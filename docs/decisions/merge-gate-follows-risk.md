# The gate for an unattended merge follows risk

Date: 2026-11-07. Status: accepted.

## Decision

An unattended merge (mode `auto`, with no yes on that PR) needs what the PR's risk tier asks for. The tier comes from the table in `playbooks/opening-a-pr.md`, and the gate is in `playbooks/shipping.md`.

| Risk | What the merge needs |
|---|---|
| Low or Moderate | Green CI, the review for that tier, and no open blocking finding |
| High | All of that, plus an independent verifier and a verdict file |

- A verdict that exists must be `PASS` or `PASS+NOTES` at the current head, whatever the tier.
- Outside High risk, a verifier runs only when the user asks for `/shinstack:autopilot`. `orchestrate.md` follows the same rule.
- A yes on one PR still takes the lighter path in `shipping.md`.

## Why

`approval-modes.md` asked an `auto` merge for green CI and no blocking findings. `shipping.md` also asked for a verifier on every PR, so the two disagreed. Following the stricter one cost about 80k tokens to verify a 19-line CI file (#25). Under that rule, `auto` could cost more per PR than `supervised`, the opposite of why a repo would choose it.

## Rejected

- A verifier on every unattended merge: the cost doesn't scale with the risk, and a program of small PRs pays it each time.
- A verifier for any PR that ran under autopilot, as a rule in the merge gate: how a PR got built doesn't change its risk. Autopilot runs its own verifier because that is the playbook's job.
- No verifier at any tier: a High-risk change can't be reversed, and the author rates its own change.

## Consequences

- A Low or Moderate change can merge with only its author's review. In a repo on `auto`, no person or second agent looks at it.
- Agents rate their own tier, so under-rating can skip the verifier. An unclear tier goes up, and a miss becomes a friction line (`review-depth.md`).
