# No version in plugin.json (2026-11-15)

Status: accepted. Part of #68, done in #72.

## Decision
`.claude-plugin/plugin.json` carries no `version`. Claude Code then uses the git commit SHA as the plugin version, so every merge to main reaches installed copies. The "bump the version on every change" rule, and the check in `check-router.sh` that enforced it, are gone. The check now fails if a `version` comes back.

## Why
The manual bump existed because installed copies update only when the version string changes. Each PR had to remember it, and Shin questioned the rule (#68). A CI job that bumps on merge would commit to unprotected main, can retrigger itself, and conflicts with open PRs on the same line; dropping the field needs none of that.

## Proof (claude CLI, marketplace added from a git clone, isolated `CLAUDE_CONFIG_DIR`)
- With no version, `claude plugin list` shows `Version: ebc205281d81` (a commit SHA).
- After one commit to a playbook, `marketplace update` then `plugin update` printed `updated from ebc205281d81 to 4999b0b307b4` and a new cache directory appeared.
- An install pinned at `0.25.0`, then a commit removing `version`, printed `updated from 0.25.0 to 42065b32a788`, so existing installs migrate.

## Consequences
- Every commit that changes a marketplace source is a new version, docs-only ones included; the old cache directory stays on disk (seen in the test above).
- A session already running keeps the old plugin path until restart.
- Earlier records that cite 0.x versions (`approval-modes.md`, `overlay-skill-routes.md`) are history.
