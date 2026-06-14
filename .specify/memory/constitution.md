<!--
  Sync Impact Report
  ==================
  Version change: 1.0.0 → 1.1.0
  Modified principles: None
  Added sections:
    - "Domain Business Rules" (§ VI) — Sprint-specific invariants governing
      slot management, booking flows, ticketing, pricing, and asset control.
  Removed sections: None
  Templates requiring updates:
    - .specify/templates/plan-template.md ✅ aligned (Constitution Check gates
      match all 5 architecture principles; business rules are domain entities
      verified through existing principle I + III gates)
    - .specify/templates/spec-template.md ✅ aligned (no new mandatory sections
      required — business rules inform FR/entity wording, not template structure)
    - .specify/templates/tasks-template.md ✅ aligned (Domain → Data →
      Presentation order already enforced; business rule tasks fall naturally
      under domain-layer phases)
    - .specify/templates/checklist-template.md ✅ aligned (generic template,
      no specific changes needed)
  Follow-up TODOs:
    - TODO(RATIFICATION_DATE): Original adoption date unknown. Set when known.
-->

# Sprint Constitution

## Core Principles

### I. Clean Architecture & Layer Separation
Business logic MUST be fully isolated from UI and infrastructure concerns.
The codebase MUST follow strict layered architecture:
- **Domain layer** (entities, use cases, repository interfaces): Zero external dependencies. Pure Dart only.
- **Data layer** (repository implementations, data sources, DTOs, mappers): Depends only on Domain.
- **Presentation layer** (UI widgets, ViewModels/Controllers, pages): Depends only on Domain via injected interfaces.
- Dependencies MUST point inward — Presentation → Domain ← Data (no Presentation→Data leaks).
Rationale: Enforces testability, swapability of implementations, and framework-independent business rules.

### II. Riverpod State Management with MVVM/MVI
All UI state management MUST use Riverpod exclusively. Mixing setState, InheritedWidget,
or other state solutions alongside Riverpod is prohibited without explicit constitutional exception.
- ViewModels (MVVM) or ViewModels/Intents (MVI) MUST be implemented as Riverpod providers
  (`StateNotifierProvider`, `AsyncNotifierProvider`, `NotifierProvider`, or `StreamProvider`).
- Business logic MUST NOT live in Widgets — widgets read providers only.
- MVI pattern: use sealed/freezed classes for state and intents/events.
- Rationale: Riverpod provides compile-safe, testable, and composable state management aligned
  with Clean Architecture's dependency inversion.

### III. Test-First & Fully Testable Core (NON-NEGOTIABLE)
Every domain layer component MUST have a corresponding unit test written before or alongside
implementation. Tests MUST cover:
- Domain entities and value objects
- Use case/interactor logic (all success and error branches)
- Repository contract behavior (via mock implementations)
- ViewModel/Notifier state transitions
Data layer tests (repository impls with real/fake data sources) and widget tests are strongly
encouraged but not governed by this principle — use pragmatic judgment.
Rationale: Ensures business rules are verified independently of frameworks and UI.

### IV. Modular Design & Clear Abstractions
The project MUST be organized into highly modular, feature-first packages:
- Each feature or bounded context SHOULD be a self-contained module with its own
  domain/data/presentation layers.
- Shared code (core/commons) MUST have a clearly documented purpose — no "utility" dumping grounds.
- Abstraction boundaries MUST be explicit: repository interfaces in domain, implementations in data.
- Circular dependencies between modules are strictly prohibited.
Rationale: Modules can be developed, tested, and reasoned about independently.

### V. Flutter Mobile-Optimized Patterns
- Widgets MUST be stateless where possible; stateful widgets are reserved for lifecycle-scoped
  concerns (e.g., animation controllers, focus nodes).
- Build methods MUST be pure: no side effects, no business logic, only widget composition.
- Platform channels and native code MUST be encapsulated behind repository interfaces in the
  domain layer — never accessed directly from presentation.
- Deep linking, navigation, and routing MUST be centralized (e.g., GoRouter) and not scattered
  across widgets.
- Performance-sensitive operations (large lists, images, animations) MUST use `const` constructors,
  `ListView.builder`, `ImageCache`, and `RepaintBoundary` as appropriate.
Rationale: Ensures the app remains responsive, maintainable, and idiomatic on mobile platforms.

## Domain Business Rules

These invariants are non-negotiable product constraints. Every use case, entity, and repository
contract MUST enforce them. Violations in the domain layer are constitution violations.

### BR-01 · Slot Capacity Cap & Auto-Close
Every bookable time slot MUST carry a `capacity` integer (set per facility/lane).
- When `confirmedBookings >= capacity`, the slot status MUST transition to `SlotStatus.full`
  atomically (single DB transaction or optimistic-lock check).
- A full slot MUST be invisible or non-selectable in the booking UI; it MUST NOT be bookable
  via the API even if the UI is bypassed.
- Capacity checks MUST be re-evaluated server-side at payment confirmation, not only at
  slot-selection time.

### BR-02 · Waitlist & Fair-Queue on Cancellation
When a confirmed booking is cancelled:
1. The slot's `confirmedBookings` count MUST decrement atomically.
2. If a waitlist queue exists for that slot, the **head** of the queue MUST receive a
   time-bounded offer (configurable, default 30 minutes) to confirm their booking.
3. If the offer expires without confirmation, the next queue member MUST receive the offer.
4. No manual admin intervention is required or permitted to skip queue order.
Rationale: Enforces fairness and equal opportunity — a core doctoral dissertation requirement.

### BR-03 · 7-Day Booking Window with Real-Time Slot Disabling
- The booking window is exactly `[today, today + 6 days]` inclusive (7 calendar days).
- Slots whose `startTime` is in the past MUST be disabled in real time — the domain MUST
  reject bookings where `slot.startTime <= DateTime.now()` regardless of UI state.
- The presentation layer MUST refresh slot availability on screen focus to prevent stale state.

### BR-04 · Two Separate Booking Flows (Never Merged)
Two flows exist and MUST be implemented as distinct use cases with no shared entry point:
- **Free-booking flow**: User selects facility → selects day → selects available hour range.
  No trainer involvement. Use case: `CreateFreeBookingUseCase`.
- **Coached flow**: User selects trainer → views trainer's available 1-hour slots → books one.
  Slot availability is derived from the trainer's schedule, not facility-wide availability.
  Use case: `CreateCoachedBookingUseCase`.
Merging these flows into a conditional branch within one use case is prohibited.

### BR-05 · QR Ticket as Physical Entry Pass
A QR ticket is the **sole authorized entry mechanism** — it is not optional attendance evidence.
- A ticket MUST be issued only after payment is fully confirmed (no pending-payment tickets).
- The QR payload MUST encode: `bookingId`, `userId`, `slotId`, `facilityId`, and an
  HMAC signature to prevent forgery.
- Entry MUST be denied when the QR is invalid, expired (slot time passed), already scanned,
  or belongs to a different facility.
- Staff/trainer scan is the authoritative gate — manual override requires explicit admin authorization logged as an audit event.

### BR-06 · Asset & Equipment Management is Staff-Only
The asset/equipment management feature (`عهدة`) MUST be guarded at every layer:
- Domain: `AssetManagementUseCase` MUST require a `UserRole.staff` or higher permission check.
- Data: Repository queries MUST include a server-side role filter (RLS policy or equivalent).
- Presentation: Routes MUST redirect non-staff users to an unauthorized screen — no client-side
  visibility toggle is sufficient on its own.
No booker or trainer role may read, write, or report on asset records.

### BR-07 · Automatic Pricing by Account Type
Pricing MUST be computed by the domain layer — never entered manually by staff or users.
- `UserAffiliation.universityAffiliated` → discounted price (set in facility's price table).
- `UserAffiliation.external` → full price.
- Guest (unauthenticated) users MUST see prices but cannot book.
- Price applied at booking creation MUST be stored immutably on the `Booking` entity;
  subsequent affiliation changes MUST NOT retroactively alter confirmed booking prices.

## Technology Stack & Architecture Constraints

- **Language**: Dart (matching Flutter SDK constraint in pubspec.yaml).
- **State Management**: Riverpod (flutter_riverpod, riverpod_annotation).
- **Code Generation**: freezed (data classes/sealed unions), json_serializable (DTOs),
  riverpod_generator (provider code-gen).
- **Navigation**: GoRouter (declarative, deep-link capable).
- **Dependency Injection**: Riverpod's provider graph (no Service Locator or DI containers outside
  the Riverpod ecosystem).
- **Testing**: flutter_test (unit/widget), mockito/mocktail (mocks), integration_test (E2E).
- **Static Analysis**: Dart's built-in analyzer + flutter_lints (strict rule set).
- **Formatting**: `dart format` (line length 80 chars preferred).
Rationale: Constraining the tech stack avoids architectural drift and ensures all contributors
follow the same conventions.

## Development Workflow & Quality Gates

1. **Pre-implementation**: Feature spec approved, plan aligned with constitution principles.
2. **Implementation order**: Domain layer → Data layer → Presentation layer (inward out).
3. **Testing gate**: All domain unit tests MUST pass before presentation layer work begins.
4. **Code review gate**: Every PR MUST verify Clean Architecture layer compliance —
   no infrastructure imports in domain, no business logic in widgets.
5. **Static analysis gate**: `dart analyze` MUST pass with zero errors before merge.
6. **Formatting gate**: `dart format --set-exit-if-changed .` MUST pass before merge.
Rationale: Layered implementation prevents coupling leaks; quality gates catch violations early.

## Governance

This constitution supersedes all ad-hoc development practices within the Sprint project.
Amendments require:
1. A documented proposal (PR or spec) describing the change and rationale.
2. Explicit approval from the project maintainer or lead.
3. A migration plan for existing code that would fall out of compliance.
4. A version bump per semantic versioning rules defined below.

**Versioning policy**:
- MAJOR: Backward-incompatible governance changes, principle removals or redefinitions.
- MINOR: New principles or materially expanded guidance.
- PATCH: Clarifications, wording refinements, typo fixes.

**Compliance review**: Every feature spec and implementation plan MUST include a
"Constitution Check" section verifying alignment. Complexity deviations must be documented
and justified.

**Version**: 1.1.0 | **Ratified**: TODO(RATIFICATION_DATE) | **Last Amended**: 2026-06-14
