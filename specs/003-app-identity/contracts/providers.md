# Provider Contracts: App Identity

**Branch**: `003-app-identity`

These are the public API contracts for the two Riverpod providers introduced in this feature. Every consumer in the app (including future settings screens) MUST use these contracts to read and update theme/locale state.

---

## ThemeModeNotifier

```
Provider:   themeProvider
Type:       NotifierProvider<ThemeModeNotifier, ThemeMode>
Module:     lib/core/providers/theme_provider.dart
Default:    ThemeMode.dark
```

### Read

```dart
// In any ConsumerWidget / ConsumerStatefulWidget:
final ThemeMode mode = ref.watch(themeProvider);
```

### Write

```dart
ref.read(themeProvider.notifier).setTheme(ThemeMode.light);
ref.read(themeProvider.notifier).setTheme(ThemeMode.dark);
```

### Invariants

- `.system` MUST NOT be passed to `setTheme()` — the provider ignores OS theme entirely.
- Passing the already-active mode is a no-op (no rebuild triggered).
- State is NOT persisted in this version; defaults to `ThemeMode.dark` on every cold launch.

### MaterialApp wiring

```dart
// In app.dart (App widget):
final ThemeMode themeMode = ref.watch(themeProvider);

MaterialApp.router(
  theme: AppTheme.light(),
  darkTheme: AppTheme.dark(),
  themeMode: themeMode,
  ...
)
```

---

## LocaleNotifier

```
Provider:   localeProvider
Type:       NotifierProvider<LocaleNotifier, Locale>
Module:     lib/core/providers/locale_provider.dart
Default:    Locale('ar')
```

### Read

```dart
final Locale locale = ref.watch(localeProvider);
```

### Write

```dart
ref.read(localeProvider.notifier).setLocale(const Locale('en'));
ref.read(localeProvider.notifier).setLocale(const Locale('ar'));
```

### Invariants

- Only `Locale('ar')` and `Locale('en')` are valid inputs. Unsupported locales are silently dropped (assert in debug).
- State is NOT persisted in this version; defaults to `Locale('ar')` on every cold launch.
- Text direction (`TextDirection.rtl` for Arabic, `TextDirection.ltr` for English) is derived automatically by Flutter from the locale — the provider does not expose a direction field.

### MaterialApp wiring

```dart
// In app.dart (App widget):
final Locale locale = ref.watch(localeProvider);

MaterialApp.router(
  locale: locale,
  supportedLocales: AppLocalizations.supportedLocales, // [Locale('ar'), Locale('en')]
  localizationsDelegates: AppLocalizations.localizationsDelegates,
  ...
)
```

---

## Navigation Contract

```
Route path:   /splash         (initial route — always the entry point)
Route path:   /login          (login placeholder, navigated to after splash)
Route path:   /               (home shell — existing, unchanged)
```

The splash screen fires `context.go(AppRoutes.login)` after the 1 800 ms animation completes. This is a hard-coded navigation with no conditions — auth logic is out of scope for this feature.

Future auth feature: replace the splash's unconditional redirect with a `GoRouter` redirect function that checks auth state and sends authenticated users to `/` and unauthenticated users to `/login`.
