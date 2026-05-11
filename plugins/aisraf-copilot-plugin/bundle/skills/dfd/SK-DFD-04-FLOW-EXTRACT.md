---
skill_id: SK-DFD-04-FLOW-EXTRACT
skill_name: DFD Flow Extract
owning_build_package: Build Package 05
skill_family: dfd
status: active
mapped_prompt_id: PR-DFD-05
mapped_prompt_file: prompts/dfd/05-flow-extract.prompt.md
future_pra_owner: PRA-DFD-EXTRACTOR (planned; defined in Build Package 06)
dfd_step: DFD-04
---

# SK-DFD-04-FLOW-EXTRACT — DFD Flow Extract

## 1. Identity

- skill_id: `SK-DFD-04-FLOW-EXTRACT`
- skill_name: DFD Flow Extract
- owning_build_package: Build Package 05 — Skills and skill registry.
- skill_family: `dfd`
- status: `active`
- mapped_prompt_id: `PR-DFD-05`
- mapped_prompt_file: [prompts/dfd/05-flow-extract.prompt.md](../../prompts/dfd/05-flow-extract.prompt.md)
- future_pra_owner: `PRA-DFD-EXTRACTOR` (planned; defined in Build Package 06).
- dfd_step: `DFD-04`

## 2. Purpose

Extract the visible flow inventory from the DFD source. The skill records each visibly drawn arrow or line as a flow row with endpoints, direction, and tentative interaction type. Annotations and legend tokens are not parsed at this step; that work is owned by DFD-05.

## 3. Required Inputs

- `runs/{{run_id}}/run-profile.yaml`
- `{{output_root}}/dfd/01-intake-quality-check.md`
- `{{output_root}}/dfd/02-boundary-catalog.md`
- `{{output_root}}/dfd/03-component-catalog.md`
- `{{input_root}}/` — DFD source and supporting notes.
- `config/run-profile.validation-rules.md`
- `config/path-resolution-rules.md`
- `config/sensitive-data-rules.md`

## 4. Optional Inputs

- `{{expected_root}}/expected-flows.json` — relationship reference only.

## 5. Required Outputs

- `{{output_root}}/dfd/04-flow-inventory.md` — Markdown table with the columns: `flow_id`, `source_component`, `destination_component`, `direction`, `interaction_type_visible`, `confidence`, `notes`.

## 6. Procedure

1. Resolve run-profile variables.
2. Read DFD-01..DFD-03.
3. For each visible arrow or line connecting two components, produce one flow row.
4. Set `direction` only when arrowhead is visible.
5. Set `interaction_type_visible` (e.g., `data`, `model_call`, `tool_api_call`, `agent_to_agent`, `hitl`, `write_back`, `observability`) only when supported by visible markers; otherwise `unknown`.
6. Set `confidence` per Section 9.
7. Write `{{output_root}}/dfd/04-flow-inventory.md`.
8. Stop before writing if any Section 7 stop condition holds.

## 7. Stop Conditions

- Required prior DFD outputs missing.
- Run-profile unresolved or sensitive-data confirmation `false`.
- The work would invent a flow.
- Annotations or legend tokens are parsed at this step.
- Write outside `{{output_root}}` or to the old reference workspace.
- Any prohibited execution claim.

## 8. Unknown Handling

- Direction unknown when no arrowhead is visible.
- Interaction type unknown when no marker supports it.
- Material unknowns propagate to DFD-08 confidence scoring and ultimately to RS-09.

## 9. Confidence Handling

- `HIGH` — clear arrow, both endpoints in DFD-03, supported interaction type marker.
- `MEDIUM` — clear arrow but interaction type is `unknown`.
- `LOW` — partial line or ambiguous endpoints.
- `UNKNOWN` — visible line that cannot be reduced to a row with reliable endpoints.

## 10. Critical Misses

- Missing a model/tool/API/write-back/observability/internet/human flow that is drawn.
- Inventing a flow.
- Parsing annotations before raw flows are preserved.
- Writing outside `{{output_root}}`.

## 11. Human Review Gate

The SAS reviewer must check material flows before annotation parsing in DFD-05.

## 12. Validation / Scoring Relationship

- Expected baseline (when present): `{{expected_root}}/expected-flows.json` (planned; defined in Build Package 10).
- Scoring category: feeds RS-05 flow scoring (within `SK-ACCURACY-SCORE`).
- Missed material flow is a critical miss.

## 13. Direct Skill Test

```
tools/New-AisrafRun.ps1 -RunId RUN-LOCAL-SK-DFD04-TEST -SampleId sample-001-dfd-crop -Mode folder_first_test -CopySampleInputs
tools/Test-AisrafRunProfile.ps1 -RunProfilePath runs/RUN-LOCAL-SK-DFD04-TEST/run-profile.yaml -ExecutionReady
```

- Run DFD-01..DFD-03 first, then open [prompts/dfd/05-flow-extract.prompt.md](../../prompts/dfd/05-flow-extract.prompt.md).
- Expected local output: `runs/RUN-LOCAL-SK-DFD04-TEST/dfd/04-flow-inventory.md`.
- PASS = output exists; every flow corresponds to a drawn arrow; no annotations parsed; no invented flow.

## 14. Not In Scope

- No annotation parsing (owned by `SK-DFD-05-ANNOTATION-RESOLVE`).
- No boundary crossing detection (owned by `SK-DFD-06-BOUNDARY-CROSSING-DETECT`).
- No PRA, adapter, connector, runtime, scoring, diagram, or release execution.
