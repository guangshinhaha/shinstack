# Coordinate

**You run the program, never the code. Decide which agent does each piece, then check what each one produces.** For a standing project of many tasks and PRs, or one task driven unattended to a checkable finish. Given a parent issue, its open child issues are the units, in the listed order; skip closed or checked children and turn each child's done condition into the proof of done in its kickoff. The queue lives in issues, PRs and branches (rule 7), never a .md file.

**One task, unattended**
- **Write the exit condition as a command and its expected output** before the first iteration: tests green, repro fixed, old API gone, N PRs merged. If you can't state it as a check, the task isn't scoped yet.
- **"Autopilot" means this section.** Wrap the playbook that fits the task (`/shinstack:bug-fix` for a bug, `/shinstack:feature`, `/shinstack:refactoring`); it writes the code, you drive the loop. An autopilot request also asks for the `ship.md` verifier on any tier. Outside `auto`, the exit condition tops out at merge-ready: stop and ask "merge #N?", since a handoff is not a merge yes (router rule 2).
- **Set the contract:** the goal, the exit condition, what you may do without asking (the repo's mode), and an escape hatch (stop and write up after a time budget or three failed pivots).
- **Work in an isolated worktree** off the base branch. Loop one change at a time: check the exit condition, make the smallest change the evidence justifies, verify against the real artifact, commit if it advanced and discard if not. A "might help" change is reverted, not left to ride.
- **A plateau means pivot, not stop.** Never relax the exit condition to declare victory. Past the budget, stop and write up what you tried, the evidence, and your best hypothesis.
- **Mid-run discoveries are yours** when they support the goal and are reversible; put out-of-band fixes in their own PR. Surface only irreversible actions, product calls no experiment settles, and dead ends.
- **Assume the session can die.** Commit each finished unit and push per the repo's mode, so a fresh agent can resume (`/shinstack:recall`). Keep the decision trail for the reviewer per the Decision trail section of `/shinstack:recall`.

**Topology (many tasks)**
- **One owner per PR.** The owner is the only writer of its branch and carries the PR from build to merge-ready. You never author or edit code; conflicts, rebases and fixes go back to owners.
- **A fresh worker per independent task**, each a builder (standard weight) in its own worktree, started as a subagent. Workers can't see siblings, so each kickoff carries everything it needs, with upstream reports pasted in full.
- **Two levels (coordinator, workers)** until one area needs many parallel workers; only then add a sub-coordinator that sends you one rollup. Keep a handful of workers in flight, not dozens.
- **Each High-risk PR gets a verifier who isn't its author** (`ship.md`), with the tier from `opening-a-pr.md`. Strong weight, independent: a different model family if the host has one, otherwise a fresh-context subagent.
- **Start with one unit.** Take it through kickoff, owner, review and merge-ready before fanning out, so a flawed kickoff costs one agent.

**Kickoff.** A kickoff is a brief: the playbook to follow plus task facts. It never restates the playbook's steps. The playbook is `/shinstack:feature` for an issue or spec, `/shinstack:bug-fix` for a bug, `/shinstack:refactoring` for a reshape. The task facts are the issue, the decisions already made, the tier you expect and its required review, the paths the worker may and may not write, the actions it must not take, and that subagents are allowed (a worker that defaults to none leaves the review unrun). For a PR that gets a verifier, say the verifier posts its own verdict comment in the exact JSON format and the owner never writes or transcribes one. Every kickoff names the proof of done: a command and its expected output, or an artifact. If you can't name the proof, the unit isn't scoped.

**Supervision (the part that goes wrong silently)**
- **Arm a recurring poll yourself** (Monitor or ScheduleWakeup) the moment work is delegated. Never say "I'll check back" without one set: nothing wakes you. Watchers report only on change.
- **Never report running, stuck or fine from a snapshot or an open port.** Check the process is alive, the age of the last event, failures since the last check, and each worker's liveness against its order's state. Judge by pushes and PR activity, not status text.
- **"No decision needed" names what you verified and when**, for example "workers 2/3 alive, last push 4 min ago, checked 14:05".
- **Confirm every orchestration send by an artifact** (a commit, a posted comment, a created file) and read its warnings. A send that returned without an artifact didn't happen.
- **Don't nudge a rate-limited worker.** Wait out the limit or replace it; a nudge burns its budget and adds nothing.
- **Read the diff, not the summary.** Green CI is an input to your judgment, not the judgment. Send back work that drifts from scope; park the rest as follow-ups.
- **Check live state before reporting** (`git log`, the forge CLI's PR view and checks). Account for every worker as done, replaced or absorbed.
- **Replace workers that stall.** Retry by cause: smaller scope after a context limit, same kickoff after a dropped connection, a different approach after a tool error. After two retries drop the unit and replan around it.
- **Ask the user only for a real decision or blocker:** an irreversible action, a product call no experiment settles, a dead end that survived a replan. Retries, CI flakes and review triage never reach the user, but a review that came back empty twice does.

**Make it enforceable (factory):** the program state lives in the factory's Orca Run (tasks and their dependencies), which `sf-state` reads, not in your context. Kickoffs are generated from a brief template with required fields, starting `factory-role: <station>`. gantry's `gantry-gate-evidence` rejects a build that returns without the named proof. The exit condition is a command the runner executes, not the agent's opinion; the iteration and time budget live in policy.

**Reply:** the exit condition or goal and where it stands, what landed, each PR's live state, tier and review result or verdict with its link, what was dropped and why, what was verified and when, and the decisions waiting on the user. When the open issues left hold only a live check, name `/shinstack:uat`.
