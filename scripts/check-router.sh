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
[ $fail -eq 0 ] && echo "router ok"
exit $fail
