# Friction goes to GitHub issues (2026-11-15)

Status: accepted. Part of #68 (rules 7 and 8), done in #72.

## Decision
When a shinstack file is wrong, unclear or ignored mid-task, the agent files a `friction`-labelled issue in guangshinhaha/shinstack (router, Friction section). It no longer appends to `~/.claude/shinstack-friction.md`. `reflect` files the same way. The repo is public, so an issue holds the file and what went wrong, never code or private content.

## Why
A local file is invisible to the repo that owns the fix, and nothing read it (see `review-depth.md`). Issues are the state for anything that goes stale, and the fix belongs at the source.

## Consequences
- `bug-fix.md` and `opening-a-pr.md` still send review misses and too-heavy reviews to friction; they now mean an issue.
- The two lines in the old local log were filed as issues; the file itself is deleted by hand after the PR merges.
- `review-depth.md` and `merge-gate-follows-risk.md` mention the old log and are not rewritten.
