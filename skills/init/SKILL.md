---
name: init
description: "Use when the user asks to set up, init or onboard shinstack in a repo, or a repo has no shinstack-mode declared. Writes a managed shinstack block (mode and check commands) into the repo's CLAUDE.md. Never commits or pushes."
---

# shinstack init

Set up shinstack in the current repo: one managed block in `CLAUDE.md`. Re-running updates it in place.

1. **Find the check commands** by reading the repo: `package.json` scripts, `Makefile`, `scripts/`, CI workflows, lefthook or husky config. Pick what a PR must pass (test, lint, typecheck). Write one command per line to a temp file. Don't invent any; an empty file writes "none found".
2. **Run the lever:** `sh <this skill's dir>/init.sh <repo-root> <checks-file> [mode]`. Mode defaults to `supervised` for a GitHub remote and `manual` otherwise. Pass a mode only if the user named one.
3. **Show `git diff CLAUDE.md`** and stop. Do not commit, push or open a PR.

The script keeps everything outside `<!-- shinstack:begin/end -->` untouched, and skips its own mode line when `shinstack-mode:` is already declared outside the block.

**Reply:** the mode chosen and why, the commands found (or "none found"), the diff.
