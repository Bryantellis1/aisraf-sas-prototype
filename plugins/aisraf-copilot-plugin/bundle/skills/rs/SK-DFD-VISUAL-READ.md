---
skill_id: SK-DFD-VISUAL-READ
skill_name: DFD Visual Read
owning_build_package: Build Package 05
skill_family: rs
status: active
mapped_prompt_id: PR-RS-02
mapped_prompt_file: prompts/rs/02-dfd-visual-read.prompt.md
future_pra_owner: PRA-DFD-READER (planned; defined in Build Package 06)
review_step: RS-02
---

# SK-DFD-VISUAL-READ — DFD Visual Read

## 1. Identity

- skill_id: `SK-DFD-VISUAL-READ`
- skill_name: DFD Visual Read
- owning_build_package: Build Package 05 — Skills and skill registry.
- skill_family: `rs`
- status: `active`
- mapped_prompt_id: `PR-RS-02`
- mapped_prompt_file: [prompts/rs/02-dfd-visual-read.prompt.md](../../prompts/rs/02-dfd-visual-read.prompt.md)
- future_pra_owner: `PRA-DFD-READER` (planned; defined in Build Package 06).
- review_step: `RS-02`

## 2. Purpose

Record every visible DFD object (nodes, flows, labels, zones, boundaries) from the DFD source artifact and supporting notes staged under `{{input_root}}` without claiming unsupported precision. The skill produces a single Markdown inventory of visible objects that downstream skills (`SK-LEGEND-NORMALIZE`, `SK-COMPONENT-EXTRACT`, `SK-FLOW-EXTRACT`, `SK-BOUNDARY-CROSSING-DETECT`) read. It does not normalize legend tokens, map components to type, classify flows, or claim runtime stack presence.

## 3. Required Inputs

- `runs/{{run_id}}/run-profile.yaml`
- `{{output_root}}/01-input-inventory.md` — RS-01 output identifying the DFD source.
- `{{input_root}}/` — DFD source artifact and supporting notes.
- `config/run-profile.validation-rules.md`
- `config/path-resolution-rules.md`
- `config/sensitive-data-rules.md`

## 4. Optional Inputs

- `{{output_root}}/dfd/01-intake-quality-check.md` — DFD intake quality check (when present).
- `{{expected_root}}/expected-visible-dfd-objects.json` — relationship reference only.
- `runs/{{run_id}}/inputs/README.md` — operator notes about the staged inputs.

## 5. Required Outputs

This skill produces exactly one artifact under `{{output_root}}`:

- `{{output_root}}/02-visible-dfd-objects.md` — Markdown inventory with the columns: `object_id`, `object_type`, `label_text`, `visibility_source`, `confidence`, `notes`.

No other write path is permitted. No write outside `{{output_root}}` is permitted.

## 6. Procedure

1. Resolve every required run-profile variable from `runs/{{run_id}}/run-profile.yaml`.
2. Read `{{output_root}}/01-input-inventory.md` and identify the DFD source artifact and any supporting notes.
3. Enumerate every visible DFD object: nodes (process, store, actor, model, tool), flows (arrows, lines), labels (text near nodes/flows), zones, and boundaries.
4. For each object, record `object_type`, `label_text` (verbatim from the source), `visibility_source` (file name and visible region), `confidence` (HIGH/MEDIUM/LOW/UNKNOWN), and `notes` (brief readability or ambiguity remark).
5. Do not interpret legend tokens (RS-03 owns that). Do not classify component type beyond the surface label (RS-04 owns that). Do not assert flow direction or interaction type beyond what is visibly drawn (RS-05 owns the interpretation).
6. Write `{{output_root}}/02-visible-dfd-objects.md`.
7. Stop before writing if any Section 7 stop condition holds.

## 7. Stop Conditions

- `runs/{{run_id}}/run-profile.yaml` is missing or unreadable.
- Any required run-profile variable is unset, empty, or unresolvable.
- `sensitive_data_confirmed_redacted` is `false`.
- `{{output_root}}/01-input-inventory.md` is missing.
- The DFD source artifact identified by RS-01 is missing or unreadable.
- Any proposed write resolves outside `{{output_root}}`.
- A read or write would touch the old reference workspace.
- A sensitive-data substring per `config/sensitive-data-rules.md` is detected.
- The work would require running a Package 05+ skill, PRA, adapter, connector, runtime, scoring, diagram, or release service.
- The work would require inventing an object that is not visible in the source.

## 8. Unknown Handling

- Any object whose type cannot be read remains `object_type: unknown`.
- Any label that is partially visible is recorded verbatim with the visible portion plus an `unknown` suffix in `notes`.
- Cropped, occluded, or low-resolution objects carry `confidence: LOW` and an explicit `notes` reason.
- The skill never promotes an `unknown` row to a confirmed type using assumption or naming convention.

## 9. Confidence Handling

- `HIGH` — object is clearly drawn, fully labeled, and unambiguous.
- `MEDIUM` — object is clearly drawn but the label is partially obscured or ambiguous.
- `LOW` — the object is partially visible, low-resolution, occluded, or cropped at an edge.
- `UNKNOWN` — operator cannot judge type or label from visible evidence.

## 10. Critical Misses

- Inventing a DFD object that is not visible in the source.
- Asserting unsupported precision (e.g., "encrypted at rest" from a DFD label that does not show storage protection).
- Treating a legend token as a classified component or flow type at this step.
- Writing outside `{{output_root}}`.

## 11. Human Review Gate

The SAS reviewer must spot-check the inventory against the DFD source:

- Every row corresponds to a visibly drawn object in the source artifact.
- No invented objects appear.
- Confidence levels match readability.
- Sensitive-material rejection (if any) was honored before write.

## 12. Validation / Scoring Relationship

- Expected baseline (when present): `{{expected_root}}/expected-visible-dfd-objects.json` (planned; defined in Build Package 10).
- Scoring category: visible DFD object extraction (10 points within `SK-ACCURACY-SCORE`).
- Critical-miss conditions force a FAIL on `SK-ACCURACY-SCORE`.
- The skill produces no score field of its own.

## 13. Direct Skill Test

```
tools/New-AisrafRun.ps1 -RunId RUN-LOCAL-SK-DFDVISUAL-TEST -SampleId sample-001-dfd-crop -Mode folder_first_test -CopySampleInputs
tools/Test-AisrafRunProfile.ps1 -RunProfilePath runs/RUN-LOCAL-SK-DFDVISUAL-TEST/run-profile.yaml -ExecutionReady
```

- Open [prompts/rs/02-dfd-visual-read.prompt.md](../../prompts/rs/02-dfd-visual-read.prompt.md) in VS Code Copilot Chat after running RS-01 (or with a pre-existing `01-input-inventory.md`).
- Expected local output: `runs/RUN-LOCAL-SK-DFDVISUAL-TEST/02-visible-dfd-objects.md`.
- PASS = output exists; every row corresponds to a visibly drawn object; unknowns are marked, not invented; no critical miss.

## 14. Not In Scope

- No legend normalization, component classification, flow interpretation, boundary derivation, security stack assertion, or scoring (later RS skills own those).
- No PRA execution, `.agent.md` adapter execution, connector execution, runtime, cloud, scoring, diagram, or release.
- Catalog references in later steps are placeholders only `(planned; defined in Build Package 07)`.
