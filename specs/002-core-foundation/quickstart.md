# Quickstart & Validation Guide: Sprint Core Foundation

**Phase 1 Output** | **Date**: 2026-06-14 | **Plan**: [plan.md](./plan.md)

This guide describes how to set up the project locally and validate that the core
foundation is complete. Run these checks in order; all must pass before the foundation
milestone is closed.

---

## Prerequisites

- Flutter SDK stable channel, version ≥ 3.22 (`flutter --version`)
- Dart SDK ≥ 3.2 (bundled with Flutter)
- Chrome (for web validation)
- Xcode 15+ (for iOS simulator validation, macOS only)
- Android Studio / emulator (for Android validation)
- Git

---

## Setup (New Developer, Cold Start)

```bash
# 1. Clone the repository
git clone <repo-url>
cd sprint

# 2. Install Flutter dependencies
flutter pub get

# 3. Run code generation (Riverpod + freezed + json_serializable)
dart run build_runner build --delete-conflicting-outputs

# 4. Generate localization files
flutter gen-l10n

# 5. Verify static analysis passes
dart analyze

# Expected output: "No issues found!"
```

If `dart analyze` reports issues, stop here and fix before proceeding.

---

## Validation Checks

### SC-006 · Zero static analysis errors

```bash
dart analyze
# Expected: "No issues found!"

dart format --set-exit-if-changed .
# Expected: exit code 0 (no formatting changes needed)
```

### SC-001 · Feature module independence

Verify the folder structure exists and no `features/` code is imported by `core/`:

```bash
# Confirm structure
ls lib/core/theme/
# Expected: app_colors.dart  app_spacing.dart  app_theme.dart  app_typography.dart

ls lib/core/router/
# Expected: app_router.dart  app_routes.dart

ls lib/features/
# Expected: .gitkeep  (empty — no features yet)

# Confirm no cross-imports (core must not import features/)
grep -r "import.*features/" lib/core/
# Expected: no output
```

### SC-002 · Design token single-source propagation

Run the theme smoke test:

```bash
flutter test test/core/theme/app_theme_test.dart --reporter=expanded
# Expected: all tests pass
# Key assertions: AppColors.lime == Color(0xFFCCF42B), theme uses Cairo, M3 enabled
```

### SC-003 & SC-004 · RTL Arabic app launches on web

```bash
flutter run -d chrome
```

In the browser:
1. Address bar shows `http://localhost:<port>/`
2. Page text is right-aligned (RTL)
3. App bar displays "سبرنت" in Cairo font
4. No English fallback text visible anywhere

### SC-003 · URL deep link works

With the app running in Chrome:
1. Navigate to `http://localhost:<port>/error` manually in the address bar
2. App renders the Arabic error screen without crashing
3. Browser back button returns to `/`

### SC-004 · RTL Arabic launches on iOS simulator

```bash
flutter run -d "iPhone 15"
```

Verify:
1. App renders in Arabic RTL
2. No overflow warnings in debug console
3. Cairo font renders correctly

### SC-004 · RTL Arabic launches on Android emulator

```bash
flutter run -d emulator-5554
```

Same checks as iOS above.

### SC-005 · Adding a new string requires only ARB + widget change

1. Open `assets/l10n/app_ar.arb`
2. Add: `"testString": "نص تجريبي", "@testString": { "description": "Test" }`
3. Run `flutter gen-l10n`
4. Reference `AppLocalizations.of(context)!.testString` in any widget
5. Hot-reload → string appears in Arabic
6. Revert the test string after validation

### SC-007 · Developer setup time

Time the full setup from step 1 to first successful `flutter run -d chrome`.
Target: under 10 minutes on a machine with a reasonable internet connection.

### SC-008 · Smoke test suite passes

```bash
flutter test --reporter=expanded
# Expected: all tests in test/ pass
# Covers: theme tokens (app_theme_test.dart) + app launch (app_launch_test.dart)
```

---

## Definition of Done

The foundation milestone is **complete** when all of the following are true:

- [ ] `dart analyze` → zero errors, zero warnings
- [ ] `dart format --set-exit-if-changed .` → exit code 0
- [ ] `flutter test` → all smoke tests pass
- [ ] App launches in Arabic RTL on web (Chrome), iOS simulator, and Android emulator
- [ ] URL navigation to `/` and `/error` works on web
- [ ] `lib/features/` is empty (no feature code committed to this branch)
- [ ] `lib/core/theme/` contains only token-sourced values (no `Color(0x...)` literals outside `app_colors.dart`)
- [ ] All ARB strings have `@` metadata entries
- [ ] No hardcoded Arabic strings exist outside `app_ar.arb`