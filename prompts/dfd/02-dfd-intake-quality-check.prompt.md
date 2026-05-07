---
prompt_id: PR-DFD-02
prompt_name: DFD Intake Quality Check
owning_build_package: Build Package 04
prompt_family: dfd
status: active
future_skill_id: SK-DFD-01-INTAKE-QUALITY-CHECK (planned; defined in Build Package 05)
future_pra_owner: PRA-DFD-EXTRACTOR (planned; defined in Build Package 06)
dfd_step: DFD-01
---

# DFD-01 — Intake Quality Check

## 1. Identity

- prompt_id: `PR-DFD-02`
- prompt_name: DFD Intake Quality Check
- owning_build_package: Build Package 04 — Prompts and prompt registry.
- prompt_family: `dfd`
- status: `active`
- future_skill_id: `SK-DFD-01-INTAKE-QUALITY-CHECK` (planned; defined in Build Package 05).
- future_pra_owner: `PRA-DFD-EXTRACTOR` (planned; defined in Build Package 06).
- dfd_step: `DFD-01`

## 2. Purpose

Check whether the staged DFD inputs are readable enough to extract boundaries, components, flows, and controls in later DFD subskills. Write `{{output_root}}/dfd/01-intake-quality-check.md`. The output records source availability, readability, sensitive-material rejection, and the operator's go/no-go decision for downstream extraction. This prompt does not extract DFD facts, does not import meanings from non-visible catalogs, and does not promote a low-quality intake to a confident extraction state.

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
- `{{input_root}}/` — every file present at the top level, including the DFD source artifact and any supporting notes (legend excerpt, cloud triage notes, transcript, ticket).

Conditional read (only when the file exists; the RS prompt may not have been run):

- `{{output_root}}/01-input-inventory.md` (RS-01 output) — used for cross-reference if present; do not require its presence to run DFD-01.

Future-package references (not required; do not stop on absence):

- `skills/SK-DFD-01-INTAKE-QUALITY-CHECK.md` (Build Package 05).
- `prototype-agents/PRA-DFD-EXTRACTOR.md` (Build Package 06).
- `catalogs/dfd/component-type-catalog.yaml` (Build Package 07).
- `templates/dfd-intake-quality-check-template.md` (Build Package 09).

## 5. Required Output

This prompt writes exactly one artifact:

- `{{output_root}}/dfd/01-intake-quality-check.md`

No other write path is permitted. No write outside `{{output_root}}` is permitted.

## 6. Instructions

1. Resolve every variable in Section 3 from `runs/{{run_id}}/run-profile.yaml`.
2. Confirm `{{output_root}}/dfd/` exists. If absent, the operator may create it explicitly; this prompt does not create folders outside the `runs/{{run_id}}/dfd/` path that the run-setup tool already produces.
3. List the DFD-related artifacts present at `{{input_root}}/` and classify each as `dfd_source`, `legend_excerpt`, `cloud_triage_note`, `review_transcript`, `intake_ticket`, or `unknown`.
4. For each DFD source artifact, record: `readability` (`high`, `medium`, `low`, `unreadable`), `sensitive_material_present` (`true`, `false`, or `unknown` — the operator's manual judgment based on visible content), `notes_count` (number of supporting note files), and `decision` (`proceed`, `proceed_with_limits`, or `do_not_proceed`).
5. Add a "limits" section listing readability constraints (image quality, occlusion, missing legend, partial transcript).
6. Make a final go/no-go decision recorded as `intake_decision: proceed | proceed_with_limits | do_not_proceed` with one-paragraph reason.
7. Write `{{output_root}}/dfd/01-intake-quality-check.md`. Do not append to `{{output_root}}/00-run-log.md` until a human reviewer accepts the check.

## 7. Stop Conditions

Stop before any write if any of the following holds:

- `runs/{{run_id}}/run-profile.yaml` is missing or unreadable.
- Any required run-profile variable from Section 3 is unset, empty, or unresolvable.
- `sensitive_data_confirmed_redacted` is `false`.
- `{{input_root}}` does not exist, is empty, or contains no DFD source artifact.
- A DFD source artifact contains real sensitive payload, secrets, credentials, or production endpoints — record `do_not_proceed` and stop, do not extract.
- Any proposed write resolves outside `{{output_root}}`.
- A read or write would touch the old reference workspace.
- A sensitive-data substring per `config/sensitive-data-rules.md` is detected in any read value.
- The instruction would require running a Package 05+ skill / PRA / adapter / connector / runtime / scoring / diagram / release service.

## 8. Unknown Handling

- Record any unreadable artifact as `unreadable` and explain briefly.
- Record any partially obscured source with `readability: low` or `readability: medium`.
- Where the operator cannot judge sensitive-material presence, record `sensitive_material_present: unknown` and explain.
- Do not invent intake decisions; do not promote `proceed_with_limits` to `proceed`.

## 9. Evidence / Run-Log Guidance

- After human acceptance, append one entry to `{{output_root}}/00-run-log.md` recording: `prompt_id: PR-DFD-02`, `output: {{output_root}}/dfd/01-intake-quality-check.md`, accepted-by reviewer label, accepted-at timestamp (ISO 8601 UTC), and a one-line summary of `intake_decision` and any readability limits.
- Do not pre-write the run-log entry before human acceptance.
- Do not claim Jira post-back, Confluence publication, Rovo execution, or MCP execution.

## 10. Direct Prompt Test

Operator test sequence:

```
# 1. Create a folder-first test run with sample inputs (or stage your own under runs/<RunId>/inputs/).
tools/New-AisrafRun.ps1 -RunId RUN-LOCAL-DFD01-TEST -SampleId sample-001-dfd-crop -Mode folder_first_test -CopySampleInputs
tools/Test-AisrafRunProfile.ps1 -RunProfilePath runs/RUN-LOCAL-DFD01-TEST/run-profile.yaml -ExecutionReady
```

- Open this card in VS Code Copilot Chat. Do not edit the prompt body. Substitute or confirm only the variables in Section 3.
- Expected local artifact: `runs/RUN-LOCAL-DFD01-TEST/dfd/01-intake-quality-check.md`.
- PASS = artifact exists; readability and sensitive-material judgments are explicit; `intake_decision` is one of the allowed values; no DFD facts extracted; no external/runtime claim; run-log entry appended only after human acceptance.

## 11. Not In Scope

- No skill execution. Skill contracts are deferred to Build Package 05.
- No PRA execution. PRA specifications are deferred to Build Package 06.
- No `.agent.md` adapter execution. Adapters are deferred to Build Package 06.
- No Jira post-back, Confluence publication, Rovo execution, or MCP execution.
- No accuracy scoring (handled only by [../rs/13-accuracy-score.prompt.md](../rs/13-accuracy-score.prompt.md)).
- No diagram generation, runbook generation, or release/export.
- No runtime, cloud, or database execution.
- No boundary, component, flow, annotation, control, confidence, or summary work (later DFD cards own those).
