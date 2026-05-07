---
skill_id: SK-AI-ACTION-LEVEL-CLASSIFY
skill_name: AI Action Level Classify
owning_build_package: Build Package 05
skill_family: rs
status: active
mapped_prompt_id: PR-RS-08
mapped_prompt_file: prompts/rs/08-ai-action-level-classify.prompt.md
future_pra_owner: PRA-AI-CLASSIFIER (planned; defined in Build Package 06)
review_step: RS-10
---

# SK-AI-ACTION-LEVEL-CLASSIFY — AI Action Level Classify

## 1. Identity

- skill_id: `SK-AI-ACTION-LEVEL-CLASSIFY`
- skill_name: AI Action Level Classify
- owning_build_package: Build Package 05 — Skills and skill registry.
- skill_family: `rs`
- status: `active`
- mapped_prompt_id: `PR-RS-08`
- mapped_prompt_file: [prompts/rs/08-ai-action-level-classify.prompt.md](../../prompts/rs/08-ai-action-level-classify.prompt.md)
- future_pra_owner: `PRA-AI-CLASSIFIER` (planned; defined in Build Package 06).
- review_step: `RS-10`

## 2. Purpose

Classify the AI Action Level (L1 through L5) from supported interaction facts in RS-04..RS-08. When the facts are insufficient, the skill records `unknown` and references the missing fact in RS-09. Unsupported level claims are critical misses.

## 3. Required Inputs

- `runs/{{run_id}}/run-profile.yaml`
- `{{output_root}}/04-components.md`
- `{{output_root}}/05-flows.md`
- `{{output_root}}/08-internal-review-table.md`
- `config/run-profile.validation-rules.md`
- `config/path-resolution-rules.md`
- `config/sensitive-data-rules.md`

## 4. Optional Inputs

- `{{output_root}}/09-missing-facts.md` — for `missing_fact_ref` linkage when the level is `unknown`.
- `{{input_root}}/cloud-triage-notes.md`, `{{input_root}}/review-transcript.md`
- `{{expected_root}}/expected-ai-action-level.json` — relationship reference only.

## 5. Required Outputs

- `{{output_root}}/10-ai-action-level.md` — Markdown table with the columns: `ai_action_level`, `supporting_facts`, `confidence`, `missing_fact_ref`, `notes`.

## 6. Procedure

1. Resolve run-profile variables.
2. Read RS-04, RS-05, RS-08.
3. Determine the AI Action Level (L1, L2, L3, L4, L5) from the supported interaction facts (information retrieval, suggestion, action with HITL, autonomous action, multi-agent autonomous action).
4. If the facts are insufficient, set `ai_action_level: unknown` and reference the relevant `gap_id` from RS-09.
5. Set `confidence` per Section 9.
6. Write `{{output_root}}/10-ai-action-level.md`.
7. Stop before writing if any Section 7 stop condition holds.

## 7. Stop Conditions

- Required prior outputs missing.
- Run-profile unresolved or sensitive-data confirmation `false`.
- The output would assert an L1..L5 level without supporting facts.
- Write outside `{{output_root}}` or to the old reference workspace.
- Any prohibited execution claim.

## 8. Unknown Handling

- `ai_action_level: unknown` is required when facts cannot support a single level.
- Multiple plausible levels are recorded in `notes` with the materiality reason.
- Unknown level routes the missing fact through RS-09 / RS-12.

## 9. Confidence Handling

- `HIGH` — supporting facts are present in RS-05 and RS-08 with corroborating notes.
- `MEDIUM` — facts support the level but one supporting field is `unknown`.
- `LOW` — only one supporting fact is available.
- `UNKNOWN` — facts insufficient; level is `unknown`.

## 10. Critical Misses

- Asserting L1..L5 without supporting facts.
- Using a DFD label alone to claim a level.
- Writing outside `{{output_root}}`.

## 11. Human Review Gate

The SAS reviewer must confirm L1..L5 interpretation with the requesting team if unclear, and accept that an `unknown` level is allowed.

## 12. Validation / Scoring Relationship

- Expected baseline (when present): `{{expected_root}}/expected-ai-action-level.json` (planned; defined in Build Package 10).
- Scoring category: AI Action Level classification (10 points within `SK-ACCURACY-SCORE`).
- Unsupported level is a critical miss.

## 13. Direct Skill Test

```
tools/New-AisrafRun.ps1 -RunId RUN-LOCAL-SK-AILEVEL-TEST -SampleId sample-001-dfd-crop -Mode folder_first_test -CopySampleInputs
tools/Test-AisrafRunProfile.ps1 -RunProfilePath runs/RUN-LOCAL-SK-AILEVEL-TEST/run-profile.yaml -ExecutionReady
```

- Run RS-01..RS-08 first, then open [prompts/rs/08-ai-action-level-classify.prompt.md](../../prompts/rs/08-ai-action-level-classify.prompt.md).
- Expected local output: `runs/RUN-LOCAL-SK-AILEVEL-TEST/10-ai-action-level.md`.
- PASS = output exists; level is supported by named facts or recorded `unknown`; no critical miss.

## 14. Not In Scope

- No blueprint matching (owned by `SK-REVIEW-BLUEPRINT-MATCH`).
- No PRA, adapter, connector, runtime, scoring, diagram, or release execution.
