# Implementation Plan: Login Screen UI

**Branch**: `004-login-screen-ui` | **Date**: 2026-06-21 | **Spec**: [spec.md](spec.md)

**Input**: Feature specification from `/specs/004-login-screen-ui/spec.md`

## Summary

Replace the existing `LoginPlaceholderScreen` with a fully-designed login screen UI
composed of five small single-responsibility widgets, a `freezed` `LoginFormState`,
and a code-generated Riverpod `LoginFormNotifier`. The screen is scrollable
(`SingleChildScrollView`), RTL by default, dark-themed via established design tokens,
and constrained to a max-width container on wide viewports. No backend or domain logic
is introduced; the Notifier drives mock visual states only.

## Technical Context

**Language/Version**: Dart ≥ 3.11 (Flutter SDK constraint `^3.11.1`)

**Primary Dependencies**: flutter_riverpod ^2.6.1, riverpod_annotation ^2.4.1,
riverpod_generator ^2.4.4 (dev), freezed_annotation ^2.4.4, freezed ^2.5.7 (dev),
go_router ^14.3.0, flutter_localizations (SDK)

**Storage**: N/A — UI only, no persistence

**Testing**: flutter_test (widget tests for `LoginScreen`), unit tests for
`LoginFormNotifier` state transitions

**Target Platform**: Flutter web + iOS + Android (single codebase)

**Performance Goals**: 60 fps field focus transitions; mock loading cycle auto-reverts
within 2 seconds

**Constraints**: Full RTL layout, dark theme by default, Cairo font, zero hardcoded
color values (all via `AppColors`), zero inline Arabic strings (all via `AppLocalizations`
ARB pipeline), `SingleChildScrollView` for keyboard accommodation

**Scale/Scope**: 1 screen, 4 sub-widgets, 1 Notifier, 1 freezed state class, ~10 new
l10n keys, ~2 widget/unit test files

## Constitution Check

*GATE: Must pass before implementation begins.*

1. **Clean Architecture** ✅ — All new code lives in
   `lib/features/auth/presentation/`. No domain or data layer is introduced
   (explicitly out of scope for this UI-only feature). No infrastructure imports
   in the presentation layer.
2. **Riverpod-exclusive state** ✅ — `LoginFormNotifier` is a `@riverpod`-annotated
   `Notifier` class with code-gen. No `StatefulWidget` or `setState` for
   application state.
3. **Test coverage** ✅ (presentation scope) — Domain layer is N/A. Widget tests for
   `LoginScreen` and unit tests for `LoginFormNotifier` MUST be written alongside
   implementation.
4. **Modular separation** ✅ — Feature is isolated in `features/auth/`. No
   cross-feature dependencies.
5. **Implementation order** — Domain → Data steps are N/A (UI-only, explicitly scoped
   by spec). Implementation starts directly at the presentation layer. Justified
   exception documented in Complexity Tracking.

## Project Structure

### Documentation (this feature)

```text
specs/004-login-screen-ui/
├── plan.md                        # This file
├── research.md                    # Phase 0 output
├── data-model.md                  # Phase 1 output
├── quickstart.md                  # Phase 1 output
├── contracts/
│   └── widget-contracts.md        # Phase 1 output
└── tasks.md                       # Phase 2 output (/speckit-tasks)
```

### Source Code

```text
lib/features/auth/presentation/
├── screens/
│   └── login_screen.dart              # Replaces login_placeholder_screen.dart
├── widgets/
│   ├── login_brand_header.dart
│   ├── login_identifier_field.dart
│   ├── login_password_field.dart
│   └── login_button.dart
└── notifiers/
    ├── login_form_notifier.dart        # @riverpod Notifier + freezed state
    └── login_form_notifier.g.dart      # generated (do not hand-edit)

assets/l10n/
├── app_ar.arb                         # ~10 new loginField* / loginBtn* keys
└── app_en.arb                         # English equivalents

lib/core/l10n/
├── app_localizations.dart             # New abstract getters (auto-generated)
├── app_localizations_ar.dart          # Arabic translations (auto-generated)
└── app_localizations_en.dart          # English fallbacks (auto-generated)

test/presentation/auth/
├── login_screen_test.dart             # Widget tests for 4 visual states
└── login_form_notifier_test.dart      # Unit tests for Notifier transitions
```

**Structure Decision**: Flutter Clean Architecture — presentation layer only.
All new code is additive within `lib/features/auth/presentation/`. Shared core assets
(theme, l10n, router) are already in place and require only additive changes.

## Complexity Tracking

| Situation | Why Acceptable |
|-----------|---------------|
| Presentation layer before Domain/Data | Feature is explicitly UI-only per spec. No business logic, no backend calls, no domain entities exist yet. The future "real auth" feature will introduce domain + data layers then. This is not a sequence violation — there is simply nothing above presentation to implement. |
