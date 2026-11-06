# Opening a PR

Run at the end of every other playbook. Whether you may push and open the PR without asking comes from the repo's `approval-modes`.

**Worktree.** Work from a git worktree off trunk. Subagents each get their own worktree.

**Commits.** Commit often, then rebase into small ordered commits before opening. Each commit is a future PR: landable on its own and ordered to tell the story (subtraction, then reshape, then follow-on cleanup; failing test, then fix). Bodies don't restate the subject.

**Text.** Run the title, body and commit messages through `/shinstack:unslop`, and write to the standard in `/shinstack:technical-writing`.

**Title.** Conventional Commits `type(scope): subject`, no trailing period, imperative, naming a real symbol when one carries the change.

**Body.** A one-minute briefing for a reviewer who has the diff, using `##` headings in this order:
- `## Why`: the problem and approach, 1-3 short sentences.
- `## What changed`: 1-3 short bullets. Name both sides of a rename.
- `## Scope`: always. What it covers and what it deliberately leaves out.
- `## Tradeoffs`: only rejected alternatives a reviewer would otherwise ask about.
- `## Blast Radius`: who or what it touches, and why that is safe or risky.
- `## Verification`: 1-3 bullets, each a real run and its outcome. Perf: one number with its unit, `before -> after`.

SHAs, lane recitals and file-by-file lists go in a linked artifact, not the body. Attach screenshots or video when they prove a claim.

**Ready, not draft.** Open every PR ready for review unless the project says otherwise.

**Size.** Prefer five narrow PRs to one large one. Stack a PR on another only when it truly builds on it (base it on the parent's branch, and move it onto trunk as the parent merges).

**Don't babysit on open.** Post the URL and keep building. A babysit pass runs when the user asks after the work exists, or when you are an `autopilot.md` owner (`babysit.md`).

**Forge.** Use the forge CLI the repo lives on (`gh` for GitHub). Where the repo's remote is somewhere colleagues see everything, follow the project's rules before pushing or opening anything.
