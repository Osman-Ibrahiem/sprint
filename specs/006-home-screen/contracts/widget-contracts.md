# UI Contracts: Home Screen

## Route
`/home` → `HomeScreen(session: HomeSession.parse(query['session']))`. Default guest.

## Domain interface
```dart
abstract interface class HomeRepository {
  Future<HomeContent> load(HomeSession session);
}
```

## Widgets (presentation)
| Widget | Inputs | Behaviour |
|---|---|---|
| `HomeScreen` | `session` | Loading → spinner; error → `HomeErrorView(onRetry)`; data → guest page or booker shell |
| `HomeTopBar` | — | Brand + sign-in text button → `/login` (guest only) |
| `HomeHero` | — | Pitch + `AdaptiveFilledButton` → `/login` |
| `HomeGreeting` | `name` | Greeting + subtitle |
| `UpcomingBookingCard` | `booking?` | Booking details, or empty state when null |
| `FacilityCard` | `facility`, `affiliation?`, `onTap` | Art tile with mode badge, name, category, price (struck-through full price when discounted); one semantic node |
| `FacilitiesGrid` | `facilities`, `affiliation`, `isGuest` | Sliver grid, columns by pane size class; tap → `/login` for guest, no-op for booker |
| `HomeBottomBar` / `HomeSideRail` | `selected`, `onSelect`, (`navType`) | 4 destinations; rail extended when `NavType.drawer` |
| `ComingSoonView` | — | Body for non-Home destinations |

## Localization keys
`home*` keys in `app_ar.arb` (source) and `app_en.arb`: guest hero, greeting, upcoming booking
(+ date/time/plural duration), price per hour, original price, booking-mode and category labels,
facility semantic label, navigation labels, coming soon, error, retry.
