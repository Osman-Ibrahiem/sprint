# Research: Sprint Core Foundation

**Phase 0 Output** | **Date**: 2026-06-14 | **Plan**: [plan.md](./plan.md)

All decisions below are resolved from user-provided constraints, Flutter ecosystem
best practices (stable channel as of mid-2026), and the Sprint constitution.
No open NEEDS CLARIFICATION items remain.

---

## Decision 1: Flutter SDK Channel & Dart Version

**Decision**: Flutter **stable** channel, Dart ≥ 3.2 (required for `dart records` and
`sealed` classes used by freezed patterns).

**Rationale**: Stable channel is the only appropriate choice for a production app targeting
university governance. Dart 3.x enables pattern-matching and sealed unions that freezed
leverages for MVI state classes (Principle II).

**Alternatives considered**:
- Beta channel → rejected (instability risk for multi-platform target)
- Dart 2.x (Flutter 3.16 or older) → rejected (freezed 2.x requires Dart 3.x sealed classes)

---

## Decision 2: Package Versions (pinned minima)

| Package | Version | Rationale |
|---------|---------|-----------|
| `flutter_riverpod` | `^2.6.1` | Latest stable; supports `@riverpod` annotation, `AsyncNotifier` |
| `riverpod_annotation` | `^2.4.1` | Code-gen annotations paired to above |
| `riverpod_generator` | `^2.4.4` | build_runner plugin for `@riverpod` |
| `go_router` | `^14.3.0` | Stable; `ShellRoute` for nested nav; deep link support |
| `freezed` | `^2.5.7` | Sealed classes for state + events |
| `freezed_annotation` | `^2.4.4` | Annotations for freezed |
| `json_serializable` | `^6.8.0` | DTO code gen (used by data layer in features) |
| `supabase_flutter` | `^2.5.0` | Auth + DB client; declared at root but initialized per-feature |
| `intl` | `^0.19.0` | Required by flutter_localizations for plural/date formatting |

**Rationale**: All packages are the latest stable as of 2026-06 and have null-safe APIs.
Caret ranges allow patch updates; minor bumps require explicit upgrade.

---

## Decision 3: Design Token Architecture

**Decision**: Expose all Claude Design tokens as a static constant class hierarchy:
`AppColors` (Color consts) → `AppTypography` (TextTheme) → `AppSpacing` (double consts) →
`AppTheme.dark()` (ThemeData factory). No `MaterialColor` swatches; direct `Color` values.

**Tokens from Claude Design system**:
- Lime accent: `Color(0xFFCCF42B)` (#CCF42B)
- Sprint green: `Color(0xFF1B5E3B)` (#1B5E3B)
- Background dark: `Color(0xFF0A0A0A)` (near-black, not pure `Colors.black`)
- Surface: `Color(0xFF1A1A1A)`
- On-surface: `Color(0xFFE8E8E8)`
- Error: `Color(0xFFEF5350)`
- Font family: `'Cairo'` (Google Fonts or bundled asset — see Decision 6)
- Type scale: Material 3 `TextTheme` with Cairo at standard M3 sizes

**Rationale**: Keeping tokens as Dart constants (not a runtime config object) means
the compiler catches typos, and `const` constructors work everywhere (Principle V).
A single `AppTheme.dark()` factory satisfies SC-002 (change one place, propagates everywhere).

**Alternatives considered**:
- `ThemeExtension` for custom tokens → deferred to feature polish; foundation uses
  standard `ThemeData` fields to minimize ceremony
- JSON/YAML design tokens file → rejected for mobile (adds runtime parsing complexity)

---

## Decision 4: go_router Configuration Pattern

**Decision**: Single `GoRouter` instance declared as a Riverpod `Provider<GoRouter>` in
`lib/core/router/app_router.dart`. Routes defined as `GoRoute` tree with named constants
in `app_routes.dart`. Splash/shell uses `ShellRoute` for persistent navigation shell
(bottom nav bar) once features are added.

**Initial routes for foundation**:
- `/` → `HomeShellScreen` (placeholder; proves routing works)
- `/error` → `ErrorScreen` (404/auth-guard redirect target)

**Deep link**: `GoRouter` handles web URL bar and Android/iOS intent URLs natively.
No additional plugin needed. `go_router` 14.x has `routerNeglect` disabled by default
so browser history works.

**Rationale**: Provider-based router (not global singleton) makes it injectable and testable.
`ShellRoute` future-proofs the navigation without any breaking changes when features arrive.

**Alternatives considered**:
- `Navigator 2.0` directly → rejected (more boilerplate, no URL bar support out of box)
- `auto_route` → rejected (constitution mandates go_router explicitly)

---

## Decision 5: Riverpod Initialization & Code-Gen Setup

**Decision**:
- `main.dart`: `runApp(ProviderScope(child: App()))` — no overrides at root (overrides
  applied per-test or per-feature as needed).
- All providers use `@riverpod` annotation (code-gen), not manual `Provider(...)` calls.
- `build_runner` with `--delete-conflicting-outputs` in dev workflow.
- Generated files (`.g.dart`) committed to repo (not gitignored) — avoids CI build-runner
  requirement and simplifies code review diffs.

**Rationale**: Committing generated files is the Flutter community standard for apps (as
opposed to packages). It ensures `dart analyze` works on CI without running build_runner.

**Alternatives considered**:
- Gitignore generated files → rejected (breaks `dart analyze` on clean CI checkout)
- Manual providers without code-gen → rejected (constitution requires `riverpod_annotation`)

---

## Decision 6: Arabic Font — Google Fonts vs Bundled

**Decision**: Bundle Cairo font as a local asset (`assets/fonts/Cairo/`).

**Rationale**: The app targets Egyptian university campuses where network reliability
varies. Bundling the font guarantees correct rendering offline and on first launch with
no FOUT (flash of unstyled text). Google Fonts package can be used in development for
convenience but production MUST use bundled assets.

**Font weights needed**: 400 (Regular), 500 (Medium), 700 (Bold) — covers all M3 text roles.

**Alternatives considered**:
- `google_fonts` package → rejected for production (network dependency, license check overhead)

---

## Decision 7: l10n Configuration

**Decision**:
- Single ARB file: `assets/l10n/app_ar.arb` (Arabic, locale `ar`)
- `l10n.yaml` config: `arb-dir: assets/l10n`, `template-arb-file: app_ar.arb`,
  `output-localization-file: app_localizations.dart`, `output-dir: lib/core/l10n`
- Generated code is committed (same rationale as Riverpod gen files)
- `MaterialApp.router` receives `localizationsDelegates` and `supportedLocales: [Locale('ar')]`
- `Directionality` is automatic when locale is `ar` — no manual `TextDirection.rtl` needed

**Rationale**: `flutter_localizations` with ARB is the Flutter-official approach. Single
locale for v1 satisfies the spec assumption while the architecture supports multi-locale
without structural changes (just add more ARB files).

**Alternatives considered**:
- `easy_localization` package → rejected (adds another dependency; official approach sufficient)
- Hardcoded Arabic strings → explicitly prohibited by FR-005 and constitution

---

## Decision 8: analysis_options.yaml

**Decision**: Use `package:flutter_lints/flutter.yaml` as base, then add strict overrides:
```yaml
include: package:flutter_lints/flutter.yaml
linter:
  rules:
    prefer_const_constructors: true
    prefer_const_declarations: true
    avoid_print: true
    always_use_package_imports: true
    directives_ordering: true
```

**Rationale**: `always_use_package_imports` prevents relative cross-feature imports, making
layer boundary violations visible at analysis time. `prefer_const_constructors` enforces
Principle V performance requirement.
