# Data Model: Home Screen UI

All types are pure Dart in `lib/features/home/domain/`. No persistence.

| Entity | Fields | Rules |
|---|---|---|
| `FacilityCategory` (enum) | pool, gym, footballPitch, basketballCourt | — |
| `BookingMode` (enum) | free, coached | BR-04: the two flows are never merged |
| `UserAffiliation` (enum) | universityAffiliated, external | BR-07 |
| `Facility` | id, name, category, bookingMode, fullPrice (int EGP/h), discountedPrice (int EGP/h) | `discountedPrice ≤ fullPrice`; `priceFor(null)` and `priceFor(external)` = fullPrice; `priceFor(universityAffiliated)` = discountedPrice; `isDiscountedFor(a)` = `priceFor(a) < fullPrice` |
| `BookerProfile` | displayName, affiliation | — |
| `UpcomingBooking` | id, facilityName, startTime, durationHours | — |
| `HomeContent` | facilities, profile?, upcomingBooking? | `isGuest` = profile is null; `affiliation` = profile?.affiliation |
| `HomeSession` (enum) | guest, booker | `parse(String?)`: "booker" → booker, anything else → guest |

**Use case `GetHomeContent(session)`**: loads from `HomeRepository`; for `guest` it strips any
profile or booking the repository returned (a guest never receives personal data).

**State (presentation)**: `homeContentProvider(session)` → `AsyncValue<HomeContent>`;
`homeNavProvider` → selected `HomeDestination` (home, bookings, notifications, profile).
