---
skill_id: SK-DFD-01-INTAKE-QUALITY-CHECK
skill_name: DFD Intake Quality Check
owning_build_package: Build Package 05
skill_family: dfd
status: active
mapped_prompt_id: PR-DFD-02
mapped_prompt_file: prompts/dfd/02-dfd-intake-quality-check.prompt.md
future_pra_owner: PRA-DFD-EXTRACTOR (planned; defined in Build Package 06)
dfd_step: DFD-01
---

# SK-DFD-01-INTAKE-QUALITY-CHECK — DFD Intake Quality Check

## 1. Identity

- skill_id: `SK-DFD-01-INTAKE-QUALITY-CHECK`
- skill_name: DFD Intake Quality Check
- owning_build_package: Build Package 05 — Skills and skill registry.
- skill_family: `dfd`
- status: `active`
- mapped_prompt_id: `PR-DFD-02`
- mapped_prompt_file: [prompts/dfd/02-dfd-intake-quality-check.prompt.md](../../prompts/dfd/02-dfd-intake-quality-check.prompt.md)
- future_pra_owner: `PRA-DFD-EXTRACTOR` (planned; defined in Build Package 06).
- dfd_step: `DFD-01`

## 2. Purpose

Check whether the staged DFD inputs are readable enough to extract boundaries, components, flows, and controls in later DFD subskills. The skill records source availability, readability, sensitive-material rejection, and the operator's go/no-go decision. It does not extract DFD facts and does not import meanings from a non-visible catalog.

## 3. Required Inputs

- `runs/{{run_id}}/run-profile.yaml`
- `{{input_root}}/` — DFD source artifact and supporting notes.
- `config/run-profile.validation-rules.md`
- `config/path-resolution-rules.md`
- `config/sensitive-data-rules.md`

## 4. Optional Inputs

- `{{output_root}}/01-input-inventory.md` — RS-01 output, used for cross-reference if present.

## 5. Required Outputs

- `{{output_root}}/dfd/01-intake-quality-check.md` — Markdown record with the columns: `artifact`, `classification`, `readability`, `sensitive_material_present`, `notes_count`, `decision`; plus `intake_decision` and a `limits` section.

## 6. Procedure

1. Resolve run-profile variables.
2. Confirm `{{output_root}}/dfd/` exists.
3. Classify each DFD-related artifact in `{{input_root}}/`.
4. Record `readability` (`high`, `medium`, `low`, `unreadable`), `sensitive_material_present` (`true`, `false`, `unknown`), `notes_count`, and per-artifact `decision`.
5. Write a `limits` section.
6. Set `intake_decision: proceed | proceed_with_limits | do_not_proceed`.
7. Write `{{output_root}}/dfd/01-intake-quality-check.md`.
8. Stop before writing if any Section 7 stop condition holds.

## 7. Stop Conditions

- Run-profile unresolved or sensitive-data confirmation `false`.
- `{{input_root}}` missing, empty, or no DFD source artifact.
- Real sensitive payload detected — record `do_not_proceed` and stop.
- Write outside `{{output_root}}` or to the old reference workspace.
- Any prohibited execution claim.

## 8. Unknown Handling

- Unreadable artifacts are recorded as `unreadable`.
- Partial visibility is `low` or `medium` readability.
- Sensitive-material judgment unknown is recorded as `unknown` with explanation.

## 9. Confidence Handling

- `HIGH` — DFD source is fully readable and supporting notes present.
- `MEDIUM` — DFD source readable but some support notes are missing.
- `LOW` — DFD source partially readable.
- `UNKNOWN` — operator cannot judge readability.

## 10. Critical Misses

- Proceeding after an unreadable DFD source.
- Ignoring real sensitive material.
- Treating input availability as implementation proof.
- Writing outside `{{output_root}}`.

## 11. Human Review Gate

The SAS reviewer accepts DFD quality limits before later DFD subskills proceed.

## 12. Validation / Scoring Relationship

- Expected baseline (when present): `{{expected_root}}/expected-visible-dfd-objects.json` (planned; defined in Build Package 10) and the DFD intake baseline.
- Scoring relationship: blocks DFD-02..DFD-09 progression if intake fails; supports `SK-ACCURACY-SCORE` indirectly through readiness.
- Critical-miss conditions force a FAIL on `SK-ACCURACY-SCORE`.

## 13. Direct Skill Test

```
tools/New-AisrafRun.ps1 -RunId RUN-LOCAL-SK-DFD01-TEST -SampleId sample-001-dfd-crop -Mode folder_first_test -CopySampleInputs
tools/Test-AisrafRunProfile.ps1 -RunProfilePath runs/RUN-LOCAL-SK-DFD01-TEST/run-profile.yaml -ExecutionReady
```

- Open [prompts/dfd/02-dfd-intake-quality-check.prompt.md](../../prompts/dfd/02-dfd-intake-quality-check.prompt.md).
- Expected local output: `runs/RUN-LOCAL-SK-DFD01-TEST/dfd/01-intake-quality-check.md`.
- PASS = output exists; readability and sensitive-material judgments are explicit; `intake_decision` is one of the allowed values; no DFD facts extracted.

## 14. Not In Scope

- No boundary, component, flow, annotation, control, confidence, or summary work (later DFD cards own those).
- No PRA, adapter, connector, runtime, scoring, diagram, or release execution.
