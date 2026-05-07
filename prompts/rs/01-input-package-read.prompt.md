---
prompt_id: PR-RS-01
prompt_name: Input Package Read
owning_build_package: Build Package 04
prompt_family: rs
status: active
future_skill_id: SK-INPUT-PACKAGE-READ (planned; defined in Build Package 05)
future_pra_owner: PRA-INTAKE (planned; defined in Build Package 06)
review_step: RS-01
---

# RS-01 — Input Package Read

## 1. Identity

- prompt_id: `PR-RS-01`
- prompt_name: Input Package Read
- owning_build_package: Build Package 04 — Prompts and prompt registry.
- prompt_family: `rs`
- status: `active`
- future_skill_id: `SK-INPUT-PACKAGE-READ` (planned; defined in Build Package 05).
- future_pra_owner: `PRA-INTAKE` (planned; defined in Build Package 06).
- review_step: `RS-01`

## 2. Purpose

Inventory the review materials staged under `{{input_root}}` and produce a single Markdown inventory at `{{output_root}}/01-input-inventory.md`. The inventory lists each received artifact with status (present, empty, unreadable), purpose (DFD crop, legend excerpt, cloud triage notes, review transcript, intake ticket, other), and any material gap that should be raised before the design-fact extraction starts. This prompt does not invent missing materials, request a new submission form, or alter source inputs.

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
- Every file present at the top level of `{{input_root}}/`.

Conditional read (only when `{{expected_root}}` is non-empty and populated):

- `{{expected_root}}/expected-input-inventory.json` — used as a relationship reference only; do not edit and do not require for Build Package 04 acceptance.

Future-package references (not required for this prompt; do not stop on absence):

- `skills/SK-INPUT-PACKAGE-READ.md` (Build Package 05).
- `prototype-agents/PRA-INTAKE.md` (Build Package 06).
- `templates/run-log-entry-template.md` (Build Package 09).
- `samples/{{sample_id}}/expected/expected-input-inventory.json` (Build Package 10).

## 5. Required Output

This prompt writes exactly one artifact:

- `{{output_root}}/01-input-inventory.md`

No other write path is permitted. No write outside `{{output_root}}` is permitted.

## 6. Instructions

1. Resolve every variable in Section 3 from `runs/{{run_id}}/run-profile.yaml`.
2. List the contents of `{{input_root}}/` (top level only).
3. For each entry, classify the artifact (DFD crop, legend excerpt, cloud triage notes, review transcript, intake ticket, other) using the file name and visible content. If the classification is uncertain, label it `unknown`.
4. Record file status: `present` (non-empty, readable), `empty` (zero bytes), or `unreadable` (corrupted, password-protected, binary the operator cannot read).
5. For each present artifact, write a one-sentence purpose note tied to the visible content.
6. List material gaps (artifacts that the review sequence will need but are missing). Do not request invented materials beyond the v0.1.2 review-input set.
7. Write `{{output_root}}/01-input-inventory.md` with the columns: `artifact`, `status`, `classification`, `purpose`, `material_gap`.
8. Do not append to `{{output_root}}/00-run-log.md` until a human reviewer accepts the inventory.

## 7. Stop Conditions

Stop before any write if any of the following holds:

- `runs/{{run_id}}/run-profile.yaml` is missing or unreadable.
- Any required run-profile variable from Section 3 is unset, empty, or unresolvable.
- `sensitive_data_confirmed_redacted` is `false`.
- `{{input_root}}` does not exist, is empty, or contains no readable artifacts.
- Any proposed write resolves outside `{{output_root}}`.
- A read or write would touch the old reference workspace.
- A sensitive-data substring per `config/sensitive-data-rules.md` appears in any read value.
- The instruction would require running a Package 05+ skill, PRA, adapter, Jira/Confluence/Rovo/MCP connector, runtime, cloud, scoring, diagram, or release service.
- The instruction would require inventing a missing artifact, asking the requester for a new submission form, or rebaselining `{{expected_root}}`.

## 8. Unknown Handling

- Record any uncertain classification as `unknown`.
- Record any unreadable file as `unreadable` and explain briefly in the `purpose` cell what evidence (file name only) led to the row.
- Do not promote an `unknown` classification to a definite type using guesswork or cloud defaults.
- Do not invent purpose statements for artifacts that are not present.

## 9. Evidence / Run-Log Guidance

- After human acceptance, append one entry to `{{output_root}}/00-run-log.md` recording: `prompt_id: PR-RS-01`, `output: {{output_root}}/01-input-inventory.md`, accepted-by reviewer label, accepted-at timestamp (ISO 8601 UTC), and a one-line summary of inventory size and material gaps.
- Do not pre-write the run-log entry before human acceptance.
- Do not claim Jira post-back, Confluence publication, Rovo execution, or MCP execution.

## 10. Direct Prompt Test

Operator test sequence:

```
# 1. Create a folder-first test run with sample inputs copied in.
tools/New-AisrafRun.ps1 -RunId RUN-LOCAL-RS01-TEST -SampleId sample-001-dfd-crop -Mode folder_first_test -CopySampleInputs

# 2. Confirm inputs are clean and flip sensitive_data_confirmed_redacted to true,
#    then validate the profile.
tools/Test-AisrafRunProfile.ps1 -RunProfilePath runs/RUN-LOCAL-RS01-TEST/run-profile.yaml -ExecutionReady
```

- Open this card in VS Code Copilot Chat. Do not edit the prompt body. Substitute or confirm only the variables in Section 3.
- Expected local artifact: `runs/RUN-LOCAL-RS01-TEST/01-input-inventory.md`.
- PASS = artifact exists; lists every file actually present under `{{input_root}}`; marks unknowns explicitly; makes no external/runtime claim; the run-log entry is appended only after the human reviewer accepts the inventory.

## 11. Not In Scope

- No skill execution. Skill contracts are deferred to Build Package 05.
- No PRA execution. PRA specifications are deferred to Build Package 06.
- No `.agent.md` adapter execution. Adapters are deferred to Build Package 06.
- No Jira post-back, Confluence publication, Rovo execution, or MCP execution.
- No accuracy scoring (handled only by [13-accuracy-score.prompt.md](13-accuracy-score.prompt.md)).
- No diagram generation, runbook generation, or release/export.
- No runtime, cloud, or database execution.
- No request to the requester for a new submission form, new template, or external homework.
