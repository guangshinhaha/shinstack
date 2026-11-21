# Hillclimb is back

**Decision:** restore `hillclimb` as a playbook and skill, reached through its skill description and the index, with no router trigger.

**Why:** the #70 rebuild deleted it as zero-use (`shinstack-rebuild.md`). Shin wants it back: sustained metric work (latency, accuracy, cost) has no other home, and `bug-fix` is one fix, not a loop.

**What changed from the old version:**
- Rewritten against today's files. The links to `how`, `benchmark-checklist`, `show-me-your-work`, `perf-issue`, `autonomous-run` and the "builder (standard weight)" label are gone; their jobs point at `investigation.md`, `coordinate.md` and a Sonnet worker.
- Dropped the speed mantras that lived in `perf-issue.md`; the mechanism rule (step 4) stays.

**No router line:** the injected router is 8943 of 9000 bytes. The skill's description fires it and `skills/router/index.md` lists it, so the router file doesn't change.

**Revisit:** if a run shows the skill isn't picked up when someone says "make it faster", add one clause to the router and trim elsewhere to pay for it.
