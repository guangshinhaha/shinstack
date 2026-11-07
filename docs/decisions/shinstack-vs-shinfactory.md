# shinstack owns how, shinfactory owns when and who, gantry owns the checks

Date: 2026-11-06, recording a split made on 2026-11-05. Gantry added on 2026-11-07. Status: accepted.

## Decision

| Concern | Owner |
|---|---|
| How to do the work: principles, playbooks, craft skills, review standards | shinstack |
| When a stage runs, in what order, and what happens on failure | shinfactory |
| Who runs a stage: provider, model, runtime | shinfactory |
| Merging, PRs and worktrees inside a factory order | shinfactory (its `mode`) |
| Push, PR, merge and deploy outside the factory | shinstack (`approval-modes`) |
| Checks that need no judgment, shared across repos: secret scan, lint, tests, `ac-check`, the `needs-human` label | gantry |
| Whether a failed check blocks a merge: the required `gantry / ci-ok` check | gantry (`gantry-protect`) |
| Checks that only one repo needs, such as `check-router.sh` | That repo's own workflow or `lefthook.yml` |
| Knowledge about one project | That project's `CLAUDE.md` and `docs/` (for the factory itself, `brain/`) |

**The test for a new rule:** ask these in order and stop at the first yes.

1. Can a machine check it with no judgment? It goes in gantry.
2. Does it need a schedule, a stage or an event? It goes in shinfactory.
3. Would it still apply to one person running one agent session with no loop? It goes in shinstack.

**Dependency direction:** shinfactory depends on shinstack, never the reverse. shinstack must work with no factory installed. It mentions the factory only to step aside: the router's "Inside shinfactory" section and the matching line in `approval-modes`. Gantry depends on neither: its checks run on a repo whoever wrote the code, person or agent. shinstack and shinfactory must both work in a repo with no gantry.

**A merge needs both a green check and an approval.** Gantry decides whether the checks pass. `approval-modes` or the factory's `mode` decides whether the merge may happen. Neither one overrides the other.

## Worked example: review
- shinfactory decides that a `quality` stage follows `execute`, and which provider runs it.
- shinstack decides what counts as a finding (`interrogate`: a finding needs proof) and how deep review goes outside the factory (the table in `opening-a-pr.md`).
- gantry runs no review by default. Its `--review` option sends PR diffs to Anthropic, so a repo turns it on only after deciding its diffs hold no sensitive data.

## Where the code comes from
- `poteto/noodle` is upstream of shinfactory. `~/Desktop/projects/noodle-upstream` is a plain copy of it.
- A useful idea from noodle goes through the test above. A craft idea is rewritten in shinstack; it isn't copied into the factory.

## Why
Two rulebooks diverged and made cooks behave inconsistently. One source of truth for how to work removes that.

## Rejected
- Merge them into one repo: shinstack would stop being usable on its own, and upstream noodle updates would be harder to take.

## Consequences
- Craft changes land in shinstack even when a factory run exposed the problem.
- Exceptions that exist today are tracked as issues in the repo that owns the fix.
- A factory order merges to local main, so gantry first sees that work at push. The factory passes through gantry's merge gate only once its final stage opens a PR (shinfactory#6).
