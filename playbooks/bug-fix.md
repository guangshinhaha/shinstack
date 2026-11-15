# Bug fix

Every shipped line traces to runtime evidence. A "might help" change is a hypothesis, not a fix, and it does not ship. When evidence refutes a hypothesis, revert what it motivated. Ship the smallest change the evidence justifies, nothing more. Done by one agent; in a factory run the owner does steps 1-6 and a different agent verifies (`ship.md`).

1. **Reproduce it yourself,** on the surface where it happens. Ask the human only with a specific reason you can't. If it won't reproduce, synthesize the trigger, tighten the conditions, or instrument until it fires.
2. **Find the cause by elimination.** List the candidate hypotheses, then rule them out until one survives. Each pass, take the split that cuts the most remaining problem space, get runtime evidence, and eliminate. When state is unclear, add logging and read it as the code runs. Don't guess. Use `git log` and `git blame` for the regression history. Two failed fixes mean suspect their shared premise. **Confirm the surviving mechanism with evidence before planning the fix.**
3. **Plan the smallest fix** (if the bug is state or branch sprawl, name the data shape that makes the bad state unrepresentable). Stop and settle the design only at a real fork: the fix changes a data shape or a public interface. Crossing a function boundary is not a fork.
4. **Verify on the same surface:** the original repro now passes. "Inconclusive" or the wrong surface is not a pass; flag it. Unit tests show branch behavior, not that the bug is gone.
5. **Commit the failing repro or test before the fix.** Skip a test only when it would be expensive or unclear, and say what you used instead. Outside a factory station, push each commit (per rule 2), so a killed session resumes from the branch (`/shinstack:recall`).
6. **Run the repo's lint, typecheck and tests,** then open the PR (`opening-a-pr.md`) under the repo's mode. If the bug shipped past a review that should have caught it, log it as friction (router).
7. **Hand off.** Outside a factory station, if the PR has red CI or review comments, work it per the router's watching line. Otherwise stop at the PR URL.

**Reply:** what was broken, the root cause, the fix, how you verified. Paste the failing-then-passing output verbatim.
