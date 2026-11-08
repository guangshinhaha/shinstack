#!/usr/bin/env python3
"""Count which shinstack skills and playbooks fired on one day.

Usage: skill-usage.py <projects-dir> <YYYY-MM-DD>

<projects-dir> is a Claude Code projects directory (default ~/.claude/projects).
The date is read in local time. Subagent transcripts count under their session.

Only tool_use blocks are read. From each one the script keeps the tool name,
the `skill` input of a Skill call, and the `file_path` input of a Read call
when that path is a playbooks/*.md or skills/*/SKILL.md file. It also reads
each record's `timestamp`. Nothing else in a transcript is read, and the output
holds only skill names, playbook and skill paths, counts, and session ids.
"""
import json
import re
import sys
from collections import Counter
from datetime import datetime
from pathlib import Path

PLAYBOOK = re.compile(r"(?:^|/)(playbooks/[^/]+\.md)$")
SKILL_MD = re.compile(r"(?:^|/)(skills/[^/]+/SKILL\.md)$")


def label_for(path):
    if not isinstance(path, str):
        return None
    m = PLAYBOOK.search(path) or SKILL_MD.search(path)
    return m.group(1) if m else None


def session_key(projects, f):
    parts = f.relative_to(projects).parts
    if "subagents" in parts:
        parts = parts[: parts.index("subagents")]
        return "/".join(parts)
    return "/".join(parts)[: -len(".jsonl")]


def local_day(ts):
    try:
        return datetime.fromisoformat(ts.replace("Z", "+00:00")).astimezone().date().isoformat()
    except (ValueError, OverflowError, OSError):
        return None


def hit_for(block):
    if not isinstance(block, dict) or block.get("type") != "tool_use":
        return None
    inp = block.get("input")
    if not isinstance(inp, dict):
        return None
    if block.get("name") == "Skill" and isinstance(inp.get("skill"), str):
        return f"Skill: {inp['skill']}"
    if block.get("name") == "Read":
        label = label_for(inp.get("file_path"))
        return f"Read: {label}" if label else None
    return None


def main(argv):
    if len(argv) != 3:
        print("usage: skill-usage.py <projects-dir> <YYYY-MM-DD>", file=sys.stderr)
        return 2
    projects, day = Path(argv[1]), argv[2]
    try:
        datetime.strptime(day, "%Y-%m-%d")
    except ValueError:
        print(f"date must be YYYY-MM-DD, got {day!r}", file=sys.stderr)
        return 2

    per_session = {}
    total = Counter()
    files = skipped = 0
    for f in sorted(projects.rglob("*.jsonl")):
        if not f.is_file():
            continue
        files += 1
        key = session_key(projects, f)
        try:
            fh = open(f, encoding="utf-8", errors="replace")
        except OSError:
            skipped += 1
            continue
        with fh:
            for line in fh:
                try:
                    rec = json.loads(line)
                except ValueError:
                    skipped += 1
                    continue
                if not isinstance(rec, dict) or not isinstance(rec.get("timestamp"), str):
                    continue
                if local_day(rec["timestamp"]) != day:
                    continue
                msg = rec.get("message")
                content = msg.get("content") if isinstance(msg, dict) else None
                if not isinstance(content, list):
                    continue
                for block in content:
                    hit = hit_for(block)
                    if hit:
                        per_session.setdefault(key, Counter())[hit] += 1
                        total[hit] += 1

    def show(counter):
        for hit, n in sorted(counter.items(), key=lambda kv: (-kv[1], kv[0])):
            print(f"  {hit}  x{n}")

    print(f"skill usage on {day} (local time): {files} transcript files scanned, "
          f"{len(per_session)} sessions with hits")
    for key in sorted(per_session):
        print(key)
        show(per_session[key])
    print("total")
    show(total)
    if skipped:
        print(f"unreadable lines skipped: {skipped}")
    return 0


if __name__ == "__main__":
    sys.exit(main(sys.argv))
