# shinstack index

The catalog behind the router (`SKILL.md`, next to this file): every skill, one line each. It lives here so the router injected each session stays under Claude Code's hook output limit.

## Skills (invoke as /shinstack:<name>)
- `brainstorm`: think through an unsettled idea, size it, and end in a draft artifact or draft issues
- `blast-radius`: before shipping a risky change, find what it could break beyond the diff and prove the one safety fact by running code
- `interrogate`: adversarial review where a finding survives only if a run proves it
- `init`: set up shinstack in a repo (mode and check commands in CLAUDE.md)
- `correct`: make a repeated agent mistake impossible (architecture, then types, lint, test, docs last); CI-check lessons
- `writing`: standard for prose a person reads (docs, PR bodies, replies), including cutting AI tells
- `recall`: re-enter cold: rebuild context from chats, git and PRs; catch the user up on a long chat; keep the decision trail
- `consult-shin`: Shin is away and a product call blocks you: take the pick (taste first, else Fable advises), log it in a fixed line, keep going; never an approval
- `uat`: after a milestone merges, walk the user through its live checks one at a time on a fresh build; pass needs their evidence, fails become issues
- `milestone`: manual only (never routed): set up a milestone with a goal, ready issues, an approved order, the user's hands-on items and an unattended run text
- `reflect`: file this conversation's lessons as issues in the repos that own them (`friction` label for shinstack)
**UI craft**
- `frontend-design`: pick a design direction before code; UI that avoids generic AI aesthetics
- `interaction-design`: microinteractions, motion, loading and feedback states, timing scale, reduced motion
- `make-interfaces-feel-better`: polish details (radius, optical alignment, shadows, interruptible animation, tabular numbers)
**Playbooks (each is also a command, /shinstack:<name>)**
- `feature`, `bug-fix`, `refactoring`, `investigation`, `opening-a-pr`, `ship`, `coordinate`, `plan`
