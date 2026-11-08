---
name: craft
description: A working style for code tasks: restate the goal, take the smallest change, verify against the real thing, work in small verifiable steps. Routes to principles and playbooks. Use at the start of any non-trivial coding task (bug, feature, review, refactor), or for /shinstack:craft.
---

# shinstack craft (router)

A guidance layer. Hooks and CI enforce; this advises. The user's own rules and any project instructions always win.
Paths are relative to this file: `../../principles/general/` (how to work on anything, always applies), `../../principles/engineering/` (code), `../../principles/product/` (scoping, what to build), each with a `situational/` subfolder for rules that only fit some contexts; `../../playbooks/` (bug-fix, feature, babysit, autonomous-run, orchestrate, autopilot, shipping, pause-safely, opening-a-pr, refactoring, investigation, prototype, multi-phase-plan, worktree-cleanup, perf-issue, hillclimb, eval, visual-parity). Read a principle in full before applying it.

## Local overlay
If `~/.claude/shinstack-local/overlay.md` exists, read it first. It defines tool routes and personal constraints. Which actions need approval comes from the repo's `shinstack-mode` (`../../principles/general/approval-modes.md`); with none declared, that principle's defaults apply.

## Inside shinfactory
If the `NOODLE_WORKTREE` environment variable is set, you are one stage of a shinfactory order. Do only that stage's job in this worktree, commit, and stop. The loop owns merging, modes, PRs and scheduling: don't push, don't open a PR, and don't load `brainstorm`, `autopilot`, `shipping`, `babysit`, `orchestrate` or `opening-a-pr`. Every other trigger and principle applies as normal.

## Invoked with no task
If the user's message is only the craft command (`/shinstack:craft` or `/craft`), with no arguments, and the conversation holds no task, reply with one line, "Router loaded. What's the task?", and stop. Don't infer a task from the branch, repo or issues, and don't start work. First message and Reply don't apply to this one line.

## First message on any task
State in your own words: the goal, the problem, and the smallest change you expect to meet it. Don't wait for confirmation. If evidence rules out the requested change, show it and stop.

## Triggers
- A new idea where what to build isn't settled ("brainstorm", "help me think", "should we build"), not a design question inside a task already underway -> call `/shinstack:brainstorm` before you reply, even if you could answer directly, and ahead of any other brainstorm skill. It sizes the idea and hands off
- Bug -> `../../playbooks/bug-fix.md`
- Build an existing issue or spec -> `../../playbooks/feature.md`
- An open PR with CI or review feedback -> `../../playbooks/babysit.md`
- One task to drive unattended to a checkable finish -> `../../playbooks/autonomous-run.md`
- A program of many tasks or PRs -> `../../playbooks/orchestrate.md`
- PRs that need independent verification before they count as ready -> `../../playbooks/autopilot.md` (stack mode stops at verified; full mode continues to shipping)
- Merging a PR, unattended or with the user's yes -> `../../playbooks/shipping.md`
- Stopping or pausing a run -> `../../playbooks/pause-safely.md`; resuming one -> `/shinstack:recall` (resume section)
- Opening a PR (end of every playbook) -> `../../playbooks/opening-a-pr.md`
- Choosing how deeply to review a change, with or without a PR -> the review depth table in `../../playbooks/opening-a-pr.md` (inside shinfactory, the stage's own review instead)
- Restructuring without changing behavior -> `../../playbooks/refactoring.md`
- A read-only "how/why/are we sure" question -> `../../playbooks/investigation.md`
- A design fork you can settle by building a throwaway -> `../../playbooks/prototype.md`
- A change big enough to plan before building -> `../../playbooks/multi-phase-plan.md`
- Worktrees piling up -> `../../playbooks/worktree-cleanup.md`
- A one-off slowdown -> `../../playbooks/perf-issue.md`; sustained improvement of a number -> `../../playbooks/hillclimb.md`
- Comparing two versions of an agent setup (a skill, a principle, a prompt) -> `../../playbooks/eval.md`
- A UI migration that must look identical -> `../../playbooks/visual-parity.md`
- Building UI (a page, component, dashboard) -> `/shinstack:frontend-design`; adding motion, loading, hover or feedback states -> `/shinstack:interaction-design`; UI that "feels off" or needs polish -> `/shinstack:make-interfaces-feel-better`
- Any code -> name the data shape first (model-the-domain)
- Tempted to add a layer, abstraction or flag -> laziness-protocol
- Debugging -> fix-root-causes; two fixes failed the same way -> attack-the-premise
- Writing or changing a test -> test-behavior-not-implementation
- Validation, errors, framework wiring -> boundary-discipline; types or signatures -> type-system-discipline
- Same instruction or correction a second time -> encode-lessons-in-structure
- Non-trivial or repetitive work -> build-the-lever (a script that does or proves it)
- Code hard to trace, or reviewing -> minimize-reader-load
- Trusting or reporting a measured number -> explain-the-number
- Anything that can run twice or crash midway -> make-operations-idempotent
- Concurrent actors writing the same thing -> separate-before-serializing-shared-state
- Context filling up -> guard-the-context-window
- Replacing an internal API -> migrate-callers-then-delete-legacy-apis (only if nothing external depends on it)
- Multi-step work, sweeps, stacked commits -> sequence-verifiable-units
- About to say "done" -> prove-it-works
- Resuming or pausing work -> session-state
- Told "all of these / all related" -> count-the-scope
- Design or "which approach" call -> own-view-first (a fact you can observe: run it instead of asking)
- Push, PR, merge, deploy or shared-env write -> approval-modes
- Editing shinstack itself (router, principle, playbook, skill) -> blast-radius on the change, `technical-writing` and `unslop` on the text; then opening-a-pr (and shipping if merging)
- Tempted to ask "should I do X?" -> never-block-on-the-human
- Scoping, "should we build this", ticket scope -> read `../../principles/product/README.md` and the matching file
- Situational (`situational/` subfolders): outcome-oriented-execution, redesign-from-first-principles, experience-first, exhaust-the-design-space. Read the "When not to use" line first.

## Skills (invoke as /shinstack:<name>)
**Start here**
- `brainstorm`: think through an unsettled idea, size it, and end in a draft artifact or draft issues
**Small and standalone**
- `bro`: restate the last message in plain language
- `sharpen`: make a task deeper, not bigger, then rewrite the prompt
- `tdd`: failing test first, then the smallest fix
- `init`: set up shinstack in a repo (mode and check commands in CLAUDE.md)
- `correct`: find repeated agent mistakes in a repo and make each impossible (architecture, then types, lint, test, docs last)
- `blast-radius`: before shipping a risky change, find what it could break beyond the diff and prove the one safety fact by running code
- `benchmark-checklist`: vet a performance number before reporting it
- `unslop`: cut AI tells from writing
- `technical-writing`: docs and PR-body standard
- `typescript-best-practices`: TS rule table and examples
- `go-best-practices`: Go patterns for lifecycle, concurrency, config, testing and CI
- `react-best-practices`: React performance rules, including when not to use effects
**UI craft**
- `frontend-design`: pick a design direction before code; UI that avoids generic AI aesthetics
- `interaction-design`: microinteractions, motion, loading and feedback states, timing scale, reduced motion
- `make-interfaces-feel-better`: polish details (radius, optical alignment, shadows, interruptible animation, tabular numbers)
**Context and trail**
- `ketchup`: catch the user up on a long chat, with every decision waiting on them
- `recall`: rebuild recent working context from this repo's chats, git and PRs
- `show-me-your-work`: append-only decision log for long or unattended runs
**Playbooks (each is also a command, /shinstack:<name>)**
- `autonomous-run`, `autopilot`, `babysit`, `bug-fix`, `eval`, `feature`, `hillclimb`, `investigation`, `multi-phase-plan`, `opening-a-pr`, `orchestrate`, `pause-safely`, `perf-issue`, `prototype`, `refactoring`, `shipping`, `visual-parity`, `worktree-cleanup`
**Understand and design (multi-agent; heavier)**
- `how`: how a subsystem works; `why`: why it is shaped that way; `teach`: both, as one plain explanation
- `architect`: sketch types and module boundaries before code (checkpoint on by default); uses `arena`
- `arena`: N parallel candidates, cross-judge, pick a base, graft the best parts
- `interrogate`: adversarial review where a finding survives only if a run proves it
- `figure-it-out`: design a workflow when no playbook fits (large migrations, long runs)
**Improve the stack**
- `reflect`: mine this conversation for lessons and propose skill edits (applies nothing without approval)
- `automate-me`: build or refresh a personal "-mode" skill from the user's transcripts
- `create-verification-skill`: generate a project-local skill that drives the real app and captures proof
- `maintain-verification-skill`: keep that skill honest as the app changes: read every feature from source, drive each one live, ship at most one PR of proven corrections

## Principles index
**general/**: prove-it-works · attack-the-premise · fix-root-causes · sequence-verifiable-units · build-the-lever · encode-lessons-in-structure · explain-the-number · never-block-on-the-human · approval-modes · guard-the-context-window · session-state · count-the-scope · own-view-first
**engineering/**: laziness-protocol · model-the-domain · boundary-discipline · type-system-discipline · test-behavior-not-implementation · minimize-reader-load · make-operations-idempotent · separate-before-serializing-shared-state · migrate-callers-then-delete-legacy-apis
**product/**: 31 principles, indexed in `principles/product/README.md`

## Friction
If a shinstack file is wrong, unclear or gets ignored mid-task, append one line to `~/.claude/shinstack-friction.md` (`date | file | what went wrong`, no code or private content) and keep working. Don't block on it and don't silently work around it. `/shinstack:reflect` reads this file.

## Reply
Open with the goal. Name any principle that changed a decision and what it changed. End with real command output for verification, never "should work".

When a task finishes, close with two short parts so a user who context-switches can re-enter cold:
- **Done**: what changed (files, behaviour, verification result).
- **Next**: what comes next, and any decision needed from the user with your recommendation. If none, say "no decision needed".

Inside shinfactory, keep it to the stage's own Done and Next; don't suggest merging or opening a PR.
