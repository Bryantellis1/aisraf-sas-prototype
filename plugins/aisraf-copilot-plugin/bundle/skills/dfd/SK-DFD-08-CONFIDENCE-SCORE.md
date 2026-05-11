---
skill_id: SK-DFD-08-CONFIDENCE-SCORE
skill_name: DFD Confidence Score
owning_build_package: Build Package 05
skill_family: dfd
status: active
mapped_prompt_id: PR-DFD-09
mapped_prompt_file: prompts/dfd/09-confidence-score.prompt.md
future_pra_owner: PRA-DFD-EXTRACTOR (planned; defined in Build Package 06)
dfd_step: DFD-08
---

# SK-DFD-08-CONFIDENCE-SCORE — DFD Confidence Score

## 1. Identity

- skill_id: `SK-DFD-08-CONFIDENCE-SCORE`
- skill_name: DFD Confidence Score
- owning_build_package: Build Package 05 — Skills and skill registry.
- skill_family: `dfd`
- status: `active`
- mapped_prompt_id: `PR-DFD-09`
- mapped_prompt_file: [prompts/dfd/09-confidence-score.prompt.md](../../prompts/dfd/09-confidence-score.prompt.md)
- future_pra_owner: `PRA-DFD-EXTRACTOR` (planned; defined in Build Package 06).
- dfd_step: `DFD-08`

## 2. Purpose

Assign per-row extraction confidence (HIGH / MEDIUM / LOW / UNKNOWN) to each visible-fact row in DFD-02..DFD-07. The skill is not an accuracy score; it is an extraction-confidence record that downstream RS skills and the eventual `SK-ACCURACY-SCORE` use as input.

## 3. Required Inputs

- `runs/{{run_id}}/run-profile.yaml`
- `{{output_root}}/dfd/02-boundary-catalog.md`
- `{{output_root}}/dfd/03-component-catalog.md`
- `{{output_root}}/dfd/04-flow-inventory.md`
- `{{output_root}}/dfd/05-annotation-resolution.md`
- `{{output_root}}/dfd/06-boundary-crossings.md`
- `{{output_root}}/dfd/07-control-signals.md`
- `config/run-profile.validation-rules.md`
- `config/path-resolution-rules.md`
- `config/sensitive-data-rules.md`

## 4. Optional Inputs

- (none)

## 5. Required Outputs

- `{{output_root}}/dfd/08-confidence-score.md` — Markdown table with the columns: `row_ref` (DFD-02..DFD-07 row reference), `target_kind` (boundary | component | flow | annotation | crossing | control_signal), `confidence`, `evidence_summary`, `notes`.

## 6. Procedure

1. Resolve run-profile variables.
2. Read DFD-02..DFD-07 outputs.
3. For each row in each DFD subskill output, record one confidence row.
4. Set `confidence` (HIGH / MEDIUM / LOW / UNKNOWN) using the per-skill confidence-handling rules already declared in DFD-02..DFD-07.
5. Set `evidence_summary` to a short rationale tied to the row's `visibility_source` and supporting notes.
6. Write `{{output_root}}/dfd/08-confidence-score.md`.
7. Stop before writing if any Section 7 stop condition holds.

## 7. Stop Conditions

- Any required prior DFD output missing.
- Run-profile unresolved or sensitive-data confirmation `false`.
- The output would claim accuracy or a numeric score.
- Write outside `{{output_root}}` or to the old reference workspace.
- Any prohibited execution claim.

## 8. Unknown Handling

- Rows where prior DFD subskills already recorded `confidence: UNKNOWN` carry forward as UNKNOWN.
- Unknowns are visible, not hidden.

## 9. Confidence Handling

The skill is the canonical confidence-score recorder for DFD subskill outputs. The four levels are:

- `HIGH` — multiple independent visible signals support the row.
- `MEDIUM` — one strong signal supports the row, with at least one ambiguous attribute.
- `LOW` — one weak signal supports the row.
- `UNKNOWN` — no clear visible support.

## 10. Critical Misses

- Claiming an accuracy score (accuracy is owned exclusively by `SK-ACCURACY-SCORE`).
- Promoting an UNKNOWN row to HIGH without supporting evidence.
- Hiding LOW or UNKNOWN rows to make a downstream output look more confident.
- Writing outside `{{output_root}}`.

## 11. Human Review Gate

The SAS reviewer must accept the confidence distribution before DFD-09 summarizes the extraction.

## 12. Validation / Scoring Relationship

- Expected baseline (when present): no separate baseline; baselines for individual rows live with each DFD subskill.
- Scoring category: this skill does not produce a numeric score. Its outputs feed `SK-ACCURACY-SCORE` indirectly.
- Hiding LOW/UNKNOWN rows is a critical miss.

## 13. Direct Skill Test

```
tools/New-AisrafRun.ps1 -RunId RUN-LOCAL-SK-DFD08-TEST -SampleId sample-001-dfd-crop -Mode folder_first_test -CopySampleInputs
tools/Test-AisrafRunProfile.ps1 -RunProfilePath runs/RUN-LOCAL-SK-DFD08-TEST/run-profile.yaml -ExecutionReady
```

- Run DFD-01..DFD-07 first, then open [prompts/dfd/09-confidence-score.prompt.md](../../prompts/dfd/09-confidence-score.prompt.md).
- Expected local output: `runs/RUN-LOCAL-SK-DFD08-TEST/dfd/08-confidence-score.md`.
- PASS = output exists; confidence distribution honest; LOW and UNKNOWN rows visible.

## 14. Not In Scope

- No accuracy scoring (owned by `SK-ACCURACY-SCORE`).
- No PRA, adapter, connector, runtime, diagram, or release execution.
- No promotion of UNKNOWN to HIGH.
