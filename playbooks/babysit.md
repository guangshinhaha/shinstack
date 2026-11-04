# Babysit a PR

**You own the merge frontier. Declare a mode, clear one PR at a time, and stop where the human's call begins.** Babysitting starts when the user asks (normally once a phase or a whole stack is built), or when you are an `autopilot.md` owner. Opening a PR never starts one. Landing is `shipping.md`.

1. **Declare the mode before polling.**
   - `drive`: run to merge-ready ("get it green", "merge-ready").
   - `background`: triage without blocking, for a plan still executing.
   - `threads-only`: answer review comments and touch nothing else.
2. **Work the merge frontier and nothing above it.** The lowest unmerged PR is the only one that matters until it merges. Read and batch upstack threads; don't fix them at the cost of restarting the frontier's checks.
3. **One babysitter per stack.** Check nothing else is already on it.
4. **Never change stack topology** from inside a babysit: no base retarget, rebase, or force-push. Fix on the owning branch and report anything rebase-shaped upward. (An `autopilot.md` owner babysitting its own PR is that owner.)
5. **Order: conflicts, then review threads, then CI.** Batch every known fix into one push wave. A conflict is the one blocker you report instead of resolve: say which branch needs the rebase and stop. Name the drift sweep in that report, since trunk may have grown callers of code the stack moves or deletes.
6. **Trust the forge's verdict, not a green list.** Ready means the forge says the PR can merge: checks green, mergeable, no unresolved blocking threads (`gh pr view --json mergeable,mergeStateStatus,reviewDecision`, `gh pr checks`). Re-read the PR and threads after every push; don't declare green from memory.
7. **Classify a CI failure before any retrigger.**
   - Flake or infrastructure earns **one** fresh build, never a blind job retry.
   - An identical second failure means it was never a flake: reclassify and read the logs.
   - A failure in code the diff never touched means a stale base. Check with `git merge-base --is-ancestor` and report that it needs a rebase instead of burning retries.
   - Only a failure in the diff's own code gets a commit.
8. **Review comments, bots included, are triaged skeptically:** fix, dismiss with a concrete reason, or ask. Verify each claim against the code. Fix real findings with a failing-test-first proof in the PR that owns the code. Reply on the thread with what changed.
9. **Stop at the human's line.** Babysitting never authorizes a merge; only an explicit request to merge or ship does, and that routes to `shipping.md`. Owner approval is a wait, not a blocker to fix. Surface it and keep working the rest.

**Reply:** PR state, what changed since the last check, what is blocking, and the single next action.
