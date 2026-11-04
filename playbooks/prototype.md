# Prototype

**You own the design decision, not the code. The prototype is a throwaway instrument; the real build follows `feature.md`.** The one playbook where "smallest change" and the usual verification bar invert: speed over polish, no tests, no planning. The rigor is in picking the right design cheaply.

1. **Scope the decision** the prototype exists to make: which layout, interaction or density, or for an empirical fork which behavior, timing or approach. No decision means no prototype; go to `feature.md`.
2. **Gather references** when the design space is open (prior art, themes, layouts) and let the user pick directions before building. Skip when the direction is set.
3. **Build throwaway in an isolated scratch directory,** outside production source. For a visual decision, plain HTML, CSS and JS with a hot-reload dev server. For a behavioral or timing decision, the smallest script that exercises the question. No production framework, no abstractions.
4. **Compare alternatives behind one switcher,** each variant labeled.
5. **Verify on the matching surface.** Screenshot each variant and drive the interaction for a visual decision. For a behavioral decision, observe the thing you are deciding by logging the timing or printing the output. The observation is the test.
6. **Present** alternatives, tradeoffs and a recommendation. Hand the chosen direction to `feature.md` (or `/shinstack:architect` for the shape).

In a system with nobody to ask, this is how an agent settles a "which approach?" fork: run it and let the result decide.

**Reply:** the variants, the evidence (screenshots or the observed output), tradeoffs, your recommendation, and the scratch path. Say plainly that the prototype is throwaway.
