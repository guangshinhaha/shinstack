# Bug fix
Every shipped line traces to runtime evidence. A "might help" change is a hypothesis, not a fix. Ship the smallest change the evidence justifies.
1. Reproduce it yourself, on the surface where it happens. Ask the human only with a specific reason you can't. If it won't reproduce, tighten conditions or instrument until it does.
2. Find the cause by elimination: list hypotheses, pick the check that cuts the most, get runtime evidence, rule out. Two failed fixes -> attack-the-premise. Confirm the mechanism with evidence before planning the fix.
3. Plan the smallest fix (laziness-protocol; model-the-domain if the bug is state/branch sprawl).
4. Verify on the same surface: the original repro now passes. "Inconclusive" is not a pass.
5. Commit the failing repro/test before the fix (sequence-verifiable-units).
6. Run the repo's lint/typecheck/tests. Then open the PR and follow the project's approval rules (see the local overlay in the router, or stop before merge if there is none).
Reply: what was broken, root cause, fix, how verified. Paste failing-then-passing output verbatim.
