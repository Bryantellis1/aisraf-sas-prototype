# Recommendations — RUN-001
| field | value |
|---|---|
| run_id | `RUN-001` |
| sample_id | sample-001-dfd-crop |
| mode | `folder_first_test` |
| output_root | `runs/RUN-001` |
| step | RS-10 |
| prompt | prompts/rs/10-finding-recommendation-write.prompt.md |
| skill | skills/rs/SK-RECOMMENDATION-WRITE.md |
| owning_pra | PRA-07-FINDING-RECOMMENDER |

## Recommendation Rows

| recommendation_id | source_finding_id | recommendation_type | recommendation_statement | supporting_concern | expected_next_action | owner_or_route_if_known | confidence | review_status | unknown_fields | notes |
|---|---|---|---|---|---|---|---|---|---|---|
| REC-01 | FN-02 | `<value-from-catalogs/review/recommendation-type-catalog.yaml#RT-REQUEST-OWNER-OR-EVIDENCE>` | Request the approved-stack inventory record for CMP-10 Cloud Armor / WAF and confirm which control gates the visible `S1` diamond corresponds to. | Approved-stack scope at Cloud Armor / WAF (MF-01) is unknown. | The edge-control owner provides the approved-stack inventory entry that maps to the deployed WAF controls; reviewer accepts or routes the gap to a validation ticket. | unknown (`[copy from runs/RUN-001/run-profile.yaml#operator_name]` may identify the edge-control owner) | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | `<value-from-catalogs/review/review-status-catalog.yaml#RS-AWAITING-HUMAN-REVIEW>` | owner | No invented owner. Recommendation cites MF-01; routes to VN-02 if evidence is not produced before handoff. |
| REC-02 | FN-02 | `<value-from-catalogs/review/recommendation-type-catalog.yaml#RT-ROUTE-TO-VALIDATION-TICKET>` | Route at-rest encryption proof for the current Data subnet stores (CMP-04, CMP-06, CMP-07, CMP-13, CMP-14: KMS, key rotation, key scope) to a separate validation ticket; handoff pack remains design-review only. | At-rest encryption proof on the current Data subnet stores (MF-02) is unknown beyond the `Enc` markers. | Validation ticket is opened; data team supplies KMS configuration and key-management evidence; the validation ticket is tracked separately from the handoff pack. | unknown (`[copy from runs/RUN-001/run-profile.yaml#operator_name]` may identify the data-team owner) | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | `<value-from-catalogs/review/review-status-catalog.yaml#RS-AWAITING-HUMAN-REVIEW>` | owner | Cross-references VN-01. |
| REC-03 | FN-01, FN-03 | `<value-from-catalogs/review/recommendation-type-catalog.yaml#RT-DEFINE-SCOPE>` | Define and confirm the data-class scope and authorization policy for the F9 / F10 model exchange between CMP-12 AI Analysis Connector and CMP-05 External AI Model Endpoint, including request / response redaction policy. | F9 / F10 to and from the external AI SaaS may carry C4 review-IP content (MF-03) and authorization scope at the SaaS endpoint is unknown (MF-04). | AI platform owner documents the agreed payload / response class scope, redaction approach, and AZ policy before pre-deployment sign-off. | unknown (AI platform owner) | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | `<value-from-catalogs/review/review-status-catalog.yaml#RS-AWAITING-HUMAN-REVIEW>` | owner | Resolves the BP-MODEL-ENDPOINT-CALL `candidate` disposition vs the BP-AI-SAAS-INTEGRATION `matched` primary. |

## Unknowns

| unknown_id | recommendation_id | unresolved_field | notes |
|---|---|---|---|
| UNK-19 | REC-01 | owner | edge-control owner is not named in the inputs |
| UNK-20 | REC-02 | owner | data-team owner is not named in the inputs |
| UNK-21 | REC-03 | owner | AI platform owner is not named in the inputs |

## Human Review Gate Status

`<value-from-catalogs/review/review-status-catalog.yaml#RS-AWAITING-HUMAN-REVIEW>`

## Stop Conditions Recorded

None at this step. No invented controls, owners, or evidence. Every recommendation traces to a finding in `13-findings.md` and a missing fact in `09-missing-facts.md`.

