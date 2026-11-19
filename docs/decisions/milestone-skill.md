# Setting up a milestone is a manual-only skill

Date: 2026-11-19. Status: accepted. Tracked in #93.

## Decision
`/shinstack:milestone` sets a milestone up: one goal and scope, issues that meet `issue-standard.md`, an order the user approves once, the user's hands-on items named, and the text for an unattended run. It has no router trigger and no playbook, and its description says to use it only when the user types it. The user types it. `coordinate` runs the milestone; `uat` ends it.

## Why
Chippy v1.4 and v1.5 were set up by hand the same way each time, and the setup caught real mistakes (chippy#139's live check assumed a state that can never happen; a goal that includes a live check blocks a Stop hook forever). A usage count over Nov 17-19 showed `plan` fired in no session, so a milestone row in `plan.md` would not be read. `brainstorm` was rejected too: it sizes an idea, a milestone is already decided.

## Choices
- **Manual by description, not by flag.** `check-router.sh` bans `disable-model-invocation` (every skill fires on its own, rule 10, since 2026-11-06), so a hard block would first mean lifting that check; not decided here. Milestones are rare and the user knows when one starts. A trigger would fire on any talk of "milestone" and cost router bytes, of which about 90 are free, measured at an install-length path.
- **The marker is the repo's.** shinstack defines no label. An exit command over agent-doable work needs the user's issues marked, so the skill uses the repo's marker (Chippy: `hands-on`) or proposes one with the order's one yes.
- **Not decided here.** Whether `coordinate` should accept a milestone as the parent beyond what it says today, and the `Refs` and `hands-on` rules in `feature.md`. Both wait for a Chippy v1.6 run with this skill.
