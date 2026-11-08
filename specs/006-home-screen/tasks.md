# Tasks: Home Screen UI

Format: `[ID] [P?] [Story] Description`. Order: Setup → Domain → Data → Presentation → Polish.

## Phase 1: Setup
- [x] T001 Add `home*` keys to `assets/l10n/app_ar.arb` and `app_en.arb`; run `flutter gen-l10n`
- [x] T002 Route: `/home?session=` → `HomeScreen`; remove `HomeShellScreen`

## Phase 2: Domain (tests first)
- [x] T003 [P] Entities + enums (`Facility`, `FacilityCategory`, `BookingMode`, `UserAffiliation`, `BookerProfile`, `UpcomingBooking`, `HomeContent`, `HomeSession`)
- [x] T004 [P] `Facility.priceFor` tests (guest, external, affiliated) — BR-07
- [x] T005 `HomeRepository` interface + `GetHomeContent` use case + tests (guest has no profile/booking; booker has profile)

## Phase 3: Data
- [x] T006 `MockHomeRepository` (+ test: guest vs booker content, coached/free mix)

## Phase 4: Presentation
- [x] T007 `home_layout.dart` constants + column helper (+ test)
- [x] T008 Providers (`@riverpod`), `HomeNavNotifier`; run build_runner (+ nav notifier test)
- [x] T009 [US1] Guest: top bar, hero, facility card/section, screen
- [x] T010 [US2] Booker: greeting, upcoming booking card/empty state, discounted price display
- [x] T011 [US2/3] Adaptive navigation (bar / rail / drawer), coming-soon body
- [x] T012 [US4] Loading + error view with retry
- [x] T013 Widget tests: guest, booker (affiliated vs external), widths 360/700/1000/1400, nav type, guest→/login

## Phase 5: Polish
- [x] T014 `flutter analyze`, `dart format`, full `flutter test`
- [x] T015 Verify on web + iOS simulator (Apple + `SPRINT_PLATFORM=material`)
- [x] T016 Update `docs/project-context/status.md`; PR into `develop`
