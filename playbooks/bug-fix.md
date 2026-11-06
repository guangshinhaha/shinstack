# Bug fix

Every shipped line traces to runtime evidence. A "might help" change is a hypothesis, not a fix, and it does not ship. When evidence refutes a hypothesis, revert what it motivated. Ship the smallest change the evidence justifies, nothing more. Done by one agent; in a factory run the owner does steps 1-6 and a different agent verifies (`autopilot.md`).

1. **Reproduce it yourself,** on the surface where it happens. Ask the human only with a specific reason you can't. If it won't reproduce, synthesize the trigger, tighten the conditions, or instrument until it fires.
2. **Find the cause by elimination.** List the candidate hypotheses, then rule them out until one survives. Each pass, take the split that cuts the most remaining problem space, get runtime evidence, and eliminate. When state is unclear, add logging and read it as the code runs. Don't guess. `/shinstack:how` gives the map and `/shinstack:why` the regression history. Two failed fixes mean attack-the-premise. **Confirm the surviving mechanism with evidence before planning the fix.**
3. **Plan the smallest fix** (laziness-protocol; model-the-domain if the bug is state or branch sprawl). If it crosses a function boundary, sketch it first (`/shinstack:architect`).
4. **Verify on the same surface:** the original repro now passes. "Inconclusive" or the wrong surface is not a pass; flag it. Unit tests show branch behavior, not that the bug is gone.
5. **Commit the failing repro or test before the fix** (`/shinstack:tdd`, sequence-verifiable-units). Skip a test only when it would be expensive or unclear, and say what you used instead.
6. **Run the repo's lint, typecheck and tests,** then open the PR (`opening-a-pr.md`) under the repo's `approval-modes`.

**Reply:** what was broken, the root cause, the fix, how you verified. Paste the failing-then-passing output verbatim.
