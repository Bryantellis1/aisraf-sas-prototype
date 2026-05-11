---
prompt_id: PR-DFD-07
prompt_name: DFD Boundary Crossing Detect
owning_build_package: Build Package 04
prompt_family: dfd
status: active
future_skill_id: SK-DFD-06-BOUNDARY-CROSSING-DETECT (planned; defined in Build Package 05)
future_pra_owner: PRA-DFD-EXTRACTOR (planned; defined in Build Package 06)
dfd_step: DFD-06
---

# DFD-06 — Boundary Crossing Detect

## 1. Identity

- prompt_id: `PR-DFD-07`
- prompt_name: DFD Boundary Crossing Detect
- owning_build_package: Build Package 04 — Prompts and prompt registry.
- prompt_family: `dfd`
- status: `active`
- future_skill_id: `SK-DFD-06-BOUNDARY-CROSSING-DETECT` (planned; defined in Build Package 05).
- future_pra_owner: `PRA-DFD-EXTRACTOR` (planned; defined in Build Package 06).
- dfd_step: `DFD-06`

## 2. Purpose

Detect boundary crossings — flows whose `from_component_id` and `to_component_id` sit in different boundaries — using the prior boundary catalog, component catalog, flow inventory, and annotation resolution. Write `{{output_root}}/dfd/06-boundary-crossings.md`. This prompt records visible crossings only; it does not assert that a crossing is encrypted, authenticated, logged, or rate-limited unless the prior annotations support it.

## 3. Run Profile Inputs

Resolve every value from `runs/{{run_id}}/run-profile.yaml`. The seven required v0.1.2 run-profile variables are:

- `{{run_id}}`, `{{input_root}}`, `{{expected_root}}`, `{{output_root}}`, `{{mode}}`, `{{postback_execution_status}}`, `{{output_destination_mode}}`.

Do not hardcode any value. Do not invent fields outside `config/run-profile.schema.yaml`.

## 4. Required Read Paths

Required reads:

- `runs/{{run_id}}/run-profile.yaml`
- `config/run-profile.validation-rules.md`
- `config/path-resolution-rules.md`
- `config/sensitive-data-rules.md`
- `{{output_root}}/dfd/02-boundary-catalog.md`
- `{{output_root}}/dfd/03-component-catalog.md`
- `{{output_root}}/dfd/04-flow-inventory.md`
- `{{output_root}}/dfd/05-annotation-resolution.md`

Conditional read (only when `{{expected_root}}` is non-empty and populated):

- `{{expected_root}}/expected-boundaries.json`
- `{{expected_root}}/expected-flows.json`

These are relationship references only; do not edit baselines.

Future-package references (not required; do not stop on absence):

- `skills/SK-DFD-06-BOUNDARY-CROSSING-DETECT.md` (Build Package 05).
- `prototype-agents/PRA-DFD-EXTRACTOR.md` (Build Package 06).
- `catalogs/dfd/boundary-type-catalog.yaml`, `catalogs/dfd/security-stack-marker-catalog.yaml` (Build Package 07).
- `templates/dfd-boundary-crossings-template.md` (Build Package 09).

## 5. Required Output

This prompt writes exactly one artifact:

- `{{output_root}}/dfd/06-boundary-crossings.md`

No other write path is permitted. No write outside `{{output_root}}` is permitted.

## 6. Instructions

1. Resolve every variable in Section 3 from `runs/{{run_id}}/run-profile.yaml`.
2. Read the four prior outputs in Section 4. Confirm all are non-empty.
3. For each flow row in `dfd/04-flow-inventory.md`, look up `from_component_id` and `to_component_id` in `dfd/03-component-catalog.md`, and look up each component's `containing_boundary_id` in `dfd/02-boundary-catalog.md`.
4. If the two boundaries differ, record a crossing with: `crossing_id` (e.g., `X-001`), `flow_id` (from `dfd/04-flow-inventory.md`), `from_boundary_id`, `to_boundary_id`, `crossing_kind` (one short label such as `internet_edge`, `customer_to_third_party`, `app_to_data_store`, `app_to_model_endpoint`, `app_to_tool_api`, `human_to_app`, `other`, or `unknown`), `attached_annotations` (auth, authz, transport, at-rest markers from `dfd/05-annotation-resolution.md` for that flow), and `confidence`.
5. If `containing_boundary_id` is `unknown` for either component, record the crossing as `crossing_kind: unknown` and explain.
6. Add a "limits" footnote describing flows whose containing boundaries could not be determined.
7. Write `{{output_root}}/dfd/06-boundary-crossings.md`. Do not append to `{{output_root}}/00-run-log.md` until a human reviewer accepts the crossings.

## 7. Stop Conditions

Stop before any write if any of the following holds:

- `runs/{{run_id}}/run-profile.yaml` is missing or unreadable.
- Any required run-profile variable from Section 3 is unset, empty, or unresolvable.
- `sensitive_data_confirmed_redacted` is `false`.
- Any of the four prior outputs is missing or empty.
- A row would require asserting that a crossing is encrypted, authenticated, logged, or rate-limited without supporting annotations.
- Any proposed write resolves outside `{{output_root}}`.
- A read or write would touch the old reference workspace.
- A sensitive-data substring per `config/sensitive-data-rules.md` is detected.
- The instruction would require inventing crossings or claiming a Package 05+ skill / PRA / adapter / connector / runtime / scoring / diagram / release execution.

## 8. Unknown Handling

- Where `containing_boundary_id` for either component is `unknown`, record `crossing_kind: unknown` and `confidence: low`.
- Where annotations on the flow are absent, leave the `attached_annotations` cell as `none` rather than guessing.

## 9. Evidence / Run-Log Guidance

- After human acceptance, append one entry to `{{output_root}}/00-run-log.md` recording: `prompt_id: PR-DFD-07`, `output: {{output_root}}/dfd/06-boundary-crossings.md`, accepted-by reviewer label, accepted-at timestamp (ISO 8601 UTC), and a one-line summary of crossing count and unknown-kind count.
- Do not pre-write the run-log entry before human acceptance.
- Do not claim Jira post-back, Confluence publication, Rovo execution, or MCP execution.

## 10. Direct Prompt Test

Operator test sequence:

```
# 1. Use the run that already contains dfd/02..05 outputs.
tools/Test-AisrafRunProfile.ps1 -RunProfilePath runs/RUN-LOCAL-DFD06-TEST/run-profile.yaml -ExecutionReady
```

- Open this card in VS Code Copilot Chat. Do not edit the prompt body. Substitute or confirm only the variables in Section 3.
- Expected local artifact: `runs/RUN-LOCAL-DFD06-TEST/dfd/06-boundary-crossings.md`.
- PASS = artifact exists; crossings reference `flow_id`, `from_boundary_id`, `to_boundary_id` from prior DFD outputs; unknowns marked explicitly; no control enforcement claim; no external/runtime claim; run-log entry appended only after human acceptance.

## 11. Not In Scope

- No skill execution. Skill contracts are deferred to Build Package 05.
- No PRA execution. PRA specifications are deferred to Build Package 06.
- No `.agent.md` adapter execution. Adapters are deferred to Build Package 06.
- No Jira post-back, Confluence publication, Rovo execution, or MCP execution.
- No accuracy scoring (handled only by [../rs/13-accuracy-score.prompt.md](../rs/13-accuracy-score.prompt.md)).
- No diagram generation, runbook generation, or release/export.
- No runtime, cloud, or database execution.
- No control signal, confidence, or summary work (later DFD cards own those).
