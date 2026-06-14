# Data Model: Sprint Core Foundation

**Phase 1 Output** | **Date**: 2026-06-14 | **Plan**: [plan.md](./plan.md)

The "data model" for the core foundation is the **structural and type contract** for the
shared infrastructure objects that every feature will consume. No business entities are
defined here; those belong to feature-specific `domain/` layers.

---

## AppColors

**Location**: `lib/core/theme/app_colors.dart`

Static constant class. No instances. All values are `const Color`.

```
AppColors
├── lime          Color(0xFFCCF42B)   // Lime accent — primary interactive color
├── green         Color(0xFF1B5E3B)   // Sprint green — brand anchor
├── background    Color(0xFF0A0A0A)   // Scaffold background (near-black)
├── surface       Color(0xFF1A1A1A)   // Card / bottom sheet background
├── surfaceVariant Color(0xFF2A2A2A)  // Input fill, chip background
├── onBackground  Color(0xFFE8E8E8)   // Primary text on dark background
├── onSurface     Color(0xFFCCCCCC)   // Secondary text on surface
├── onLime        Color(0xFF0A0A0A)   // Text/icon on lime background (must pass WCAG AA)
├── error         Color(0xFFEF5350)   // Error state
└── onError       Color(0xFFFFFFFF)   // Text on error color
```

**Constraint**: No value outside this class may appear as a `Color(0x...)` literal.
Violations are caught by `avoid_hardcoded_colors` custom lint (or code review).

---

## AppTypography

**Location**: `lib/core/theme/app_typography.dart`

Produces a Material 3 `TextTheme` with Cairo as the font family.
All sizes follow the M3 type scale. Font weights: 400, 500, 700.

```
AppTypography.textTheme → TextTheme
├── displayLarge    Cairo 57/64  weight:400
├── displayMedium   Cairo 45/52  weight:400
├── displaySmall    Cairo 36/44  weight:400
├── headlineLarge   Cairo 32/40  weight:700
├── headlineMedium  Cairo 28/36  weight:700
├── headlineSmall   Cairo 24/32  weight:700
├── titleLarge      Cairo 22/28  weight:500
├── titleMedium     Cairo 16/24  weight:500
├── titleSmall      Cairo 14/20  weight:500
├── bodyLarge       Cairo 16/24  weight:400
├── bodyMedium      Cairo 14/20  weight:400
├── bodySmall       Cairo 12/16  weight:400
├── labelLarge      Cairo 14/20  weight:500
├── labelMedium     Cairo 12/16  weight:500
└── labelSmall      Cairo 11/16  weight:500
```

---

## AppSpacing

**Location**: `lib/core/theme/app_spacing.dart`

Static constant class. All values are `const double` on a 4-pt base grid.

```
AppSpacing
├── xs     4.0
├── sm     8.0
├── md    16.0
├── lg    24.0
├── xl    32.0
├── xxl   48.0
└── xxxl  64.0
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
