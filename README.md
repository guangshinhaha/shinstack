# shinstack

A working style for coding agents, packaged as a Claude Code plugin: a router, principles, playbooks and skills for verified, small, reversible changes.

- **Router** (`/shinstack:shinstack`): restate the goal and the smallest change, then pull in only the principles and skills that apply.
- **Principles** (`principles/`): `general/` (how to work on anything), `engineering/` (code), `product/` (scoping and what to build). Each is one short file with an **Apply** trigger. `situational/` folders hold rules that only fit some contexts.
- **Playbooks** (`playbooks/`): step-by-step recipes.
- **Skills** (`skills/`): small tools such as `tdd`, `blast-radius`, `correct`, `unslop`, plus heavier multi-agent ones such as `architect`, `interrogate`, `reflect`.

## Install
```
claude plugin marketplace add <this-repo>
claude plugin install shinstack@shinstack
```
Restart Claude Code, then try `/shinstack:shinstack` or `/shinstack:bro`.

## Local overlay
The router reads `~/.claude/skills/shinstack-local/SKILL.md` if it exists. Use it for your own approval rules (which actions the agent may take without asking), tool routes and personal constraints. Without it, the router stops before merge, deploy and anything shared.

## License
MIT. See `LICENSE`.
