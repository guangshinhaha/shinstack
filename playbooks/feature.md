# Feature from an issue or spec
Build what the acceptance criteria say, one verifiable slice at a time. Stop and ask if the issue isn't specific enough to build.
1. **Read the contract.** The issue body, its acceptance criteria, its out-of-scope list, and the comments (a later comment overrides the body). If there is nothing observable to check, say what is missing and stop instead of guessing.
2. **Restate** the goal and the smallest change that meets it (see the router's first-message habit).
3. **Explore before coding.** Read the nearest existing code that does something similar, the data model you will extend, and the repo's conventions. Name the data shape first (model-the-domain).
4. **Plan the slices.** One slice per criterion, in an order where each ends in a checkable state (sequence-verifiable-units). Note what each test will assert (test-behavior-not-implementation).
5. **Build each slice:** failing test first when a cheap test path exists (tdd), smallest change that passes (laziness-protocol), run the repo's checks, one commit per slice.
6. **Prove it** against the real thing: run the feature, not just the tests (prove-it-works). Anything risky gets `blast-radius`.
7. **Open the PR** following the project's approval rules. The description opens with the goal, links the issue, and pastes the verification output.
Reply: slices done (X of N), evidence per slice, anything left out of scope.
