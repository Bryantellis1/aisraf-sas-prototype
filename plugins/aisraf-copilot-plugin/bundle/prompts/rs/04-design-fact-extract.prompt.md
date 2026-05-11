---
prompt_id: PR-RS-04
prompt_name: Design Fact Extract
owning_build_package: Build Package 04
prompt_family: rs
status: active
future_skill_id: SK-COMPONENT-EXTRACT and SK-FLOW-EXTRACT (planned; defined in Build Package 05)
future_pra_owner: PRA-DESIGN-FACT-EXTRACTOR (planned; defined in Build Package 06)
review_step: RS-04
---

# RS-04 — Design Fact Extract

## 1. Identity

- prompt_id: `PR-RS-04`
- prompt_name: Design Fact Extract
- owning_build_package: Build Package 04 — Prompts and prompt registry.
- prompt_family: `rs`
- status: `active`
- future_skill_id: `SK-COMPONENT-EXTRACT` and `SK-FLOW-EXTRACT` (planned; defined in Build Package 05).
- future_pra_owner: `PRA-DESIGN-FACT-EXTRACTOR` (planned; defined in Build Package 06).
- review_step: `RS-04`

## 2. Purpose

Extract supported components and supported flows from the visible DFD objects and normalized legend, and write two Markdown artifacts: `{{output_root}}/04-components.md` and `{{output_root}}/05-flows.md`. A "supported" fact is one that the operator can read from the source or confirm against the normalized legend. This prompt does not extract boundaries, security-stack signals, controls, AI Action Level, blueprint matches, findings, or recommendations, and does not promote a label into a runtime/control claim.

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
- `{{output_root}}/02-visible-dfd-objects.md`
- `{{output_root}}/03-legend-normalization.md`
- `{{input_root}}/` — supporting notes that describe components and flows (cloud triage notes, review transcript, intake ticket).

Conditional read (only when `{{expected_root}}` is non-empty and populated):

- `{{expected_root}}/expected-components.json`
- `{{expected_root}}/expected-flows.json`

These are relationship references only; do not edit baselines.

Future-package references (not required; do not stop on absence):

- `skills/SK-COMPONENT-EXTRACT.md` and `skills/SK-FLOW-EXTRACT.md` (Build Package 05).
- `prototype-agents/PRA-DESIGN-FACT-EXTRACTOR.md` (Build Package 06).
- `catalogs/dfd/component-type-catalog.yaml` and `catalogs/dfd/cloud-service-component-map.yaml` (Build Package 07).
- `templates/components-template.md` and `templates/flows-template.md` (Build Package 09).

## 5. Required Output

This prompt writes exactly two artifacts:

- `{{output_root}}/04-components.md`
- `{{output_root}}/05-flows.md`

No other write path is permitted. No write outside `{{output_root}}` is permitted.

## 6. Instructions

1. Resolve every variable in Section 3 from `runs/{{run_id}}/run-profile.yaml`.
2. Read `{{output_root}}/02-visible-dfd-objects.md` and `{{output_root}}/03-legend-normalization.md`. Confirm both exist and are non-empty.
3. For `04-components.md`, list each supported component with: `component_id` (operator-assigned, e.g., `C-001`), `name_visible_on_source`, `kind` (web app, API, database, queue, cache, model endpoint, tool/API, identity provider, human, other, or `unknown`), `purpose_supported_by_source` (one sentence citing visible-object IDs), and `confidence` (`high`, `medium`, `low`, `unknown`).
4. For `05-flows.md`, list each supported flow with: `flow_id` (e.g., `F-001`), `from_component`, `to_component`, `direction` (one-way, two-way, or `unknown`), `payload_visible` (label literal, e.g., `JSON request`, `image upload`, `unknown`), `transport_visible` (e.g., `HTTPS`, `gRPC`, `unknown`), and `confidence`.
5. Do not infer hidden components, hidden flows, hidden retries, error paths, or runtime queues that the source does not show.
6. Do not assert authentication, authorization, encryption, logging, monitoring, network policy, or rate limiting in this output; that work belongs to RS-05 and RS-08.
7. Write both artifacts. Do not append to `{{output_root}}/00-run-log.md` until a human reviewer accepts both.

## 7. Stop Conditions

Stop before any write if any of the following holds:

- `runs/{{run_id}}/run-profile.yaml` is missing or unreadable.
- Any required run-profile variable from Section 3 is unset, empty, or unresolvable.
- `sensitive_data_confirmed_redacted` is `false`.
- `{{output_root}}/02-visible-dfd-objects.md` or `{{output_root}}/03-legend-normalization.md` is missing or empty.
- The visible-object listing contains no component-like or flow-like rows.
- Any proposed write resolves outside `{{output_root}}`.
- A read or write would touch the old reference workspace.
- A sensitive-data substring per `config/sensitive-data-rules.md` is detected.
- The instruction would require inventing components or flows, asserting controls, or claiming a Package 05+ skill / PRA / adapter / connector / runtime / scoring / diagram / release execution.

## 8. Unknown Handling

- Record any unsupported component kind, purpose, payload, transport, or direction as `unknown`.
- Record any partially supported fact with `confidence: low` and a short visible-evidence note.
- Do not import component or flow types from non-visible catalogs.
- Do not promote `unknown` rows to confirmed facts.

## 9. Evidence / Run-Log Guidance

- After human acceptance, append one entry to `{{output_root}}/00-run-log.md` recording: `prompt_id: PR-RS-04`, `outputs: {{output_root}}/04-components.md and {{output_root}}/05-flows.md`, accepted-by reviewer label, accepted-at timestamp (ISO 8601 UTC), and a one-line summary of component count, flow count, and unknown counts.
- Do not pre-write the run-log entry before human acceptance.
- Do not claim Jira post-back, Confluence publication, Rovo execution, or MCP execution.

## 10. Direct Prompt Test

Operator test sequence:

```
# 1. Use the run that already contains 02-visible-dfd-objects.md and 03-legend-normalization.md.
tools/Test-AisrafRunProfile.ps1 -RunProfilePath runs/RUN-LOCAL-RS04-TEST/run-profile.yaml -ExecutionReady
```

- Open this card in VS Code Copilot Chat. Do not edit the prompt body. Substitute or confirm only the variables in Section 3.
- Expected local artifacts: `runs/RUN-LOCAL-RS04-TEST/04-components.md` and `runs/RUN-LOCAL-RS04-TEST/05-flows.md`.
- PASS = both artifacts exist; every row cites visible-object IDs as source evidence; unknowns marked explicitly; no boundary or control assertion; no external/runtime claim; run-log entry appended only after human acceptance.

## 11. Not In Scope

- No skill execution. Skill contracts are deferred to Build Package 05.
- No PRA execution. PRA specifications are deferred to Build Package 06.
- No `.agent.md` adapter execution. Adapters are deferred to Build Package 06.
- No Jira post-back, Confluence publication, Rovo execution, or MCP execution.
- No accuracy scoring (handled only by [13-accuracy-score.prompt.md](13-accuracy-score.prompt.md)).
- No diagram generation, runbook generation, or release/export.
- No runtime, cloud, or database execution.
- No boundary, security-stack, control, AI Action Level, blueprint, finding, or recommendation work (later RS cards own those).
