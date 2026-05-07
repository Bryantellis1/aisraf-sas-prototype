---
skill_id: SK-DFD-02-BOUNDARY-EXTRACT
skill_name: DFD Boundary Extract
owning_build_package: Build Package 05
skill_family: dfd
status: active
mapped_prompt_id: PR-DFD-03
mapped_prompt_file: prompts/dfd/03-boundary-extract.prompt.md
future_pra_owner: PRA-DFD-EXTRACTOR (planned; defined in Build Package 06)
dfd_step: DFD-02
---

# SK-DFD-02-BOUNDARY-EXTRACT — DFD Boundary Extract

## 1. Identity

- skill_id: `SK-DFD-02-BOUNDARY-EXTRACT`
- skill_name: DFD Boundary Extract
- owning_build_package: Build Package 05 — Skills and skill registry.
- skill_family: `dfd`
- status: `active`
- mapped_prompt_id: `PR-DFD-03`
- mapped_prompt_file: [prompts/dfd/03-boundary-extract.prompt.md](../../prompts/dfd/03-boundary-extract.prompt.md)
- future_pra_owner: `PRA-DFD-EXTRACTOR` (planned; defined in Build Package 06).
- dfd_step: `DFD-02`

## 2. Purpose

Extract the visible boundary catalog from the DFD source: trust boundaries, environment boundaries, customer/internet boundaries, internal/external boundaries, model/tool/data-store boundaries, and human-actor boundaries. The skill never invents a boundary or trust level. Visible boundary names are review signals only, not implementation proof.

## 3. Required Inputs

- `runs/{{run_id}}/run-profile.yaml`
- `{{output_root}}/dfd/01-intake-quality-check.md`
- `{{input_root}}/` — DFD source artifact and supporting notes.
- `config/run-profile.validation-rules.md`
- `config/path-resolution-rules.md`
- `config/sensitive-data-rules.md`

## 4. Optional Inputs

- `{{output_root}}/01-input-inventory.md`
- `{{expected_root}}/expected-boundaries.json` — relationship reference only.

## 5. Required Outputs

- `{{output_root}}/dfd/02-boundary-catalog.md` — Markdown table with the columns: `boundary_id`, `boundary_type`, `label_text`, `visibility_source`, `confidence`, `notes`.

## 6. Procedure

1. Resolve run-profile variables.
2. Verify `intake_decision` from DFD-01 is `proceed` or `proceed_with_limits`.
3. Identify every visible boundary in the DFD source.
4. Classify `boundary_type` as `internet_facing`, `customer_environment`, `internal_trust`, `model_endpoint`, `tool_api_surface`, `data_store_zone`, `human_actor_zone`, or `unknown`.
5. Set `confidence` per Section 9.
6. Write `{{output_root}}/dfd/02-boundary-catalog.md`.
7. Stop before writing if any Section 7 stop condition holds.

## 7. Stop Conditions

- DFD-01 missing or `intake_decision: do_not_proceed`.
- Run-profile unresolved or sensitive-data confirmation `false`.
- The work would invent a boundary or trust level.
- Write outside `{{output_root}}` or to the old reference workspace.
- Any prohibited execution claim.

## 8. Unknown Handling

- Unsupported boundary type stays `unknown`.
- Trust level, owner, exposure, and policy facts that are not visible stay `unknown`.

## 9. Confidence Handling

- `HIGH` — boundary clearly drawn with a clear label.
- `MEDIUM` — boundary drawn but label is ambiguous.
- `LOW` — boundary partially visible.
- `UNKNOWN` — boundary visible but type cannot be supported.

## 10. Critical Misses

- Missing an internet/customer-facing boundary.
- Missing a model/tool/data-store/human boundary that is visibly drawn.
- Claiming control properties from a boundary label alone.
- Writing outside `{{output_root}}`.

## 11. Human Review Gate

The SAS reviewer must inspect high-risk and internet-facing boundaries.

## 12. Validation / Scoring Relationship

- Expected baseline (when present): `{{expected_root}}/expected-boundaries.json` (planned; defined in Build Package 10).
- Scoring category: feeds RS-06 boundary scoring (within `SK-ACCURACY-SCORE`).
- Missed internet boundary is a critical miss.

## 13. Direct Skill Test

```
tools/New-AisrafRun.ps1 -RunId RUN-LOCAL-SK-DFD02-TEST -SampleId sample-001-dfd-crop -Mode folder_first_test -CopySampleInputs
tools/Test-AisrafRunProfile.ps1 -RunProfilePath runs/RUN-LOCAL-SK-DFD02-TEST/run-profile.yaml -ExecutionReady
```

- Run DFD-01 first, then open [prompts/dfd/03-boundary-extract.prompt.md](../../prompts/dfd/03-boundary-extract.prompt.md).
- Expected local output: `runs/RUN-LOCAL-SK-DFD02-TEST/dfd/02-boundary-catalog.md`.
- PASS = output exists; every boundary corresponds to a visible boundary in the source; no invented boundaries.

## 14. Not In Scope

- No component, flow, annotation, control, confidence, or summary work (later DFD cards own those).
- No PRA, adapter, connector, runtime, scoring, diagram, or release execution.
- No claim of implementation proof from boundary labels.
