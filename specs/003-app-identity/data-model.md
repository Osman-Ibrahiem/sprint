# Data Model: App Identity

**Branch**: `003-app-identity`

---

## Overview

This feature has no domain entities — there are no bookings, users, or facilities to model. Instead it defines two **app-level state containers** (Riverpod providers) and the **navigation trigger** that fires after the splash animation completes.

---

## ThemeModeState

Wraps Flutter's `ThemeMode` enum. Not a custom class; the provider holds `ThemeMode` directly.

| Attribute | Type | Default | Notes |
|-----------|------|---------|-------|
| `themeMode` | `ThemeMode` | `ThemeMode.dark` | The active theme: `.dark` or `.light` |

**Valid transitions**:
- `ThemeMode.dark` → `ThemeMode.light` (user toggles in future settings screen)
- `ThemeMode.light` → `ThemeMode.dark`
- No `.system` mode — Sprint never mirrors the OS theme; the in-app toggle is the single source of truth.

**Provider type**: `NotifierProvider<ThemeModeNotifier, ThemeMode>`

---

## LocaleState

Wraps Flutter's `Locale`. The provider holds `Locale` directly.

| Attribute | Type | Default | Notes |
|-----------|------|---------|-------|
| `locale` | `Locale` | `Locale('ar')` | The active locale: `Locale('ar')` or `Locale('en')` |

**Valid locales**: `Locale('ar')` · `Locale('en')` (exactly these two — no subtags needed).

**Valid transitions**:
- `Locale('ar')` → `Locale('en')`
- `Locale('en')` → `Locale('ar')`
- Unsupported locale passed in → silently ignored (assert in debug, no-op in release).

**Provider type**: `NotifierProvider<LocaleNotifier, Locale>`

---

## SplashAnimationState

Tracks the progress of the splash screen animation. Not persisted; ephemeral and scoped to the `SplashScreen` widget via a local `AnimationController`.

| Phase | Duration | Description |
|-------|----------|-------------|
| Initialising | 0 ms | Widget mounts; animation not yet started |
| Animating | 0 – 1 800 ms | Loading bar animates from 8 % → 96 % |
| Complete | 1 800 ms | `context.go(AppRoutes.login)` fires |

This is not a Riverpod provider — it is local widget state driven by a single `AnimationController` (keeping the `SplashScreen` a `ConsumerStatefulWidget` for the controller lifecycle).

---

## ARB String Additions

Both ARB files (`app_ar.arb`, `app_en.arb`) will receive these new keys:

| Key | Arabic (`ar`) | English (`en`) | Notes |
|-----|--------------|----------------|-------|
| `appName` | `سبرنت` | `Sprint` | Already in `app_ar.arb` |
| `splashSubtitle` | `احجز ملعبك، من غير زحمة ⚡` | `Book your court, hassle-free ⚡` | Splash screen tagline |
| `splashContinueHint` | `اضغط للمتابعة` | `Loading…` | Micro hint below loading bar |
| `loginTitle` | `أهلاً بيك في سبرنت` | `Welcome to Sprint` | Login placeholder heading |
| `loginSubtitle` | `ابدأ حجزك دلوقتي` | `Start booking now` | Login placeholder subheading |

---

## File Layout (source code additions)

```text
lib/
├── core/
│   ├── providers/
│   │   ├── theme_provider.dart          # ThemeModeNotifier + themeProvider
│   │   └── locale_provider.dart         # LocaleNotifier + localeProvider
│   ├── theme/
│   │   └── app_theme.dart               # + AppTheme.light() method
│   ├── router/
│   │   ├── app_routes.dart              # + AppRoutes.splash, AppRoutes.login
│   │   └── app_router.dart              # + splash + login routes; initial = /splash
│   └── l10n/                            # generated — do not edit manually
│
├── features/
│   ├── splash/
│   │   └── presentation/
│   │       └── screens/
│   │           └── splash_screen.dart
│   └── auth/
│       └── presentation/
│           └── screens/
│               └── login_placeholder_screen.dart
│
└── app.dart                             # reads themeProvider + localeProvider

assets/
└── l10n/
    ├── app_ar.arb                       # + new splash & login strings
    └── app_en.arb                       # new file

android/
└── app/src/main/res/
    ├── drawable/launch_background.xml   # dark splash background (#0D1B13)
    ├── drawable-v21/launch_background.xml # same, vector-safe
    ├── values/styles.xml                # normal (light) splash style
    └── values-night/styles.xml          # night (dark) splash style

ios/
└── Runner/
    └── Base.lproj/
        └── LaunchScreen.storyboard      # solid #0D1B13 background

test/
└── core/
    └── providers/
        ├── theme_provider_test.dart
        └── locale_provider_test.dart
```
