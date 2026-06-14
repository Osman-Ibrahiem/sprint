# Data Model: Sprint Core Foundation

**Phase 1 Output** | **Date**: 2026-06-14 | **Plan**: [plan.md](./plan.md)

The "data model" for the core foundation is the **structural and type contract** for the
shared infrastructure objects that every feature will consume. No business entities are
defined here; those belong to feature-specific `domain/` layers.

---

## AppColors

**Location**: `lib/core/theme/app_colors.dart`

> **Updated 2026-06-14**: Values corrected from Sprint Brand Guidelines v1.0 via Claude
> Design export. Several values in the original draft were incorrect.

Static constant final class. No instances. All values are `const Color`.
Full green-axis palette + semantic aliases for dark mode (app default).

```
AppColors — Brand core
├── sprintGreen      Color(0xFF1B5E3B)   // logo bg / primary btn (unchanged)
├── sprintGreenDeep  Color(0xFF0F4C2F)   // pressed / hover-darker
├── lime             Color(0xFFCCF42B)   // accent / CTA (unchanged)
└── limeSoft         Color(0xFFDFF96B)   // lime hover

AppColors — Green ramp (neutrals live on a green axis)
├── green900   Color(0xFF0D1B13)   // dark page base       ← was #0A0A0A
├── green800   Color(0xFF122B1D)   // dark surface/cards   ← was #1A1A1A
├── green700   Color(0xFF1A3D2A)   // dark elevated        ← was #2A2A2A
├── green600   Color(0xFF2E5E3E)   // dark border
├── green500   Color(0xFF5EA87A)   // secondary text/icons
├── green300   Color(0xFFA8D8BA)   // light borders
├── green100   Color(0xFFD0E8D8)   // light-mode border
└── green50    Color(0xFFF8FFF9)   // light page base

AppColors — True neutrals
├── ink900   Color(0xFF1A1A1A)   // text-primary on light
├── ink500   Color(0xFF666666)   // text-secondary on light
└── white    Color(0xFFFFFFFF)

AppColors — Semantic hues
├── success  Color(0xFF1D9E75)
├── warning  Color(0xFFEF9F27)
├── error    Color(0xFFE24B4A)   ← was #EF5350
└── info     Color(0xFF378ADD)

AppColors — Status badge pairs (bg / fg)
├── badgeConfirmedBg/Fg   #E4F7EC / #0F6E56
├── badgePendingBg/Fg     #FFF9E6 / #854F0B
├── badgeCancelledBg/Fg   #FCEBEB / #A32D2D
├── badgeTrainerBg/Fg     #E6F1FB / #185FA5
└── badgeFeaturedBg/Fg    #F4FFB0 / #3B6D11

AppColors — Dark-mode semantic aliases (app default)
├── bgBase        = green900  #0D1B13
├── bgSurface     = green800  #122B1D
├── bgElevated    = green700  #1A3D2A
├── border        = green600  #2E5E3E
├── borderSubtle  Color(0xFF163525)
├── textPrimary   = green50   #F8FFF9  ← was #E8E8E8
├── textSecondary = green500  #5EA87A  ← was #CCCCCC
├── textMuted     Color(0xFF3E6E50)
├── accent        = lime
├── onAccent      = sprintGreen  #1B5E3B  ← was #0A0A0A
├── onPrimary     = lime
├── overlay       rgba(13,27,19,0.66)
└── focusRing     rgba(204,244,43,0.55)
```

**Constraint**: No `Color(0x...)` literal may appear outside `app_colors.dart`.
Violations are caught by `avoid_hardcoded_colors` lint (or code review).

---

## AppRadius

**Location**: `lib/core/theme/app_radius.dart` *(new file — not in original draft)*

> **Added 2026-06-14**: Design export includes explicit radius tokens.

Static constant final class + `BorderRadius` helpers.

```
AppRadius
├── sm     8.0    // chips / inner elements
├── md    12.0    // buttons & form fields
├── lg    16.0    // large cards
├── xl    20.0    // sheets / modals
└── pill 999.0    // badges, pills, avatars (fully round)

BorderRadius helpers: smAll, mdAll, lgAll, xlAll, pillAll
```

---

## AppTypography

**Location**: `lib/core/theme/app_typography.dart`

> **Updated 2026-06-14**: Size scale corrected from design export; not pure M3 sizes.
> Cairo font weights available: 200·300·400·600·700·900 (500 falls back to 400; 800 to 900).

Produces a Material 3 `TextTheme` mapped to the Sprint design scale, plus named helpers.

```
Named helpers (AppTypography.display, .h1, .h2, …):
├── display    40px  weight:900  height:1.15   // hero / splash
├── h1         32px  weight:800  height:1.15
├── h2         26px  weight:700  height:1.30
├── h3         20px  weight:600  height:1.30
├── bodyLg     16px  weight:500  height:1.55
├── body       15px  weight:500  height:1.55
├── sm         14px  weight:400  height:1.55
├── xs         12px  weight:400  height:1.70
└── micro      11px  weight:600  height:1.30   // badges / labels

M3 TextTheme mapping:
├── displayLarge    40px  w900  h:1.15
├── displayMedium   32px  w800  h:1.15
├── displaySmall    26px  w700  h:1.30
├── headlineLarge   26px  w700  h:1.30
├── headlineMedium  20px  w600  h:1.30
├── headlineSmall   20px  w600  h:1.30
├── titleLarge      20px  w600  h:1.30
├── titleMedium     16px  w500  h:1.55
├── titleSmall      14px  w500  h:1.55
├── bodyLarge       16px  w500  h:1.55
├── bodyMedium      15px  w500  h:1.55
├── bodySmall       14px  w400  h:1.55
├── labelLarge      14px  w600  h:1.30
├── labelMedium     12px  w400  h:1.70
└── labelSmall      11px  w600  h:1.30
```

---

## AppSpacing

**Location**: `lib/core/theme/app_spacing.dart`

> **Updated 2026-06-14**: Scale corrected from design tokens. `md` is 12px (not 16px);
> all subsequent values shift by one step. A `xxs: 2px` step added.

Static constant final class. All values are `const double` on a 4-pt base grid.

```
AppSpacing
├── xxs      2.0   // 2xs in CSS tokens
├── xs       4.0
├── sm       8.0
├── md      12.0   ← was 16 in draft
├── lg      16.0   ← was 24 in draft (= --space-lg)
├── xl      24.0   ← was 32 in draft (= --space-xl, screenPad)
├── xxl     32.0   ← was 48 in draft (= --space-2xl, sectionGap)
├── xxxl    48.0   ← was 64 in draft (= --space-3xl)
└── xxxxl   64.0   // new (= --space-4xl)

Convenience
├── screenPad   = xl   (24px)
├── sectionGap  = xxl  (32px)
└── gutter      = lg   (16px)
```

---

## AppTheme

**Location**: `lib/core/theme/app_theme.dart`

Single factory method returning a fully configured `ThemeData`.

```
AppTheme
└── dark() → ThemeData
    ├── colorScheme: ColorScheme.dark(
    │     primary: AppColors.lime,
    │     onPrimary: AppColors.onLime,
    │     secondary: AppColors.green,
    │     background: AppColors.background,
    │     surface: AppColors.surface,
    │     error: AppColors.error,
    │     brightness: Brightness.dark
    │   )
    ├── textTheme: AppTypography.textTheme
    ├── scaffoldBackgroundColor: AppColors.background
    ├── useMaterial3: true
    └── fontFamily: 'Cairo'
```

**Usage**: `MaterialApp.router(theme: AppTheme.dark(), ...)` — one call, no duplication.

---

## AppRouter

**Location**: `lib/core/router/app_router.dart`

Riverpod `Provider<GoRouter>` (code-generated via `@Riverpod(keepAlive: true)`).

```
AppRouter (GoRouter instance)
├── initialLocation: '/'
├── errorBuilder: → ErrorScreen
├── routes:
│   ├── GoRoute(path: '/', name: AppRoutes.home)
│   │     → HomeShellScreen (foundation placeholder)
│   └── GoRoute(path: '/error', name: AppRoutes.error)
│         → ErrorScreen
└── redirect: (auth guard — stub returning null for foundation milestone)
```

---

## AppRoutes

**Location**: `lib/core/router/app_routes.dart`

String constants only. No logic.

```
AppRoutes
├── home    '/home'
└── error   '/error'
```

Feature branches add their named routes here as a PR to this file.

---

## L10n Catalog Structure

**Source**: `assets/l10n/app_ar.arb`

ARB keys follow `lowerCamelCase` with feature prefix:

```json
{
  "@@locale": "ar",
  "appName": "سبرنت",
  "@appName": { "description": "Application name displayed in app bar" },
  "errorPageTitle": "خطأ",
  "@errorPageTitle": { "description": "Title shown on the 404/error screen" },
  "errorPageMessage": "الصفحة غير موجودة",
  "@errorPageMessage": { "description": "Body text on the 404/error screen" }
}
```

**Naming convention for future features**:
- Booking: `booking_*` prefix → `bookingSelectSlot`, `bookingConfirm`, etc.
- Trainer: `trainer_*` prefix
- Payment: `payment_*` prefix
- Asset: `asset_*` prefix
- Shared: no prefix → `cancel`, `confirm`, `save`, `error`, etc.

---

## Smoke Test Contracts

These are the assertions the two smoke tests verify:

**`app_theme_test.dart`**:
- `AppColors.lime` is `Color(0xFFCCF42B)` (not null, correct type)
- `AppColors.green` is `Color(0xFF1B5E3B)`
- `AppTheme.dark()` returns a non-null `ThemeData` with `useMaterial3 == true`
- `AppTheme.dark().colorScheme.primary == AppColors.lime`
- `AppTheme.dark().textTheme.bodyLarge?.fontFamily == 'Cairo'`

**`app_launch_test.dart`**:
- `pumpWidget(ProviderScope(child: App()))` does not throw
- Widget tree contains a `Directionality` with `textDirection == TextDirection.rtl`
- Widget tree contains a `Localizations` widget with locale `ar`
- The initial route (`/`) renders without a RenderFlex overflow or error widget
