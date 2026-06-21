# Feature Specification: Login Screen UI

**Feature Branch**: `004-login-screen-ui`

**Created**: 2026-06-21

**Status**: Draft

**Input**: Login screen visual interface — UI-only, no backend or logic wiring.

---

## User Scenarios & Testing *(mandatory)*

### User Story 1 — View Default Login Screen (Priority: P1)

A user opens the app and lands on the login screen. They see the Sprint branding, two input fields (identifier and password), and a login button — all in the dark theme with Arabic RTL layout.

**Why this priority**: This is the entry gate for all three roles. The default state is what every user sees first and is the baseline for all other states.

**Independent Test**: Launch the app, navigate to the login route, and confirm the screen renders the brand header, both fields, and the login button with correct RTL layout and design tokens (no hardcoded colors).

**Acceptance Scenarios**:

1. **Given** the app is on the login route with no user input, **When** the screen loads, **Then** the brand header (bolt icon + "سبرنت" in Lime accent on dark background) is visible at the top, both fields are empty and unfocused, and the login button shows its default label "دخول" with no spinner.
2. **Given** the screen is displayed on a mobile viewport (360 dp wide), **When** rendered, **Then** all elements fit within the viewport with correct Arabic text alignment and RTL icon mirroring.
3. **Given** the screen is displayed on a web viewport (≥ 960 dp wide), **When** rendered, **Then** the form is centered with a max-width container consistent with existing responsive patterns — no horizontal overflow.

---

### User Story 2 — Interact with Input Fields (Focus State) (Priority: P2)

A user taps the identifier or password field. The focused field visually highlights to confirm interaction. The password field shows a visibility toggle icon.

**Why this priority**: Focus feedback is a fundamental usability signal; missing it would make the form feel broken even in a UI-only preview.

**Independent Test**: Tap the identifier field — it gains a Lime-accent border. Tap the password field — it gains a Lime-accent border and shows a show/hide icon. Tap outside both fields — both return to default unfocused appearance.

**Acceptance Scenarios**:

1. **Given** the identifier field is unfocused, **When** the user taps it, **Then** the field border transitions to Lime accent (#CCF42B) and the cursor is positioned correctly in RTL mode.
2. **Given** the password field is unfocused, **When** the user taps it, **Then** the field border transitions to Lime accent and a visibility-toggle icon appears on the leading side (RTL-mirrored — icon on the right in LTR maps to left in RTL).
3. **Given** the password field is focused with text entered and visibility is hidden, **When** the user taps the toggle icon, **Then** the password text becomes visible and the icon reflects the "eye open" state; tapping again hides it.

---

### User Story 3 — View Error/Validation Appearance (Priority: P3)

A developer or designer previews the error visual state on the form. Fields display a red border and an inline error message beneath them. This is a static/mock state — no real validation logic drives it.

**Why this priority**: The error appearance must be designed and code-reviewable before the real validation feature is built, so it needs to be a first-class visual state in this UI-only feature.

**Independent Test**: Trigger the error visual state (e.g., via a debug toggle, a mock prop, or a static demo screen) and confirm both fields can show a red border with an Arabic error label beneath.

**Acceptance Scenarios**:

1. **Given** the identifier field is in the error mock state, **When** rendered, **Then** the field has a red border (error color from the theme's `colorScheme.error`) and an Arabic error caption ("يرجى إدخال الإيميل أو رقم الموبايل") appears directly beneath the field.
2. **Given** the password field is in the error mock state, **When** rendered, **Then** the field has a red border and an Arabic error caption ("يرجى إدخال كلمة السر") appears beneath.
3. **Given** both fields are in error state, **When** rendered, **Then** the login button remains visible and the layout does not overflow or shift unexpectedly.

---

### User Story 4 — View Button Loading State (Priority: P3)

A developer or designer previews the loading visual state of the login button after a mock tap. The button shows a circular spinner in place of its label to indicate in-progress action.

**Why this priority**: The loading state must be designed now so the future wiring step only needs to wire state, not invent visual behavior.

**Independent Test**: Tap the login button (mock tap handler). The button replaces "دخول" with a circular spinner for ~2 seconds, then reverts to default. Confirm the spinner color and button dimensions remain stable during the transition.

**Acceptance Scenarios**:

1. **Given** the login button is in default state, **When** tapped, **Then** the button label disappears and a circular loading indicator (Lime accent or dark contrast spinner) appears centered within the button's fixed dimensions.
2. **Given** the button is in loading state, **When** rendered, **Then** the button width and height do not change — no layout shift.
3. **Given** the button is in loading state on both mobile and web, **When** rendered, **Then** the spinner is correctly centered and sized in both breakpoints.

---

### Edge Cases

- What happens when the identifier field contains a very long email string? The field should scroll/ellipsis internally without breaking the layout.
- What happens on extra-small viewports (< 320 dp)? Text and fields must not overflow — minimum padding must be maintained.
- What happens when the device font scale is increased to 200%? The form must not overflow its container (use `textScaler` constraints if needed).
- What happens in landscape orientation on mobile? The branding header should collapse or reduce so the form is still accessible without scrolling excessively.

---

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: The screen MUST display a branding header at the top containing the bolt icon and the app name "سبرنت" using the Lime accent color on the dark background, consistent with the splash screen identity.
- **FR-002**: The screen MUST display a single identifier input field that accepts email or phone number text without a toggle between modes. Hint text (placeholder) MUST read "الإيميل أو رقم الموبايل" in informal Arabic.
- **FR-003**: The screen MUST display a password input field with obscured text by default and a show/hide toggle icon. Hint text MUST read "كلمة السر".
- **FR-004**: The identifier field MUST display a Lime-accent border when focused and revert to the default border style when unfocused.
- **FR-005**: The password field MUST display a Lime-accent border when focused, include a visibility-toggle icon that is RTL-mirrored, and toggle text visibility on icon tap.
- **FR-006**: Both fields MUST support an error visual state: red border (theme error color) plus an Arabic error caption below the field. This state is triggered by a mock/static mechanism, not real validation.
- **FR-007**: The screen MUST display a primary login button with the label "دخول". On tap, the button MUST enter a loading visual state (spinner replaces label) for a brief mock duration, then revert. No real submission occurs.
- **FR-008**: The layout MUST be RTL by default. All icons within input fields MUST be mirrored appropriately. Text MUST align right. The bolt icon in the branding header MUST respect RTL conventions.
- **FR-009**: The screen MUST be responsive: on mobile (< 600 dp wide) it occupies full width with horizontal padding; on web (≥ 960 dp wide) the form is centered in a max-width container.
- **FR-010**: All colors MUST be sourced from the project's design token system (`AppColors` / `AppTheme` in `core/theme/`). Zero hardcoded color values are permitted.
- **FR-011**: All text strings MUST be externalized via the project's localization system (`flutter_localizations` / `AppLocalizations`). No inline Arabic string literals in widget code.
- **FR-012**: The screen MUST be implemented as a composition of small, single-responsibility widgets (brand header widget, identifier field widget, password field widget, login button widget) within the presentation layer. No monolithic screen widget.
- **FR-013**: No Forgot Password link, social login buttons, or role selection UI MUST appear on this screen.

### Key Entities

- **LoginFormState**: A UI-only state model holding: `identifierText`, `passwordText`, `isPasswordVisible` (bool), `identifierError` (nullable string), `passwordError` (nullable string), `isLoading` (bool). Drives visual rendering only — no domain logic.
- **LoginBrandHeader**: A stateless widget encapsulating the bolt icon and app name branding element.
- **LoginIdentifierField**: A stateless widget rendering the identifier input with focus/error visual states.
- **LoginPasswordField**: A stateless widget rendering the password input with visibility toggle and focus/error visual states.
- **LoginButton**: A widget rendering the primary action button with default and loading visual states.

---

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: All four visual states (default, focused, error, loading) are renderable and distinguishable on first viewing by a designer with no code context — verified by a design review session.
- **SC-002**: The screen renders without visual overflow, clipping, or misalignment on mobile (360 × 800 dp), tablet (768 × 1024 dp), and web (1280 × 800 dp) viewports.
- **SC-003**: All on-screen Arabic text is correctly right-aligned and all directional icons are correctly mirrored in RTL layout — verified by visual inspection in an RTL locale.
- **SC-004**: Zero hardcoded color values exist in any widget file for this screen — verified by a `grep` scan of the feature's presentation layer files.
- **SC-005**: Zero inline Arabic string literals exist in widget files — verified by checking all strings are routed through the localization system.
- **SC-006**: The screen compiles with zero Dart analyzer errors or warnings.
- **SC-007**: The login button mock loading cycle (tap → spinner → revert) completes visually within 2 seconds and produces no layout shift measurable by the developer.

---

## Assumptions

- The existing splash screen's bolt icon asset is already available in the project's asset registry and can be reused directly.
- The project's localization `.arb` files exist and can accept new keys for this screen's strings.
- The `core/theme/` directory already defines `AppColors.limeAccent`, `AppColors.darkBackground`, `AppColors.sprintGreen`, and the Cairo font configuration — no new tokens need to be created.
- The existing responsive layout utility (breakpoint helpers) used in prior screens applies here; no new responsive framework is introduced.
- "Brief mock duration" for the loading state is approximately 1.5–2 seconds (a `Future.delayed` in the tap handler), sufficient for visual preview purposes.
- The login screen route path (e.g., `/login`) is already registered or will be registered in go_router separately from this feature — this spec covers only the screen widget, not the route registration.
- Arabic is the default locale and RTL the default direction; English/LTR variants are out of scope for this UI iteration.
