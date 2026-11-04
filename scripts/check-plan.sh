#!/bin/bash
# Structural check for a multi-phase plan. Usage: check-plan.sh <plan.md>. Prints one line per problem; exit 1 if any.
f="$1"; [ -f "$f" ] || { echo "usage: check-plan.sh <plan.md>"; exit 2; }; bad=0
req() { grep -q "$1" "$f" || { echo "missing section: $1"; bad=1; }; }
req '^## How to read this'; req '^## Program checklist'; req '^### Arm the program'; req '^### Spawn owners'; req '^### Verdict and merge'; req '^## PRs'
grep -n '<[^>]*>' "$f" | grep -v '^[0-9]*:```' | sed 's/^/unfilled placeholder at line /' | head -20 | grep . && bad=1
awk '/^- \[[ x]\]/ && !/Evidence:/ {print "box without evidence at line " NR ": " $0; b=1} END{exit b}' "$f" || bad=1
grep -q 'explicit go\|explicit "go"\|user.s go' "$f" || { echo "no explicit-go gate in the plan"; bad=1; }
exit $bad
