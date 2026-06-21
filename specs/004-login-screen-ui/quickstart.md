# Quickstart Validation Guide: Login Screen UI

**Feature**: 004-login-screen-ui
**Date**: 2026-06-21
**Purpose**: Prove the login screen UI works end-to-end across all 4 visual states.

---

## Prerequisites

- Flutter SDK ≥ 3.11 installed and on PATH
- A connected device or simulator/emulator running
- From the project root (`/path/to/sprint`):

```bash
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter gen-l10n
```

Confirm no errors before proceeding.

---

## Running the App

```bash
flutter run
```

Or for web:
```bash
flutter run -d chrome
```

The app launches on the splash screen. After the splash animation completes, it
navigates to the login screen at route `/login`.

---

## Validation Scenarios

### Scenario 1 — Default State

**What to confirm**: All elements render correctly with no user interaction.

1. Navigate to `/login` (happens automatically after splash).
2. Verify: bolt icon (lime on green container) visible at top.
3. Verify: "سبرنت" app name below icon, styled in large bold text.
4. Verify: "أهلاً بيك في سبرنت" subtitle in secondary color.
5. Verify: Identifier field shows hint text "الإيميل أو رقم الموبايل" with a person icon on the right (RTL leading).
6. Verify: Password field shows hint text "كلمة السر" with eye icon on the left (RTL trailing = left side).
7. Verify: Login button "دخول" in lime with sprint-green text, full width.
8. Verify: No error messages, no spinner visible.

**Pass**: All elements present, layout not overflowing, text right-aligned.

---

### Scenario 2 — Focus State

**What to confirm**: Fields visually highlight on tap.

1. Tap the identifier field.
2. Verify: Border turns lime/accent color, 2dp wide.
3. Tap the password field.
4. Verify: Identifier border reverts to default; password border turns lime.
5. Tap outside both fields (e.g., on the logo).
6. Verify: Both fields revert to default border.

**Pass**: Lime border appears on focused field only; reverts on blur.

---

### Scenario 3 — Loading State (Login Button)

**What to confirm**: Tapping the button triggers the mock loading cycle.

1. Tap the "دخول" button.
2. Verify: Label disappears, circular spinner appears centered in the button.
3. Verify: Button dimensions (height, width) do not change during the transition.
4. Wait ~2 seconds.
5. Verify: Spinner disappears, "دخول" label reappears.
6. Verify: Button is tappable again.

**Pass**: No layout shift; auto-revert within 2 seconds.

---

### Scenario 4 — Error State (Mock)

**What to confirm**: Error visual style renders correctly on both fields.

This state requires a debug/test trigger. Use one of:
- A debug button in the widget (if added during implementation for preview purposes)
- A widget test that calls `loginFormNotifier.mockSetError()`
- A direct hot-reload with error state hardcoded temporarily

1. Trigger `mockSetError()` on `loginFormNotifierProvider`.
2. Verify: Identifier field has red border and caption "يرجى إدخال الإيميل أو رقم الموبايل" below.
3. Verify: Password field has red border and caption "يرجى إدخال كلمة السر" below.
4. Verify: Login button remains visible; layout does not overflow.
5. Start typing in the identifier field.
6. Verify: Error clears on the identifier field while password error remains.

**Pass**: Error styling visible; per-field clearing works.

---

### Scenario 5 — Keyboard / Scroll Behavior

**What to confirm**: Content stays accessible when keyboard appears.

1. Tap the password field on a mobile device (or simulate on iOS/Android emulator).
2. Verify: Keyboard appears, screen content scrolls up.
3. Verify: Password field and login button are fully visible above the keyboard.
4. Verify: Branding header may scroll off-screen — this is the expected behavior.
5. Dismiss keyboard (tap back/done).
6. Verify: Content scrolls back; branding header is visible again.

**Pass**: No fields hidden behind keyboard; no overflow errors in console.

---

### Scenario 6 — RTL Layout

**What to confirm**: All directional elements are correctly mirrored.

1. Ensure Arabic locale is active (default — or use debug toggle if present).
2. Verify: All text is right-aligned.
3. Verify: Person icon in identifier field appears on the RIGHT side of the field (leading = right in RTL).
4. Verify: Eye icon in password field appears on the LEFT side (trailing = left in RTL).
5. Verify: Bolt icon in brand header is directionally neutral (appears the same in both directions).

**Pass**: RTL mirroring correct; no LTR icon placement in Arabic mode.

---

### Scenario 7 — Responsive (Web)

**What to confirm**: Form is centered at max-width on wide screens.

1. Run on Chrome: `flutter run -d chrome`
2. Resize browser window to ≥ 960 dp wide.
3. Verify: Form column does not stretch beyond ~480 dp; content is horizontally centered.
4. Resize to ≤ 400 dp wide.
5. Verify: Form fills available width with 24 dp horizontal padding.

**Pass**: Max-width constraint works; no overflow.

---

## Static Analysis Gate

```bash
dart analyze
```

Expected output: `No issues found!`

---

## Formatting Gate

```bash
dart format --set-exit-if-changed lib/features/auth/ test/presentation/auth/
```

Expected: exits 0 (no changes needed).

---

## Running Tests

```bash
flutter test test/presentation/auth/
```

Expected: All tests pass.
