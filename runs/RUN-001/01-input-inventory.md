# Input Inventory — RUN-001
| field | value |
|---|---|
| run_id | `RUN-001` |
| sample_id | sample-001-dfd-crop |
| mode | `folder_first_test` |
| input_root | `runs/RUN-001/inputs` |
| output_root | `runs/RUN-001` |
| step | RS-01 |
| prompt | prompts/rs/01-input-package-read.prompt.md |
| skill | skills/rs/SK-INPUT-PACKAGE-READ.md |
| owning_pra | PRA-02-INPUT-READER |

## Inventory Table

| artifact_id | path_under_input_root | artifact_type | summary | required_for_review | confidence | notes |
|---|---|---|---|---|---|---|
| ART-01 | `dfd-crop.png` | DFD | Visible DFD image of the AI SaaS Security Review Portal. | yes | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Renders 14 components, 14 flows, 8 boundary containers, and 10 boundary crossings. |
| ART-02 | `dfd-crop.mmd` | sample-design | Mermaid source companion for `dfd-crop.png`. Reproducibility only. | optional | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Not a separate review input; supports PNG regeneration. |
| ART-03 | `dfd-legend-excerpt.md` | narrative | Legend tokens visible on the DFD with normalization paths. | yes | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | C2, C4, IA1, SA5, SA7, S1, T1, AZ?, R1, Enc. |
| ART-04 | `cloud-triage-notes.md` | narrative | Component classification narrative; AI Action Level narrative; triage uncertainties. | yes | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Open items mirror the missing-fact rows. |
| ART-05 | `review-transcript.md` | narrative | Synthetic review-call transcript covering authentication, AZ unknown discipline, S1 signal status, and KMS / Enc proof unknowns. | yes | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Role labels only; no real participants. |
| ART-06 | `intake-ticket.md` | ticket-export | Synthetic intake ticket; scope; sensitive-data exclusions; pass criteria. | yes | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | `postback_execution_status_requested: deferred`. |

## Unknowns

| unknown_id | concern | catalog_reference_for_required_value | gap |
|---|---|---|---|
| UNK-01 | None at intake. The six artifacts above resolve every required input for sample-001. | n/a | Material gaps belong to step RS-07; this step records inventory only. |

## Stop Conditions Recorded

None at this step. No stop condition is triggered at intake. Sensitive-data review is deferred to `09-missing-facts.md` and `16-validation-notes.md`; the inputs are confirmed synthetic per `intake-ticket.md` § 6 and `cloud-triage-notes.md` § 6.

