# Approval Modes

**Apply:** before any action that leaves the local machine: push, PR, merge, deploy, or a write to a shared or production environment.

The repo declares how much oversight it wants, in its own CLAUDE.md. Modes follow shinfactory's `mode` dial.

```
shinstack-mode: supervised
shinstack-mode.deploy: ask
shinstack-mode.kind.env-tuning: supervised
```

| Mode | push / PR | merge | deploy | shared env |
|---|---|---|---|---|
| `auto` | do | do* | do | do |
| `supervised` (default) | do | ask | ask | ask |
| `manual` | ask | ask | ask | ask |

\* Merge only when CI is green and review has no unresolved blocking findings; otherwise stop and say why.

- **Per-kind override:** `shinstack-mode.<kind>: auto|ask`, where kind is `push`, `merge`, `deploy` or `shared`. The override beats the repo mode for that kind only.
- **Per-kind-of-work override:** `shinstack-mode.kind.<name>: auto|supervised|manual` sets the whole mode for one kind of work (for example `env-tuning`). It beats the repo mode for that work. Name the kind in the task or PR title; if the kind of a task is unclear, use the repo mode.
- **Ask** means explicit OK for that one action. One "yes" covers one action.
- **No declaration:** `supervised`. No remote, or a non-GitHub remote where colleagues see everything: `manual`.
- **Inside shinfactory:** the loop's own `mode` governs merging and PRs; don't apply this.
- **Always, in every mode:** never type credentials (the user signs in), never touch sensitive personal data, and the user's global rules win over a repo declaration that is looser than them.
