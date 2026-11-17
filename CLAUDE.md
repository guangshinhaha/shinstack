# shinstack

Claude Code plugin: a router (`skills/router`), principles, playbooks and skills.

shinstack-mode: auto

- Check before opening a PR: `sh scripts/check-router.sh`.
- Router change? Also run `sh scripts/router-eval.sh` (on demand, costs tokens; fake `gh`, fixture repos).
- `.claude-plugin/plugin.json` has no `version` on purpose: installs take the commit SHA as the version, so every merge to main updates them. Don't add one back.
- Decisions go in `docs/decisions/`.
- Ownership: gantry owns machine checks, shinstack owns how to work, and `factory` (github.com/guangshinhaha/factory) owns when work runs and who runs it. The old shinfactory is retired. Each works without the others. See `docs/decisions/shinstack-vs-shinfactory.md`.
