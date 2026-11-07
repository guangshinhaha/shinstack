# shinstack

Claude Code plugin: a router (`skills/craft`), principles, playbooks and skills.

shinstack-mode: auto

- Check before opening a PR: `sh scripts/check-router.sh`.
- Any change under `skills/`, `principles/`, `playbooks/` or `hooks/` needs a version bump in `.claude-plugin/plugin.json`, or installed copies never update.
- Decisions go in `docs/decisions/`.
- Ownership: gantry owns machine checks, shinstack owns how to work, and shinfactory owns when work runs and who runs it. Each works without the others. See `docs/decisions/shinstack-vs-shinfactory.md`.
