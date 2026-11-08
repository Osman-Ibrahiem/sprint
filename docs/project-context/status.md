# Status (snapshot: 2026-11-07)

Update or delete this file as the project moves. Check `git log` and `specs/` for the truth.

## Where the work is
- Active feature: login screen UI on `feature/auth-login`, spec `specs/004-login-screen-ui/`. UI only with mock behavior, no auth logic. Check `tasks.md` for what is checked off before resuming `/implement`.
- Open PR: [#7](https://github.com/Osman-Ibrahiem/sprint/pull/7) `chore/upgrade-deps` into `feature/auth-login` (dependency upgrade, see `workflow-and-lessons.md`). The final `flutter test` run on its last commit still had to be confirmed.
- CI/CD live: `develop` deploys to GitHub Pages. `master`/production deploy is deferred.
- The project runs on Android, iOS, and web.

## Open questions
1. **Which Figma file is canonical?** Two keys appear in the chats: `jDJkupRwurbY5DoUZOG8dF` (22-screen UI file built 2026-06-09) and `WU6HvS85C8F8U0f468VWVf` (screen designs used during splash and login work). Confirm with the owner and record the answer in `CLAUDE.md`.
2. Whether the Register screen is in scope soon (designed in Figma, not in the login spec).
3. The cancellation-fee and discount numbers in the Figma mocks are unconfirmed placeholders.
4. Optional cleanup: the `axisAlignment` deprecation in `splash_screen.dart` (do it in its own commit, verify the animation visually).

## Next likely steps
Finish and merge login UI, then home (guest and logged-in), booking flow, payment, trainer dashboard, admin dashboard. Supabase auth comes after the UI-first phase.

## Machine notes
Development moved to a second Mac in Nov 2026. `.claude/settings.local.json` and `.opencode/` are git-ignored and were not carried over; regenerate or copy them if needed.
