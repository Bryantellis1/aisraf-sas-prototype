---
expected_baseline_id: EXP-DFD-08-CONFIDENCE-SCORE
sample_id: sample-001-dfd-crop
mirrors_template: templates/output/output-dfd-08-confidence-score-template.md
prompt: prompts/dfd/09-confidence-score.prompt.md
skill: skills/dfd/SK-DFD-08-CONFIDENCE-SCORE.md
owning_pra: PRA-03-DFD-EXTRACTOR
adapter: .agents/aisraf-dfd-extractor.agent.md
target_run_output: "{{output_root}}/dfd/08-confidence-score.md"
expected_outcome: PASS_READY_FOR_REVIEW
scoring_basis: template-aligned qualitative baseline; numeric scoring deferred to Build Package 11 run execution
package_version: v0.1.2
---

# DFD Confidence Score — sample-001-dfd-crop

| field | value |
|---|---|
| run_id | `{{run_id}}` |
| sample_id | sample-001-dfd-crop |
| mode | `{{mode}}` |
| output_root | `{{output_root}}` |
| dfd_step | DFD-08 |
| prompt | prompts/dfd/09-confidence-score.prompt.md |
| skill | skills/dfd/SK-DFD-08-CONFIDENCE-SCORE.md |
| owning_pra | PRA-03-DFD-EXTRACTOR |
| disclaimer | This is a per-row extraction confidence assignment. It is not an accuracy score. |

## Per-Row Confidence Assignments

| row_id | source_artifact | confidence | reason | notes |
|---|---|---|---|---|
| BND-01..04 | `02-boundary-catalog.md` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Every boundary container is named in the DFD subgraph. | 4 rows. |
| CMP-01..08 | `03-component-catalog.md` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Every component classifies via `CER-VISIBLE-LABEL-SUPPORTS-TYPE`. | 8 rows. |
| F1 / F2 / F3 / F6 / F7 / F8 | `04-flow-inventory.md` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Visible flows with resolved tokens. | 6 rows. |
| F4 | `04-flow-inventory.md` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-MEDIUM>` | Request payload class is `DC-UNKNOWN`. | 1 row. |
| F5 | `04-flow-inventory.md` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-LOW>` | Response payload class is `DC-UNKNOWN`. | 1 row. |
| AN-01..07, AN-09, AN-10 | `05-annotation-resolution.md` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Tokens resolve cleanly. | 9 rows. |
| AN-08 | `05-annotation-resolution.md` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-MEDIUM>` | C4P maps under DC-C5P raw_pattern. | 1 row. |
| BC-01 / BC-02 / BC-04 / BC-05 / BC-06 | `06-boundary-crossings.md` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Visible crossings. | 5 rows. |
| BC-03 / BC-07 | `06-boundary-crossings.md` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-MEDIUM>` | Inbound response and tool-surface crossings recorded conservatively. | 2 rows. |
| CS-01..04 | `07-control-signals.md` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Markers visible; recorded as signals. | 4 rows. |
| CS-05 | `07-control-signals.md` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-MEDIUM>` | Missing-marker observation. | 1 row. |

## Confidence Level Distribution

| source_artifact | high | medium | low | unknown |
|---|---|---|---|---|
| `02-boundary-catalog.md` | 4 | 0 | 0 | 0 |
| `03-component-catalog.md` | 8 | 0 | 0 | 0 |
| `04-flow-inventory.md` | 6 | 1 | 1 | 0 |
| `05-annotation-resolution.md` | 9 | 1 | 0 | 0 |
| `06-boundary-crossings.md` | 5 | 2 | 0 | 0 |
| `07-control-signals.md` | 4 | 1 | 0 | 0 |

This distribution is descriptive only. No aggregate accuracy score is produced here.

## Stop Conditions Recorded

None at this step.
