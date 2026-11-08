# Feature from an issue or spec

Build what the issue or spec's Done when says, one verifiable slice at a time. Stop and ask if the issue isn't specific enough to build.

1. **Read the contract:** the issue body, its Done when (acceptance criteria or any other observable statement of done counts, whatever the heading), its out-of-scope list, and the comments (a later comment overrides the body). If nothing is observable to check, say what is missing and stop instead of guessing. If the issue lists Decided, Assumed or Open items:
   - *Decided:* build to it and don't reopen it. If evidence rules it out, show the evidence and stop.
   - *Assumed:* build on it. If the code contradicts it, take the smallest change that still meets the goal and say so in the PR.
   - *Open:* if it doesn't block the build, take its default, or the most reversible option if it has none, and list it in the PR as your call. If it blocks, settle it by reading or running what you can. If only a person can settle it, say what is missing and stop.
2. **Restate** the goal and the smallest change that meets it.
3. **Explore before coding:** the nearest existing code that does something similar, the data model you will extend, the repo's conventions (`/shinstack:how`). Name the data shape first (model-the-domain). A wide search goes to explorers (light weight, `guard-the-context-window`).
4. **Write the throughput checkpoint** as four lines, keeping any that don't apply as `n/a: <reason>`:
   - *Blocking first steps:* gates that run before any fan-out.
   - *Independent workstreams:* disjoint files, services or layers can run in parallel; shared writes serialize.
   - *Shared mutable state:* default to splitting the target (separate-before-serializing-shared-state).
   - *Smallest safe decomposition:* if one worker is best, say why.
5. **Plan the slices:** one per Done when item, in an order where each ends in a checkable state (sequence-verifiable-units). Note what each test will assert (test-behavior-not-implementation). Code-coupled work stays with a single owner. Fan out only across slices that produce independent artifacts.
6. **Build each slice.** When delegating, the builder (standard weight) gets a brief with the file paths, the data shape and its structure, and the success criteria. Per slice: call `/shinstack:tdd` first when a cheap test path exists (otherwise say what proves the slice), make the smallest change that passes (laziness-protocol), run the repo's checks, then commit and push the slice (push per `approval-modes`), so a killed session resumes from the branch (`/shinstack:recall`).
7. **Prove it against the real thing:** run the feature, not just the tests (prove-it-works). Review depth is chosen once, in step 8, from the table in `opening-a-pr.md`. Don't run `/shinstack:blast-radius` or `/shinstack:interrogate` here, or a High PR runs them twice.
8. **Open the PR** under the repo's `approval-modes` (`opening-a-pr.md`), with the goal first, the issue linked as that playbook says, and the verification output pasted.
9. **Hand off.** Outside shinfactory, if the PR has red CI or review comments, continue in `babysit.md`. Otherwise stop at the PR URL.

**Reply:** slices done (X of N), the throughput checkpoint, evidence per slice, open decisions, anything left out of scope.
