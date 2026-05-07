---
expected_baseline_id: EXP-RS-01-INPUT-INVENTORY
sample_id: sample-001-dfd-crop
mirrors_template: templates/output/output-01-input-inventory-template.md
prompt: prompts/rs/01-input-package-read.prompt.md
skill: skills/rs/SK-INPUT-PACKAGE-READ.md
owning_pra: PRA-02-INPUT-READER
adapter: .agents/aisraf-input-reader.agent.md
target_run_output: "{{output_root}}/01-input-inventory.md"
expected_outcome: PASS_READY_FOR_REVIEW
scoring_basis: template-aligned qualitative baseline; numeric scoring deferred to Build Package 11 run execution
package_version: v0.1.2
---

# Input Inventory — sample-001-dfd-crop

| field | value |
|---|---|
| run_id | `{{run_id}}` |
| sample_id | sample-001-dfd-crop |
| mode | `{{mode}}` |
| input_root | `{{input_root}}` |
| output_root | `{{output_root}}` |
| step | RS-01 |
| prompt | prompts/rs/01-input-package-read.prompt.md |
| skill | skills/rs/SK-INPUT-PACKAGE-READ.md |
| owning_pra | PRA-02-INPUT-READER |

## Inventory Table

| artifact_id | path_under_input_root | artifact_type | summary | required_for_review | confidence | notes |
|---|---|---|---|---|---|---|
| ART-01 | `dfd-crop.png` | DFD | Visible DFD image of the AI SaaS Security Review Portal. | yes | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Renders 8 components, 8 flows, 4 boundaries. |
| ART-02 | `dfd-crop.mmd` | sample-design | Mermaid source companion for `dfd-crop.png`. Reproducibility only. | optional | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Not a separate review input; supports PNG regeneration. |
| ART-03 | `dfd-legend-excerpt.md` | narrative | Legend tokens visible on the DFD with normalization paths. | yes | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | C2, C4, C4P, IA1, SA1, S1, T1, E1. |
| ART-04 | `cloud-triage-notes.md` | narrative | Component classification narrative; AI Action Level narrative; triage uncertainties. | yes | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Open items mirror the missing-fact rows. |
| ART-05 | `review-transcript.md` | narrative | Synthetic review-call transcript covering authentication, AZ scope on F4, S1 status, KMS unknowns. | yes | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Role labels only; no real participants. |
| ART-06 | `intake-ticket.md` | ticket-export | Synthetic intake ticket; scope; sensitive-data exclusions; pass criteria. | yes | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | `postback_execution_status_requested: deferred`. |

## Unknowns

| unknown_id | concern | catalog_reference_for_required_value | gap |
|---|---|---|---|
| UNK-01 | None at intake. The six artifacts above resolve every required input for sample-001. | n/a | Material gaps belong to step RS-07; this step records inventory only. |

## Stop Conditions Recorded

None at this step. No stop condition is triggered at intake. Sensitive-data review is deferred to `09-missing-facts.md` and `16-validation-notes.md`; the inputs are confirmed synthetic per `intake-ticket.md` § 6 and `cloud-triage-notes.md` § 6.
