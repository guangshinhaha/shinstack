# Hillclimb is back

**Decision:** restore `hillclimb` as a playbook and skill, with no router trigger.

**Why:** the #70 rebuild deleted it as zero-use (`shinstack-rebuild.md`). Shin wants it back: sustained metric work (latency, accuracy, cost) has no other home, and `bug-fix` is one fix, not a loop.

**What changed from the old version:**
- Rewritten against today's files. The links to `how`, `benchmark-checklist`, `show-me-your-work`, `perf-issue`, `autonomous-run` and the "builder (standard weight)" label are gone; their jobs point at `investigation.md`, `coordinate.md` and a Sonnet worker.
- Added what the deleted `benchmark-checklist` used to give: at least 5 alternating runs, median and range, so "past noise" is measurable.
- Dropped the speed mantras that lived in `perf-issue.md`; the mechanism rule (step 4) stays.

**No router line, and why:** the injected router is about 8943 of 9000 bytes. A first eval of the skill description alone (case 17, a no-op `slow.sh`) failed 0/6 on Sonnet; adding a router clause lifted it to 4 of 6 and 3 of 4. Both were wrong turns: the fixture was unrealistic (deleting the loop is a 1000x win, so Sonnet just did it without a loop). On a fixture that needs many rounds (`primes.py`, the final case 17), the description alone fires `hillclimb` 6/6 on Sonnet, and the same 6/6 with the clause removed. So the clause is not needed and was reverted. Haiku, the harness default, is not a useful signal (it also misses `writing`, case 13).

**Risk:** High: `playbooks/**` is a gantry High-risk path, so this PR is labelled `risk:high` and needs an independent verdict. The router file is untouched.

**Revisit:** if "make it faster" requests skip the skill in real use, add one router clause and free bytes elsewhere first.
