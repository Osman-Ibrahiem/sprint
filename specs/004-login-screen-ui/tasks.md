# Tasks: Login Screen UI

**Input**: Design documents from `specs/004-login-screen-ui/`

**Prerequisites**: plan.md ✅ | spec.md ✅ | research.md ✅ | data-model.md ✅ | contracts/widget-contracts.md ✅ | quickstart.md ✅

**Tests**: Included — Notifier unit tests (domain-adjacent logic) + widget tests per user story.

**Organization**: Tasks are grouped by user story phase. US1 is the full MVP; US2–4
add test coverage for the remaining visual states (which are implemented in US1 widgets).

## Format: `[ID] [P?] [Story?] Description`

- **[P]**: Can run in parallel (different files, no blocking dependencies)
- **[Story]**: Which user story this task belongs to ([US1]–[US4])

---

## Phase 1: Setup

**Purpose**: Add localization keys and regenerate the l10n layer. No widget or Dart
class is touched until l10n is ready.

- [X] T001 [P] Add 10 new `login*` keys to `assets/l10n/app_ar.arb`: `loginIdentifierHint` ("الإيميل أو رقم الموبايل"), `loginPasswordHint` ("كلمة السر"), `loginButton` ("دخول"), `loginIdentifierError` ("يرجى إدخال الإيميل أو رقم الموبايل"), `loginPasswordError` ("يرجى إدخال كلمة السر"), `loginIdentifierSemantic` ("حقل الإيميل أو رقم الموبايل"), `loginPasswordSemantic` ("حقل كلمة السر"), `loginButtonSemantic` ("زرار الدخول"), `loginPasswordShow` ("إظهار كلمة السر"), `loginPasswordHide` ("إخفاء كلمة السر")
- [X] T002 [P] Add matching `login*` keys to `assets/l10n/app_en.arb` with English values: `loginIdentifierHint` ("Email or phone number"), `loginPasswordHint` ("Password"), `loginButton` ("Sign in"), `loginIdentifierError` ("Please enter your email or phone"), `loginPasswordError` ("Please enter your password"), `loginIdentifierSemantic` ("Email or phone number field"), `loginPasswordSemantic` ("Password field"), `loginButtonSemantic` ("Sign in button"), `loginPasswordShow` ("Show password"), `loginPasswordHide` ("Hide password")
- [X] T003 Run `flutter gen-l10n` to regenerate `lib/core/l10n/app_localizations.dart`, `app_localizations_ar.dart`, `app_localizations_en.dart` (depends on T001 + T002 — run after both ARB files are updated)

**Checkpoint**: `flutter gen-l10n` completes with zero errors. All 10 new getters appear in `app_localizations.dart`.

---

## Phase 2: Foundational (Blocking Prerequisites)

**Purpose**: Create the `LoginFormState` (freezed) + `LoginFormNotifier` (@riverpod)
and run code generation. All widget phases depend on these being generated.

**⚠️ CRITICAL**: No widget or screen work can begin until T006 completes successfully.

- [X] T004 Create `lib/features/auth/presentation/notifiers/login_form_notifier.dart` with the `@freezed` `LoginFormState` class containing 6 fields with defaults: `identifierText String ''`, `passwordText String ''`, `isPasswordVisible bool false`, `identifierError String? null`, `passwordError String? null`, `isLoading bool false` — add `part 'login_form_notifier.g.dart';` at top
- [X] T005 Add `@riverpod` `LoginFormNotifier extends Notifier<LoginFormState>` to `lib/features/auth/presentation/notifiers/login_form_notifier.dart` with 6 methods: `build()` → `LoginFormState()`, `setIdentifierText(String v)` → clears `identifierError`, `setPasswordText(String v)` → clears `passwordError`, `togglePasswordVisibility()` → flips `isPasswordVisible`, `mockLogin()` → sets `isLoading=true`, awaits `Future.delayed(1800ms)`, sets `isLoading=false`, `mockSetError()` → sets both error fields, `clearErrors()` → clears both error fields (depends on T004)
- [X] T006 Run `dart run build_runner build --delete-conflicting-outputs` from project root to generate `lib/features/auth/presentation/notifiers/login_form_notifier.g.dart` (depends on T005 — file must compile before running)
- [X] T007 Write unit tests in `test/features/auth/presentation/login_form_notifier_test.dart` covering: initial state has all defaults, `setIdentifierText` updates text + clears error, `setPasswordText` updates text + clears error, `togglePasswordVisibility` flips bool, `mockLogin` transitions `isLoading` true then false, `mockSetError` sets both error strings, `clearErrors` nulls both errors (depends on T006)

**Checkpoint**: `flutter test test/features/auth/presentation/login_form_notifier_test.dart` passes. `dart analyze lib/features/auth/presentation/notifiers/` reports no issues.

---

## Phase 3: User Story 1 — Default Login Screen (Priority: P1) 🎯 MVP

**Goal**: A fully-rendered login screen with all four widgets visible in their default
state, wired to the Notifier, correct RTL layout, dark theme, max-width responsive
container, and scrollable on keyboard appearance.

**Independent Test**: Navigate to `/login` in a running app. All quickstart.md
Scenario 1 items pass. `dart analyze` and `flutter gen-l10n` report zero issues.

### Implementation for User Story 1

- [X] T008 [P] [US1] Create `lib/features/auth/presentation/widgets/login_brand_header.dart` — `StatelessWidget`, `const LoginBrandHeader({super.key})`: renders `ExcludeSemantics` → `Container(48×48, color: AppColors.sprintGreen, borderRadius: BorderRadius.circular(AppRadius.sm))` → `Icon(Icons.bolt_rounded, size: 28, color: AppColors.lime)`; followed by `Text(l10n.appName, style: AppTypography.h1)` and `Text(l10n.loginTitle, style: AppTypography.body, color: AppColors.textSecondary)` (depends on T003)
- [X] T009 [P] [US1] Create `lib/features/auth/presentation/widgets/login_identifier_field.dart` — `StatelessWidget` with constructor `({required ValueChanged<String> onChanged, String? errorText, TextEditingController? controller, super.key})`: wraps `TextField` in `Semantics(label: l10n.loginIdentifierSemantic)`; `InputDecoration` with `hintText: l10n.loginIdentifierHint`, `prefixIcon: ExcludeSemantics(child: Icon(Icons.person_outline_rounded))`, `errorText: errorText`, `focusedErrorBorder: OutlineInputBorder(borderSide: BorderSide(color: AppColors.error, width: 2), borderRadius: AppRadius.mdAll)`; `keyboardType: TextInputType.emailAddress`, `textInputAction: TextInputAction.next` (depends on T003 + T006)
- [X] T010 [P] [US1] Create `lib/features/auth/presentation/widgets/login_password_field.dart` — `StatelessWidget` with constructor `({required ValueChanged<String> onChanged, required bool isVisible, required VoidCallback onToggleVisibility, String? errorText, TextEditingController? controller, super.key})`: wraps `TextField` in `Semantics(label: l10n.loginPasswordSemantic)`; `obscureText: !isVisible`; `suffixIcon: IconButton(icon: Icon(isVisible ? Icons.visibility_outlined : Icons.visibility_off_outlined), semanticLabel: isVisible ? l10n.loginPasswordHide : l10n.loginPasswordShow, onPressed: onToggleVisibility)`; `errorText: errorText`; `focusedErrorBorder` same as identifier field; `textInputAction: TextInputAction.done` (depends on T003 + T006)
- [X] T011 [P] [US1] Create `lib/features/auth/presentation/widgets/login_button.dart` — `StatelessWidget` with constructor `({required VoidCallback? onPressed, required bool isLoading, super.key})`: wraps in `Semantics(label: l10n.loginButtonSemantic)`; renders `FilledButton(onPressed: isLoading ? null : onPressed, child: isLoading ? SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: AppColors.sprintGreen)) : Text(l10n.loginButton))` (depends on T003 + T006)
- [X] T012 [US1] Create `lib/features/auth/presentation/screens/login_screen.dart` — `ConsumerWidget`, `const LoginScreen({super.key})`: reads `loginFormNotifierProvider`; `Scaffold(backgroundColor: theme.scaffoldBackgroundColor)` with body `SafeArea → SingleChildScrollView → Center → ConstrainedBox(maxWidth: 480) → Padding(horizontal: AppSpacing.screenPad) → Column` containing: `SizedBox(height: AppSpacing.xxxl)`, `LoginBrandHeader()`, `SizedBox(height: AppSpacing.xxxl)`, `LoginIdentifierField(onChanged: notifier.setIdentifierText, errorText: state.identifierError)`, `SizedBox(height: AppSpacing.lg)`, `LoginPasswordField(onChanged: notifier.setPasswordText, isVisible: state.isPasswordVisible, onToggleVisibility: notifier.togglePasswordVisibility, errorText: state.passwordError)`, `SizedBox(height: AppSpacing.xxl)`, `LoginButton(onPressed: notifier.mockLogin, isLoading: state.isLoading)`, `SizedBox(height: AppSpacing.xxxl)` (depends on T008–T011)
- [X] T013 [US1] Update `lib/core/router/app_router.dart` — change the `/login` route builder from `LoginPlaceholderScreen()` to `LoginScreen()` and update the import to `login_screen.dart` (depends on T012)
- [X] T014 [US1] Delete `lib/features/auth/presentation/screens/login_placeholder_screen.dart` after confirming T013 compiles without it (depends on T013)
- [X] T015 [P] [US1] Write widget test for default state in `test/features/auth/presentation/login_screen_test.dart`: pump `LoginScreen` wrapped in `ProviderScope`, `MaterialApp` with `AppTheme.dark()` and Arabic locale; assert bolt icon `Container` is present; assert app name text renders; assert identifier hint text renders; assert password hint text renders; assert login button label renders; assert no error text visible; assert no spinner visible (depends on T012)

**Checkpoint**: `flutter run` → navigate to `/login` → Quickstart Scenario 1 passes. `flutter test test/features/auth/presentation/login_screen_test.dart` passes.

---

## Phase 4: User Story 2 — Input Focus State (Priority: P2)

**Goal**: Confirm Lime-accent focus border activates on field tap, and password
visibility toggle works correctly. Widgets are already implemented — this phase adds
test coverage.

**Independent Test**: Quickstart Scenario 2 (focus) and the visibility toggle part of
Scenario 2 pass. Widget tests for both behaviors pass.

- [X] T016 [US2] Add widget test for focus state to `test/features/auth/presentation/login_screen_test.dart`: pump screen, tap identifier field, verify `FocusScope` shows identifier focused; pump password field tap, verify border color reflects focused state (use `TestWidgetsFlutterBinding.ensureInitialized`, verify `TextField` gains focus via `FocusNode`) (depends on T015)
- [X] T017 [US2] Add widget test for password visibility toggle to `test/features/auth/presentation/login_screen_test.dart`: pump screen, assert password field starts obscured (`TextField.obscureText == true`), tap the eye icon, pump, assert password field is now visible; tap again, assert obscured again (depends on T015)

**Checkpoint**: All widget tests pass. `flutter run` → Quickstart Scenario 2 verified manually.

---

## Phase 5: User Story 3 — Error/Validation Appearance (Priority: P3)

**Goal**: Confirm the error visual state renders correctly on both fields when
`mockSetError()` is called on the Notifier.

**Independent Test**: Quickstart Scenario 4 (error state) passes. Widget test for
error state passes.

- [X] T018 [US3] Add widget test for error state to `test/features/auth/presentation/login_screen_test.dart`: pump screen, call `container.read(loginFormNotifierProvider.notifier).mockSetError()`, pump, verify identifier field shows error border style and `loginIdentifierError` caption below field; verify password field shows error border and `loginPasswordError` caption; verify login button still visible; start typing in identifier field and verify its error clears while password error remains (depends on T015)

**Checkpoint**: Widget test passes. `flutter run` → call `mockSetError()` from DevTools or test → Scenario 4 verified.

---

## Phase 6: User Story 4 — Button Loading State (Priority: P3)

**Goal**: Confirm the login button enters the loading visual state on mock tap,
auto-reverts after ~2 seconds, and produces no layout shift.

**Independent Test**: Quickstart Scenario 3 (loading) passes. Widget test for
loading state passes.

- [X] T019 [US4] Add widget test for loading state to `test/features/auth/presentation/login_screen_test.dart`: pump screen; tap login button; pump; verify spinner (`CircularProgressIndicator`) is visible; verify button label ("دخول") is not visible; verify button's `onPressed` is null (disabled during load); use `fakeAsync` + `tick(Duration(milliseconds: 1900))` to advance time; pump; verify spinner gone, label visible, button re-enabled (depends on T015)

**Checkpoint**: Widget test passes with `fakeAsync`. `flutter run` → tap button → Scenario 3 passes manually.

---

## Phase 7: Polish & Cross-Cutting Concerns

**Purpose**: Static analysis, formatting, and final manual validation pass.

- [X] T020 [P] Run `dart analyze lib/features/auth/ test/features/auth/` — resolve any warnings or hints until output is `No issues found!`
- [X] T021 [P] Run `dart format --set-exit-if-changed lib/features/auth/ test/features/auth/` — apply formatting if needed
- [x] T022 Run all quickstart.md scenarios (1–7) manually in a running app (`flutter run` on device or simulator) and confirm all pass — pay special attention to Scenario 5 (keyboard scroll), Scenario 6 (RTL), and Scenario 7 (web responsive) *(verified 2026-11-08: web 375/1280 and iPhone Duo simulator; scenarios 3–4 covered by widget tests; scenario 7 superseded by spec 005 two-pane layout)*
- [X] T023 Run full test suite `flutter test` to confirm no regressions in other features

---

## Dependencies & Execution Order

### Phase Dependencies

- **Setup (Phase 1)**: No dependencies — start immediately. T001 and T002 run in parallel.
- **Foundational (Phase 2)**: Depends on T003 completing. T004 and T005 are sequential (same file). T006 depends on T005. T007 depends on T006.
- **US1 (Phase 3)**: Depends on Phase 2 completion (T006). T008–T011 run in parallel. T012 depends on T008–T011. T013 depends on T012. T014 depends on T013. T015 depends on T012.
- **US2 (Phase 4)**: Depends on T015 (test file exists).
- **US3 (Phase 5)**: Depends on T015.
- **US4 (Phase 6)**: Depends on T015.
- **Polish (Phase 7)**: Depends on T019 (all implementation and tests complete).

### User Story Dependencies

- **US1 (P1)**: Starts after Phase 2 — no dependency on other stories.
- **US2 (P2)**: Can start after T015 — independent of US3/US4.
- **US3 (P3)**: Can start after T015 — independent of US2/US4.
- **US4 (P3)**: Can start after T015 — independent of US2/US3.

### Parallel Opportunities

```bash
# Phase 1 — parallel:
T001  # Add AR l10n keys
T002  # Add EN l10n keys

# Phase 3 — parallel widget creation (after T006):
T008  # LoginBrandHeader
T009  # LoginIdentifierField
T010  # LoginPasswordField
T011  # LoginButton

# Phase 4–6 — parallel (after T015):
T016  # Focus state test
T017  # Visibility toggle test
T018  # Error state test
T019  # Loading state test

# Phase 7 — parallel:
T020  # dart analyze
T021  # dart format
```

---

## Implementation Strategy

### MVP First (User Story 1 Only)

1. Complete Phase 1: Setup (T001–T003)
2. Complete Phase 2: Foundational (T004–T007)
3. Complete Phase 3: US1 (T008–T015)
4. **STOP and VALIDATE**: Run `flutter run`, navigate to `/login`, verify Quickstart Scenario 1.
5. Run `flutter test` to confirm no regressions.

At this point the login screen is fully functional and visible in the running app.

### Incremental Delivery

1. MVP (US1) → Screen renders with all widgets in default state.
2. US2 tests → Focus behavior and visibility toggle verified.
3. US3 test → Error state verified.
4. US4 test → Loading cycle verified.
5. Polish → Zero analyzer warnings, formatting clean, all 7 quickstart scenarios pass.

### Notes

- `[P]` tasks can run in parallel (different files, no shared edits).
- Build runner (T006) MUST complete before any widget creates a `ref.watch(loginFormNotifierProvider)` call — the generated provider name won't exist until then.
- `flutter gen-l10n` (T003) MUST complete before any widget imports `AppLocalizations` new getters — the getters won't exist in the generated file until then.
- Delete `LoginPlaceholderScreen` (T014) only after confirming the router compiles with `LoginScreen` — avoids a broken state where neither screen exists.
- Test file `login_screen_test.dart` is created in T015 and appended to in T016–T019 — tasks must execute sequentially within that file.
