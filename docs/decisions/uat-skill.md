# A milestone's live checks run as a UAT skill

Date: 2026-11-19. Status: accepted. Tracked in #93.

## Decision
`/shinstack:uat` walks the user through the live checks left after a milestone merges: a rebuild of `origin/main`, one card per check, the user's screenshot or pass/fail as the evidence. It is a skill with no playbook. `ship.md` and `coordinate.md` name it in their Reply when only live checks remain, and the router has one trigger line.

## Why
In Chippy v1.5 three of four open issues ended in "Live check (Shin)", and the agent left each open for it. The pattern that worked was worth keeping: expected behaviour up front, the agent faking safe inputs so the user only looks, evidence read back.

## Choices
- **Not in `ship` or `coordinate`.** `ship`'s verifier already proves Done when against the running build; UAT covers only what a person must see, hear or do. `coordinate` runs unattended, UAT is attended.
- **Three outcomes plus skipped.** A finding (works, but the issue's premise was wrong) is never a pass and keeps the issue open. chippy#139 is the example: its live check assumed the rest panel shows an approval, which it can never do.
- **No pass without the user's evidence.** Screenshots are read locally and never attached or sent (PDPA).
- **A fail gets no `ready` label.** `ready` is a person's permission (`issue-standard.md`); the reply asks for it.
- **No label, no playbook.** A "Live check" line in Done when plus a merged PR selects the issues. The router had about 180 bytes of hook budget free, so the trigger is one short line.

## Not decided here
A factory "awaiting UAT" digest (factory owns when work runs), and staging or prod targets.
