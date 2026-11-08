# Feature Specification: Home Screen UI (Guest + Booker)

**Feature Branch**: `claude/home-screen-d508af` (merges into `develop`, never `main`)
**Created**: 2026-11-08
**Status**: Draft
**Input**: Home screen in two states — guest (not logged in, limited) and logged-in Booker. UI only, mock data.

> Builds on [004-login-screen-ui](../004-login-screen-ui/spec.md) and
> [005-adaptive-platform-ui](../005-adaptive-platform-ui/spec.md) (size classes, `PaneScope`,
> adaptive widgets, platform look). No canonical Figma exists for Home; the layout below is
> the design of record until one does (UX correction 1 and 2 in
> `docs/project-context/product-and-ux.md`).

## Scope

**In**: the `/home` route in two states, mock data behind a domain repository interface,
adaptive navigation for the signed-in state, facility discovery with prices.
**Out of scope**: Supabase / auth logic / real session, Register screen (deferred), booking
flow, payment, My Bookings / Notifications / Profile screens (nav destinations exist, show a
"coming soon" body), trainer and admin homes, photos (placeholder art until assets exist),
foldable hinge-aware split (content scrolls and stays inside safe areas; revisit with Home v2).

## User Scenarios & Testing

### US1 — Guest discovers facilities (P1)
A visitor who is not signed in sees a limited Home: brand top bar with a "دخول" button, a
short pitch, and a list of facilities with their prices. Prices are visible (BR-07); booking is
not possible.

**Independent test**: open `/home` (default = guest). Top bar shows brand + login button, hero
with sign-in CTA, facility cards with full price; no bottom navigation; tapping a card or any
CTA goes to `/login`.

Acceptance:
1. Given guest state, when loaded, then no greeting, no upcoming booking, no navigation bar/rail.
2. Given a facility card, then it shows name, category, booking mode badge (free / with trainer — BR-04) and the **full** hourly price.
3. Given a tap on a card, hero CTA or top-bar button, then the app navigates to `/login`.

### US2 — Booker sees a personalised Home (P1)
A signed-in Booker sees a greeting, their next booking (or an empty state), the facility list
with **their** price (university-affiliated → discounted with the full price struck through;
external → full price), and the app navigation.

**Independent test**: open `/home?session=booker`. Greeting uses the profile name; upcoming
booking card shows facility and time; affiliated users see discounted prices.

Acceptance:
1. Given a booker with an upcoming booking, then the card shows facility name, day/time and duration.
2. Given a booker with none, then an empty-state card invites to book.
3. Given a university-affiliated booker, then every facility card shows the discounted price and the original price struck through; an external booker sees full price only.
4. Given the signed-in state, then navigation has 4 destinations (Home, My bookings, Notifications, Profile); non-Home destinations show a "coming soon" body. No quick-action buttons duplicate them (UX correction 2).

### US3 — Adapts to the window (P2)
Compact: one column + bottom bar. Medium: 2-column grid + rail. Expanded: 3 columns + rail.
Large: 3 columns + permanent drawer. Guest has no nav at any size. Content is capped at
`maxContentWidth`, scrolls, never overflows from 320 dp, and follows the platform look.

### US4 — Loading and error states (P3)
While content loads a skeleton-free spinner (adaptive) shows; on failure an Arabic message with
a retry button shows. Mock repository can be made to fail in tests.

## Requirements

- **FR-001** Home MUST render two states chosen by a `HomeSession` value (`guest`, `booker`) taken from the route query `session` (default `guest`). No real auth.
- **FR-002** Data MUST come from `HomeRepository` (domain interface) implemented by `MockHomeRepository` (data layer). No Supabase imports anywhere in `features/home/`.
- **FR-003** Price shown MUST be computed in the domain (`Facility.priceFor(UserAffiliation?)`): null (guest) and `external` → full price, `universityAffiliated` → discounted (BR-07).
- **FR-004** Each facility MUST expose its booking mode (`free` | `coached`), shown as a badge; the two flows are never merged (BR-04).
- **FR-005** Guest MUST NOT see booking-specific personal data and has no navigation chrome; every booking entry point routes to `/login`.
- **FR-006** Signed-in navigation type MUST follow `AdaptiveTokens.navType` of the window class (bottomBar / rail / drawer).
- **FR-007** Grid columns for facility cards MUST derive from the pane's size class (compact 1, medium 2, expanded 3, large 3) via a layout helper; no new breakpoints.
- **FR-008** All colors from `AppColors`, spacing from `AppSpacing`, radii from `AppRadius`, type from `AdaptiveTypography`; no hardcoded values. Home-specific constants live in `home_layout.dart`.
- **FR-009** All user-facing strings via ARB (`ar` source, `en` mirror). Mock facility names are mock *data* in the data layer and are replaced by backend content later.
- **FR-010** RTL by default; icons from `AppIcons`/platform-aware or directional-safe Material icons.
- **FR-011** State via `@riverpod` (code generation). No `setState`.
- **FR-012** Semantics: cards expose name + price + mode as one label; decorative art excluded.

## Key Entities

`Facility`, `FacilityCategory`, `BookingMode`, `UserAffiliation`, `BookerProfile`,
`UpcomingBooking`, `HomeContent`, `HomeSession`.

## Success Criteria

- `flutter analyze` clean, `flutter test` green, `dart format` clean.
- Both states verified on web and an iOS simulator; Material look checked via `SPRINT_PLATFORM`.
- Domain tests cover pricing, use-case branching; widget tests cover both states and 3 widths.

## Constitution Check
I Clean Arch ✅ (domain/data/presentation, no infra in domain) · II Riverpod ✅ · III tests ✅ ·
IV feature module ✅ · V mobile patterns ✅ (`ListView`/sliver builders, const) · VI adaptive ✅ ·
VII platform-adaptive ✅ (shared controls only) · BR-04, BR-07 enforced in domain.
