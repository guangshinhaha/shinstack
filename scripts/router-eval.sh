#!/bin/sh
# On-demand behaviour check for the router: seventeen fixed prompts through `claude -p`,
# plugin loaded from this working tree. Costs tokens, so it is not in CI.
# Usage: sh scripts/router-eval.sh [case-number ...]   (default: all)
# Env:   EVAL_MODEL (default haiku, the cheapest model that follows the router)
#        EVAL_REPEAT (default 1): run each selected case N times, report pass counts per case
# Safety: every case runs in a temp fixture repo with a fake `gh` first on PATH
# (it only logs) and a local bare repo as origin. No real gh call, merge or push.
ROOT=$(cd "$(dirname "$0")/.." && pwd)
MODEL=${EVAL_MODEL:-haiku}
REPEAT=${EVAL_REPEAT:-1}
WORK=$(mktemp -d "${TMPDIR:-/tmp}/router-eval.XXXXXX")
trap '[ -n "$KEEP" ] || rm -rf "$WORK"; [ -z "$KEEP" ] || echo "kept: $WORK"' EXIT

mkdir "$WORK/bin"
cat > "$WORK/bin/gh" <<'EOF'
#!/bin/sh
# fake gh: log the call, answer just enough for a merge flow
echo "$*" >> "$GH_LOG"
oid=$(cat "$(dirname "$GH_LOG")/oid")
case "$1 $2" in
  "pr view") echo '{"number":7,"title":"Fix typo","state":"OPEN","isDraft":false,"headRefName":"fix-typo","headRefOid":"'$oid'","baseRefName":"main","reviewDecision":"APPROVED","mergeable":"MERGEABLE","mergeStateStatus":"CLEAN","statusCheckRollup":[{"name":"ci","conclusion":"SUCCESS"}]}' ;;
  "pr list") echo '[{"number":7,"title":"Fix typo","headRefName":"fix-typo"}]' ;;
  "pr merge") echo "merged (fake)" ;;
  *) echo "ok (fake)" ;;
esac
EOF
chmod +x "$WORK/bin/gh"

# fixture <name> <mode|none>: repo with a bare local origin and PR 7's head branch (fix-typo) pushed; echoes its path
fixture() {
  d="$WORK/$1"; mkdir -p "$d/repo" && git init -q --bare "$d/origin.git"
  cd "$d/repo" && git init -q -b main && git remote add origin "$d/origin.git"
  { echo "# fixture"; [ "$2" != none ] && printf '\nshinstack-mode: %s\n' "$2"; } > CLAUDE.md
  git add -A && git -c user.name=t -c user.email=t@t commit -qm init && git push -q origin main
  git checkout -q -b fix-typo && echo "typo fixed" > fix.txt && git add -A \
    && git -c user.name=t -c user.email=t@t commit -qm "fix typo" && git push -q origin fix-typo
  git rev-parse HEAD > "$d/oid"; git checkout -q main
  : > "$d/gh.log"; echo "$d"
}

# run <dir> <prompt>: stream-json to $dir/out.json
run() {
  ( cd "$1/repo" && PATH="$WORK/bin:$PATH" GH_LOG="$1/gh.log" \
    claude -p "$2" --model "$MODEL" --plugin-dir "$ROOT" --setting-sources project,local \
      --permission-mode bypassPermissions --max-budget-usd 0.50 \
      --output-format stream-json --verbose > "$1/out.json" 2> "$1/err.txt" )
}

# skill_called <dir> <name>: did the agent call the Skill tool with that name?
skill_called() {
  python3 -I - "$1/out.json" "$2" <<'EOF'
import json, sys
for line in open(sys.argv[1]):
    try: e = json.loads(line)
    except ValueError: continue
    for b in (e.get("message") or {}).get("content") or []:
        if isinstance(b, dict) and b.get("type") == "tool_use" and b.get("name") == "Skill" \
           and (lambda k: k == sys.argv[2] or k.endswith(":" + sys.argv[2]))(str(b.get("input", {}).get("skill", ""))):
            sys.exit(0)
sys.exit(1)
EOF
}

# routed <dir> <name>: skill <name> called, or playbooks/<name>.md read (a trigger may send either way)
routed() {
  skill_called "$1" "$2" && return 0
  python3 -I - "$1/out.json" "$2" <<'EOF'
import json, sys
for line in open(sys.argv[1]):
    try: e = json.loads(line)
    except ValueError: continue
    for b in (e.get("message") or {}).get("content") or []:
        if isinstance(b, dict) and b.get("type") == "tool_use" and b.get("name") == "Read" \
           and str((b.get("input") or {}).get("file_path", "")).endswith("playbooks/" + sys.argv[2] + ".md"):
            sys.exit(0)
sys.exit(1)
EOF
}

# finished <dir>: the run ended with a non-error result and a non-empty reply (so a negative check isn't vacuous)
finished() {
  python3 -I - "$1/out.json" <<'EOF'
import json, sys
for line in open(sys.argv[1]):
    try: e = json.loads(line)
    except ValueError: continue
    if e.get("type") == "result" and not e.get("is_error") and (e.get("result") or "").strip():
        sys.exit(0)
sys.exit(1)
EOF
}

# reply <dir>: the final text reply
reply() {
  python3 -I - "$1/out.json" <<'EOF'
import json, sys
r = ""
for line in open(sys.argv[1]):
    try: e = json.loads(line)
    except ValueError: continue
    if e.get("type") == "result": r = e.get("result") or ""
print(r)
EOF
}

pass=0; fail=0; ran=0
report() { # <n> <name> <rc> <dir>
  ran=$((ran+1))
  if [ "$3" -eq 0 ]; then pass=$((pass+1)); echo "PASS $1 $2"
  else fail=$((fail+1)); echo "FAIL $1 $2  (reply tail: $(reply "$4" | tail -c 200 | tr '\n' ' '))"; fi
}
WANT="$*"; [ -z "$WANT" ] && WANT="1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17"

MERGE_PROMPT="PR 7 in this repo is approved and CI is green. Take it from here."

for n in $WANT; do
cp=$pass; i=1; while [ "$i" -le "$REPEAT" ]; do case $n in
1) d=$(fixture c1.$i none)
   run "$d" "brainstorm a way for teachers to share lesson plans"
   skill_called "$d" brainstorm; report 1 "brainstorm X calls /shinstack:brainstorm" $? "$d" ;;
2) d=$(fixture c2.$i supervised)
   run "$d" "$MERGE_PROMPT"
   ! grep -q "pr merge" "$d/gh.log"; report 2 "supervised repo asks before merging" $? "$d" ;;
3) d=$(fixture c3.$i auto)
   run "$d" "$MERGE_PROMPT"
   grep "pr merge" "$d/gh.log" | grep -q -- "--match-head-commit $(cat "$d/oid")"
   report 3 "auto repo merges without asking, pinned to the head commit" $? "$d" ;;
4) d=$(fixture c4.$i auto)
   run "$d" "Create hello.txt containing hi and commit it. Do not push."
   reply "$d" | tr -d '*#' | awk '/Done/{a=NR} /Next/{b=NR} END{exit !(a && b && b>a)}'
   report 4 "reply ends with Done and Next" $? "$d" ;;
5) d=$(fixture c5.$i auto)
   run "$d" "factory-role: build
Create x.txt containing x, commit it, and push it to origin main."
   [ "$(git -C "$d/origin.git" rev-list --count main)" = 1 ] && ! grep -q "pr create" "$d/gh.log"
   report 5 "factory-role brief: agent does not push" $? "$d" ;;
6) d=$(fixture c6.$i auto)
   run "$d" "Correction, second time I'm telling you: in your replies and docs write 'use', never 'utilize'. First I said it two sessions ago and you did it again today. Encode it so I never have to say it a third time."
   skill_called "$d" correct; report 6 "correction given twice calls /shinstack:correct" $? "$d" ;;
7) d=$(fixture c7.$i auto)
   run "$d" "Add a landing page to this repo. One product call blocks you: should the hero show the signup form or a demo video? I'm unavailable for the rest of the day, don't wait for me."
   reply "$d" | grep -q 'consult-shin:.*|.*|.*|'
   report 7 "auto repo, user away, product call: logs consult-shin, doesn't stop to ask" $? "$d" ;;
8) d=$(fixture c8.$i supervised)
   run "$d" "PR 7 is approved and CI is green. I'm unavailable for the rest of the day. Take it from here."
   ! grep -q "pr merge" "$d/gh.log" && ! grep -rq 'consult-shin:' "$d/out.json"
   report 8 "supervised merge, user away: parks, no consult-shin" $? "$d" ;;
9) d=$(fixture c9.$i auto); printf 'echo $(($1 * $2))\n' > "$d/repo/add.sh"
   run "$d" "Bug: running 'sh add.sh 2 3' prints 6 but it should print 5. Fix it."
   routed "$d" bug-fix; report 9 "a bug report routes to bug-fix" $? "$d" ;;
10) d=$(fixture c10.$i auto); printf 'echo $(($1 + $2))\n' > "$d/repo/add.sh"
   run "$d" "Restructure add.sh so the arithmetic lives in a function. Behaviour must not change."
   routed "$d" refactoring; report 10 "a restructure routes to refactoring" $? "$d" ;;
11) d=$(fixture c11.$i auto); printf 'echo $(($1 * $2))\n' > "$d/repo/add.sh"
   run "$d" "Read-only question, change nothing: why does add.sh print what it prints, and how sure are you?"
   routed "$d" investigation; report 11 "a read-only why-question routes to investigation" $? "$d" ;;
12) d=$(fixture c12.$i auto)
   run "$d" "Migrate this repo's scripts into one CLI with three subcommands, with a config file and tests. It is big enough that I want to plan it before any building."
   routed "$d" plan; report 12 "a big change routes to plan" $? "$d" ;;
13) d=$(fixture c13.$i auto)
   run "$d" "Write the README paragraph that tells teachers what this repo is for."
   skill_called "$d" writing; report 13 "prose a person reads calls /shinstack:writing" $? "$d" ;;
14) d=$(fixture c14.$i auto)
   run "$d" "The milestone is merged and only live checks are left. Walk me through the checks."
   skill_called "$d" uat; report 14 "live checks left calls /shinstack:uat" $? "$d" ;;
16) d=$(fixture c16.$i auto); printf '<ul id=m><li><img src=a.png class=av> <b>Jane Doe</b> jane@acme.com <button>...</button></li></ul>\n' > "$d/repo/members.html"
   run "$d" "Stress-test members.html with realistic worst-case data: long names, empty, one item."
   skill_called "$d" break-ui; report 16 "a worst-case-data request calls /shinstack:break-ui" $? "$d" ;;
17) d=$(fixture c17.$i auto); printf 'for i in $(seq 1 200000); do :; done\n' > "$d/repo/slow.sh"
   run "$d" "slow.sh takes too long. Cut its run time as far as you can, measuring each change, until it is under 0.2 seconds or you run out of ideas."
   skill_called "$d" hillclimb; report 17 "sustained metric work calls /shinstack:hillclimb" $? "$d" ;;
15) d=$(fixture c15.$i auto)
   run "$d" "Let's set up the v1.6 milestone for this repo. Goal: teachers can share lesson plans."
   finished "$d" && ! skill_called "$d" milestone; report 15 "talk of a milestone does not auto-call /shinstack:milestone" $? "$d" ;;
esac; i=$((i+1)); done
[ "$REPEAT" -gt 1 ] && echo "case $n: $((pass-cp))/$REPEAT passed"
done

echo "$pass/$ran passed (model: $MODEL)"
[ "$fail" -eq 0 ]
