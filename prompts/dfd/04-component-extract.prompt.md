---
prompt_id: PR-DFD-04
prompt_name: DFD Component Extract
owning_build_package: Build Package 04
prompt_family: dfd
status: active
future_skill_id: SK-DFD-03-COMPONENT-EXTRACT (planned; defined in Build Package 05)
future_pra_owner: PRA-DFD-EXTRACTOR (planned; defined in Build Package 06)
dfd_step: DFD-03
---

# DFD-03 — Component Extract

## 1. Identity

- prompt_id: `PR-DFD-04`
- prompt_name: DFD Component Extract
- owning_build_package: Build Package 04 — Prompts and prompt registry.
- prompt_family: `dfd`
- status: `active`
- future_skill_id: `SK-DFD-03-COMPONENT-EXTRACT` (planned; defined in Build Package 05).
- future_pra_owner: `PRA-DFD-EXTRACTOR` (planned; defined in Build Package 06).
- dfd_step: `DFD-03`

## 2. Purpose

Extract a DFD component catalog from the DFD source, given the boundaries already cataloged. A component is a visible service, application, store, queue, identity provider, model endpoint, tool/API, human, or other actor. Write `{{output_root}}/dfd/03-component-catalog.md`. This prompt records visible or note-supported components only; it does not extract flows, annotations, controls, or runtime behavior, and does not import component types from non-visible catalogs.

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
- `{{input_root}}/` — DFD source and any component-relevant notes.

Conditional read (only when `{{expected_root}}` is non-empty and populated):

- `{{expected_root}}/expected-components.json`

This is a relationship reference only; do not edit the baseline.

Future-package references (not required; do not stop on absence):

- `skills/SK-DFD-03-COMPONENT-EXTRACT.md` (Build Package 05).
- `prototype-agents/PRA-DFD-EXTRACTOR.md` (Build Package 06).
- `catalogs/dfd/component-type-catalog.yaml`, `catalogs/dfd/cloud-service-component-map.yaml`, `catalogs/dfd/boundary-type-catalog.yaml` (Build Package 07).
- `templates/dfd-component-catalog-template.md` (Build Package 09).

## 5. Required Output

This prompt writes exactly one artifact:

- `{{output_root}}/dfd/03-component-catalog.md`

No other write path is permitted. No write outside `{{output_root}}` is permitted.

## 6. Instructions

1. Resolve every variable in Section 3 from `runs/{{run_id}}/run-profile.yaml`.
2. Read the prior outputs in Section 4. Confirm both DFD prior outputs exist and are non-empty.
3. For each visible component, record: `component_id` (e.g., `C-001`), `name_visible_on_source`, `kind` (web app, API, database, queue, cache, model endpoint, tool/API, identity provider, human, other, or `unknown`), `containing_boundary_id` (or `unknown`), `evidence` (visible label, shape, or note), and `confidence`.
4. Do not assert internal implementation, cloud provider, region, version, or operational status unless the source explicitly shows it. Mark such fields `unknown` if they are not visible.
5. Do not import component types from non-visible catalogs (Build Package 07 will provide controlled vocabulary later).
6. Add a "limits" footnote describing components hinted at but not visibly resolvable.
7. Write `{{output_root}}/dfd/03-component-catalog.md`. Do not append to `{{output_root}}/00-run-log.md` until a human reviewer accepts the catalog.

## 7. Stop Conditions

Stop before any write if any of the following holds:

- `runs/{{run_id}}/run-profile.yaml` is missing or unreadable.
- Any required run-profile variable from Section 3 is unset, empty, or unresolvable.
- `sensitive_data_confirmed_redacted` is `false`.
- `{{output_root}}/dfd/01-intake-quality-check.md` or `{{output_root}}/dfd/02-boundary-catalog.md` is missing or empty.
- The DFD source contains real sensitive payload, secrets, credentials, or production endpoints.
- Any proposed write resolves outside `{{output_root}}`.
- A read or write would touch the old reference workspace.
- A sensitive-data substring per `config/sensitive-data-rules.md` is detected.
- The instruction would require inventing components, asserting runtime behavior, or claiming a Package 05+ skill / PRA / adapter / connector / runtime / scoring / diagram / release execution.

## 8. Unknown Handling

- Record any unsupported component kind, containing boundary, implementation, owner, or status as `unknown`.
- Where the same shape might map to multiple component kinds, record `kind: unknown` and list the candidate kinds in the evidence cell.
- Do not promote `unknown` rows to confirmed component types.

## 9. Evidence / Run-Log Guidance

- After human acceptance, append one entry to `{{output_root}}/00-run-log.md` recording: `prompt_id: PR-DFD-04`, `output: {{output_root}}/dfd/03-component-catalog.md`, accepted-by reviewer label, accepted-at timestamp (ISO 8601 UTC), and a one-line summary of component count and unknown count.
- Do not pre-write the run-log entry before human acceptance.
- Do not claim Jira post-back, Confluence publication, Rovo execution, or MCP execution.

## 10. Direct Prompt Test

Operator test sequence:

```
# 1. Use the run that already contains dfd/01-intake-quality-check.md and dfd/02-boundary-catalog.md.
tools/Test-AisrafRunProfile.ps1 -RunProfilePath runs/RUN-LOCAL-DFD03-TEST/run-profile.yaml -ExecutionReady
```

- Open this card in VS Code Copilot Chat. Do not edit the prompt body. Substitute or confirm only the variables in Section 3.
- Expected local artifact: `runs/RUN-LOCAL-DFD03-TEST/dfd/03-component-catalog.md`.
- PASS = artifact exists; component rows cite visible-evidence; containing boundary IDs reference `dfd/02-boundary-catalog.md`; unknowns marked explicitly; no runtime assertion; no external/runtime claim; run-log entry appended only after human acceptance.

## 11. Not In Scope

- No skill execution. Skill contracts are deferred to Build Package 05.
- No PRA execution. PRA specifications are deferred to Build Package 06.
- No `.agent.md` adapter execution. Adapters are deferred to Build Package 06.
- No Jira post-back, Confluence publication, Rovo execution, or MCP execution.
- No accuracy scoring (handled only by [../rs/13-accuracy-score.prompt.md](../rs/13-accuracy-score.prompt.md)).
- No diagram generation, runbook generation, or release/export.
- No runtime, cloud, or database execution.
- No flow, annotation, control, crossing, confidence, or summary work (later DFD cards own those).
