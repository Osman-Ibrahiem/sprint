# Adaptive + platform UI — code-first implementation plan

Status: plan only, nothing implemented. Written 2026-11-07 from the Figma design pass.
Order chosen by Osman: code first, look at the result, then update specs 001–004 and the constitution.

Sources of truth
- Figma: https://www.figma.com/design/XOicu3nMxdDpSORSyHG9UX (pages Splash `6:2`, Login `15:2`; variable collections Type scale `VariableCollectionId:11:2`, Layout `VariableCollectionId:11:3`).
- Decisions doc: "Sprint" Project on claude.ai, `claude/design-decisions.md` (platform rules, size classes, deviations, provisional data).
- Values marked proposed there (Light mode, Duo/Fold sizes, safe-area insets, type sizes beyond display-xl/h1/body) are provisional. Read exact numbers from Figma (`get_variable_defs`) instead of copying them from this file.

Decision (2026-11-07): the adaptive foundation gets a NEW spec, `005-adaptive-platform-ui` (size classes, tokens, platform detection, adaptive widgets, tests). `002-core-foundation` stays as is, with a short note pointing to 005 and a "superseded by 005" mark only on any theme/token decision that conflicts. `004-login-screen-ui` is amended (two panes, the deviations below, uses the 005 widgets). Splash changes go into the existing splash spec (likely 003), or a small section in 005 if the change stays minor. The constitution is updated once, when 005 is done, with two principles: Adaptive-first and Platform-adaptive UI.

Rules that still apply (constitution)
Clean Architecture layers, Riverpod, go_router, Arabic RTL + Cairo, dark default, zero hardcoded colors/strings/magic numbers (all through `core/theme` and the new adaptive tokens), strings via l10n, zero analyzer warnings, business logic tested.

## Branching
Create a new branch from the current one (`chore/upgrade-deps`) or from `main` once that merges, e.g. `feature/adaptive-ui`. The working tree has uncommitted edits in AGENTS.md and CLAUDE.md that are not part of this work.

## Phase 0 — Preflight
- Confirm the Flutter SDK has `RoundedSuperellipseBorder` (squircle). If not, fall back to `ContinuousRectangleBorder`.
- Confirm `cupertino_icons` is in pubspec (the grep printed above shows whether it is; add it if missing).
- Decide where the shared pieces live: `lib/core/adaptive/` (breakpoints, tokens, platform) and `lib/core/presentation/widgets/adaptive/` (widgets).

## Phase 1 — Core: size classes, tokens, platform
- `SizeClass { compact, medium, expanded, large }` with `fromWidth` using 600 / 840 / 1200 (Material 3 window size classes).
- Per-class tokens: columns, margin, gutter, max content width, navigation type, pane count, start-pane width, type sizes. Values: Figma collections Layout and Type scale.
- `PaneScope` (LayoutBuilder + InheritedWidget): exposes the size class of the pane's own width, so inside a pane the tokens follow the pane, not the window. Window-level class decides structure only.
- `AppPlatform.of(context)`: apple = iOS/macOS, material = Android/Windows/Linux/Fuchsia, read from `Theme.of(context).platform` so tests and a debug override can switch it. On web the target platform comes from the user agent, so Safari/macOS gives the Apple look and Chrome/Windows the Material look.
- Typography: keep `AppTypography` constants as the Compact values; add a size-class-aware accessor instead of rewriting call sites.
- `AppSpacing.screenPad` (fixed 24) becomes the responsive margin token for screens; keep the constant for non-screen uses.

## Phase 2 — Adaptive widgets (core)
Each widget chooses its look from `AppPlatform` and is built once, used everywhere.
- `AdaptiveTextField`: Apple = filled, no outline, squircle, 50 dp, leading/trailing icons thin-stroke. Material = filled + outline, 56 dp, 2 px lime focus border, `error` border for errors. Both keep the existing hint/error/semantics behaviour.
- `AdaptiveFilledButton`: Apple = capsule, 50 dp. Material = 12 dp radius, 52 dp. Lime fill, sprintGreen label, loading state swaps the label for the spinner.
- `AdaptiveSpinner`: `CupertinoActivityIndicator` (12 spokes) vs `CircularProgressIndicator` arc (size 20, stroke 2), sprintGreen on the button and the Splash color on the Splash footer.
- `AppIcons` (platform pick): person, lock, eye, eye_slash → `CupertinoIcons.person / lock / eye / eye_slash` on Apple; `Icons.person_outline_rounded / lock_outline_rounded / visibility_outlined / visibility_off_outlined` on Material. Brand bolt is the same on both (traced vector from Splash, replaces `Icons.bolt_rounded` in the header).
- Pixel details (radii, border widths, fills per state): read from Figma `Login/Field` set `15:44` (axes Kind, State, Platform, Reveal), `Login/Button` set `15:49`, Spinner set `20:705`.

## Phase 3 — Login screen
- Compact/Medium: single column, max width 480, brand header above the form.
- Expanded/Large: two panes. Brand pane on the start side (right in RTL): glow, logo, name, tagline, institution badge; width from `layout/pane-start-width`. Form pane: 480 + 2 × margin, with title (`loginTitle`) and subtitle (`loginSubtitle`, currently unused).
- Password field gets a leading lock icon, identifier keeps person. Visibility toggle stays at the end side.
- Keyboard open: scrollable form that scrolls the focused field and button above the keyboard.
- States to match Figma: default, focused, error, loading, typed (masked), password visible, keyboard open.
- Foldables: use `MediaQuery.displayFeatures`. Flat or no hinge = ignore it. Flex posture (half-open) = header in the top half, form in the bottom half; do this last, it is the least certain part of the design.
- Keep the existing Riverpod notifier and l10n keys; this phase is presentation-only.

## Phase 4 — Splash
- Corner brackets inside the safe area (today the top ones are 24 from the screen edge).
- Logo size by size class (160 / 200 / 240), short screens drop the spinner and shrink the logo, spinner uses `AdaptiveSpinner`.

## Phase 5 — Tests (alongside each phase)
- Unit: `SizeClass.fromWidth` at 599/600/839/840/1199/1200, token table lookups.
- Widget: each adaptive widget under `TargetPlatform.iOS` vs `android` (check widget types and shapes); Login at 360×800 = one pane, at 1280×800 = two panes, RTL; keyboard inset does not hide the button; Splash brackets respect safe-area padding.
- `flutter analyze` with zero warnings; `dart format`; existing tests still green.

## Phase 6 — Visual check against Figma
Run on Chrome (try the Apple look with a debug platform override), an iOS simulator and an Android emulator, at phone, tablet and wide window sizes; compare with the Figma frames of the same name (`Login / iPhone 17`, `Login / Pixel 10`, States row for keyboard/typed/visible). Fix differences in the code, or note in the decisions doc when the Figma value was the wrong one.

## Phase 7 — After the code looks right
- Write spec 005 (speckit-specify, then plan and tasks) from what exists in code. Amend 004 for the deviations below, add the pointer notes in 002 (and 003 for Splash), then update the constitution with the two new principles.
- Next screen: Home (Guest). It also decides navigation per platform (Apple tab bar/sidebar vs Material bottom bar/rail/drawer).

## Deviations from spec 004 / current code (to record in the spec afterwards)
1. FR-009 centered max-width form on web → two panes from Expanded up.
2. New brand pane and form heading (`loginSubtitle`).
3. Per-platform field/button/loading/icon styling instead of one Material theme.
4. Brand bolt = traced Splash vector instead of `Icons.bolt_rounded`.
5. Password visibility toggle on the end side (code already does this; spec FR-005 wording differs).
6. Mobile-only wording (360 dp, ≥ 960 web) → size-class table.
7. Responsive margin instead of fixed `screenPad` 24.
8. Leading lock icon on the password field.

## Open points
- Which Material icon paths in Figma were recalled from memory: re-check against the real `Icons` when implementing.
- Not designed yet: tablet/desktop versions of typed/visible/keyboard states, half-open postures, Light mode, English/LTR, splash animation.
