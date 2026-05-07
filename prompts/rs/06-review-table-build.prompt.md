---
prompt_id: PR-RS-06
prompt_name: Internal Review Table Build
owning_build_package: Build Package 04
prompt_family: rs
status: active
future_skill_id: SK-DATA-FLOW-TABLE-BUILD (planned; defined in Build Package 05)
future_pra_owner: PRA-REVIEW-TABLE-BUILDER (planned; defined in Build Package 06)
review_step: RS-06
---

# RS-06 — Internal Review Table Build

## 1. Identity

- prompt_id: `PR-RS-06`
- prompt_name: Internal Review Table Build
- owning_build_package: Build Package 04 — Prompts and prompt registry.
- prompt_family: `rs`
- status: `active`
- future_skill_id: `SK-DATA-FLOW-TABLE-BUILD` (planned; defined in Build Package 05).
- future_pra_owner: `PRA-REVIEW-TABLE-BUILDER` (planned; defined in Build Package 06).
- review_step: `RS-06`

## 2. Purpose

Combine the prior RS outputs (components, flows, boundaries, security-stack signals) into a single internal review table at `{{output_root}}/08-internal-review-table.md`. The table is the structured backbone for later AI Action Level classification, blueprint matching, and findings. This prompt does not invent rows, does not assert controls, and does not score against a baseline.

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
- `{{output_root}}/04-components.md`
- `{{output_root}}/05-flows.md`
- `{{output_root}}/06-boundaries.md`
- `{{output_root}}/07-security-stack-assessment.md`

Conditional read (only when `{{expected_root}}` is non-empty and populated):

- `{{expected_root}}/expected-review-table.json`

This is a relationship reference only; do not edit the baseline.

Future-package references (not required; do not stop on absence):

- `skills/SK-DATA-FLOW-TABLE-BUILD.md` (Build Package 05).
- `prototype-agents/PRA-REVIEW-TABLE-BUILDER.md` (Build Package 06).
- `catalogs/dfd/component-type-catalog.yaml`, `catalogs/dfd/boundary-type-catalog.yaml`, `catalogs/dfd/security-stack-marker-catalog.yaml` (Build Package 07).
- `templates/internal-review-table-template.md` (Build Package 09).

## 5. Required Output

This prompt writes exactly one artifact:

- `{{output_root}}/08-internal-review-table.md`

No other write path is permitted. No write outside `{{output_root}}` is permitted.

## 6. Instructions

1. Resolve every variable in Section 3 from `runs/{{run_id}}/run-profile.yaml`.
2. Read the four prior outputs in Section 4. Confirm all exist and are non-empty.
3. Build one row per supported flow with the columns: `row_id` (e.g., `R-001`), `from_component`, `to_component`, `boundary_crossed` (boundary ID or `none`), `payload_visible`, `transport_visible`, `auth_signal` (signal ID or `unknown`), `encryption_signal` (signal ID or `unknown`), `logging_signal` (signal ID or `unknown`), `confidence`, and `notes`.
4. Do not invent rows for flows that do not appear in `05-flows.md`. Do not invent boundaries that do not appear in `06-boundaries.md`. Do not invent control signals that do not appear in `07-security-stack-assessment.md`.
5. Mark every unsupported cell as `unknown`. Do not infer auth, encryption, or logging from defaults.
6. Add a "limits" footnote describing rows whose evidence is partial.
7. Write `{{output_root}}/08-internal-review-table.md`. Do not append to `{{output_root}}/00-run-log.md` until a human reviewer accepts the table.

## 7. Stop Conditions

Stop before any write if any of the following holds:

- `runs/{{run_id}}/run-profile.yaml` is missing or unreadable.
- Any required run-profile variable from Section 3 is unset, empty, or unresolvable.
- `sensitive_data_confirmed_redacted` is `false`.
- Any of the four prior outputs is missing or empty.
- A row would require inventing a flow, boundary, or signal that does not exist in the prior outputs.
- Any proposed write resolves outside `{{output_root}}`.
- A read or write would touch the old reference workspace.
- A sensitive-data substring per `config/sensitive-data-rules.md` is detected.
- The instruction would require asserting runtime controls or claiming a Package 05+ skill / PRA / adapter / connector / runtime / scoring / diagram / release execution.

## 8. Unknown Handling

- Mark any unsupported cell as `unknown`.
- Record `confidence: low` for rows where two or more cells are `unknown`.
- Do not collapse two flows into one row to reduce unknown counts.

## 9. Evidence / Run-Log Guidance

- After human acceptance, append one entry to `{{output_root}}/00-run-log.md` recording: `prompt_id: PR-RS-06`, `output: {{output_root}}/08-internal-review-table.md`, accepted-by reviewer label, accepted-at timestamp (ISO 8601 UTC), and a one-line summary of row count and unknown-cell count.
- Do not pre-write the run-log entry before human acceptance.
- Do not claim Jira post-back, Confluence publication, Rovo execution, or MCP execution.

## 10. Direct Prompt Test

Operator test sequence:

```
# 1. Use the run that already contains 04-components.md, 05-flows.md, 06-boundaries.md, 07-security-stack-assessment.md.
tools/Test-AisrafRunProfile.ps1 -RunProfilePath runs/RUN-LOCAL-RS06-TEST/run-profile.yaml -ExecutionReady
```

- Open this card in VS Code Copilot Chat. Do not edit the prompt body. Substitute or confirm only the variables in Section 3.
- Expected local artifact: `runs/RUN-LOCAL-RS06-TEST/08-internal-review-table.md`.
- PASS = artifact exists; every row references prior-output IDs only; unknowns marked explicitly; no external/runtime claim; run-log entry appended only after human acceptance.

## 11. Not In Scope

- No skill execution. Skill contracts are deferred to Build Package 05.
- No PRA execution. PRA specifications are deferred to Build Package 06.
- No `.agent.md` adapter execution. Adapters are deferred to Build Package 06.
- No Jira post-back, Confluence publication, Rovo execution, or MCP execution.
- No accuracy scoring (handled only by [13-accuracy-score.prompt.md](13-accuracy-score.prompt.md)).
- No diagram generation, runbook generation, or release/export.
- No runtime, cloud, or database execution.
- No missing facts, targeted questions, AI Action Level, blueprint, finding, recommendation, handoff, validation note, or scoring work (later RS cards own those).
