# Overlay `trigger -> skill` lines route ahead of the router's triggers

Date: 2026-11-08. Status: accepted.

## Decision
A `trigger -> skill` line in `~/.claude/shinstack-local/overlay.md` sends a matching task to that skill before the router's own triggers. If the skill isn't installed, the router's triggers apply. The lines only route: they can't override shinstack's rules, approval modes or the limits inside a shinfactory stage.

## Why
- Personal skills in `~/.claude/skills` were reachable only through their own description, which loses to a shinstack trigger that matches the same task.
- The overlay is already read first and is the user's own file, so a route there is the user saying which skill they want.
- Routing is the only power it gets. Approval stays with each repo's `shinstack-mode`, which can be reviewed in public (see `approval-modes.md`).

## Rejected
- Have the SessionStart hook paste the overlay's route lines into context: it puts user-file content of unknown size in the hook output, which has to stay under 9000 bytes. The router already tells the agent to read the overlay first, and live runs show it does.

## Consequences
- An overlay route can win over a built-in trigger, including brainstorm. That is intended: the user chose it.
- Plugin 0.20.0 is the first version that has this.
