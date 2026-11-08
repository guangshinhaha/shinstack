# Skill usage reads tool names and paths only

Date: 2026-11-08. Status: accepted.

## Decision
`scripts/skill-usage.py` counts Skill calls and reads of `playbooks/*.md` and `skills/*/SKILL.md` per session for one day. It reads only `tool_use` blocks (their `name`, and the `skill` or `file_path` input) and each record's `timestamp`. It prints names, paths, counts and session ids, and nothing else from a transcript.

## Why
Routing fixes need measured counts, and the transcripts hold private work and personal data. A script that reads only these fields can run over every session without touching their text. `scripts/test-skill-usage.sh` puts sentinel strings in text, thinking, tool results, commands and user messages, and fails if any reaches the output.

## Rejected
- Printing the matched Read path in full: it can carry a user's directory names. The script prints only the `playbooks/…` or `skills/…` part. The session id does print its project directory name, which is needed to tell sessions apart.
- Sending counts to a dashboard or service: out of scope for the issue, and transcripts stay on the machine.

## Consequences
- A `playbooks/` or `skills/` folder in any project counts, not only shinstack's. Read the project name in the session id before you trust a count.
- A new record type that holds a skill call in a different shape will be missed until the script learns it.
