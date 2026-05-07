---
prompt_id: PR-DFD-10
prompt_name: DFD Extraction Summarize
owning_build_package: Build Package 04
prompt_family: dfd
status: active
future_skill_id: SK-DFD-09-EXTRACTION-SUMMARIZE (planned; defined in Build Package 05)
future_pra_owner: PRA-DFD-EXTRACTOR (planned; defined in Build Package 06)
dfd_step: DFD-09
---

# DFD-09 — Extraction Summarize

## 1. Identity

- prompt_id: `PR-DFD-10`
- prompt_name: DFD Extraction Summarize
- owning_build_package: Build Package 04 — Prompts and prompt registry.
- prompt_family: `dfd`
- status: `active`
- future_skill_id: `SK-DFD-09-EXTRACTION-SUMMARIZE` (planned; defined in Build Package 05).
- future_pra_owner: `PRA-DFD-EXTRACTOR` (planned; defined in Build Package 06).
- dfd_step: `DFD-09`

## 2. Purpose

Summarize the DFD extraction state at the end of the DFD subskill chain and describe residual gaps that downstream RS prompts should be aware of. Write `{{output_root}}/dfd/09-extraction-summary.md`. The summary records counts of boundaries, components, flows, annotations, crossings, control signals, and confidence-scored rows, plus a short narrative of what the operator could and could not extract. This prompt does not duplicate prior outputs, does not score against a baseline, and does not record findings or recommendations.

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
- `{{output_root}}/dfd/02-boundary-catalog.md`
- `{{output_root}}/dfd/03-component-catalog.md`
- `{{output_root}}/dfd/04-flow-inventory.md`
- `{{output_root}}/dfd/05-annotation-resolution.md`
- `{{output_root}}/dfd/06-boundary-crossings.md`
- `{{output_root}}/dfd/07-control-signals.md`
- `{{output_root}}/dfd/08-confidence-score.md`

Future-package references (not required; do not stop on absence):

- `skills/SK-DFD-09-EXTRACTION-SUMMARIZE.md` (Build Package 05).
- `prototype-agents/PRA-DFD-EXTRACTOR.md` (Build Package 06).
- `templates/dfd-extraction-summary-template.md` (Build Package 09).

## 5. Required Output

This prompt writes exactly one artifact:

- `{{output_root}}/dfd/09-extraction-summary.md`

No other write path is permitted. No write outside `{{output_root}}` is permitted.

## 6. Instructions

1. Resolve every variable in Section 3 from `runs/{{run_id}}/run-profile.yaml`.
2. Read the eight prior DFD outputs in Section 4. Confirm all are non-empty.
3. Build a Markdown document with these sections in order: `Intake Decision` (link to `dfd/01-intake-quality-check.md` and restate the intake decision), `Counts` (boundary count, component count, flow count, annotation count, crossing count, control signal count, confidence row count, total `unknown` cells across DFD outputs), `Residual Gaps` (one bullet per material gap referencing prior `unknown` rows or `material` low-confidence rows), `Limits` (one paragraph on what the DFD source allowed and did not allow), and `Posture` (state `output_destination_mode`, `postback_execution_status`, and explicitly that this summary is local-only and that no scoring against `{{expected_root}}` has been performed in this prompt).
4. Do not duplicate the body of prior outputs. Reference them by path.
5. Do not produce findings, recommendations, targeted questions, or accuracy scores; later RS prompts handle those.
6. Write `{{output_root}}/dfd/09-extraction-summary.md`. Do not append to `{{output_root}}/00-run-log.md` until a human reviewer accepts the summary.

## 7. Stop Conditions

Stop before any write if any of the following holds:

- `runs/{{run_id}}/run-profile.yaml` is missing or unreadable.
- Any required run-profile variable from Section 3 is unset, empty, or unresolvable.
- `sensitive_data_confirmed_redacted` is `false`.
- Any prior DFD output in Section 4 is missing or empty.
- The instruction would require duplicating prior outputs or performing accuracy scoring against `{{expected_root}}`.
- Any proposed write resolves outside `{{output_root}}`.
- A read or write would touch the old reference workspace.
- A sensitive-data substring per `config/sensitive-data-rules.md` is detected.
- The instruction would require claiming a Package 05+ skill / PRA / adapter / connector / runtime / scoring / diagram / release execution.

## 8. Unknown Handling

- Preserve `unknown` from prior DFD outputs as `unknown` in the counts.
- Where a residual gap's materiality is uncertain, record it under `Residual Gaps` with `materiality: unknown`.

## 9. Evidence / Run-Log Guidance

- After human acceptance, append one entry to `{{output_root}}/00-run-log.md` recording: `prompt_id: PR-DFD-10`, `output: {{output_root}}/dfd/09-extraction-summary.md`, accepted-by reviewer label, accepted-at timestamp (ISO 8601 UTC), and a one-line summary of total rows and residual-gap count.
- Do not pre-write the run-log entry before human acceptance.
- Do not claim Jira post-back, Confluence publication, Rovo execution, or MCP execution.

## 10. Direct Prompt Test

Operator test sequence:

```
# 1. Use the run that already contains dfd/01..08 outputs.
tools/Test-AisrafRunProfile.ps1 -RunProfilePath runs/RUN-LOCAL-DFD09-TEST/run-profile.yaml -ExecutionReady
```

- Open this card in VS Code Copilot Chat. Do not edit the prompt body. Substitute or confirm only the variables in Section 3.
- Expected local artifact: `runs/RUN-LOCAL-DFD09-TEST/dfd/09-extraction-summary.md`.
- PASS = artifact exists; counts add up across prior DFD outputs; residual gaps reference prior `unknown` rows or material low-confidence rows; no duplication of prior content; no accuracy claim; no external/runtime claim; run-log entry appended only after human acceptance.

## 11. Not In Scope

- No skill execution. Skill contracts are deferred to Build Package 05.
- No PRA execution. PRA specifications are deferred to Build Package 06.
- No `.agent.md` adapter execution. Adapters are deferred to Build Package 06.
- No Jira post-back, Confluence publication, Rovo execution, or MCP execution.
- No accuracy scoring against `{{expected_root}}` (handled only by [../rs/13-accuracy-score.prompt.md](../rs/13-accuracy-score.prompt.md)).
- No diagram generation, runbook generation, or release/export.
- No runtime, cloud, or database execution.
- No new findings, recommendations, or targeted questions.
