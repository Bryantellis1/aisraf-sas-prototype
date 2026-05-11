---
prompt_id: PR-DFD-08
prompt_name: DFD Control Signal Detect
owning_build_package: Build Package 04
prompt_family: dfd
status: active
future_skill_id: SK-DFD-07-CONTROL-SIGNAL-DETECT (planned; defined in Build Package 05)
future_pra_owner: PRA-DFD-EXTRACTOR (planned; defined in Build Package 06)
dfd_step: DFD-07
---

# DFD-07 — Control Signal Detect

## 1. Identity

- prompt_id: `PR-DFD-08`
- prompt_name: DFD Control Signal Detect
- owning_build_package: Build Package 04 — Prompts and prompt registry.
- prompt_family: `dfd`
- status: `active`
- future_skill_id: `SK-DFD-07-CONTROL-SIGNAL-DETECT` (planned; defined in Build Package 05).
- future_pra_owner: `PRA-DFD-EXTRACTOR` (planned; defined in Build Package 06).
- dfd_step: `DFD-07`

## 2. Purpose

Identify visible control signals (authentication, authorization, encryption-in-transit, encryption-at-rest, logging, monitoring, network policy, rate limit) attached to components, flows, or boundary crossings, based on the prior annotation resolution and crossing detection. Write `{{output_root}}/dfd/07-control-signals.md`. This prompt records signal labels only; it does not assert that a control is enforced at runtime, does not claim configuration correctness, and does not score against a baseline.

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
- `{{output_root}}/dfd/03-component-catalog.md`
- `{{output_root}}/dfd/04-flow-inventory.md`
- `{{output_root}}/dfd/05-annotation-resolution.md`
- `{{output_root}}/dfd/06-boundary-crossings.md`

Conditional read (only when `{{expected_root}}` is non-empty and populated):

- `{{expected_root}}/expected-security-stack-assessment.json`

This is a relationship reference only; do not edit the baseline.

Future-package references (not required; do not stop on absence):

- `skills/SK-DFD-07-CONTROL-SIGNAL-DETECT.md` (Build Package 05).
- `prototype-agents/PRA-DFD-EXTRACTOR.md` (Build Package 06).
- `catalogs/dfd/security-stack-marker-catalog.yaml`, `catalogs/dfd/authn-authz-marker-catalog.yaml`, `catalogs/dfd/storage-protection-marker-catalog.yaml`, `catalogs/dfd/cloud-service-component-map.yaml` (Build Package 07).
- `templates/dfd-control-signals-template.md` (Build Package 09).

## 5. Required Output

This prompt writes exactly one artifact:

- `{{output_root}}/dfd/07-control-signals.md`

No other write path is permitted. No write outside `{{output_root}}` is permitted.

## 6. Instructions

1. Resolve every variable in Section 3 from `runs/{{run_id}}/run-profile.yaml`.
2. Read the four prior outputs in Section 4. Confirm all are non-empty.
3. For each visible control signal, record: `signal_id` (e.g., `CS-001`), `kind` (`authentication`, `authorization`, `encryption_in_transit`, `encryption_at_rest`, `logging`, `monitoring`, `network_policy`, `rate_limit`, `other`, or `unknown`), `attached_to` (component_id, flow_id, or crossing_id), `evidence` (annotation row, legend token, or crossing row), `claim_strength_qualitative` (`labeled` if the source labels the control, `implied` if a related label suggests but does not state it, `not_supported` if no evidence, or `unknown`), and `confidence`.
4. Do not assert that a labeled control is enforced at runtime; the source label only confirms intent or design.
5. Where the same flow has multiple labeled controls (e.g., `https` plus an auth marker), record each as a separate signal row.
6. Add a "limits" footnote describing controls inferred from cloud defaults (mark all such inferences `claim_strength_qualitative: not_supported` and `confidence: unknown`).
7. Write `{{output_root}}/dfd/07-control-signals.md`. Do not append to `{{output_root}}/00-run-log.md` until a human reviewer accepts the signals.

## 7. Stop Conditions

Stop before any write if any of the following holds:

- `runs/{{run_id}}/run-profile.yaml` is missing or unreadable.
- Any required run-profile variable from Section 3 is unset, empty, or unresolvable.
- `sensitive_data_confirmed_redacted` is `false`.
- Any of the four prior outputs is missing or empty.
- A row would require asserting that a control is enforced at runtime.
- A row would require importing a default-on assumption (e.g., "this cloud service encrypts at rest by default") as a labeled signal.
- Any proposed write resolves outside `{{output_root}}`.
- A read or write would touch the old reference workspace.
- A sensitive-data substring per `config/sensitive-data-rules.md` is detected.
- The instruction would require claiming a Package 05+ skill / PRA / adapter / connector / runtime / scoring / diagram / release execution.

## 8. Unknown Handling

- Where the source neither labels nor implies a control, record `claim_strength_qualitative: not_supported` and `confidence: unknown`.
- Where multiple kinds plausibly apply, record `kind: unknown` and list the candidate kinds in the evidence cell.
- Do not promote `implied` rows to `labeled`.

## 9. Evidence / Run-Log Guidance

- After human acceptance, append one entry to `{{output_root}}/00-run-log.md` recording: `prompt_id: PR-DFD-08`, `output: {{output_root}}/dfd/07-control-signals.md`, accepted-by reviewer label, accepted-at timestamp (ISO 8601 UTC), and a one-line summary of labeled / implied / not_supported / unknown counts.
- Do not pre-write the run-log entry before human acceptance.
- Do not claim Jira post-back, Confluence publication, Rovo execution, or MCP execution.

## 10. Direct Prompt Test

Operator test sequence:

```
# 1. Use the run that already contains dfd/03..06 outputs.
tools/Test-AisrafRunProfile.ps1 -RunProfilePath runs/RUN-LOCAL-DFD07-TEST/run-profile.yaml -ExecutionReady
```

- Open this card in VS Code Copilot Chat. Do not edit the prompt body. Substitute or confirm only the variables in Section 3.
- Expected local artifact: `runs/RUN-LOCAL-DFD07-TEST/dfd/07-control-signals.md`.
- PASS = artifact exists; every signal row cites prior-output evidence; no runtime enforcement claim; cloud defaults are recorded as `not_supported` rather than `labeled`; no external/runtime claim; run-log entry appended only after human acceptance.

## 11. Not In Scope

- No skill execution. Skill contracts are deferred to Build Package 05.
- No PRA execution. PRA specifications are deferred to Build Package 06.
- No `.agent.md` adapter execution. Adapters are deferred to Build Package 06.
- No Jira post-back, Confluence publication, Rovo execution, or MCP execution.
- No accuracy scoring (handled only by [../rs/13-accuracy-score.prompt.md](../rs/13-accuracy-score.prompt.md)).
- No diagram generation, runbook generation, or release/export.
- No runtime, cloud, or database execution.
- No confidence-row scoring (DFD-08 owns that), no extraction summarization (DFD-09 owns that).
