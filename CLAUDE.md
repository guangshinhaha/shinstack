# shinstack

Claude Code plugin: a router (`skills/craft`), principles, playbooks and skills.

shinstack-mode: auto

- Check before opening a PR: `sh scripts/check-router.sh`.
- Router change? Also run `sh scripts/router-eval.sh` (on demand, costs tokens; fake `gh`, fixture repos).
- Any change under `skills/`, `principles/`, `playbooks/` or `hooks/` needs a version bump in `.claude-plugin/plugin.json`, or installed copies never update.
- Decisions go in `docs/decisions/`.
- Ownership: gantry owns machine checks, shinstack owns how to work, and `factory` (github.com/guangshinhaha/factory) owns when work runs and who runs it. The old shinfactory is retired. Each works without the others. See `docs/decisions/shinstack-vs-shinfactory.md`.
