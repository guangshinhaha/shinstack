---
name: brainstorm
description: "Call this before answering when the user brings a new idea and hasn't settled what to build, even if you could answer directly: 'brainstorm', 'help me think', 'i'm thinking of', 'what if we', 'should we build', 'is this a good idea', or /shinstack:brainstorm. Sizes the idea as small, unclear or big, gives a position instead of a list of questions, and ends in a draft artifact or draft issues. Not for a design question inside a task already underway, a bug, or an issue or spec that is ready to build."
---

# Brainstorm

Help the user think by giving them something to push against. A question the user can't answer never stops the work. Don't implement anything.

## Start with a position

1. **Restate the idea in one line.** Most corrections are premise fixes, so let the user catch a wrong frame early.
2. **Hand over what isn't an idea.** Send a bug to `/shinstack:bug-fix`, and an issue or spec that is ready to build to `/shinstack:feature`. An issue too vague to build counts as an idea, so stay here.
3. **Say the size and why, in one line.** The user can overrule it with a word, and you change it when the evidence changes.

| Size | How to recognize it | What you do |
|---|---|---|
| Small | One thing, and you can already say what done looks like | Skip the questions. Go to "End on something concrete" with your assumptions |
| Unclear | You can't yet say what to build or who it is for | Continue below |
| Big | Several pieces, or the order isn't clear | Continue below, and expect a parent issue |

4. **Retrieve before you ask, and scale it to the size.** For a small idea, read only the code or issue it touches. For the rest, read the repo, the issues and past chats. Pull from connected sources such as Slack or meeting notes when the user points at them, and synthesize the material first. Write "I assumed X from Y" instead of asking for X. Treat student, staff and citizen data as sensitive: don't pull it in unasked, and don't send it to external services. For a scoping call, read `../../principles/product/README.md` and the matching file.
5. **Open with a position.** Say what you would build first, who it is for, why, what you would leave out, and what would change your mind. Give a flat verdict, not conditionals. A wrong first pass is useful, because the user sharpens the idea by pointing at the gap.

If the user says they want to understand first, walk through the items one by one and hold your recommendation until they have seen them all.

If the user asks directly whether to do it, or the evidence rules it out, say so and show the evidence. "Don't build this" is a valid ending.

## Ask only what moves the idea

- Ask only about a judgment call that retrieval can't answer and that would change the first slice.
- Give every question a recommended answer. Accept "ok", a number or free text.
- Ask at most two questions at a time while the idea is forming. Ask at most four when the decisions are bounded and the shape is settled.
- Don't ask the user to justify the idea, assess themselves, or commit to a position before anything is on the table.
- Don't ask whether they should do this at all. If you see a real risk that doesn't rule the idea out, state it once in one line and carry on.
- Offer options only with your pick, and at most three. The exception is wording, where the user may want many.

## Never get stuck on an unknown

- Ask each question once. If the user skips it, or says "not sure" or "you write first", take that as a handoff. Record an assumption or an open item, then keep going with your default.
- If the user is lost, restate the idea as plain segments, each with a default to correct.
- Take new material at any point, with or without a question. Say what it changed.
- If building something small would settle a question faster than talking, offer `/shinstack:prototype`.

Keep a running record in the chat, and update it when something changes:

- **Decided:** what the user settled. Never ask about these again.
- **Assumed:** your defaults, marked as your call and not the user's.
- **Open:** each unknown, how to find out (ask a person, check data, build a prototype), and whether it blocks the first slice.

When someone asks where things stand, answer from this record. Stop when the open items wouldn't change the first slice.

## End on something concrete

Never end on a question alone. End with a draft and one next step. Set the length by who reads it: short and point-form for people, detailed for anything an agent or engineer builds from.

| What the idea became | Draft | Next step |
|---|---|---|
| Something to show or send to people | A one-pager, a message or a deck outline | The user sends it |
| One or two buildable pieces | One issue for each | `/shinstack:feature #N` |
| Three or more independent pieces, in a known order | A parent issue with a checklist of child issues | `/shinstack:orchestrate #N` |
| Pieces that depend on each other, or an unclear order | A parent issue that lists the pieces and the open questions | `/shinstack:multi-phase-plan` |

Each issue states its goal, what you can observe when it is done, what is out of scope, and the Decided, Assumed and Open items it depends on. The next agent can't see this chat. Each child issue must stand alone for the same reason.

Say who has to test the result and what that costs before you file anything. File issues only after the user says yes, and use GitHub issues rather than `.md` backlogs. Don't start building. The user starts that with the next step.
