# break-ui, and Emil's motion rules in interaction-design

**Decision:** add `break-ui` (worst-case data), put Emil Kowalski's "should this animate" and easing rules into `interaction-design`, delete its generic snippet references, and install none of his plugin. Issue #90.

**Why:** shinstack's three UI skills came from poteto/noodle, and `frontend-design` is Anthropic's. None tests a UI with hostile data, and `interaction-design` had a timing table plus about 34KB of generic Framer and GSAP snippets with no rule for when not to animate. A Fable comparison against [emilkowalski/skills](https://github.com/emilkowalski/skills) (MIT) found his motion rules and `break-ui` better; polish was a draw; direction fit neither (#99).

**Why not install his set:** 17 of 19 skills open with a scripted "I'm ready to..." line that clashes with the router's no-task line, 5 disable model invocation, and it is about 366KB with its own routing style. Same reason dx-harness was removed.

**What changed:**
- `skills/break-ui`: rewritten in shinstack's voice, not copied. Adds the catalog government tools need: Chinese, Tamil, Malay `bin`/`binti`, Indian `s/o` and `d/o`, single names, long agency names. A finding survives only if a run shows it. Synthetic data only (PDPA).
- `interaction-design`: frequency table and easing rules in 20 lines; "prefer springs" narrowed to drag, interruptible gestures and pointer tracking. Deleted `references/scroll-animations.md` and `references/microinteraction-patterns.md`.
- README credits Emil Kowalski.

**No router line:** the injected router is about 8941 of 9000 bytes. The skill description fires `break-ui`; the index lists it. Revisit if a run shows it isn't picked up.

**Left alone:** `learn-taste` (`correct` and `reflect` cover it), `prototype` (maybe later), his other motion skills, and the 0.96 vs 0.97 press-scale difference in `make-interfaces-feel-better`.
