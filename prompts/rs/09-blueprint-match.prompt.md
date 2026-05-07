---
prompt_id: PR-RS-09
prompt_name: Blueprint Match
owning_build_package: Build Package 04
prompt_family: rs
status: active
future_skill_id: SK-REVIEW-BLUEPRINT-MATCH (planned; defined in Build Package 05)
future_pra_owner: PRA-BLUEPRINT-MATCHER (planned; defined in Build Package 06)
review_step: RS-09
---

# RS-09 — Blueprint Match

## 1. Identity

- prompt_id: `PR-RS-09`
- prompt_name: Blueprint Match
- owning_build_package: Build Package 04 — Prompts and prompt registry.
- prompt_family: `rs`
- status: `active`
- future_skill_id: `SK-REVIEW-BLUEPRINT-MATCH` (planned; defined in Build Package 05).
- future_pra_owner: `PRA-BLUEPRINT-MATCHER` (planned; defined in Build Package 06).
- review_step: `RS-09`

## 2. Purpose

Match the observed design shape to a candidate review blueprint pattern and write `{{output_root}}/11-blueprint-match.md`. The output records which blueprint best matches, why, and what evidence is missing for full match. In Build Package 04, Build Package 08 has not yet provided blueprint content, so this prompt's match result is typically `no_blueprint_available` plus a description of the observed pattern using prior RS outputs. This prompt does not invent blueprints, does not promote a partial match into a confirmed match, and does not perform scoring.

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
- `{{output_root}}/06-boundaries.md`
- `{{output_root}}/08-internal-review-table.md`
- `{{output_root}}/10-ai-action-level.md`

Conditional read (only when the artifact exists; Build Package 08 has not yet provided it):

- `blueprints/blueprint-index.yaml` (Build Package 08 — treat as future-package reference if absent).
- `blueprints/<pattern>.md` (Build Package 08 — treat as future-package reference if absent).

Conditional read (only when `{{expected_root}}` is non-empty and populated):

- `{{expected_root}}/expected-blueprint-match.json`

This is a relationship reference only; do not edit the baseline.

Future-package references (not required; do not stop on absence):

- `skills/SK-REVIEW-BLUEPRINT-MATCH.md` (Build Package 05).
- `prototype-agents/PRA-BLUEPRINT-MATCHER.md` (Build Package 06).
- `templates/blueprint-match-template.md` (Build Package 09).

## 5. Required Output

This prompt writes exactly one artifact:

- `{{output_root}}/11-blueprint-match.md`

No other write path is permitted. No write outside `{{output_root}}` is permitted.

## 6. Instructions

1. Resolve every variable in Section 3 from `runs/{{run_id}}/run-profile.yaml`.
2. Read the prior outputs in Section 4. Confirm all are non-empty.
3. Check whether `blueprints/` contains any blueprint files. If absent, set `match_result: no_blueprint_available` and continue with steps 4-6 to record the observed pattern only.
4. If blueprints exist, list each blueprint considered and record: `blueprint_id`, `pattern_name`, `match_score_qualitative` (`strong`, `partial`, `weak`, `none`, or `unknown`), `evidence_supporting_match` (component, flow, boundary, or row IDs), and `evidence_against_match`.
5. Pick the best candidate (or `none`/`no_blueprint_available`) and write a one-paragraph rationale grounded in prior-output IDs.
6. List the residual unknowns that would change the match.
7. Write `{{output_root}}/11-blueprint-match.md` with: `match_result`, `candidate_blueprint`, `rationale`, `evidence`, `residual_unknowns`, `confidence`.
8. Do not append to `{{output_root}}/00-run-log.md` until a human reviewer accepts the match.

## 7. Stop Conditions

Stop before any write if any of the following holds:

- `runs/{{run_id}}/run-profile.yaml` is missing or unreadable.
- Any required run-profile variable from Section 3 is unset, empty, or unresolvable.
- `sensitive_data_confirmed_redacted` is `false`.
- Any prior output in Section 4 is missing or empty.
- The instruction would require inventing a blueprint pattern, asserting a strong match without supporting evidence, or claiming a Package 05+ skill / PRA / adapter / connector / runtime / scoring / diagram / release execution.
- Any proposed write resolves outside `{{output_root}}`.
- A read or write would touch the old reference workspace.
- A sensitive-data substring per `config/sensitive-data-rules.md` is detected.

## 8. Unknown Handling

- Record `match_result: unknown` when prior-output evidence is too partial to compare against any available blueprint.
- Record `match_result: no_blueprint_available` when `blueprints/` contains no blueprint to compare against.
- Do not promote a `partial` or `weak` match to `strong` to fill a gap.

## 9. Evidence / Run-Log Guidance

- After human acceptance, append one entry to `{{output_root}}/00-run-log.md` recording: `prompt_id: PR-RS-09`, `output: {{output_root}}/11-blueprint-match.md`, accepted-by reviewer label, accepted-at timestamp (ISO 8601 UTC), and a one-line summary of match result and confidence.
- Do not pre-write the run-log entry before human acceptance.
- Do not claim Jira post-back, Confluence publication, Rovo execution, or MCP execution.

## 10. Direct Prompt Test

Operator test sequence:

```
# 1. Use the run that already contains 04-components.md, 05-flows.md, 06-boundaries.md, 08-internal-review-table.md, 10-ai-action-level.md.
tools/Test-AisrafRunProfile.ps1 -RunProfilePath runs/RUN-LOCAL-RS09-TEST/run-profile.yaml -ExecutionReady
```

- Open this card in VS Code Copilot Chat. Do not edit the prompt body. Substitute or confirm only the variables in Section 3.
- Expected local artifact: `runs/RUN-LOCAL-RS09-TEST/11-blueprint-match.md`.
- PASS = artifact exists; honestly records `no_blueprint_available` if `blueprints/` has no content; rationale cites prior-output IDs only; no invented blueprint; no external/runtime claim; run-log entry appended only after human acceptance.

## 11. Not In Scope

- No skill execution. Skill contracts are deferred to Build Package 05.
- No PRA execution. PRA specifications are deferred to Build Package 06.
- No `.agent.md` adapter execution. Adapters are deferred to Build Package 06.
- No Jira post-back, Confluence publication, Rovo execution, or MCP execution.
- No accuracy scoring (handled only by [13-accuracy-score.prompt.md](13-accuracy-score.prompt.md)).
- No diagram generation, runbook generation, or release/export.
- No runtime, cloud, or database execution.
- No blueprint authoring; blueprint content is owned by Build Package 08.
