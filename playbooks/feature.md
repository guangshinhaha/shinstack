# Feature from an issue or spec

Build what the acceptance criteria say, one verifiable slice at a time. Stop and ask if the issue isn't specific enough to build.

1. **Read the contract:** the issue body, its acceptance criteria, its out-of-scope list, and the comments (a later comment overrides the body). If nothing is observable to check, say what is missing and stop instead of guessing.
2. **Restate** the goal and the smallest change that meets it.
3. **Explore before coding:** the nearest existing code that does something similar, the data model you will extend, the repo's conventions (`/shinstack:how`). Name the data shape first (model-the-domain).
4. **Write the throughput checkpoint** as four lines, keeping any that don't apply as `n/a: <reason>`:
   - *Blocking first steps:* gates that run before any fan-out.
   - *Independent workstreams:* disjoint files, services or layers can run in parallel; shared writes serialize.
   - *Shared mutable state:* default to splitting the target (separate-before-serializing-shared-state).
   - *Smallest safe decomposition:* if one worker is best, say why.
5. **Plan the slices:** one per criterion, in an order where each ends in a checkable state (sequence-verifiable-units). Note what each test will assert (test-behavior-not-implementation). Code-coupled work stays with a single owner. Fan out only across slices that produce independent artifacts.
6. **Build each slice.** When delegating, the brief names the file paths, the data shape and its structure, and the success criteria. Failing test first when a cheap test path exists (`/shinstack:tdd`), smallest change that passes (laziness-protocol), run the repo's checks, one commit per slice.
7. **Prove it against the real thing:** run the feature, not just the tests (prove-it-works). A risky change gets `/shinstack:blast-radius`. A contested design gets `/shinstack:interrogate` before it ships.
8. **Open the PR** under the project's approval rules (`opening-a-pr.md`), with the goal first, the issue linked, and the verification output pasted.

**Reply:** slices done (X of N), the throughput checkpoint, evidence per slice, open decisions, anything left out of scope.
