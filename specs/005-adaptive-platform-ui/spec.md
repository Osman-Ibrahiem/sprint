# Feature Specification: Adaptive & Platform-Native UI

**Feature Branch**: `feature/adaptive-ui` (spec directory `005-adaptive-platform-ui`)

**Created**: 2026-11-07

**Status**: Draft — written **after** the code (code-first, per `docs/adaptive-ui-plan.md`). It documents what was built in Phases 0–4 and is the reference for later screens.

**Input**: "Adaptive size-class layout (compact / medium / expanded / large), per-class tokens, pane-aware sizing, platform detection (Apple vs Material look), adaptive form widgets (text field, filled button, spinner, icons), brand bolt, flex posture, debug platform override; applied to Login (two panes) and Splash."

**Source of truth for numbers**: Figma file `XOicu3nMxdDpSORSyHG9UX` — variable collections **Layout** and **Type scale**, component sets `Login/Field` (15:44), `Login/Button` (15:49), `Splash/Spinner` (20:705). Where this spec and Figma differ, Figma wins; record the difference in the decisions doc.

---

## User Scenarios & Testing *(mandatory)*

### User Story 1 — Same app, right layout for every screen size (Priority: P1)

A user opens Sprint on a phone, a tablet, a foldable or a wide browser window. The Login screen shows one centered column on narrow windows and a brand pane plus a form pane on wide ones. Nothing overflows, nothing is stretched edge to edge.

**Why this priority**: Sprint ships as one codebase for mobile and web; an unusable wide layout blocks the web release.

**Independent Test**: Render Login at 360×800, 800×1000, 840×800 and 1280×800 and check pane count, form width and brand-pane width.

**Acceptance Scenarios**:

1. **Given** a window narrower than 840 dp, **When** Login opens, **Then** a single column shows the brand header above the form, the form is at most 480 dp wide, and side margins follow the size class.
2. **Given** a window of 840 dp or wider, **When** Login opens, **Then** two panes show: the brand pane on the start side (right in RTL) and the form pane, whose width is the form column plus two margins.
3. **Given** a window exactly 840 dp wide, **When** Login opens, **Then** the brand pane is not narrower than its 360 dp minimum.
4. **Given** the window is resized across a breakpoint, **When** layout rebuilds, **Then** the structure switches with no overflow and no loss of typed input.

---

### User Story 2 — Native feel on Apple and Material platforms (Priority: P1)

A user on iPhone or Mac Safari sees filled, rounded, thin-stroke controls with a capsule button; a user on Android or Windows sees outlined fields with a 12 dp-radius button. Both keep the Sprint dark, lime identity.

**Why this priority**: Platform-familiar controls reduce friction for first-time bookers and are a stated design decision.

**Independent Test**: Render each adaptive control under iOS and Android target platforms and compare size, shape, border and icon set.

**Acceptance Scenarios**:

1. **Given** an Apple platform, **When** a text field renders, **Then** it is 50 dp tall, squircle-shaped, has no border at rest, and on focus gets a 1 dp lime border and an elevated fill.
2. **Given** a Material platform, **When** a text field renders, **Then** it is 56 dp tall with a 1 dp border at rest and a 2 dp lime border on focus.
3. **Given** either platform, **When** a field has an error, **Then** its border uses the error colour and a caption sits 4 dp below it.
4. **Given** Apple, **When** the primary button renders, **Then** it is a 50 dp capsule; on Material it is 52 dp with a 12 dp radius.
5. **Given** the button is loading, **When** it renders, **Then** the label is replaced by a spinner, taps are ignored, size is unchanged, and the fill is lime at 40 %.
6. **Given** the platform changes, **When** icons render, **Then** person, lock, eye and eye-slash come from the platform's own icon set.
7. **Given** web on macOS/iOS, **When** the app loads, **Then** the Apple look is used; on Windows/Linux/Android, the Material look.

---

### User Story 3 — Splash that fits any window (Priority: P2)

On launch the splash animates a logo, name, tagline, spinner and institution badge. Corner brackets stay inside the safe area; the logo scales with the window class; on very short windows the spinner is dropped and the logo shrinks.

**Why this priority**: First impression on every device; affects foldable cover screens and landscape.

**Independent Test**: Run the splash at 360×800, 1280×720 and 380×420 and check logo size, spinner presence and bracket positions.

**Acceptance Scenarios**:

1. **Given** compact / medium / expanded-or-large windows, **When** the splash settles, **Then** the logo is 160 / 200 / 240 dp.
2. **Given** a window shorter than 600 dp, **When** the splash settles, **Then** there is no spinner and the logo is capped at one third of the window height (never above the class size).
3. **Given** device insets (notch, home indicator, hinge side cut-outs), **When** brackets render, **Then** each sits at safe-area inset plus 24 dp (compact) or 32 dp (medium and up) from the edge.

---

### User Story 4 — Foldables and dual-screen hinges (Priority: P3)

On a dual-screen device (e.g. iPhone Duo) or a half-open flip phone, nothing is drawn across the hinge. With a vertical hinge the brand pane sits on one screen and the form pane on the other; with a horizontal hinge the header is on the top screen and the form on the bottom one. A flat, seamless fold or a hinge-less device behaves normally.

**Why this priority**: Least certain part of the design; not yet verified on hardware.

**Independent Test**: Provide a half-open horizontal hinge via display features and check the header ends above it and the form starts below it.

**Acceptance Scenarios**:

1. **Given** a horizontal hinge (dual-screen, or a half-open fold) and a single-pane width, **When** Login renders, **Then** the brand header is entirely above the hinge and the form entirely below.
2. **Given** a vertical hinge (dual-screen landscape), **When** Login renders, **Then** the brand pane occupies the start screen and the form pane the other, with the hinge gap empty and no control crossing it.
3. **Given** a flat seamless fold or no hinge, **When** Login renders, **Then** the normal layout is used.

---

### User Story 5 — Keyboard never hides the form (Priority: P2)

When the keyboard opens, the focused field and the login button remain reachable by scrolling; dragging the form closes the keyboard.

**Independent Test**: Open Login at 360×700 with a 300 dp keyboard inset, focus the password field, scroll to the button, and check it ends above the keyboard.

---

### Edge Cases

- Window exactly on a breakpoint (599/600, 839/840, 1199/1200): the larger class applies.
- Brand-pane institution badge on a narrow pane or large text scale: it scales down instead of overflowing.
- A pane narrower than the window (e.g. the 576 dp form pane in a 1440 dp window): type and margin tokens follow the **pane**, not the window.
- Deep link straight to `/login` on web: the native splash overlay never clears (existing defect, tracked in Open Points).
- Light mode, English/LTR, tablet/desktop typed/keyboard states and half-open postures beyond Flip are not designed yet.

---

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: The app MUST classify a width into compact (<600), medium (600–839), expanded (840–1199) or large (≥1200); boundaries belong to the larger class.
- **FR-002**: Each class MUST provide, from Figma **Layout**: columns (4/8/12/12), margin (24/32/40/48), gutter (16/16/24/24), max content width (600/840/840/1200), panes (1/1/2/2), navigation type (bottom bar / rail / rail / drawer), start-pane width (0/0/360/400), splash logo size (160/200/240/240), splash edge inset (24/32/32/32).
- **FR-003**: Each class MUST provide type sizes from Figma **Type scale** (display-xl 48/56/64/72, display 40/44/52/60, h1 32/36/40/44, h2 26/28/32/34, h3 20/22/24/26, body-lg 16/17/18/18, body 15/16/16/17, sm 14/14/15/15, xs 12/12/13/13, micro 11/11/12/12). Weight, line height and family stay those of the Compact scale.
- **FR-004**: Sizing inside a pane MUST follow the pane's own width (pane scope); the window class decides structure only. Without a pane scope the window class applies.
- **FR-005**: The platform look MUST be derived from the theme's target platform: iOS/macOS → Apple; Android/Windows/Linux/Fuchsia → Material. On web the target platform comes from the user agent.
- **FR-006**: For development, the platform look, device size, keyboard and folds MUST be switchable at runtime with the `device_preview` package (debug/profile only; off in release). On iOS the engine reports no display features yet (flutter/flutter#193025), so hinge-aware layouts can only be checked on Android/Windows foldables.
- **FR-007**: The adaptive text field, filled button and spinner MUST match the metrics in the table below.

  | Control | Apple | Material |
  |---------|-------|----------|
  | Field height / shape | 50, squircle r12 | 56, r12 |
  | Field border | none; focus 1 lime; error 1 error | 1 border; focus 2 lime; error 1 error |
  | Field fill | surface; focus elevated | surface |
  | Icon size / placement | 20 inline, gap 8, edge 14 | 24 in 48 box |
  | Trailing tap target | 44 | 48 |
  | Button height / shape | 50 capsule, Bold | 52, r12, Black |
  | Spinner | 12-spoke activity indicator, 20 | arc, 20, stroke 2 (1.5 on splash) |

- **FR-008**: Icons for person, lock, eye and eye-slash MUST be chosen per platform (Cupertino vs outlined Material).
- **FR-009**: The Sprint bolt MUST be a drawn vector (traced from the Figma Splash bolt), not a stock icon, and MUST be excluded from the accessibility tree where decorative.
- **FR-010**: Login MUST render one pane below 840 dp (header above form, form ≤ 480 dp) and two panes from 840 dp (brand pane on the start side; form pane = 480 + 2 × margin, never leaving the brand pane under the start-pane minimum).
- **FR-011**: The Login form pane MUST show a title and subtitle; the single-pane layout shows the brand header instead. The password field MUST have a leading lock and a trailing visibility toggle that exposes tooltip text.
- **FR-012**: Login content MUST scroll, keep focused fields above the keyboard, and dismiss the keyboard on drag.
- **FR-013**: A dual-screen hinge (any posture) or a half-open fold MUST split the Login layout: horizontal → header above, form below; vertical → brand pane on the start screen, form pane on the other, hinge gap empty. Flat seamless folds are ignored.
- **FR-014**: The Splash MUST size its logo by class (160/200/240), place brackets at safe-area inset + edge inset, use the adaptive spinner, and below 600 dp height omit the spinner and cap the logo at ⌊⅓ × height⌋.
- **FR-015**: No colour, size, spacing or string used by these features MAY be hard-coded outside the token files (`core/theme`, `core/adaptive`) or localisation; analyzer MUST report zero warnings.
- **FR-016**: Business and layout rules (class boundaries, token lookups, short-window limits, posture detection, platform mapping, override parsing) MUST have unit tests; each adaptive control MUST have widget tests under both platforms.

### Key Entities

- **Size class**: one of four window/pane width categories, with a minimum width.
- **Adaptive tokens**: per-class bundle of layout values, navigation type and type sizes.
- **Pane scope**: the size class of the nearest pane.
- **App platform**: Apple or Material look.
- **Flex posture**: top-half height and bottom-half start of a half-open horizontal hinge.
- **Splash limits**: short-window threshold and logo cap.

---

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: At every width from 320 to 2560 dp, Login and Splash render with no overflow or clipped controls.
- **SC-002**: Boundary tests at 599/600/839/840/1199/1200 dp all pass.
- **SC-003**: Visual comparison of Login (phone Apple, phone Material focused, wide Apple) and Splash (phone, wide, short) against the matching Figma frames shows no layout difference larger than 2 dp, other than documented deviations.
- **SC-004**: A user can reach and press the login button with the keyboard open on a 700 dp-tall phone without leaving the screen.
- **SC-005**: Adding a new screen needs no new breakpoints: it reads size class, tokens and platform from the shared layer only.

---

## Assumptions

- Dark mode, Arabic RTL and Cairo remain the only designed variants; Light mode and English/LTR are out of scope.
- Navigation type per class is recorded as a token but no navigation UI is built here; Home (Guest) decides it.
- Foldable behaviour beyond the half-open posture is treated as the nearest size class.
- Splash animation is unchanged apart from the end size.

## Deviations from spec 004 and the earlier splash/foundation specs

1. Login web layout: centred max-width form → two panes from Expanded up (004 FR-009).
2. New brand pane and form heading using the previously unused subtitle string.
3. Per-platform field, button, loading and icon styling instead of one Material theme.
4. Brand bolt: traced vector instead of `Icons.bolt_rounded`.
5. Password toggle on the end side (004 FR-005 wording differs).
6. 360 dp / ≥ 960 web wording → size-class table.
7. Responsive margin instead of fixed 24.
8. Leading lock icon on the password field.
9. Apple field has a lime 1 dp border on focus (plan said "no outline"; Figma shows it).
10. Splash: logo size by class, short-window rules, safe-area brackets (003).

## Open Points

- Deep link to `/login` on web leaves the native splash overlay up; propose removing it from `main` on web.
- Shared brand widgets (glow, logo image, institution badge) still live in the splash feature and are imported by Login; move to `core`.
- Brand-pane details not fixed in Figma: badge position, logo-to-name gap.
- Form-pane type uses the pane class (Medium: title 28, subtitle 16); Figma drew Compact values (26 / 15).
- Short-window logo cap is a formula (⅓ height) that is 1–2 dp off Figma's 140 / 152.
- Not verified on iOS simulator, Android emulator or real foldables; Material look verified on web via the platform override only.
