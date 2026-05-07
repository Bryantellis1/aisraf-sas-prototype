---
prompt_id: PR-RS-11
prompt_name: Handoff Pack Build
owning_build_package: Build Package 04
prompt_family: rs
status: active
future_skill_id: SK-HANDOFF-PACK-BUILD (planned; defined in Build Package 05)
future_pra_owner: PRA-HANDOFF-BUILDER (planned; defined in Build Package 06)
review_step: RS-11
---

# RS-11 — Handoff Pack Build

## 1. Identity

- prompt_id: `PR-RS-11`
- prompt_name: Handoff Pack Build
- owning_build_package: Build Package 04 — Prompts and prompt registry.
- prompt_family: `rs`
- status: `active`
- future_skill_id: `SK-HANDOFF-PACK-BUILD` (planned; defined in Build Package 05).
- future_pra_owner: `PRA-HANDOFF-BUILDER` (planned; defined in Build Package 06).
- review_step: `RS-11`

## 2. Purpose

Assemble a single Markdown handoff pack at `{{output_root}}/15-handoff-pack.md` that summarizes the design review for downstream owners (design, security, data, requester). The handoff pack collects the internal review table, missing facts, AI Action Level, blueprint match, targeted questions, findings, and recommendations into one operator-readable document with explicit sections and links back to the per-step outputs. This prompt does not invent new findings or recommendations, does not duplicate the source artifacts, and does not claim that the pack has been delivered to a destination.

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
- `{{output_root}}/08-internal-review-table.md`
- `{{output_root}}/09-missing-facts.md`
- `{{output_root}}/10-ai-action-level.md`
- `{{output_root}}/11-blueprint-match.md`
- `{{output_root}}/12-targeted-questions.md`
- `{{output_root}}/13-findings.md`
- `{{output_root}}/14-recommendations.md`

Conditional read (only when `{{expected_root}}` is non-empty and populated):

- `{{expected_root}}/expected-handoff-pack.json`

This is a relationship reference only; do not edit the baseline.

Future-package references (not required; do not stop on absence):

- `skills/SK-HANDOFF-PACK-BUILD.md` (Build Package 05).
- `prototype-agents/PRA-HANDOFF-BUILDER.md` (Build Package 06).
- `templates/handoff-pack-template.md` (Build Package 09).

## 5. Required Output

This prompt writes exactly one artifact:

- `{{output_root}}/15-handoff-pack.md`

No other write path is permitted. No write outside `{{output_root}}` is permitted.

## 6. Instructions

1. Resolve every variable in Section 3 from `runs/{{run_id}}/run-profile.yaml`.
2. Read the prior outputs in Section 4. Confirm all are non-empty.
3. Build a single Markdown document with these sections in order: `Summary` (one paragraph: who this is for, what design was reviewed, what mode was used), `AI Action Level` (one paragraph linking to `10-ai-action-level.md`), `Blueprint Match` (one paragraph linking to `11-blueprint-match.md`), `Findings` (table summarizing `13-findings.md` with finding_id, category, severity_qualitative, evidence), `Recommendations` (table summarizing `14-recommendations.md` with recommendation_id, owner_role, addresses_findings, prerequisite_evidence), `Targeted Questions` (table summarizing `12-targeted-questions.md`), `Missing Facts` (table summarizing `09-missing-facts.md`), `Source Artifacts` (links to all prior outputs under `{{output_root}}`), and `Posture` (state `output_destination_mode`, `postback_execution_status`, and explicitly that no external post-back has occurred from this prompt).
4. Do not introduce new findings, new recommendations, new questions, or new missing facts in this pack. Summarize and link only.
5. Do not include the body of source artifacts; reference them by relative path under `{{output_root}}`.
6. Write `{{output_root}}/15-handoff-pack.md`. Do not append to `{{output_root}}/00-run-log.md` until a human reviewer accepts the pack.

## 7. Stop Conditions

Stop before any write if any of the following holds:

- `runs/{{run_id}}/run-profile.yaml` is missing or unreadable.
- Any required run-profile variable from Section 3 is unset, empty, or unresolvable.
- `sensitive_data_confirmed_redacted` is `false`.
- Any prior output in Section 4 is missing or empty.
- The instruction would require introducing new findings, recommendations, questions, or missing facts.
- The instruction would require claiming Jira post-back, Confluence publication, or other external delivery from this prompt.
- Any proposed write resolves outside `{{output_root}}`.
- A read or write would touch the old reference workspace.
- A sensitive-data substring per `config/sensitive-data-rules.md` is detected.
- The instruction would require claiming a Package 05+ skill / PRA / adapter / connector / runtime / scoring / diagram / release execution.

## 8. Unknown Handling

- Where a prior output cell is `unknown`, preserve `unknown` in the pack summary.
- Do not infer additional facts to fill empty cells in the summary tables.

## 9. Evidence / Run-Log Guidance

- After human acceptance, append one entry to `{{output_root}}/00-run-log.md` recording: `prompt_id: PR-RS-11`, `output: {{output_root}}/15-handoff-pack.md`, accepted-by reviewer label, accepted-at timestamp (ISO 8601 UTC), and a one-line summary of pack section count and any residual unknowns.
- Do not pre-write the run-log entry before human acceptance.
- Do not claim Jira post-back, Confluence publication, Rovo execution, or MCP execution. Posture in the pack must reflect the run-profile values exactly.

## 10. Direct Prompt Test

Operator test sequence:

```
# 1. Use the run that already contains 08-internal-review-table.md through 14-recommendations.md.
tools/Test-AisrafRunProfile.ps1 -RunProfilePath runs/RUN-LOCAL-RS11-TEST/run-profile.yaml -ExecutionReady
```

- Open this card in VS Code Copilot Chat. Do not edit the prompt body. Substitute or confirm only the variables in Section 3.
- Expected local artifact: `runs/RUN-LOCAL-RS11-TEST/15-handoff-pack.md`.
- PASS = artifact exists; sections are present and ordered as in Section 6; every section links to a prior output rather than duplicating content; posture section honestly reflects `output_destination_mode` and `postback_execution_status`; no external/runtime claim; run-log entry appended only after human acceptance.

## 11. Not In Scope

- No skill execution. Skill contracts are deferred to Build Package 05.
- No PRA execution. PRA specifications are deferred to Build Package 06.
- No `.agent.md` adapter execution. Adapters are deferred to Build Package 06.
- No Jira post-back, Confluence publication, Rovo execution, or MCP execution.
- No accuracy scoring (handled only by [13-accuracy-score.prompt.md](13-accuracy-score.prompt.md)).
- No diagram generation, runbook generation, or release/export.
- No runtime, cloud, or database execution.
- No new finding, recommendation, question, or missing-fact creation.
