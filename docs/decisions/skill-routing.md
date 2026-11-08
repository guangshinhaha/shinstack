# Skills fire from playbook steps and git facts

Date: 2026-11-08. Status: accepted. Closes #47.

## Decision
- Playbooks call the skills they need as explicit steps: `feature.md` and `bug-fix.md` call `/shinstack:tdd`, and `bug-fix.md` calls `/shinstack:architect` only when the fix changes a data shape or a public interface.
- Review depth lives only in the table in `opening-a-pr.md`. `feature.md` no longer runs `blast-radius` or `interrogate`, so a High PR runs them once.
- `feature.md` and `bug-fix.md` end with a hand-off: outside shinfactory, red CI or review comments on the PR go to `babysit.md`. Both commit and push after each slice so a killed session can resume.
- The router resumes from facts, not from a user's phrasing: commits on the branch that the default branch lacks, or an open PR for it, call `/shinstack:recall` first. The repeated-correction trigger names `/shinstack:correct`.
- A kickoff in `orchestrate.md` names the playbook plus task facts and never restates the playbook's steps.
- Every fan-out point names a role (explorer, builder, reviewer, adversary, verifier, judge) and a weight (light, standard, strong), never a model.

## Why
Across 377 sessions (2026-11-06 to 08), `babysit`, `tdd`, `recall`, `pause-safely` and `correct` never ran although their situations came up, and a High PR ran the heavy reviews twice (once in `feature.md`, once from the table). Skills that depend on an agent remembering to name them don't fire; steps and detectable facts do.

## Rejected
- Model IDs in playbooks: shinfactory owns who runs a stage (`shinstack-vs-shinfactory.md`), and IDs go stale.
- A resume check in a hook: the hook only injects text, and a script that guesses at resuming would give wrong answers in repos with no remote.

## Consequences
- The hook output grew by about 380 bytes. The limit in `scripts/check-router.sh` is 9000, so new router text needs a cut elsewhere.
- Inside shinfactory the resume check and the hand-off are skipped; the loop owns both.
- `pause-safely` has no new trigger here: its situation is the user stopping a run, which the router already names.
