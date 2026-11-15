# Skill merges and reflect files issues (#71, step 3 of #68)

- `writing` replaces `unslop` and `technical-writing`: one copy of each rule (rule 6). Overlaps (filler, plain words, active voice) are said once; the AI-tell catalog and the sentence layers survive.
- `recall` absorbs `ketchup` and `show-me-your-work`: all three re-enter cold (rule 1). The decision trail is no longer a TSV file: rule 7 keeps state in issues, so it goes in batched comments or a `Decided` section. `log.sh`, the transcript audit and the cross-model review are gone.
- `reflect` files issues in the repo that owns the cause (rule 8) and writes no local file. One pass with a "argue against it" step replaces three reviewers and a synthesizer. Until #72 removes the router's friction log, reflect files the old `shinstack-friction.md` lines as issues and tells the user to delete the file.
- `correct` and `init` keep only lines that trace to a rule. `correct` also carries the lessons from closed PR #65 (CI cost controls, independent review, no "gate" before a required check).
- Older records that mention `unslop` or the friction log (`review-depth.md`, `merge-gate-follows-risk.md`) are history and are not rewritten.
