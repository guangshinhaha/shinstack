# Refactoring

**You own the contract. The structure changes; the behavior does not.** Distinct from `feature.md` (adds behavior) and `bug-fix.md` (corrects it). If the cleanup reveals a missing feature or a real bug, split it out and ship the structural change first against the pinned contract. Large cross-cutting work is `/shinstack:figure-it-out`.

1. **Pin the behavior first.** Learn the contract (`/shinstack:how`), then write a characterization test, snapshot or equivalence harness that captures current behavior before any structure moves. No coverage means write the pin first. Type check and lint are not a pin.
2. **Name the structure the code is missing** (model-the-domain). Boring code stays when its shape is already clear and local. The reshape must delete branches or invalid states, not add indirection.
3. **Name the target shape:** the module layout, types and call graph if it were built today. If it crosses a function boundary, sketch it with `/shinstack:architect` first.
4. **Subtract before you add.** Delete dead code, collapse one-caller wrappers, drop redundant validators and orphan references, then reshape. The smallest change that reaches the target ships.
5. **Move in small steps, each keeping the pin green.** For API reshapes, migrate every caller and delete the old API in the same wave: no shims, no parallel old and new paths. Spot-check every rename against the actual files, because renames miss usages in strings and prose.
6. **Prove behavior is unchanged on the real artifact,** not "it compiles". For bigger reshapes, use an equivalence check: a script that diffs old and new outputs, or a recorded baseline replayed against the new code.
7. **Keep it only if it earns it.** The measure is reduced reader load (minimize-reader-load). If the diff doesn't lower it somewhere, revert.
8. **Commit in order:** subtraction, then the reshape, then any cleanup. Then `opening-a-pr.md`.

**Reply:** the structure that changed, the pin you held it against, the equivalence proof, the reader-load change, what shipped and what was reverted. No new behavior.
