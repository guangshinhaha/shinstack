# Review depth follows the risk of a wrong change

Date: 2026-11-07, recording a decision made on 2026-11-06 (#18). Status: accepted.

## Decision

The table in `playbooks/opening-a-pr.md` picks the review from the risk of a wrong change. That table is the source of truth, and this doc records why it has its shape.

- **Tiers come from three questions:** how bad is a wrong change, can you reverse its effects after deploy, and would tests catch it?
- **No fixed level for all code:** Low uses `/code-review low`. Moderate uses `medium`, or `high` if the tests are thin.
- **The High row's areas are a hard minimum:** auth, migrations and the others set High at any size. The typical changes in the other rows are examples.
- **"Reverse" means the effects, not the commit:** `git revert` can't undo written data, sent messages or a changed contract.
- **An unclear tier goes up:** agents rate their own changes, so this rule limits under-rating.

## How the table gets tuned

1. A review miss becomes one line in `~/.claude/shinstack-friction.md`. `bug-fix.md` logs a bug that a review should have caught, and `opening-a-pr.md` logs a review that was clearly too heavy.
2. `/shinstack:reflect` step 5 reads the log. When two or more lines point the same way at one file, it proposes an edit and waits for approval.
3. Single lines stay in the log, so one odd miss doesn't move a tier.

## Why

A fixed `/code-review medium` gave a one-line fix the same review as a new feature. The router also said `reflect` reads the friction log, but nothing read that file, so the table had no way to improve.

## Rejected

- High areas as examples: an agent could rate a small migration with a down script as Low and skip `/shinstack:blast-radius` and `/shinstack:interrogate`.
- Friction lines through the `reflect` reviewers: the reviewers and the synthesizer accept only findings about skills used in the current chat, so they would reject lines from earlier sessions. `reflect` reads the log itself.
- The logging rule for missed bugs in `opening-a-pr.md`: that step runs before the bug ships, so no agent is there when it surfaces.
- `max` and `ultra` in the table: they are the costliest reviews and need an explicit request, which already overrides the table.

## Consequences

- Agents still judge the Low tier for their own changes, so under-review stays possible. Friction lines are how we find out.
- The log can skew towards "too heavy" if agents forget to log missed bugs. Weigh that when you tune the table.
