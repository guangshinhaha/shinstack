# Hillclimb is back

**Decision:** restore `hillclimb` as a playbook and skill, with one short router trigger (`push a metric over runs`) and an index entry.

**Why:** the #70 rebuild deleted it as zero-use (`shinstack-rebuild.md`). Shin wants it back: sustained metric work (latency, accuracy, cost) has no other home, and `bug-fix` is one fix, not a loop.

**What changed from the old version:**
- Rewritten against today's files. The links to `how`, `benchmark-checklist`, `show-me-your-work`, `perf-issue`, `autonomous-run` and the "builder (standard weight)" label are gone; their jobs point at `investigation.md`, `coordinate.md` and a Sonnet worker.
- Added what the deleted `benchmark-checklist` used to give: at least 5 alternating runs, median and range, so "past noise" is measurable.
- Dropped the speed mantras that lived in `perf-issue.md`; the mechanism rule (step 4) stays.

**Router line, added after a verifier's FAIL:** the first version had none, on the guess that the skill description would fire it. The independent verifier ran `scripts/router-eval.sh` case 17 (a sustained-speedup request) on Sonnet: 0/6, the skill listed but never called. With the clause on the plan line, the same case passes 3/4 on Sonnet. The hook is now 8994 of 9000 bytes, so the next router change must free bytes first. Haiku, the harness default, is not a useful signal (it also misses `writing`, case 13).

**Risk:** High: `playbooks/**` is a gantry High-risk path and the router file changed.

**Revisit:** if "make it faster" requests still skip the skill, widen the clause and free bytes elsewhere first.
