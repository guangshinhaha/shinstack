---
name: milestone
description: "Set up a milestone: one goal and scope, issues ready to build, the order approved once, the user's hands-on items named, and the text to run it unattended. Use only when the user types /shinstack:milestone; never start it on your own, and no router line points here."
---

# milestone

Rules 3, 6, 7. Set a milestone up so `coordinate` can run it and `uat` can end it. You write the setup, you never build. The user approves the order once.

## Gate

- Factory station, or the user is away: stop. The order needs their yes.
- Creating a milestone and editing issues are shared writes: follow the repo's mode (router rule 2).

## Steps

1. **Goal and scope.** One goal in a line, what's in, what's out. More than one goal is more than one milestone. The milestone description holds all of it and the order below.
2. **Issues.** Each child meets `docs/decisions/issue-standard.md` (observable Done when, out of scope). Check every Done when against the code and the issue's comments: what it names exists and its premise is true (chippy#139 assumed a panel state that can never happen). An issue only a person can finish gets a "Live check" line in Done when, and the PR says `Refs #N`, never `Closes`, so the issue stays open for `uat`.
3. **Order.** Chosen on purpose: what unblocks what, cheapest checks first. List it in the description. It beats oldest-first. Show it once and take one yes. Items outside the milestone (the backlog) are not touched and not run.
4. **Hands-on.** Name the user's own work up front: live checks, real accounts, real config, anything the agent can't do. List it in the description; the unattended run skips it.
5. **Unattended run text.** For `/goal` or a Stop hook, an exit command over the milestone, for example `gh issue list --milestone <name> --state open`. A live check the agent can't do must not sit inside it, or the hook blocks forever: the repo marks those issues (Chippy uses a `hands-on` label) and the command excludes them. State the command and its expected output (empty), plus the escape hatch (`coordinate.md`).
6. **End.** The last step is `/shinstack:uat` once the issues merge. The milestone is done when it has run; the user closes it, never the agent.

**Reply:** the milestone link, the goal in one line, the order, the hands-on list, the exit command, and the one yes needed.
