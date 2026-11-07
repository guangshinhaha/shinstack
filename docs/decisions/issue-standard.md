# Every agent-built issue states an observable Done when

Date: 2026-11-07. Status: accepted. Tracked in #32.

## Decision

An issue an agent builds has these parts. Exact headings aren't required, as long as the issue states something observable. Existing issues stay as they are.

- **Goal:** why it matters and what should be true afterwards.
- **Done when:** something observable you can test.
- **Out of scope:** what the agent must not touch or add.
- **Decided / Assumed / Open:** only if any exist.
- **Where to look:** optional.

For the factory, the issue also needs a `ready` label, which is a person's permission to build it.

The rules:

1. **No Done when, no build.** `playbooks/feature.md` stops and says what is missing. The factory rejects the issue visibly instead of guessing (shinfactory#16).
2. **Words alone can't pass.** "README mentions the flag" is weak. "Running the command with the flag does X" is good. See `principles/product/no-criterion-satisfiable-by-a-sentence.md`.
3. **Proof goes in the PR.** The agent shows real runs in `## Verification`, and nobody re-ticks boxes. A different agent also tests the work against Done when in two places:
   - Inside the factory, the `quality` stage does it (shinfactory#16).
   - Outside the factory, only a High-risk PR gets this test, from the verifier in `playbooks/autopilot.md`.

Enforcement changed alongside the standard, and the review tiers did not:

- **The risk table stays.** Moderate gets no verifier, which matches `playbooks/shipping.md`.
- **A review that returns nothing counts as not run.** It can't clear the gate. A review that finds no problems must say what it checked, which is how the two cases differ.
- **Coordinator briefs state the tier, its required review, and that subagents are allowed.** Orca's worker preamble says "no subagents or helper workers unless the task asks", so a brief that doesn't ask leaves the review unrun.

## Where each part lives

| Part | Owner |
|---|---|
| How to write an issue, and how to build from one | shinstack |
| Rejecting an issue with no Done when, and testing against it at `quality` | shinfactory (shinfactory#16) |
| Nothing: judging whether a claim is true isn't a machine check, so `ac-check` is opt-in | gantry (gantry#30) |

## Why

The PR checklist only proved that boxes were ticked, because the agent ticks its own. Criteria stay in the issue and proof goes in the PR, as #28 concluded.

Three gantry PRs showed the gap in enforcement. gantry#33 and gantry#35 were High and never ran `interrogate`. The `/code-review low` on gantry#34 came back empty. gantry#35 merged under `auto` with a verifier but no `interrogate`, which breached the gate. A worker that reported it couldn't spawn subagents was following its default, not a technical limit.

## Rejected

- A different agent testing every PR outside the factory: it would add a verifier to Moderate and undo `merge-gate-follows-risk.md`. Hand-run work has no required step for it, and the cost doesn't scale with the risk.
- A required template or a machine check on issue format: a machine can check that a heading exists, not that the text under it can be observed.

## Consequences

- A Moderate or lower PR outside the factory can merge with no second agent testing it against Done when. Its author's review and real runs are the only evidence.
- A free-form Done when may turn out too loose. The shinfactory#3 trial answers this.
- The factory half of rules 1 and 3 doesn't exist until shinfactory#16 lands, so #32 stays open until then.
