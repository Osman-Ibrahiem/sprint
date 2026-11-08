# Product and UX decisions (from chats)

The roles, the four core features, booking rules, and architecture are already in `CLAUDE.md` and the constitution (§ Domain Business Rules). This file adds what only the chats hold.

## Purpose and framing
- Sprint digitizes and governs sports-facility booking at Tanta University (random booking, unfair access, crowding in places like swimming pools, cash fee collection).
- It is both a real app and a doctoral dissertation artifact on digital transformation in Egyptian public universities, so traceability and clear business rules matter.
- Admin is a hierarchy that shares one interface with graduated permissions: facility manager, dean, ministry representative.
- Pricing is decided by account type, never manually. All university-affiliated users (students, staff, faculty) get the same discounted price. External visitors pay full price.

## User Flow (four phases)
1. **Entry and identity verification.** The system decides the price tier from the account type here (decision point 1).
2. **Facility browsing and time selection.** Availability is checked instantly and conflicts are prevented (decision point 2).
3. **Booking confirmation and payment.** Success confirms the booking and sends notifications. Failure returns the user to retry (decision point 3).
4. **Post-booking.**
   - Confirmation screen: booking number, QR entry code, appointment details, "My bookings" button.
   - Automatic push notification and SMS with the booking details.
   - Reminder one hour before, with a cancel option if there is enough time.
   - On the day, admin or staff record attendance or no-show from the dashboard.
   - Either way the booking closes in the log and the admin report updates automatically.

## Six UX corrections applied to wireframes v2
1. Home is state-based: guests see an empty/discovery state, logged-in users see a personalized view.
2. No quick-action buttons that duplicate the bottom navigation.
3. Calendar enforces the 7-day window, and past times are disabled according to the current time.
4. Free-booking facilities allow multi-hour ranges.
5. Coached facilities (e.g. swimming pools) are trainer-first, then fixed one-hour slots. These are two separate flows, never merged.
6. Trainer attendance uses QR scanning with a manual fallback, to prevent manipulation.

## Screen inventory (Figma, 22 screens, 6 pages)
Figma file key `jDJkupRwurbY5DoUZOG8dF` (built in the 2026-06-09 chat). See `status.md` for a conflicting key.
- **Auth:** Splash, Login, Register
- **Booker Home:** Guest Discovery, Logged In, My Bookings, Notifications, Profile
- **Booking Flow:** facility selection, calendar with time range, coached booking with trainer selection, summary
- **Payment:** payment, success with QR code, failed payment
- **Trainer:** dashboard, QR scanner, QR confirmation, attendance list
- **Admin:** dashboard with KPIs, finance/revenue

Unconfirmed sample content in those Figma mocks (treat as placeholders, not requirements): a 50% student discount example (400 EGP to 200 EGP) and a cancellation policy of free before 24 hours, then 25% deducted.

## Login screen (feature 004, UI only)
Decisions from `/specify` and `/clarify`:
- One unified form for all roles. Fields: email or phone, and password.
- No "forgot password" and no social login.
- Scroll behavior: `SingleChildScrollView`.
- State: `@riverpod` Notifier with code generation.
- Identifier field leading icon: `Icons.person_outline`.
- Loading state auto-reverts (chat said about 2 seconds; the current mock uses 1.8 seconds).
- Accessibility: semantic labels on interactive elements only.
- **Out of scope:** any authentication logic, backend calls, or Supabase. The spec has an explicit Out-of-scope section to stop agents from generating auth code. Keep it.

## Deferred on purpose
- Supabase credentials and real authentication (UI-first approach).
- `master` branch production deployment to a custom domain.
- Packages to reconsider later: `permission_handler`, `share_plus`, `cached_network_image`, `skeletonizer`, `flutter_animate`, `fpdart` (`Either`/`Option` for domain errors).
- Planned feature order after login: home, booking flow, payment, trainer dashboard, admin dashboard.

## Language rules
- The app is fully Arabic (RTL) by default, English secondary. Strings live in ARB files.
- Chat with the owner happens in Egyptian Arabic. All code, specs, Spec Kit artifacts, and config stay in English.
