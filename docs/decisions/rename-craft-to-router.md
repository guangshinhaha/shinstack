# The router skill is named `router`, not `craft`

2026-11-17

## Decision

`skills/craft` becomes `skills/router`, invoked as `/shinstack:router`. Nothing else about it changes.

## Why

`craft` did not say what the skill is. The first thing a new reader sees is the router, and its name told them nothing. `router` says it. `shin-mode` was considered and dropped: it reads like `shinstack-mode`, the approval setting, and the two would be confused.

## Consequences

- `/shinstack:craft` stops working. There is no stub: a second copy of the router's name would be a second place to keep right.
- `.github/gantry-high-risk-paths` lists `skills/router/SKILL.md`. If that path goes stale, router edits silently stop getting risk:high.
- `scripts/check-router.sh` greps the hook output for `shinstack router`, and the hook prints that header from the router file.
- Skill-usage history splits across the two names. Read old counts for `craft` as the router.
- Older decision docs keep saying `craft`. They are history.
