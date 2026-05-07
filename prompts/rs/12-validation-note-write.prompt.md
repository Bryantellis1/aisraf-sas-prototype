---
prompt_id: PR-RS-12
prompt_name: Validation Note Write
owning_build_package: Build Package 04
prompt_family: rs
status: active
future_skill_id: SK-VALIDATION-NOTE-WRITE (planned; defined in Build Package 05)
future_pra_owner: PRA-VALIDATION-NOTE-WRITER (planned; defined in Build Package 06)
review_step: RS-13
---

# RS-12 (RS Output 16) — Validation Note Write

## 1. Identity

- prompt_id: `PR-RS-12`
- prompt_name: Validation Note Write
- owning_build_package: Build Package 04 — Prompts and prompt registry.
- prompt_family: `rs`
- status: `active`
- future_skill_id: `SK-VALIDATION-NOTE-WRITE` (planned; defined in Build Package 05).
- future_pra_owner: `PRA-VALIDATION-NOTE-WRITER` (planned; defined in Build Package 06).
- review_step: `RS-13`

## 2. Purpose

Write validation notes that document the validator's view of the run, kept separate from findings and recommendations. Validation notes describe method limits, residual unknowns, drift risks, and any operator concerns that future scoring or reviewers should be aware of. Write `{{output_root}}/16-validation-notes.md`. This prompt does not duplicate the findings, does not score against a baseline, and does not claim that issues have been resolved.

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
- `validation/no-drift-rules.md`
- `{{output_root}}/08-internal-review-table.md`
- `{{output_root}}/09-missing-facts.md`
- `{{output_root}}/10-ai-action-level.md`
- `{{output_root}}/12-targeted-questions.md`
- `{{output_root}}/13-findings.md`
- `{{output_root}}/14-recommendations.md`

Conditional read (only when `{{expected_root}}` is non-empty and populated):

- `{{expected_root}}/expected-validation-notes.md`

This is a relationship reference only; do not edit the baseline.

Future-package references (not required; do not stop on absence):

- `skills/SK-VALIDATION-NOTE-WRITE.md` (Build Package 05).
- `prototype-agents/PRA-VALIDATION-NOTE-WRITER.md` (Build Package 06).
- `templates/validation-notes-template.md` (Build Package 09).

## 5. Required Output

This prompt writes exactly one artifact:

- `{{output_root}}/16-validation-notes.md`

No other write path is permitted. No write outside `{{output_root}}` is permitted.

## 6. Instructions

1. Resolve every variable in Section 3 from `runs/{{run_id}}/run-profile.yaml`.
2. Read the prior outputs in Section 4. Confirm all are non-empty.
3. Write a Markdown document with these sections: `Method Limits` (what the run could and could not see, including DFD readability and legend completeness), `Residual Unknowns` (material unknowns that remain after `09-missing-facts.md` and `12-targeted-questions.md`), `Drift Risks` (places where future runs could drift if catalogs, blueprints, or templates change later), `Validator Concerns` (one-line concerns about findings or recommendations that are still under-evidenced), and `Acceptance Posture` (state the human gate accepted the per-step outputs and that this run is in `{{mode}}` with `output_destination_mode: {{output_destination_mode}}` and `postback_execution_status: {{postback_execution_status}}`).
4. Do not duplicate the findings text. Reference `13-findings.md` and `14-recommendations.md` by file path.
5. Do not assert that a finding has been resolved or accepted by the requester.
6. Write `{{output_root}}/16-validation-notes.md`. Do not append to `{{output_root}}/00-run-log.md` until a human reviewer accepts the notes.

## 7. Stop Conditions

Stop before any write if any of the following holds:

- `runs/{{run_id}}/run-profile.yaml` is missing or unreadable.
- Any required run-profile variable from Section 3 is unset, empty, or unresolvable.
- `sensitive_data_confirmed_redacted` is `false`.
- Any prior output in Section 4 is missing or empty.
- The instruction would require asserting that an unknown has been resolved without supporting evidence.
- Any proposed write resolves outside `{{output_root}}`.
- A read or write would touch the old reference workspace.
- A sensitive-data substring per `config/sensitive-data-rules.md` is detected.
- The instruction would require claiming a Package 05+ skill / PRA / adapter / connector / runtime / scoring / diagram / release execution.

## 8. Unknown Handling

- Preserve `unknown` from prior outputs as `unknown` in the validation notes.
- Where a validator concern is itself uncertain, mark `confidence: low` in the note row.

## 9. Evidence / Run-Log Guidance

- After human acceptance, append one entry to `{{output_root}}/00-run-log.md` recording: `prompt_id: PR-RS-12`, `output: {{output_root}}/16-validation-notes.md`, accepted-by reviewer label, accepted-at timestamp (ISO 8601 UTC), and a one-line summary of method-limit count, drift-risk count, and validator-concern count.
- Do not pre-write the run-log entry before human acceptance.
- Do not claim Jira post-back, Confluence publication, Rovo execution, or MCP execution.

## 10. Direct Prompt Test

Operator test sequence:

```
# 1. Use the run that already contains 08-internal-review-table.md through 14-recommendations.md.
tools/Test-AisrafRunProfile.ps1 -RunProfilePath runs/RUN-LOCAL-RS12-TEST/run-profile.yaml -ExecutionReady
```

- Open this card in VS Code Copilot Chat. Do not edit the prompt body. Substitute or confirm only the variables in Section 3.
- Expected local artifact: `runs/RUN-LOCAL-RS12-TEST/16-validation-notes.md`.
- PASS = artifact exists; sections are present and ordered as in Section 6; preserves prior `unknown` entries; does not duplicate findings text; no external/runtime claim; run-log entry appended only after human acceptance.

## 11. Not In Scope

- No skill execution. Skill contracts are deferred to Build Package 05.
- No PRA execution. PRA specifications are deferred to Build Package 06.
- No `.agent.md` adapter execution. Adapters are deferred to Build Package 06.
- No Jira post-back, Confluence publication, Rovo execution, or MCP execution.
- No accuracy scoring (handled only by [13-accuracy-score.prompt.md](13-accuracy-score.prompt.md)).
- No diagram generation, runbook generation, or release/export.
- No runtime, cloud, or database execution.
- No new findings, no new recommendations, no new questions, no new missing facts.
