# Research: Login Screen UI

**Feature**: 004-login-screen-ui
**Date**: 2026-06-21
**Status**: Complete — all unknowns resolved

---

## 1. Branding Header Approach

**Decision**: Use an inline `Container` (48×48, `AppColors.sprintGreen` background,
`AppRadius.sm` = 8 radius) with `Icons.bolt_rounded` (size 28, `AppColors.lime`) as
the brand icon, followed by `Text(l10n.appName)` and a welcome subtitle. Do NOT use
`SplashIcon` (which renders `assets/splash/splash_image.png` — a full splash raster
that is too large and context-inappropriate for an in-app header).

**Rationale**: The existing `LoginPlaceholderScreen` already establishes this pattern
(Container + bolt icon + appName + subtitle). The splash image is designed for a
full-screen context. Re-using the placeholder pattern keeps visual continuity on the
login screen without adding an image decode cost.

**Alternatives considered**:
- `Image.asset('assets/splash/splash_image.png')` — rejected: sized for full-screen splash,
  not a compact header.
- Custom SVG asset — rejected: no SVG renderer in pubspec; icon system is sufficient.

---

## 2. Scrollable Layout Implementation

**Decision**: Wrap the `Scaffold` body in a `SingleChildScrollView` with
`physics: ClampingScrollPhysics()` (default on Android, avoids iOS bounce on a
form screen). The `Scaffold` sets `resizeToAvoidBottomInset: true` (default). The
`SingleChildScrollView` fills available vertical space via a `ConstrainedBox` with
`minHeight: MediaQuery.sizeOf(context).height`.

**Rationale**: This is the standard Flutter pattern for login forms. The constrained
box ensures content is vertically centered when the keyboard is absent; the scroll
wrapper allows content to be reached when the keyboard is present.

**Alternatives considered**:
- `resizeToAvoidBottomInset: false` with `Padding(EdgeInsets.only(bottom: viewInsets.bottom))`
  — rejected: more boilerplate, same outcome.
- Fixed layout — rejected: fields become obscured by keyboard on small devices.

---

## 3. Responsive Max-Width Container

**Decision**: Use `LayoutBuilder` to check available width and constrain the form
column with `ConstrainedBox(constraints: BoxConstraints(maxWidth: 480))` centered via
`Center`. This matches the existing `HomeShellScreen` and the general project
responsive approach (no dedicated breakpoint utility class exists yet).

**Breakpoints**:
- `< 600 dp` — full width with `AppSpacing.screenPad` (24) horizontal padding.
- `≥ 600 dp` — center-constrained at max-width 480 dp with `AppSpacing.screenPad`
  horizontal padding still applied inside the constrained box.

**Rationale**: A single `ConstrainedBox(maxWidth: 480)` centered is sufficient for
this form screen. No additional responsive utility is needed.

---

## 4. Riverpod Pattern: @riverpod Notifier

**Decision**: Use `@riverpod` annotation on a `Notifier<LoginFormState>` subclass
in `login_form_notifier.dart`. Run `dart run build_runner build` to generate
`login_form_notifier.g.dart`.

**Rationale**: Riverpod 2.x `Notifier` (code-gen) is the project's established
pattern (see `locale_provider.dart`, `theme_provider.dart`, `shared_preferences_provider.dart`
which all use the same generator). It is type-safe, testable, and requires zero
`StatefulWidget` usage.

**Provider name generated**: `loginFormNotifierProvider` (auto-named from class
`LoginFormNotifier` by riverpod_generator).

---

## 5. Freezed State Class

**Decision**: `LoginFormState` is a `@freezed` data class (copyWith-based mutations
via Notifier methods). Using `const factory` constructor.

**Rationale**: `freezed` is already in `pubspec.yaml` (freezed_annotation ^2.4.4,
freezed ^2.5.7 dev). It provides value equality, `copyWith`, and immutability — all
required by Riverpod's change-detection model. The existing `locale_provider.dart`
uses the same approach.

---

## 6. Input Field Design

**Decision**: Use Flutter's `TextField` (not `TextFormField` — no form submission
needed) with `InputDecoration` drawn from the dark theme (`AppTheme.dark()`). The
theme already defines:
- `enabledBorder`: `AppColors.border` (green600)
- `focusedBorder`: `AppColors.lime`, width 2
- `errorBorder`: `AppColors.error`
- `fillColor`: `AppColors.bgSurface`

Add `focusedErrorBorder` locally in each field widget:
`OutlineInputBorder(borderSide: BorderSide(color: AppColors.error, width: 2), borderRadius: AppRadius.mdAll)`

**Leading icon (identifier field)**: `Icon(Icons.person_outline_rounded)` wrapped in
`ExcludeSemantics`. RTL mirroring is automatic via Flutter's `Directionality`.

**Trailing icon (password field)**: `IconButton` with `semanticLabel` set to
`l10n.loginPasswordShow` / `l10n.loginPasswordHide` depending on `isPasswordVisible`.
Icon: `Icons.visibility_outlined` / `Icons.visibility_off_outlined`.

**Rationale**: `Icons.person_outline_rounded` is directionally neutral and does not
require explicit RTL mirroring. `Icons.visibility_outlined` similarly does not need
mirroring. Flutter handles prefix/suffix icon placement within `InputDecoration`
correctly for RTL via `Directionality`.

---

## 7. Login Button Design

**Decision**: Use `FilledButton` (Lime accent fill, Sprint green text — already
configured in `AppTheme.dark().filledButtonTheme`). When `isLoading` is true,
replace the label with `SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.sprintGreen))`.

**Rationale**: `FilledButton` (lime fill) is the CTA style per brand guidelines.
The existing `filledButtonTheme` in `AppTheme.dark()` already enforces
`minimumSize: Size(double.infinity, 52)` — the button stays full-width and
52 dp tall whether showing label or spinner, so no layout shift occurs.

**Mock tap behavior**: `onPressed` calls `loginFormNotifier.mockLogin()`, which:
1. Sets `isLoading = true`
2. Awaits `Future.delayed(const Duration(milliseconds: 1800))`
3. Sets `isLoading = false`

The button is disabled (passes `onPressed: null`) while `isLoading` is true.

---

## 8. Semantic Accessibility Labels

**Decision**: Apply `semanticLabel` directly on `Icon` widgets and `TextField`'s
`decoration.semanticCounterText` is insufficient — instead wrap `TextField` in a
`Semantics` widget with `label: l10n.loginIdentifierSemantic`. Decorative elements
(brand icon Container, bolt Icon inside it) are wrapped in `ExcludeSemantics`.

**Rationale**: `Semantics(label: ...)` is the correct Flutter API for giving a
custom accessible name to a widget subtree. `ExcludeSemantics` ensures the decorative
bolt icon is not announced by screen readers.

---

## 9. Localization Keys (New)

All keys must be added to `assets/l10n/app_ar.arb` and `assets/l10n/app_en.arb`,
then the generated Dart files regenerated via `flutter gen-l10n`.

| Key | Arabic | English |
|-----|--------|---------|
| `loginIdentifierHint` | الإيميل أو رقم الموبايل | Email or phone number |
| `loginPasswordHint` | كلمة السر | Password |
| `loginButton` | دخول | Sign in |
| `loginIdentifierError` | يرجى إدخال الإيميل أو رقم الموبايل | Please enter your email or phone |
| `loginPasswordError` | يرجى إدخال كلمة السر | Please enter your password |
| `loginIdentifierSemantic` | حقل الإيميل أو رقم الموبايل | Email or phone number field |
| `loginPasswordSemantic` | حقل كلمة السر | Password field |
| `loginButtonSemantic` | زرار الدخول | Sign in button |
| `loginPasswordShow` | إظهار كلمة السر | Show password |
| `loginPasswordHide` | إخفاء كلمة السر | Hide password |

Note: `loginTitle` and `loginSubtitle` already exist and are reused as-is.

---

## 10. Router Update

**Decision**: Update `app_router.dart` to reference `LoginScreen` instead of
`LoginPlaceholderScreen`. Delete `login_placeholder_screen.dart` after the new
screen is confirmed working.

**Rationale**: The route (`/login`, name: `'login'`) already exists in `AppRoutes`.
Only the builder target changes.
