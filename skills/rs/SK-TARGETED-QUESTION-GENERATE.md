---
skill_id: SK-TARGETED-QUESTION-GENERATE
skill_name: Targeted Question Generate
owning_build_package: Build Package 05
skill_family: rs
status: active
mapped_prompt_id: PR-RS-07
mapped_prompt_file: prompts/rs/07-missing-fact-question-generate.prompt.md
future_pra_owner: PRA-MISSING-FACT-INTERVIEWER (planned; defined in Build Package 06)
review_step: RS-12
---

# SK-TARGETED-QUESTION-GENERATE — Targeted Question Generate

## 1. Identity

- skill_id: `SK-TARGETED-QUESTION-GENERATE`
- skill_name: Targeted Question Generate
- owning_build_package: Build Package 05 — Skills and skill registry.
- skill_family: `rs`
- status: `active`
- mapped_prompt_id: `PR-RS-07`
- mapped_prompt_file: [prompts/rs/07-missing-fact-question-generate.prompt.md](../../prompts/rs/07-missing-fact-question-generate.prompt.md) (shared with `SK-MISSING-FACT-IDENTIFY`)
- future_pra_owner: `PRA-MISSING-FACT-INTERVIEWER` (planned; defined in Build Package 06).
- review_step: `RS-12`

## 2. Purpose

Write fewer and better targeted questions that are bound to specific material missing facts in RS-09. Each question must change at least one downstream output (finding, recommendation, owner, route, disposition, AI Action Level, blueprint match, validation note, or score). Broad checklist questions are a critical miss.

## 3. Required Inputs

- `runs/{{run_id}}/run-profile.yaml`
- `{{output_root}}/09-missing-facts.md`
- `{{output_root}}/10-ai-action-level.md`
- `{{output_root}}/11-blueprint-match.md`
- `config/run-profile.validation-rules.md`
- `config/path-resolution-rules.md`
- `config/sensitive-data-rules.md`

## 4. Optional Inputs

- `{{output_root}}/06-boundaries.md`
- `{{output_root}}/07-security-stack-assessment.md`
- `{{expected_root}}/expected-targeted-questions.json` — relationship reference only.

## 5. Required Outputs

- `{{output_root}}/12-targeted-questions.md` — Markdown list/table with the columns: `question_id`, `question_text`, `missing_fact_ref`, `affects_output`, `status`.

The shared prompt also writes `{{output_root}}/09-missing-facts.md` (owned by `SK-MISSING-FACT-IDENTIFY`).

## 6. Procedure

1. Resolve run-profile variables.
2. Read RS-09, RS-10, RS-11.
3. For each `gap_id` in RS-09, generate at most one targeted question that changes a named downstream output.
4. Set `status: open`. Do not pre-accept questions.
5. Drop any question whose answer would not change a named output.
6. Write `{{output_root}}/12-targeted-questions.md`.
7. Stop before writing if any Section 7 stop condition holds.

## 7. Stop Conditions

- RS-09 missing.
- Run-profile unresolved or sensitive-data confirmation `false`.
- The output would contain broad checklist questions.
- Write outside `{{output_root}}` or to the old reference workspace.
- Any prohibited execution claim.

## 8. Unknown Handling

- A question is generated only when the missing fact's materiality is supported.
- If materiality is `unknown` for a `gap_id`, no question is generated; the gap stays in RS-09 only.

## 9. Confidence Handling

- `HIGH` — question is bound to a named `gap_id` with a named `affects_output` and a clear materiality reason.
- `MEDIUM` — question is bound but the affected output is partial.
- `LOW` — question is bound but the materiality is borderline.
- `UNKNOWN` — drop the question; do not include.

## 10. Critical Misses

- Broad checklist questions ("do you have logging?").
- Questions whose answer changes nothing.
- Pre-accepted (`status: accepted`) questions before SAS review.
- Writing outside `{{output_root}}`.

## 11. Human Review Gate

The SAS reviewer approves questions before they are sent to the requesting team. Final acceptance occurs after the blueprint-match review.

## 12. Validation / Scoring Relationship

- Expected baseline (when present): `{{expected_root}}/expected-targeted-questions.json` (planned; defined in Build Package 10).
- Scoring category: targeted question quality (10 points within `SK-ACCURACY-SCORE`).
- Broad checklist questions are critical misses.

## 13. Direct Skill Test

```
tools/New-AisrafRun.ps1 -RunId RUN-LOCAL-SK-QUESTION-TEST -SampleId sample-001-dfd-crop -Mode folder_first_test -CopySampleInputs
tools/Test-AisrafRunProfile.ps1 -RunProfilePath runs/RUN-LOCAL-SK-QUESTION-TEST/run-profile.yaml -ExecutionReady
```

- Run RS-01..RS-09, RS-10, RS-11 first, then open [prompts/rs/07-missing-fact-question-generate.prompt.md](../../prompts/rs/07-missing-fact-question-generate.prompt.md).
- Expected local output: `runs/RUN-LOCAL-SK-QUESTION-TEST/12-targeted-questions.md`.
- PASS = output exists; every question is bound to a `gap_id` and a named output; no broad checklist question; no critical miss.

## 14. Not In Scope

- No missing-fact identification (owned by `SK-MISSING-FACT-IDENTIFY`).
- No PRA, adapter, connector, runtime, scoring, diagram, or release execution.
- No requester homework artifact creation.
