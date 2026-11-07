# Shipping

**You own what lands. Land one PR at a time, each only after it clears the gate for its risk, then keep your hands off.** The gate and the numbered steps are for merging without a yes on each PR, so they apply only where `approval-modes` allows that (mode `auto`, or `shinstack-mode.merge: auto`). Otherwise stop when the PR is ready, or at `autopilot.md` stack mode if it ran under autopilot.

**The gate.** Take the PR's tier from the review table in `opening-a-pr.md`. An unclear tier goes up.
- *None, Low or Moderate:* at the current head, green CI (with no CI, run the repo's checks and paste the output), the review its tier names (an empty one counts as not run, see `opening-a-pr.md`), and no open blocking finding. It needs no verifier.
- *High:* all of that, plus a verdict from an independent verifier (`autopilot.md`).
- *Any tier:* check the PR for a verdict. The latest one must be `PASS` or `PASS+NOTES` and must still describe the code (step 3). A `FAIL` stops the merge until a newer verdict replaces it, whatever was pushed since.

**A merge the user approved.** In any mode, a user's explicit yes on one PR replaces the numbered steps, so a hand-built PR needs no verdict file. A PR that ran under `autopilot.md` still needs `PASS` or `PASS+NOTES` at its current head.
- Before merging, check for anything the user may not know: a commit pushed after their approval, red CI (if the repo has CI), an open blocking review finding, a missing or failed verdict, or a High-risk PR with no verdict. Run step 4's trunk check too. If you find any of these, stop and say what you found. A rebase changes the head, so it needs a new yes.
- Merge that one PR, pinned to the head you checked (`gh pr merge <pr> --squash --match-head-commit <sha>`, or the forge's equivalent). Another PR needs another yes.
- Read back the PR's state, merged time and base, and name the merged SHA in your reply. If the base isn't trunk, say the change hasn't reached trunk. If the PR closes an issue that is still open, say so.

1. **Clear the gate for each PR before it lands.** Where the gate needs a verdict, it is a file written by a verifier who isn't the author, at the PR's current head (`autopilot.md`).
2. **Land only the contiguous cleared run rooted at the bottom.** For stacked PRs, walk up from the lowest unmerged PR and stop at the first that hasn't cleared its gate. A cleared PR above an uncleared one waits. A PR whose branch neither holds nor needs the lower code may move onto trunk and land on its own.
3. **Re-check that each verdict you rely on still describes the code.** A rebase moves every PR above it to a new SHA without failing a check. Compare `git patch-id` at the verdict SHA with the current head before trusting an older verdict. A difference only in tests, docs or lint config can stand if what it ran builds the same at both.
4. **Merge right, then read it back.** Right before merging, fetch trunk and ask whether its changes can affect the patch. Rebase and wait for CI only when the code that would land was never tested (a conflict, a file both sides changed). Merge the lowest unmerged PR, pinned to the head you checked (`gh pr merge <pr> --squash --match-head-commit <sha>`, or the forge's equivalent). Confirm with the PR's state, merged time and base.
5. **Leave the stack alone while it lands.** Moving the next PR to trunk is the only change to a branch or base. Watch the run with a background watcher until it reaches the ceiling.
6. **Stop at the ceiling.** Extending the run means the next PR has to clear its gate first.

**Make it enforceable (factory):** the merge step is a wrapper that reads any verdict, checks `head_sha` and `patch-id`, and refuses on a `FAIL`, or where the tier needs a verdict and none exists. `release: manual` in policy keeps it off until a project is switched to auto.

**Reply:** the cleared run and its ceiling, each PR's tier and gate result, any verdict and who produced it, what landed and how you confirmed it, and what the next gap needs.
