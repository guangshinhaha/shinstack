# Orchestrate

**You run the program, never the code. Decide which agent does each piece, then check what each one produces.** For a standing project of many tasks and PRs. One task driven to a check is `autonomous-run.md`. Given a parent issue, its open child issues are the units, in the listed order. Skip closed or checked children, and turn each child's done condition into the proof of done in its kickoff.

**Topology**
- **One owner per PR.** The owner is the only writer of its branch and carries the PR from build to merge-ready. You never author or edit code; conflicts, rebases and fixes go back to owners.
- **A fresh worker per independent task**, each in its own worktree, started as a subagent. Workers can't see siblings, so each kickoff carries everything it needs, with upstream reports pasted in full.
- **Two levels (coordinator, workers)** until one area needs many parallel workers; only then add a sub-coordinator that sends you one rollup. Keep a handful of workers in flight, not dozens.
- **Each PR gets a verifier who isn't its author** (`autopilot.md`). Use a second model family for it if you have one; otherwise a fresh-context subagent.
- **Start with one unit.** Take it through kickoff, owner, verifier and merge-ready before fanning out, so a flawed kickoff costs one agent.

**Supervision**
- **Every kickoff names the proof of done** (a command and its expected output, or an artifact), the goal, the build playbook to follow (`/shinstack:feature` for an issue or spec, `/shinstack:bug-fix` for a bug, `/shinstack:refactoring` for a reshape), the paths the worker may and may not write, and the actions it must not take. If you can't name the proof, the unit isn't scoped.
- **Read the diff, not the summary.** Green CI is an input to a verdict, not a verdict. Send back work that drifts from scope; park the rest as follow-ups.
- **Check live state before reporting** (`git log`, the forge CLI's PR view and checks), not the worker's last message. Account for every worker as done, replaced or absorbed.
- **Replace workers that stall.** Judge by pushes and PR activity, not status text. Retry by cause: smaller scope after a context limit, same kickoff after a dropped connection, a different approach after a tool error. After two retries drop the unit and replan around it.
- **Ask the user only for a real decision or blocker:** an irreversible action, a product call no experiment settles, a dead end that survived a replan. Retries, CI flakes and review triage never reach the user.

**Make it enforceable (factory):** the program state lives in a file (`run.json`-style) a validator can read, not in your context. Kickoffs are generated from a template with required fields. A worker that returns without the named proof is rejected by the runner.

**Reply:** what landed against the goal, each PR's live state and verdict with its link, what was dropped and why, and the decisions waiting on the user.
