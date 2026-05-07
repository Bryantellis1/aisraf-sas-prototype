---
prompt_id: PR-RS-08
prompt_name: AI Action Level Classify
owning_build_package: Build Package 04
prompt_family: rs
status: active
future_skill_id: SK-AI-ACTION-LEVEL-CLASSIFY (planned; defined in Build Package 05)
future_pra_owner: PRA-AI-CLASSIFIER (planned; defined in Build Package 06)
review_step: RS-08
---

# RS-08 — AI Action Level Classify

## 1. Identity

- prompt_id: `PR-RS-08`
- prompt_name: AI Action Level Classify
- owning_build_package: Build Package 04 — Prompts and prompt registry.
- prompt_family: `rs`
- status: `active`
- future_skill_id: `SK-AI-ACTION-LEVEL-CLASSIFY` (planned; defined in Build Package 05).
- future_pra_owner: `PRA-AI-CLASSIFIER` (planned; defined in Build Package 06).
- review_step: `RS-08`

## 2. Purpose

Classify the AI Action Level of the design under review using only supported flow and table evidence. Write `{{output_root}}/10-ai-action-level.md`. The classification is a single level (typically: `informational`, `assistive`, `recommending`, `acting_with_human_approval`, `acting_autonomously`, or `unknown`) plus a justification grounded in specific row IDs from the internal review table. This prompt does not invent capabilities the source does not show, does not assert runtime behavior, and does not promote `unknown` into a confident classification.

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
- `{{output_root}}/08-internal-review-table.md`

Conditional read (only when `{{expected_root}}` is non-empty and populated):

- `{{expected_root}}/expected-ai-action-level.json`

This is a relationship reference only; do not edit the baseline.

Future-package references (not required; do not stop on absence):

- `skills/SK-AI-ACTION-LEVEL-CLASSIFY.md` (Build Package 05).
- `prototype-agents/PRA-AI-CLASSIFIER.md` (Build Package 06).
- `catalogs/ai-action-level-catalog.yaml` (Build Package 07).
- `templates/ai-action-level-template.md` (Build Package 09).

## 5. Required Output

This prompt writes exactly one artifact:

- `{{output_root}}/10-ai-action-level.md`

No other write path is permitted. No write outside `{{output_root}}` is permitted.

## 6. Instructions

1. Resolve every variable in Section 3 from `runs/{{run_id}}/run-profile.yaml`.
2. Read the three prior outputs in Section 4. Confirm all are non-empty.
3. Identify components and flows that exhibit AI behavior (model endpoint, agent, tool/API orchestration, autonomous decision, human approval loop). Use only supported evidence — visible labels, normalized legend tokens, and row entries.
4. Choose one classification: `informational`, `assistive`, `recommending`, `acting_with_human_approval`, `acting_autonomously`, or `unknown`.
5. Justify the classification with: (a) the chosen level, (b) at least two supporting row IDs from `08-internal-review-table.md` or supporting component/flow IDs, (c) an explicit list of what would need to be true to escalate to the next level, and (d) the residual unknowns blocking confidence.
6. If no AI behavior is supported by the source, classify as `not_applicable` and explain.
7. Write `{{output_root}}/10-ai-action-level.md` with the structure: `classification`, `justification`, `supporting_evidence`, `escalation_conditions`, `residual_unknowns`, `confidence`.
8. Do not append to `{{output_root}}/00-run-log.md` until a human reviewer accepts the classification.

## 7. Stop Conditions

Stop before any write if any of the following holds:

- `runs/{{run_id}}/run-profile.yaml` is missing or unreadable.
- Any required run-profile variable from Section 3 is unset, empty, or unresolvable.
- `sensitive_data_confirmed_redacted` is `false`.
- Any prior output in Section 4 is missing or empty.
- The classification would require asserting runtime AI behavior, autonomous decision-making, or human-in-the-loop controls that the source does not show.
- Any proposed write resolves outside `{{output_root}}`.
- A read or write would touch the old reference workspace.
- A sensitive-data substring per `config/sensitive-data-rules.md` is detected.
- The instruction would require claiming a Package 05+ skill / PRA / adapter / connector / runtime / scoring / diagram / release execution.

## 8. Unknown Handling

- Where supporting evidence is partial, classify as `unknown` and list the residual unknowns blocking confidence.
- Do not pick a higher classification than the source supports to "be safe"; record `confidence: low` instead.
- Do not import AI Action Level definitions from external models — Build Package 07 will provide a controlled catalog later.

## 9. Evidence / Run-Log Guidance

- After human acceptance, append one entry to `{{output_root}}/00-run-log.md` recording: `prompt_id: PR-RS-08`, `output: {{output_root}}/10-ai-action-level.md`, accepted-by reviewer label, accepted-at timestamp (ISO 8601 UTC), and a one-line summary of classification and confidence.
- Do not pre-write the run-log entry before human acceptance.
- Do not claim Jira post-back, Confluence publication, Rovo execution, or MCP execution.

## 10. Direct Prompt Test

Operator test sequence:

```
# 1. Use the run that already contains 04-components.md, 05-flows.md, 08-internal-review-table.md.
tools/Test-AisrafRunProfile.ps1 -RunProfilePath runs/RUN-LOCAL-RS08-TEST/run-profile.yaml -ExecutionReady
```

- Open this card in VS Code Copilot Chat. Do not edit the prompt body. Substitute or confirm only the variables in Section 3.
- Expected local artifact: `runs/RUN-LOCAL-RS08-TEST/10-ai-action-level.md`.
- PASS = artifact exists; classification is one of the allowed values; justification cites at least two row or component/flow IDs; residual unknowns are explicit; no external/runtime claim; run-log entry appended only after human acceptance.

## 11. Not In Scope

- No skill execution. Skill contracts are deferred to Build Package 05.
- No PRA execution. PRA specifications are deferred to Build Package 06.
- No `.agent.md` adapter execution. Adapters are deferred to Build Package 06.
- No Jira post-back, Confluence publication, Rovo execution, or MCP execution.
- No accuracy scoring (handled only by [13-accuracy-score.prompt.md](13-accuracy-score.prompt.md)).
- No diagram generation, runbook generation, or release/export.
- No runtime, cloud, or database execution.
- No blueprint matching, finding writing, recommendation writing, handoff packaging, or validation note work (later RS cards own those).
