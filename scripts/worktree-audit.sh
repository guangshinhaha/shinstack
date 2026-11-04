#!/bin/bash
# Read-only audit of git worktrees. Usage: worktree-audit.sh [-b <base-ref>] [repo-path]
base=""; while getopts "b:" o; do [ "$o" = b ] && base="$OPTARG"; done; shift $((OPTIND-1))
repo="${1:-.}"; cd "$repo" || exit 1
[ -z "$base" ] && base=$(git symbolic-ref -q --short refs/remotes/origin/HEAD 2>/dev/null || echo main)
printf "%-60s %-30s %-8s %-9s %-9s %s\n" PATH BRANCH MERGED MODIFIED UNTRACKED AGE_DAYS
git worktree list --porcelain | awk '/^worktree /{p=substr($0,10)} /^branch /{b=substr($0,8); sub("refs/heads/","",b); print p"\t"b} /^detached/{print p"\t(detached)"}' | while IFS=$'\t' read -r path br; do
  [ -d "$path" ] || { printf "%-60s %-30s %s\n" "$path" "$br" "(missing dir)"; continue; }
  if [ "$br" != "(detached)" ] && git merge-base --is-ancestor "$br" "$base" 2>/dev/null; then m=yes; else m=no; fi
  mod=$(git -C "$path" status --porcelain 2>/dev/null | grep -vc '^??'); unt=$(git -C "$path" status --porcelain 2>/dev/null | grep -c '^??')
  ts=$(git -C "$path" log -1 --format=%ct 2>/dev/null); ts=${ts:-0}; age=$(( ( $(date +%s) - ts ) / 86400 ))
  printf "%-60s %-30s %-8s %-9s %-9s %s\n" "$path" "$br" "$m" "$mod" "$unt" "$age"
done
