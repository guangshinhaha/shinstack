#!/bin/sh
# SessionStart: put the router's triggers in context every session, so no skill depends on someone invoking the router first.
root="${CLAUDE_PLUGIN_ROOT:-$(cd "$(dirname "$0")/.." && pwd)}"
echo "shinstack is active. Before acting, match the task against these triggers and follow the playbook, principle or skill that fits. Relative paths below resolve from $root/skills/craft/. Skills are invocable: call the Skill tool for any that match."
echo
awk '/^---$/{c++;next} c>=2' "$root/skills/craft/SKILL.md"
