# Babysit a PR
Keep one open PR moving until it is merge-ready. Fix on the same PR; don't open new ones.
1. **State the mode** before polling: watch CI only, handle review comments only, or both until merge-ready.
2. **Check status:** CI runs, review threads, requested changes. Read each failing check's log, not just its name.
3. **CI failure:** reproduce locally, find the root cause (fix-root-causes), fix it, push to the same branch. A flaky check is reported as flaky with evidence, not silently re-run until green.
4. **Review comments:** triage each as fix, dismiss (with a concrete reason), or ask. Bots and reviewers catch real bugs and also file nitpicks, so judge each on its merits instead of churning code. Reply on the thread with what changed.
5. **Re-verify** after each push: run the repo's checks, then re-read status. Don't declare green from memory.
6. **Stop condition:** all checks green and no unresolved blocking comments. Then follow the project's approval rules: some projects merge here, others wait for the user.
Reply: PR state, what changed since last check, what is blocking, the single next action.
