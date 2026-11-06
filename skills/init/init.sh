#!/bin/sh
# Usage: init.sh REPO_DIR [CHECKS_FILE] [MODE]
# Writes or refreshes the managed shinstack block in REPO_DIR/CLAUDE.md. Idempotent. Never commits.
# CHECKS_FILE: one command per line (empty or missing -> "none found"). MODE: auto|supervised|manual (default: detected).
set -eu
repo=${1:?repo dir}; checks=${2:-}; mode=${3:-}
[ -n "$checks" ] && [ -f "$checks" ] && checks=$(cd "$(dirname "$checks")" && pwd)/$(basename "$checks")
cd "$repo"
git rev-parse --git-dir >/dev/null 2>&1 || { echo "not a git repo: $repo" >&2; exit 1; }
f=CLAUDE.md
B='<!-- shinstack:begin -->'; E='<!-- shinstack:end -->'
if [ -z "$mode" ]; then
  url=$(git remote get-url origin 2>/dev/null || true)
  case "$url" in *github.com*) mode=supervised ;; *) mode=manual ;; esac
fi
case "$mode" in auto|supervised|manual) ;; *) echo "bad mode: $mode" >&2; exit 1 ;; esac
# A mode declared outside the managed block wins; don't add a second one.
outside=""
[ -f "$f" ] && outside=$(awk -v b="$B" -v e="$E" '$0==b{s=1;next} $0==e{s=0;next} !s' "$f")
tmp=$(mktemp)
{
  echo "$B"
  echo "## shinstack"
  if printf '%s\n' "$outside" | grep -q '^shinstack-mode:'; then :; else echo "shinstack-mode: $mode"; fi
  echo
  echo "Before a PR:"
  if [ -n "$checks" ] && [ -s "$checks" ]; then sed 's/^/- `/; s/$/`/' "$checks"; else echo "- none found"; fi
  echo
  echo "Decisions: \`docs/decisions/\`. Solved bugs: \`docs/solutions/\`."
  echo "$E"
} > "$tmp"
if [ ! -f "$f" ]; then
  cp "$tmp" "$f"
elif grep -qxF "$B" "$f"; then
  awk -v b="$B" -v e="$E" -v blk="$tmp" '
    $0==b{while((getline l < blk)>0) print l; s=1; next}
    $0==e{s=0; next}
    !s' "$f" > "$f.new" && mv "$f.new" "$f"
else
  { cat "$f"; echo; cat "$tmp"; } > "$f.new" && mv "$f.new" "$f"
fi
rm -f "$tmp"
echo "updated $repo/$f (mode: $mode)"
