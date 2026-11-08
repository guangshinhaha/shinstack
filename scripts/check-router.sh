#!/bin/sh
# Fails if the router's index names a principle/playbook that has no file, or a file the index omits.
cd "$(dirname "$0")/.." || exit 1
fail=0
for f in principles/general/*.md principles/engineering/*.md; do
  n=$(basename "$f" .md)
  grep -q "$n" skills/craft/SKILL.md || { echo "not in router index: $n"; fail=1; }
  grep -q "$n" README.md || { echo "not in README: $n"; fail=1; }
done
for p in $(grep -o '\.\./\.\./playbooks/[a-z-]*\.md' skills/craft/SKILL.md | sort -u); do
  [ -f "skills/craft/$p" ] || { echo "router points at missing file: $p"; fail=1; }
done
grep -rn -E "\bowned\b/|class: (owned|gated)|project-class|approval rules" principles playbooks skills/craft README.md && fail=1
for f in skills/*/SKILL.md; do
  awk '/^---$/{c++;next} c==1' "$f" | grep -q '^disable-model-invocation' && { echo "skill hidden from auto-invocation: $f"; fail=1; }
done
for f in playbooks/*.md; do
  n=$(basename "$f" .md)
  [ -f "skills/$n/SKILL.md" ] || { echo "playbook has no skill (no command): $n"; fail=1; continue; }
  grep -q "playbooks/$n.md" "skills/$n/SKILL.md" || { echo "skill $n does not point at its playbook"; fail=1; }
done
awk '/^## Reply/{r=1;next} /^## /{r=0} r' skills/craft/SKILL.md | grep -q 'what it achieves' || { echo "router Reply: Done must ask what the work achieves"; fail=1; }
python3 -c "import json;json.load(open('hooks/hooks.json'))" || { echo "hooks/hooks.json invalid"; fail=1; }
[ -x hooks/inject-router.sh ] || { echo "hooks/inject-router.sh not executable"; fail=1; }
sh hooks/inject-router.sh | grep -q "shinstack craft" || { echo "hook does not emit the router"; fail=1; }
# plugin content changed against main without a version bump -> installed copies never update
if git rev-parse -q --verify origin/main >/dev/null && [ "$(git rev-parse HEAD)" != "$(git rev-parse origin/main)" ]; then
  if git diff --name-only origin/main | grep -qE '^(skills|principles|playbooks|hooks)/' && \
     [ "$(git show origin/main:.claude-plugin/plugin.json | grep '"version"')" = "$(grep '"version"' .claude-plugin/plugin.json)" ]; then
    echo "plugin content changed but .claude-plugin/plugin.json version was not bumped"; fail=1
  fi
fi
[ $fail -eq 0 ] && echo "router ok"
exit $fail
