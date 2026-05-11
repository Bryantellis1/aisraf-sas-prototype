---
prompt_id: PR-RS-03
prompt_name: Legend Normalization
owning_build_package: Build Package 04
prompt_family: rs
status: active
future_skill_id: SK-DFD-LEGEND-NORMALIZE (planned; defined in Build Package 05)
future_pra_owner: PRA-DFD-READER (planned; defined in Build Package 06)
review_step: RS-03
---

# RS-03 — Legend Normalization

## 1. Identity

- prompt_id: `PR-RS-03`
- prompt_name: Legend Normalization
- owning_build_package: Build Package 04 — Prompts and prompt registry.
- prompt_family: `rs`
- status: `active`
- future_skill_id: `SK-DFD-LEGEND-NORMALIZE` (planned; defined in Build Package 05).
- future_pra_owner: `PRA-DFD-READER` (planned; defined in Build Package 06).
- review_step: `RS-03`

## 2. Purpose

Normalize the visible legend, color codes, line styles, marker tokens, and annotation shorthand observed in the DFD source into a small dictionary at `{{output_root}}/03-legend-normalization.md`. The dictionary maps the source token to a normalized meaning (where the source legend states it) or `unknown` (where the legend is missing, partial, or ambiguous). This prompt does not invent legend semantics, does not expand abbreviations beyond what the source legend asserts, and does not promote a legend entry into a runtime control claim.

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
- `{{output_root}}/02-visible-dfd-objects.md`
- `{{input_root}}/` — visible legend excerpt and any inline notes that describe legend tokens.

Conditional read (only when `{{expected_root}}` is non-empty and populated):

- `{{expected_root}}/expected-legend-normalization.json` — relationship reference only; do not edit.

Future-package references (not required; do not stop on absence):

- `skills/SK-DFD-LEGEND-NORMALIZE.md` (Build Package 05).
- `prototype-agents/PRA-DFD-READER.md` (Build Package 06).
- `catalogs/dfd/annotation-semantics-registry.yaml` (Build Package 07).
- `catalogs/dfd/authn-authz-marker-catalog.yaml` (Build Package 07).
- `catalogs/dfd/storage-protection-marker-catalog.yaml` (Build Package 07).
- `catalogs/dfd/security-stack-marker-catalog.yaml` (Build Package 07).
- `templates/legend-normalization-template.md` (Build Package 09).

## 5. Required Output

This prompt writes exactly one artifact:

- `{{output_root}}/03-legend-normalization.md`

No other write path is permitted. No write outside `{{output_root}}` is permitted.

## 6. Instructions

1. Resolve every variable in Section 3 from `runs/{{run_id}}/run-profile.yaml`.
2. Read `{{output_root}}/02-visible-dfd-objects.md`. Confirm that visible legend, color, line-style, or marker tokens are listed.
3. For each unique token observed, record a row with: `token` (literal source string or visual cue), `normalized_meaning` (the meaning explicitly asserted by the source legend or supporting notes), `source_evidence` (legend cell, inline note, transcript line), and `confidence` (`high` if the source legend states the meaning, `medium` if the meaning is implied by visible context, `low` if guessed, `unknown` if no source asserts the meaning).
4. Where the source legend is missing, partial, or ambiguous, record `normalized_meaning: unknown`. Do not import meanings from non-visible catalogs (Build Package 07 will provide controlled vocabulary later).
5. Add a "limits" footnote describing legend readability and any tokens that the source did not define.
6. Write `{{output_root}}/03-legend-normalization.md` with the columns: `token`, `normalized_meaning`, `source_evidence`, `confidence`.
7. Do not append to `{{output_root}}/00-run-log.md` until a human reviewer accepts the dictionary.

## 7. Stop Conditions

Stop before any write if any of the following holds:

- `runs/{{run_id}}/run-profile.yaml` is missing or unreadable.
- Any required run-profile variable from Section 3 is unset, empty, or unresolvable.
- `sensitive_data_confirmed_redacted` is `false`.
- `{{output_root}}/02-visible-dfd-objects.md` is missing or empty.
- No legend, color code, line style, marker token, or annotation appears in the visible-object listing or supporting notes.
- Any proposed write resolves outside `{{output_root}}`.
- A read or write would touch the old reference workspace.
- A sensitive-data substring per `config/sensitive-data-rules.md` is detected in any read value.
- The instruction would require asserting a legend meaning that the source does not state, or claiming a Package 05+ skill / PRA / adapter / connector / runtime / scoring / diagram / release execution.

## 8. Unknown Handling

- Record any token not defined by the source as `normalized_meaning: unknown`.
- Record any ambiguous token with `confidence: low` and the visible context.
- Do not infer meanings from cloud defaults, training data, or external best practices.
- Do not collapse two tokens into one normalized meaning unless the source legend explicitly equates them.

## 9. Evidence / Run-Log Guidance

- After human acceptance, append one entry to `{{output_root}}/00-run-log.md` recording: `prompt_id: PR-RS-03`, `output: {{output_root}}/03-legend-normalization.md`, accepted-by reviewer label, accepted-at timestamp (ISO 8601 UTC), and a one-line summary of token count and unknown count.
- Do not pre-write the run-log entry before human acceptance.
- Do not claim Jira post-back, Confluence publication, Rovo execution, or MCP execution.

## 10. Direct Prompt Test

Operator test sequence:

```
# 1. Use the run that already contains 01-input-inventory.md and 02-visible-dfd-objects.md.
tools/Test-AisrafRunProfile.ps1 -RunProfilePath runs/RUN-LOCAL-RS03-TEST/run-profile.yaml -ExecutionReady
```

- Open this card in VS Code Copilot Chat. Do not edit the prompt body. Substitute or confirm only the variables in Section 3.
- Expected local artifact: `runs/RUN-LOCAL-RS03-TEST/03-legend-normalization.md`.
- PASS = artifact exists; every row cites visible source evidence; tokens not defined by the source are recorded as `unknown`; no external/runtime claim; run-log entry appended only after human acceptance.

## 11. Not In Scope

- No skill execution. Skill contracts are deferred to Build Package 05.
- No PRA execution. PRA specifications are deferred to Build Package 06.
- No `.agent.md` adapter execution. Adapters are deferred to Build Package 06.
- No Jira post-back, Confluence publication, Rovo execution, or MCP execution.
- No accuracy scoring (handled only by [13-accuracy-score.prompt.md](13-accuracy-score.prompt.md)).
- No diagram generation, runbook generation, or release/export.
- No runtime, cloud, or database execution.
- No use of Build Package 07 catalogs as a substitute for source legends. Catalogs are referenced only as future-package references.
