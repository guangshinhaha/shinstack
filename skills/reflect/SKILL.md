---
name: reflect
description: "Review the current conversation for lessons and file each as a GitHub issue in the repo that owns the cause (label `friction` for shinstack). Writes no local file. Use when the user says reflect."
---

# Reflect

Rule 8: fix at the source. Turn what went wrong in this conversation into issues in the repos that own the problem, not a local note, memory or workaround.

Skip a trivial or off-topic conversation. One-offs are not lessons: a lesson is a mistake, ignored instruction or unclear file that cost real time, or one the user corrected.

1. **Find the transcript.** This workspace only: `~/.claude/projects/<slug>/<session>.jsonl`, `<slug>` the path with every non-alphanumeric turned into `-`, newest first (`ls -t`), confirmed by the opening user prompt. Never glob across projects. If none matches, work from what is in context.
2. **Draft lessons.** One pass, by you or one read-only subagent for a long transcript. Each lesson: what happened (cite the turn), the owning file or repo, and the fix. Then argue against each one: was it a one-off, already covered, or the user's own call? Drop what doesn't survive. A lesson a script, lint rule or test would enforce says so (see `/shinstack:correct`).
3. **Route.** The owner is the repo whose file, tool or process caused it, not the repo you happened to be in. A wrong or ignored shinstack file goes to `guangshinhaha/shinstack` with the `friction` label.
4. **Check visibility** with `gh repo view <repo> --json visibility`. A public repo's issue holds no code, no private content and no student, staff or citizen data (PDPA). Describe the behaviour, name the file.
5. **File.** `gh issue create --repo <repo> --title ... --body ...` (add `--label friction` for shinstack; the label exists), body: what happened, the file, the proposed change, and what would show it fixed. Search open issues first and comment on a duplicate instead. Filing is a shared write, so it follows rule 2: proceed in an `auto` repo; otherwise show the drafts as one batch with a recommendation and ask once.
6. **Old log.** If `~/.claude/shinstack-friction.md` exists, file its lines the same way, then tell the user the file can be deleted. Don't edit it.

**Reply:** the issue links, one line each; what was dropped and why; anything not filed and the one decision needed.
