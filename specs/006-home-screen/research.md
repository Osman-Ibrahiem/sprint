# Research: Home Screen UI

## R1 — How is the guest/booker state selected before auth exists?
- **Decision**: a `HomeSession` enum parsed from the `session` query parameter of `/home` (default guest), passed to `HomeScreen` and used as the family argument of the content provider.
- **Rationale**: no global mock singleton; real auth later replaces the router parameter with an auth provider without touching widgets.
- **Alternatives**: a mutable global provider toggled by the login screen (couples login to Home and leaks mock state); a dart-define flag (not switchable at runtime on web).

## R2 — Where does pricing live?
- **Decision**: `Facility.priceFor(UserAffiliation?)` in the domain.
- **Rationale**: BR-07 says pricing is computed by the domain; it is testable without widgets and guests (null) map to the full price.
- **Alternatives**: computing in the widget (violates BR-07 and principle III).

## R3 — Navigation per size class
- **Decision**: `AdaptiveTokens.navType` of the window class: bottom bar (compact), rail (medium/expanded), extended rail (large).
- **Rationale**: tokens already exist from 005; no new breakpoints (principle VI).
- **Alternatives**: permanent `NavigationDrawer` (second control), Cupertino tab bar on Apple (deferred, noted in Complexity Tracking).

## R4 — Facility grid columns
- **Decision**: columns by the *content pane's* size class (1 / 2 / 3), card height = art height + info height scaled by the user's text scale.
- **Rationale**: the pane (window minus rail) is what matters; fixed extent with text-scale keeps cards uniform at 200% text.
- **Alternatives**: `Wrap` with intrinsic height (jumpy, no lazy building); aspect ratio (breaks with text scale).

## R5 — Date and duration formatting
- **Decision**: ARB placeholders (`DateTime` with `MMMEd` / `jm` formats, plural for hours).
- **Rationale**: locale-correct Arabic without a hand-rolled formatter.

## R6 — Photos
- **Decision**: gradient tile with a category icon until real photos exist.
- **Rationale**: no assets; avoids hotlinking or fake imagery.

## R7 — Verification on web
- **Decision**: check a `flutter build web --release` served statically; the debug web-server did not finish loading inside the browser pane.
