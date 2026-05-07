---
skill_id: SK-MISSING-FACT-IDENTIFY
skill_name: Missing Fact Identify
owning_build_package: Build Package 05
skill_family: rs
status: active
mapped_prompt_id: PR-RS-07
mapped_prompt_file: prompts/rs/07-missing-fact-question-generate.prompt.md
future_pra_owner: PRA-MISSING-FACT-INTERVIEWER (planned; defined in Build Package 06)
review_step: RS-09
---

# SK-MISSING-FACT-IDENTIFY — Missing Fact Identify

## 1. Identity

- skill_id: `SK-MISSING-FACT-IDENTIFY`
- skill_name: Missing Fact Identify
- owning_build_package: Build Package 05 — Skills and skill registry.
- skill_family: `rs`
- status: `active`
- mapped_prompt_id: `PR-RS-07`
- mapped_prompt_file: [prompts/rs/07-missing-fact-question-generate.prompt.md](../../prompts/rs/07-missing-fact-question-generate.prompt.md) (shared with `SK-TARGETED-QUESTION-GENERATE`)
- future_pra_owner: `PRA-MISSING-FACT-INTERVIEWER` (planned; defined in Build Package 06).
- review_step: `RS-09`

## 2. Purpose

Identify only the missing or unclear facts that are material enough to affect a finding, recommendation, owner, route, validation note, AI Action Level, blueprint match, or accuracy score. Broad checklist-style gaps are not material and are a critical miss when included.

## 3. Required Inputs

- `runs/{{run_id}}/run-profile.yaml`
- `{{output_root}}/01-input-inventory.md`
- `{{output_root}}/04-components.md`
- `{{output_root}}/05-flows.md`
- `{{output_root}}/06-boundaries.md`
- `{{output_root}}/07-security-stack-assessment.md`
- `{{output_root}}/08-internal-review-table.md`
- `config/run-profile.validation-rules.md`
- `config/path-resolution-rules.md`
- `config/sensitive-data-rules.md`

## 4. Optional Inputs

- `{{output_root}}/03-legend-normalization.md`
- `{{output_root}}/dfd/05-annotation-resolution.md` — DFD-05, when present.
- `{{expected_root}}/expected-missing-facts.json` — relationship reference only.

## 5. Required Outputs

- `{{output_root}}/09-missing-facts.md` — Markdown list/table with the columns: `gap_id`, `missing_fact`, `why_material`, `affects_output`.

The shared prompt also writes `{{output_root}}/12-targeted-questions.md` (owned by `SK-TARGETED-QUESTION-GENERATE`).

## 6. Procedure

1. Resolve run-profile variables.
2. Read RS-08 plus any RS-04..RS-07 unknowns.
3. For each unknown, ask: does the unknown change a finding, recommendation, owner, route, validation note, AI Action Level, blueprint match, or score?
4. Keep only the unknowns where the answer is yes.
5. For each kept unknown, populate `missing_fact`, `why_material`, and `affects_output` (named output file).
6. Drop broad checklist-style gaps (e.g., "do they use OAuth somewhere") that do not change a named output row.
7. Write `{{output_root}}/09-missing-facts.md`.
8. Stop before writing if any Section 7 stop condition holds.

## 7. Stop Conditions

- RS-08 output missing.
- Run-profile unresolved or sensitive-data confirmation `false`.
- The output would contain broad checklist gaps.
- Write outside `{{output_root}}` or to the old reference workspace.
- Any prohibited execution claim.

## 8. Unknown Handling

- Material unknowns are listed.
- Immaterial unknowns are not listed.
- Unknowns whose materiality cannot be judged are listed only with `why_material: unknown` and a note explaining the ambiguity.

## 9. Confidence Handling

- Each gap row is implicitly `HIGH` when the unknown is named in a prior output and the affected downstream output is named.
- `MEDIUM` when the unknown is named but the downstream effect is partial.
- `LOW` when the unknown is plausible but the downstream effect is speculative; the operator should consider dropping the row.
- `UNKNOWN` materiality requires either a corroborating note or the row is dropped.

## 10. Critical Misses

- Broad checklist questions (e.g., generic "is there logging?").
- Hiding a material unknown.
- Closing a proof gap with a DFD marker that is itself a review signal.
- Writing outside `{{output_root}}`.

## 11. Human Review Gate

The SAS reviewer must trim broad checklist questions and keep only material gaps that change a finding, recommendation, owner, route, validation note, AI Action Level, blueprint match, or score.

## 12. Validation / Scoring Relationship

- Expected baseline (when present): `{{expected_root}}/expected-missing-facts.json` (planned; defined in Build Package 10).
- Scoring category: missing fact identification (10 points within `SK-ACCURACY-SCORE`).
- Hidden material unknown is a critical miss.

## 13. Direct Skill Test

```
tools/New-AisrafRun.ps1 -RunId RUN-LOCAL-SK-MISSING-TEST -SampleId sample-001-dfd-crop -Mode folder_first_test -CopySampleInputs
tools/Test-AisrafRunProfile.ps1 -RunProfilePath runs/RUN-LOCAL-SK-MISSING-TEST/run-profile.yaml -ExecutionReady
```

- Run RS-01..RS-08 first, then open [prompts/rs/07-missing-fact-question-generate.prompt.md](../../prompts/rs/07-missing-fact-question-generate.prompt.md).
- Expected local output: `runs/RUN-LOCAL-SK-MISSING-TEST/09-missing-facts.md`.
- PASS = output exists; every row is material; no broad checklist gap; downstream output named.

## 14. Not In Scope

- No targeted question generation (owned by `SK-TARGETED-QUESTION-GENERATE`).
- No PRA, adapter, connector, runtime, scoring, diagram, or release execution.
- No requester homework artifact creation.
