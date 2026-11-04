# Worktree cleanup

**You own a safe sweep.** The one playbook that deletes work with no code review to catch a slip, so the gates below are the review. Needed once runs and agents leave worktrees behind.

1. **Snapshot and audit.** Record `df -h /`, then run `scripts/worktree-audit.sh [-b <base-ref>] [repo-path]`. It is read-only and prints one row per worktree: path, branch, whether it is merged into the base, counts of modified and untracked files, and days since the last commit.
2. **The bucket is advice, not permission.** `merged` with no modified or untracked files is safe. `wip:N` means N tracked uncommitted edits. `scratch:N` is untracked throwaway. Anything in use by a live session or a pushed-but-unmerged branch is held.
3. **Verify use before deleting.** For any row you doubt, check whether a running session or open PR uses it. When the audit and the user disagree, the user wins.
4. **Pause on irreversible loss.** Show the diff for `wip:N` and get a decision first: removing a clean worktree is recoverable from its branch, uncommitted work is gone. For `scratch:N`, name the files before dropping them.
5. **Prune the confirmed set** per path with `git worktree remove <path>` (add `--force` only for confirmed `scratch`), then `git worktree prune`. Branch refs survive, so commits are not lost. Confirm with `df -h /` and re-list.

**Reply:** disk before and after with the space reclaimed, the worktrees pruned, and a one-line reason for each held back.
