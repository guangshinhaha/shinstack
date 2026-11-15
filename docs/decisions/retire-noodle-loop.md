# Retire the noodle loop (2026-11-15)

- Removed the old shinfactory (noodle) setup from this repo: `.agents/` (copied factory skills), `.noodle.toml`, `adapters/` (GitHub backlog adapter), and the `.noodle/` and `.worktrees/` gitignore lines, plus their gantry high-risk entries. Set up in #61, with gantry entries in #63 and the adapter fixed in #64.
- Why: the old noodle loop is retired. Shin decided this on 2026-11-15, recorded under "Decided" on #68.
- Kept: the new factory's `factory-role` brief line (#67) stays in the router, so factory stations still key off it.
- Not touched here: `skills/`, `playbooks/`, `principles/`, `hooks/`, `README.md`, `CLAUDE.md`. #70 owns the `NOODLE_WORKTREE` and router cleanup.
- Tracking: #68.
