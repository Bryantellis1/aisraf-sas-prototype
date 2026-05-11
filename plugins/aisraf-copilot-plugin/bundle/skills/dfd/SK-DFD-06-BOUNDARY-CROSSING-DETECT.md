---
skill_id: SK-DFD-06-BOUNDARY-CROSSING-DETECT
skill_name: DFD Boundary Crossing Detect
owning_build_package: Build Package 05
skill_family: dfd
status: active
mapped_prompt_id: PR-DFD-07
mapped_prompt_file: prompts/dfd/07-boundary-crossing-detect.prompt.md
future_pra_owner: PRA-DFD-EXTRACTOR (planned; defined in Build Package 06)
dfd_step: DFD-06
---

# SK-DFD-06-BOUNDARY-CROSSING-DETECT — DFD Boundary Crossing Detect

## 1. Identity

- skill_id: `SK-DFD-06-BOUNDARY-CROSSING-DETECT`
- skill_name: DFD Boundary Crossing Detect
- owning_build_package: Build Package 05 — Skills and skill registry.
- skill_family: `dfd`
- status: `active`
- mapped_prompt_id: `PR-DFD-07`
- mapped_prompt_file: [prompts/dfd/07-boundary-crossing-detect.prompt.md](../../prompts/dfd/07-boundary-crossing-detect.prompt.md)
- future_pra_owner: `PRA-DFD-EXTRACTOR` (planned; defined in Build Package 06).
- dfd_step: `DFD-06`

## 2. Purpose

Detect every boundary crossing in the DFD source by joining DFD-02 boundaries, DFD-03 components, DFD-04 flows, and DFD-05 annotations. The skill produces a row per crossing flow with explicit auth and encryption visibility from the resolved annotations.

## 3. Required Inputs

- `runs/{{run_id}}/run-profile.yaml`
- `{{output_root}}/dfd/02-boundary-catalog.md`
- `{{output_root}}/dfd/03-component-catalog.md`
- `{{output_root}}/dfd/04-flow-inventory.md`
- `{{output_root}}/dfd/05-annotation-resolution.md`
- `config/run-profile.validation-rules.md`
- `config/path-resolution-rules.md`
- `config/sensitive-data-rules.md`

## 4. Optional Inputs

- `{{expected_root}}/expected-boundaries.json` — relationship reference only.

## 5. Required Outputs

- `{{output_root}}/dfd/06-boundary-crossings.md` — Markdown table with the columns: `crossing_id`, `flow_ref`, `source_boundary`, `destination_boundary`, `internet_facing`, `data_class`, `auth_visible`, `encryption_visible`, `confidence`, `notes`.

## 6. Procedure

1. Resolve run-profile variables.
2. Read DFD-02..DFD-05 outputs.
3. For each DFD-04 flow, determine whether the source and destination components are in different DFD-02 boundaries.
4. For each crossing flow, produce a row.
5. Set `internet_facing: true` only when at least one boundary is `internet_facing` or `customer_environment`.
6. Populate `auth_visible`, `encryption_visible`, and `data_class` from DFD-05 resolved annotations; otherwise `unknown`.
7. Set `confidence` per Section 9.
8. Write `{{output_root}}/dfd/06-boundary-crossings.md`.
9. Stop before writing if any Section 7 stop condition holds.

## 7. Stop Conditions

- Required prior DFD outputs missing.
- Run-profile unresolved or sensitive-data confirmation `false`.
- The work would invent a boundary or trust level.
- Write outside `{{output_root}}` or to the old reference workspace.
- Any prohibited execution claim.

## 8. Unknown Handling

- Boundary fields without DFD-02 support stay `unknown`.
- Auth and encryption visibility unknown when DFD-05 row is `unknown`.

## 9. Confidence Handling

- `HIGH` — both boundaries clearly assigned in DFD-02 and the flow is unambiguous.
- `MEDIUM` — one boundary partially assigned.
- `LOW` — at least one boundary is ambiguous.
- `UNKNOWN` — flow exists but boundaries cannot be reliably assigned.

## 10. Critical Misses

- Missing an internet-facing crossing.
- Inventing a crossing without DFD-04 support.
- Claiming controls from a boundary label alone.
- Writing outside `{{output_root}}`.

## 11. Human Review Gate

The SAS reviewer must inspect every internet-facing, third-party, model-endpoint, data-store, tool/API, and customer-environment crossing.

## 12. Validation / Scoring Relationship

- Expected baseline (when present): `{{expected_root}}/expected-boundaries.json` (planned; defined in Build Package 10).
- Scoring category: feeds RS-06 boundary scoring (within `SK-ACCURACY-SCORE`).
- Missed internet-facing crossing is a critical miss.

## 13. Direct Skill Test

```
tools/New-AisrafRun.ps1 -RunId RUN-LOCAL-SK-DFD06-TEST -SampleId sample-001-dfd-crop -Mode folder_first_test -CopySampleInputs
tools/Test-AisrafRunProfile.ps1 -RunProfilePath runs/RUN-LOCAL-SK-DFD06-TEST/run-profile.yaml -ExecutionReady
```

- Run DFD-01..DFD-05 first, then open [prompts/dfd/07-boundary-crossing-detect.prompt.md](../../prompts/dfd/07-boundary-crossing-detect.prompt.md).
- Expected local output: `runs/RUN-LOCAL-SK-DFD06-TEST/dfd/06-boundary-crossings.md`.
- PASS = output exists; every crossing has DFD-02 and DFD-04 support; no invented crossings.

## 14. Not In Scope

- No control-signal detection (owned by `SK-DFD-07-CONTROL-SIGNAL-DETECT`).
- No PRA, adapter, connector, runtime, scoring, diagram, or release execution.
- No claim of implementation proof from boundary or annotation labels.
