# Tasks: Home Screen UI (Guest and Booker)

**Input**: Design documents from `specs/006-home-screen/`
**Prerequisites**: plan.md ✅ spec.md ✅ research.md ✅ data-model.md ✅ contracts/widget-contracts.md ✅ quickstart.md ✅
**Tests**: Included (constitution III: domain tests first; widget tests per state and width).
**Organization**: by user story. Order inside a story: domain → data → presentation.

## Format: `[ID] [P?] [Story?] Description with file path`

---

## Phase 1: Setup

- [x] T001 [P] Add the `home*` keys (guest hero, greeting, upcoming booking with date/time/plural duration, prices, booking-mode and category labels, facility semantic label, nav labels, coming soon, error, retry) to `assets/l10n/app_ar.arb`
- [x] T002 [P] Add the matching English `home*` keys to `assets/l10n/app_en.arb`
- [x] T003 Run `flutter gen-l10n` to regenerate `lib/core/l10n/app_localizations*.dart` (after T001 and T002)

---

## Phase 2: Foundational (blocks all user stories)

**⚠️ No presentation work starts before T008 passes.**

- [x] T004 [P] Create enums in `lib/features/home/domain/entities/` (`facility_category.dart`, `booking_mode.dart`, `user_affiliation.dart`) and `lib/features/home/domain/home_session.dart` with `HomeSession.parse`
- [x] T005 [P] Create `facility.dart`, `booker_profile.dart`, `upcoming_booking.dart`, `home_content.dart` in `lib/features/home/domain/entities/` (`Facility.priceFor`, `isDiscountedFor`; `HomeContent.isGuest`, `affiliation`)
- [x] T006 Create `lib/features/home/domain/repositories/home_repository.dart` and `lib/features/home/domain/usecases/get_home_content.dart` (guest never keeps profile or booking)
- [x] T007 Create `lib/features/home/data/mock_home_repository.dart` (4 facilities mixing free and coached, booker profile, optional upcoming booking, configurable latency and affiliation)
- [x] T008 Domain tests in `test/features/home/domain/home_domain_test.dart`: `priceFor` for guest/external/affiliated, `HomeSession.parse`, use case for guest and booker, guest never receives personal data, both booking modes present in mock data
- [x] T009 Create `lib/features/home/presentation/home_layout.dart` (layout constants, `columnsFor(SizeClass)`, `cardExtent(TextScaler)`)
- [x] T010 Create `lib/features/home/presentation/providers/home_providers.dart` (`homeRepository`, `getHomeContent`, `homeContent(session)`, `HomeDestination`, `HomeNav` notifier) and run `dart run build_runner build --delete-conflicting-outputs`

**Checkpoint**: domain tests pass; providers generated; `flutter analyze` clean.

---

## Phase 3: User Story 1 — Guest discovers facilities (P1) 🎯 MVP

**Goal**: limited Home for visitors; every booking entry point goes to login.
**Independent test**: open `/home`; guest layout with full prices; all CTAs → `/login`.

- [x] T011 [P] [US1] `lib/features/home/presentation/widgets/facility_labels.dart` (icon and label mappings for category and booking mode)
- [x] T012 [P] [US1] `lib/features/home/presentation/widgets/facility_card.dart` (art tile, badge, name, category, price, single semantic node)
- [x] T013 [P] [US1] `lib/features/home/presentation/widgets/facilities_section.dart` (title + sliver grid; guest tap → `/login`)
- [x] T014 [P] [US1] `lib/features/home/presentation/widgets/home_top_bar.dart` and `home_hero.dart` (brand, sign-in, pitch button → `/login`)
- [x] T015 [US1] `lib/features/home/presentation/screens/home_screen.dart` guest branch; update `lib/core/router/app_router.dart` so `/home?session=` builds `HomeScreen`; delete `lib/core/presentation/screens/home_shell_screen.dart`; regenerate router
- [x] T016 [US1] Widget tests in `test/features/home/presentation/home_screen_test.dart`: guest shows hero, full prices, no greeting, no navigation; top-bar button, hero button and card each open login

---

## Phase 4: User Story 2 — Booker sees a personalised Home (P1)

**Goal**: greeting, next booking or empty state, tier price, navigation.
**Independent test**: `/home?session=booker` as affiliated and as external Booker.

- [x] T017 [P] [US2] `lib/features/home/presentation/widgets/home_greeting.dart` and `upcoming_booking_card.dart` (booking details or empty state)
- [x] T018 [P] [US2] `lib/features/home/presentation/widgets/home_nav.dart` (4 destinations: bottom bar and rail, extended rail for `NavType.drawer`) and `ComingSoonView` in `home_status_views.dart`
- [x] T019 [US2] Booker shell in `home_screen.dart` (greeting + booking card + facilities, nav selected via `HomeNav`, non-Home → coming soon)
- [x] T020 [US2] Widget tests: greeting and booking card, empty state, discounted price with struck-through original, external sees full price only, 4 destinations, other destination shows coming soon and hides facilities

---

## Phase 5: User Story 3 — Adapts to the window (P2)

**Goal**: nav type and columns follow size classes; no overflow from 320 dp.
**Independent test**: both states at 320, 360, 800, 1000, 1400 dp.

- [x] T021 [US3] Ensure `PaneScope` wraps each content pane, content capped at `maxContentWidth`, safe areas respected (`home_screen.dart`)
- [x] T022 [US3] Widget tests: `columnsFor` per class; bottom bar at 360; rail with 2 columns at 800; 3 columns at 1000 and 1400; extended rail at 1400; no overflow at 320 for guest and booker

---

## Phase 6: User Story 4 — Loading and failure (P3)

**Goal**: loading indicator, error message with retry.
**Independent test**: slow and failed loads.

- [x] T023 [US4] `lib/features/home/presentation/widgets/home_status_views.dart` (`HomeLoadingView`, `HomeErrorView`) wired into `home_screen.dart` (retry invalidates the provider)
- [x] T024 [US4] Widget test: failing provider shows the message; tapping retry shows the facilities

---

## Phase 7: Polish and delivery

- [x] T025 `dart format --set-exit-if-changed lib test`, `flutter analyze` (zero issues), `flutter test` (all green)
- [x] T026 Verify per `quickstart.md`: web release build (guest at phone width, booker at desktop width) and an iOS simulator with `--route "/home?session=booker"`; note anything not checked (Android, Material look)
- [x] T027 Update `docs/project-context/status.md`; push and open a PR into `develop` (never `main`)

---

## Dependencies and order

- Setup (T001–T003) → Foundational (T004–T010) → US1 → US2 → US3 → US4 → Polish.
- US2 reuses US1's card and grid; US3 and US4 modify `home_screen.dart` after US1/US2.
- Parallel: T001‖T002; T004‖T005; T011‖T012‖T013‖T014; T017‖T018.

## Parallel example (US1)

```text
T011 facility_labels.dart  ‖  T012 facility_card.dart  ‖  T013 facilities_section.dart  ‖  T014 home_top_bar.dart + home_hero.dart
```

## Implementation strategy

MVP = Phase 1–3 (guest Home). Then US2 (booker), US3 (adaptive polish), US4 (states). Stop
and validate against `quickstart.md` after each story.

## Notes

- Implementation pass 2026-11-08: every task was checked against the files; all exist and the checks pass (format, analyze, 109 tests). T026 verified on web (guest 375 dp, booker desktop) and an iOS simulator; Android and the Material look were not checked.
- Some of this code may already exist from an earlier hand-written pass on this branch; `/speckit-implement` must verify each task against the files, fix gaps, and tick only what it confirmed.
