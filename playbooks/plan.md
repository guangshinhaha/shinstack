# Plan

**You own the plan, not the code. The plan is a GitHub issue (rule 7): a checklist an owner runs box by box and the user audits from the evidence.** The plan is the deliverable. Do not implement. Execution starts only on the user's explicit go, under `coordinate.md` (or `ship.md` for a verified stack).

1. **Skip the plan** when the change is one or two files with an obvious approach. Say so and stop.
2. **Settle open questions by running something.** Build a throwaway if that settles a design fork faster than talking. Ask the user only about a product or preference call no run can settle, and give options with a pick.
3. **Explore in subagents** (explorers, light weight, read-only), each returning file pointers, conventions, test commands and entry points. Keep the reduced findings in the main thread.
4. **Fill the skeleton below.** One section per PR, and one PR is one change with its own evidence.
5. **Write it plainly** (`/shinstack:technical-writing`, then `/shinstack:unslop`), then open it as an issue with `gh issue create`, labelled as the repo's labels allow. Its edits are design changes: record the call under a `Decided` heading, not in a side file.
6. **Run `check-plan.sh` on the plan's body saved to a temp file** and fix every line it prints. The script ships with shinstack, at `../scripts/check-plan.sh` from this playbook's directory.
7. **Hand back** the issue link and the checker's output, then stop.

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
- [ ] One owner per PR (a builder, standard weight). Dependency order: <PR ids>. File boundaries: <PR id> touches only <glob>. Each brief states the tier, its required review, the actions the owner must not take and that subagents are allowed. Evidence: owner list.
### Every PR
- [ ] Opened ready, per `opening-a-pr.md`. Evidence: PR link.
- [ ] Lint, typecheck and tests pass at the code-ready head. Evidence: command output.
- [ ] The review for its risk tier at that head, plus an independent verdict if High. Evidence: review output, and `{pr, head_sha, verdict}` where a verdict applies, posted by the verifier itself, never the author.
### Verdict and merge
- [ ] <The merge or handoff rule, with the patch-id rule from `ship.md`.>

## PRs
### PR 1: <title>
- [ ] Unit: <what, with the failing test first>. Evidence: <command and expected output>.
- [ ] Live: <the real-thing check>. Evidence: <artifact>.
- Out of scope: <list>.

## Decided
<Each settled question, with the branch, SHA and screenshots.>
```

**Reply:** the issue link, the checker's output, and the decisions waiting on the user.
