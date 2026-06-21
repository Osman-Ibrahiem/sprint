# Quickstart: App Identity

**Branch**: `003-app-identity`

This guide shows how to run the app and validate every acceptance criterion from the spec after implementation.

---

## Prerequisites

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs   # regenerates Riverpod + GoRouter
flutter gen-l10n                                            # regenerates AppLocalizations from ARB files
```

---

## Run

```bash
# iOS Simulator
flutter run -d "iPhone 16"

# Android Emulator
flutter run -d emulator-5554

# Chrome (web)
flutter run -d chrome
```

---

## Validation Scenarios

### SC-1 · Cold launch (FR-005, FR-006, FR-007)

1. **Install fresh** on a device/simulator in dark mode.
2. Observe the **native splash**: solid `#0D1B13` background, no white flash.
3. Flutter app loads: the `SplashScreen` fills the screen with the **same dark green** — verify no colour jump.
4. The Sprint logo (green rounded square + lime bolt) fades up, "سبرنت" appears in 44px black, subtitle below.
5. The lime loading bar animates from left edge to ~96 % over 1.8 s.
6. At 1.8 s the app navigates automatically to the **login placeholder** — no user tap required.
7. ✅ Total time from app open to login placeholder ≤ 3 seconds.

---

### SC-2 · Arabic default (FR-002, FR-003)

1. Launch the app (fresh install).
2. On the login placeholder confirm:
   - Text reads `أهلاً بيك في سبرنت` (heading) in Arabic.
   - Layout direction is **RTL** (text flows right-to-left).
3. ✅ Default locale is `Locale('ar')`, no configuration needed.

---

### SC-3 · Theme toggle (FR-004) — developer validation

Since the settings screen is out of scope, toggle the theme via a Riverpod `ProviderScope` override in a test or via Flutter DevTools:

```dart
// In a test widget or integration test:
await tester.pumpWidget(
  ProviderScope(
    overrides: [
      themeProvider.overrideWith(() => ThemeModeNotifier()..setTheme(ThemeMode.light)),
    ],
    child: const App(),
  ),
);
```

Or: add a temporary `FloatingActionButton` on `LoginPlaceholderScreen` that calls:
```dart
ref.read(themeProvider.notifier).setTheme(ThemeMode.light);
```

Verify the entire screen re-renders in light colours (`#F8FFF9` background, `#1A1A1A` text) **within one frame** (no blank intermediate state).

---

### SC-4 · Locale toggle (FR-003) — developer validation

Same pattern as SC-3. Toggle via provider override or temporary button:

```dart
ref.read(localeProvider.notifier).setLocale(const Locale('en'));
```

Verify:
- Text switches to English (`Welcome to Sprint`)
- Layout direction flips to **LTR**
- No restart required.

---

### SC-5 · Zero hardcoded strings (FR-009)

```bash
# Should return 0 results:
grep -r "سبرنت\|Sprint\|Welcome\|أهلاً\|Book your" lib/ --include="*.dart"
```

All user-visible strings must come from `AppLocalizations.of(context)!.<key>`.

---

### SC-6 · Zero analysis warnings (SC-006)

```bash
dart analyze lib/ test/
# Expected: No issues found!
```

---

## Unit Tests

```bash
flutter test test/core/providers/theme_provider_test.dart
flutter test test/core/providers/locale_provider_test.dart
```

**ThemeModeNotifier tests**:
- Initial state is `ThemeMode.dark`
- `setTheme(ThemeMode.light)` → state becomes `ThemeMode.light`
- `setTheme(ThemeMode.dark)` → state becomes `ThemeMode.dark`
- `setTheme(ThemeMode.system)` → state remains unchanged (no-op)

**LocaleNotifier tests**:
- Initial state is `Locale('ar')`
- `setLocale(Locale('en'))` → state becomes `Locale('en')`
- `setLocale(Locale('ar'))` → state becomes `Locale('ar')`
- `setLocale(Locale('fr'))` → state remains unchanged (no-op / assert)
