---
skill_id: SK-REVIEW-BLUEPRINT-MATCH
skill_name: Review Blueprint Match
owning_build_package: Build Package 05
skill_family: rs
status: active
mapped_prompt_id: PR-RS-09
mapped_prompt_file: prompts/rs/09-blueprint-match.prompt.md
future_pra_owner: PRA-BLUEPRINT-MATCHER (planned; defined in Build Package 06)
review_step: RS-11
---

# SK-REVIEW-BLUEPRINT-MATCH — Review Blueprint Match

## 1. Identity

- skill_id: `SK-REVIEW-BLUEPRINT-MATCH`
- skill_name: Review Blueprint Match
- owning_build_package: Build Package 05 — Skills and skill registry.
- skill_family: `rs`
- status: `active`
- mapped_prompt_id: `PR-RS-09`
- mapped_prompt_file: [prompts/rs/09-blueprint-match.prompt.md](../../prompts/rs/09-blueprint-match.prompt.md)
- future_pra_owner: `PRA-BLUEPRINT-MATCHER` (planned; defined in Build Package 06).
- review_step: `RS-11`

## 2. Purpose

Match the design shape to the closest Review Blueprint using the supported facts in RS-04..RS-08 and RS-10. The skill records a primary match and any secondary candidates with explicit match evidence and any gaps versus expected controls. The skill never claims runtime approval, never invents a design shape, and never depends on a Build Package 08 blueprint as a hard read.

## 3. Required Inputs

- `runs/{{run_id}}/run-profile.yaml`
- `{{output_root}}/04-components.md`
- `{{output_root}}/05-flows.md`
- `{{output_root}}/06-boundaries.md`
- `{{output_root}}/08-internal-review-table.md`
- `{{output_root}}/10-ai-action-level.md`
- `config/run-profile.validation-rules.md`
- `config/path-resolution-rules.md`
- `config/sensitive-data-rules.md`

## 4. Optional Inputs

- `{{output_root}}/09-missing-facts.md`
- `blueprints/` directory (planned; defined in Build Package 08) — when blueprints exist, match against them; until then, record `primary_blueprint: unknown` with a clear "no blueprints catalog yet" note.
- `{{expected_root}}/expected-blueprint-match.json` — relationship reference only.

## 5. Required Outputs

- `{{output_root}}/11-blueprint-match.md` — Markdown table with the columns: `primary_blueprint`, `match_evidence`, `secondary_candidates`, `gaps_vs_expected_controls`, `runtime_approval_claimed`.

## 6. Procedure

1. Resolve run-profile variables.
2. Read the required prior outputs.
3. If a Build Package 08 blueprint catalog is available, evaluate match against each candidate using component, flow, boundary, and AI Action Level facts.
4. If no catalog is available, record `primary_blueprint: unknown` with a note that the catalog is `(planned; defined in Build Package 08)` and that `runtime_approval_claimed: false`.
5. List `gaps_vs_expected_controls` from missing or `not_visible` security-stack rows in RS-07.
6. Always set `runtime_approval_claimed: false`. The skill never claims runtime approval.
7. Write `{{output_root}}/11-blueprint-match.md`.
8. Stop before writing if any Section 7 stop condition holds.

## 7. Stop Conditions

- Required prior outputs missing.
- Run-profile unresolved or sensitive-data confirmation `false`.
- The output would claim runtime approval.
- The output would invent a design shape not supported by RS-04..RS-08.
- Write outside `{{output_root}}` or to the old reference workspace.
- Any prohibited execution claim.

## 8. Unknown Handling

- `primary_blueprint: unknown` is allowed and required when no blueprints catalog exists.
- Secondary candidates are listed only when supported.
- Gaps versus expected controls reference RS-07 rows by `boundary_ref`.

## 9. Confidence Handling

- `HIGH` — clear match with multiple supported facts and an existing blueprint.
- `MEDIUM` — match supported but one or more dimensions are `unknown`.
- `LOW` — only one supporting fact; multiple plausible candidates.
- `UNKNOWN` — no blueprint catalog or insufficient facts.

## 10. Critical Misses

- Claiming runtime approval.
- Inventing a blueprint or design shape.
- Hard-depending on a Build Package 08 blueprint that does not exist.
- Writing outside `{{output_root}}`.

## 11. Human Review Gate

The SAS reviewer must confirm the chosen design shape and explicitly accept `unknown` when the catalog is absent.

## 12. Validation / Scoring Relationship

- Expected baseline (when present): `{{expected_root}}/expected-blueprint-match.json` (planned; defined in Build Package 10).
- Scoring category: blueprint match (10 points within `SK-ACCURACY-SCORE`).
- Runtime approval claim is a critical miss.

## 13. Direct Skill Test

```
tools/New-AisrafRun.ps1 -RunId RUN-LOCAL-SK-BLUEPRINT-TEST -SampleId sample-001-dfd-crop -Mode folder_first_test -CopySampleInputs
tools/Test-AisrafRunProfile.ps1 -RunProfilePath runs/RUN-LOCAL-SK-BLUEPRINT-TEST/run-profile.yaml -ExecutionReady
```

- Run RS-01..RS-08 and RS-10 first, then open [prompts/rs/09-blueprint-match.prompt.md](../../prompts/rs/09-blueprint-match.prompt.md).
- Expected local output: `runs/RUN-LOCAL-SK-BLUEPRINT-TEST/11-blueprint-match.md`.
- PASS = output exists; blueprint match is supported or `unknown`; `runtime_approval_claimed: false`.

## 14. Not In Scope

- No blueprint catalog creation (Build Package 08).
- No runtime approval claim.
- No PRA, adapter, connector, runtime, scoring, diagram, or release execution.
