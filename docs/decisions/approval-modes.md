# Approval modes replace owned/gated project classes

Date: 2026-11-05. Status: accepted.

## Decision
Approval for push, PR, merge, deploy and shared-env writes follows a per-repo `shinstack-mode` (`auto | supervised | manual`), with an optional override per action. There is no per-kind-of-work override; to review a kind of work first, switch the repo to `supervised` by hand. See `principles/general/approval-modes.md`.

## Why
- The private overlay's `owned` class let the agent merge and deploy unasked. The user's global rule says one explicit OK per action. The two contradicted each other.
- The class was guessed from the origin URL (`project-class.sh`), so it said nothing about what the repo owner wanted.
- Policy belongs in the public repo, where it can be reviewed. The overlay keeps only tool routes and personal constraints.
- The modes mirror shinfactory's `mode`, so one vocabulary covers both.

## Rejected
- Keep owned/gated and edit the global CLAUDE.md to defer to the overlay: the policy stays private and URL-guessed.
- Cut the classes to "always ask": safe but slow on repos the user owns.

## Consequences
- A repo with no declaration is `supervised` (`manual` with no remote or a non-GitHub remote).
- Plugin 0.10.0 is the first version that has this. Sessions on the cached 0.9.0 do not.
