# Accuracy Score — RUN-001
| field | value |
|---|---|
| run_id | `RUN-001` |
| sample_id | sample-001-dfd-crop |
| mode | `folder_first_test` |
| expected_root | `samples/sample-001-dfd-crop/expected` |
| output_root | `runs/RUN-001` |
| step | RS-13 |
| prompt | prompts/rs/13-accuracy-score.prompt.md |
| skill | skills/rs/SK-ACCURACY-SCORE.md |
| owning_pra | PRA-08-HANDOFF-QA-SCORER |

## Scoring Eligibility Check

| gate | value |
|---|---|
| scoring_enabled | true |
| expected_baseline_required | true |
| expected_root_populated | true (`samples/sample-001-dfd-crop/expected/` carries 26 baselines: 17 RS + 9 DFD) |
| scoring_runs | true when `scoring_enabled: true`, `expected_baseline_required: true`, and `expected_root_populated: true` |

## Per-Output Comparison Table

The numeric per-row comparison is produced by `skills/rs/SK-ACCURACY-SCORE.md` at run time. This baseline records the **expected per-output match shape** so a comparator can be wired up in Build Package 11.

| output_artifact | baseline_artifact | comparison_result | unknowns_at_extract_time | confidence | notes |
|---|---|---|---|---|---|
| `runs/RUN-001/01-input-inventory.md` | `samples/sample-001-dfd-crop/expected/expected-01-input-inventory.md` | match | 0 | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | All six artifacts present with high-confidence rows. |
| `runs/RUN-001/02-visible-dfd-objects.md` | `samples/sample-001-dfd-crop/expected/expected-02-visible-dfd-objects.md` | match | 0 | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | 14 components + 8 boundary containers visible. |
| `runs/RUN-001/03-legend-normalization.md` | `samples/sample-001-dfd-crop/expected/expected-03-legend-normalization.md` | match | 0 | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | IA1 / SA5 / SA7 / AZ? / Enc tokens recorded under corrected 4-token flow grammar and storage-marker rules. |
| `runs/RUN-001/04-components.md` | `samples/sample-001-dfd-crop/expected/expected-04-components.md` | match | 0 | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | 14 components classified by visible evidence. |
| `runs/RUN-001/05-flows.md` | `samples/sample-001-dfd-crop/expected/expected-05-flows.md` | partial_match | 2 | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-MEDIUM>` | F9 / F10 redaction and data-class posture are honestly unknown. |
| `runs/RUN-001/06-boundaries.md` | `samples/sample-001-dfd-crop/expected/expected-06-boundaries.md` | match | 0 | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | 8 boundary containers; 10 boundary crossings. |
| `runs/RUN-001/07-security-stack-assessment.md` | `samples/sample-001-dfd-crop/expected/expected-07-security-stack-assessment.md` | partial_match | 2 | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | All marker rows are `signal`; AZ scope remains unknown on every IA# / SA# flow unless visibly proven. |
| `runs/RUN-001/08-internal-review-table.md` | `samples/sample-001-dfd-crop/expected/expected-08-internal-review-table.md` | partial_match | 4 | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-MEDIUM>` | RT-09 / RT-10 carry the external AI model exchange uncertainty; RT-14 records formatted_only handoff without post-back. |
| `runs/RUN-001/09-missing-facts.md` | `samples/sample-001-dfd-crop/expected/expected-09-missing-facts.md` | match | 0 | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | 4 material missing facts; all blueprint cross-references resolve. |
| `runs/RUN-001/10-ai-action-level.md` | `samples/sample-001-dfd-crop/expected/expected-10-ai-action-level.md` | match | 0 | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | `AAL-L3` with `CL-MEDIUM`. |
| `runs/RUN-001/11-blueprint-match.md` | `samples/sample-001-dfd-crop/expected/expected-11-blueprint-match.md` | match | 0 | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | 4 dispositions across the four-state model. |
| `runs/RUN-001/12-targeted-questions.md` | `samples/sample-001-dfd-crop/expected/expected-12-targeted-questions.md` | match | 0 | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | 4 questions, all material. |
| `runs/RUN-001/13-findings.md` | `samples/sample-001-dfd-crop/expected/expected-13-findings.md` | match | 0 | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | 3 findings with allowed categories and supported facts. |
| `runs/RUN-001/14-recommendations.md` | `samples/sample-001-dfd-crop/expected/expected-14-recommendations.md` | match | 0 | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | 3 recommendations; owners remain `unknown` honestly. |
| `runs/RUN-001/15-handoff-pack.md` | `samples/sample-001-dfd-crop/expected/expected-15-handoff-pack.md` | match | 0 | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Twelve required sections present; design-review only. |
| `runs/RUN-001/16-validation-notes.md` | `samples/sample-001-dfd-crop/expected/expected-16-validation-notes.md` | match | 0 | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | 2 validation notes, separation_confirmed yes. |

## Critical Miss Status

`none` — at this expected-baseline level. The 12 critical-miss vocabulary categories (per `prompts/rs/13-accuracy-score.prompt.md`) are honestly absent in the baseline:

- No `C5` / `PCI` token is present in the sample, so neither "missed" nor "invented" applies.
- Internet-facing boundary BC-01 is captured.
- `S1` is recorded as `signal` only; no security-stack presence is asserted.
- F9 / F10 model prompt / response and F14 formatted-only tool call are captured.
- AAL-L3 is supported by HITL evidence.
- Blueprint match disposition (BP-AI-SAAS-INTEGRATION matched) is supported by F9 + BC-05 evidence, with BC-06 recording the inbound model response.
- All targeted questions are material (not broad-checklist).
- Every finding traces to a supported fact.
- Every recommendation traces to a finding.
- Implementation-validation content is separated into `16-validation-notes.md`.
- Output writes go under `runs/RUN-001` only; no run output, runtime, cloud, or release artefact is produced.

## Qualitative Score / Verdict

`PASS_READY_FOR_REVIEW` — template-aligned qualitative baseline. Numeric scoring (e.g., the v0.01 reference 151/160 from the legacy 160-point model) is **not pinned as v0.1.2 truth**. The numeric verdict is produced by `skills/rs/SK-ACCURACY-SCORE.md` at run time once Build Package 11 lands and the v0.1.2 scoring rubric is governed.

Legacy reference (informational only): the v0.01 sample-001 expected baseline carried 151/160 PASS at the legacy 160-point model. That number is **not** asserted as v0.1.2 ground truth and must not be used to lower the v0.1.2 expected-score threshold to force a pass.

## Stop Conditions Recorded

None at this step. Baselines under `samples/sample-001-dfd-crop/expected` are read-only. The `expected_score_threshold` is not lowered. No `qualitative_score` is produced outside `SK-ACCURACY-SCORE`.

