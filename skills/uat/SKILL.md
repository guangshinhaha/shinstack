---
name: uat
description: "Walk the user through a merged milestone's live checks one at a time on a fresh build of main: a card per check, they answer with a screenshot or pass/fail, passes close the issue, fails become issues. Use for /shinstack:uat, 'UAT', 'milestone merged, live checks left', 'walk me through the checks'."
---

# uat

Rule 4: no pass without evidence. For the checks only a person can see, hear or do, after the code is merged. Needs the user at the keyboard. It is not a merge gate (`ship.md` is).

## Gate

- Factory station, or the user is away: stop. Leave every issue open and name the ones waiting. `consult-shin` can't help: a model can't supply the evidence.
- Everything runs from merged code. An unmerged PR is not a check.

## Steps

1. **Select.** Open issues in the named milestone (or the ones the user names) whose Done when has a "Live check" line and whose PR is merged. Read the body and the latest comments; a comment that corrected the premise wins, and the card says so. Anything you can run yourself (a command, a test, a screenshot you can take), run and report; it gets no card.
2. **Build.** From a clean checkout of `origin/main`, with the repo's own build and launch command (CLAUDE.md, README, scripts, then `/run`; if none, say the one command you ran). State the SHA first and prove each issue's merge is in it (`git merge-base --is-ancestor <merge> <sha>`). One yes before quitting the user's running copy of the app.
3. **Order.** Smoke first (it launches at that SHA), then cheapest first grouped by shared setup, checks that touch real config last.
4. **One card at a time**, then wait:

   ```
   Check 2 of 3 · #142 · main@abc1234
   Setup (done): <what you faked or started>
   You do: <up to 3 physical steps>
   Expect: <plain words, observable>
   Fail if: <concrete>
   Send: <screenshot of what, or pass/fail>
   Restore: <how to undo, if anything real was touched>
   ```

5. **Read the reply** and say what matches the Expect and what doesn't, then move on:
   - **pass:** matches, with the user's screenshot or word this session. Never mark one without it. A screenshot that visibly contradicts their "pass": flag it once, they decide.
   - **fail:** contradicts Expect or hits Fail if.
   - **finding:** it works, or is odd, but the issue's premise was wrong or the Expect was ambiguous. Never a pass; the issue stays open; they pick accept-as-pass with the amended expectation, or file an issue.
   - **skipped:** the issue stays open.

## Never

- Touch real config (hooks or settings in `~/.claude`, app files under `~/`) without a yes for that card and a restore step you verify by reading the file.
- Touch accounts, credentials or real student, staff or citizen data (PDPA).
- Attach or send a screenshot anywhere. Read it locally; comments describe what was seen in words.
- Fake anything you didn't create this session. What you made (throwaway dirs and repos, processes and sockets you started, demo payloads, a separate build output) you remove at the end.
- Test staging or prod: that is a shared write and follows the repo's mode.

## End

- **pass:** comment `UAT pass at <sha>: <what was seen>` and close the issue.
- **fail:** a new issue in the product repo (repro, expected, observed, SHA, `Refs #N`) with no `ready` label, which is the user's permission. The original stays open.
- **finding:** a `Finding:` comment on the issue.
- A parent issue, if one exists, gets a roll-up comment. No `.md` file. Don't close the milestone.

**Reply:** passed, failed, finding, skipped (with issue links), then `milestone done: yes|no`, and "label #A, #B ready?" with your recommendation. A product repo's CLAUDE.md makes this a milestone's last step ("a milestone ends with `/shinstack:uat`").
