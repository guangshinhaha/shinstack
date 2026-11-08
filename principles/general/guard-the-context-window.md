# Guard the Context Window

**Apply:** when context is filling up: large outputs, long files, repeated reads, fan-out planning.

**Why:** Context overflow degrades reasoning quality, creates compression artifacts, and halts progress.

**Pattern:**
- **Size phases and cap scope.** Limit files per phase, set turn budgets, account for mechanism costs.
- **Budget every delegation.** A subagent, CI run or fan-out has a turn or cost cap. Count setup, reading, implementing, verifying and git ops against it; if the sum doesn't fit with a margin, the scope is too large. Split it.
- **Front-load context in the brief.** Paths, data shape and what you already found. A longer prompt costs one read; making the delegate rediscover it costs several turns.
- **Name each delegate's role and weight.** Roles: explorer (reads and reports), builder (writes the change), reviewer (checks a diff against a standard), adversary (tries to break it), verifier (independent check at the head), judge (picks between candidates). Weights: light (search, read, summarize), standard (write or review code), strong (a wrong call is costly: verifier, judge). Playbooks and skills name roles and weights, never models. The host maps weights to models.
- **Pick the cheaper mechanism.** A subagent that returns directly beats a coordinated team unless the work needs agents to talk to each other.
- **Exit before the cap.** Commit passing work with the margin intact; git operations cost turns too.
