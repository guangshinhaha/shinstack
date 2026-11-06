# Fold cost-aware-delegation into guard-the-context-window

Date: 2026-11-06. Status: accepted. Closes #1.

## Decision
No standalone `cost-aware-delegation` principle. Its four ideas that shinstack lacked (budget each delegation, front-load context in the brief, pick the cheaper mechanism, exit before the cap) are bullets in `principles/general/guard-the-context-window.md`.

## Why
- The source principle's own "see also" points at `guard-the-context-window`. Both are about spending a finite budget of attention, and the existing bullet already said "cap scope, set turn budgets, account for mechanism costs".
- `feature.md` step 6 already requires briefs to name paths, data shape and success criteria, so a separate principle would repeat it.
- The source's numbers (2-3 files per CI phase, "budget - 7") are tuned to noodle's CI and turn limits. Copying them here would be false precision.

## Rejected
- Port it verbatim under `principles/general/`: duplicates a neighbour, adds a router and README entry for four bullets.

## Consequences
- shinfactory can drop its pointer to the noodle principle.
