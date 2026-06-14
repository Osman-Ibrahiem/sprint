# Tasks: App Identity

**Input**: Design documents from `specs/003-app-identity/`

**Prerequisites**: plan.md ✅ · spec.md ✅ · research.md ✅ · data-model.md ✅ · contracts/providers.md ✅

**Tests**: Provider unit tests are included (constitution requirement — all Riverpod notifiers must have tests).

**Organization**: Tasks are grouped by user story to enable independent implementation and testing.

## Format: `[ID] [P?] [Story] Description`

- **[P]**: Can run in parallel (different files, no dependencies)
- **[Story]**: User story label ([US1], [US2], [US3])
- Paths shown are relative to repo root `/Users/osman/Projects/sprint/`

---

## Phase 1: Setup

**Purpose**: Add the one new runtime dependency and prepare icon assets. No feature code yet.

- [ ] T001 Add `shared_preferences: ^2.3.2` to `pubspec.yaml` under `dependencies:` and add `assets/images/icons/` to `flutter.assets:`, then run `flutter pub get`
- [ ] T002 [P] Create `assets/images/icons/` directory and copy `sprint-mark-lime.png` from `/tmp/design-extract/sprint-booker-mobile/project/assets/sprint-mark-lime.png` to `assets/images/icons/sprint-mark-dark.png` (the dark variant — Sprint Green square + Lime bolt)
- [ ] T003 [P] Create a placeholder `assets/images/icons/sprint-mark-light.png` by copying the same source file for now (a proper light-variant SVG export is a future task); document in an inline comment that this is the same asset and the correct light variant is deferred

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Core infrastructure that ALL user stories depend on — providers, theme, localisation, routing, app wiring. Nothing in Phase 3+ can start until this phase is complete.

**⚠️ CRITICAL**: No user story work can begin until this phase is complete.

### Shared-preferences provider (testable foundation for persistence)

- [ ] T004 Create `lib/core/providers/shared_preferences_provider.dart` — a `@riverpod` provider that throws `UnimplementedError` (overridden at startup in main): `@riverpod SharedPreferences sharedPreferences(Ref ref) => throw UnimplementedError();`

### Theme provider

- [ ] T005 Create `lib/core/providers/theme_provider.dart` — `@riverpod class ThemeModeNotifier extends _$ThemeModeNotifier`. In `build()`: read `ref.read(sharedPreferencesProvider)`, look up key `'sprint_theme_mode'`, return `ThemeMode.values.byName(saved)` or `ThemeMode.dark`. In `setTheme(ThemeMode mode)`: guard `if (mode == ThemeMode.system) return;`, set `state = mode`, write `prefs.setString('sprint_theme_mode', mode.name)`

### Locale provider

- [ ] T006 Create `lib/core/providers/locale_provider.dart` — `@riverpod class LocaleNotifier extends _$LocaleNotifier`. In `build()`: read prefs, look up key `'sprint_locale'`, return `Locale(saved ?? 'ar')`. In `setLocale(Locale locale)`: guard `if (!['ar','en'].contains(locale.languageCode)) { assert(false, ...); return; }`, set `state = locale`, write `prefs.setString('sprint_locale', locale.languageCode)`

### Light theme

- [ ] T007 [P] Add `AppTheme.light()` static method to `lib/core/theme/app_theme.dart` — mirror of `dark()` but with light-mode colour scheme: `surface: AppColors.white`, `onSurface: AppColors.ink900`, `outline: AppColors.green100`, `outlineVariant: Color(0xFFE8F3EC)`, `scaffoldBackgroundColor: AppColors.green50`, `secondaryContainer: AppColors.green100`, `onSurfaceVariant: AppColors.ink500`, `inverseSurface: AppColors.ink900`, `onInverseSurface: AppColors.green50`, `shadow: AppColors.ink900`. All other fields mirror `dark()`.

### ARB localisation strings

- [ ] T008 [P] Update `assets/l10n/app_ar.arb` — add four new keys after `backToHome`: `"splashSubtitle": "احجز ملعبك، من غير زحمة ⚡"`, `"splashContinueHint": "اضغط للمتابعة"`, `"loginTitle": "أهلاً بيك في سبرنت"`, `"loginSubtitle": "ابدأ حجزك دلوقتي"` — each with a `@` descriptor block
- [ ] T009 [P] Create `assets/l10n/app_en.arb` with `"@@locale": "en"` and English translations for all eight keys: `appName: "Sprint"`, `errorPageTitle: "Error"`, `errorPageMessage: "Page not found"`, `backToHome: "Back to Home"`, `splashSubtitle: "Book your court, hassle-free ⚡"`, `splashContinueHint: "Loading…"`, `loginTitle: "Welcome to Sprint"`, `loginSubtitle: "Start booking now"`
- [ ] T010 Run `flutter gen-l10n` from repo root and verify `lib/core/l10n/app_localizations_en.dart` is generated with class `AppLocalizationsEn` containing all eight getters, and that `AppLocalizations.supportedLocales` now includes `Locale('en')`

### Router updates

- [ ] T011 [P] Add `static const String splash = '/splash';` and `static const String login = '/login';` to `lib/core/router/app_routes.dart`
- [ ] T012 Update `lib/core/router/app_router.dart` — change `initialLocation` to `AppRoutes.splash`; add two stub `GoRoute` entries for `/splash` and `/login` with `builder: (context, state) => const Placeholder()` so the router compiles before screens exist; then run `dart run build_runner build --delete-conflicting-outputs` to regenerate `lib/core/router/app_router.g.dart`

### App wiring

- [ ] T013 Update `lib/main.dart` — add `WidgetsFlutterBinding.ensureInitialized()` at the top of `main()`, await `SharedPreferences.getInstance()`, then pass it as a `ProviderScope` override: `sharedPreferencesProvider.overrideWithValue(prefs)` so both notifiers can read it synchronously in `build()`
- [ ] T014 Update `lib/app.dart` — change `App` to `ConsumerWidget`; in `build()` call `ref.watch(themeProvider)` and `ref.watch(localeProvider)`; pass `theme: AppTheme.light()`, `darkTheme: AppTheme.dark()`, `themeMode: themeMode`, `locale: locale` to `MaterialApp.router`; update `supportedLocales` to `AppLocalizations.supportedLocales` (now includes both `ar` and `en`)

### Provider unit tests

- [ ] T015 Create `test/core/providers/theme_provider_test.dart` — use `ProviderContainer` with a `FakeSharedPreferences` stub. Test four cases: (1) `build()` with no saved key → `ThemeMode.dark`; (2) `build()` with saved `'light'` → `ThemeMode.light`; (3) `setTheme(ThemeMode.light)` → state becomes `ThemeMode.light` and prefs key written; (4) `setTheme(ThemeMode.system)` → state unchanged, no prefs write
- [ ] T016 [P] Create `test/core/providers/locale_provider_test.dart` — same pattern. Four cases: (1) no saved key → `Locale('ar')`; (2) saved `'en'` → `Locale('en')`; (3) `setLocale(Locale('en'))` → state `Locale('en')`, key written; (4) `setLocale(Locale('fr'))` → state unchanged
- [ ] T017 Run `flutter test test/core/providers/` and confirm all 8 provider unit tests pass with zero errors

**Checkpoint**: Foundation is complete — both providers persist correctly, light theme compiles, English l10n generates, router builds. User story implementation can now proceed.

---

## Phase 3: User Story 1 — First Launch (Priority: P1) 🎯 MVP

**Goal**: A fresh install opens with a pixel-faithful Sprint splash screen (dark, Arabic, no white flash) and automatically navigates to the login placeholder after 1 800 ms.

**Independent Test**: Install clean, launch, observe: native splash (#0D1B13 bg, no white flash) → Flutter splash (logo, loading bar 1.8 s) → login placeholder (Arabic, dark). Total ≤ 3 s.

### Implementation for User Story 1

- [ ] T018 [US1] Create `lib/features/splash/presentation/screens/splash_screen.dart` — `ConsumerStatefulWidget`. In `initState()`: create `AnimationController(duration: 600ms)` for entry fade-up and start it; use `Future.delayed(const Duration(milliseconds: 1800))` to call `if (mounted) context.go(AppRoutes.login)`. In `build()`: full-screen `Scaffold(backgroundColor: AppColors.green900)` with `Stack`; bottom layer is a `DecoratedBox(decoration: BoxDecoration(gradient: RadialGradient(...AppColors.green700 at 0%, AppColors.green900 at 62%...)))`; centred `Column` with: (a) 118×118 `Container(decoration: BoxDecoration(color: AppColors.sprintGreen, borderRadius: BorderRadius.circular(38), boxShadow: [BoxShadow(color: Color(0x990F4C2F), blurRadius: 50, offset: Offset(0,18))]))` containing `Icon(Icons.bolt_rounded, size: 70, color: AppColors.lime)`; (b) `Text(l10n.appName, style: AppTypography.display.copyWith(fontSize: 44, color: AppColors.textPrimary))`; (c) `Text(l10n.splashSubtitle, style: AppTypography.body.copyWith(fontWeight: AppTypography.semiBold, color: AppColors.green300))`; bottom `PositionedDirectional` with loading bar (148×4 `ClipRRect(borderRadius: pill)` with `LinearProgressIndicator` or animated `FractionallySizedBox` fill from 8%→96%) and hint text `l10n.splashContinueHint` in `AppTypography.xs`
- [ ] T019 [US1] Create `lib/features/auth/presentation/screens/login_placeholder_screen.dart` — `ConsumerWidget`. Shows `Scaffold(backgroundColor: Theme.of(context).scaffoldBackgroundColor)` with centred `Column`: Sprint logo (48×48 green square + bolt icon), `Text(l10n.appName)` in `AppTypography.h1`, `Text(l10n.loginTitle)` in `AppTypography.body`, `Text(l10n.loginSubtitle)` in `AppTypography.sm.copyWith(color: AppColors.textSecondary)`. Include developer-validation `Row` at bottom with two `TextButton`s: one calls `ref.read(themeProvider.notifier).setTheme(...)` toggling dark↔light, one calls `ref.read(localeProvider.notifier).setLocale(...)` toggling ar↔en
- [ ] T020 [US1] Update `lib/core/router/app_router.dart` — replace the two `Placeholder()` stub builders from T012 with real imports: `builder: (context, state) => const SplashScreen()` and `builder: (context, state) => const LoginPlaceholderScreen()`; re-run `dart run build_runner build --delete-conflicting-outputs`
- [ ] T021 [US1] Update `android/app/src/main/res/drawable/launch_background.xml` — replace contents with a `<layer-list>` containing a single `<item>` with `android:drawable` set to solid colour `#0D1B13` (AppColors.green900)
- [ ] T022 [US1] [P] Update `android/app/src/main/res/drawable-v21/launch_background.xml` — identical to T021; the `-v21` variant enables vector drawables on API 21+ but uses the same solid colour
- [ ] T023 [US1] [P] Update `android/app/src/main/res/values/styles.xml` — ensure `LaunchTheme` has `<item name="android:windowBackground">@drawable/launch_background</item>`
- [ ] T024 [US1] Update `android/app/src/main/res/values-night/styles.xml` — same `LaunchTheme` override so night mode also uses `#0D1B13` (the dark splash background is the same in both Android light and dark because Sprint's default is always dark)
- [ ] T025 [US1] Update `ios/Runner/Base.lproj/LaunchScreen.storyboard` — set the root `UIView`'s `backgroundColor` to custom colour RGB `(13, 27, 19)` (#0D1B13) so the iOS native splash matches the Flutter splash background

**Checkpoint**: US1 fully functional — cold launch works end-to-end on Android and iOS with no white flash and ≤ 3 s total time.

---

## Phase 4: User Story 2 — Theme Toggle (Priority: P2)

**Goal**: The in-app theme (dark ↔ light) switches within one frame via the Riverpod `themeProvider`, persists across restarts, and the full app re-renders without restart.

**Independent Test**: On the login placeholder, tap the theme toggle button. Verify the background transitions from `AppColors.green900` to `AppColors.green50`, text transitions from `AppColors.textPrimary` to `AppColors.ink900`, all within one frame. Kill and reopen the app — the selected theme is restored.

### Implementation for User Story 2

- [ ] T026 [US2] Complete `AppTheme.light()` in `lib/core/theme/app_theme.dart` — verify the following fields are set for light mode: `cardTheme.color: AppColors.white`, `cardTheme.shape.side: BorderSide(color: AppColors.green100)`, `elevatedButtonTheme` unchanged (green fill/lime text still correct in light), `inputDecorationTheme.fillColor: AppColors.white`, `bottomNavigationBarTheme.backgroundColor: AppColors.white`, `chipTheme.backgroundColor: AppColors.green50`, `dividerTheme.color: AppColors.green100`, `bottomSheetTheme.backgroundColor: AppColors.white`. Add any fields that differ from dark that were missed in T007.
- [ ] T027 [US2] Validate persistence: after toggling to light mode via the FAB on the login placeholder, force-quit and reopen the app; confirm the app opens directly in light mode (provider reads from SharedPreferences on `build()`). Confirm the same for locale (US3 is next, but persistence for both is validated here together)

**Checkpoint**: Theme switching and persistence both verified. US2 complete.

---

## Phase 5: User Story 3 — Language Toggle (Priority: P3)

**Goal**: The locale (Arabic/English) switches within one frame via the Riverpod `localeProvider`, directionality flips (RTL ↔ LTR), and the selection persists across restarts.

**Independent Test**: On the login placeholder, tap the locale toggle button. Verify all text switches language and layout direction within one frame — Arabic shows RTL, English shows LTR. Kill and reopen — locale is restored.

### Implementation for User Story 3

- [ ] T028 [US3] Verify `l10n.yaml` `output-localization-file` generates correctly for English: open `lib/core/l10n/app_localizations.dart` and confirm `isSupported` returns `true` for `'en'` and that `supportedLocales` includes `Locale('en')`. If `flutter gen-l10n` didn't auto-update these (older tooling), manually add `'en'` to the `isSupported` switch and the `supportedLocales` list — but prefer re-running `flutter gen-l10n` first.
- [ ] T029 [US3] Verify `AppLocalizations.of(context)!.splashSubtitle` returns the correct Arabic string on `SplashScreen` when locale is `Locale('ar')`, and the English string when locale is `Locale('en')` — check by toggling locale on the login placeholder and navigating back to splash (or via a widget test targeting the `SplashScreen` `Text` widget)

**Checkpoint**: Locale switching, directionality, and ARB string coverage all verified. US3 complete.

---

## Phase 6: Polish & Cross-Cutting Concerns

**Purpose**: Ensure zero warnings, all tests pass, and quickstart scenarios are validated before merge.

- [ ] T030 [P] Run `dart analyze lib/ test/` and fix any warnings or errors introduced by this feature (common issues: unused imports, missing `const`, incorrect `override` annotations on generated code)
- [ ] T031 [P] Run `flutter test` (all tests) and confirm all provider unit tests plus any existing tests still pass
- [ ] T032 Run the full quickstart validation from `specs/003-app-identity/quickstart.md` — SC-1 (cold launch ≤ 3 s), SC-4 (zero hardcoded strings grep), SC-5 (splash pixel parity), SC-6 (analyzer clean)
- [ ] T033 Remove the developer-validation `Row` with debug toggle buttons from `lib/features/auth/presentation/screens/login_placeholder_screen.dart` OR wrap them in `kDebugMode` guard (`if (kDebugMode) ...`) so they are excluded from release builds

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies — start immediately; T002 and T003 can run in parallel
- **Foundational (Phase 2)**: Depends on Phase 1 completion — **BLOCKS all user stories**
  - T004 → T005, T006 (T004 must exist before providers are written)
  - T007, T008, T009 can proceed in parallel (different files)
  - T011 can run in parallel with T007–T009
  - T012 depends on T011
  - T013 depends on T004 (needs sharedPreferencesProvider)
  - T014 depends on T005, T006, T010 (app.dart needs theme, locale, l10n)
  - T015, T016 can run in parallel (different test files)
  - T017 depends on T015 and T016
- **US1 (Phase 3)**: Depends on Phase 2 completion
  - T018 and T019 can run in parallel (different files)
  - T020 depends on T018 and T019 (replaces stubs with real screens)
  - T021–T025 can run in parallel with T018–T020 (platform files)
- **US2 (Phase 4)**: Depends on T026 (AppTheme.light() complete from T007) and T019 (login placeholder has toggle)
- **US3 (Phase 5)**: Depends on T028 (l10n fully generated from T010) and T019
- **Polish (Phase 6)**: Depends on all phases complete

### User Story Dependencies

- **US1 (P1)**: Can start after Phase 2 — no dependencies on US2 or US3
- **US2 (P2)**: Can start after Phase 2 — requires login placeholder (US1 T019) as validation surface
- **US3 (P3)**: Can start after Phase 2 — requires login placeholder (US1 T019) as validation surface; US2 and US3 are independent of each other

### Within Each Phase

- Domain → Data → Presentation (constitution rule)
- Here: no domain entities; providers are the "data" layer; screens are presentation
- Provider tests (T015–T017) MUST pass before screens are built (T018–T019)

---

## Parallel Opportunities

### Phase 2 parallelisable groups

```
Group A (run together):   T007, T008, T011  — different files, no dependencies
Group B (after Group A):  T009, T012        — T009 needs T007+T008; T012 needs T011
Group C (parallel):       T015, T016        — different test files
```

### Phase 3 parallelisable groups

```
Group D (run together):   T018, T019, T021, T022, T023  — different files
Group E (after Group D):  T020, T024, T025               — need T018+T019; platform files
```

---

## Implementation Strategy

### MVP First (User Story 1 Only)

1. Complete Phase 1: Setup (T001–T003)
2. Complete Phase 2: Foundational (T004–T017) — **cannot skip**
3. Complete Phase 3: User Story 1 (T018–T025)
4. **STOP and VALIDATE**: cold-launch on device, verify splash → login, no white flash ≤ 3 s
5. Run quickstart SC-1 and SC-6

### Incremental Delivery

1. Phase 1 + Phase 2 → providers ready, l10n wired, routing configured
2. Phase 3 → US1 complete, cold-launch experience validated → **MVP** ✅
3. Phase 4 → theme toggle proven, persistence verified
4. Phase 5 → locale toggle proven, English strings verified
5. Phase 6 → zero warnings, clean merge

---

## Notes

- `[P]` tasks operate on different files with no shared dependencies — safe to run in parallel
- `[Story]` label maps each task to a specific user story for traceability
- `shared_preferences` uses `sharedPreferencesProvider.overrideWithValue()` in `main()` so providers can read synchronously in `build()` — no `AsyncNotifier` needed
- The debug toggle buttons (T019) MUST be guarded with `kDebugMode` or removed (T033) before shipping
- `flutter gen-l10n` must be re-run whenever any `.arb` file changes
- `dart run build_runner build` must be re-run whenever `app_router.dart` changes
- The two platform splash files (Android XML, iOS Storyboard) are the only native-code files touched in this feature
