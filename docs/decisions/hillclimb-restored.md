# Hillclimb is back

**Decision:** restore `hillclimb` as a playbook and skill, reached through its skill description and the index, with no router trigger.

**Why:** the #70 rebuild deleted it as zero-use (`shinstack-rebuild.md`). Shin wants it back: sustained metric work (latency, accuracy, cost) has no other home, and `bug-fix` is one fix, not a loop.

**What changed from the old version:**
- Rewritten against today's files. The links to `how`, `benchmark-checklist`, `show-me-your-work`, `perf-issue`, `autonomous-run` and the "builder (standard weight)" label are gone; their jobs point at `investigation.md`, `coordinate.md` and a Sonnet worker.
- Added what the deleted `benchmark-checklist` used to give: at least 5 alternating runs, median and range, so "past noise" is measurable.
- Dropped the speed mantras that lived in `perf-issue.md`; the mechanism rule (step 4) stays.

**No router line:** the injected router is 8943 of 9000 bytes. The skill's description fires it and `skills/router/index.md` lists it, so the router file doesn't change.

**Routing check:** `scripts/router-eval.sh` case 17 (a sustained-speedup request) calls `hillclimb` 2/2 on Sonnet with no router line. The harness default, Haiku, is not a useful signal (it also misses `writing`, case 13).

**Risk:** `playbooks/**` is a gantry High-risk path, so this PR is labelled `risk:high` and needs an independent verdict even though the router file is untouched.

**Revisit:** if a run shows the skill isn't picked up when someone says "make it faster", add one clause to the router and trim elsewhere to pay for it.
