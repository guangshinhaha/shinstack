---
name: writing
description: "Standard for any prose a person reads: docs, READMEs, PR titles and bodies, commit messages, issue text, replies. Picks the document mode, sets sentence rules, and cuts AI tells. Use when drafting or editing such text, or when the user says it sounds like AI."
---

# Writing

Write so a tired reader understands on the first read, and nothing reads as machine-written. Preserve meaning and match the tone asked for. Rule 1 (short and plain) is the source.

Three rules sit above the rest:

- Cut every word that does no work. "In order to" is "to". "It is important to note that" is nothing.
- Use the short word: "use", not "utilize"; "help", not "facilitate"; "many", not "numerous"; "if", not "in the event that".
- When a rule makes a sentence worse, fix the sentence another way. A sentence that follows every rule and still sounds like a machine has failed.

The codebase is the word list. Write the real symbol, file, flag or command, not a description of it. Don't invent jargon: say "move", not "evacuate"; "a limit that only tightens", not "ratchet"; "the last phase", not "endgame".

## Pick the mode first (Diátaxis)

One document, one mode. Does it inform action or understanding, and does it serve learning or work?

- **Tutorial** (action, learning): open by saying what the learner will build. Every step shows a visible result and what to expect. Say "we", in commands.
- **How-to** (action, work): steps to a goal the reader has. Assume competence, no background. Allow forks: "If you want x, do y." Name it by the task.
- **Reference** (understanding, work): only facts, options, limits and errors, dry and complete, no opinion. Mirror the structure of the thing described.
- **Explanation** (understanding, learning): one bounded topic, with the why: constraints, history, alternatives. Opinion belongs here and nowhere else.

Don't mix modes. Split and link instead.

## Sentences

- Say who does what, in the present tense: "the compiler checks", not "is checked". Passive only when the actor is unknown or beside the point.
- Instructions are commands, one per sentence, condition first: "To delete the file, run `rm`." Never "simply", "easy" or "quickly" in a procedure.
- One thought per sentence; split past about 25 words. Mix lengths: short sentences land a point, a longer one carries a fact with its condition.
- Keep "the" and "a". Use one word per action and one name per thing, everywhere.
- Keep "only" and "not" next to the word they change. Make every "it", "they" and "this" point at one noun; never use "this" or "which" for a whole clause. Break noun strings: "the script that checks the proto-import budget".
- Use periods, not semicolons. Straight quotes, sentence-case headings, no decorative emojis. No slashes ("a, b, or both", not "a/b"), no idioms, no Latin abbreviations.
- Headings carry the point ("Pick the mode first", not "Modes"). A task heading is a bare verb phrase. One h1, no skipped levels.
- Number a sequence; bullet the rest. Introduce a list with a full sentence. Keep items parallel.
- Link with words that say where it goes, never "click here".
- Don't compress until the reader must decode: "Parser rejects bad date → exit 2, no write" becomes "The parser rejects a bad date, exits with code 2, and writes nothing."

## AI tells to cut

- **Filler and chatbot talk.** "I hope this helps", "Certainly!", "Great question", "Found the smoking gun!", "due to the fact that" (because), "could potentially possibly" (may), generic conclusions ("the future looks bright"). Delete or state the fact.
- **AI vocabulary.** crucial, delve, enhance, foster, garner, interplay, intricate, pivotal, showcase, tapestry, testament, underscore, vibrant, landscape (abstract). "Serves as", "stands as", "boasts" become "is" or "has".
- **Shapes.** "Not just X, but Y" (state Y); forced groups of three; "highlighting...", "ensuring..." tails; "from X to Y" with no real scale; one thing under four names in a paragraph (pick one); vague attributions ("experts believe": name the source or cut).
- **Formatting.** Several em dashes in a paragraph; colons as mid-sentence connectors; bold on every noun; a bold label that only restates its line ("**Performance:** performance improved"). A bold lead-in that names the item and adds new detail is fine.
- **Metaphor nouns.** substrate, wedge, vector, locus, nexus, bedrock, scaffolding, paradigm, modality, harness (as metaphor), surface (as in "API surface"), gold-plating, north star, flywheel. Name the concrete thing.
- **Mannered prose.** Aphorisms ("wire it or delete it"), personified code ("the plan holds it"), figurative verbs ("rides along"). Say what you mean.
- **Feeling instead of mechanism.** "SQL you can read" names a feeling; "`.toSQL()` returns the exact string sent to the database" names a fact. If a sentence could sit unchanged in another project's docs, it says nothing about this one. Cut it.
- **Adverbs on weak verbs.** "runs quickly" becomes "is fast" or the number.

## PRs, commits and replies

A PR body is a briefing a reviewer reads in under a minute. Link logs, SHA lists and metric tables; don't paste them. Product UI strings are not documentation. Make every count or tree claim true at the commit that lands it, and give the command that regenerates it.

Before:

> Configuration of the proto import ratchet budget script parameters is performed via budget.json. Note that it's important to remember that running with --write, which updates the committed budget to reflect the current count, should only be done when lowering it. If exceeded, CI fails.

After:

> `budget.mjs` reads the committed budget from `budget.json` and counts the files that import protos. If the count exceeds the budget, CI fails. Run `budget.mjs --write` only to lower the budget.
