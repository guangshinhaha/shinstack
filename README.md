# shinstack

**A working style for coding agents, packaged as a Claude Code plugin.**

shinstack is a small router plus a library of short principles, playbooks and skills. It nudges an agent to restate the goal, take the smallest change, verify against the real thing, and work in small steps that can each be checked. Nothing in it is a program: every piece is a markdown file the agent reads when it applies.

```
/shinstack:shinstack      the router (loads on non-trivial coding tasks)
        │
        ├─ principles/    short rules, read only when their trigger matches
        ├─ playbooks/     step-by-step recipes for one kind of task
        └─ skills/        tools you or the agent invoke by name
```

## How it works

1. **A coding task starts.** The router's one-line description is always visible to the agent. When a non-trivial coding task begins (or you type `/shinstack:shinstack`), the router's ~60 lines load.
2. **Local overlay.** If `~/.claude/skills/shinstack-local/SKILL.md` exists, the router reads it first. That is where you put your own approval rules and tool routes. Without it, the router stops before merge, deploy and anything shared.
3. **First message.** The agent states the goal, the problem, and the smallest change it expects to meet it, without waiting for confirmation.
4. **Triggers.** The router holds a table of "when X, read Y". "Bug" opens the bug-fix playbook, "debugging" opens `fix-root-causes`, "about to say done" opens `prove-it-works`, and so on. Everything else stays unloaded, so context stays small even with dozens of files.
5. **Reply.** The agent opens with the goal, names any principle that changed a decision, and ends with real command output instead of "should work".

**This is guidance, not enforcement.** The agent follows the table by judgment. Pair it with hooks and CI for anything that must never be skipped; the principle `encode-lessons-in-structure` says the same.

## Layout

```
.claude-plugin/    plugin and marketplace manifests
skills/            the router (shinstack/) and 21 other skills
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
- [`bug-fix`](playbooks/bug-fix.md): reproduce, find the cause by elimination, smallest fix, failing test before the fix.
- [`feature`](playbooks/feature.md): build from an issue or spec, one slice per acceptance criterion.
- [`babysit`](playbooks/babysit.md): keep one PR moving until it is merge-ready.

## Skills
Invoke as `/shinstack:<name>`.

**Small and standalone**

| Skill | What it does |
|---|---|
| `bro` | Restate the last message in plain language |
| `sharpen` | Make a task deeper, not bigger, then rewrite the prompt |
| `tdd` | Failing test first, then the smallest fix |
| `correct` | Find mistakes agents keep repeating in a repo and make each impossible: architecture first, then types, lint, test, docs last |
| `blast-radius` | Before shipping a risky change, find what it could break beyond the diff and prove the one safety fact by running code |
| `benchmark-checklist` | Vet a performance number before you report it |
| `unslop` | Cut AI tells from writing |
| `technical-writing` | Docs and PR-body standard |
| `typescript-best-practices` | TypeScript rule table with examples |

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

## Install

```
claude plugin marketplace add guangshinhaha/shinstack
claude plugin install shinstack@shinstack
```

Restart Claude Code, then try `/shinstack:bro` or `/shinstack:shinstack`.

## Make it yours: the local overlay

The public router is generic on purpose. Put your own rules in `~/.claude/skills/shinstack-local/SKILL.md`, which the router reads first:

- **Project classes:** which repos the agent may run end to end (branch, PR, review, merge, deploy) and which need your OK at each step.
- **Tool routes:** which skills from other plugins to use for issues, PRs and reviews.
- **Personal constraints** on the situational principles.

Anything private stays in that file, outside this repo.

## Status

Early (v0.3). The principles and playbooks are the settled part. The multi-agent skills have had little real use, so expect rough edges. Run `reflect` after real sessions to turn what went wrong into edits, and cut principles that never get used.

## License

MIT. See [`LICENSE`](LICENSE).
