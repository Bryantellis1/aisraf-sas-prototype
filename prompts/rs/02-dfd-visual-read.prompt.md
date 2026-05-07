---
prompt_id: PR-RS-02
prompt_name: DFD Visual Read
owning_build_package: Build Package 04
prompt_family: rs
status: active
future_skill_id: SK-DFD-VISUAL-READ (planned; defined in Build Package 05)
future_pra_owner: PRA-DFD-READER (planned; defined in Build Package 06)
review_step: RS-02
---

# RS-02 — DFD Visual Read

## 1. Identity

- prompt_id: `PR-RS-02`
- prompt_name: DFD Visual Read
- owning_build_package: Build Package 04 — Prompts and prompt registry.
- prompt_family: `rs`
- status: `active`
- future_skill_id: `SK-DFD-VISUAL-READ` (planned; defined in Build Package 05).
- future_pra_owner: `PRA-DFD-READER` (planned; defined in Build Package 06).
- review_step: `RS-02`

## 2. Purpose

Identify the visible DFD objects in the staged DFD crop and supporting notes and produce a single Markdown listing at `{{output_root}}/02-visible-dfd-objects.md`. Visible objects are concrete shapes, labels, arrows, zones, and annotations that an operator can read on the source. This prompt does not extract components, flows, boundaries, controls, or findings, and does not promote a visible label to a confirmed architectural fact.

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
- `{{input_root}}/` — all visible DFD-related artifacts present (typically a DFD crop, a legend excerpt, and any text notes that describe what the operator can see in the diagram).

Conditional read (only when `{{expected_root}}` is non-empty and populated):

- `{{expected_root}}/expected-visible-dfd-objects.json` — relationship reference only; do not edit.

Future-package references (not required; do not stop on absence):

- `skills/SK-DFD-VISUAL-READ.md` (Build Package 05).
- `prototype-agents/PRA-DFD-READER.md` (Build Package 06).
- `catalogs/dfd/component-type-catalog.yaml` (Build Package 07).
- `templates/dfd-visible-objects-template.md` (Build Package 09).

## 5. Required Output

This prompt writes exactly one artifact:

- `{{output_root}}/02-visible-dfd-objects.md`

No other write path is permitted. No write outside `{{output_root}}` is permitted.

## 6. Instructions

1. Resolve every variable in Section 3 from `runs/{{run_id}}/run-profile.yaml`.
2. Read `{{output_root}}/01-input-inventory.md`. Confirm that the inventory lists at least one DFD source artifact with status `present`. If not, stop per Section 7.
3. Open the DFD source artifacts named in the inventory.
4. Record each visible object as a row with: `object_id` (operator-assigned, e.g., `OBJ-001`), `kind` (shape, label, arrow, zone, annotation, legend, other), `text_visible_on_source` (the literal text the operator can read; redact sensitive substrings per `config/sensitive-data-rules.md`), `source_artifact` (the inventory entry it came from), and `confidence` (`high` if cleanly readable, `medium` if partially obscured, `low` if barely readable, `unknown` if illegible).
5. Do not interpret labels into components, flows, boundaries, owners, or controls in this output; that work belongs to RS-04 and RS-05.
6. Write `{{output_root}}/02-visible-dfd-objects.md` with the columns above plus a short "limits" footnote describing readability constraints (image quality, occlusion, legend ambiguity).
7. Do not append to `{{output_root}}/00-run-log.md` until a human reviewer accepts the listing.

## 7. Stop Conditions

Stop before any write if any of the following holds:

- `runs/{{run_id}}/run-profile.yaml` is missing or unreadable.
- Any required run-profile variable from Section 3 is unset, empty, or unresolvable.
- `sensitive_data_confirmed_redacted` is `false`.
- `{{output_root}}/01-input-inventory.md` is missing, empty, or lists no DFD source artifact with status `present`.
- The DFD source artifact is missing, empty, corrupted, or unreadable.
- The DFD source contains real sensitive payload, secrets, credentials, or production endpoints.
- Any proposed write resolves outside `{{output_root}}`.
- A read or write would touch the old reference workspace.
- The instruction would require inventing a hidden object, splitting an unseen child, asserting a runtime control, or claiming a Package 05+ skill / PRA / adapter / Jira / Confluence / Rovo / MCP / scoring / diagram / release execution.

## 8. Unknown Handling

- Record any unreadable shape, label, arrow, zone, or annotation as `unknown`.
- Record any partially obscured object with `confidence: low` or `confidence: medium` and a brief note in the listing.
- Do not promote `unknown` rows to confirmed architectural facts.
- Do not infer a label's meaning from a non-visible legend or from background knowledge.

## 9. Evidence / Run-Log Guidance

- After human acceptance, append one entry to `{{output_root}}/00-run-log.md` recording: `prompt_id: PR-RS-02`, `output: {{output_root}}/02-visible-dfd-objects.md`, accepted-by reviewer label, accepted-at timestamp (ISO 8601 UTC), and a one-line summary of the visible-object count and readability limits.
- Do not pre-write the run-log entry before human acceptance.
- Do not claim Jira post-back, Confluence publication, Rovo execution, or MCP execution.

## 10. Direct Prompt Test

Operator test sequence:

```
# 1. Reuse or create a folder-first test run with sample inputs.
tools/New-AisrafRun.ps1 -RunId RUN-LOCAL-RS02-TEST -SampleId sample-001-dfd-crop -Mode folder_first_test -CopySampleInputs

# 2. Run RS-01 first to produce 01-input-inventory.md, then run this card.
tools/Test-AisrafRunProfile.ps1 -RunProfilePath runs/RUN-LOCAL-RS02-TEST/run-profile.yaml -ExecutionReady
```

- Open this card in VS Code Copilot Chat. Do not edit the prompt body. Substitute or confirm only the variables in Section 3.
- Expected local artifact: `runs/RUN-LOCAL-RS02-TEST/02-visible-dfd-objects.md`.
- PASS = artifact exists; only lists objects an operator can verify on the source; no fabricated shapes; unknowns marked explicitly; no external/runtime claim; run-log entry appended only after human acceptance.

## 11. Not In Scope

- No skill execution. Skill contracts are deferred to Build Package 05.
- No PRA execution. PRA specifications are deferred to Build Package 06.
- No `.agent.md` adapter execution. Adapters are deferred to Build Package 06.
- No Jira post-back, Confluence publication, Rovo execution, or MCP execution.
- No accuracy scoring (handled only by [13-accuracy-score.prompt.md](13-accuracy-score.prompt.md)).
- No diagram generation, runbook generation, or release/export.
- No runtime, cloud, or database execution.
- No component, flow, boundary, control, or finding extraction (later RS cards own those).
