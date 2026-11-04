---
name: shinstack
description: A working style for code tasks: restate the goal, take the smallest change, verify against the real thing, work in small verifiable steps. Routes to principles and playbooks. Use for /shinstack or when asked to work in this style.
disable-model-invocation: true
---

# shinstack

A guidance layer. Hooks and CI enforce; this advises. The user's own rules and any project instructions always win.
Paths are relative to this file: `../../principles/general/` (how to work on anything, always applies), `../../principles/engineering/` (code), `../../principles/product/` (scoping, what to build), each with a `situational/` subfolder for rules that only fit some contexts; `../../playbooks/` (step-by-step recipes). Read a principle in full before applying it.

## Local overlay
If `~/.claude/skills/shinstack-local/SKILL.md` exists, read it first. It defines which actions need approval (project class), tool routes and personal constraints. If it does not exist, treat the project as gated: stop before merge, deploy and anything shared, and ask.

## First message on any task
State in your own words: the goal, the problem, and the smallest change you expect to meet it. Don't wait for confirmation. If evidence rules out the requested change, show it and stop.

## Triggers
- Bug -> `../../playbooks/bug-fix.md`
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
- Tempted to ask "should I do X?" -> never-block-on-the-human
- Scoping, "should we build this", ticket scope -> read `../../principles/product/README.md` and the matching file
- Situational (`situational/` subfolders): outcome-oriented-execution, redesign-from-first-principles, experience-first, exhaust-the-design-space. Read the "When not to use" line first.

## Skills (invoke as /shinstack:<name>)
**Small and standalone**
- `bro`: restate the last message in plain language
- `sharpen`: make a task deeper, not bigger, then rewrite the prompt
- `tdd`: failing test first, then the smallest fix
- `correct`: find repeated agent mistakes in a repo and make each impossible (architecture, then types, lint, test, docs last)
- `blast-radius`: before shipping a risky change, find what it could break beyond the diff and prove the one safety fact by running code
- `benchmark-checklist`: vet a performance number before reporting it
- `unslop`: cut AI tells from writing
- `technical-writing`: docs and PR-body standard
- `typescript-best-practices`: TS rule table and examples
**Context and trail**
- `ketchup`: catch the user up on a long chat, with every decision waiting on them
- `recall`: rebuild recent working context from this repo's chats, git and PRs
- `show-me-your-work`: append-only decision log for long or unattended runs
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

## Principles index
**general/**: prove-it-works · attack-the-premise · fix-root-causes · sequence-verifiable-units · build-the-lever · encode-lessons-in-structure · explain-the-number · never-block-on-the-human · guard-the-context-window · session-state · count-the-scope · own-view-first
**engineering/**: laziness-protocol · model-the-domain · boundary-discipline · type-system-discipline · test-behavior-not-implementation · minimize-reader-load · make-operations-idempotent · separate-before-serializing-shared-state · migrate-callers-then-delete-legacy-apis
**product/**: 31 principles, indexed in `principles/product/README.md`

## Reply
Open with the goal. Name any principle that changed a decision and what it changed. End with real command output for verification, never "should work".
