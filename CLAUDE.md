# Sprint (سبرنت) — Claude Code Project Context

## ALWAYS READ FIRST
Before any task, read: .specify/memory/constitution.md
This is the project constitution — all code must comply with it.

## What is this project
Sprint is a digital governance system for sports facility management
at Tanta University. It solves real administrative problems: random
bookings, unfair access, cash fee collection, and lack of oversight.
This is both a working application and a doctoral dissertation artifact
on digital transformation in Egyptian public universities.

Platforms: Flutter web + mobile (iOS & Android) — single codebase.
Language: Arabic (RTL) throughout. Font: Cairo.
Theme: Dark, modern, sports-oriented youth identity.
Design source: Claude Design.
Colors: lime accent #CCF42B | Sprint green #1B5E3B.
All colors/typography/spacing from core/theme/ only. Zero hardcoded values.

## Three user roles
- Booker (المستخدم): browses facilities, books, pays, receives QR ticket.
  University-affiliated → discounted price (automatic, not manual).
  External visitor → full price (automatic).
  Guest state (not logged in) shows limited home screen UI.
- Trainer (المدرب): has profile, availability schedule, and rating.
  Manages coached sessions. Cannot book facilities.
- Admin (الإدارة): facility manager → dean → ministry rep.
  Graduated permissions within a shared interface.

## Four core features

### 1. Smart Booking System
- User browses facilities (swimming pools, gyms, football pitches…)
  with photos and details before booking.
- Two flows — completely separate, never merged:
  A. Free-booking: pick day → pick available hour range.
  B. Coached (e.g. swimming): pick trainer first →
  see that trainer's available 1-hour slots.
- Each slot has a capacity cap (e.g. 10 per swimming lane).
  Slot auto-closes when capacity is reached.
- Booking window: 7 days from today only.
  Past time slots are disabled in real time.
- Waitlist / digital queue: when a booking is cancelled,
  the next person in the queue gets the slot automatically.
  This enforces fairness and equal opportunity.

### 2. Trainer Management
- Booker sees list of available trainers with schedules and ratings.
- Booker can rate a trainer after session ends.
- Ratings improve administrative performance quality.

### 3. Digital Payment & QR Ticket
- Zero cash. Payment via Visa card or InstaPay only.
- After payment: electronic ticket with QR code is issued to booker.
- Trainer or facility staff scans QR to allow entry.
- This replaces paper records and protects public funds.

### 4. Asset & Equipment Management (عهدة)
- Staff-only feature.
- Staff scan or photograph sports equipment for inventory tracking.
- Records damage reports in real time.
- Protects public assets and enables financial accountability.

## Architecture (non-negotiable)
- Clean Architecture: presentation / domain / data — always.
- Domain layer: interfaces only. Zero Supabase/Firebase imports in domain/.
  This abstraction enables backend swapping without touching other layers.
- State: Riverpod + code generation.
- Navigation: go_router (URL-based, required for web).
- Backend: Supabase (auth + database). Swappable via domain abstraction.

## Spec Kit workflow
Skills installed in .claude/skills/ — use in this order:
1. /speckit-constitution
2. /speckit-specify
3. /speckit-plan
4. /speckit-tasks
5. /speckit-implement  ← may run in OpenCode instead of Claude Code

Constitution: .specify/memory/constitution.md
Specs: .specify/specs/

## Definition of done
- Compiles with zero warnings.
- Business logic has tests.
- No hardcoded colors, strings, or magic numbers.
- Clean Architecture layer boundaries respected.
- Arabic strings externalized via flutter_localizations.

<!-- SPECKIT START -->
For additional context about technologies to be used, project structure,
shell commands, and other important information, read the current plan
at specs/003-app-identity/plan.md
<!-- SPECKIT END -->