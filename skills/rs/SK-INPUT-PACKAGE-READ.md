---
skill_id: SK-INPUT-PACKAGE-READ
skill_name: Input Package Read
owning_build_package: Build Package 05
skill_family: rs
status: active
mapped_prompt_id: PR-RS-01
mapped_prompt_file: prompts/rs/01-input-package-read.prompt.md
future_pra_owner: PRA-INTAKE (planned; defined in Build Package 06)
review_step: RS-01
---

# SK-INPUT-PACKAGE-READ — Input Package Read

## 1. Identity

- skill_id: `SK-INPUT-PACKAGE-READ`
- skill_name: Input Package Read
- owning_build_package: Build Package 05 — Skills and skill registry.
- skill_family: `rs`
- status: `active`
- mapped_prompt_id: `PR-RS-01`
- mapped_prompt_file: [prompts/rs/01-input-package-read.prompt.md](../../prompts/rs/01-input-package-read.prompt.md)
- future_pra_owner: `PRA-INTAKE` (planned; defined in Build Package 06).
- review_step: `RS-01`

## 2. Purpose

Inventory the review materials staged under `{{input_root}}` so downstream RS skills know which artifacts are present, which are missing, and which gaps are material for the rest of the chain. The skill produces a single Markdown inventory describing each received artifact and any required artifact that is missing, without inventing inputs, requesting new requester forms, or modifying source files. It does not extract DFD facts, classify findings, or score outputs.

## 3. Required Inputs

- `runs/{{run_id}}/run-profile.yaml` — resolved run-profile.
- `{{input_root}}/` — every file present at the top level of the staged input folder.
- `config/run-profile.validation-rules.md`
- `config/path-resolution-rules.md`
- `config/sensitive-data-rules.md`

## 4. Optional Inputs

- `runs/{{run_id}}/README.md` — operator notes about the run, if present.
- `runs/{{run_id}}/inputs/README.md` — inputs README, if present.
- `{{expected_root}}/expected-input-inventory.json` — used as a relationship reference only when the file exists; not required for the skill to produce an inventory.

## 5. Required Outputs

This skill produces exactly one artifact under `{{output_root}}`:

- `{{output_root}}/01-input-inventory.md` — Markdown inventory with the columns: `artifact`, `status`, `classification`, `purpose`, `material_gap`.

No other write path is permitted. No write outside `{{output_root}}` is permitted.

## 6. Procedure

1. Resolve every required run-profile variable from `runs/{{run_id}}/run-profile.yaml`. Use the seven canonical v0.1.2 variables: `{{run_id}}`, `{{input_root}}`, `{{expected_root}}`, `{{output_root}}`, `{{mode}}`, `{{postback_execution_status}}`, `{{output_destination_mode}}`.
2. List the contents of `{{input_root}}/` (top level only).
3. Classify each entry as `dfd_source`, `legend_excerpt`, `cloud_triage_note`, `review_transcript`, `intake_ticket`, or `unknown` using only the file name and visible content.
4. Record the file `status` as `present`, `empty`, or `unreadable`. Do not promote `unreadable` to a content judgment.
5. Write a one-sentence `purpose` for each present artifact tied to visible content. For `empty` and `unreadable` rows, leave the purpose explicit about why no purpose was established.
6. List `material_gap` entries for required artifact classes that are missing from the inventory. Do not invent additional required classes beyond the v0.1.2 review-input set.
7. Write `{{output_root}}/01-input-inventory.md` using the column contract in Section 5.
8. Stop before writing if any Section 7 stop condition holds.

## 7. Stop Conditions

Stop the skill before writing the output if any of the following holds:

- `runs/{{run_id}}/run-profile.yaml` is missing or unreadable.
- Any required run-profile variable is unset, empty, or unresolvable.
- `sensitive_data_confirmed_redacted` is `false`.
- `{{input_root}}` does not exist, is empty, or contains no readable artifact.
- A read or write would touch the old reference workspace.
- Any proposed write resolves outside `{{output_root}}`.
- A sensitive-data substring per `config/sensitive-data-rules.md` is detected.
- The work would require running a Package 05+ skill, PRA, adapter, Jira/Confluence/Rovo/MCP connector, runtime, cloud, scoring, diagram, or release service.
- The work would require inventing a missing artifact, asking the requester for a new submission form, or rebaselining `{{expected_root}}`.

## 8. Unknown Handling

- Any uncertain classification is recorded as `unknown` and not promoted by guesswork.
- Any unreadable file is recorded as `unreadable` with a brief reason tied to the file name only.
- Missing required artifacts are listed under `material_gap`. They are not silently filled in.
- An `unknown` classification is never promoted to a definite classification using cloud defaults, naming-only inference, or assumption.

## 9. Confidence Handling

- `present` rows with a clearly classified file carry implicit `HIGH` confidence in the inventory's classification step.
- `present` rows with `classification: unknown` carry `MEDIUM` confidence and must keep `unknown` until later RS skills supply support.
- `empty` and `unreadable` rows carry `LOW` confidence and may not be cited as evidence by later RS skills.
- The skill never assigns a numeric inventory score. Numeric scoring is owned exclusively by `SK-ACCURACY-SCORE` (RS-17).

## 10. Critical Misses

- Inventing an artifact that is not staged under `{{input_root}}`.
- Listing a required gap as `received` to lower the missing count.
- Writing the inventory outside `{{output_root}}`.
- Asking the requester for a new submission form or generating a fresh requester template.
- Rebaselining or editing any file under `{{expected_root}}`.

## 11. Human Review Gate

The SAS reviewer must inspect:

- Every `present` row maps to a real file under `{{input_root}}`.
- Every `material_gap` row reflects an actual missing artifact and not a checklist gap.
- No requester homework or new requester form is implied.
- Sensitive-material rejection (if any) was honored before write.

The output is not accepted until the reviewer signs off.

## 12. Validation / Scoring Relationship

- Expected baseline (when present): `{{expected_root}}/expected-input-inventory.json` (planned; defined in Build Package 10).
- Scoring category: input inventory completeness (10 points within `SK-ACCURACY-SCORE`).
- Critical-miss conditions in Section 10 force a FAIL on `SK-ACCURACY-SCORE` regardless of numeric score.
- The skill produces no score field of its own.

## 13. Direct Skill Test

The skill is exercised by its mapped prompt card.

```
tools/New-AisrafRun.ps1 -RunId RUN-LOCAL-SK-INPUT-TEST -SampleId sample-001-dfd-crop -Mode folder_first_test -CopySampleInputs
tools/Test-AisrafRunProfile.ps1 -RunProfilePath runs/RUN-LOCAL-SK-INPUT-TEST/run-profile.yaml -ExecutionReady
```

- Open [prompts/rs/01-input-package-read.prompt.md](../../prompts/rs/01-input-package-read.prompt.md) in VS Code Copilot Chat against the resolved run profile.
- Expected local output: `runs/RUN-LOCAL-SK-INPUT-TEST/01-input-inventory.md`.
- PASS = output exists; columns match Section 5; every `present` row corresponds to a real file under `{{input_root}}`; every missing required artifact appears under `material_gap`; no critical miss in Section 10.

## 14. Not In Scope

- No executable runtime behavior. The skill is a contract, not a tool.
- No PRA execution. PRA specifications are deferred to Build Package 06.
- No `.agent.md` adapter execution. Adapters are deferred to Build Package 06.
- No Jira post-back, Confluence publication, Rovo execution, or MCP execution.
- No runtime, cloud, database, Terraform, or ADK execution.
- No diagram generation, runbook generation, or release/export.
- No accuracy scoring (owned exclusively by `SK-ACCURACY-SCORE`).
- Reference catalogs are noted only as `(planned; defined in Build Package 07)` and are never required hard reads at this stage.
