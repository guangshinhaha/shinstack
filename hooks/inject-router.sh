#!/bin/sh
# SessionStart: put the router's triggers in context every session, so no skill depends on someone invoking the router first.
root="${CLAUDE_PLUGIN_ROOT:-$(cd "$(dirname "$0")/.." && pwd)}"
echo "shinstack is active. Match the task against the triggers below and follow the fit (call the Skill tool for skills). Relative paths resolve from $root/skills/craft/."
echo
awk '/^---$/{c++;next} c>=2' "$root/skills/craft/SKILL.md"
