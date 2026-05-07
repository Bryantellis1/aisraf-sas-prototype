---
skill_id: SK-DATA-FLOW-TABLE-BUILD
skill_name: Data Flow Table Build
owning_build_package: Build Package 05
skill_family: rs
status: active
mapped_prompt_id: PR-RS-06
mapped_prompt_file: prompts/rs/06-review-table-build.prompt.md
future_pra_owner: PRA-REVIEW-TABLE-BUILDER (planned; defined in Build Package 06)
review_step: RS-08
---

# SK-DATA-FLOW-TABLE-BUILD — Data Flow Table Build

## 1. Identity

- skill_id: `SK-DATA-FLOW-TABLE-BUILD`
- skill_name: Data Flow Table Build
- owning_build_package: Build Package 05 — Skills and skill registry.
- skill_family: `rs`
- status: `active`
- mapped_prompt_id: `PR-RS-06`
- mapped_prompt_file: [prompts/rs/06-review-table-build.prompt.md](../../prompts/rs/06-review-table-build.prompt.md)
- future_pra_owner: `PRA-REVIEW-TABLE-BUILDER` (planned; defined in Build Package 06).
- review_step: `RS-08`

## 2. Purpose

Build the Internal Data Flow Review Table from RS-04..RS-07 outputs by joining components, flows, boundaries, and security-stack visibility into one row per data flow. The table separates `known_fact_summary` from `unknown_fact_summary` for downstream gap-finding work. The table is internal SAS working material; it is not a requester form and is not sent as homework.

## 3. Required Inputs

- `runs/{{run_id}}/run-profile.yaml`
- `{{output_root}}/04-components.md`
- `{{output_root}}/05-flows.md`
- `{{output_root}}/06-boundaries.md`
- `{{output_root}}/07-security-stack-assessment.md`
- `config/run-profile.validation-rules.md`
- `config/path-resolution-rules.md`
- `config/sensitive-data-rules.md`

## 4. Optional Inputs

- `{{output_root}}/01-input-inventory.md`
- `{{output_root}}/02-visible-dfd-objects.md`
- `{{output_root}}/03-legend-normalization.md`
- `{{expected_root}}/expected-review-table.json` — relationship reference only.

## 5. Required Outputs

- `{{output_root}}/08-internal-review-table.md` — Markdown table with the columns: `row_id`, `source`, `destination`, `interaction_type`, `data_class`, `boundary_crossing`, `auth_visible`, `encryption_visible`, `stack_visible`, `known_fact_summary`, `unknown_fact_summary`.

## 6. Procedure

1. Resolve run-profile variables.
2. Read RS-04..RS-07 outputs.
3. For each row in RS-05 (flows), produce one review-table row joining the matching component zones (RS-04), boundary crossings (RS-06), and security-stack visibility (RS-07).
4. Populate `known_fact_summary` with explicit, supported facts only.
5. Populate `unknown_fact_summary` with the explicit list of unknowns relevant to that row.
6. Do not collapse unknowns into the known summary to make the row look complete.
7. Write `{{output_root}}/08-internal-review-table.md`.
8. Stop before writing if any Section 7 stop condition holds.

## 7. Stop Conditions

- Any required prior output missing.
- Run-profile unresolved or sensitive-data confirmation `false`.
- The work would write outside `{{output_root}}` or to the old reference workspace.
- The work would convert the internal table into a requester homework artifact.
- Any prohibited execution claim.

## 8. Unknown Handling

- Each row's `unknown_fact_summary` lists the actual unknowns from prior outputs.
- Hidden material unknowns are a critical miss.
- Unknowns may not be "explained" with assumed defaults.

## 9. Confidence Handling

- The table inherits the per-source confidence from RS-04..RS-07. The skill itself does not introduce a new confidence value, but it must not raise the per-row confidence implied by the source outputs.

## 10. Critical Misses

- Hiding a material unknown in the known summary.
- Treating the table as a requester form (sending it out as homework).
- Writing outside `{{output_root}}`.

## 11. Human Review Gate

The SAS reviewer must confirm:

- The table is internal working material, not a requester form.
- Material unknowns are visible, not hidden.
- Each row matches a flow row in RS-05.

## 12. Validation / Scoring Relationship

- Expected baseline (when present): `{{expected_root}}/expected-review-table.json` (planned; defined in Build Package 10).
- Scoring category: missing fact identification support (within `SK-ACCURACY-SCORE`).
- The table is the primary input to `SK-MISSING-FACT-IDENTIFY`, `SK-AI-ACTION-LEVEL-CLASSIFY`, `SK-REVIEW-BLUEPRINT-MATCH`, `SK-FINDING-CLASSIFY`, `SK-RECOMMENDATION-WRITE`, and `SK-HANDOFF-PACK-BUILD`.

## 13. Direct Skill Test

```
tools/New-AisrafRun.ps1 -RunId RUN-LOCAL-SK-TABLE-TEST -SampleId sample-001-dfd-crop -Mode folder_first_test -CopySampleInputs
tools/Test-AisrafRunProfile.ps1 -RunProfilePath runs/RUN-LOCAL-SK-TABLE-TEST/run-profile.yaml -ExecutionReady
```

- Run RS-01..RS-07 first, then open [prompts/rs/06-review-table-build.prompt.md](../../prompts/rs/06-review-table-build.prompt.md).
- Expected local output: `runs/RUN-LOCAL-SK-TABLE-TEST/08-internal-review-table.md`.
- PASS = output exists; every row corresponds to a flow row in RS-05; unknowns are explicit; the table is not framed as requester homework.

## 14. Not In Scope

- No PRA, adapter, connector, runtime, scoring, diagram, or release execution.
- No catalog creation; catalog references in later steps are placeholders only.
- No conversion of the internal table into requester homework.
