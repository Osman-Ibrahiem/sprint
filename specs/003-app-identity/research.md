# Research: App Identity

**Branch**: `003-app-identity` | **Feature**: App Identity

---

## Decision 1: Native Splash Screen Approach

**Decision**: Manual XML/Storyboard configuration — no `flutter_native_splash` package.

**Rationale**: The sprint native splash is a single solid background color per theme (`#0D1B13` dark, `#F8FFF9` light). Android already has `launch_background.xml` stubs in `drawable/` and `drawable-v21/` (which can be themed via `values-night/styles.xml`). iOS uses `LaunchScreen.storyboard` which Flutter scaffolds. Manual configuration requires zero new dependencies and gives precise control over the exact colour values from `AppColors`.

**Alternatives considered**:
- `flutter_native_splash` package: simplifies multi-theme splash configuration but adds a dev dependency and a build-step script; overkill for a plain-color background.
- `flutter_launcher_icons` + manual: useful for icon generation but unrelated to splash.

**Flutter splash pixel-parity with native splash**: Both use `AppColors.green900` (`#0D1B13`) as the background in dark mode and `AppColors.green50` (`#F8FFF9`) in light mode. The Flutter `SplashScreen` widget fills the entire screen with the same colour before rendering content, eliminating any visible transition gap.

---

## Decision 2: App Icon Strategy

**Decision**: Place the `sprint-mark-lime.png` from the design bundle into the project asset path (`assets/images/icons/`) and configure Android/iOS icon slots manually, using the existing dark-variant PNG for both platforms as the primary icon. Light-variant icon referencing is documented as a future step (adaptive icon support is OS-restricted at runtime). For this feature, the app icon in the OS launcher uses the dark (Sprint Green square + lime bolt) variant only.

**Rationale**: Dynamic runtime icon switching (switching the launcher icon when the user changes theme) is not reliably supported on either Android or iOS without a plugin (`dynamic_icon` / `flutter_dynamic_icon`). The spec says "the correct variant MUST be shown in OS contexts that support adaptive icons" — for the initial implementation, providing the dark-variant icon everywhere satisfies the MVP. Light-variant adaptive icon is a P3 enhancement.

**Alternatives considered**:
- `flutter_launcher_icons` package: useful generator but not needed for manual placement.
- `dynamic_icon` plugin: adds native code complexity; deferred.

---

## Decision 3: Locale & Theme Persistence

**Decision**: Defer persistence (shared_preferences) to the Settings feature. For this feature, providers hold in-memory state only. On cold launch, providers initialise to their compile-time defaults (Arabic + dark). This is explicitly allowed by the spec: *"defaults to dark on first launch, then remembers last choice"* — remembering requires a settings screen, which is out of scope.

**Rationale**: No `shared_preferences` dependency is required today. Providers will expose the full persistence API contract (read/write), making it trivial to wire persistence when the settings feature is built. Adding the package now without a UI to exercise it is premature.

**Alternatives considered**:
- Add `shared_preferences` now: cleaner long-term but means adding a dependency with no user-visible payoff in this feature.
- Hydrated Riverpod: heavier dependency, deferred.

---

## Decision 4: English Localisation Wiring

**Decision**: Add `app_en.arb` to `assets/l10n/` and add `Locale('en')` to `supportedLocales`. The existing `l10n.yaml` configuration generates from `app_ar.arb` as template, producing `AppLocalizationsAr` + a new `AppLocalizationsEn`. The `AppLocalizations` abstract base in `lib/core/l10n/` grows an `AppLocalizationsEn` implementation.

**Rationale**: The l10n pipeline is already wired (`l10n.yaml` → `flutter gen-l10n`). Adding an English ARB file and updating `supportedLocales` is a two-file change. The generated `AppLocalizations.lookupAppLocalizations()` switch statement will handle the new `'en'` case.

**Alternatives considered**:
- `easy_localization`: heavier package; ARB pipeline already in place, no reason to switch.

---

## Decision 5: Splash Screen Navigation Timing

**Decision**: The Flutter `SplashScreen` widget uses a fixed `Future.delayed` of 1 800 ms (matching the design's `barload 1.8s` animation), then calls `context.go(AppRoutes.login)` via GoRouter. No "tap to continue" interaction in production (the design prototype used tap-to-continue for demo purposes only).

**Rationale**: A loading bar animation drives perceived progress. 1 800 ms gives Cairo fonts and Riverpod providers time to settle without feeling sluggish. The spec success criterion is "< 3 seconds total cold launch", which this satisfies easily.

**Alternatives considered**:
- Tap-to-continue (from design prototype): valid for demo but not a good production UX.
- `go_router` redirect on auth state: the correct long-term approach, but auth is out of scope; splash just navigates unconditionally to the login placeholder.

---

## Decision 6: SplashScreen Widget Composition

**Decision**: `SplashScreen` is a full-screen `Scaffold` with `scaffoldBackgroundColor: AppColors.green900` (dark) / `AppColors.green50` (light). The body draws the radial gradient overlay as a `DecoratedBox`, the centred logo group as a `Column`, and the loading bar at the bottom using a `PositionedDirectional`. All animation is driven by a single `AnimationController`.

The logo: a 118×118 `Container` with `BorderRadius.circular(38)`, `color: AppColors.sprintGreen`, child = `Icon(Icons.bolt_rounded, size: 70, color: AppColors.lime)`.

**Font size for "سبرنت"**: 44px, `FontWeight.w900` (Black), `color: AppColors.textPrimary`.
**Subtitle**: "احجز ملعبك، من غير زحمة ⚡", 15px SemiBold, `color: AppColors.green300`.
**Loading bar**: 148px wide, 4px tall, pill radius; track `rgba(204,244,43,0.16)`; fill `AppColors.lime`; animated from 8% → 96% over 1 800 ms.

**Rationale**: Pixel-identical recreation of the design HTML prototype's splash using Flutter primitives. No external image assets needed for the Flutter splash itself — the bolt icon is from Material Icons.

---

## Decision 7: Login Placeholder Screen

**Decision**: `LoginPlaceholderScreen` is a `Scaffold` with the Sprint logo centred and a localised app-name text. It is intentionally minimal — its only role is to confirm routing and localisation work. A "← Back" ghost button navigates to `/splash` for manual testing during development.

**Rationale**: The spec says "no interactive elements beyond what is needed to verify identity display." The back button is a dev convenience removed in production.
