---
skill_id: SK-FINDING-CLASSIFY
skill_name: Finding Classify
owning_build_package: Build Package 05
skill_family: rs
status: active
mapped_prompt_id: PR-RS-10
mapped_prompt_file: prompts/rs/10-finding-recommendation-write.prompt.md
future_pra_owner: PRA-RISK-WRITER (planned; defined in Build Package 06)
review_step: RS-13
---

# SK-FINDING-CLASSIFY — Finding Classify

## 1. Identity

- skill_id: `SK-FINDING-CLASSIFY`
- skill_name: Finding Classify
- owning_build_package: Build Package 05 — Skills and skill registry.
- skill_family: `rs`
- status: `active`
- mapped_prompt_id: `PR-RS-10`
- mapped_prompt_file: [prompts/rs/10-finding-recommendation-write.prompt.md](../../prompts/rs/10-finding-recommendation-write.prompt.md) (shared with `SK-RECOMMENDATION-WRITE`)
- future_pra_owner: `PRA-RISK-WRITER` (planned; defined in Build Package 06).
- review_step: `RS-13`

## 2. Purpose

Classify findings into allowed categories (Requirement, Gap, Deficiency, Observation, Evidence Gap) with supported evidence, disposition, and ownership. Wrong category that changes the responsible owner is a critical miss. The skill never invents an evidence reference, never re-routes a ticket without supported facts, and never depends on Package 07 catalog content as a hard read.

## 3. Required Inputs

- `runs/{{run_id}}/run-profile.yaml`
- `{{output_root}}/06-boundaries.md`
- `{{output_root}}/07-security-stack-assessment.md`
- `{{output_root}}/08-internal-review-table.md`
- `{{output_root}}/09-missing-facts.md`
- `{{output_root}}/10-ai-action-level.md`
- `{{output_root}}/11-blueprint-match.md`
- `{{output_root}}/12-targeted-questions.md`
- `config/run-profile.validation-rules.md`
- `config/path-resolution-rules.md`
- `config/sensitive-data-rules.md`

## 4. Optional Inputs

- `{{expected_root}}/expected-findings.json` — relationship reference only.

## 5. Required Outputs

- `{{output_root}}/13-findings.md` — Markdown table with the columns: `finding_id`, `finding_category`, `component_or_flow_ref`, `concern`, `disposition`, `evidence_ref`, `owner`, `validation_ticket_needed`.

The shared prompt also writes `{{output_root}}/14-recommendations.md` (owned by `SK-RECOMMENDATION-WRITE`).

## 6. Procedure

1. Resolve run-profile variables.
2. Read RS-06..RS-12 outputs.
3. For each supported concern row in RS-08 (review table), produce one finding row using the allowed categories: `Requirement`, `Gap`, `Deficiency`, `Observation`, `Evidence Gap`.
4. Set `evidence_ref` to a row reference in RS-06, RS-07, or RS-08; never a label alone.
5. Set `owner` per the boundary type and zone. If owner is unknown, mark `unknown` rather than guess.
6. Set `validation_ticket_needed: true` when the finding requires downstream implementation evidence.
7. Write `{{output_root}}/13-findings.md`.
8. Stop before writing if any Section 7 stop condition holds.

## 7. Stop Conditions

- Required prior outputs missing.
- Run-profile unresolved or sensitive-data confirmation `false`.
- A finding lacks supported evidence.
- A finding's category would be wrong in a way that changes the owner.
- Write outside `{{output_root}}` or to the old reference workspace.
- Any prohibited execution claim.

## 8. Unknown Handling

- Owner unknown is allowed and recorded as `unknown`.
- Disposition unknown is allowed; do not promote `unknown` to `accepted`.
- Evidence-only unknowns become Evidence Gap findings, not Deficiency.

## 9. Confidence Handling

- `HIGH` — supported by named RS-06/RS-07/RS-08 row(s) and corroborating notes.
- `MEDIUM` — supported by one named row.
- `LOW` — supported by inference; flagged for SAS review.
- `UNKNOWN` — no support; the finding is dropped.

## 10. Critical Misses

- Wrong category that changes the owner.
- Finding without supported evidence.
- Inventing an evidence reference.
- Writing outside `{{output_root}}`.

## 11. Human Review Gate

The SAS reviewer must inspect each finding's category, disposition, owner, route, and evidence reference. Validation-ticket flag is reviewed before handoff.

## 12. Validation / Scoring Relationship

- Expected baseline (when present): `{{expected_root}}/expected-findings.json` (planned; defined in Build Package 10).
- Scoring category: finding/recommendation quality (shared 20 points with `SK-RECOMMENDATION-WRITE` within `SK-ACCURACY-SCORE`).
- Wrong category changing owner is a critical miss.

## 13. Direct Skill Test

```
tools/New-AisrafRun.ps1 -RunId RUN-LOCAL-SK-FINDING-TEST -SampleId sample-001-dfd-crop -Mode folder_first_test -CopySampleInputs
tools/Test-AisrafRunProfile.ps1 -RunProfilePath runs/RUN-LOCAL-SK-FINDING-TEST/run-profile.yaml -ExecutionReady
```

- Run RS-01..RS-12 first, then open [prompts/rs/10-finding-recommendation-write.prompt.md](../../prompts/rs/10-finding-recommendation-write.prompt.md).
- Expected local output: `runs/RUN-LOCAL-SK-FINDING-TEST/13-findings.md`.
- PASS = output exists; every finding has a named evidence row; categories are allowed; no wrong-owner classification.

## 14. Not In Scope

- No recommendation writing (owned by `SK-RECOMMENDATION-WRITE`).
- No PRA, adapter, connector, runtime, scoring, diagram, or release execution.
- No invention of evidence references.
