# Sprint (سبرنت) — Agent Context & Instructions

## Project Overview
Sprint is a digital governance system for sports facility management at Tanta University. It targets digital transformation in Egyptian public universities by solving issues like random bookings, unfair access, and cash collection.

- **Platforms**: Flutter (Web, iOS, Android).
- **Primary Language**: Arabic (RTL), Font: Cairo.
- **Theme**: Dark, modern, sports identity.
- **Colors**: Lime accent `#CCF42B`, Green `#1B5E3B`.

## User Roles
- **Booker (المستخدم)**: Browse, book (Free/Coached), pay digitally, QR tickets.
- **Trainer (المدرب)**: Manage availability, sessions, and profile.
- **Admin (الإدارة)**: Graduated permissions for facility management.

## Core Features
1. **Smart Booking**: 7-day window, capacity caps, waitlist, separate flows for free vs. coached bookings.
2. **Trainer Management**: Ratings and schedules.
3. **Digital Payment**: QR tickets, Visa/InstaPay only. No cash.
4. **Asset Management**: Staff-only inventory and damage tracking via QR/Photos.

## Technical Architecture (Non-negotiable)
- **Clean Architecture**: 
    - `domain`: Pure Dart, interfaces only. No backend imports.
    - `data`: Repository implementations, DTOs, Supabase integration.
    - `presentation`: UI, Riverpod providers.
- **State Management**: Riverpod with code generation.
- **Navigation**: `go_router` for deep linking and web support.
- **Backend**: Supabase.

## Development Rules
- **No Hardcoding**: All colors/spacing from `core/theme/`. All strings externalized via `flutter_localizations`.
- **Logic Isolation**: Keep business logic out of UI.
- **Tests**: Domain layer requires unit tests for all business rules.
- **Quality**: Zero warnings policy. Follow the project constitution in `.specify/memory/constitution.md`.

## Workflow
1. Read `.specify/memory/constitution.md` before any task.
2. Use the Spec Kit workflow if available:
   - `/speckit-constitution`
   - `/speckit-specify`
   - `/speckit-plan`
   - `/speckit-tasks`
   - `/speckit-implement`

## Extended project context
Background from the original design chats is in docs/project-context/ (start with README.md).
The constitution, specs/, and lib/core/theme/ remain the source of truth; if they conflict with these docs, flag it.
Read on demand, not every session:
- docs/project-context/product-and-ux.md  (user flow, UX decisions, screen inventory, login decisions, deferred items)
- docs/project-context/brand-and-voice.md  (brand rules, Egyptian-Arabic tone of voice)
- docs/project-context/workflow-and-lessons.md  (git flow, tool split, regressions to avoid)
- docs/project-context/status.md  (current state and open questions)

<!-- SPECKIT START -->
For additional context about technologies to be used, project structure,
shell commands, and other important information, read the current plan
<!-- SPECKIT END -->
