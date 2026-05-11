---
prompt_id: PR-RS-13
prompt_name: Accuracy Score
owning_build_package: Build Package 04
prompt_family: rs
status: active
future_skill_id: SK-ACCURACY-SCORE (planned; defined in Build Package 05)
future_pra_owner: PRA-VALIDATION-SCORER (planned; defined in Build Package 06)
review_step: RS-14-through-RS-17
---

# RS-13 (RS Output 17) — Accuracy Score

## 1. Identity

- prompt_id: `PR-RS-13`
- prompt_name: Accuracy Score
- owning_build_package: Build Package 04 — Prompts and prompt registry.
- prompt_family: `rs`
- status: `active` (conditional)
- future_skill_id: `SK-ACCURACY-SCORE` (planned; defined in Build Package 05).
- future_pra_owner: `PRA-VALIDATION-SCORER` (planned; defined in Build Package 06).
- review_step: `RS-14-through-RS-17`

## 2. Purpose

Compare the run outputs under `{{output_root}}` to expected baselines under `{{expected_root}}` and write `{{output_root}}/17-accuracy-score.md`. The output records per-artifact qualitative scores (`pass`, `partial`, `fail`, `not_applicable`, or `unknown`), specific divergences, and an honest run-level summary. This prompt is the only prompt in Package 04 that performs scoring, and it is conditional: it stops cleanly when scoring is not applicable for the run. It does not edit baselines, does not claim that scoring has been verified externally, and does not produce a release artifact.

## 3. Run Profile Inputs

Resolve every value from `runs/{{run_id}}/run-profile.yaml`. The seven required v0.1.2 run-profile variables are:

- `{{run_id}}`, `{{input_root}}`, `{{expected_root}}`, `{{output_root}}`, `{{mode}}`, `{{postback_execution_status}}`, `{{output_destination_mode}}`.

Additional run-profile fields used by this prompt's scoring gate (resolved from the same run profile):

- `scoring_enabled`
- `expected_baseline_required`

Do not hardcode any value. Do not invent fields outside `config/run-profile.schema.yaml`.

## 4. Required Read Paths

Required reads:

- `runs/{{run_id}}/run-profile.yaml`
- `config/run-profile.validation-rules.md`
- `config/path-resolution-rules.md`
- `config/sensitive-data-rules.md`
- `validation/no-drift-rules.md`
- `{{output_root}}/01-input-inventory.md`
- `{{output_root}}/02-visible-dfd-objects.md`
- `{{output_root}}/03-legend-normalization.md`
- `{{output_root}}/04-components.md`
- `{{output_root}}/05-flows.md`
- `{{output_root}}/06-boundaries.md`
- `{{output_root}}/07-security-stack-assessment.md`
- `{{output_root}}/08-internal-review-table.md`
- `{{output_root}}/09-missing-facts.md`
- `{{output_root}}/10-ai-action-level.md`
- `{{output_root}}/11-blueprint-match.md`
- `{{output_root}}/12-targeted-questions.md`
- `{{output_root}}/13-findings.md`
- `{{output_root}}/14-recommendations.md`
- `{{output_root}}/15-handoff-pack.md`
- `{{output_root}}/16-validation-notes.md`
- All files under `{{expected_root}}/` — only when `{{expected_root}}` is non-empty and populated, `expected_baseline_required: true`, and `scoring_enabled: true`.

Future-package references (not required; do not stop on absence):

- `skills/SK-ACCURACY-SCORE.md` (Build Package 05).
- `prototype-agents/PRA-VALIDATION-SCORER.md` (Build Package 06).
- `validation/scoring-rubric.md` (planned future validation artifact).
- `templates/accuracy-score-template.md` (Build Package 09).

## 5. Required Output

This prompt writes exactly one artifact:

- `{{output_root}}/17-accuracy-score.md`

No other write path is permitted. No write outside `{{output_root}}` is permitted.

## 6. Instructions

1. Resolve every variable in Section 3 from `runs/{{run_id}}/run-profile.yaml`. Also resolve `scoring_enabled` and `expected_baseline_required`.
2. Apply the scoring gate. The run is scoreable only when ALL of the following hold:
   - `scoring_enabled: true`
   - `expected_baseline_required: true`
   - `{{expected_root}}` is non-empty.
   - `{{expected_root}}/` exists on disk and contains at least one expected baseline file.
3. If the gate is not satisfied, stop scoring and instead write `{{output_root}}/17-accuracy-score.md` with: `scoring_status: not_applicable_for_this_run`, the resolved values of `scoring_enabled`, `expected_baseline_required`, and `{{expected_root}}`, and a one-paragraph reason. Do not produce per-artifact scores. This is the honest path — do not invent scoring proof.
4. If the gate is satisfied, for each RS output 01..16, find the matching expected baseline (either by stable filename mapping the operator can confirm against `{{expected_root}}/`, or by inventory comparison when no exact baseline filename exists) and record: `artifact`, `expected_baseline`, `qualitative_score` (`pass`, `partial`, `fail`, `not_applicable`, or `unknown`), `divergence_summary` (one or two sentences naming row IDs or fields that diverge), and `confidence`.
5. Add a run-level summary: total scored artifacts, count of `pass`, `partial`, `fail`, `unknown`, and `not_applicable`. Mark any score as `unknown` whenever the operator cannot confidently compare against a baseline.
6. Write `{{output_root}}/17-accuracy-score.md`. Do not append to `{{output_root}}/00-run-log.md` until a human reviewer accepts the score.

## 7. Stop Conditions

Stop before any write if any of the following holds:

- `runs/{{run_id}}/run-profile.yaml` is missing or unreadable.
- Any required run-profile variable from Section 3 is unset, empty, or unresolvable.
- `sensitive_data_confirmed_redacted` is `false`.
- Any RS output 01..16 listed in Section 4 is missing or empty.
- The scoring gate is not satisfied AND the operator attempts to score anyway. The honest path is to record `scoring_status: not_applicable_for_this_run`.
- The instruction would require editing `{{expected_root}}/` baselines, or rebaselining without explicit operator action recorded in `00-run-log.md`.
- Any proposed write resolves outside `{{output_root}}`.
- A read or write would touch the old reference workspace.
- A sensitive-data substring per `config/sensitive-data-rules.md` is detected in any read value.
- The instruction would require claiming a Package 05+ skill / PRA / adapter / connector / runtime / external scoring service / diagram / release execution.

## 8. Unknown Handling

- Where a baseline filename cannot be matched confidently to an RS output, record `qualitative_score: unknown` and explain in the divergence summary.
- Where the gate is not satisfied, record `scoring_status: not_applicable_for_this_run`. Do not produce per-artifact scores.
- Do not promote a `partial` to `pass` or downgrade a `fail` to `partial` without supporting divergence detail.

## 9. Evidence / Run-Log Guidance

- After human acceptance, append one entry to `{{output_root}}/00-run-log.md` recording: `prompt_id: PR-RS-13`, `output: {{output_root}}/17-accuracy-score.md`, accepted-by reviewer label, accepted-at timestamp (ISO 8601 UTC), and a one-line summary of `scoring_status` plus pass/partial/fail/unknown/not_applicable counts.
- Do not pre-write the run-log entry before human acceptance.
- Do not claim Jira post-back, Confluence publication, Rovo execution, or MCP execution. Scoring proof is a local Markdown artifact only.

## 10. Direct Prompt Test

Operator test sequence:

```
# 1. Use the run that already contains 01-input-inventory.md through 16-validation-notes.md.
# 2. Confirm whether {{expected_root}} is populated. In Build Package 04 the
#    samples/ surface is reserved (Build Package 10), so most runs will hit
#    "not_applicable_for_this_run" — that is the correct, honest result.
tools/Test-AisrafRunProfile.ps1 -RunProfilePath runs/RUN-LOCAL-RS13-TEST/run-profile.yaml -ExecutionReady
```

- Open this card in VS Code Copilot Chat. Do not edit the prompt body. Substitute or confirm only the variables in Section 3.
- Expected local artifact: `runs/RUN-LOCAL-RS13-TEST/17-accuracy-score.md`.
- PASS (gate not satisfied) = artifact records `scoring_status: not_applicable_for_this_run`, lists resolved values of `scoring_enabled`, `expected_baseline_required`, and `{{expected_root}}`, and produces no per-artifact score.
- PASS (gate satisfied) = artifact lists per-artifact scores citing `{{expected_root}}/<baseline>` filenames, run-level counts add up to total scored artifacts, no baseline edited, no external claim, run-log entry appended only after human acceptance.

## 11. Not In Scope

- No skill execution. Skill contracts are deferred to Build Package 05.
- No PRA execution. PRA specifications are deferred to Build Package 06.
- No `.agent.md` adapter execution. Adapters are deferred to Build Package 06.
- No Jira post-back, Confluence publication, Rovo execution, or MCP execution.
- No diagram generation, runbook generation, or release/export.
- No runtime, cloud, or database execution.
- No editing of expected baselines under `{{expected_root}}`.
- No rebaselining inside this prompt; rebaseline policy is owned by Build Package 10.
- No scoring outside this prompt. Other RS prompts must not produce a `qualitative_score` field.
