# shinstack v1: rebuild from Shin's principles (2026-11-15)

Status: accepted. Plan, usage numbers and the full keep/merge/delete table: issue #68 (steps: #69 eval, #70 router, #71 skills, #72 housekeeping, #73 measure).

## Why
- Most of shinstack was copied wholesale from pstack (21 principles, 22 skills, 18 playbooks); most of it was never used (transcripts since 2026-11-04: about 26 principles, 31 product principles, 30 skills and 9 playbooks had 0-3 sessions).
- What agents follow is what is inline in the router. Principle files were almost never opened.
- It contradicted Shin's own rules: a local friction log, a manual version bump, and the same rule copied across router, playbooks and principles.

## What it is now
- **Router** (`skills/craft`): Shin's rules 1-10 inline, a trigger list, and the `factory-role` contract. Under 120 lines and 9000 hook bytes (`scripts/check-router.sh`).
- **8 playbooks:** feature, bug-fix, refactoring, investigation, opening-a-pr, ship, coordinate, plan.
- **Skills kept:** brainstorm, blast-radius, interrogate, writing, recall, reflect, correct, init, and the 3 UI skills.
- **`taste/product.md`:** the 31 product principles in one file, read when scoping or writing an issue.
- **`scripts/router-eval.sh`:** six fixed prompts that check the router's behaviour.

## Merged, folded, deleted
- Merged: shipping + autopilot into `ship`; orchestrate + autonomous-run into `coordinate`; unslop + technical-writing into `writing`; multi-phase-plan rewritten as `plan`; 31 product principles into `taste/product.md`.
- Folded: babysit and pause-safely into router lines; ketchup and show-me-your-work into `recall`; the 21 general and engineering principles into router lines.
- Deleted: the zero-use playbooks (hillclimb, perf-issue, eval, visual-parity, prototype, worktree-cleanup), the other zero-use pstack skills, the language best-practice skills, the 4 situational principles, and the noodle setup (`.noodle.toml`, `.agents/`, `adapters/`).

## Housekeeping in #72
See `plugin-version-from-commit.md` (no version bump) and `friction-as-issues.md` (friction log).

## Consequences
- Older records in this folder that mention deleted files or the old friction log are history and are not rewritten.
- A week after #72 merges, #73 reruns `scripts/skill-usage.py`; anything still unused gets a delete issue.

> Amended 2026-11-17: the word "autopilot" now routes to `coordinate` (one task unattended), which asks for the `ship.md` verifier. That is a new trigger, not a change to where the old playbook was merged.
