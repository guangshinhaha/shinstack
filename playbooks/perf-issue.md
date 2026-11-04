# Perf issue

**You own the measurement story. Tie every fix to a measurement; don't read source instead of measuring.** For a one-off fix. Sustained improvement of a metric is `hillclimb.md`.

1. **Capture a baseline** with the right instrument (a profiler, a trace, a benchmark script on a realistic workload). Vet the baseline, and every later number, with `/shinstack:benchmark-checklist` and explain-the-number.
2. **Ground hypotheses** in how the code actually runs (`/shinstack:how`). Don't claim a ceiling without running it. Then try the performance mantras in order, cheapest first, and stop at the first that meets the target:
   1. Don't do it. Stop work whose result nothing uses.
   2. Do it, but don't do it again.
   3. Do it less.
   4. Do it later.
   5. Do it when they're not looking.
   6. Do it concurrently.
   7. Do it cheaper.
3. **Plan the fix from the trace.** If it crosses a function boundary, sketch it first (`/shinstack:architect`). Make one attempt at a time and verify each before the next (sequence-verifiable-units). Review the diff. Capture a post-fix measurement the same way as the baseline.
4. **Compare the artifacts** (diff the outputs, load the numbers into a table). "Inconclusive" or the wrong surface is not a pass; flag it.
5. **Cite the measurement in the PR** (`opening-a-pr.md`).

**Reply:** baseline number, post-fix number, delta, and the artifact path.
