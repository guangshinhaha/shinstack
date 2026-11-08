# Orchestrate

**You run the program, never the code. Decide which agent does each piece, then check what each one produces.** For a standing project of many tasks and PRs. One task driven to a check is `autonomous-run.md`. Given a parent issue, its open child issues are the units, in the listed order. Skip closed or checked children, and turn each child's done condition into the proof of done in its kickoff.

**Topology**
- **One owner per PR.** The owner is the only writer of its branch and carries the PR from build to merge-ready. You never author or edit code; conflicts, rebases and fixes go back to owners.
- **A fresh worker per independent task**, each a builder (standard weight) in its own worktree, started as a subagent. Workers can't see siblings, so each kickoff carries everything it needs, with upstream reports pasted in full.
- **Two levels (coordinator, workers)** until one area needs many parallel workers; only then add a sub-coordinator that sends you one rollup. Keep a handful of workers in flight, not dozens.
- **Each High-risk PR gets a verifier who isn't its author** (`autopilot.md`), with the tier from the table in `opening-a-pr.md`. The verifier is strong weight and independent of the author: a different model family if the host has one, otherwise a fresh-context subagent. Any other PR gets its tier's review and no verifier, unless the user asked for `/shinstack:autopilot`.
- **Start with one unit.** Take it through kickoff, owner, review and merge-ready before fanning out, so a flawed kickoff costs one agent.

**Supervision**
- **A kickoff is a brief: the playbook to follow plus task facts. It never restates the playbook's steps.** The playbook is `/shinstack:feature` for an issue or spec, `/shinstack:bug-fix` for a bug, `/shinstack:refactoring` for a reshape; the worker loads it and its own steps govern. The task facts are the issue, the decisions already made, the tier you expect and its required review, the paths the worker may and may not write, the actions it must not take, and that subagents are allowed (a worker that defaults to none leaves the review unrun).
- **Every kickoff names the proof of done:** a command and its expected output, or an artifact. If you can't name the proof, the unit isn't scoped.
- **Read the diff, not the summary.** Green CI is an input to your judgment, not the judgment. Send back work that drifts from scope; park the rest as follow-ups.
- **Check live state before reporting** (`git log`, the forge CLI's PR view and checks), not the worker's last message. Account for every worker as done, replaced or absorbed.
- **Replace workers that stall.** Judge by pushes and PR activity, not status text. Retry by cause: smaller scope after a context limit, same kickoff after a dropped connection, a different approach after a tool error. After two retries drop the unit and replan around it.
- **Ask the user only for a real decision or blocker:** an irreversible action, a product call no experiment settles, a dead end that survived a replan. Retries, CI flakes and review triage never reach the user, but a review that came back empty twice does.

**Make it enforceable (factory):** the program state lives in a file (`run.json`-style) a validator can read, not in your context. Kickoffs are generated from a template with required fields. A worker that returns without the named proof is rejected by the runner.

**Reply:** what landed against the goal, each PR's live state, tier and review result or verdict, with its link, what was dropped and why, and the decisions waiting on the user.
