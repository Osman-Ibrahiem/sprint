# Implementation Plan: Home Screen UI (Guest and Booker)

**Branch**: `claude/home-screen-d508af` | **Date**: 2026-11-08 | **Spec**: [spec.md](spec.md)

**Input**: Feature specification from `/specs/006-home-screen/spec.md`

## Summary

A new feature module `features/home` replaces the placeholder `HomeShellScreen`. A small domain
(entities, `HomeRepository` interface, one use case) is fed by a mock data implementation; a
Riverpod-generated provider per session (`guest` | `booker`) drives two presentation states.
Guest is a limited discovery page; Booker adds greeting, next booking, discounted prices and
adaptive navigation (bottom bar / rail / extended rail). Layout follows the 005 size classes and
`PaneScope`; strings go through ARB. No auth, Supabase, booking or payment code.

## Technical Context

**Language/Version**: Dart ≥ 3.11 (Flutter SDK `^3.11.1`)

**Primary Dependencies**: flutter_riverpod ^3.5, riverpod_annotation ^4.0 (+ riverpod_generator), go_router ^18, freezed_annotation, intl / flutter_localizations (ARB in `assets/l10n`, output `lib/core/l10n`)

**Storage**: N/A (mock in-memory data)

**Testing**: flutter_test — domain unit tests, widget tests per state and width

**Target Platform**: Flutter web + iOS + Android (single codebase)

**Project Type**: mobile-app (Flutter)

**Performance Goals**: lazy sliver grid; 60 fps scrolling on a 4–N item list

**Constraints**: RTL Arabic default, Cairo font, tokens only (`core/theme`, `core/adaptive`), no new breakpoints, content scrolls and survives 200% text scale, usable from 320 dp

**Scale/Scope**: 1 route (two states), ~9 widgets, 1 use case, 1 mock repository, ~28 l10n keys

## Constitution Check

*GATE: passes before Phase 0; re-checked after Phase 1 design — still passes.*

1. **I Clean Architecture** ✅ — `features/home/{domain,data,presentation}`; domain is pure Dart (no Flutter, Supabase); presentation talks to domain interfaces through providers.
2. **II Riverpod** ✅ — `@riverpod` providers and a nav notifier; no `setState`.
3. **III Test-first core** ✅ — pricing rule, use case and mock repository tested before presentation work.
4. **IV Modularity** ✅ — self-contained feature; the only core imports are shared tokens, adaptive widgets, router constants and l10n.
5. **V Mobile patterns** ✅ — `const` widgets, `SliverGrid.builder`, pure builds.
6. **VI Adaptive-first** ✅ — grid columns and nav type come from size classes; `PaneScope` around the content pane; scrolls; safe areas.
7. **VII Platform-adaptive UI** ✅ — filled button and spinner from `core/presentation/widgets/adaptive/`; chrome icons are Material in v1 (deviation recorded below).
8. **BR-04** ✅ facility carries a booking mode; **BR-07** ✅ price computed in the domain, guests see prices but cannot book.

## Project Structure

### Documentation (this feature)

```text
specs/006-home-screen/
├── plan.md
├── research.md
├── data-model.md
├── quickstart.md
├── contracts/
│   └── widget-contracts.md
├── checklists/requirements.md
└── tasks.md             # /speckit-tasks
```

### Source Code (repository root)

```text
lib/features/home/
├── domain/
│   ├── entities/        # facility, facility_category, booking_mode, user_affiliation,
│   │                    # booker_profile, upcoming_booking, home_content
│   ├── home_session.dart
│   ├── repositories/home_repository.dart
│   └── usecases/get_home_content.dart
├── data/mock_home_repository.dart
└── presentation/
    ├── home_layout.dart
    ├── providers/home_providers.dart        # + generated .g.dart
    ├── screens/home_screen.dart
    └── widgets/         # home_top_bar, home_hero, home_greeting, upcoming_booking_card,
                         # facility_card, facilities_section, facility_labels,
                         # home_nav, home_status_views
lib/core/router/app_router.dart              # /home?session= → HomeScreen
assets/l10n/app_{ar,en}.arb                  # home* keys
test/features/home/{domain,presentation}/
```

**Structure Decision**: Flutter feature-first layout (template Option 3). The placeholder
`lib/core/presentation/screens/home_shell_screen.dart` is deleted.

## Complexity Tracking

| Deviation | Why | Simpler alternative rejected because |
|-----------|-----|--------------------------------------|
| Navigation chrome uses Material widgets on every platform | Shared adaptive nav control does not exist yet | Building a Cupertino tab bar now is out of scope; recorded for Home v2 |
| `NavType.drawer` rendered as an extended rail | Same control, fewer moving parts | A permanent drawer adds a second nav widget for no UX gain |
