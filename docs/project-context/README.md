# Sprint — Project Context (from the design chats)

Snapshot taken 2026-11-07 from the claude.ai "Sprint" Project chats.
This folder holds background that exists only in those chats. It supports, and never overrides:

1. `.specify/memory/constitution.md` — non-negotiable principles and domain business rules
2. `specs/00x-*/` — the per-feature specs and plans (source of truth for what is built)
3. `lib/core/theme/` — the real design tokens in code

If something here disagrees with those, the constitution/specs/code win. Flag the conflict instead of silently picking one.

## Files (read on demand)

| File | Read it when |
|---|---|
| `product-and-ux.md` | planning a feature or screen: user flow, UX decisions, screen inventory, login decisions, deferred items |
| `brand-and-voice.md` | writing UI, copy, or error messages; checking visual rules |
| `workflow-and-lessons.md` | starting any task: git flow, tool split, regressions to avoid |
| `status.md` | needing the current state, open PRs, or open questions |
| `thesis-research-plan.md` | writing a PRD, user stories or a spec: the registered research plan (problem, objective, population, tools, steps), transcribed |
| `thesis-alignment.md` | checking a feature or business rule against the research plan: gaps, open questions for the doctor |

## Source chats (claude.ai, Sprint Project)

Chronological. Titles are in Arabic as saved.

| Date | Chat | What it contains |
|---|---|---|
| 2026-06-09 | [تطبيق سبرنت لبحث الدكتوراه في التربية الرياضية](https://claude.ai/chat/f476cbe7-3452-4046-aa0a-1e88b19ff2bb) | Concept, roles, modules, full User Flow (4 phases), wireframes v2 and six UX corrections, Figma build of 22 screens |
| 2026-06-10 | [نظام حجز المنشآت الرياضية الذكي سبرنت](https://claude.ai/chat/c298eadd-5b5b-46cd-834e-b80235062eeb) | Brand identity, design system, logo variants, Tone of Voice, Brand Guidelines v1.0 (.docx generated in this chat) |
| 2026-06-11 | [بناء تطبيق حجز التذاكر الرياضية sprint](https://claude.ai/chat/4ef69b22-baee-47c1-ac20-336698d78784) | Library choices and the Clean Architecture folder structure |
| 2026-06-14 | [بناء تطبيق ويب من فلاتر على GitHub Pages](https://claude.ai/chat/43def7de-4bd0-4a1f-adf2-04da48be5094) | Flutter web build, `--base-href`, `404.html` SPA fallback |
| 2026-06-16 | [شرح ملف README في flutter_native_splash](https://claude.ai/chat/59706c32-e566-4dc6-ba33-6e8dca9f5f9d) | Native splash setup per platform, asset pipeline, iOS color-space note |
| 2026-06-17 | [شرح ملف README لـ flutter_launcher_icons](https://claude.ai/chat/c8b6642e-8113-49d1-b353-4e31ad5b928e) | Launcher icon config, adaptive icons, generated icon assets |
| 2026-06-17 | [شرح ملف README لباكيدج rename](https://claude.ai/chat/7864bf57-5506-4804-b516-2ec9d9a34b62) | `rename setAppName` for ios/android/web |
| 2026-06-18 | [بناء تطبيق حجوزات فلاتر باستخدام spec kit](https://claude.ai/chat/a04e069c-f2cc-4262-bd3d-ef651547f4f6) | Spec Kit setup, CLAUDE.md / AGENTS.md / constitution prompts, core foundation, app identity, splash iteration |
| 2026-06-21 | [فهم بنية مشروع فلاتر من الصفر](https://claude.ai/chat/e1b870e1-4a68-4318-a552-3c6db24c8af4) | FlutterInit evaluation, splash regression and recovery, app-identity audit, CI/CD to GitHub Pages |
| 2026-06-21 | [شاشة اللوجن في مشروع سربينت](https://claude.ai/chat/bbd540a8-a8d3-448d-85af-ce0d8fd8c543) | `/specify` prompt and `/clarify` answers for the login UI |

Files generated inside those chats (for example `Sprint_Brand_Guidelines_v1.docx`, the wireframes HTML, the icon PNGs) are not stored in the repo. Download them from the chat and keep copies under `docs/` if they matter.
