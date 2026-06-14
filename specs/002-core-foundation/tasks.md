---
description: "Task list for Sprint Core Foundation"
---

# Tasks: Sprint Core Foundation

**Input**: Design documents from `specs/002-core-foundation/`

**Prerequisites**: plan.md ✅ | spec.md ✅ | data-model.md ✅ | research.md ✅ | quickstart.md ✅

**Tests**: Smoke tests included (required by SC-008 — all six foundation areas must have
at least one passing test before milestone closes).

**Organization**: Tasks follow the mandated implementation order from spec + plan:
project setup → design tokens → routing shell → Riverpod wiring → localization →
logging → smoke tests → validation.

**Story labels**: This spec has no user stories. Foundation Area labels [FA1]–[FA6]
replace [US*] labels and identify which SC-008 area each task delivers.

## Format: `[ID] [P?] [FA?] Description with file path`

- **[P]**: Can run in parallel (different files, no shared deps)
- **[FA]**: Which foundation area the task belongs to (FA1–FA6)
- All paths are project-relative from the repo root

---

## Phase 1: Setup — Flutter Project Initialization

**Purpose**: Create the runnable project scaffold and configure tooling before any
source code is written. No feature code. No backend packages.

- [ ] T001 Create Flutter project with `flutter create --org edu.tanta.sprint --project-name sprint .` (run in repo root if not already initialized) — produces pubspec.yaml, android/, ios/, web/, lib/main.dart
- [ ] T002 Replace pubspec.yaml with Sprint dependencies: `flutter_riverpod ^2.6.1`, `riverpod_annotation ^2.4.1`, `go_router ^14.3.0`, `freezed_annotation ^2.4.4`, `json_serializable ^6.8.0`, `intl ^0.19.0`; dev deps: `build_runner`, `riverpod_generator ^2.4.4`, `freezed ^2.5.7`; assets: `assets/fonts/Cairo/`, `assets/l10n/`; flutter: `generate: true` (for l10n codegen). No Supabase or backend packages.
- [ ] T003 [P] Write analysis_options.yaml at repo root: include `package:flutter_lints/flutter.yaml`; add linter rules: `prefer_const_constructors: true`, `prefer_const_declarations: true`, `avoid_print: true`, `always_use_package_imports: true`, `directives_ordering: true`
- [ ] T004 [P] Write l10n.yaml at repo root: `arb-dir: assets/l10n`, `template-arb-file: app_ar.arb`, `output-localization-file: app_localizations.dart`, `output-dir: lib/core/l10n`, `output-class: AppLocalizations`
- [ ] T005 Create directory scaffold: `lib/core/theme/`, `lib/core/router/`, `lib/core/l10n/`, `lib/core/logger/`, `lib/core/presentation/screens/`, `lib/features/`, `assets/l10n/`, `assets/fonts/Cairo/`, `test/core/theme/`, `test/smoke/`
- [ ] T006 Add Cairo font files (Regular-400, Medium-500, Bold-700 `.ttf`) to `assets/fonts/Cairo/` and declare all three weights under `fonts:` in pubspec.yaml
- [ ] T007 Run `flutter pub get` and confirm zero errors before proceeding

**Checkpoint**: Project compiles (`flutter build web --debug` exits 0). No source logic yet.

---

## Phase 2: Foundation Area 1 — Design Tokens

**Goal**: Single-source design token system satisfying FR-002 and SC-002.
All four files are independent and can be written in parallel.

**Independent Test**: `flutter test test/core/theme/app_theme_test.dart` passes — token values
are correct Dart types, `AppTheme.dark()` returns a valid `ThemeData` with lime primary.

- [ ] T008 [P] [FA1] Create `lib/core/theme/app_colors.dart`: abstract final class `AppColors` with 10 `static const Color` fields — `lime` (#CCF42B), `green` (#1B5E3B), `background` (#0A0A0A), `surface` (#1A1A1A), `surfaceVariant` (#2A2A2A), `onBackground` (#E8E8E8), `onSurface` (#CCCCCC), `onLime` (#0A0A0A), `error` (#EF5350), `onError` (#FFFFFF)
- [ ] T009 [P] [FA1] Create `lib/core/theme/app_spacing.dart`: abstract final class `AppSpacing` with 7 `static const double` fields on a 4-pt grid — `xs: 4.0`, `sm: 8.0`, `md: 16.0`, `lg: 24.0`, `xl: 32.0`, `xxl: 48.0`, `xxxl: 64.0`
- [ ] T010 [P] [FA1] Create `lib/core/theme/app_typography.dart`: class `AppTypography` with `static TextTheme get textTheme` returning a full M3 `TextTheme` — all 15 roles using `fontFamily: 'Cairo'` with weights 400/500/700 per data-model.md spec
- [ ] T011 [FA1] Create `lib/core/theme/app_theme.dart`: class `AppTheme` with `static ThemeData dark()` — builds `ThemeData` with `useMaterial3: true`, `colorScheme: ColorScheme.dark(primary: AppColors.lime, onPrimary: AppColors.onLime, secondary: AppColors.green, surface: AppColors.surface, error: AppColors.error, brightness: Brightness.dark)`, `textTheme: AppTypography.textTheme`, `scaffoldBackgroundColor: AppColors.background`, `fontFamily: 'Cairo'` (depends on T008, T009, T010)

**Checkpoint**: `dart analyze lib/core/theme/` → zero issues. All 4 files use `package:` imports.

---

## Phase 3: Foundation Area 2 — Routing Shell

**Goal**: Centralized `GoRouter` as a Riverpod provider with two named routes and
URL deep-link support, satisfying FR-003 and SC-003.

**Independent Test**: With T016/T017 app wiring in place, navigating to `/error` in the
web address bar renders `ErrorScreen` without crash. Browser back returns to `/`.

- [ ] T012 [P] [FA2] Create `lib/core/router/app_routes.dart`: abstract final class `AppRoutes` with `static const String home = '/'` and `static const String error = '/error'`
- [ ] T013 [P] [FA2] Create `lib/core/presentation/screens/home_shell_screen.dart`: `HomeShellScreen` stateless widget — `Scaffold` with `AppBar(title: Text(AppLocalizations.of(context)!.appName))` and centered `Text` body (placeholder); uses `AppColors` for background (add `// TODO: replace with feature nav shell` comment)
- [ ] T014 [P] [FA2] Create `lib/core/presentation/screens/error_screen.dart`: `ErrorScreen` stateless widget — `Scaffold` with Arabic `AppBar(title: Text(AppLocalizations.of(context)!.errorPageTitle))` and `AppLocalizations.of(context)!.errorPageMessage` as body text; a back button navigates to `AppRoutes.home`
- [ ] T015 [FA2] Create `lib/core/router/app_router.dart`: `@Riverpod(keepAlive: true)` annotation on `GoRouter appRouter(AppRouterRef ref)` function — `GoRouter(initialLocation: AppRoutes.home, errorBuilder: (_, __) => const ErrorScreen(), routes: [GoRoute(path: AppRoutes.home, name: 'home', builder: (_, __) => const HomeShellScreen()), GoRoute(path: AppRoutes.error, name: 'error', builder: (_, __) => const ErrorScreen())], redirect: (_, __) => null)` (auth guard stub)
- [ ] T016 [FA2] Run `dart run build_runner build --delete-conflicting-outputs` to generate `lib/core/router/app_router.g.dart`; commit the generated file alongside the source

**Checkpoint**: `dart analyze lib/core/router/` → zero issues. `app_router.g.dart` committed.

---

## Phase 4: Foundation Area 3 — Riverpod Initialization & App Wiring

**Goal**: `ProviderScope` at the root; `MaterialApp.router` consumes the generated
`appRouterProvider`, satisfying FR-004 and SC-003.

**Independent Test**: `flutter run -d chrome` opens the app, address bar shows `/`,
no provider-not-found or `ProviderScope` errors in the debug console.

- [ ] T017 [FA3] Create `lib/app.dart`: `class App extends ConsumerWidget` — `build` returns `MaterialApp.router(theme: AppTheme.dark(), routerConfig: ref.watch(appRouterProvider), localizationsDelegates: AppLocalizations.localizationsDelegates, supportedLocales: AppLocalizations.supportedLocales, debugShowCheckedModeBanner: false)` (depends on T011, T016)
- [ ] T018 [FA3] Replace generated `lib/main.dart` with: `void main() => runApp(const ProviderScope(child: App()))` (depends on T017)

**Checkpoint**: `flutter run -d chrome` boots to Arabic home screen with no console errors.

---

## Phase 5: Foundation Area 4 — Localization Bootstrap

**Goal**: All visible strings externalized in ARB, app renders Arabic RTL with zero
English fallback, satisfying FR-005, SC-004, and SC-005.

**Independent Test**: App renders "سبرنت" in the app bar on all three platforms;
navigating to `/error` shows Arabic error text; `dart analyze` still zero issues.

- [ ] T019 [P] [FA4] Create `assets/l10n/app_ar.arb` with initial strings: `@@locale: ar`, `appName: "سبرنت"`, `errorPageTitle: "خطأ"`, `errorPageMessage: "الصفحة غير موجودة"` — each key must have a corresponding `@key` metadata object with `description` field
- [ ] T020 [FA4] Run `flutter gen-l10n` to generate `lib/core/l10n/app_localizations.dart` and `lib/core/l10n/app_localizations_ar.dart`; commit all generated files (depends on T019, T004)
- [ ] T021 [FA4] Verify `lib/app.dart` correctly passes `AppLocalizations.localizationsDelegates` and `AppLocalizations.supportedLocales` to `MaterialApp.router`; manually smoke-test that the app bar shows "سبرنت" on Chrome and text is right-aligned (RTL) (depends on T020, T017)

**Checkpoint**: `flutter run -d chrome` → app bar shows "سبرنت", text is RTL, no English visible.

---

## Phase 6: Foundation Area 5 — Logging Abstraction

**Goal**: Shared `AppLogger` in `lib/core/logger/` giving all feature branches a
consistent, zero-dependency logging interface, satisfying FR-009.

**Independent Test**: Replace a `debugPrint` call anywhere with `AppLogger.info(...)`;
confirm the message appears in the debug console. `dart analyze` still zero issues.

- [ ] T022 [FA5] Create `lib/core/logger/app_logger.dart`: abstract final class `AppLogger` with four `static` methods — `debug(String msg, {Object? error, StackTrace? stackTrace})`, `info(String msg, {Object? error, StackTrace? stackTrace})`, `warning(String msg, {Object? error, StackTrace? stackTrace})`, `error(String msg, {Object? error, StackTrace? stackTrace})` — each calling `dart:developer`'s `log(msg, name: 'Sprint', level: <level>, error: error, stackTrace: stackTrace)` with appropriate level constants; no `print` or `debugPrint` calls anywhere

**Checkpoint**: `dart analyze lib/core/logger/` → zero issues. `AppLogger.info('foundation ready')` call in main.dart dev build prints to console; remove the test call before Phase 8.

---

## Phase 7: Smoke Tests

**Goal**: Automated tests that prove all six foundation areas work together,
satisfying SC-008. Tests written after implementation (not TDD) since foundation
has no domain use-case logic to test-first.

- [ ] T023 [P] Create `test/core/theme/app_theme_test.dart`: group `'AppTheme'` — test `'dark() returns valid ThemeData with M3 and Cairo'` (asserts `useMaterial3`, `colorScheme.primary == AppColors.lime`, `colorScheme.secondary == AppColors.green`, `textTheme.bodyLarge?.fontFamily == 'Cairo'`); group `'AppColors'` — test `'lime token is correct value'` (`== const Color(0xFFCCF42B)`), `'green token is correct value'` (`== const Color(0xFF1B5E3B)`)
- [ ] T024 [P] Create `test/smoke/app_launch_test.dart`: `testWidgets('app boots in Arabic RTL without crash', ...)` — `pumpWidget(ProviderScope(child: App()))`, `await tester.pumpAndSettle()`, assert `find.byType(Directionality)` with `textDirection == TextDirection.rtl`, assert `find.byType(Localizations)` with locale `Locale('ar')`, assert no `ErrorWidget` in tree
- [ ] T025 Run `flutter test --reporter=expanded` and confirm all tests pass; fix any failures before proceeding

**Checkpoint**: `flutter test` → all green. No `ErrorWidget` or overflow warnings.

---

## Phase 8: Polish & Final Validation

**Purpose**: Verify all SC-001 through SC-008 pass and the milestone is shippable.

- [ ] T026 Run `dart analyze` and fix any remaining warnings to achieve zero-issue output (SC-006)
- [ ] T027 Run `dart format --set-exit-if-changed .` and fix any formatting issues; re-run until exit code 0
- [ ] T028 [P] Create `lib/features/.gitkeep` to preserve the empty features directory in git; confirm `grep -r "import.*features/" lib/core/` returns no output (SC-001)
- [ ] T029 Manually run all validation checks from `specs/002-core-foundation/quickstart.md` in order (SC-001 through SC-008): structure check, theme test, web launch + RTL check, deep-link to `/error`, iOS simulator launch, Android emulator launch, ARB round-trip test, setup timing
- [ ] T030 Update `specs/002-core-foundation/quickstart.md` Definition of Done checklist — check off all passing items

---

## Dependencies & Execution Order

### Phase Dependencies

- **Phase 1 (Setup)**: No dependencies — start immediately
- **Phase 2 (Design Tokens)**: Depends on Phase 1 (T007 `flutter pub get`)
- **Phase 3 (Routing)**: Depends on Phase 2 complete (needs `AppColors` for screens)
- **Phase 4 (Riverpod Wiring)**: Depends on Phase 3 (needs generated `appRouterProvider`)
- **Phase 5 (Localization)**: Depends on Phase 4 (screens must exist to wire L10n)
- **Phase 6 (Logging)**: Depends only on Phase 1 — can overlap with Phases 2–5
- **Phase 7 (Smoke Tests)**: Depends on Phases 2–6 complete
- **Phase 8 (Validation)**: Depends on Phase 7

### Within Each Phase — Parallel Opportunities

**Phase 2** (T008, T009, T010 run in parallel → T011 depends on all three):
```
T008 app_colors.dart   ─┐
T009 app_spacing.dart  ─┤→ T011 app_theme.dart
T010 app_typography.dart─┘
```

**Phase 3** (T012, T013, T014 run in parallel → T015 depends on all three → T016 depends on T015):
```
T012 app_routes.dart       ─┐
T013 home_shell_screen.dart ─┤→ T015 app_router.dart → T016 build_runner
T014 error_screen.dart     ─┘
```

**Phase 5** (T019 → T020 → T021 sequential):
```
T019 app_ar.arb → T020 flutter gen-l10n → T021 verify in app
```

**Phase 7** (T023, T024 run in parallel → T025 depends on both):
```
T023 app_theme_test.dart    ─┐
T024 app_launch_test.dart   ─┘→ T025 flutter test
```

**Phase 6** (T022) can overlap with Phases 3–5 — independent files.

---

## Implementation Strategy

### Sequential Solo Strategy (single developer)

1. Complete Phase 1 → project compiles
2. Complete Phase 2 → design tokens locked in
3. Complete Phase 3 → router + screens scaffold
4. Complete Phase 4 → app boots on Chrome
5. Complete Phase 5 → Arabic RTL confirmed
6. Complete Phase 6 → logger available for all features
7. Complete Phase 7 → tests green
8. Complete Phase 8 → milestone closed; open feature branches may start

### Minimum Viable Foundation (if time-boxed)

If you need a working app on ONE platform first:
1. Phases 1–6 (all implementation)
2. T023 only (theme test — proves token system)
3. T025 (run tests)
4. T026–T027 (analyze + format)
5. Web-only validation (skip iOS/Android simulator checks)

Then complete iOS/Android validation in Phase 8 when simulators are available.

---

## Notes

- **No Supabase**: `pubspec.yaml` must NOT include `supabase_flutter` or any backend SDK.
  The first data-layer feature branch adds it. This is a hard spec constraint (clarification
  session 2026-06-14).
- **Generated files are committed**: `.g.dart` (Riverpod) and `app_localizations*.dart`
  files are committed to the repo. Do not add them to `.gitignore`.
- **No `print` / `debugPrint`**: Use `AppLogger.*` only. The `avoid_print` lint rule will
  catch violations automatically.
- **[P] tasks**: All tasks marked [P] within a phase touch different files and have no
  shared intermediate state — safe to parallelize.
- **Stop at each checkpoint**: Verify `dart analyze` passes before advancing to the next
  phase. Catching lint issues early prevents compound errors.
