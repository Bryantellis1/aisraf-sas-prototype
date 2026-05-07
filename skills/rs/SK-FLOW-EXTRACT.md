---
skill_id: SK-FLOW-EXTRACT
skill_name: Flow Extract
owning_build_package: Build Package 05
skill_family: rs
status: active
mapped_prompt_id: PR-RS-04
mapped_prompt_file: prompts/rs/04-design-fact-extract.prompt.md
future_pra_owner: PRA-DESIGN-FACT-EXTRACTOR (planned; defined in Build Package 06)
review_step: RS-05
---

# SK-FLOW-EXTRACT — Flow Extract

## 1. Identity

- skill_id: `SK-FLOW-EXTRACT`
- skill_name: Flow Extract
- owning_build_package: Build Package 05 — Skills and skill registry.
- skill_family: `rs`
- status: `active`
- mapped_prompt_id: `PR-RS-04`
- mapped_prompt_file: [prompts/rs/04-design-fact-extract.prompt.md](../../prompts/rs/04-design-fact-extract.prompt.md) (shared with `SK-COMPONENT-EXTRACT`)
- future_pra_owner: `PRA-DESIGN-FACT-EXTRACTOR` (planned; defined in Build Package 06).
- review_step: `RS-05`

## 2. Purpose

Extract every supported data flow and interaction (data transfer, model call, tool/API call, agent-to-agent call, HITL hand-off, write-back, observability) from the visible DFD objects and review notes. The skill records source, destination, direction, interaction type, and data class only when supported. Material flows that are missed (model, tool, API, write-back, observability, internet-facing, human) are critical misses.

## 3. Required Inputs

- `runs/{{run_id}}/run-profile.yaml`
- `{{output_root}}/02-visible-dfd-objects.md`
- `{{output_root}}/04-components.md` — produced by the same shared prompt; this skill expects the component table to exist (the prompt writes both files together).
- `config/run-profile.validation-rules.md`
- `config/path-resolution-rules.md`
- `config/sensitive-data-rules.md`

## 4. Optional Inputs

- `{{output_root}}/03-legend-normalization.md`
- `{{output_root}}/dfd/04-flow-inventory.md` — DFD subskill DFD-04 output, when present.
- `{{input_root}}/cloud-triage-notes.md`, `{{input_root}}/review-transcript.md`
- `{{expected_root}}/expected-flows.json` — relationship reference only.

## 5. Required Outputs

- `{{output_root}}/05-flows.md` — Markdown table with the columns: `flow_id`, `source`, `destination`, `direction`, `interaction_type`, `data_class`, `confidence`, `notes`.

The shared prompt also writes `{{output_root}}/04-components.md` (owned by `SK-COMPONENT-EXTRACT`). This skill is responsible only for the flow artifact.

## 6. Procedure

1. Resolve run-profile variables.
2. Read RS-02 and RS-04 outputs (visible objects + components).
3. For each visibly drawn arrow or line connecting components, produce a flow row.
4. Set `direction` only when the arrowhead is visible; otherwise `unknown`.
5. Set `interaction_type` (data, model_call, tool_api_call, agent_to_agent, hitl, write_back, observability) only when supported by visible markers, normalized legend, or corroborating notes.
6. Set `data_class` from RS-03 normalized rows when applicable; otherwise `unknown`.
7. Set `confidence` per Section 9.
8. Write `{{output_root}}/05-flows.md`.
9. Stop before writing if any Section 7 stop condition holds.

## 7. Stop Conditions

- Required prior outputs missing.
- Run-profile unresolved or sensitive-data confirmation `false`.
- The work would invent a flow not drawn in the source.
- Annotations are parsed before raw flows are preserved.
- Write outside `{{output_root}}` or to the old reference workspace.
- Any prohibited execution claim.

## 8. Unknown Handling

- Direction unknown when no arrowhead is visible.
- Interaction type unknown when no marker supports it.
- Data class unknown when not legend-supported.
- Material unknowns (model/tool/API/write-back/observability) carry forward to RS-09.

## 9. Confidence Handling

- `HIGH` — clear arrow, both endpoints in component table, supported interaction type and data class.
- `MEDIUM` — clear arrow but one of {interaction_type, data_class} is `unknown`.
- `LOW` — partial line, ambiguous endpoints, or no supporting marker.
- `UNKNOWN` — visible line that cannot be reduced to a row with reliable endpoints.

## 10. Critical Misses

- Missing a model/tool/API/write-back/observability/internet/human flow that is visibly drawn.
- Inventing a flow that is not drawn.
- Parsing legend annotations before preserving raw flow rows.
- Writing outside `{{output_root}}`.

## 11. Human Review Gate

The SAS reviewer must check material flows, especially model, tool/API, data store, agent-to-agent, observability, and customer-environment flows.

## 12. Validation / Scoring Relationship

- Expected baseline (when present): `{{expected_root}}/expected-flows.json` (planned; defined in Build Package 10).
- Scoring category: flow extraction (15 points within `SK-ACCURACY-SCORE`).
- Missed material flow is a critical miss.

## 13. Direct Skill Test

```
tools/New-AisrafRun.ps1 -RunId RUN-LOCAL-SK-FLOW-TEST -SampleId sample-001-dfd-crop -Mode folder_first_test -CopySampleInputs
tools/Test-AisrafRunProfile.ps1 -RunProfilePath runs/RUN-LOCAL-SK-FLOW-TEST/run-profile.yaml -ExecutionReady
```

- Run RS-01, RS-02, RS-03, then open [prompts/rs/04-design-fact-extract.prompt.md](../../prompts/rs/04-design-fact-extract.prompt.md).
- Expected local output: `runs/RUN-LOCAL-SK-FLOW-TEST/05-flows.md`.
- PASS = output exists; every flow corresponds to a drawn arrow or supported note; no critical miss.

## 14. Not In Scope

- No component extraction (owned by `SK-COMPONENT-EXTRACT`).
- No boundary derivation or security stack assertion.
- No PRA, adapter, connector, runtime, scoring, diagram, or release execution.
- Catalogs and templates are placeholders only `(planned; defined in Build Package 07/09)`.
