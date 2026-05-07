---
prompt_id: PR-DFD-09
prompt_name: DFD Confidence Score
owning_build_package: Build Package 04
prompt_family: dfd
status: active
future_skill_id: SK-DFD-08-CONFIDENCE-SCORE (planned; defined in Build Package 05)
future_pra_owner: PRA-DFD-EXTRACTOR (planned; defined in Build Package 06)
dfd_step: DFD-08
---

# DFD-08 — Confidence Score

## 1. Identity

- prompt_id: `PR-DFD-09`
- prompt_name: DFD Confidence Score
- owning_build_package: Build Package 04 — Prompts and prompt registry.
- prompt_family: `dfd`
- status: `active`
- future_skill_id: `SK-DFD-08-CONFIDENCE-SCORE` (planned; defined in Build Package 05).
- future_pra_owner: `PRA-DFD-EXTRACTOR` (planned; defined in Build Package 06).
- dfd_step: `DFD-08`

## 2. Purpose

Assign a per-row extraction confidence to each visible fact produced by the prior DFD subskills. Write `{{output_root}}/dfd/08-confidence-score.md`. The output records, for each boundary, component, flow, annotation, crossing, and control signal, the operator's confidence in the extraction (`high`, `medium`, `low`, or `unknown`) along with a brief reason. This is **not** an accuracy score against a baseline — accuracy scoring is the responsibility of [../rs/13-accuracy-score.prompt.md](../rs/13-accuracy-score.prompt.md). This prompt does not edit prior outputs and does not promote a low-confidence row to high without supporting evidence.

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
- `{{output_root}}/dfd/05-annotation-resolution.md`
- `{{output_root}}/dfd/06-boundary-crossings.md`
- `{{output_root}}/dfd/07-control-signals.md`

Future-package references (not required; do not stop on absence):

- `skills/SK-DFD-08-CONFIDENCE-SCORE.md` (Build Package 05).
- `prototype-agents/PRA-DFD-EXTRACTOR.md` (Build Package 06).
- `templates/dfd-confidence-score-template.md` (Build Package 09).

## 5. Required Output

This prompt writes exactly one artifact:

- `{{output_root}}/dfd/08-confidence-score.md`

No other write path is permitted. No write outside `{{output_root}}` is permitted.

## 6. Instructions

1. Resolve every variable in Section 3 from `runs/{{run_id}}/run-profile.yaml`.
2. Read the six prior outputs in Section 4. Confirm all are non-empty.
3. For each row across the prior outputs, record: `source_artifact` (the prior output filename), `row_id` (e.g., `B-001`, `C-001`, `F-001`, `X-001`, `CS-001`, or annotation token), `extraction_confidence` (`high`, `medium`, `low`, or `unknown`), `confidence_reason` (one short phrase such as "label clearly visible," "partial occlusion," "legend missing," "ambiguous shape," "unknown component endpoint"), and `materiality` (`material` if a low confidence row would change a downstream RS finding or recommendation, otherwise `cosmetic`).
4. Do not edit prior outputs from this prompt. Confidence values may differ from per-row confidence in the source artifact; this prompt's value reflects the operator's overall judgment in context.
5. Add a summary block: total rows, count by `extraction_confidence`, and count of `material` low-confidence rows.
6. Write `{{output_root}}/dfd/08-confidence-score.md`. Do not append to `{{output_root}}/00-run-log.md` until a human reviewer accepts the score.

## 7. Stop Conditions

Stop before any write if any of the following holds:

- `runs/{{run_id}}/run-profile.yaml` is missing or unreadable.
- Any required run-profile variable from Section 3 is unset, empty, or unresolvable.
- `sensitive_data_confirmed_redacted` is `false`.
- Any of the six prior outputs is missing or empty.
- The instruction would require editing a prior output, performing accuracy scoring against `{{expected_root}}`, or claiming a Package 05+ skill / PRA / adapter / connector / runtime / scoring / diagram / release execution.
- Any proposed write resolves outside `{{output_root}}`.
- A read or write would touch the old reference workspace.
- A sensitive-data substring per `config/sensitive-data-rules.md` is detected.

## 8. Unknown Handling

- Where the operator cannot judge confidence for a row, record `extraction_confidence: unknown` and explain in `confidence_reason`.
- Where materiality is itself uncertain, record `materiality: unknown` rather than `material` or `cosmetic`.
- Do not promote `low` to `medium` or `medium` to `high` without supporting reason.

## 9. Evidence / Run-Log Guidance

- After human acceptance, append one entry to `{{output_root}}/00-run-log.md` recording: `prompt_id: PR-DFD-09`, `output: {{output_root}}/dfd/08-confidence-score.md`, accepted-by reviewer label, accepted-at timestamp (ISO 8601 UTC), and a one-line summary of total rows, low-confidence count, and material-low count.
- Do not pre-write the run-log entry before human acceptance.
- Do not claim Jira post-back, Confluence publication, Rovo execution, or MCP execution.
- Do not record this output as an accuracy score against a baseline.

## 10. Direct Prompt Test

Operator test sequence:

```
# 1. Use the run that already contains dfd/02..07 outputs.
tools/Test-AisrafRunProfile.ps1 -RunProfilePath runs/RUN-LOCAL-DFD08-TEST/run-profile.yaml -ExecutionReady
```

- Open this card in VS Code Copilot Chat. Do not edit the prompt body. Substitute or confirm only the variables in Section 3.
- Expected local artifact: `runs/RUN-LOCAL-DFD08-TEST/dfd/08-confidence-score.md`.
- PASS = artifact exists; every row references a `source_artifact` and `row_id` from prior DFD outputs; confidence and materiality cells are explicit; summary counts add up; no accuracy claim against `{{expected_root}}`; no external/runtime claim; run-log entry appended only after human acceptance.

## 11. Not In Scope

- No skill execution. Skill contracts are deferred to Build Package 05.
- No PRA execution. PRA specifications are deferred to Build Package 06.
- No `.agent.md` adapter execution. Adapters are deferred to Build Package 06.
- No Jira post-back, Confluence publication, Rovo execution, or MCP execution.
- No accuracy scoring against `{{expected_root}}` (handled only by [../rs/13-accuracy-score.prompt.md](../rs/13-accuracy-score.prompt.md)).
- No diagram generation, runbook generation, or release/export.
- No runtime, cloud, or database execution.
- No editing of prior DFD outputs from this prompt.
