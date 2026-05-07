---
skill_id: SK-ACCURACY-SCORE
skill_name: Accuracy Score
owning_build_package: Build Package 05
skill_family: rs
status: active
mapped_prompt_id: PR-RS-13
mapped_prompt_file: prompts/rs/13-accuracy-score.prompt.md
future_pra_owner: PRA-VALIDATION-SCORER (planned; defined in Build Package 06)
review_step: RS-17
---

# SK-ACCURACY-SCORE — Accuracy Score

## 1. Identity

- skill_id: `SK-ACCURACY-SCORE`
- skill_name: Accuracy Score
- owning_build_package: Build Package 05 — Skills and skill registry.
- skill_family: `rs`
- status: `active`
- mapped_prompt_id: `PR-RS-13`
- mapped_prompt_file: [prompts/rs/13-accuracy-score.prompt.md](../../prompts/rs/13-accuracy-score.prompt.md)
- future_pra_owner: `PRA-VALIDATION-SCORER` (planned; defined in Build Package 06).
- review_step: `RS-17`

## 2. Purpose

Score the actual run outputs (RS-01..RS-16) against the expected baselines under `{{expected_root}}` using a 160-point scoring model with explicit category breakdown, critical-miss rules, and PASS/PARTIAL/FAIL verdict. The skill is the only place a numeric accuracy score is produced. It runs only when scoring is enabled and the expected baselines are populated.

## 3. Required Inputs

- `runs/{{run_id}}/run-profile.yaml`
- `{{output_root}}/01-input-inventory.md`
- `{{output_root}}/02-visible-dfd-objects.md`
- `{{output_root}}/03-legend-normalization.md`
- `{{output_root}}/04-components.md`
- `{{output_root}}/05-flows.md`
- `{{output_root}}/06-boundaries.md`
- `{{output_root}}/07-security-stack-assessment.md`
- `{{output_root}}/08-internal-review-table.md`
- `{{output_root}}/09-missing-facts.md`
- `{{output_root}}/10-ai-action-level.md`
- `{{output_root}}/11-blueprint-match.md`
- `{{output_root}}/12-targeted-questions.md`
- `{{output_root}}/13-findings.md`
- `{{output_root}}/14-recommendations.md`
- `{{output_root}}/15-handoff-pack.md`
- `{{output_root}}/16-validation-notes.md`
- `{{expected_root}}/` — baseline files (when populated).
- `config/run-profile.validation-rules.md`
- `config/path-resolution-rules.md`
- `config/sensitive-data-rules.md`

## 4. Optional Inputs

- `validation/scoring-rubric.md` (planned; defined in Build Package 12).
- `validation/no-drift-rules.md` (already present).

## 5. Required Outputs

- `{{output_root}}/17-accuracy-score.md` — Markdown score report with the fields: `total_score`, `max_score`, `pass_partial_fail`, `critical_miss_list`, `category_breakdown`, `residual_gaps`, `next_route`.

## 6. Procedure

1. Resolve run-profile variables.
2. Confirm scoring is enabled: `scoring_enabled: true`, `expected_baseline_required: true`, `{{expected_root}}` is non-empty and populated. If any condition fails, write a brief `17-accuracy-score.md` recording that scoring is not applicable for this run, with an explicit `total_score: not_applicable`.
3. Compare each RS-01..RS-16 output against the corresponding baseline file under `{{expected_root}}/`.
4. Assign per-category points using the scoring rubric (planned; defined in Build Package 12). Until the rubric is published, the scoring categories follow the per-skill `scoring_category` values declared in this Package 05 registry.
5. Record any critical misses from any prior skill.
6. Compute the verdict: PASS (>=135/160 and no critical miss), PARTIAL (110-134 or one non-critical blocker), FAIL (<110 or any critical miss).
7. Record `residual_gaps` and `next_route`.
8. Write `{{output_root}}/17-accuracy-score.md`.
9. Stop before writing if any Section 7 stop condition holds.

## 7. Stop Conditions

- Any required RS-01..RS-16 output missing.
- Run-profile unresolved or sensitive-data confirmation `false`.
- The work would edit any baseline under `{{expected_root}}`.
- Write outside `{{output_root}}` or to the old reference workspace.
- Any prohibited execution claim.

## 8. Unknown Handling

- A category may be `unknown` only when the corresponding baseline is missing or the actual output is `unknown`. The score reflects unknown categories transparently.
- Residual gaps name the unknowns by source row.

## 9. Confidence Handling

- `HIGH` — every category has a populated baseline and a populated actual output.
- `MEDIUM` — at least one category is partial.
- `LOW` — multiple categories are partial or missing baselines.
- `UNKNOWN` — scoring is not applicable (baselines absent); record `not_applicable` and stop.

## 10. Critical Misses

- Scoring before structured outputs exist.
- Ignoring a critical miss recorded by any prior skill.
- Claiming accuracy without baseline comparison when baselines exist.
- Inflating a score by hiding unknowns.
- Editing a baseline file under `{{expected_root}}`.
- Writing outside `{{output_root}}`.

## 11. Human Review Gate

The SAS reviewer accepts the verdict and records residual gaps. The package sealer decides whether QA can proceed.

## 12. Validation / Scoring Relationship

- Expected baseline (when present): `{{expected_root}}/expected-accuracy-score.json` (planned; defined in Build Package 10).
- Scoring category: all scoring categories (160 points total).
- Score inflation and ignoring a critical miss are themselves critical misses.

## 13. Direct Skill Test

```
tools/New-AisrafRun.ps1 -RunId RUN-LOCAL-SK-SCORE-TEST -SampleId sample-001-dfd-crop -Mode integration -CopySampleInputs
tools/Test-AisrafRunProfile.ps1 -RunProfilePath runs/RUN-LOCAL-SK-SCORE-TEST/run-profile.yaml -ExecutionReady
```

- Set `scoring_enabled: true` and `expected_baseline_required: true` in the run profile, populate `{{expected_root}}/`, then run RS-01..RS-12 prompt cards.
- Open [prompts/rs/13-accuracy-score.prompt.md](../../prompts/rs/13-accuracy-score.prompt.md).
- Expected local output: `runs/RUN-LOCAL-SK-SCORE-TEST/17-accuracy-score.md`.
- PASS = output exists; verdict is one of PASS/PARTIAL/FAIL/`not_applicable`; critical-miss list is honest; no baseline edited.

## 14. Not In Scope

- No PRA, adapter, connector, runtime, diagram, or release execution.
- No baseline rebaselining (rebaselining is a Build Package 10 concern).
- No claim of accuracy in any other skill or prompt.
