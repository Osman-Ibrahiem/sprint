# Data Model: Login Screen UI

**Feature**: 004-login-screen-ui
**Date**: 2026-06-21
**Layer**: Presentation only — no domain or data entities.

---

## State Model

### `LoginFormState` (freezed data class)

Located at: `lib/features/auth/presentation/notifiers/login_form_notifier.dart`

```
LoginFormState
├── identifierText: String          default: ''
├── passwordText: String            default: ''
├── isPasswordVisible: bool         default: false
├── identifierError: String?        default: null
├── passwordError: String?          default: null
└── isLoading: bool                 default: false
```

**Immutability**: All mutations occur via `copyWith` inside `LoginFormNotifier`.
**Value equality**: Provided by `freezed`.
**Serialization**: Not required — this is a transient UI state.

**State transitions**:

```
Initial (all defaults)
  │
  ├─ user types in identifier field
  │     → identifierText = value, identifierError = null
  │
  ├─ user types in password field
  │     → passwordText = value, passwordError = null
  │
  ├─ user taps password visibility toggle
  │     → isPasswordVisible = !isPasswordVisible
  │
  ├─ user taps login button (mockLogin)
  │     → isLoading = true
  │     → [after ~1800ms] isLoading = false
  │
  └─ mockSetError() called (UI preview / debug)
        → identifierError = l10n string, passwordError = l10n string
```

---

## Notifier

### `LoginFormNotifier` (@riverpod Notifier)

Located at: `lib/features/auth/presentation/notifiers/login_form_notifier.dart`

| Method | Parameters | Effect |
|--------|-----------|--------|
| `build()` | — | Returns `LoginFormState()` (all defaults) |
| `setIdentifierText(String v)` | value | Updates `identifierText`, clears `identifierError` |
| `setPasswordText(String v)` | value | Updates `passwordText`, clears `passwordError` |
| `togglePasswordVisibility()` | — | Flips `isPasswordVisible` |
| `mockLogin()` | — | `isLoading=true` → 1800ms delay → `isLoading=false` |
| `mockSetError()` | — | Sets both error fields to mock strings |
| `clearErrors()` | — | Clears both error fields to null |

**Provider generated name**: `loginFormNotifierProvider`
**Provider type**: `AutoDisposeNotifierProvider<LoginFormNotifier, LoginFormState>`
(auto-dispose — provider is created when screen is mounted, disposed on pop)

---

## Widget Tree

```
LoginScreen (ConsumerWidget)
└── Scaffold
    └── SafeArea
        └── SingleChildScrollView
            └── Center
                └── ConstrainedBox (maxWidth: 480)
                    └── Padding (horizontal: AppSpacing.screenPad)
                        └── Column
                            ├── SizedBox (height: AppSpacing.xxxl)   ← top breathing room
                            ├── LoginBrandHeader (StatelessWidget)
                            │   └── Column
                            │       ├── ExcludeSemantics
                            │       │   └── Container (48×48, sprintGreen, radius 8)
                            │       │       └── Icon(bolt_rounded, lime, size 28)
                            │       ├── SizedBox (height: AppSpacing.lg)
                            │       ├── Text(l10n.appName, style: h1)
                            │       ├── SizedBox (height: AppSpacing.xs)
                            │       └── Text(l10n.loginTitle, style: body, color: textSecondary)
                            ├── SizedBox (height: AppSpacing.xxxl)   ← section gap
                            ├── LoginIdentifierField (StatelessWidget)
                            │   └── Semantics(label: loginIdentifierSemantic)
                            │       └── TextField(prefixIcon: person_outline_rounded)
                            ├── SizedBox (height: AppSpacing.lg)
                            ├── LoginPasswordField (StatelessWidget)
                            │   └── Semantics(label: loginPasswordSemantic)
                            │       └── TextField(suffixIcon: IconButton(eye))
                            ├── SizedBox (height: AppSpacing.xxl)
                            ├── LoginButton (StatelessWidget)
                            │   └── Semantics(label: loginButtonSemantic)
                            │       └── FilledButton OR [loading: CircularProgressIndicator]
                            └── SizedBox (height: AppSpacing.xxxl)  ← bottom breathing room
```

---

## Localization Keys

New keys added to ARB files. See `research.md § 9` for the full table.

Abstract getters added to `AppLocalizations`:
- `loginIdentifierHint`
- `loginPasswordHint`
- `loginButton`
- `loginIdentifierError`
- `loginPasswordError`
- `loginIdentifierSemantic`
- `loginPasswordSemantic`
- `loginButtonSemantic`
- `loginPasswordShow`
- `loginPasswordHide`

Reused existing keys:
- `loginTitle` — welcome heading ("أهلاً بيك في سبرنت")
- `loginSubtitle` — NOT shown on the new login screen (replaced by loginTitle as subtitle)
- `appName` — "سبرنت"

---

## Token Mapping

| Element | Token |
|---------|-------|
| Scaffold background | `AppColors.bgBase` (via Scaffold `Theme.of(context)`) |
| Field fill | `AppColors.bgSurface` (via `inputDecorationTheme`) |
| Enabled field border | `AppColors.border` (via theme) |
| Focused field border | `AppColors.lime`, width 2 (via theme) |
| Error field border | `AppColors.error` (via theme) |
| Brand icon background | `AppColors.sprintGreen` |
| Brand bolt icon | `AppColors.lime` |
| App name text | `AppColors.textPrimary` (via `AppTypography.h1`) |
| Welcome subtitle text | `AppColors.textSecondary` |
| Login button fill | `AppColors.lime` (via `filledButtonTheme`) |
| Login button text | `AppColors.sprintGreen` (via `filledButtonTheme`) |
| Loading spinner | `AppColors.sprintGreen` |
| Error caption text | `AppColors.error` (via M3 `errorText` styling) |
| Field corner radius | `AppRadius.md` (12 dp, via theme) |
| Brand icon corner radius | `AppRadius.sm` (8 dp) |
