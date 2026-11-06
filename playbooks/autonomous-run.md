# Autonomous run

**You own the exit condition. Define done, then drive to it without stopping.** For one task worked unattended. A standing program of many tasks is `orchestrate.md`.

1. **Write the exit condition as a command and its expected output** before the first iteration: tests green, repro fixed, old API gone, N PRs merged. If you can't state it as a check, the task isn't scoped yet. Ask once, then start.
2. **Set the contract:** the goal, the exit condition, what you may do without asking (the repo's `approval-modes`), and an escape hatch (stop and write up after a time budget or after three failed pivots).
3. **Work in an isolated worktree** off the base branch, so nothing else you have open collides with the run.
4. **Loop, one change at a time.** Check the exit condition. Make the smallest change the evidence justifies. Verify against the real artifact (prove-it-works). If it advanced, commit; if not, discard it. Write one decision row (`/shinstack:show-me-your-work`). Never stack untested changes. A "might help" change is reverted, not left to ride.
5. **Wake on events, with a heartbeat.** Watch what can change (CI, a merge, a ref) with a background watcher, and add a long scheduled heartbeat as the fallback. With no event to watch, size a fixed heartbeat to when the result can change. Inside the software factory the waker (`tick`) does this.
6. **Mid-run discoveries are yours** when they support the goal and are reversible: a broken skill, a related bug, a flaky check. Put out-of-band fixes in their own PR. Surface only irreversible actions, product calls no experiment settles, and dead ends.
7. **A plateau means pivot, not stop.** Never relax the exit condition to declare victory. Past the budget, stop and write up what you tried, the evidence, and your best hypothesis.
8. **Assume the session can die.** Commit each finished unit and push per the project's rules, so a fresh agent can resume from the log (`/shinstack:recall`, session-state).

**Make it enforceable (factory):** the exit condition is a command the runner executes, not the agent's opinion. The iteration and time budget live in policy. Log rows are validated.

**Reply:** the exit condition, iterations run, what landed, what was discarded, the final state of the check.
