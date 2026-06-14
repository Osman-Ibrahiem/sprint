# Feature Specification: Sprint Core Foundation

**Feature Branch**: `feature/core-foundation`

**Created**: 2026-06-14

**Status**: Draft

**Input**: "Create a spec for the core foundation setup of Sprint. This is NOT a user-facing
feature — it covers: Flutter project structure (Clean Architecture folders), Design token
implementation from our Claude Design system, Routing shell with go_router, Riverpod
initialization, Arabic (RTL) localization bootstrap. No user stories needed. Define done
criteria only."

> **Note**: This is a technical infrastructure spec, not a user-facing feature. There are
> no user stories. The "done when" criteria below replace acceptance scenarios. Individual
> feature specs depend on this foundation being in place.

---

## Requirements *(mandatory)*

### Functional Requirements

- **FR-001**: The project structure MUST enforce Clean Architecture with three separated
  layers per feature: domain (pure business logic, zero external dependencies), data
  (implementations and data sources), and presentation (UI and state). No layer may import
  from a layer it is not permitted to depend on.
- **FR-002**: All visual design tokens — colors, typography scale, spacing, border radii —
  MUST be sourced from the Claude Design system and exposed as a single theme object.
  Hardcoded color values, font sizes, or spacing literals anywhere in the codebase are a
  violation.
- **FR-003**: Navigation MUST be centralized in a routing shell that supports URL-based
  deep linking on web and named routes on mobile. No widget may perform navigation directly.
- **FR-004**: Application-wide state management MUST be initialized at startup via a
  dependency graph. All providers MUST be accessible from any widget in the tree without
  manual prop-drilling.
- **FR-005**: The UI runtime MUST operate in Arabic (RTL) by default. Every text string
  visible to end users MUST be externalized (not hardcoded in widget code). The localization
  system MUST be bootstrapped at app startup and support adding new languages without
  structural changes.
- **FR-006**: The app MUST compile and run on web, iOS, and Android from the same codebase
  with zero platform-specific workarounds in the foundation layer.
- **FR-007**: The codebase MUST pass static analysis with zero errors and zero warnings at
  the end of foundation setup.
- **FR-008**: The project MUST include a documented local setup procedure that allows a new
  developer to build and run the app in under 10 minutes.

### Key Entities

- **Theme**: A single source of truth for all design tokens (color palette, typography,
  spacing, shape). All feature UIs consume from this; none define their own.
- **AppRouter**: The centralized routing configuration mapping named routes to screens.
  All navigation transitions pass through it.
- **ProviderScope**: The root dependency container wrapping the entire widget tree,
  making all state providers available to all features.
- **L10n / ARB files**: The externalized string catalog powering Arabic UI text. Each
  UI-visible string has exactly one definition here.

---

## Success Criteria *(mandatory)*

> These criteria define "done" for the core foundation. They are verified by the development
> team, not end users, because this is an infrastructure milestone.

- **SC-001**: A new feature module can be added by creating its domain / data / presentation
  subdirectories only — no changes to the foundation layer are required.
- **SC-002**: Changing any design token value (e.g., the lime accent color) in one place
  propagates to the entire app with no other code changes.
- **SC-003**: Navigating to any registered route via URL (on web) or deep link (on mobile)
  works correctly from a cold app start.
- **SC-004**: The app launches and renders in Arabic RTL on all three platforms (web, iOS,
  Android) with zero English fallback text visible in the UI.
- **SC-005**: A new Arabic string can be added and displayed in the UI by editing only the
  ARB file and the widget that renders it — no structural changes needed.
- **SC-006**: `dart analyze` reports zero errors and zero warnings on the project.
- **SC-007**: A developer following only the setup documentation can run the app locally
  on their machine in under 10 minutes without verbal assistance.
- **SC-008**: All five foundation areas (project structure, design tokens, routing, state
  init, localization) have at least one passing smoke test (build + launch on each target
  platform) before the foundation is declared done.

---

## Assumptions

- The Claude Design system has already been defined and color/typography values are
  available for extraction. If design tokens are still in flux, this spec assumes they will
  be finalized before foundation implementation begins.
- "Arabic (RTL) by default" means the app ships with Arabic as its only locale for v1;
  multi-language support is a future concern but the localization architecture MUST support
  it without structural rewrites.
- The three target platforms (web, iOS, Android) are validated via manual smoke tests at
  foundation completion; automated E2E tests across all platforms are out of scope for this
  milestone.
- All subsequent feature specs assume this foundation is complete and stable before their
  implementation begins. The foundation is a hard prerequisite for all other feature branches.
- "Claude Design system" refers to the design specification produced by Claude Design
  (the design tool), not the Claude AI product. Design token values will be provided as
  part of the design handoff.