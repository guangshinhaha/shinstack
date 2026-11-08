# Visual parity

**You own pixel-exact equivalence. The baseline is the spec, and you do not touch it.** Equivalence is verified by image diff, not by eye. For UI migrations: a framework move, a design-system swap, a rewrite.

1. **Baseline first,** before any migration: a visual regression harness that screenshots the current component across its states (for example the browser test runner's screenshot assertions), plus the target when matching two implementations. No baseline, no parity claim. This is a blocking prerequisite, not a follow-up.
2. **Hold the anti-shortcut clauses:** no changes to the harness, no baseline tampering, no restructuring a component to make a diff pass. If the baseline looks wrong, stop and ask. Do not edit it.
3. **Migrate one component at a time,** in parallel across worktrees with one owner per component (a builder, standard weight). Shared primitives migrate first, as a blocking phase.
4. **Verify each component against its baseline** by image diff on the real surface. A nonzero diff is a fail: investigate the pixel delta and iterate per component until the diff is zero.
5. **Open a PR** per component or per safe batch (`opening-a-pr.md`).

**Reply:** components migrated, the diff result for each, the baseline harness location, and what is left.
