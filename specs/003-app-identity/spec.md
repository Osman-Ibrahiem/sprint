# Feature Specification: App Identity

**Feature Branch**: `003-app-identity`

**Created**: 2026-06-14

**Status**: Draft

**Input**: User description: "Feature: app-identity — Bilingual support (Arabic default, English secondary) via ARB files; dual theme (dark default, light secondary) via Riverpod ThemeMode provider; app name 'سبرنت' (ar) / 'Sprint' (en); app icon variants switching with theme; native and Flutter splash screens pixel-identical and seamless; navigates to login screen placeholder after splash."

---

## User Scenarios & Testing *(mandatory)*

### User Story 1 — First Launch in Arabic, Dark Theme (Priority: P1)

A new user opens the app for the first time. The native OS splash appears immediately with a dark background matching the Sprint theme. The Flutter splash replaces it pixel-for-pixel with no visual jump. After a brief moment, the login screen placeholder appears. The UI is fully in Arabic with right-to-left layout, and the app icon reflects the dark variant.

**Why this priority**: This is the default experience for every new user and represents the brand's first impression. It must work flawlessly before any other flow is built.

**Independent Test**: Install the app on a fresh device, launch it, and verify the splash sequence and final landing on the login placeholder — all in Arabic, dark mode, without any crash or visual flash.

**Acceptance Scenarios**:

1. **Given** the app is freshly installed and launched, **When** the OS loads, **Then** the native splash screen appears with a dark background and Sprint branding — no white flash.
2. **Given** the native splash is visible, **When** Flutter initialises, **Then** the Flutter splash replaces the native splash with a pixel-identical dark screen — no gap or colour shift.
3. **Given** the Flutter splash completes, **When** the transition runs, **Then** the user lands on the login screen placeholder with all UI rendered in Arabic (RTL) and dark theme active.
4. **Given** the login placeholder is shown, **When** the user inspects the app icon in the task switcher, **Then** the icon is the dark variant.

---

### User Story 2 — Theme Toggle (Dark ↔ Light) at Runtime (Priority: P2)

A user changes the app theme from dark to light (or vice versa) from within the app (e.g., a settings screen or a temporary debug toggle). The entire app re-renders immediately in the new theme without restarting. The app icon visible in the OS task switcher updates to the matching variant.

**Why this priority**: The constitution requires a Riverpod-driven theme that updates without restart. Proving this works validates the provider architecture that all future screens depend on.

**Independent Test**: Toggle the theme via a provider call (e.g., from a test button or devtools) and confirm all currently visible widgets re-render to the new theme instantly, without a rebuild of the entire navigator stack.

**Acceptance Scenarios**:

1. **Given** the app is running in dark mode, **When** the theme provider is set to light, **Then** all visible UI switches to light theme within one frame — no full app restart.
2. **Given** the app is running in light mode, **When** the theme provider is set to dark, **Then** all visible UI switches to dark theme within one frame.
3. **Given** the theme is toggled multiple times rapidly, **When** each toggle completes, **Then** the final state matches the last requested theme with no visual artefacts.

---

### User Story 3 — Language Toggle (Arabic ↔ English) at Runtime (Priority: P3)

A user changes the app language from Arabic to English (or vice versa). The entire app re-renders immediately in the new language with the correct text direction (RTL for Arabic, LTR for English) without restarting.

**Why this priority**: Bilingual support is a stated requirement. Validating runtime locale switching confirms the ARB/localisation wiring is correct and future screens can rely on it.

**Independent Test**: Toggle the locale provider and confirm the login screen placeholder re-renders in the new language with the correct directionality, without a full app restart.

**Acceptance Scenarios**:

1. **Given** the app is running in Arabic (RTL), **When** the locale provider is set to English, **Then** all visible text switches to English with LTR layout within one frame.
2. **Given** the app is running in English (LTR), **When** the locale provider is set to Arabic, **Then** all visible text switches to Arabic with RTL layout within one frame.
3. **Given** the locale is Arabic, **When** the user reads the app name in the splash or header, **Then** "سبرنت" is displayed; in English, "Sprint" is displayed.

---

### Edge Cases

- What happens when the device OS theme is dark but the app's in-app theme override is set to light? The app follows its own Riverpod provider value; it does not mirror the OS theme automatically (unless explicitly built that way in future).
- How does the system handle a locale that is neither Arabic nor English? It falls back to Arabic as the default locale.
- What happens if the Flutter splash animation is skipped (e.g., very fast device)? The transition must still land on the login placeholder correctly — no blank screen or stuck state.
- What happens when the user backgrounds the app mid-splash and returns? The splash must not replay; the user should land on the login placeholder.
- What happens if an ARB key is missing in the English file? The app falls back to the Arabic string rather than crashing or showing a key name.

---

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: The app MUST display "سبرنت" as its name when the Arabic locale is active and "Sprint" when the English locale is active, in all system-visible contexts (splash, app bar, OS task switcher label where supported).
- **FR-002**: The app MUST default to Arabic locale and dark theme on first launch, with no user configuration required.
- **FR-003**: The app MUST support runtime locale switching between Arabic (RTL) and English (LTR) without an app restart, driven exclusively by a Riverpod locale provider.
- **FR-004**: The app MUST support runtime theme switching between dark and light modes without an app restart, driven exclusively by a Riverpod ThemeMode provider.
- **FR-005**: The native OS splash screen MUST use the dark background colour (`#1B1B1B` or the project's canonical dark surface) when the device is in dark mode and a matching light background when in light mode.
- **FR-006**: The Flutter splash screen MUST be pixel-identical to the native splash (same background colour, centred Sprint logo/wordmark, same proportions) to produce a seamless visual transition.
- **FR-007**: After the Flutter splash completes, the app MUST navigate to the login screen placeholder automatically — no user action required.
- **FR-008**: The login screen placeholder MUST be a static screen showing the app name in the active locale, with no interactive elements beyond what is needed to verify identity display.
- **FR-009**: All user-visible strings MUST be externalised in ARB files (`app_ar.arb` for Arabic, `app_en.arb` for English); no hardcoded string literals in widget code.
- **FR-010**: The app icon MUST have two variants — one for dark theme, one for light theme — and the correct variant MUST be shown in OS contexts that support adaptive icons.
- **FR-011**: All theme values (colours, typography, spacing) used in the splash and login placeholder MUST be sourced from `core/theme/`; zero hardcoded colour or size values are permitted.

### Key Entities *(include if feature involves data)*

- **ThemeMode Provider**: A Riverpod provider holding the current `ThemeMode` (dark/light). Writable from any screen; read by `MaterialApp`. Persisted in local storage for future launches (assumption: defaults to dark on first launch, then remembers last choice).
- **Locale Provider**: A Riverpod provider holding the current `Locale` (Arabic/English). Writable from any screen; read by `MaterialApp`. Persisted in local storage for future launches (defaults to Arabic).
- **SplashRoute**: The Flutter splash screen widget. Reads theme and locale providers passively; triggers navigation to login placeholder after its completion animation.
- **LoginPlaceholder**: A minimal static screen widget confirming routing works and displaying the localised app name.

---

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: On a cold launch, the transition from native splash to Flutter splash to the login placeholder completes in under 3 seconds on a mid-range device (equivalent to a 2019-era Android mid-range or iPhone SE 2).
- **SC-002**: Theme switching (dark ↔ light) takes effect within a single rendered frame (≤ 16 ms) with no intermediate blank or flickering state visible to the user.
- **SC-003**: Locale switching (Arabic ↔ English) takes effect within a single rendered frame with correct text direction applied immediately — no frame where RTL and LTR content coexist.
- **SC-004**: 100% of visible string literals on the splash and login placeholder are sourced from ARB files — a grep for hardcoded Arabic or English text in widget source files returns zero results.
- **SC-005**: The Flutter splash and native splash are visually indistinguishable when viewed side-by-side in a screenshot comparison — background colour delta ≤ 1 RGB unit, logo position within 1 dp.
- **SC-006**: `dart analyze` produces zero errors and zero warnings across all files introduced by this feature.

---

## Assumptions

- The project's canonical dark surface colour for splash backgrounds is already defined in `core/theme/` and will be reused; no new colour values are invented for this feature.
- The Sprint logo/wordmark asset (SVG or PNG) already exists in the asset pipeline from the core foundation feature and can be referenced directly.
- Adaptive icon support is limited to Android (foreground + background layers) and iOS (single PNG set); the "theme-switching icon" behaviour refers to providing dark/light variants via platform-specific asset declarations, not dynamic runtime icon replacement (which is OS-restricted).
- Theme and locale provider values are stored in device local storage and survive app restarts; the persistence mechanism (shared_preferences or equivalent) is treated as an infrastructure detail in the data layer.
- A settings screen that exposes the theme and locale toggles to end users is **out of scope** for this feature; provider wiring is built but UI controls will appear in a future settings feature.
- The login screen itself (authentication logic, form validation, backend calls) is **out of scope**; only a placeholder screen confirming navigation and localisation is required.
- No backend, network calls, or authentication flows are involved in this feature.
