# Implementation Plan: Sprint Core Foundation

**Branch**: `feature/core-foundation` | **Date**: 2026-06-14
**Spec**: [spec.md](./spec.md)

**Input**: Feature specification from `specs/002-core-foundation/spec.md`

---

## Summary

Stand up the Flutter project scaffold that all subsequent Sprint features will build on.
This milestone produces a compiling, RTL-Arabic, dark-themed app shell with:
- Clean Architecture folder conventions enforced by structure (not a lint rule alone)
- All design tokens sourced from Claude Design (#CCF42B lime, #1B5E3B green, Cairo font)
  exposed via a single `AppTheme` object in `lib/core/theme/`
- Centralized navigation via go_router with URL deep-link support
- Riverpod `ProviderScope` wrapping the widget tree with code-gen wired up
- `flutter_localizations` + `intl` bootstrapped with Arabic as the only locale,
  all strings in `assets/l10n/app_ar.arb`

No feature logic is implemented in this milestone. The output is a running skeleton
that proves all five infrastructure concerns work before any feature branch starts.

---

## Technical Context

**Language/Version**: Dart 3.x (bundled with Flutter stable channel, ≥ 3.22)

**Primary Dependencies**:
- `flutter_riverpod ^2.6` + `riverpod_annotation ^2.4` + `riverpod_generator ^2.4`
- `go_router ^14.x`
- `freezed ^2.5` + `freezed_annotation ^2.4`
- `json_serializable ^6.8` (DTOs — wired now, used in feature branches)
- `supabase_flutter ^2.x` (dependency declared now; initialized in data layer by features)
- `flutter_localizations` (Flutter SDK)
- `intl ^0.19`

**Dev Dependencies**: `build_runner`, `riverpod_generator`, `freezed`, `json_serializable`

**Storage**: N/A for foundation milestone (Supabase declared but not initialized)

**Testing**: `flutter_test` (SDK) — smoke tests only at foundation level

**Target Platform**: Web (Chrome), iOS 16+, Android API 26+

**Project Type**: Flutter mobile + web app (single codebase)

**Performance Goals**: App cold-start to first frame < 3 s on mid-range Android device

**Constraints**:
- Zero hardcoded colors, font sizes, or spacing literals anywhere
- `dart analyze` must produce zero errors/warnings post-setup
- Arabic RTL with zero English fallback text in UI

**Scale/Scope**: Foundation only — ~10 source files, <500 LOC excluding generated code

---

## Constitution Check

*GATE: Must pass before Phase 0 research. Re-check after Phase 1 design.*

1. **Clean Architecture compliance** ✅
   Foundation creates the enforced folder structure. Domain dirs exist; no feature code
   added yet, so no layer-skip imports can occur. Enforced structurally and by linter.

2. **Riverpod-exclusive state management** ✅
   `ProviderScope` wraps `MaterialApp.router`. No `setState` for app state; widget-level
   ephemeral state (e.g., animation) permitted as per Principle V but not introduced here.

3. **Test coverage for all domain use cases** ✅ (scoped)
   Foundation has no domain use cases (it IS the layer scaffold). Two smoke tests cover:
   - Theme token type-safety (tokens exist and are `Color`, `TextStyle`, etc.)
   - App builds and routes to initial shell without crash
   Full domain test coverage applies from feature branches onward.

4. **Modular feature separation** ✅
   `lib/features/` is empty (`.gitkeep`). No features exist yet so no circular deps.
   Module boundary is established: features MUST NOT import across feature dirs.

5. **Implementation order: Domain → Data → Presentation** ✅
   For the foundation itself: `core/theme` (shared) → `core/router` → `core/l10n` →
   `main.dart` wiring. No feature domain layers are touched here.

*No constitution violations. Complexity Tracking section omitted.*

---

## Project Structure

### Documentation (this feature)

```text
specs/002-core-foundation/
├── plan.md          ← this file
├── research.md      ← Phase 0 output
├── data-model.md    ← Phase 1 output
├── quickstart.md    ← Phase 1 output
└── tasks.md         ← Phase 2 output (/speckit-tasks)
```

### Source Code Layout

```text
lib/
├── core/
│   ├── theme/
│   │   ├── app_colors.dart        # Color constants from Claude Design
│   │   ├── app_typography.dart    # TextTheme using Cairo font
│   │   ├── app_spacing.dart       # Spacing scale (4-pt grid)
│   │   └── app_theme.dart         # ThemeData factory — the single theme object
│   ├── router/
│   │   ├── app_router.dart        # GoRouter configuration + route names
│   │   └── app_routes.dart        # Route path constants
│   └── l10n/
│       └── app_localizations.dart # Re-export of generated AppLocalizations
├── features/
│   └── .gitkeep                   # Placeholder; populated by feature branches
├── app.dart                       # MaterialApp.router + ProviderScope + L10n
└── main.dart                      # runApp entry point

assets/
└── l10n/
    └── app_ar.arb                 # Arabic string catalog (source of truth)

test/
├── core/
│   └── theme/
│       └── app_theme_test.dart    # SC-002: token types are correct, no nulls
└── smoke/
    └── app_launch_test.dart       # SC-003 / SC-004: app renders RTL Arabic shell

pubspec.yaml                       # All dependencies declared
analysis_options.yaml              # strict flutter_lints rules
l10n.yaml                          # ARB source → generated Dart config
```
