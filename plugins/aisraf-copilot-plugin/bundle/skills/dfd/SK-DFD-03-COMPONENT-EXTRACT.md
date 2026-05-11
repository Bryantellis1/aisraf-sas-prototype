---
skill_id: SK-DFD-03-COMPONENT-EXTRACT
skill_name: DFD Component Extract
owning_build_package: Build Package 05
skill_family: dfd
status: active
mapped_prompt_id: PR-DFD-04
mapped_prompt_file: prompts/dfd/04-component-extract.prompt.md
future_pra_owner: PRA-DFD-EXTRACTOR (planned; defined in Build Package 06)
dfd_step: DFD-03
---

# SK-DFD-03-COMPONENT-EXTRACT — DFD Component Extract

## 1. Identity

- skill_id: `SK-DFD-03-COMPONENT-EXTRACT`
- skill_name: DFD Component Extract
- owning_build_package: Build Package 05 — Skills and skill registry.
- skill_family: `dfd`
- status: `active`
- mapped_prompt_id: `PR-DFD-04`
- mapped_prompt_file: [prompts/dfd/04-component-extract.prompt.md](../../prompts/dfd/04-component-extract.prompt.md)
- future_pra_owner: `PRA-DFD-EXTRACTOR` (planned; defined in Build Package 06).
- dfd_step: `DFD-03`

## 2. Purpose

Extract the visible component catalog from the DFD source: services, models, tools, stores, agents, observability surfaces, and human actors. The skill never invents a component and never assigns runtime properties from a label.

## 3. Required Inputs

- `runs/{{run_id}}/run-profile.yaml`
- `{{output_root}}/dfd/01-intake-quality-check.md`
- `{{output_root}}/dfd/02-boundary-catalog.md`
- `{{input_root}}/` — DFD source and supporting notes.
- `config/run-profile.validation-rules.md`
- `config/path-resolution-rules.md`
- `config/sensitive-data-rules.md`

## 4. Optional Inputs

- `{{expected_root}}/expected-components.json` — relationship reference only.

## 5. Required Outputs

- `{{output_root}}/dfd/03-component-catalog.md` — Markdown table with the columns: `component_id`, `component_name`, `component_type`, `boundary_ref`, `visibility_source`, `confidence`, `notes`.

## 6. Procedure

1. Resolve run-profile variables.
2. Read DFD-01 and DFD-02.
3. For each visible node, produce one component row.
4. Set `component_type` as `service`, `model`, `tool`, `store`, `agent`, `observability`, `human_actor`, or `unknown`.
5. Link the component to a boundary in DFD-02 via `boundary_ref` when supported; otherwise `unknown`.
6. Set `confidence` per Section 9.
7. Write `{{output_root}}/dfd/03-component-catalog.md`.
8. Stop before writing if any Section 7 stop condition holds.

## 7. Stop Conditions

- DFD-01 or DFD-02 missing.
- Run-profile unresolved or sensitive-data confirmation `false`.
- The work would invent a component.
- Write outside `{{output_root}}` or to the old reference workspace.
- Any prohibited execution claim.

## 8. Unknown Handling

- Unsupported component type stays `unknown`.
- Boundary linkage unknown stays `unknown`.

## 9. Confidence Handling

- `HIGH` — visibly drawn, fully labeled, with a corroborating note.
- `MEDIUM` — visibly drawn with one supported attribute.
- `LOW` — visibly drawn but type and boundary are both ambiguous.
- `UNKNOWN` — node is visible but neither type nor boundary can be supported.

## 10. Critical Misses

- Inventing a component.
- Missing an external actor, model, tool, store, observability, or human actor visibly drawn.
- Claiming runtime from a component label.
- Writing outside `{{output_root}}`.

## 11. Human Review Gate

The SAS reviewer must inspect uncertain and high-risk component mappings.

## 12. Validation / Scoring Relationship

- Expected baseline (when present): `{{expected_root}}/expected-components.json` (planned; defined in Build Package 10).
- Scoring category: feeds RS-04 component scoring (within `SK-ACCURACY-SCORE`).
- Invented component is a critical miss.

## 13. Direct Skill Test

```
tools/New-AisrafRun.ps1 -RunId RUN-LOCAL-SK-DFD03-TEST -SampleId sample-001-dfd-crop -Mode folder_first_test -CopySampleInputs
tools/Test-AisrafRunProfile.ps1 -RunProfilePath runs/RUN-LOCAL-SK-DFD03-TEST/run-profile.yaml -ExecutionReady
```

- Run DFD-01 and DFD-02 first, then open [prompts/dfd/04-component-extract.prompt.md](../../prompts/dfd/04-component-extract.prompt.md).
- Expected local output: `runs/RUN-LOCAL-SK-DFD03-TEST/dfd/03-component-catalog.md`.
- PASS = output exists; every component corresponds to a visible node; no invented components.

## 14. Not In Scope

- No flow, annotation, control, confidence, or summary work (later DFD cards own those).
- No PRA, adapter, connector, runtime, scoring, diagram, or release execution.
- No claim of runtime or approved-stack properties.
