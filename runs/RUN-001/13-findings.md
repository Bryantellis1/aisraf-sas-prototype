# Findings — RUN-001
| field | value |
|---|---|
| run_id | `RUN-001` |
| sample_id | sample-001-dfd-crop |
| mode | `folder_first_test` |
| output_root | `runs/RUN-001` |
| step | RS-10 |
| prompt | prompts/rs/10-finding-recommendation-write.prompt.md |
| skill | skills/rs/SK-FINDING-CLASSIFY.md |
| owning_pra | PRA-07-FINDING-RECOMMENDER |

## Finding Rows

| finding_id | source_fact_refs | finding_statement | finding_category | severity | supporting_evidence | confidence | review_status | human_reviewer | notes |
|---|---|---|---|---|---|---|---|---|---|
| FN-01 | `06-boundaries.md#BC-05`; `08-internal-review-table.md#RT-09`; `09-missing-facts.md#MF-04` | The reviewed system crosses from BND-05 Application subnet to BND-07 External AI SaaS Provider Zone without a confirmed authorization scope at the destination, beyond the visible `SA7` service-authentication marker. | `<value-from-catalogs/review/finding-category-catalog.yaml#FC-GAP>` | `<value-from-catalogs/review/severity-catalog.yaml#SV-MEDIUM>` | F9 / F10 have `SA7` (AuthN); AZ scope remains unknown because `AZ?` is visible and no `AZ#` proof is present. | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | `<value-from-catalogs/review/review-status-catalog.yaml#RS-AWAITING-HUMAN-REVIEW>` | `SAS reviewer` | Severity selected by skill + human review; `SV-MEDIUM` reflects that AuthN is in place and the boundary is reachable today. |
| FN-02 | `07-security-stack-assessment.md#SSM-01`; `09-missing-facts.md#MF-01`; `09-missing-facts.md#MF-02` | Approved-stack and at-rest-encryption claims at CMP-10 (`S1`) and the current Data subnet store `Enc` markers are visible markers only; implementation evidence is not in the design materials. | `<value-from-catalogs/review/finding-category-catalog.yaml#FC-EVIDENCE-GAP>` | `<value-from-catalogs/review/severity-catalog.yaml#SV-MEDIUM>` | Proof-vs-signal global rule applies (`catalogs/security-stacks/proof-vs-signal-rule-catalog.yaml#SR-DIAMOND-NOT-APPROVED-STACK`, `#SR-MARKER-NOT-PROOF`). | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | `<value-from-catalogs/review/review-status-catalog.yaml#RS-AWAITING-HUMAN-REVIEW>` | `SAS reviewer` | Routes to validation notes for separate evidence collection. |
| FN-03 | `05-flows.md#F9`; `05-flows.md#F10`; `08-internal-review-table.md#RT-09`; `08-internal-review-table.md#RT-10`; `09-missing-facts.md#MF-03` | The model prompt / response on F9 / F10 may carry C4 review-IP content to or from the external AI SaaS without explicit data-class confirmation or implemented redaction. | `<value-from-catalogs/review/finding-category-catalog.yaml#FC-OBSERVATION>` | `<value-from-catalogs/review/severity-catalog.yaml#SV-LOW>` | `09-missing-facts.md#MF-03` records that F9 / F10 redaction posture is unknown while the visible tuples assert C4. | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-MEDIUM>` | `<value-from-catalogs/review/review-status-catalog.yaml#RS-AWAITING-HUMAN-REVIEW>` | `SAS reviewer` | Promotion to FC-GAP requires confirmation of C4 (or higher) class actually traversing F9 / F10 without adequate redaction. |

## Unknowns

| unknown_id | finding_id | what_is_unknown | catalog_reference_checked |
|---|---|---|---|
| UNK-17 | FN-01 | Final `severity` once AZ scope at CMP-05 is confirmed | `catalogs/review/severity-catalog.yaml` |
| UNK-18 | FN-03 | Final `finding_category` once F9 / F10 redaction and payload / response data class are confirmed | `catalogs/review/finding-category-catalog.yaml` |

## Human Review Gate Status

`<value-from-catalogs/review/review-status-catalog.yaml#RS-AWAITING-HUMAN-REVIEW>`

## Stop Conditions Recorded

None at this step. No invented finding facts. Severity and category selection remain with `skills/rs/SK-FINDING-CLASSIFY.md` plus human review.

