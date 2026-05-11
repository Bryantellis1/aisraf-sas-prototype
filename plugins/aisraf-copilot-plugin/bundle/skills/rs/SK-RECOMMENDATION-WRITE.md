---
skill_id: SK-RECOMMENDATION-WRITE
skill_name: Recommendation Write
owning_build_package: Build Package 05
skill_family: rs
status: active
mapped_prompt_id: PR-RS-10
mapped_prompt_file: prompts/rs/10-finding-recommendation-write.prompt.md
future_pra_owner: PRA-RISK-WRITER (planned; defined in Build Package 06)
review_step: RS-14
---

# SK-RECOMMENDATION-WRITE — Recommendation Write

## 1. Identity

- skill_id: `SK-RECOMMENDATION-WRITE`
- skill_name: Recommendation Write
- owning_build_package: Build Package 05 — Skills and skill registry.
- skill_family: `rs`
- status: `active`
- mapped_prompt_id: `PR-RS-10`
- mapped_prompt_file: [prompts/rs/10-finding-recommendation-write.prompt.md](../../prompts/rs/10-finding-recommendation-write.prompt.md) (shared with `SK-FINDING-CLASSIFY`)
- future_pra_owner: `PRA-RISK-WRITER` (planned; defined in Build Package 06).
- review_step: `RS-14`

## 2. Purpose

Write clear security recommendations from supported findings. Each recommendation names the component or flow, the concern, the expected control, the owner if known, and the next action. The skill never invents a control, owner, or evidence reference. Recommendations cite findings, not labels.

## 3. Required Inputs

- `runs/{{run_id}}/run-profile.yaml`
- `{{output_root}}/06-boundaries.md`
- `{{output_root}}/07-security-stack-assessment.md`
- `{{output_root}}/08-internal-review-table.md`
- `{{output_root}}/11-blueprint-match.md`
- `{{output_root}}/13-findings.md`
- `config/run-profile.validation-rules.md`
- `config/path-resolution-rules.md`
- `config/sensitive-data-rules.md`

## 4. Optional Inputs

- `{{output_root}}/12-targeted-questions.md`
- `{{expected_root}}/expected-recommendations.json` — relationship reference only.

## 5. Required Outputs

- `{{output_root}}/14-recommendations.md` — Markdown table with the columns: `rec_id`, `finding_ref`, `component_or_flow_ref`, `concern`, `expected_control`, `owner`, `next_action`, `priority`.

The shared prompt also writes `{{output_root}}/13-findings.md` (owned by `SK-FINDING-CLASSIFY`).

## 6. Procedure

1. Resolve run-profile variables.
2. Read RS-13 plus the supporting RS-06..RS-08 and RS-11 outputs.
3. For each finding, write at most one recommendation that names the expected control and next action.
4. Set `owner` from the finding row. If unknown, mark `unknown`.
5. Set `priority` (P1, P2, P3, P4) from concern severity and boundary exposure; do not invent a priority for `unknown` evidence.
6. Write `{{output_root}}/14-recommendations.md`.
7. Stop before writing if any Section 7 stop condition holds.

## 7. Stop Conditions

- RS-13 missing.
- Run-profile unresolved or sensitive-data confirmation `false`.
- The recommendation would invent a control, owner, or evidence.
- The recommendation would claim implementation proof.
- Write outside `{{output_root}}` or to the old reference workspace.
- Any prohibited execution claim.

## 8. Unknown Handling

- Owner unknown is allowed.
- Expected control unknown is allowed; in that case the recommendation reads `expected_control: unknown` and the next action is to obtain supporting evidence.
- Unknown priority is allowed when concern severity cannot be supported.

## 9. Confidence Handling

- `HIGH` — finding is supported, expected control is well-known for the boundary type, and owner is known.
- `MEDIUM` — finding supported but owner or control is `unknown`.
- `LOW` — finding supported only by inference; recommendation is flagged for SAS review.
- `UNKNOWN` — drop the recommendation; do not include.

## 10. Critical Misses

- Inventing a control, owner, or evidence.
- Writing a recommendation that does not cite a finding.
- Claiming implementation proof.
- Writing outside `{{output_root}}`.

## 11. Human Review Gate

The SAS reviewer approves recommendation wording before ticket-ready handoff.

## 12. Validation / Scoring Relationship

- Expected baseline (when present): `{{expected_root}}/expected-recommendations.json` (planned; defined in Build Package 10).
- Scoring category: finding/recommendation quality (shared 20 points with `SK-FINDING-CLASSIFY` within `SK-ACCURACY-SCORE`).
- Invented control is a critical miss.

## 13. Direct Skill Test

```
tools/New-AisrafRun.ps1 -RunId RUN-LOCAL-SK-REC-TEST -SampleId sample-001-dfd-crop -Mode folder_first_test -CopySampleInputs
tools/Test-AisrafRunProfile.ps1 -RunProfilePath runs/RUN-LOCAL-SK-REC-TEST/run-profile.yaml -ExecutionReady
```

- Run RS-01..RS-13 first, then open [prompts/rs/10-finding-recommendation-write.prompt.md](../../prompts/rs/10-finding-recommendation-write.prompt.md).
- Expected local output: `runs/RUN-LOCAL-SK-REC-TEST/14-recommendations.md`.
- PASS = output exists; every recommendation cites a finding; no invented control or owner.

## 14. Not In Scope

- No finding classification (owned by `SK-FINDING-CLASSIFY`).
- No PRA, adapter, connector, runtime, scoring, diagram, or release execution.
- No implementation-proof claim.
