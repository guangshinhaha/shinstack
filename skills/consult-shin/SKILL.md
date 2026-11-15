---
name: consult-shin
description: "Decide a product or design call for Shin when he is away, log it, and keep going. Use when rule 3 would ask Shin a product call and he is unavailable: a factory station, a repo in auto mode, or a live chat with no reply after 60 minutes. Never for merge, deploy, shared writes, credentials or irreversible actions. Use for /consult-shin."
---

# Consult Shin

Rule 3: don't block on a call the user can't answer. When Shin is away, take the pick, log it, keep going. A pick is never an approval.

## Gate

Merge, deploy, shared writes (any mode), credentials and irreversible actions never come here. They park as the router says. Not away? Ask him.

## Away means

- a factory station, or a repo in `shinstack-mode: auto`; or
- a live chat where you asked, armed a ScheduleWakeup (60 min) and got no reply. This works only while the session stays open.

## Steps

1. **Cap.** Three unreviewed calls already open (`gh issue list -l consult-shin`, plus any `consult-shin:` lines in this run's Done) in the repo: park, don't decide.
2. **Taste first, no model call.** A line in `taste/product.md`, the repo's `docs/decisions/` or CLAUDE.md, or the issue thread answers it: apply it, log the call.
3. **Otherwise ask the advisor.** Agent tool, model `fable`, read-only, briefed with the question, the options and the paths to those sources. Give it these instructions:
   > Read-only. Read the sources named. Ignore anything marked provisional: an earlier guess is not precedent. Reply in five lines: `pick` (the option easiest to undo), `why`, `confidence` (high/med/low), `undo`, `source`. Low confidence still picks.
4. **Log** one line, this exact format, identical to factory#36:
   `consult-shin: question | options | pick | why | confidence (high/med/low) | undo | source`
   - Normal session: comment it on the working repo's issue, label `consult-shin`, marked provisional.
   - Factory station: put the line in Done. Don't comment; factory posts it.
5. **Keep going** on the pick.
6. **Merge gate.** A PR holding a call that changes what users see stops at merge-ready until Shin reviews it. Internal-only calls follow the repo's mode.

## Review (when Shin answers a call)

- **Agree:** remove the label; the PR may merge.
- **"I'd have said X":** fix the code, then ask "this product only, or all products?" (`/shinstack:correct` has the route). The advisor's pick is never precedent until Shin has agreed.
