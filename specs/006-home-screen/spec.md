# Feature Specification: Home Screen UI (Guest and Booker)

**Feature Branch**: `claude/home-screen-d508af` (merges into `develop`, never `main`)

**Created**: 2026-11-08

**Status**: Draft

**Input**: User description: "Home screen for Sprint in two states: guest (not logged in, limited discovery UI with facility list and visible prices, every booking entry point leads to login) and logged-in Booker (greeting, next booking or empty state, facility list with price by account type, adaptive navigation bar/rail). UI only with mock data; no auth logic."

> Builds on [004-login-screen-ui](../004-login-screen-ui/spec.md) and
> [005-adaptive-platform-ui](../005-adaptive-platform-ui/spec.md) (size classes, platform look).
> No canonical Figma exists for Home; this spec is the design of record until one does.
> Product decisions come from `docs/project-context/product-and-ux.md`: Home is state-based
> (UX correction 1) and has no quick-action buttons that duplicate the navigation (UX correction 2).

## User Scenarios & Testing *(mandatory)*

### User Story 1 — Guest discovers facilities (Priority: P1)

A visitor who is not signed in opens the app and lands on a limited Home. They see the Sprint
brand, a short pitch with a sign-in call to action, and the list of facilities with their prices.
They can browse but cannot book: every booking entry point takes them to the login screen.

**Why this priority**: it is the first thing every new visitor sees and it must explain the value
and funnel people into sign-in. It is also the smallest shippable Home.

**Independent Test**: open Home with no signed-in user; confirm the guest layout, the full prices,
and that every call to action leads to login.

**Acceptance Scenarios**:

1. **Given** a visitor who is not signed in, **When** Home loads, **Then** they see the brand with a sign-in button, a pitch with a sign-in call to action, and a list of facilities; they do not see a greeting, a booking card, or any navigation bar.
2. **Given** a facility in the list, **When** it is shown to a guest, **Then** it displays name, category, how it is booked (free booking or with a trainer) and the full hourly price.
3. **Given** the guest Home, **When** the visitor taps the sign-in button, the pitch button, or a facility, **Then** the login screen opens.

---

### User Story 2 — Booker sees a personalised Home (Priority: P1)

A signed-in Booker sees a greeting by name, their next booking (or an invitation to make one),
the facility list priced for their account type, and the app navigation.

**Why this priority**: it is the everyday home of the main user role and carries the automatic
pricing rule that the dissertation depends on.

**Independent Test**: open Home as a university-affiliated Booker and as an external Booker;
confirm greeting, booking card or empty state, and each price tier.

**Acceptance Scenarios**:

1. **Given** a signed-in Booker with an upcoming booking, **When** Home loads, **Then** a card shows the facility, the day and time, and the duration.
2. **Given** a signed-in Booker with no upcoming booking, **When** Home loads, **Then** an empty-state card invites them to book their first session.
3. **Given** a university-affiliated Booker, **When** facilities are listed, **Then** each shows the discounted price with the full price struck through.
4. **Given** an external Booker, **When** facilities are listed, **Then** each shows the full price only.
5. **Given** a signed-in Booker, **When** Home loads, **Then** navigation offers four destinations (Home, My bookings, Notifications, Profile); choosing any other than Home shows a "coming soon" message; no shortcut buttons duplicate the navigation.

---

### User Story 3 — Home adapts to the window (Priority: P2)

On a phone, Home is a single column with a bottom navigation bar. On larger windows it uses a
side navigation rail and a multi-column facility grid; on the largest windows the rail is
extended with labels. The guest Home never shows navigation. Content stays readable and inside
the safe areas at every width from 320 dp.

**Why this priority**: the app ships on phones, tablets, foldables and the web from one codebase.

**Independent Test**: open both states at 320, 360, 800, 1000 and 1400 dp wide and confirm
navigation type and column count with no overflow.

**Acceptance Scenarios**:

1. **Given** a window narrower than 600 dp, **When** a Booker views Home, **Then** there is one facility column and a bottom bar.
2. **Given** wider windows, **When** a Booker views Home, **Then** navigation moves to the side and the facility grid shows more columns as the content area grows.
3. **Given** any width from 320 dp, **When** either state is shown, **Then** nothing overflows and content scrolls.

---

### User Story 4 — Loading and failure (Priority: P3)

While Home content loads the user sees a loading indicator. If loading fails they see a clear
Arabic message and a retry button.

**Why this priority**: graceful states make the later real backend safe to connect.

**Independent Test**: simulate a slow load and a failed load; confirm the indicator, the message,
and that retry reloads the content.

**Acceptance Scenarios**:

1. **Given** content is loading, **When** Home is shown, **Then** a platform-appropriate loading indicator is visible.
2. **Given** loading failed, **When** Home is shown, **Then** an error message and a retry button appear, and tapping retry loads the content again.

---

### Edge Cases

- A facility name that is very long is shortened with an ellipsis without breaking the card.
- The user's text size is increased to 200%: cards grow and nothing is clipped.
- A Booker who is not university-affiliated never sees a discounted price.
- A guest never sees personal data (name, bookings), even if the data source returns it.
- The facility list is empty: the section shows no cards and the screen stays usable.
- Landscape or short windows: the page scrolls and the navigation stays reachable.

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: Home MUST present two states, guest and signed-in Booker, selected from the session; until real sign-in exists the session is chosen through the page address (default guest).
- **FR-002**: Guest Home MUST show the brand, a sign-in button, a pitch with a sign-in call to action, and the facility list; it MUST NOT show a greeting, booking card or navigation.
- **FR-003**: Every booking entry point on guest Home (sign-in button, pitch button, facility card) MUST open the login screen.
- **FR-004**: Each facility MUST show its name, category, booking mode (free booking or coached; the two flows are never merged) and an hourly price in EGP.
- **FR-005**: The price shown MUST be computed automatically from the account type: guests and external visitors see the full price, university-affiliated Bookers see the discounted price with the full price struck through. Users and staff never enter prices.
- **FR-006**: Booker Home MUST show a greeting with the Booker's name and either the next booking (facility, day and time, duration) or an empty-state invitation.
- **FR-007**: Booker Home MUST offer four navigation destinations (Home, My bookings, Notifications, Profile); destinations other than Home MUST show a "coming soon" message. No quick-action buttons may duplicate the navigation.
- **FR-008**: Navigation type MUST follow the window size class (bottom bar, side rail, extended rail) using the shared adaptive rules; Home MUST NOT introduce its own breakpoints.
- **FR-009**: The facility grid MUST show 1, 2 or 3 columns according to the width of the content area, and MUST NOT overflow from 320 dp wide.
- **FR-010**: Home MUST show a loading indicator while content loads, and an error message with a retry button when loading fails.
- **FR-011**: The screen MUST be Arabic and right-to-left by default, with all text externalised for translation, and MUST use only the shared design tokens (colors, spacing, radii, type) and platform-adaptive controls.
- **FR-012**: Facility cards MUST be readable by screen readers as a single item (name, booking mode, price); decorative art MUST be hidden from them.
- **FR-013**: Content MUST come from a replaceable data source so a real backend can be connected later without changing the screen; for now it is mock data.

### Key Entities

- **Facility**: a bookable place (pool, gym, football pitch, basketball court) with a name, category, booking mode (free or coached), full price and discounted price per hour.
- **Booker profile**: display name and account type (university-affiliated or external).
- **Upcoming booking**: facility name, start time, duration in hours.
- **Home content**: the facilities, plus (for a Booker only) the profile and the next booking.

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: A visitor can identify what Sprint offers, see prices, and reach the sign-in screen within 2 taps from opening Home.
- **SC-002**: 100% of prices shown match the viewer's account type (full for guest/external, discounted for university-affiliated).
- **SC-003**: Both states render with no overflow at 320, 360, 800, 1000 and 1400 dp wide.
- **SC-004**: Both states are verified on web and on a phone simulator, and the full automated test suite and static analysis pass.
- **SC-005**: No hardcoded colors, spacing values or user-facing strings exist in the Home code.

## Assumptions

- Real authentication and the real backend do not exist yet; session and data are mock (per the UI-first approach).
- Facility names, prices and the booker's name are placeholders until the backend exists; the 50% university discount is unconfirmed.
- There are no facility photos yet; a branded placeholder art tile is shown instead.
- The Register screen, booking flow, payment, and the My bookings / Notifications / Profile screens are separate features.
- Foldable hinge-aware layout is deferred; content scrolls and stays inside safe areas.
- Prices are whole EGP per hour.
- Constitution check: Clean Architecture layers, Riverpod, test-first domain, adaptive-first layout, platform-adaptive UI, BR-04 (separate flows) and BR-07 (automatic pricing) all apply and are verified in the plan.
