# Router rewrite: rules inline, principles collapsed

Date: 2026-11-15. Status: accepted. Plan and rationale: issue #68 (step 2 is #70).

## Decision
The router states Shin's rules 1-10 inline, with one line each for the engineering rules that earned one (root cause, model the data, test behaviour, idempotence, small verifiable units). The 21 general and engineering principle files, the 4 situational ones, and 13 playbooks and 30 skills with 0-1 uses are deleted. `shipping` and `autopilot` became `ship`, `orchestrate` and `autonomous-run` became `coordinate`, `multi-phase-plan` became `plan`, `babysit` and `pause-safely` became router lines. The 31 product principles became `taste/product.md`.

## Why
Principle files were almost never opened; the router line is what gets followed (#68). One copy of each rule.

## Consequences
- Under `auto`, a deploy still asks when it targets prod. The old approval-modes table let `auto` deploy anywhere, but #68 rule 2 says deploy and prod belong to the user. `docs/decisions/approval-modes.md` links to a deleted file; the decision stands.
- `check-router.sh` no longer checks principles; it checks the router's size (120 lines, 9000 hook bytes) and that every file it names exists.

> Amended 2026-11-17: the word "autopilot" now routes to `coordinate` (one task unattended), which asks for the `ship.md` verifier. That is a new trigger, not a change to where the old playbook was merged.
