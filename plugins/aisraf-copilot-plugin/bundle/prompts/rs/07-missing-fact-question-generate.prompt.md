---
prompt_id: PR-RS-07
prompt_name: Missing Fact And Targeted Question Generate
owning_build_package: Build Package 04
prompt_family: rs
status: active
future_skill_id: SK-MISSING-FACT-IDENTIFY and SK-TARGETED-QUESTION-GENERATE (planned; defined in Build Package 05)
future_pra_owner: PRA-MISSING-FACT-INTERVIEWER (planned; defined in Build Package 06)
review_step: RS-07-and-RS-12
---

# RS-07 / RS-12 — Missing Fact And Targeted Question Generate

## 1. Identity

- prompt_id: `PR-RS-07`
- prompt_name: Missing Fact And Targeted Question Generate
- owning_build_package: Build Package 04 — Prompts and prompt registry.
- prompt_family: `rs`
- status: `active`
- future_skill_id: `SK-MISSING-FACT-IDENTIFY` and `SK-TARGETED-QUESTION-GENERATE` (planned; defined in Build Package 05).
- future_pra_owner: `PRA-MISSING-FACT-INTERVIEWER` (planned; defined in Build Package 06).
- review_step: `RS-07-and-RS-12`

## 2. Purpose

Identify material missing facts (the unknowns that change a finding, recommendation, owner, route, or validation note) and convert them into targeted questions for the requester. Write two Markdown artifacts: `{{output_root}}/09-missing-facts.md` (the inventory of material unknowns with evidence pointers) and `{{output_root}}/12-targeted-questions.md` (a focused question list, one per material unknown, framed for a requester to answer). This prompt does not generate broad checklist-style questions, does not invent unknowns to fill quota, and does not promote an unknown into an asserted finding.

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
- `{{output_root}}/01-input-inventory.md`
- `{{output_root}}/04-components.md`
- `{{output_root}}/05-flows.md`
- `{{output_root}}/06-boundaries.md`
- `{{output_root}}/07-security-stack-assessment.md`
- `{{output_root}}/08-internal-review-table.md`

Conditional read (only when `{{expected_root}}` is non-empty and populated):

- `{{expected_root}}/expected-missing-facts.json`
- `{{expected_root}}/expected-targeted-questions.json`

These are relationship references only; do not edit baselines.

Future-package references (not required; do not stop on absence):

- `skills/SK-MISSING-FACT-IDENTIFY.md` and `skills/SK-TARGETED-QUESTION-GENERATE.md` (Build Package 05).
- `prototype-agents/PRA-MISSING-FACT-INTERVIEWER.md` (Build Package 06).
- `templates/missing-facts-template.md` and `templates/targeted-questions-template.md` (Build Package 09).

## 5. Required Output

This prompt writes exactly two artifacts:

- `{{output_root}}/09-missing-facts.md`
- `{{output_root}}/12-targeted-questions.md`

No other write path is permitted. No write outside `{{output_root}}` is permitted.

## 6. Instructions

1. Resolve every variable in Section 3 from `runs/{{run_id}}/run-profile.yaml`.
2. Read the prior outputs in Section 4. Confirm all exist and are non-empty.
3. Identify each material unknown — an `unknown` cell or row whose resolution would change a finding, recommendation, owner, route, or validation note. Skip cosmetic unknowns.
4. For `09-missing-facts.md`, list each material unknown with: `missing_id` (e.g., `M-001`), `subject` (component, flow, boundary, signal, table row, or input artifact), `subject_id` (e.g., `C-001`, `F-001`, `B-001`, `S-001`, `R-001`), `unknown_field`, `why_material` (one sentence on which downstream output would change), and `confidence_in_materiality`.
5. For `12-targeted-questions.md`, write one question per `missing_id`. Each question must be specific, name the subject and the unknown field, and be answerable by the requester without requiring the requester to author a new diagram. Use columns: `question_id` (matches `missing_id`), `audience` (requester, design owner, security owner, data owner, or `unknown`), `question_text`, and `expected_answer_shape` (what kind of answer would resolve the unknown — name, value, yes/no, link to existing doc).
6. Cross-link the two artifacts: every row in `12-targeted-questions.md` must point to a `missing_id` in `09-missing-facts.md`, and vice versa.
7. Do not generate generic "do you have authentication?" questions; tie each question to a specific subject and field.
8. Write both artifacts. Do not append to `{{output_root}}/00-run-log.md` until a human reviewer accepts both.

## 7. Stop Conditions

Stop before any write if any of the following holds:

- `runs/{{run_id}}/run-profile.yaml` is missing or unreadable.
- Any required run-profile variable from Section 3 is unset, empty, or unresolvable.
- `sensitive_data_confirmed_redacted` is `false`.
- Any prior output in Section 4 is missing or empty.
- The instruction would require generating broad checklist questions, inventing unknowns to fill quota, or asking the requester to author a new diagram.
- Any proposed write resolves outside `{{output_root}}`.
- A read or write would touch the old reference workspace.
- A sensitive-data substring per `config/sensitive-data-rules.md` is detected.
- The instruction would require claiming a Package 05+ skill / PRA / adapter / connector / runtime / scoring / diagram / release execution.

## 8. Unknown Handling

- A material unknown remains an unknown — do not promote it to an asserted finding.
- Where the materiality itself is uncertain, record `confidence_in_materiality: low` and explain in `why_material`.
- Where the audience for a question cannot be determined, record `audience: unknown`.

## 9. Evidence / Run-Log Guidance

- After human acceptance, append one entry to `{{output_root}}/00-run-log.md` recording: `prompt_id: PR-RS-07`, `outputs: {{output_root}}/09-missing-facts.md and {{output_root}}/12-targeted-questions.md`, accepted-by reviewer label, accepted-at timestamp (ISO 8601 UTC), and a one-line summary of material-unknown count and question count.
- Do not pre-write the run-log entry before human acceptance.
- Do not claim Jira post-back, Confluence publication, Rovo execution, or MCP execution.
- No question may be sent to the requester from this prompt; sending is owned by a future Build Package and requires `postback_execution_status: executed_by_operator` plus a destination URL.

## 10. Direct Prompt Test

Operator test sequence:

```
# 1. Use the run that already contains 01-input-inventory.md, 04-components.md, 05-flows.md, 06-boundaries.md, 07-security-stack-assessment.md, 08-internal-review-table.md.
tools/Test-AisrafRunProfile.ps1 -RunProfilePath runs/RUN-LOCAL-RS07-TEST/run-profile.yaml -ExecutionReady
```

- Open this card in VS Code Copilot Chat. Do not edit the prompt body. Substitute or confirm only the variables in Section 3.
- Expected local artifacts: `runs/RUN-LOCAL-RS07-TEST/09-missing-facts.md` and `runs/RUN-LOCAL-RS07-TEST/12-targeted-questions.md`.
- PASS = both artifacts exist; every missing fact is material; every question is specific and tied to a `missing_id`; no broad checklist; no external/runtime claim; run-log entry appended only after human acceptance.

## 11. Not In Scope

- No skill execution. Skill contracts are deferred to Build Package 05.
- No PRA execution. PRA specifications are deferred to Build Package 06.
- No `.agent.md` adapter execution. Adapters are deferred to Build Package 06.
- No Jira post-back, Confluence publication, Rovo execution, or MCP execution.
- No accuracy scoring (handled only by [13-accuracy-score.prompt.md](13-accuracy-score.prompt.md)).
- No diagram generation, runbook generation, or release/export.
- No runtime, cloud, or database execution.
- No sending the questions externally; that requires a later Build Package and operator-executed post-back evidence.
