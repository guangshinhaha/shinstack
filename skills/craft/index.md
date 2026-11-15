# shinstack index

The catalog behind the router (`SKILL.md`, next to this file): every skill, one line each. It lives here so the router injected each session stays under Claude Code's hook output limit.

## Skills (invoke as /shinstack:<name>)
- `brainstorm`: think through an unsettled idea, size it, and end in a draft artifact or draft issues
- `blast-radius`: before shipping a risky change, find what it could break beyond the diff and prove the one safety fact by running code
- `interrogate`: adversarial review where a finding survives only if a run proves it
- `init`: set up shinstack in a repo (mode and check commands in CLAUDE.md)
- `correct`: find repeated agent mistakes in a repo and make each impossible (architecture, then types, lint, test, docs last)
- `unslop`: cut AI tells from writing
- `technical-writing`: docs and PR-body standard
- `recall`: rebuild recent working context from this repo's chats, git and PRs
- `ketchup`: catch the user up on a long chat, with every decision waiting on them
- `show-me-your-work`: append-only decision log for long or unattended runs
- `reflect`: mine this conversation for lessons and propose skill edits (applies nothing without approval)
**UI craft**
- `frontend-design`: pick a design direction before code; UI that avoids generic AI aesthetics
- `interaction-design`: microinteractions, motion, loading and feedback states, timing scale, reduced motion
- `make-interfaces-feel-better`: polish details (radius, optical alignment, shadows, interruptible animation, tabular numbers)
**Playbooks (each is also a command, /shinstack:<name>)**
- `feature`, `bug-fix`, `refactoring`, `investigation`, `opening-a-pr`, `ship`, `coordinate`, `plan`
