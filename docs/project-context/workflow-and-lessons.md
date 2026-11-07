# Workflow and lessons learned

## Git flow
- One branch and one PR per feature, named `feature/<descriptor>`, branched from `develop` (or `main`).
- Merged so far: `feature/init-spec-kit`, `feature/core-foundation`, `feature/app-identity`, `feature/ci-cd-pages`.
- Spec Kit directories are numbered (`004-login-screen-ui`) but the git branch uses the feature name (`feature/auth-login`). They do not have to match.
- Never rewrite history on shared branches. Do not run `git rebase --root` (it rewrote 52 commits and detached the branch from `main`).
- Commits should carry the owner's identity. A fresh machine needs `git config --global user.name` and `user.email` first.

## Spec Kit sequence (strict)
`/speckit-specify` → `/speckit-clarify` → `/speckit-plan` → `/speckit-tasks` → `/speckit-implement`. The constitution comes first and rarely changes. `/plan` runs from the updated `spec.md` with no extra prompt.
Every `/specify` for a UI-only feature needs an explicit **Out of scope** section, otherwise agents add unrequested logic.

## Tool split
- OpenCode: implementation phases.
- Claude Code: planning, auditing, debugging.
- The owner does `git add`/staging and runs `flutter_native_splash`, `flutter_launcher_icons`, and `rename` himself when a prompt gave bad results.
- Before closing a branch, run a read-only audit prompt for: staging inconsistencies, hardcoded values that bypass tokens, orphaned ARB keys.

## Code standards
- Small single-responsibility widget files, not monolithic screens.
- Hardcoded `Color(0xFF...)`, raw `fontSize`, or spacing literals are defects. Intentional exceptions (for example Figma-spec badge padding 17/7) get an inline comment so nobody "fixes" them.
- Domain unit tests for every business rule. `flutter analyze` must stay clean (one known info: `axisAlignment` deprecation in `splash_screen.dart`).

## Working with AI agents (regressions that already happened)
- **Scope creep in migrations.** Moving the splash to `flutter_animate` destroyed the coordinated two-stage `AnimationController` timeline (bolt shrinks 0–600 ms, content reveals 600–1400 ms). Recovery: revert to the controller, keep only the glow fix, delete orphaned files, drop the package. Change one concern at a time and avoid prompts that imply rewrites.
- **Prescriptive prompts cause rollbacks.** Prefer "investigate and confirm the root cause, then fix".
- Use explicit read-only audit prompts before merging.

## Technical gotchas
- The original logo was a JPEG saved as PNG with an opaque black background. Sample the noise floor before choosing a chroma-key threshold.
- Android 12 adaptive-icon safe zone and the Android 12 splash mask are the same masking problem.
- iOS may render the splash background slightly differently from Android because of Display P3 vs sRGB in `LaunchScreen.storyboard`.
- After "Erase All Content and Settings" on a simulator, delete the app and rerun to clear the stale splash. `WFIsolatedShortcutRunner`/`ToolKitIndexer` log noise is unrelated to the app.
- GitHub Pages needs a public repo (or a paid plan). The `github-pages` environment must allowlist non-default branches.
- CI/CD: `develop` deploys to `Osman-Ibrahiem.github.io/sprint/` with `actions/upload-pages-artifact@v3` + `actions/deploy-pages@v4`, `--base-href "/sprint/"`, and a `404.html` SPA fallback for GoRouter deep links.

## Dependency upgrade notes (Nov 2026, PR #7)
- Riverpod 3 / riverpod_generator 4 / Freezed 4 / build_runner 2.17: `Ref` replaces `*Ref` typedefs; provider names drop the `Notifier` suffix (`localeProvider`, `themeModeProvider`, `loginFormProvider`); Freezed state classes need `abstract class`; guard async notifier methods with `if (!ref.mounted) return;`; tests that call async notifier methods must keep the provider alive (`container.listen(...)`).
- `build_runner` no longer accepts `--delete-conflicting-outputs`.
- Upgrade one package family at a time, one commit each. Never run `flutter pub upgrade --major-versions` without package names.
- iOS minimum deployment target is now 15.0.
- After pulling the upgrade on another machine: `flutter pub get`.
