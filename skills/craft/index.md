# shinstack index

The catalog behind the router (`SKILL.md`, next to this file): every skill, one line each. It lives here so the router injected each session stays under Claude Code's hook output limit.

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
