---
prompt_id: PR-RS-05
prompt_name: Boundary And Security-Stack Detect
owning_build_package: Build Package 04
prompt_family: rs
status: active
future_skill_id: SK-BOUNDARY-CROSSING-DETECT and SK-SECURITY-STACK-DETECT (planned; defined in Build Package 05)
future_pra_owner: PRA-DESIGN-FACT-EXTRACTOR (planned; defined in Build Package 06)
review_step: RS-05
---

# RS-05 — Boundary And Security-Stack Detect

## 1. Identity

- prompt_id: `PR-RS-05`
- prompt_name: Boundary And Security-Stack Detect
- owning_build_package: Build Package 04 — Prompts and prompt registry.
- prompt_family: `rs`
- status: `active`
- future_skill_id: `SK-BOUNDARY-CROSSING-DETECT` and `SK-SECURITY-STACK-DETECT` (planned; defined in Build Package 05).
- future_pra_owner: `PRA-DESIGN-FACT-EXTRACTOR` (planned; defined in Build Package 06).
- review_step: `RS-05`

## 2. Purpose

Identify the supported boundaries (trust zones, customer environments, internet exposure, third-party integrations, model endpoints, data stores, tool/API edges) and the visible security-stack signals (authentication checkpoints, authorization checkpoints, encryption labels, logging, monitoring) implied by the components, flows, and normalized legend. Write `{{output_root}}/06-boundaries.md` and `{{output_root}}/07-security-stack-assessment.md`. This prompt records only what the source supports; it does not assert hidden controls, runtime behavior, or implementation proof.

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
- `{{output_root}}/03-legend-normalization.md`
- `{{output_root}}/04-components.md`
- `{{output_root}}/05-flows.md`

Conditional read (only when `{{expected_root}}` is non-empty and populated):

- `{{expected_root}}/expected-boundaries.json`
- `{{expected_root}}/expected-security-stack-assessment.json`

These are relationship references only; do not edit baselines.

Future-package references (not required; do not stop on absence):

- `skills/SK-BOUNDARY-CROSSING-DETECT.md` and `skills/SK-SECURITY-STACK-DETECT.md` (Build Package 05).
- `prototype-agents/PRA-DESIGN-FACT-EXTRACTOR.md` (Build Package 06).
- `catalogs/dfd/boundary-type-catalog.yaml`, `catalogs/dfd/security-stack-marker-catalog.yaml`, `catalogs/dfd/authn-authz-marker-catalog.yaml`, `catalogs/dfd/storage-protection-marker-catalog.yaml` (Build Package 07).
- `templates/boundaries-template.md` and `templates/security-stack-template.md` (Build Package 09).

## 5. Required Output

This prompt writes exactly two artifacts:

- `{{output_root}}/06-boundaries.md`
- `{{output_root}}/07-security-stack-assessment.md`

No other write path is permitted. No write outside `{{output_root}}` is permitted.

## 6. Instructions

1. Resolve every variable in Section 3 from `runs/{{run_id}}/run-profile.yaml`.
2. Read the three prior outputs in Section 4. Confirm all are non-empty.
3. For `06-boundaries.md`, list each supported boundary with: `boundary_id` (e.g., `B-001`), `kind` (trust zone, internet edge, customer environment, third-party, model endpoint, data store, tool/API, human operator, other, or `unknown`), `from_components` (component IDs inside), `to_components` (component IDs outside), `evidence` (visible legend zone, label, or note), and `confidence`.
4. For `07-security-stack-assessment.md`, list each visible security-stack signal with: `signal_id` (e.g., `S-001`), `kind` (authentication checkpoint, authorization checkpoint, encryption label, logging marker, monitoring marker, network policy marker, other, or `unknown`), `attached_to` (boundary or flow ID), `claim_supported_by_source` (one sentence citing visible evidence), and `confidence`.
5. Do not assert that any security control is enforced at runtime. Record what the source shows; mark unsupported behavior as `unknown`.
6. Write both artifacts. Do not append to `{{output_root}}/00-run-log.md` until a human reviewer accepts both.

## 7. Stop Conditions

Stop before any write if any of the following holds:

- `runs/{{run_id}}/run-profile.yaml` is missing or unreadable.
- Any required run-profile variable from Section 3 is unset, empty, or unresolvable.
- `sensitive_data_confirmed_redacted` is `false`.
- Any of `{{output_root}}/03-legend-normalization.md`, `{{output_root}}/04-components.md`, `{{output_root}}/05-flows.md` is missing or empty.
- Any proposed write resolves outside `{{output_root}}`.
- A read or write would touch the old reference workspace.
- A sensitive-data substring per `config/sensitive-data-rules.md` is detected.
- The instruction would require inventing a hidden boundary or control, asserting runtime enforcement, or claiming a Package 05+ skill / PRA / adapter / connector / runtime / scoring / diagram / release execution.

## 8. Unknown Handling

- Record any unsupported boundary kind, exposure, network control, owner, tenancy, region, or implementation status as `unknown`.
- Record any unsupported authentication, authorization, encryption, logging, monitoring, or network policy as `unknown`.
- Do not promote `unknown` rows to confirmed facts. Do not import non-visible markers from external knowledge.

## 9. Evidence / Run-Log Guidance

- After human acceptance, append one entry to `{{output_root}}/00-run-log.md` recording: `prompt_id: PR-RS-05`, `outputs: {{output_root}}/06-boundaries.md and {{output_root}}/07-security-stack-assessment.md`, accepted-by reviewer label, accepted-at timestamp (ISO 8601 UTC), and a one-line summary of boundary count, signal count, and unknown counts.
- Do not pre-write the run-log entry before human acceptance.
- Do not claim Jira post-back, Confluence publication, Rovo execution, or MCP execution.

## 10. Direct Prompt Test

Operator test sequence:

```
# 1. Use the run that already contains 03-legend-normalization.md, 04-components.md, 05-flows.md.
tools/Test-AisrafRunProfile.ps1 -RunProfilePath runs/RUN-LOCAL-RS05-TEST/run-profile.yaml -ExecutionReady
```

- Open this card in VS Code Copilot Chat. Do not edit the prompt body. Substitute or confirm only the variables in Section 3.
- Expected local artifacts: `runs/RUN-LOCAL-RS05-TEST/06-boundaries.md` and `runs/RUN-LOCAL-RS05-TEST/07-security-stack-assessment.md`.
- PASS = both artifacts exist; every row cites visible evidence; no runtime control assertion; unknowns marked explicitly; no external/runtime claim; run-log entry appended only after human acceptance.

## 11. Not In Scope

- No skill execution. Skill contracts are deferred to Build Package 05.
- No PRA execution. PRA specifications are deferred to Build Package 06.
- No `.agent.md` adapter execution. Adapters are deferred to Build Package 06.
- No Jira post-back, Confluence publication, Rovo execution, or MCP execution.
- No accuracy scoring (handled only by [13-accuracy-score.prompt.md](13-accuracy-score.prompt.md)).
- No diagram generation, runbook generation, or release/export.
- No runtime, cloud, or database execution.
- No internal review table, missing facts, AI Action Level, blueprint match, finding, or recommendation work (later RS cards own those).
