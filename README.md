# shinstack

**A working style for coding agents, packaged as a Claude Code plugin.**

shinstack is how one person runs one agent: a short router that always loads, 8 playbooks for the work that person does, a few kept skills, and one product-taste file. It nudges an agent to restate the goal, take the smallest change, verify against the real thing, and work in small steps that can each be checked. Nothing in it is a program: every piece is a markdown file the agent reads when it applies. The rebuild plan and the reason each piece stays are in issue #68.

```
/shinstack:craft          the router (loads at the start of every session; rules 1-10 inline)
        │
        ├─ playbooks/     step-by-step recipes for one kind of task
        ├─ skills/        tools you or the agent invoke by name
        └─ taste/         product.md: scoping calls, loaded when scoping or writing an issue
```

## How it works

1. **A session starts.** A SessionStart hook (`hooks/inject-router.sh`) puts the router in the agent's context, so nothing depends on someone invoking it first.
2. **Local overlay.** If `~/.claude/shinstack-local/overlay.md` exists, the router reads it first. That is where you put your own tool routes, `trigger -> skill` lines for personal skills, and constraints. Approval comes from each repo's `shinstack-mode` (default `supervised`: stops before merge, deploy and anything shared).
3. **First message.** The agent states the goal, the problem, and the smallest change it expects to meet it, without waiting for confirmation. A bare `/shinstack:craft` with no task gets one line asking for the task.
4. **Rules and triggers.** The router states ten rules inline (reply style, approval mode, deciding in a batch, evidence before claims, rigor by risk, minimalism, issues as state, fix at the source, token cost, skills firing on their own) and a short list of "when X, read Y". Everything else stays unloaded, so context stays small.
5. **Reply.** The agent opens with the goal, names any rule that changed a decision, and ends with real command output instead of "should work".

**This is guidance, not enforcement.** The agent follows the router by judgment. Pair it with hooks and CI for anything that must never be skipped.

## Layout

```
.claude-plugin/    plugin and marketplace manifests
skills/            the router (craft/) and every other skill, including one command per playbook
playbooks/         one recipe per kind of task, listed below
taste/product.md   product calls for scoping and ticket-writing
```

## Where taste lives

```
shinstack repo (taste/)  ──install──▶  plugin cache  ──read by──▶  every repo's agent
                                                                      │
each repo's docs/decisions/  ◀── product-only calls ──────────────────┘
```

General taste is in `taste/`, changed only by a `taste` PR that waits for the owner's yes. Taste that applies to one product stays in that repo's `docs/decisions/`. When the owner is away, `consult-shin` reads both before it picks.

## Playbooks

Each is also a command, `/shinstack:<name>`.

- [`feature`](playbooks/feature.md): build from an issue or spec, one slice per item in its Done when.
- [`bug-fix`](playbooks/bug-fix.md): reproduce, find the cause by elimination, smallest fix, failing test before the fix.
- [`refactoring`](playbooks/refactoring.md): change structure, not behavior: pin first, subtract first, prove unchanged.
- [`opening-a-pr`](playbooks/opening-a-pr.md): ordered commits, a one-minute PR body, ready not draft, and the review depth table by risk.
- [`ship`](playbooks/ship.md): the merge gate by risk, plus an independent verifier and the verdict format for High-risk PRs.
- [`coordinate`](playbooks/coordinate.md): run many tasks through owners and workers, or one task unattended; poll, verify liveness, never write code.
- [`plan`](playbooks/plan.md): the plan is a GitHub issue, a checklist with evidence per box, checked by `scripts/check-plan.sh`.
- [`investigation`](playbooks/investigation.md): a read-only question answered with cited evidence.

Watching a PR and pausing a run are router lines, not playbooks.

## Skills
Invoke as `/shinstack:<name>`. Every skill, one line each, is in [`skills/craft/index.md`](skills/craft/index.md).

| Skill | What it does |
|---|---|
| `brainstorm` | Start here for an unsettled idea: size it, give a position, end in a draft artifact or draft issues |
| `blast-radius` | Before shipping a risky change, find what it could break beyond the diff and prove the one safety fact by running code |
| `interrogate` | Adversarial review where a finding survives only if a run proves it |
| `writing` | Standard for prose a person reads, including cutting AI tells |
| `recall` | Re-enter cold: rebuild context, catch you up on a long chat, keep the decision trail |
| `consult-shin` | Shin is away and a product call blocks the work: take the pick, log it in a fixed line, keep going. Never an approval |
| `reflect`, `correct`, `init` | File a conversation's lessons as issues; make a repeated mistake impossible; set up the repo's mode and checks |
| `frontend-design`, `interaction-design`, `make-interfaces-feel-better` | UI craft (from [poteto/noodle](https://github.com/poteto/noodle)) |

## Install

```
claude plugin marketplace add guangshinhaha/shinstack
claude plugin install shinstack@shinstack
```

Restart Claude Code, then try `/shinstack:craft`.

## Make it yours: the local overlay

The public router is generic on purpose. Put your own rules in `~/.claude/shinstack-local/overlay.md`, which the router reads first:

- **Tool routes:** which skills from other plugins to use for issues, PRs and reviews.
- **Personal constraints** on how the router's rules apply to you.
- **Personal skill routes:** lines like `flaky test -> my-flake-skill` send a matching task to that skill before the router's own triggers. If the skill isn't installed, or a factory station bars it, the router's own triggers apply. They only route: shinstack's rules and approval modes still apply.

Anything private stays in that file, outside this repo.

## How signals, gantry, shinstack and factory fit together

Each of the four works alone. When they are used together, they do not overlap.

| Tool | Answers | Owns | How it acts |
|---|---|---|---|
| [signals](https://github.com/guangshinhaha/signals) | What outside fact becomes a task, and did the fix hold? | Events from a live product, the cause that groups them, the task it opens, and the confirm after a release | An agent reads and writes an API |
| [gantry](https://github.com/guangshinhaha/gantry) | Did it pass? | Local hooks, CI checks, the secret scan and the required `gantry / ci-ok` check | Runs checks with no judgment, and can block a merge |
| [shinstack](https://github.com/guangshinhaha/shinstack) | How should the agent work, and may it act? | Rules, playbooks, review depth, PR format and approval modes | Advises the agent |
| [factory](https://github.com/guangshinhaha/factory) (shinfactory is retired) | What runs next? | Station order, retries, each station's model, and merges inside a factory order (`sf-ship`) | Starts Orca workers once a task exists |

To place a new rule, ask these in order and stop at the first yes:

1. Is it a fact from a live product (feedback, an exception, a release), or a check that the cause went quiet after a release? It goes in signals.
2. Can a machine check it with no judgment? It goes in gantry. A check that only one repo needs goes in that repo's own workflow.
3. Does it need a schedule, a station, or an event inside a factory order that already has a task? It goes in the factory.
4. Would it still apply to one person running one agent session with no loop? It goes in shinstack.

Signals opens the task and stops. The factory decides when that task runs and which model runs each station, and Orca runs the workers. gantry decides whether the checks pass. shinstack tells the agent how to work, and the repo's `shinstack-mode` decides whether a merge may happen, through router rule 2 or the factory's `sf-ship`. A merge still needs both a green check and an approval.

Full reasoning: [the decision record](https://github.com/guangshinhaha/shinstack/blob/main/docs/decisions/shinstack-vs-shinfactory.md).

## Status

Rebuilt from Shin's own rules (issue #68; decision record: [`shinstack-rebuild.md`](docs/decisions/shinstack-rebuild.md)). The plugin has no `version`: installs track the commit SHA, so every merge to main updates them. Friction (a shinstack file that was wrong or ignored) is filed as a `friction` issue in this repo.

## License

MIT. See [`LICENSE`](LICENSE). `skills/frontend-design` is Anthropic's, under Apache 2.0 (its own `LICENSE.txt`).
