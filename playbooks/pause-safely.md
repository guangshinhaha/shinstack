# Pause safely

**You own a clean stop. Leave a checkpoint a cold-start agent can resume from.** Explicit only: on "keep going" or "don't stop", do not pause. In the software factory this is the agent-side half of a resumable park.

1. **Stop at a safe boundary.** Finish the current atomic step or back out of it. Start nothing new and cancel any nested subagents.
2. **Take no irreversible action to pause.** No PR and no push unless one was already out.
3. **Make the work durable.** Commit uncommitted edits as one clear `wip:` commit on the current branch. If the tree is broken, say so in the commit body in one line.
4. **Write the resume note off-context** to a file (`.audit/<task-slug>-resume.md`, kept out of git): intent, what you were doing, progress and what is verified, current state, next steps, key files, gotchas. If a decision log exists (`/shinstack:show-me-your-work`), point at it instead of copying it.

**Reply:** where you are in the loop, what is on disk versus still in your head (paths, no diff dumps), the commits you made and whether the tree is clean, and the first action on resume. This is a pause, not a final report.
