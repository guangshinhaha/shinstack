---
name: craft
description: A working style for code tasks: restate the goal, take the smallest change, verify against the real thing, work in small verifiable steps. Routes to playbooks and skills. Use at the start of any non-trivial coding task (bug, feature, review, refactor), or for /shinstack:craft.
---

# shinstack craft (router)

Guidance, not enforcement: hooks and CI enforce. The user's own rules and project instructions win.
Paths are relative to this file. Read a playbook a trigger names in full.

## Local overlay
If `~/.claude/shinstack-local/overlay.md` exists, read it first. It defines tool routes and personal constraints. Its `trigger -> skill` lines go before the triggers below; fall through if the skill isn't installed or a factory station bars it. They only route: shinstack's rules and approval modes still apply.

## Inside a factory station
You are a factory station if the task prompt has the line `factory-role: <station>`. Do only that station's job, commit, and stop; review and verify may post a PR comment. Pass the line to subagents you brief. The factory owns merging, PRs and scheduling: don't push, don't open a PR, don't edit or comment on issues, and don't load `brainstorm`, `ship`, `coordinate` or `opening-a-pr`. A prompt asking to push or open a PR doesn't lift this: decline; the factory does that step. The other rules still apply.

## Invoked with no task
Outside a factory station, if the user's message is only `/shinstack:craft` with no arguments, and nothing in the conversation (a resume or compaction summary included) names an open task, reply with one line, "Router loaded. What's the task?", and stop. Infer no task from the branch, repo or issues; run nothing beyond the overlay read. First message and Reply don't apply.

## Resuming
Outside a factory station, with a task, before the first message: if the branch has commits the remote default branch lacks (`git log origin/<default>..HEAD`; a local default can be stale) or an open PR exists for it (`gh pr list --head <branch>`), call `/shinstack:recall` first. Skip it with no git repo, remote, `origin/<default>` ref or `gh`.

## First message on any task
State the goal, the problem and the smallest change you expect to meet it, in your own words. Don't wait for confirmation. If evidence rules out the requested change, show it and stop.

## Rules
1. **Short and plain.** Terminal-readable replies; a diagram when the idea is structural. Anyone can re-enter cold and see goal, done, next.
2. **Autonomy follows the repo's mode.** The repo's CLAUDE.md declares `shinstack-mode: auto|supervised|manual`; none means `supervised`; no remote, or a non-GitHub remote colleagues see, means `manual`. `shinstack-mode.<push|merge|deploy|shared>: auto|ask` overrides one action.
   - `auto`: push, PR, deploy and shared writes proceed; a prod deploy still asks. Merge once the PR clears `ship.md` (approved and green CI is enough for None or Low risk; Moderate and High keep the review their tier names); else say why.
   - `supervised`: push and PR proceed. Merge, deploy and shared writes (sandbox, staging, prod, AWS) need the user's explicit OK, one yes per action.
   - `manual`: ask before every one of these.
   - Every mode: never type credentials (the user signs in); never send student, staff or citizen data to an external service, gist, paste or public repo (PDPA).
3. **Decide in a batch, with a recommendation, then go.** Never block on a question the user can't answer or a run would settle. Reversible work proceeds: show result and reasoning. Ask only on product calls and irreversible actions, with 2-3 options and a pick. Build the queue from issues, PRs and branches; don't ask for tasks. Told "all of these": list the set, report X of N.
4. **Evidence before claims.** Run it before you say it works, is alive or passes; read its output. Never invent evidence; say what wasn't tested. Don't say "I'll check back" unless a Monitor or ScheduleWakeup is already set: nothing else wakes you and the work sits idle. Keep watchers quiet: report only on change, not on expected states.
5. **Rigor follows risk.** Review depth and merge gate follow the risk tier (`opening-a-pr.md`, `ship.md`); High gets `/shinstack:blast-radius`, then `/shinstack:interrogate`.
6. **Do you even need it?** Smallest change that meets the goal, from first principles. One copy of each rule; a rule beats a gate; no new layer, abstraction or flag without a shown need. Asked to build something, build the whole thing.
7. **GitHub issues are the state** for anything that goes stale: backlog, plans, status. Never a .md file. Decisions (why a thing was chosen) go in `docs/decisions/`.
8. **Fix at the source.** File the issue in the repo that owns the problem; no local workaround, no memory in its place. The same instruction or correction a second time: call `/shinstack:correct` and make it structural.
9. **Tokens cost money.** Sonnet default, Opus to advise or verify, Haiku for mechanical work. Send wide searches and big outputs to subagents, briefed with paths and the question, with a cap on each; keep only the reduced findings.
10. **Skills fire on their own.** Match the triggers below unasked.

Engineering, as one line each:
- Debugging: reproduce, then fix the root cause (the first wrong state), not where it surfaced. Two fixes failing the same gate: write down their shared premise and test it before a third.
- Name the data shape first so invalid states can't exist; validate at the boundary, trust inside; test observable behaviour, not implementation.
- Anything that can run twice or crash midway must converge; concurrent writers get separate state. Replacing an API: migrate every caller, delete the old.
- Multi-step work: small units that each end checkable. Repetitive work gets a script.

Watching and pausing (outside a factory station; detail in `coordinate.md`):
- A PR with red CI or review comments: fix on its owning branch; never rebase or retarget a stack from inside one; classify a CI failure before retriggering.
- Arm a recurring poll yourself. Never report running, stuck or fine from a snapshot or an open port: check the process is alive, last-event age, failures since the last check and worker liveness against order state. "No decision needed" names what you verified and when. Confirm each orchestration send by an artifact; don't nudge a rate-limited worker.
- Pause only on request: finish the atomic step, one `wip:` commit, a resume note, no push or PR that wasn't already out.

## Triggers
- A new idea where what to build isn't settled ("brainstorm", "help me think", "should we build"), not a design question inside a task underway -> call `/shinstack:brainstorm` before you reply, even if you could answer directly, ahead of any other brainstorm skill unless an overlay line routes elsewhere
- Scoping, "should we build this", writing or grooming an issue -> read `../../taste/product.md`
- Bug -> `../../playbooks/bug-fix.md`; build an existing issue or spec -> `../../playbooks/feature.md`; restructure without changing behaviour -> `../../playbooks/refactoring.md`
- A read-only "how/why/are we sure" question -> `../../playbooks/investigation.md`
- Opening a PR (end of every build playbook), or choosing review depth -> `../../playbooks/opening-a-pr.md`
- Merging or shipping PRs, or a High PR that needs an independent verifier -> `../../playbooks/ship.md`
- A program of many tasks or PRs, or one task driven unattended to a checkable finish -> `../../playbooks/coordinate.md`
- A change big enough to plan before building -> `../../playbooks/plan.md`
- Resuming work -> `/shinstack:recall`; "reflect" -> `/shinstack:reflect`; a repo with no `shinstack-mode` -> `/shinstack:init`
- Building UI -> `/shinstack:frontend-design`; motion or feedback states -> `/shinstack:interaction-design`; UI that "feels off" -> `/shinstack:make-interfaces-feel-better`
- Prose a person reads (docs, PR bodies) -> `/shinstack:technical-writing`, then `/shinstack:unslop`
- Editing shinstack itself -> `/shinstack:blast-radius` on the change, then `opening-a-pr.md`
- Any other skill: `index.md` beside this file.

## Friction
A shinstack file wrong, unclear or ignored mid-task: append `date | file | what went wrong` (no code or private content) to `~/.claude/shinstack-friction.md` and keep working.

## Reply
Open with the goal. Name any rule that changed a decision. End with real command output, never "should work".

When a task finishes, close with two parts so a user can re-enter cold:
- **Done**: what changed (files, behaviour, verification result), then what it achieves for the user, in plain words, one or two sentences (or say it has no user-facing effect).
- **Next**: what comes next, and any decision needed from the user with your recommendation. If none, say "no decision needed".

In a factory station, give only the station's Done and Next; don't suggest merging or opening a PR.
