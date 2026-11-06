---
name: autopilot
description: "Drive a set of open PRs to merge-ready with an owner per PR and an independent verifier who writes a verdict file at each head SHA. Use for /shinstack:autopilot, 'run autopilot on these PRs', or PRs that need independent verification before they count as ready. Stack mode stops at verified; full mode continues to shipping when approval-modes allows merging."
---

# Autopilot

Read `../../playbooks/autopilot.md` in full and follow it. Check the repo's `approval-modes` first: it decides stack mode or full mode.

If the user named PRs, those are the queue. If not, list the open PRs with `gh pr list` and confirm the queue in one line before starting.

Reply with the playbook's own reply format, then Done and Next.
