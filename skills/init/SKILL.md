---
name: init
description: "Use when the user asks to set up, init or onboard shinstack in a repo, or a repo has no shinstack-mode declared. Writes a managed shinstack block (mode and check commands) into the repo's CLAUDE.md. Never commits or pushes."
---

# shinstack init

Rule 2: autonomy follows the repo's mode, so the repo must declare one. This writes one managed block in `CLAUDE.md`; re-running updates it in place.

1. **Find the check commands** a PR must pass (test, lint, typecheck) in `package.json`, `Makefile`, `scripts/`, CI workflows, lefthook or husky. Write one per line to a temp file. Invent none; an empty file writes "none found".
2. **Run the lever:** `sh <this skill's dir>/init.sh <repo-root> <checks-file> [mode]`. Mode defaults to `supervised` for a GitHub remote and `manual` otherwise; pass one only if the user named it.
3. **Show `git diff CLAUDE.md`** and stop. No commit, push or PR.

The script leaves everything outside `<!-- shinstack:begin/end -->` untouched and skips its own mode line when one is declared outside the block.

**Reply:** the mode and why, the commands found (or "none found"), the diff.
