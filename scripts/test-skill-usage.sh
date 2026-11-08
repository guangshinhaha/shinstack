#!/bin/sh
# Fixture test for skill-usage.py. Each transcript line carries sentinel strings in
# every place a message can hold text. The test fails if any sentinel reaches the output.
cd "$(dirname "$0")/.." || exit 1
set -u
tmp=$(mktemp -d) || exit 1
trap 'rm -rf "$tmp"' EXIT
p="$tmp/projects/-fixture-proj"
mkdir -p "$p/sess-1/subagents"

# Records use UTC stamps near midday. The run pins TZ=UTC so the local day is fixed on any host.
cat > "$p/sess-2.jsonl" <<'EOF'
{"type":"assistant","timestamp":"2026-11-08T09:00:00Z","message":{"role":"assistant","content":[{"type":"tool_use","name":"Skill","input":{"skill":"shinstack:interrogate"}}]}}
EOF

cat > "$p/sess-1.jsonl" <<'EOF'
{"type":"user","timestamp":"2026-11-08T12:00:00Z","message":{"role":"user","content":"SENTINEL_USER_5d0 please build it"}}
{"type":"assistant","timestamp":"2026-11-08T12:00:01Z","message":{"role":"assistant","content":[{"type":"thinking","thinking":"SENTINEL_THINK_4c6"},{"type":"text","text":"SENTINEL_TEXT_9f3 I will call shinstack:tdd"},{"type":"tool_use","name":"Skill","input":{"skill":"shinstack:feature"}}]}}
{"type":"assistant","timestamp":"2026-11-08T12:00:02Z","message":{"role":"assistant","content":[{"type":"tool_use","name":"Bash","input":{"command":"echo SENTINEL_CMD_7a1 && cat playbooks/babysit.md"}}]}}
{"type":"user","timestamp":"2026-11-08T12:00:03Z","message":{"role":"user","content":[{"type":"tool_result","content":"SENTINEL_RESULT_2b8 skills/recall/SKILL.md"}]}}
{"type":"assistant","timestamp":"2026-11-08T12:00:04Z","message":{"role":"assistant","content":[{"type":"tool_use","name":"Read","input":{"file_path":"/x/plugins/cache/shinstack/shinstack/0.20.0/playbooks/feature.md"}},{"type":"tool_use","name":"Read","input":{"file_path":"/x/repo/skills/craft/SKILL.md"}},{"type":"tool_use","name":"Read","input":{"file_path":"/x/repo/README.md"}},{"type":"tool_use","name":"Read","input":{"file_path":"/x/SENTINEL_PATH_8e2/playbooks/notes.md.bak"}}]}}
{"type":"assistant","timestamp":"2026-11-08T12:00:05Z","message":{"role":"assistant","content":[{"type":"tool_use","name":"Read","input":{"file_path":"/x/SENTINEL_PATH_8e2/notes.md"}}]}}
{"type":"assistant","timestamp":"2026-11-07T12:00:00Z","message":{"role":"assistant","content":[{"type":"tool_use","name":"Skill","input":{"skill":"shinstack:recall"}}]}}
this line is not json SENTINEL_BAD
EOF

cat > "$p/sess-1/subagents/agent-1.jsonl" <<'EOF'
{"type":"assistant","timestamp":"2026-11-08T13:00:00Z","message":{"role":"assistant","content":[{"type":"tool_use","name":"Skill","input":{"skill":"shinstack:feature"}},{"type":"tool_use","name":"Read","input":{"file_path":"/x/repo/playbooks/feature.md"}}]}}
EOF

out=$(TZ=UTC python3 -I scripts/skill-usage.py "$tmp/projects" 2026-11-08) || { echo "FAIL: script exited non-zero"; exit 1; }
expected='skill usage on 2026-11-08 (local time): 3 transcript files scanned, 2 sessions with hits
-fixture-proj/sess-1
  Read: playbooks/feature.md  x2
  Skill: shinstack:feature  x2
  Read: skills/craft/SKILL.md  x1
-fixture-proj/sess-2
  Skill: shinstack:interrogate  x1
total
  Read: playbooks/feature.md  x2
  Skill: shinstack:feature  x2
  Read: skills/craft/SKILL.md  x1
  Skill: shinstack:interrogate  x1
unreadable lines skipped: 1'
if [ "$out" != "$expected" ]; then
  echo "FAIL: output differs from expected"
  printf '%s\n' "$out"
  exit 1
fi

if printf '%s\n' "$out" | grep -q SENTINEL; then
  echo "FAIL: transcript message text or path leaked into output"
  exit 1
fi

echo "skill-usage test ok"
