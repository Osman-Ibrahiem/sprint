# Implementation Plan: Home Screen UI

**Spec**: [spec.md](spec.md) · **Branch**: `claude/home-screen-d508af` → PR into `develop`

## Summary
New feature module `lib/features/home/` with a small domain (entities, repository interface,
one use case), a mock data implementation, and a presentation layer with a `@riverpod` view
model per session. `/home` route builds `HomeScreen(session)`. Replaces the placeholder
`HomeShellScreen`.

## Technical Context
Dart ≥ 3.11, Flutter, flutter_riverpod 3 + riverpod_annotation 4 + generator, go_router 18,
freezed 4, intl/ARB (`assets/l10n`, output `lib/core/l10n`). Tests: flutter_test.
Adaptive foundation from 005: `SizeClass`, `AdaptiveTokens`, `PaneScope`, `AppPlatform`,
`AdaptiveFilledButton`, `AdaptiveSpinner`, `BoltMark`.

## Constitution Check
All gates pass (see spec). No complexity deviations.

## Structure
```text
lib/features/home/
├── domain/
│   ├── entities/ {facility, facility_category, booking_mode, user_affiliation,
│   │              booker_profile, upcoming_booking, home_content}.dart
│   ├── home_session.dart
│   ├── repositories/home_repository.dart
│   └── usecases/get_home_content.dart
├── data/mock_home_repository.dart
└── presentation/
    ├── home_layout.dart
    ├── providers/ home_providers.dart (+ .g.dart), home_nav_notifier.dart
    ├── screens/ home_screen.dart
    └── widgets/ home_top_bar, home_hero, upcoming_booking_card, facility_card,
                 facilities_section, home_nav, home_error_view, coming_soon_view
test/features/home/ domain/ + presentation/
specs/006-home-screen/
```

## Decisions
1. **Session source**: route query `?session=booker|guest` (default guest) → `HomeSession`. Keeps state out of global mock singletons; real auth later replaces the router param with an auth provider without touching widgets.
2. **Nav**: `NavigationBar` / `NavigationRail` / permanent `NavigationDrawer` styled with tokens (Material widgets, themed lime/green); the platform look of chrome stays Material-based in v1 (Cupertino tab bar deferred, recorded below). Selected index in `HomeNavNotifier` (Riverpod).
3. **Prices** in whole EGP per hour (`int`); formatted via ARB placeholder.
4. **Facility art**: gradient tile + category icon until photos exist.
5. **Grid**: `SliverGrid` with `SliverGridDelegateWithFixedCrossAxisCount` from pane columns; card height by fixed `mainAxisExtent` token from `home_layout.dart`.
6. **Hinge**: no split; content scrolls inside `SafeArea`.

## Deviations / open
- No Figma: visual design is Claude-authored, to be reviewed by owner.
- Cupertino-style tab bar on Apple deferred.
