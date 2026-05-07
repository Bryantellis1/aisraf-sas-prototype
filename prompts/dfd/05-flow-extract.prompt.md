---
prompt_id: PR-DFD-05
prompt_name: DFD Flow Extract
owning_build_package: Build Package 04
prompt_family: dfd
status: active
future_skill_id: SK-DFD-04-FLOW-EXTRACT (planned; defined in Build Package 05)
future_pra_owner: PRA-DFD-EXTRACTOR (planned; defined in Build Package 06)
dfd_step: DFD-04
---

# DFD-04 — Flow Extract

## 1. Identity

- prompt_id: `PR-DFD-05`
- prompt_name: DFD Flow Extract
- owning_build_package: Build Package 04 — Prompts and prompt registry.
- prompt_family: `dfd`
- status: `active`
- future_skill_id: `SK-DFD-04-FLOW-EXTRACT` (planned; defined in Build Package 05).
- future_pra_owner: `PRA-DFD-EXTRACTOR` (planned; defined in Build Package 06).
- dfd_step: `DFD-04`

## 2. Purpose

Extract a raw flow inventory from the DFD source. A flow is a visible directed connection between components or boundaries that may carry data, control, or human input. Write `{{output_root}}/dfd/04-flow-inventory.md`. This prompt records both raw observed flows (every visible arrow) and a normalized form that pairs `from` and `to` to component IDs from the prior catalog. It does not extract annotations (transport, auth, data class, encryption, retries) or controls; those are later DFD steps.

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
- `{{output_root}}/dfd/01-intake-quality-check.md`
- `{{output_root}}/dfd/02-boundary-catalog.md`
- `{{output_root}}/dfd/03-component-catalog.md`
- `{{input_root}}/` — DFD source and any flow-relevant notes.

Conditional read (only when `{{expected_root}}` is non-empty and populated):

- `{{expected_root}}/expected-flows.json`

This is a relationship reference only; do not edit the baseline.

Future-package references (not required; do not stop on absence):

- `skills/SK-DFD-04-FLOW-EXTRACT.md` (Build Package 05).
- `prototype-agents/PRA-DFD-EXTRACTOR.md` (Build Package 06).
- `catalogs/dfd/component-type-catalog.yaml`, `catalogs/dfd/boundary-type-catalog.yaml` (Build Package 07).
- `templates/dfd-flow-inventory-template.md` (Build Package 09).

## 5. Required Output

This prompt writes exactly one artifact:

- `{{output_root}}/dfd/04-flow-inventory.md`

No other write path is permitted. No write outside `{{output_root}}` is permitted.

## 6. Instructions

1. Resolve every variable in Section 3 from `runs/{{run_id}}/run-profile.yaml`.
2. Read the prior outputs in Section 4. Confirm all DFD prior outputs exist and are non-empty.
3. For each visible arrow, record: `flow_id` (e.g., `F-001`), `raw_from_label` (literal label or end shape on source), `raw_to_label`, `direction` (`one_way`, `two_way`, or `unknown`), `evidence` (visible arrow position or note).
4. Normalize each flow by mapping `raw_from_label` and `raw_to_label` to `from_component_id` and `to_component_id` from `dfd/03-component-catalog.md`. If the mapping is ambiguous, record both candidates and `confidence: low`.
5. Mark `unknown` for any field that is not visibly resolvable.
6. Add a "limits" footnote describing arrows whose endpoints are unclear.
7. Write `{{output_root}}/dfd/04-flow-inventory.md`. Do not append to `{{output_root}}/00-run-log.md` until a human reviewer accepts the inventory.

## 7. Stop Conditions

Stop before any write if any of the following holds:

- `runs/{{run_id}}/run-profile.yaml` is missing or unreadable.
- Any required run-profile variable from Section 3 is unset, empty, or unresolvable.
- `sensitive_data_confirmed_redacted` is `false`.
- Any prior output in Section 4 is missing or empty.
- The DFD source has no visible flows or arrows.
- Any proposed write resolves outside `{{output_root}}`.
- A read or write would touch the old reference workspace.
- A sensitive-data substring per `config/sensitive-data-rules.md` is detected.
- The instruction would require inventing flows, asserting transport or encryption, or claiming a Package 05+ skill / PRA / adapter / connector / runtime / scoring / diagram / release execution.

## 8. Unknown Handling

- Where an endpoint cannot be mapped to a component ID with confidence, record `unknown` with the candidate IDs in the evidence cell.
- Where direction is ambiguous, record `direction: unknown`.
- Do not promote `unknown` rows to confirmed flows.

## 9. Evidence / Run-Log Guidance

- After human acceptance, append one entry to `{{output_root}}/00-run-log.md` recording: `prompt_id: PR-DFD-05`, `output: {{output_root}}/dfd/04-flow-inventory.md`, accepted-by reviewer label, accepted-at timestamp (ISO 8601 UTC), and a one-line summary of flow count and unknown-endpoint count.
- Do not pre-write the run-log entry before human acceptance.
- Do not claim Jira post-back, Confluence publication, Rovo execution, or MCP execution.

## 10. Direct Prompt Test

Operator test sequence:

```
# 1. Use the run that already contains dfd/01..03 outputs.
tools/Test-AisrafRunProfile.ps1 -RunProfilePath runs/RUN-LOCAL-DFD04-TEST/run-profile.yaml -ExecutionReady
```

- Open this card in VS Code Copilot Chat. Do not edit the prompt body. Substitute or confirm only the variables in Section 3.
- Expected local artifact: `runs/RUN-LOCAL-DFD04-TEST/dfd/04-flow-inventory.md`.
- PASS = artifact exists; raw and normalized rows are aligned to component IDs from `dfd/03-component-catalog.md`; unknowns marked explicitly; no transport or encryption assertion; no external/runtime claim; run-log entry appended only after human acceptance.

## 11. Not In Scope

- No skill execution. Skill contracts are deferred to Build Package 05.
- No PRA execution. PRA specifications are deferred to Build Package 06.
- No `.agent.md` adapter execution. Adapters are deferred to Build Package 06.
- No Jira post-back, Confluence publication, Rovo execution, or MCP execution.
- No accuracy scoring (handled only by [../rs/13-accuracy-score.prompt.md](../rs/13-accuracy-score.prompt.md)).
- No diagram generation, runbook generation, or release/export.
- No runtime, cloud, or database execution.
- No annotation, control, boundary-crossing, confidence, or summary work (later DFD cards own those).
