# Opening a PR

Run at the end of every other playbook. Whether you may push and open the PR without asking comes from the repo's `approval-modes`.

**Worktree.** Work from a git worktree off trunk. Subagents each get their own worktree.

**Commits.** Commit often, then rebase into small ordered commits before opening. Each commit is a future PR: landable on its own and ordered to tell the story (subtraction, then reshape, then follow-on cleanup; failing test, then fix). Bodies don't restate the subject.

**Review depth.** Once the commits are in final shape, ask three questions. How bad is it if the change is wrong? Can you reverse its effects after deploy, not only revert the commit? Would tests catch it? Pick the tier from the answers and run its review. If the PR opened early, do this at the code-ready head. An explicit request for a specific review overrides the table.

| Risk if the change is wrong | Typical change | Review |
|---|---|---|
| None: no program or agent acts on what changed | Docs, copy or inert config | Run the repo's checks, no review |
| Low: the damage stays local, you can reverse its effects, and tests cover it | A small fix in one module | `/code-review low`, or your agent's equivalent |
| Moderate: behavior changes across modules, or tests are thin | A feature, a refactor or a shared helper | `/code-review medium`, or `/code-review high` if the tests are thin. Or your agent's equivalent |
| High: you can't reverse its effects, or it reaches other teams, external consumers or shared environments | Auth or permissions, sensitive data, migrations, shared state, deploy or infra, public APIs, deleting data or a capability others depend on | `/shinstack:blast-radius`, then `/shinstack:interrogate` |

- Any area in the High row sets High, whatever its size: a three-line auth change is High. In the other rows the typical changes are examples, so a large rename with good tests can be Low.
- If the tier is unclear, take the higher one. A repo's CLAUDE.md can add stricter rules.
- If a review was clearly too heavy, add a line to `~/.claude/shinstack-friction.md` (`date | opening-a-pr.md | what went wrong`, no code or private content).
- Fix proven blockers and re-check before opening. List the rest in the PR body.
- Don't repeat a review: re-run only for new behavior or a large new diff. A rebase or minor fix gets a single check at the new head.
- On a sensitive-data change, reviewers use synthetic data and runners from the same provider.
- If the review can't run (no subagents, or an unattended run blocked on a question), report it as not run. Never imply it ran.
- Say the tier, the review level and why in your reply, and name the tier and review in `## Verification`, so a later session can see them. This is the author's review. `autopilot.md` verification runs separately where `shipping.md` asks for it.

**Text.** Run the title, body and commit messages through `/shinstack:unslop`, and write to the standard in `/shinstack:technical-writing`.

**Title.** Conventional Commits `type(scope): subject`, no trailing period, imperative, naming a real symbol when one carries the change.

**Body.** A one-minute briefing for a reviewer who has the diff, using `##` headings in this order:
- `## Why`: the problem and approach, 1-3 short sentences.
- `## What changed`: 1-3 short bullets. Name both sides of a rename.
- `## Scope`: always. What it covers and what it deliberately leaves out.
- `## Tradeoffs`: only rejected alternatives a reviewer would otherwise ask about.
- `## Blast Radius`: who or what it touches, and why that is safe or risky.
- `## Verification`: 1-3 bullets, each a real run and its outcome. Perf: one number with its unit, `before -> after`.

If the PR finishes an issue, put `Closes #N` in the body. If it does only part of one, use `Refs #N`.

SHAs, lane recitals and file-by-file lists go in a linked artifact, not the body. Attach screenshots or video when they prove a claim.

**Ready, not draft.** Open every PR ready for review unless the project says otherwise.

**Size.** Prefer five narrow PRs to one large one. Stack a PR on another only when it truly builds on it (base it on the parent's branch, and move it onto trunk as the parent merges).

**Don't babysit on open.** Post the URL and keep building. A babysit pass runs when the user asks after the work exists, or when you are an `autopilot.md` owner (`babysit.md`).

**Forge.** Use the forge CLI the repo lives on (`gh` for GitHub). Where the repo's remote is somewhere colleagues see everything, follow the project's rules before pushing or opening anything.
