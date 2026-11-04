# Eval

**You own the experiment design: plan, blind, run, synthesize.** Compares variants of an agent setup (a skill, a principle, a prompt) to see whether one actually helps. Behavior is graded from what agents did, not from what they say.

**Non-negotiables for blinding**
- The words `eval`, `test`, `judge`, `experiment`, `rubric`, `score`, `compare`, `benchmark`, `candidate` and `arena` appear in no directory, file or prompt a candidate sees.
- The candidate prompt reads like an organic request: state the goal, not the meta. Don't tell it other candidates exist.
- Don't ask a candidate to list which rules or files it used. Grade rule-following from the code and the files it opened.
- Use project-shaped directory and slug names.
- The judge may know it is judging but sees outputs by sanitized label only, never by model name. Comparing two variants, one judge scores both sets in a single pass on one scale.

**Steps**
1. **Frame:** the variant under test, and what counts as success. Write a 3-6 criterion rubric for the judge only.
2. **Set up sanitized environments:** one working directory per candidate with the variant in place, plus any context an organic task would have (a project skeleton, the rules it would naturally read).
3. **Author one organic prompt,** what a user would type, with no leak of what is measured.
4. **Run N candidates in parallel** as subagents, each in its own sanitized directory, same prompt. Use different models where you have them.
5. **Run one blinded judge,** a fresh-context subagent (a different model family if available) that sees the rubric and the outputs by label only.
6. **Verify from transcripts, not self-report.** Read each candidate's transcript for this workspace only (`~/.claude/projects/<slug>/`) and see which files it really opened. Never glob across other projects.
7. **Read every output yourself** and compare it with the judge's verdict. Disagreement means a bias or an ambiguous rubric.

**Reply:** the variant under test, the rubric, per-candidate notes, the judge's verdict, your synthesis, and whether to promote the variant.
