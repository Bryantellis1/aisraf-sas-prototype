---
skill_id: SK-DFD-09-EXTRACTION-SUMMARIZE
skill_name: DFD Extraction Summarize
owning_build_package: Build Package 05
skill_family: dfd
status: active
mapped_prompt_id: PR-DFD-10
mapped_prompt_file: prompts/dfd/10-dfd-extraction-summarize.prompt.md
future_pra_owner: PRA-DFD-EXTRACTOR (planned; defined in Build Package 06)
dfd_step: DFD-09
---

# SK-DFD-09-EXTRACTION-SUMMARIZE — DFD Extraction Summarize

## 1. Identity

- skill_id: `SK-DFD-09-EXTRACTION-SUMMARIZE`
- skill_name: DFD Extraction Summarize
- owning_build_package: Build Package 05 — Skills and skill registry.
- skill_family: `dfd`
- status: `active`
- mapped_prompt_id: `PR-DFD-10`
- mapped_prompt_file: [prompts/dfd/10-dfd-extraction-summarize.prompt.md](../../prompts/dfd/10-dfd-extraction-summarize.prompt.md)
- future_pra_owner: `PRA-DFD-EXTRACTOR` (planned; defined in Build Package 06).
- dfd_step: `DFD-09`

## 2. Purpose

Summarize the DFD extraction state and residual gaps from DFD-01..DFD-08 outputs. The summary names every DFD subskill, its row count, its confidence distribution, and any residual gap that must be carried into the RS chain. The skill never produces an accuracy score and never claims completeness when DFD-01 reported `proceed_with_limits` or `do_not_proceed`.

## 3. Required Inputs

- `runs/{{run_id}}/run-profile.yaml`
- `{{output_root}}/dfd/01-intake-quality-check.md`
- `{{output_root}}/dfd/02-boundary-catalog.md`
- `{{output_root}}/dfd/03-component-catalog.md`
- `{{output_root}}/dfd/04-flow-inventory.md`
- `{{output_root}}/dfd/05-annotation-resolution.md`
- `{{output_root}}/dfd/06-boundary-crossings.md`
- `{{output_root}}/dfd/07-control-signals.md`
- `{{output_root}}/dfd/08-confidence-score.md`
- `config/run-profile.validation-rules.md`
- `config/path-resolution-rules.md`
- `config/sensitive-data-rules.md`

## 4. Optional Inputs

- (none)

## 5. Required Outputs

- `{{output_root}}/dfd/09-extraction-summary.md` — Markdown summary with the sections: `intake_state`, `subskill_row_counts`, `confidence_distribution`, `residual_gaps`, `rs_handoff_notes`, `accuracy_score_claim` (always `not_applicable` — accuracy is owned by `SK-ACCURACY-SCORE` only).

## 6. Procedure

1. Resolve run-profile variables.
2. Read DFD-01..DFD-08 outputs.
3. Record `intake_state` from DFD-01.
4. Record per-subskill row counts and confidence distributions from DFD-02..DFD-07 plus DFD-08.
5. List `residual_gaps`: rows with `confidence: LOW` or `UNKNOWN`, missing tokens, missing boundaries, missing flows.
6. Write `rs_handoff_notes` describing how the RS chain should treat the residual gaps (typically routed via `SK-MISSING-FACT-IDENTIFY` and `SK-TARGETED-QUESTION-GENERATE`).
7. Set `accuracy_score_claim: not_applicable`.
8. Write `{{output_root}}/dfd/09-extraction-summary.md`.
9. Stop before writing if any Section 7 stop condition holds.

## 7. Stop Conditions

- Any required prior DFD output missing.
- Run-profile unresolved or sensitive-data confirmation `false`.
- The summary would assert an accuracy score.
- The summary would claim completeness when DFD-01 was not `proceed`.
- Write outside `{{output_root}}` or to the old reference workspace.
- Any prohibited execution claim.

## 8. Unknown Handling

- Residual unknowns are listed under `residual_gaps`.
- Unknown rows are not hidden by aggregation.
- DFD-01 limits propagate into the summary.

## 9. Confidence Handling

- The summary is implicitly `HIGH` confident only when DFD-01 reports `proceed` and DFD-02..DFD-07 contain no `LOW`/`UNKNOWN` rows.
- `MEDIUM` when DFD-01 reports `proceed_with_limits` or some rows are `LOW`.
- `LOW` when many rows are `LOW`/`UNKNOWN` or the DFD source was partial.
- `UNKNOWN` when DFD-01 reports `do_not_proceed` (the summary should record `do_not_proceed` and stop downstream RS extraction recommendations).

## 10. Critical Misses

- Asserting an accuracy score in the summary.
- Claiming completeness when DFD-01 reported limits.
- Hiding residual gaps.
- Writing outside `{{output_root}}`.

## 11. Human Review Gate

The SAS reviewer must accept the summary and decide whether to proceed with the RS chain.

## 12. Validation / Scoring Relationship

- Expected baseline (when present): no per-summary baseline; the summary is a navigation artifact for the RS chain.
- Scoring category: this skill does not produce a numeric score. It feeds the readiness decision before RS-04..RS-17.
- Asserting accuracy is a critical miss.

## 13. Direct Skill Test

```
tools/New-AisrafRun.ps1 -RunId RUN-LOCAL-SK-DFD09-TEST -SampleId sample-001-dfd-crop -Mode folder_first_test -CopySampleInputs
tools/Test-AisrafRunProfile.ps1 -RunProfilePath runs/RUN-LOCAL-SK-DFD09-TEST/run-profile.yaml -ExecutionReady
```

- Run DFD-01..DFD-08 first, then open [prompts/dfd/10-dfd-extraction-summarize.prompt.md](../../prompts/dfd/10-dfd-extraction-summarize.prompt.md).
- Expected local output: `runs/RUN-LOCAL-SK-DFD09-TEST/dfd/09-extraction-summary.md`.
- PASS = output exists; intake_state honest; per-subskill counts present; residual gaps listed; `accuracy_score_claim: not_applicable`.

## 14. Not In Scope

- No accuracy scoring (owned by `SK-ACCURACY-SCORE`).
- No PRA, adapter, connector, runtime, diagram, or release execution.
- No claim of completeness without DFD-01 `proceed`.
