# Feature Specification: Sprint Platform — Master Spec

**Feature Branch**: `feature/speckit-constitution`

**Created**: 2026-06-14

**Status**: Draft

**Input**: User description: "Create a high-level project spec for Sprint covering all four
features (Smart Booking, Trainer Management, Digital Payment & QR, Asset Management) and three
user roles. This is a master spec — individual feature specs will be created separately per
feature branch. Keep it concise, no implementation details."

> **Note**: This is the master platform specification. It establishes the full scope, user
> roles, and success criteria for Sprint. Individual feature branches will have their own
> detailed specs derived from this document.

---

## User Scenarios & Testing *(mandatory)*

### User Story 1 — Booker Books a Facility Slot (Priority: P1)

A university student or external visitor browses available sports facilities, selects an
open time slot within the 7-day window, pays digitally, and receives a QR ticket granting
physical entry. University-affiliated users automatically receive a discounted rate; external
visitors pay full price. No cash changes hands.

**Why this priority**: This is the core transaction the entire platform exists to support.
Without a working booking + payment + entry flow, no other feature delivers value.

**Independent Test**: A new booker account can browse facilities, complete a booking, pay,
receive a QR ticket, and have that ticket accepted at entry — end-to-end, without any other
feature being live.

**Acceptance Scenarios**:

1. **Given** a logged-in university-affiliated booker, **When** they browse facilities and
   select an available slot within the 7-day window, **Then** they see a discounted price
   automatically applied and can complete payment.
2. **Given** a fully paid booking, **When** the booker opens their ticket, **Then** they
   see a valid QR code encoding their booking details.
3. **Given** a facility staff member scans the QR at entry, **When** the QR is valid and
   the slot time is current, **Then** entry is granted; scanning again or after the slot
   denies entry.
4. **Given** a slot that has reached capacity, **When** a booker attempts to select it,
   **Then** the slot is shown as unavailable and cannot be booked.
5. **Given** a guest (not logged in), **When** they browse the home screen, **Then** they
   see a limited view of facilities and prices but cannot book.

---

### User Story 2 — Booker Books a Coached Session (Priority: P2)

A booker who wants professional coaching selects a trainer, views that trainer's available
1-hour slots, books one, pays, and receives a QR ticket. This flow is entirely separate from
free-booking; slot availability is driven by the trainer's schedule.

**Why this priority**: Coached sessions are a distinct revenue stream and fairness domain —
they involve trainer availability and ratings, not just facility capacity.

**Independent Test**: A booker can complete a coached booking (trainer → slot → pay → QR)
without the free-booking flow being live, and without any confusion between the two paths.

**Acceptance Scenarios**:

1. **Given** a logged-in booker, **When** they enter the coached-session flow and select a
   trainer, **Then** they see only that trainer's available 1-hour slots within the 7-day
   window.
2. **Given** a slot time that has already passed, **When** any booker tries to book it,
   **Then** the system rejects the booking regardless of how the request was submitted.
3. **Given** a completed coached session, **When** the session ends, **Then** the booker
   is prompted to rate the trainer (1–5 stars).

---

### User Story 3 — Booker Cancels and Waitlist Advances (Priority: P3)

When a booker cancels a confirmed booking, the next person in the waitlist queue for that
slot receives a time-bounded offer to claim the slot. Queue order is strictly first-in,
first-out and cannot be altered by admin intervention.

**Why this priority**: Fairness of access is a dissertation-level governance requirement.
The waitlist enforces equal opportunity and prevents slot hoarding.

**Independent Test**: Create two booker accounts, fill a slot to capacity with one, add the
other to waitlist, cancel the first booking, and verify the second receives the slot offer
within the configured offer window.

**Acceptance Scenarios**:

1. **Given** a fully booked slot with a waitlist, **When** a confirmed booking is cancelled,
   **Then** the first person in the queue receives a timed offer (default 30 minutes).
2. **Given** a timed offer that expires without acceptance, **When** the timer runs out,
   **Then** the offer passes to the next queue member automatically.
3. **Given** no waitlist exists for a cancelled slot, **When** the booking is cancelled,
   **Then** the slot simply reopens for any booker to claim.

---

### User Story 4 — Admin Manages Facilities and Oversight (Priority: P4)

A facility manager (or dean/ministry rep with higher permissions) configures facilities,
sets slot capacities and prices, views booking reports, and monitors real-time occupancy.
The admin interface is shared across all admin sub-roles with graduated permissions.

**Why this priority**: Admins configure the system that bookers use; without admin controls
the platform cannot be set up or monitored for compliance.

**Independent Test**: An admin account can create a facility, set its capacity and prices,
and see bookings appear in the dashboard — independently of trainer or asset management.

**Acceptance Scenarios**:

1. **Given** a facility manager account, **When** they create a new facility with name,
   photos, capacity, and price tiers, **Then** the facility appears immediately in the
   booker's browse view.
2. **Given** a dean-level admin, **When** they view the occupancy report, **Then** they see
   bookings aggregated across all facilities they oversee.
3. **Given** a ministry-rep admin, **When** they access the platform, **Then** they have
   read-only visibility across all facilities with no ability to modify configuration.

---

### User Story 5 — Staff Manages Asset Inventory (Priority: P5)

A staff member (facility-level role) scans or photographs sports equipment to create and
update inventory records. Damage reports are filed in real time. Bookers and trainers have
no visibility into or access to this feature.

**Why this priority**: Asset management protects public property and supports financial
accountability — a regulatory requirement for university facilities.

**Independent Test**: A staff account can add an equipment item, update its condition, and
file a damage report — without any booking or trainer flow being live, and with no access
possible from a booker or trainer account.

**Acceptance Scenarios**:

1. **Given** a logged-in staff member, **When** they scan or photograph an equipment item,
   **Then** a new inventory record is created with item identity, condition, and timestamp.
2. **Given** an existing inventory item, **When** a staff member files a damage report,
   **Then** the report is recorded and visible to admin-level users.
3. **Given** a booker or trainer account, **When** they attempt to access asset management,
   **Then** they are redirected to an unauthorized screen with no data exposed.

---

### Edge Cases

- What happens when a booker's payment times out mid-flow? The slot reservation MUST be
  released and returned to the available pool (or waitlist queue advanced) within a
  configurable hold window.
- What happens if two bookers simultaneously select the last available slot? Server-side
  atomic capacity check ensures only one succeeds; the other receives a "slot just filled"
  error and is offered the waitlist.
- What if a trainer cancels their availability after a coached booking is confirmed? The
  booker MUST be notified and refunded; the slot MUST be removed from the schedule.
- What happens when the QR scanner is offline? Entry decision falls back to admin manual
  authorization, logged as an audit event (per BR-05).

---

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: System MUST support three distinct user roles — Booker, Trainer, and Admin —
  each with non-overlapping permissions enforced at every access point.
- **FR-002**: System MUST provide two entirely separate booking flows: free-booking
  (facility-based) and coached-session (trainer-based), with no shared entry point.
- **FR-003**: System MUST enforce a strict 7-day booking window and reject any booking
  attempt for a past slot, regardless of how the request arrives.
- **FR-004**: System MUST enforce per-slot capacity caps and transition slots to unavailable
  status atomically when capacity is reached.
- **FR-005**: System MUST maintain a fair FIFO waitlist per slot and automatically advance
  the queue when a booking is cancelled.
- **FR-006**: System MUST apply pricing automatically based on account affiliation
  (university-affiliated → discounted, external → full price); no manual price override
  by staff is permitted.
- **FR-007**: System MUST accept payment via card or InstaPay only; cash payment is
  explicitly prohibited at every touchpoint.
- **FR-008**: System MUST issue a QR-encoded entry ticket only after payment is fully
  confirmed, with the QR serving as the sole physical entry authorization.
- **FR-009**: System MUST support trainer profiles with availability schedules and aggregate
  ratings derived from post-session booker reviews.
- **FR-010**: System MUST restrict asset/equipment management to staff-level accounts and
  above; access MUST be denied at every layer (not just UI).
- **FR-011**: System MUST support all three admin sub-roles (facility manager, dean,
  ministry rep) with graduated read/write permissions on a shared interface.
- **FR-012**: System MUST present the full UI in Arabic (RTL) with no English-only fallback
  for end users.

### Key Entities

- **Facility**: A bookable sports venue (pool, gym, pitch…); has name, photos, capacity
  per slot, and price tiers by affiliation.
- **Slot**: A time block within a facility (or trainer schedule); has start/end time,
  capacity, confirmed count, status (available / full / past), and waitlist.
- **Booking**: A confirmed reservation linking a Booker to a Slot; holds the price applied
  at creation time immutably.
- **QR Ticket**: An entry pass issued post-payment; encodes booking identity and an
  integrity signature.
- **Trainer**: A user with a coached-session schedule, rating, and availability calendar.
- **WaitlistEntry**: A FIFO queue record linking a Booker to a Slot with an offer-expiry
  timestamp.
- **AssetRecord**: An inventory item with identity, condition history, and damage reports;
  visible only to staff+.
- **User**: Has role (Booker / Trainer / Admin / Staff), affiliation (university / external),
  and authentication identity.

---

## Success Criteria *(mandatory)*

### Measurable Outcomes

- **SC-001**: A booker can complete the full journey (browse → select slot → pay → receive
  QR ticket) in under 3 minutes from a cold start.
- **SC-002**: A cancelled booking results in the next waitlist member receiving their offer
  within 60 seconds, without any admin action.
- **SC-003**: Zero cash transactions occur for any facility booking or coached session — all
  payments are captured digitally.
- **SC-004**: Staff can log a new equipment item or damage report in under 2 minutes,
  including photo capture.
- **SC-005**: 100% of entry attempts are gated by QR scan; manual entry without a valid QR
  is recorded as an audit event, not silently permitted.
- **SC-006**: University-affiliated price discounts are applied automatically with 100%
  accuracy — no miscategorized pricing incidents.
- **SC-007**: Admin occupancy reports reflect real-time booking data with no more than
  30-second lag.

---

## Assumptions

- All users (Bookers, Trainers, Admins, Staff) authenticate via the same identity system;
  role assignment is managed post-authentication.
- University affiliation is determined at registration or via institutional SSO; the system
  does not re-verify affiliation on every booking.
- Tanta University sports facilities have reliable internet connectivity for QR scanning;
  offline fallback is a degraded-mode exception (audit-logged), not the primary flow.
- Payment providers (card / InstaPay) supply an event callback confirming payment success
  before the ticket is issued.
- Trainer schedule management (creating/editing availability) is performed by the trainer
  themselves, not by admin.
- Individual feature specs (Smart Booking, Trainer Management, Digital Payment & QR, Asset
  Management) will each have their own detailed spec created on separate feature branches.
  This master spec sets the scope boundary; each feature spec refines acceptance criteria
  and edge cases for its domain.
- The platform targets both web and mobile (iOS + Android) from a single codebase; all
  features are available on all platforms unless explicitly noted otherwise.
