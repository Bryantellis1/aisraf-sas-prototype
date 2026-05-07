---
expected_baseline_id: EXP-RS-17-ACCURACY-SCORE
sample_id: sample-001-dfd-crop
mirrors_template: templates/output/output-17-accuracy-score-template.md
prompt: prompts/rs/13-accuracy-score.prompt.md
skill: skills/rs/SK-ACCURACY-SCORE.md
owning_pra: PRA-08-HANDOFF-QA-SCORER
adapter: .agents/aisraf-handoff-qa-scorer.agent.md
target_run_output: "{{output_root}}/17-accuracy-score.md"
legacy_reference_score: 151/160 (v0.01 sample-001 expected baseline; not v0.1.2 truth)
v0_1_2_expected_verdict: PASS_READY_FOR_REVIEW
scoring_basis: template-aligned qualitative baseline until Build Package 11 run execution validates numeric scoring
expected_outcome: PASS_READY_FOR_REVIEW
package_version: v0.1.2
---

# Accuracy Score — sample-001-dfd-crop

| field | value |
|---|---|
| run_id | `{{run_id}}` |
| sample_id | sample-001-dfd-crop |
| mode | `{{mode}}` |
| expected_root | `{{expected_root}}` |
| output_root | `{{output_root}}` |
| step | RS-13 |
| prompt | prompts/rs/13-accuracy-score.prompt.md |
| skill | skills/rs/SK-ACCURACY-SCORE.md |
| owning_pra | PRA-08-HANDOFF-QA-SCORER |

## Scoring Eligibility Check

| gate | value |
|---|---|
| scoring_enabled | [copy from runs/{{run_id}}/run-profile.yaml#scoring_enabled] |
| expected_baseline_required | [copy from runs/{{run_id}}/run-profile.yaml#expected_baseline_required] |
| expected_root_populated | true (`samples/sample-001-dfd-crop/expected/` carries 26 baselines: 17 RS + 9 DFD) |
| scoring_runs | true when `scoring_enabled: true`, `expected_baseline_required: true`, and `expected_root_populated: true` |

## Per-Output Comparison Table

The numeric per-row comparison is produced by `skills/rs/SK-ACCURACY-SCORE.md` at run time. This baseline records the **expected per-output match shape** so a comparator can be wired up in Build Package 11.

| output_artifact | baseline_artifact | comparison_result | unknowns_at_extract_time | confidence | notes |
|---|---|---|---|---|---|
| `{{output_root}}/01-input-inventory.md` | `{{expected_root}}/expected-01-input-inventory.md` | match | 0 | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | All six artifacts present with high-confidence rows. |
| `{{output_root}}/02-visible-dfd-objects.md` | `{{expected_root}}/expected-02-visible-dfd-objects.md` | match | 0 | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | 8 components + 4 boundaries visible. |
| `{{output_root}}/03-legend-normalization.md` | `{{expected_root}}/expected-03-legend-normalization.md` | match | 0 | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | C4P entry recorded under `DC-C5P` raw_pattern with medium-confidence note. |
| `{{output_root}}/04-components.md` | `{{expected_root}}/expected-04-components.md` | match | 0 | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | 8 components classified by visible evidence. |
| `{{output_root}}/05-flows.md` | `{{expected_root}}/expected-05-flows.md` | partial_match | 2 | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-MEDIUM>` | F4 / F5 data class is honestly `unknown`. |
| `{{output_root}}/06-boundaries.md` | `{{expected_root}}/expected-06-boundaries.md` | match | 0 | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | 4 boundaries; 7 boundary crossings. |
| `{{output_root}}/07-security-stack-assessment.md` | `{{expected_root}}/expected-07-security-stack-assessment.md` | partial_match | 2 | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | All marker rows are `signal`; AZ scope on F4 is honestly unknown. |
| `{{output_root}}/08-internal-review-table.md` | `{{expected_root}}/expected-08-internal-review-table.md` | partial_match | 4 | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-MEDIUM>` | RT-04 / RT-05 carry `DC-UNKNOWN` and `AZ-UNKNOWN`. |
| `{{output_root}}/09-missing-facts.md` | `{{expected_root}}/expected-09-missing-facts.md` | match | 0 | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | 4 material missing facts; all blueprint cross-references resolve. |
| `{{output_root}}/10-ai-action-level.md` | `{{expected_root}}/expected-10-ai-action-level.md` | match | 0 | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | `AAL-L3` with `CL-MEDIUM`. |
| `{{output_root}}/11-blueprint-match.md` | `{{expected_root}}/expected-11-blueprint-match.md` | match | 0 | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | 4 dispositions across the four-state model. |
| `{{output_root}}/12-targeted-questions.md` | `{{expected_root}}/expected-12-targeted-questions.md` | match | 0 | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | 4 questions, all material. |
| `{{output_root}}/13-findings.md` | `{{expected_root}}/expected-13-findings.md` | match | 0 | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | 3 findings with allowed categories and supported facts. |
| `{{output_root}}/14-recommendations.md` | `{{expected_root}}/expected-14-recommendations.md` | match | 0 | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | 3 recommendations; owners remain `unknown` honestly. |
| `{{output_root}}/15-handoff-pack.md` | `{{expected_root}}/expected-15-handoff-pack.md` | match | 0 | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Twelve required sections present; design-review only. |
| `{{output_root}}/16-validation-notes.md` | `{{expected_root}}/expected-16-validation-notes.md` | match | 0 | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | 2 validation notes, separation_confirmed yes. |

## Critical Miss Status

`none` — at this expected-baseline level. The 12 critical-miss vocabulary categories (per `prompts/rs/13-accuracy-score.prompt.md`) are honestly absent in the baseline:

- No `C5` / `PCI` token is present in the sample, so neither "missed" nor "invented" applies.
- Internet-facing boundary BC-01 is captured.
- `S1` is recorded as `signal` only; no security-stack presence is asserted.
- F4 model call and F8 tool call are captured.
- AAL-L3 is supported by HITL evidence.
- Blueprint match disposition (BP-AI-SAAS-INTEGRATION matched) is supported by F4 + BC-02 evidence.
- All targeted questions are material (not broad-checklist).
- Every finding traces to a supported fact.
- Every recommendation traces to a finding.
- Implementation-validation content is separated into `16-validation-notes.md`.
- Output writes go under `{{output_root}}` only; no run output, runtime, cloud, or release artefact is produced.

## Qualitative Score / Verdict

`PASS_READY_FOR_REVIEW` — template-aligned qualitative baseline. Numeric scoring (e.g., the v0.01 reference 151/160 from the legacy 160-point model) is **not pinned as v0.1.2 truth**. The numeric verdict is produced by `skills/rs/SK-ACCURACY-SCORE.md` at run time once Build Package 11 lands and the v0.1.2 scoring rubric is governed.

Legacy reference (informational only): the v0.01 sample-001 expected baseline carried 151/160 PASS at the legacy 160-point model. That number is **not** asserted as v0.1.2 ground truth and must not be used to lower the v0.1.2 expected-score threshold to force a pass.

## Stop Conditions Recorded

None at this step. Baselines under `{{expected_root}}` are read-only. The `expected_score_threshold` is not lowered. No `qualitative_score` is produced outside `SK-ACCURACY-SCORE`.
