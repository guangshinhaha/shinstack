# Multi-phase or multi-PR plan

**You own the plan, not the code. The plan is a checklist an owner runs box by box and the user audits from the evidence.** The plan is the deliverable. Do not implement. Execution starts only on the user's explicit go, under the playbook the plan names (`autopilot.md`, `orchestrate.md`).

1. **Skip the plan** when the change is one or two files with an obvious approach. Say so and stop.
2. **Settle open questions by prototype** (`prototype.md`) before writing. Ask the user only about a product or preference call that no run can settle, and give options.
3. **Explore in subagents** (explorers, light weight, read-only), each returning file pointers, conventions, test commands and entry points. Keep the reduced findings in the main thread (guard-the-context-window).
4. **Fill the skeleton below.** One section per PR, and one PR is one change with its own evidence (sequence-verifiable-units).
5. **Write it plainly** (`/shinstack:technical-writing`, then `/shinstack:unslop`).
6. **Run `check-plan.sh` on the plan's absolute path** and fix every line it prints. The script ships with shinstack, not with the repo you're working in. It's at `../scripts/check-plan.sh` from this playbook's directory, so build its absolute path from there.
7. **Hand back** the plan path and the checker's output, then stop.

```markdown
# <Program> plan

<Under ten lines: what changes, for whom, the rule the program enforces, the PR ids in order.>

## How to read this
One box is one unit of work. Every box names its evidence. Check a box only when the evidence exists: a file, a log line, a screenshot, a test run, or a SHA. The program runs `<execution playbook>`. <Who merges; which PRs are the user's and stop at merge-ready.>

## Program checklist
### Arm the program
- [ ] State the plan to the user, then stop. Start only on an explicit go. Evidence: the user's go.
- [ ] Re-read the execution playbook from trunk at program start and at every audit tick. Evidence: the tick log.
### Spawn owners
- [ ] One owner per PR (a builder, standard weight). Dependency order: <PR ids>. File boundaries: <PR id> touches only <glob>. Evidence: owner list.
### Every PR
- [ ] Opened ready, per `opening-a-pr.md`. Evidence: PR link.
- [ ] Lint, typecheck and tests pass at the code-ready head. Evidence: command output.
- [ ] The review for its risk tier at that head, plus an independent verdict if High or if the program runs under `autopilot.md`. Evidence: review output, and `{pr, head_sha, verdict}` where a verdict applies.
### Verdict and merge
- [ ] <The merge or handoff rule, with the patch-id rule from `shipping.md`.>

## PRs
### PR 1: <title>
- [ ] Unit: <what, with the failing test first>. Evidence: <command and expected output>.
- [ ] Live: <the real-thing check>. Evidence: <artifact>.
- Out of scope: <list>.

## Appendix A: decisions and prototypes
<Each settled question, with the branch, SHA and screenshots.>
```

**Reply:** the plan path, the checker's output, and the decisions waiting on the user.
