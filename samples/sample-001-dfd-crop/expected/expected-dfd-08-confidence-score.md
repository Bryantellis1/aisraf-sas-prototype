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
| BND-01..08 | `02-boundary-catalog.md` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Every boundary container is named with a real architecture concept and resolves to a controlled value. | 8 rows. |
| CMP-01..14 | `03-component-catalog.md` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Every component classifies via `CER-VISIBLE-LABEL-SUPPORTS-TYPE`. | 14 rows. |
| F1 / F2 / F3 / F4 / F5 / F6 / F7 / F8 / F11 / F12 / F13 / F14 | `04-flow-inventory.md` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Visible flows with resolved tokens. | 12 rows. |
| F9 | `04-flow-inventory.md` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-MEDIUM>` | Cross-internet model-call request; visible label asserts `C4` but whether AI Connector redacts before transmission drives MF-03. | 1 row. |
| F10 | `04-flow-inventory.md` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-MEDIUM>` | Inbound model response; same MF-03 dependency on whether the response carries C4 review-IP back. | 1 row. |
| AN-01 / AN-02 / AN-03 / AN-04 / AN-05 / AN-06 / AN-08 / AN-09 / AN-10 | `05-annotation-resolution.md` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Tokens resolve cleanly to catalog entries (or to legend-anchored absence-of-`AZ#` for AN-10). | 9 rows. |
| AN-07 | `05-annotation-resolution.md` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-MEDIUM>` | `R1` is a sample-specific raw token recorded only in legend §3. | 1 row. |
| BC-01 / BC-02 / BC-03 / BC-04 / BC-05 / BC-07 / BC-08 / BC-09 | `06-boundary-crossings.md` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Visible crossings. | 8 rows. |
| BC-06 / BC-10 | `06-boundary-crossings.md` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-MEDIUM>` | Inbound model response and Atlassian formatted_only handoff recorded conservatively. | 2 rows. |
| CS-01..09 | `07-control-signals.md` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Markers visible (or visibly missing for CS-09); recorded as signals. | 9 rows. |
| CS-10 | `07-control-signals.md` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-MEDIUM>` | `R1` replication marker recorded under legend-anchored sample-specific resolution. | 1 row. |

## Confidence Level Distribution

| source_artifact | high | medium | low | unknown |
|---|---|---|---|---|
| `02-boundary-catalog.md` | 8 | 0 | 0 | 0 |
| `03-component-catalog.md` | 14 | 0 | 0 | 0 |
| `04-flow-inventory.md` | 12 | 2 | 0 | 0 |
| `05-annotation-resolution.md` | 9 | 1 | 0 | 0 |
| `06-boundary-crossings.md` | 8 | 2 | 0 | 0 |
| `07-control-signals.md` | 9 | 1 | 0 | 0 |

This distribution is descriptive only. No aggregate accuracy score is produced here.

## Stop Conditions Recorded

None at this step.
