# shinstack owns how, shinfactory owns when and who

Date: 2026-11-06, recording a split made on 2026-11-05. Status: accepted.

## Decision

| Concern | Owner |
|---|---|
| How to do the work: principles, playbooks, craft skills, review standards | shinstack |
| When a stage runs, in what order, and what happens on failure | shinfactory |
| Who runs a stage: provider, model, runtime | shinfactory |
| Merging, PRs and worktrees inside a factory order | shinfactory (its `mode`) |
| Push, PR, merge and deploy outside the factory | shinstack (`approval-modes`) |
| Knowledge about one project | That project's `CLAUDE.md` and `docs/` (for the factory itself, `brain/`) |

**The test for a new rule:** would it still apply to one person running one agent session with no loop? If yes, it goes in shinstack. If it needs a schedule, a stage or an event, it goes in shinfactory.

**Dependency direction:** shinfactory depends on shinstack, never the reverse. shinstack must work with no factory installed. It mentions the factory only to step aside: the router's "Inside shinfactory" section and the matching line in `approval-modes`.

## Worked example: review
- shinfactory decides that a `quality` stage follows `execute`, and which provider runs it.
- shinstack decides what counts as a finding (`interrogate`: a finding needs proof) and how deep review goes outside the factory (the table in `opening-a-pr.md`).

## Where the code comes from
- `poteto/noodle` is upstream of shinfactory. `~/Desktop/projects/noodle-upstream` is a plain copy of it.
- A useful idea from noodle goes through the test above. A craft idea is rewritten in shinstack; it isn't copied into the factory.

## Why
Two rulebooks diverged and made cooks behave inconsistently. One source of truth for how to work removes that.

## Rejected
- Merge them into one repo: shinstack would stop being usable on its own, and upstream noodle updates would be harder to take.

## Consequences
- Craft changes land in shinstack even when a factory run exposed the problem.
- Exceptions that exist today are tracked in shinfactory's issues.
