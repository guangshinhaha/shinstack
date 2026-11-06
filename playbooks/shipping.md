# Shipping

**You own what lands. Land only the verified run, one PR at a time, then keep your hands off.** Only where `approval-modes` lets you merge (mode `auto`, or `shinstack-mode.merge: auto`). Otherwise stop at `autopilot.md` stack mode.

1. **Verify each PR independently before it lands** (`autopilot.md`): a verdict file per PR, written by a verifier who isn't the author, at the PR's current head.
2. **Land only the contiguous verified run rooted at the bottom.** For stacked PRs, walk up from the lowest unmerged PR and stop at the first without `PASS` or `PASS+NOTES`. A verified PR above an unverified one waits. A PR whose branch neither holds nor needs the lower code may move onto trunk and land on its own.
3. **Re-check that each verdict still describes the code.** A rebase moves every PR above it to a new SHA without failing a check. Compare `git patch-id` at the verdict SHA with the current head before trusting an older verdict. A difference only in tests, docs or lint config can stand if what it ran builds the same at both.
4. **Merge right, then read it back.** Right before merging, fetch trunk and ask whether its changes can affect the patch. Rebase and wait for CI only when the code that would land was never tested (a conflict, a file both sides changed). Merge the lowest unmerged PR (`gh pr merge <pr> --squash`, or the forge's equivalent). Confirm with the PR's state, merged time and base.
5. **Leave the stack alone while it lands.** Moving the next PR to trunk is the only change to a branch or base. Watch the run with a background watcher until it reaches the ceiling.
6. **Stop at the ceiling.** Extending the run needs new verdicts, so it is a new pass through `autopilot.md`.

**Make it enforceable (factory):** the merge step is a wrapper that reads the verdict file, checks `head_sha` and `patch-id`, and refuses otherwise. `release: manual` in policy keeps it off until a project is switched to auto.

**Reply:** the verified run and its ceiling, each PR's verdict and who produced it, what landed and how you confirmed it, and what the next gap needs.
