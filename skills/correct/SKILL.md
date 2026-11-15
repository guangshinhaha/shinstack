---
name: correct
description: "Make a repeated agent mistake impossible. Use when the user gives the same instruction or correction a second time, or asks to find the mistakes agents keep repeating in a repo. Fix at the highest level that works: architecture, then types, then a lint or CI check whose error names the fix, then a test, docs last. Use for /correct."
---

# Correct

Rule 8: the same correction twice means the repo allows the mistake. Change the repo, not the instruction. Assume every contributor is an agent that sees only the files it opened and copies the nearest example.

## Find the class

Read recent commits, reverts, review comments and workaround comments, plus the correction in front of you. A class counts once it has happened twice. Say which two cases.

## Fix at the highest level that works

1. **Architecture.** One owner per piece of state, one supported way per task, internals hidden so the wrong import fails, one source of truth in place of hand-synced lists. Delete old ways and dead code an agent would copy.
2. **Types, then a check.** Make the bad state unwritable. If bad code still compiles, add a lint or CI check whose error names the file, type or function to use instead. If the pattern is already common, fail only when a change adds more.
3. **A test** of the behaviour, not the internals.
4. **Docs or an agent rule last,** only for judgment calls. Nothing fails when an agent skips them, and a rule nothing enforces is the repeat you are fixing.

Then prove it: the new check must fail on the real past mistake. Run the same command locally and in CI. An exception goes on the offending line with a reason and an expiry date.

## When the fix is a CI check (lessons from PR #65)

- Ship the cost controls with it: cancel superseded runs (`concurrency`), set a `timeout-minutes`, no cron, and no path filters on a check that may become required (a skipped required check blocks merges). Check the plan's Actions minutes before you promise a merge gate (rule 9).
- A check is not a gate until it is a required status check. Until then call it advisory (rule 4).
- Get one independent review before merging your own change, and say which changes went unreviewed (rule 5).

**Reply:** each class with its two cases, the level you picked, and why a higher level didn't work.
