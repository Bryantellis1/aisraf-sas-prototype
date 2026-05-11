---
name: aisraf-handoff-qa-score
description: "Use when: building AISRAF handoff packs, validation notes, accuracy-score files, explaining PRA-08, or previewing 15-17 outputs."
user-invocable: true
---

# AISRAF Handoff QA Score Skill Wrapper

## Role Explanation

This is a thin BP12C projection of `AISRAF Handoff QA Scorer`. It uses `PRA-08-HANDOFF-QA-SCORER` to build the handoff pack, write validation-ticket notes, and invoke the scoring skill only when the run profile and expected baselines allow scoring.

## Canonical References

- Adapter: `.agents/aisraf-handoff-qa-scorer.agent.md`
- PRA: `prototype-agents/PRA-08-HANDOFF-QA-SCORER.md`
- Prompts: `prompts/rs/11-handoff-pack-build.prompt.md`, `prompts/rs/12-validation-note-write.prompt.md`, `prompts/rs/13-accuracy-score.prompt.md`
- Skills: `skills/rs/SK-HANDOFF-PACK-BUILD.md`, `skills/rs/SK-VALIDATION-NOTE-WRITE.md`, `skills/rs/SK-ACCURACY-SCORE.md`
- Templates: `templates/output/output-15-handoff-pack-template.md`, `templates/output/output-16-validation-notes-template.md`, `templates/output/output-17-accuracy-score-template.md`
- Validators: `tools/Test-AisrafPackage.ps1`, `tools/Test-AisrafBp12AReadiness.ps1`

## Allowed Writes

- `runs/{{run_id}}/15-handoff-pack.md`
- `runs/{{run_id}}/16-validation-notes.md`
- `runs/{{run_id}}/17-accuracy-score.md`

## Output Guide

- `runs/{{run_id}}/15-handoff-pack.md`
  - What: Design Review Handoff Pack.
  - Why: Packages review outcome material without validation-ticket evidence.
  - How: Use `prompts/rs/11-handoff-pack-build.prompt.md` with `skills/rs/SK-HANDOFF-PACK-BUILD.md`.
- `runs/{{run_id}}/16-validation-notes.md`
  - What: Separate Validation Ticket notes.
  - Why: Keeps validation-ticket evidence distinct from design-review handoff content.
  - How: Use `prompts/rs/12-validation-note-write.prompt.md` with `skills/rs/SK-VALIDATION-NOTE-WRITE.md`.
- `runs/{{run_id}}/17-accuracy-score.md`
  - What: Accuracy-score file or not-applicable scoring record.
  - Why: Records scoring only under the governed scoring conditions.
  - How: Use `prompts/rs/13-accuracy-score.prompt.md` with `skills/rs/SK-ACCURACY-SCORE.md`.

## Unknown Handling

Carry `unknown` through `IA?`, `SA?`, `CA?`, `AZ?`, `R?`, `L?`, and `match=unknown`. Do not invent values to clear a field.

## Stop Conditions

- Validation-ticket evidence is found inside the handoff pack (or vice versa).
- An accuracy claim is made when `mode != scored`, `expected_baseline_required = false`, or `{{expected_root}}` is empty.
- A score is inflated by hiding unknowns or by ignoring a critical miss.
- A baseline file under `{{expected_root}}` is modified by this adapter.
- An accuracy claim is made by any skill other than `SK-ACCURACY-SCORE`.
- A `postback_execution_status: executed_by_operator` value is recorded without timestamp, destination URL, and operator action in `00-run-log.md`.
- A write is attempted outside `{{output_root}}`.
- Any claim of runtime, cloud, ADK, MCP, Jira, Confluence, Rovo, database, or release execution.

## Role Smoke Response

With no input, explain this role, show the allowed write paths, cite the stop conditions, and refuse to write.

## Chat Preview Response

For preview-only mode, render the referenced template section shapes in chat. Use `<numeric_score_pending_chain_execution>` for numeric score placeholders and write nothing.

## Prohibited Claims

Do not claim runtime, cloud, ADK, MCP, Jira, Confluence, Rovo, database, Terraform, external post-back, release, diagram, or autonomous execution.
