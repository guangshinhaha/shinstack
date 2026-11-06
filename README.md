# shinstack

**A working style for coding agents, packaged as a Claude Code plugin.**

shinstack is a small router plus a library of short principles, playbooks and skills. It nudges an agent to restate the goal, take the smallest change, verify against the real thing, and work in small steps that can each be checked. Nothing in it is a program: every piece is a markdown file the agent reads when it applies.

```
/shinstack:craft          the router (loads on non-trivial coding tasks)
        │
        ├─ principles/    short rules, read only when their trigger matches
        ├─ playbooks/     step-by-step recipes for one kind of task
        └─ skills/        tools you or the agent invoke by name
```

## How it works

1. **A coding task starts.** The router's one-line description is always visible to the agent. When a non-trivial coding task begins (or you type `/shinstack:craft`), the router's ~60 lines load.
2. **Local overlay.** If `~/.claude/shinstack-local/overlay.md` exists, the router reads it first. That is where you put your own tool routes and constraints. Approval comes from each repo's `shinstack-mode` (default `supervised`: stops before merge, deploy and anything shared).
3. **First message.** The agent states the goal, the problem, and the smallest change it expects to meet it, without waiting for confirmation.
4. **Triggers.** The router holds a table of "when X, read Y". "Bug" opens the bug-fix playbook, "debugging" opens `fix-root-causes`, "about to say done" opens `prove-it-works`, and so on. Everything else stays unloaded, so context stays small even with dozens of files.
5. **Reply.** The agent opens with the goal, names any principle that changed a decision, and ends with real command output instead of "should work".

**This is guidance, not enforcement.** The agent follows the table by judgment. Pair it with hooks and CI for anything that must never be skipped; the principle `encode-lessons-in-structure` says the same.

## Layout

```
.claude-plugin/    plugin and marketplace manifests
skills/            the router (craft/) and 26 other skills
principles/
  general/         how to work on anything (always applies)
  engineering/     code-specific
  product/         scoping and what to build
  */situational/   rules that only fit some contexts
playbooks/         bug-fix, feature, babysit
```

Every principle is one short file: a title, an **Apply** trigger line, the rule, and a **Why**.

## Principles

### General
| Principle | Apply |
|---|---|
| [`attack-the-premise`](principles/general/attack-the-premise.md) | When two or more fixes that share one premise have failed the same gate |
| [`build-the-lever`](principles/general/build-the-lever.md) | To any non-trivial work, not just bulk work: edits, migrations, analyses, checks |
| [`count-the-scope`](principles/general/count-the-scope.md) | When told "all of these", "all related" or "until everything's fixed" |
| [`encode-lessons-in-structure`](principles/general/encode-lessons-in-structure.md) | When you catch yourself writing the same instruction a second time, or notice a recurring correction |
| [`explain-the-number`](principles/general/explain-the-number.md) | Before you measure, and before you trust, report, or act on a number you measured: a speedup, a regression, a throughput, a latency, or an eval result |
| [`fix-root-causes`](principles/general/fix-root-causes.md) | When debugging |
| [`guard-the-context-window`](principles/general/guard-the-context-window.md) | When context is filling up: large outputs, long files, repeated reads, fan-out planning |
| [`approval-modes`](principles/general/approval-modes.md) | Before push, PR, merge, deploy or a shared-env write |
| [`never-block-on-the-human`](principles/general/never-block-on-the-human.md) | When tempted to ask "should I do X?" |
| [`own-view-first`](principles/general/own-view-first.md) | When making a design or "which approach" call |
| [`prove-it-works`](principles/general/prove-it-works.md) | After completing a task, before declaring done |
| [`sequence-verifiable-units`](principles/general/sequence-verifiable-units.md) | To multi-step work (sweeps, migrations, runs of similar edits) and to how you stack commits and PRs |
| [`session-state`](principles/general/session-state.md) | When resuming, pausing or finishing work |

### Engineering
| Principle | Apply |
|---|---|
| [`boundary-discipline`](principles/engineering/boundary-discipline.md) | When wiring validation, error handling, or framework adapters |
| [`laziness-protocol`](principles/engineering/laziness-protocol.md) | When refactoring, evaluating diff size, or tempted to add abstractions, layers, or signal threading |
| [`make-operations-idempotent`](principles/engineering/make-operations-idempotent.md) | When designing commands, lifecycle steps, or processing loops that run amid crashes, restarts, and retries |
| [`migrate-callers-then-delete-legacy-apis`](principles/engineering/migrate-callers-then-delete-legacy-apis.md) | When introducing a new internal API while old callers still exist |
| [`minimize-reader-load`](principles/engineering/minimize-reader-load.md) | When reviewing or shaping code that's hard to trace |
| [`model-the-domain`](principles/engineering/model-the-domain.md) | When writing stateful logic, or when code branches a lot or repeats a shape assumption across files |
| [`separate-before-serializing-shared-state`](principles/engineering/separate-before-serializing-shared-state.md) | When concurrent actors might write to the same file, branch, key, or state object |
| [`test-behavior-not-implementation`](principles/engineering/test-behavior-not-implementation.md) | When you write, change, or keep a test |
| [`type-system-discipline`](principles/engineering/type-system-discipline.md) | When designing types, reviewing a function signature, or writing code in any statically-typed language |

### Situational
Each ends with a "When not to use" line. Engineering: [`outcome-oriented-execution`](principles/engineering/situational/outcome-oriented-execution.md), [`redesign-from-first-principles`](principles/engineering/situational/redesign-from-first-principles.md). Product: [`exhaust-the-design-space`](principles/product/situational/exhaust-the-design-space.md), [`experience-first`](principles/product/situational/experience-first.md).

### Product
31 principles for scoping tickets, delivery decisions, trust and privacy, architecture, and honesty about what is tested. Index: [`principles/product/README.md`](principles/product/README.md).

## Playbooks
**Single tasks**
- [`bug-fix`](playbooks/bug-fix.md): reproduce, find the cause by elimination, smallest fix, failing test before the fix.
- [`feature`](playbooks/feature.md): build from an issue or spec, one slice per acceptance criterion.
- [`babysit`](playbooks/babysit.md): keep one PR moving until it is merge-ready: modes, merge-frontier discipline, a fixed order (conflicts, threads, CI), and a rule for classifying CI failures.
- [`perf-issue`](playbooks/perf-issue.md): tie every fix to a measurement; seven "mantras" tried cheapest first.
- [`hillclimb`](playbooks/hillclimb.md): improve one number against a target: frozen harness, one change per iteration, keep or revert, decision log.
- [`visual-parity`](playbooks/visual-parity.md): pixel-exact UI migration against a baseline you never touch.
- [`refactoring`](playbooks/refactoring.md): change structure, not behavior: pin first, subtract first, prove unchanged.
- [`investigation`](playbooks/investigation.md): a read-only question answered with cited evidence.
- [`prototype`](playbooks/prototype.md): a throwaway built to settle one design decision.
- [`opening-a-pr`](playbooks/opening-a-pr.md): ordered commits, a one-minute PR body, ready not draft.

**Unattended and factory work**
- [`autonomous-run`](playbooks/autonomous-run.md): drive one task to a checkable finish condition without stopping.
- [`orchestrate`](playbooks/orchestrate.md): a coordinator that runs many tasks through owners, workers and verifiers, and never writes code.
- [`autopilot`](playbooks/autopilot.md): one owner per PR, an independent verifier, verdict files tied to a head SHA. Stack mode stops at verified; full mode continues to merge.
- [`shipping`](playbooks/shipping.md): land only the verified run, one PR at a time, then leave it alone.
- [`multi-phase-plan`](playbooks/multi-phase-plan.md): the plan is the deliverable: a checklist with evidence per box, checked by `scripts/check-plan.sh`.
- [`eval`](playbooks/eval.md): a blinded experiment to test whether a skill, principle or prompt actually helps.
- [`pause-safely`](playbooks/pause-safely.md): a clean stop with a resume note a cold-start agent can use.
- [`worktree-cleanup`](playbooks/worktree-cleanup.md): a safe sweep of leftover worktrees, using the read-only `scripts/worktree-audit.sh`.

Each of these ends with a "make it enforceable" note: the part to turn into a validator or check when a system runs the playbook, because prose alone is only a suggestion.

## Skills
Invoke as `/shinstack:<name>`.

**Small and standalone**

| Skill | What it does |
|---|---|
| `bro` | Restate the last message in plain language |
| `sharpen` | Make a task deeper, not bigger, then rewrite the prompt |
| `tdd` | Failing test first, then the smallest fix |
| `init` | Set up shinstack in a repo: mode and check commands in CLAUDE.md |
| `correct` | Find mistakes agents keep repeating in a repo and make each impossible: architecture first, then types, lint, test, docs last |
| `blast-radius` | Before shipping a risky change, find what it could break beyond the diff and prove the one safety fact by running code |
| `benchmark-checklist` | Vet a performance number before you report it |
| `unslop` | Cut AI tells from writing |
| `technical-writing` | Docs and PR-body standard |
| `typescript-best-practices` | TypeScript rule table with examples |

**UI craft** (from [poteto/noodle](https://github.com/poteto/noodle))

| Skill | What it does |
|---|---|
| `frontend-design` | Pick a design direction before code; UI that avoids generic AI aesthetics |
| `interaction-design` | Microinteractions, motion, loading and feedback states, reduced motion |
| `make-interfaces-feel-better` | Polish details: radius, optical alignment, shadows, interruptible animation, tabular numbers |

**Context and trail**

| Skill | What it does |
|---|---|
| `ketchup` | Catch you up on a long chat, with every decision waiting on you |
| `recall` | Rebuild recent working context from this repo's chats, git and PRs |
| `show-me-your-work` | Append-only decision log for long or unattended runs |

**Understand and design** (multi-agent, heavier)

| Skill | What it does |
|---|---|
| `how` / `why` / `teach` | How a subsystem works, why it is shaped that way, and both as one plain explanation |
| `architect` | Sketch types and module boundaries before code; stops for your go by default |
| `arena` | N parallel candidates, a cross-judge, pick a base, graft the best parts |
| `interrogate` | Adversarial review where a finding survives only if a run proves it |
| `figure-it-out` | Design a workflow when no playbook fits |

**Improve the stack**

| Skill | What it does |
|---|---|
| `reflect` | Mine a conversation for lessons and propose skill edits; applies nothing without approval |
| `automate-me` | Build or refresh a personal "-mode" skill from your transcripts |
| `create-verification-skill` | Generate a project-local skill that drives the real app and captures proof |
| `maintain-verification-skill` | Keep that skill honest as the app changes: every feature read from source and driven live, at most one PR of proven corrections |

## Install

```
claude plugin marketplace add guangshinhaha/shinstack
claude plugin install shinstack@shinstack
```

Restart Claude Code, then try `/shinstack:bro` or `/shinstack:craft`.

## Make it yours: the local overlay

The public router is generic on purpose. Put your own rules in `~/.claude/shinstack-local/overlay.md`, which the router reads first:

- **Tool routes:** which skills from other plugins to use for issues, PRs and reviews.
- **Personal constraints** on the situational principles.

Anything private stays in that file, outside this repo.

## shinstack and shinfactory

shinstack says how to work. [shinfactory](https://github.com/guangshinhaha/shinfactory) is an optional loop that decides when work runs and who runs it. shinstack works without it.

| Concern | Owner |
|---|---|
| Principles, playbooks, craft skills, review standards | shinstack |
| Stage order, scheduling, retries, and which provider or model runs a stage | shinfactory |
| Merge and PRs inside a factory order | shinfactory |
| Push, PR, merge and deploy outside the factory | shinstack |

To place a new rule, ask: would it still apply to one person running one agent session with no loop? If yes, it goes here. If it needs a schedule, a stage or an event, it goes in shinfactory. Full reasoning: [the decision record](docs/decisions/shinstack-vs-shinfactory.md).

## Status

Early (v0.3). The principles and playbooks are the settled part. The multi-agent skills have had little real use, so expect rough edges. Run `reflect` after real sessions to turn what went wrong into edits, and cut principles that never get used.

## License

MIT. See [`LICENSE`](LICENSE). `skills/frontend-design` is Anthropic's, under Apache 2.0 (its own `LICENSE.txt`).
