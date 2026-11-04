# External LLM Out of Sensitive Codebases

**Apply:** when an AI step would call an external model vendor from inside a sensitive codebase.

Move the step to a local tool that emits an artefact the existing deterministic path already accepts, even if the integration is built and reviewed.

**Why:** It removes the outbound call and review burden while keeping the deterministic path unchanged.
