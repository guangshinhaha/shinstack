# Overlay `trigger -> skill` lines route ahead of the router's triggers

Date: 2026-11-08. Status: accepted.

## Decision
A `trigger -> skill` line in `~/.claude/shinstack-local/overlay.md` sends a matching task to that skill before the router's own triggers. If the skill isn't installed, or the router's Inside shinfactory section bars it, the router's triggers apply. The lines only route: shinstack's principles, rules and approval modes still apply.

## Why
- Personal skills in `~/.claude/skills` were reachable only through their own description, which loses to a shinstack trigger that matches the same task.
- The overlay is already read first and is the user's own file, so a route there is the user saying which skill they want.
- Routing is the only power it gets. Approval stays with each repo's `shinstack-mode`, which can be reviewed in public (see `approval-modes.md`).

## Rejected
- Have the SessionStart hook paste the overlay's route lines into context: it puts user-file content of unknown size in the hook output, which has to stay under 9000 bytes. The router already tells the agent to read the overlay first, and live runs show it does (PR #46: 3 of 3 runs routed with the line, 0 of 3 without).

## Consequences
- An overlay route can win over a built-in trigger, including brainstorm, whose trigger defers to an overlay route. That is intended: the user chose it.
- Plugin 0.20.0 is the first version that has this.
