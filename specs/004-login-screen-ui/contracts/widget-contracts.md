# Widget Contracts: Login Screen UI

**Feature**: 004-login-screen-ui
**Date**: 2026-06-21

These contracts define the public API (constructor parameters, expected behavior) of
each widget in this feature. Implementing widgets MUST match these signatures.

---

## `LoginScreen`

**Type**: `ConsumerWidget`
**Location**: `lib/features/auth/presentation/screens/login_screen.dart`
**Constructor**: `const LoginScreen({super.key})`

**Responsibilities**:
- Reads `loginFormNotifierProvider` to get `LoginFormState`.
- Passes callbacks into sub-widgets (e.g., `ref.read(...).setIdentifierText`).
- Owns the `SingleChildScrollView` + `ConstrainedBox(maxWidth: 480)` layout.
- Sets `Scaffold(backgroundColor: theme.scaffoldBackgroundColor)`.

**Consumed provider**: `loginFormNotifierProvider`

---

## `LoginBrandHeader`

**Type**: `StatelessWidget`
**Location**: `lib/features/auth/presentation/widgets/login_brand_header.dart`
**Constructor**: `const LoginBrandHeader({super.key})`
**Parameters**: none

**Renders**:
1. `ExcludeSemantics` → `Container(48×48, color: AppColors.sprintGreen, radius: AppRadius.sm)`
   → `Icon(Icons.bolt_rounded, size: 28, color: AppColors.lime)`
2. `Text(l10n.appName, style: AppTypography.h1, color: AppColors.textPrimary)`
3. `Text(l10n.loginTitle, style: AppTypography.body, color: AppColors.textSecondary)`

**Accessibility**: bolt icon Container is wrapped in `ExcludeSemantics` — not announced.

---

## `LoginIdentifierField`

**Type**: `StatelessWidget`
**Location**: `lib/features/auth/presentation/widgets/login_identifier_field.dart`

**Constructor**:
```
LoginIdentifierField({
  required ValueChanged<String> onChanged,
  String? errorText,
  TextEditingController? controller,
  super.key,
})
```

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `onChanged` | `ValueChanged<String>` | yes | Called on every keystroke |
| `errorText` | `String?` | no | When non-null, shows red border + error caption |
| `controller` | `TextEditingController?` | no | Optional external controller |

**Renders**: `Semantics(label: l10n.loginIdentifierSemantic)` wrapping a `TextField` with:
- `keyboardType: TextInputType.emailAddress`
- `textInputAction: TextInputAction.next`
- `hintText: l10n.loginIdentifierHint`
- `prefixIcon: ExcludeSemantics(child: Icon(Icons.person_outline_rounded))`
- `errorText: errorText` (null = no error shown)
- `focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.error, width: 2), borderRadius: AppRadius.mdAll)`

---

## `LoginPasswordField`

**Type**: `StatelessWidget`
**Location**: `lib/features/auth/presentation/widgets/login_password_field.dart`

**Constructor**:
```
LoginPasswordField({
  required ValueChanged<String> onChanged,
  required bool isVisible,
  required VoidCallback onToggleVisibility,
  String? errorText,
  TextEditingController? controller,
  super.key,
})
```

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `onChanged` | `ValueChanged<String>` | yes | Called on every keystroke |
| `isVisible` | `bool` | yes | Controls obscured vs. visible text |
| `onToggleVisibility` | `VoidCallback` | yes | Called on eye-icon tap |
| `errorText` | `String?` | no | When non-null, shows red border + error caption |
| `controller` | `TextEditingController?` | no | Optional external controller |

**Renders**: `Semantics(label: l10n.loginPasswordSemantic)` wrapping a `TextField` with:
- `obscureText: !isVisible`
- `textInputAction: TextInputAction.done`
- `hintText: l10n.loginPasswordHint`
- `suffixIcon: IconButton(icon: Icon(isVisible ? visibility_outlined : visibility_off_outlined), semanticLabel: isVisible ? l10n.loginPasswordHide : l10n.loginPasswordShow, onPressed: onToggleVisibility)`
- `focusedErrorBorder:` same as identifier field

---

## `LoginButton`

**Type**: `StatelessWidget`
**Location**: `lib/features/auth/presentation/widgets/login_button.dart`

**Constructor**:
```
LoginButton({
  required VoidCallback? onPressed,
  required bool isLoading,
  super.key,
})
```

| Parameter | Type | Required | Description |
|-----------|------|----------|-------------|
| `onPressed` | `VoidCallback?` | yes | Null disables the button (used during loading) |
| `isLoading` | `bool` | yes | When true, replaces label with spinner |

**Renders**: `Semantics(label: l10n.loginButtonSemantic)` wrapping a `FilledButton` with:
- `onPressed: isLoading ? null : onPressed`
- Child when `isLoading == false`: `Text(l10n.loginButton, style: AppTypography.bodyLg.copyWith(fontWeight: AppTypography.extraBold))`
- Child when `isLoading == true`: `SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.sprintGreen))`

**Layout guarantee**: Button maintains `minimumSize: Size(double.infinity, 52)` from
`filledButtonTheme` in both states — no layout shift on loading state toggle.
