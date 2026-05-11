---
prompt_id: PR-DFD-03
prompt_name: DFD Boundary Extract
owning_build_package: Build Package 04
prompt_family: dfd
status: active
future_skill_id: SK-DFD-02-BOUNDARY-EXTRACT (planned; defined in Build Package 05)
future_pra_owner: PRA-DFD-EXTRACTOR (planned; defined in Build Package 06)
dfd_step: DFD-02
---

# DFD-02 — Boundary Extract

## 1. Identity

- prompt_id: `PR-DFD-03`
- prompt_name: DFD Boundary Extract
- owning_build_package: Build Package 04 — Prompts and prompt registry.
- prompt_family: `dfd`
- status: `active`
- future_skill_id: `SK-DFD-02-BOUNDARY-EXTRACT` (planned; defined in Build Package 05).
- future_pra_owner: `PRA-DFD-EXTRACTOR` (planned; defined in Build Package 06).
- dfd_step: `DFD-02`

## 2. Purpose

Extract a boundary catalog from the DFD source. A boundary is a visible trust zone, customer environment, internet edge, third-party perimeter, model endpoint, data store, or tool/API edge. Write `{{output_root}}/dfd/02-boundary-catalog.md`. This prompt records visible or note-supported boundaries only; it does not extract components, flows, controls, or runtime behavior, and does not promote a label to an enforced control.

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
- `{{input_root}}/` — DFD source and any boundary-relevant notes.

Conditional read (only when `{{expected_root}}` is non-empty and populated):

- `{{expected_root}}/expected-boundaries.json`

This is a relationship reference only; do not edit the baseline.

Future-package references (not required; do not stop on absence):

- `skills/SK-DFD-02-BOUNDARY-EXTRACT.md` (Build Package 05).
- `prototype-agents/PRA-DFD-EXTRACTOR.md` (Build Package 06).
- `catalogs/dfd/boundary-type-catalog.yaml` (Build Package 07).
- `catalogs/dfd/security-stack-marker-catalog.yaml` (Build Package 07).
- `templates/dfd-boundary-catalog-template.md` (Build Package 09).

## 5. Required Output

This prompt writes exactly one artifact:

- `{{output_root}}/dfd/02-boundary-catalog.md`

No other write path is permitted. No write outside `{{output_root}}` is permitted.

## 6. Instructions

1. Resolve every variable in Section 3 from `runs/{{run_id}}/run-profile.yaml`.
2. Read `{{output_root}}/dfd/01-intake-quality-check.md`. If `intake_decision: do_not_proceed`, stop. If `intake_decision: proceed_with_limits`, record the limits in this output.
3. Walk the DFD source from largest enclosing boundary to smallest, preserving parent-child nesting.
4. For each boundary, record: `boundary_id` (e.g., `B-001`), `kind` (trust zone, internet edge, customer environment, third-party, model endpoint, data store, tool/API, human operator, other, or `unknown`), `parent_boundary_id` (or `none` if top level), `evidence` (visible legend zone, label, or note), and `confidence` (`high`, `medium`, `low`, or `unknown`).
5. Do not extract components, flows, controls, owners, tenancy, region, or runtime status. Do not import boundary types from non-visible catalogs.
6. Add a "limits" footnote describing nesting ambiguity, label overlap, or any hidden boundary the source hints at but does not show.
7. Write `{{output_root}}/dfd/02-boundary-catalog.md`. Do not append to `{{output_root}}/00-run-log.md` until a human reviewer accepts the catalog.

## 7. Stop Conditions

Stop before any write if any of the following holds:

- `runs/{{run_id}}/run-profile.yaml` is missing or unreadable.
- Any required run-profile variable from Section 3 is unset, empty, or unresolvable.
- `sensitive_data_confirmed_redacted` is `false`.
- `{{output_root}}/dfd/01-intake-quality-check.md` is missing, empty, or records `intake_decision: do_not_proceed`.
- The DFD source is missing, empty, corrupted, or unreadable.
- Any proposed write resolves outside `{{output_root}}`.
- A read or write would touch the old reference workspace.
- A sensitive-data substring per `config/sensitive-data-rules.md` is detected.
- The instruction would require inventing hidden boundaries, splitting unseen child components, asserting controls, or claiming a Package 05+ skill / PRA / adapter / connector / runtime / scoring / diagram / release execution.

## 8. Unknown Handling

- Record any unsupported boundary kind, parent, exposure, network control, owner, tenancy, region, or implementation status as `unknown`.
- Where parent-child nesting is ambiguous, record `parent_boundary_id: unknown` and explain in the limits footnote.
- Do not promote `unknown` rows to confirmed boundary types.

## 9. Evidence / Run-Log Guidance

- After human acceptance, append one entry to `{{output_root}}/00-run-log.md` recording: `prompt_id: PR-DFD-03`, `output: {{output_root}}/dfd/02-boundary-catalog.md`, accepted-by reviewer label, accepted-at timestamp (ISO 8601 UTC), and a one-line summary of boundary count and unknown count.
- Do not pre-write the run-log entry before human acceptance.
- Do not claim Jira post-back, Confluence publication, Rovo execution, or MCP execution.

## 10. Direct Prompt Test

Operator test sequence:

```
# 1. Use the run that already contains dfd/01-intake-quality-check.md.
tools/Test-AisrafRunProfile.ps1 -RunProfilePath runs/RUN-LOCAL-DFD02-TEST/run-profile.yaml -ExecutionReady
```

- Open this card in VS Code Copilot Chat. Do not edit the prompt body. Substitute or confirm only the variables in Section 3.
- Expected local artifact: `runs/RUN-LOCAL-DFD02-TEST/dfd/02-boundary-catalog.md`.
- PASS = artifact exists; boundary rows are visible-evidence-supported; nesting preserved; unknowns marked explicitly; no control assertion; no external/runtime claim; run-log entry appended only after human acceptance.

## 11. Not In Scope

- No skill execution. Skill contracts are deferred to Build Package 05.
- No PRA execution. PRA specifications are deferred to Build Package 06.
- No `.agent.md` adapter execution. Adapters are deferred to Build Package 06.
- No Jira post-back, Confluence publication, Rovo execution, or MCP execution.
- No accuracy scoring (handled only by [../rs/13-accuracy-score.prompt.md](../rs/13-accuracy-score.prompt.md)).
- No diagram generation, runbook generation, or release/export.
- No runtime, cloud, or database execution.
- No component, flow, annotation, control, crossing, confidence, or summary work (later DFD cards own those).
