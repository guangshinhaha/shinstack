---
name: recall
description: "Re-enter work cold: rebuild context from chat history, git, PRs and issues and hand back a short brief; catch the user up on a long chat with every call waiting on them; keep the decision trail for long or unattended runs. Use for 'recall', 'catch me up', 'where did I leave off', 'I lost the thread', 'what's waiting on me', and before resuming a branch or PR."
---

# Recall

Rule 1: anyone can re-enter cold and see goal, done and next. Pick the mode that fits, read only what it needs, then stop.

## Rebuild context (resuming, "where did I leave off")

1. **Lock the scope.** Window (default the last 7 days), topic if named, this workspace only. State it back. Never turn "all" into "recent N", and never read another project's transcripts unasked.
2. **Read the trail.** One named prior chat, branch or PR: read it, newest part first, then scan back for decisions. Otherwise find this workspace's transcripts (Claude Code: `~/.claude/projects/<slug>/*.jsonl`, `<slug>` is the path with every non-alphanumeric turned into `-`), order by `ls -t`, grep the topic, read only matching regions. Send big transcripts to a read-only subagent and keep the reduced result.
3. **Sweep the shared record** when the topic names a feature, file or bug: issues, PRs, reverts and chat for what is open, what was tried and didn't hold, what users still report. A null result is a finding; say which source was unavailable.
4. **Verify against live state** with `git` and `gh`: branch, what landed, open PRs, CI. A prior self-report is not proof; check the claim on the real artifact. Don't redo finished work.
5. **Write the brief:** a capsule (at most 5 bullets), threads (one line each, tagged `[merged #N]`, `[open PR #N]`, `[in flight <branch>]`, `[verified, uncommitted]`, `[reverted #N]` or `[planned, not started]`), problems (at most 5), and one next move. Cite chats by id and records by PR or issue number. Keep private context out of public output.

## Catch up on a long chat ("lost the thread", "what's waiting on me")

Read-only. Assume the user remembers their last message and nothing after it; subagent results and notifications are not their messages.

- Open with one sentence naming what waits on them, or saying nothing does.
- Then what changed for them, in plain words and short sentences, under 100 words: "the tests pass", not "CI is green". No hashes, paths or build numbers unless they need one to act.
- Then every call only they can make (product choice, approval, irreversible action, access you lack), including ones raised before their last message. Each item: link, what it changes for users, the evidence, its risk, and your pick, so they can decide from the reply alone (rule 3). Never invent a call, and never cut items to fit a word count.
- A picture only from what you captured: a screenshot, or a small diagram of a structure. Never draw a screen you didn't see.

## Decision trail (long or unattended runs)

A reviewer who wasn't there needs the why. Keep one line per decision point (rule 7, no log file): what was chosen, why, the evidence (SHA, PR, `file:line`), the result (`tests green`, `reverted`, `open`). Post them batched, one comment per milestone on the issue or PR, or a `Decided` section in the PR body, never one comment each. Log forks, pivots, reverts, blockers and finished units, not every action. Append only: a wrong call gets a later line that supersedes it. In a factory station, which can't comment on issues, put the trail in the final reply. Say what wasn't tested (rule 4).
