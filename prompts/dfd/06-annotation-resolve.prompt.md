---
prompt_id: PR-DFD-06
prompt_name: DFD Annotation Resolve
owning_build_package: Build Package 04
prompt_family: dfd
status: active
future_skill_id: SK-DFD-05-ANNOTATION-RESOLVE (planned; defined in Build Package 05)
future_pra_owner: PRA-DFD-EXTRACTOR (planned; defined in Build Package 06)
dfd_step: DFD-05
---

# DFD-05 — Annotation Resolve

## 1. Identity

- prompt_id: `PR-DFD-06`
- prompt_name: DFD Annotation Resolve
- owning_build_package: Build Package 04 — Prompts and prompt registry.
- prompt_family: `dfd`
- status: `active`
- future_skill_id: `SK-DFD-05-ANNOTATION-RESOLVE` (planned; defined in Build Package 05).
- future_pra_owner: `PRA-DFD-EXTRACTOR` (planned; defined in Build Package 06).
- dfd_step: `DFD-05`

## 2. Purpose

Resolve visible legend tokens and inline annotations into normalized meanings on the prior boundary, component, and flow rows. Annotation classes covered: data class (e.g., `pii`, `pan`, `internal`, `public`, `unknown`), authentication marker, authorization marker, transport marker (e.g., `https`, `grpc`, `unknown`), data-at-rest marker, and operator-assigned confidence. Write `{{output_root}}/dfd/05-annotation-resolution.md`. This prompt records visible meanings only; it does not infer hidden controls, does not assert runtime enforcement, and does not score against a baseline.

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
- `{{input_root}}/` — visible legend, inline notes, transcript, ticket.

Conditional read (only when `{{expected_root}}` is non-empty and populated):

- `{{expected_root}}/expected-legend-normalization.json`
- `{{expected_root}}/expected-flows.json`

These are relationship references only; do not edit baselines.

Future-package references (not required; do not stop on absence):

- `skills/SK-DFD-05-ANNOTATION-RESOLVE.md` (Build Package 05).
- `prototype-agents/PRA-DFD-EXTRACTOR.md` (Build Package 06).
- `catalogs/dfd/annotation-semantics-registry.yaml`, `catalogs/dfd/authn-authz-marker-catalog.yaml`, `catalogs/dfd/storage-protection-marker-catalog.yaml`, `catalogs/dfd/security-stack-marker-catalog.yaml` (Build Package 07).
- `templates/dfd-annotation-resolution-template.md` (Build Package 09).

## 5. Required Output

This prompt writes exactly one artifact:

- `{{output_root}}/dfd/05-annotation-resolution.md`

No other write path is permitted. No write outside `{{output_root}}` is permitted.

## 6. Instructions

1. Resolve every variable in Section 3 from `runs/{{run_id}}/run-profile.yaml`.
2. Read the prior outputs in Section 4. Confirm all DFD prior outputs exist and are non-empty.
3. Build a small dictionary of visible tokens with: `token`, `normalized_meaning` (only when the source legend or inline note states it), `source_evidence`, and `confidence`.
4. For each row in `dfd/04-flow-inventory.md`, attach annotation columns: `data_class` (e.g., `pii`, `pan`, `internal`, `public`, or `unknown`), `auth_marker` (or `unknown`), `authz_marker` (or `unknown`), `transport_marker` (e.g., `https`, `grpc`, or `unknown`), `at_rest_marker` (or `unknown`), and `annotation_confidence`.
5. Where the source legend does not state a meaning, record `unknown`. Do not import meanings from non-visible catalogs.
6. Add a "limits" footnote describing tokens not defined and rows whose annotations are partial.
7. Write `{{output_root}}/dfd/05-annotation-resolution.md`. Do not append to `{{output_root}}/00-run-log.md` until a human reviewer accepts the resolution.

## 7. Stop Conditions

Stop before any write if any of the following holds:

- `runs/{{run_id}}/run-profile.yaml` is missing or unreadable.
- Any required run-profile variable from Section 3 is unset, empty, or unresolvable.
- `sensitive_data_confirmed_redacted` is `false`.
- Any prior output in Section 4 is missing or empty.
- The DFD source contains real sensitive payload, secrets, credentials, or production endpoints.
- Any proposed write resolves outside `{{output_root}}`.
- A read or write would touch the old reference workspace.
- A sensitive-data substring per `config/sensitive-data-rules.md` is detected.
- The instruction would require inventing legend meanings, asserting hidden controls, or claiming a Package 05+ skill / PRA / adapter / connector / runtime / scoring / diagram / release execution.

## 8. Unknown Handling

- Where the source legend or inline note does not state a meaning, record `unknown`.
- Where two tokens look related but are not equated by the source, do not collapse them.
- Do not promote `unknown` annotations to confirmed values to lower the unknown count.

## 9. Evidence / Run-Log Guidance

- After human acceptance, append one entry to `{{output_root}}/00-run-log.md` recording: `prompt_id: PR-DFD-06`, `output: {{output_root}}/dfd/05-annotation-resolution.md`, accepted-by reviewer label, accepted-at timestamp (ISO 8601 UTC), and a one-line summary of resolved-token count and `unknown` count.
- Do not pre-write the run-log entry before human acceptance.
- Do not claim Jira post-back, Confluence publication, Rovo execution, or MCP execution.

## 10. Direct Prompt Test

Operator test sequence:

```
# 1. Use the run that already contains dfd/02-boundary-catalog.md, dfd/03-component-catalog.md, dfd/04-flow-inventory.md.
tools/Test-AisrafRunProfile.ps1 -RunProfilePath runs/RUN-LOCAL-DFD05-TEST/run-profile.yaml -ExecutionReady
```

- Open this card in VS Code Copilot Chat. Do not edit the prompt body. Substitute or confirm only the variables in Section 3.
- Expected local artifact: `runs/RUN-LOCAL-DFD05-TEST/dfd/05-annotation-resolution.md`.
- PASS = artifact exists; every annotation cites visible legend or inline-note evidence; tokens not defined by source remain `unknown`; no control assertion; no external/runtime claim; run-log entry appended only after human acceptance.

## 11. Not In Scope

- No skill execution. Skill contracts are deferred to Build Package 05.
- No PRA execution. PRA specifications are deferred to Build Package 06.
- No `.agent.md` adapter execution. Adapters are deferred to Build Package 06.
- No Jira post-back, Confluence publication, Rovo execution, or MCP execution.
- No accuracy scoring (handled only by [../rs/13-accuracy-score.prompt.md](../rs/13-accuracy-score.prompt.md)).
- No diagram generation, runbook generation, or release/export.
- No runtime, cloud, or database execution.
- No boundary-crossing, control-signal, confidence, or summary work (later DFD cards own those).
