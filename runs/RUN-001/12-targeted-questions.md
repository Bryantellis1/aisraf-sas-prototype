# Targeted Questions — RUN-001
| field | value |
|---|---|
| run_id | `RUN-001` |
| sample_id | sample-001-dfd-crop |
| mode | `folder_first_test` |
| output_root | `runs/RUN-001` |
| step | RS-07 |
| prompt | prompts/rs/07-missing-fact-question-generate.prompt.md |
| skill | skills/rs/SK-TARGETED-QUESTION-GENERATE.md |
| owning_pra | PRA-06-BLUEPRINT-QUESTIONER |

## Targeted Question Rows

| question_id | question_text | source_missing_fact_id | evidence_requested | blueprint_cross_reference | owner_or_route_if_known | notes |
|---|---|---|---|---|---|---|
| TQ-01 | What is the approved-stack inventory implemented at CMP-10 Cloud Armor / WAF, and which control gates does the `S1` diamond signal correspond to? | MF-01 | Approved-stack catalogue entry; WAF / edge control-gate inventory | BP-MODEL-ENDPOINT-CALL#BP-MODEL-ENDPOINT-CALL-MMF-04 | unknown (route via validation note VN-02) | Cites `catalogs/security-stacks/proof-vs-signal-rule-catalog.yaml#SR-DIAMOND-NOT-APPROVED-STACK`. |
| TQ-02 | What KMS / key rotation / key scope protects the current Data subnet stores (CMP-04, CMP-06, CMP-07, CMP-13, CMP-14) at rest, beyond the visible `Enc` markers? | MF-02 | KMS configuration; key rotation policy; key scope | BP-API-WRITEBACK#BP-API-WRITEBACK-MMF-03 | unknown (route to data team via validation note VN-01) | Cites `catalogs/security-stacks/proof-vs-signal-rule-catalog.yaml#SR-MARKER-NOT-PROOF`. |
| TQ-03 | What data class traverses F9 / F10 between CMP-12 AI Analysis Connector and CMP-05 External AI Model Endpoint, and is prompt / response redaction implemented? | MF-03 | Sample payload; redaction logic | BP-MODEL-ENDPOINT-CALL#BP-MODEL-ENDPOINT-CALL-MMF-03; BP-AI-SAAS-INTEGRATION#BP-AI-SAAS-INTEGRATION-MMF-02 | unknown (route to AI platform owner) | Drives whether the BP-AI-SAAS-INTEGRATION match remains the primary disposition. |
| TQ-04 | What authorization scope and policy enforce the F9 / F10 model exchange between CMP-12 and CMP-05, beyond the `SA7` service authentication marker? | MF-04 | AZ policy at the SaaS endpoint; scope of vendor-side enforcement | BP-AI-SAAS-INTEGRATION#BP-AI-SAAS-INTEGRATION-MMF-03; BP-MODEL-ENDPOINT-CALL#BP-MODEL-ENDPOINT-CALL-MMF-01 | unknown (route to AI platform owner) | Cites `catalogs/security-stacks/proof-vs-signal-rule-catalog.yaml#SR-AUTHN-NOT-AUTHZ`. |

## Stop Conditions Recorded

None at this step. Every question traces to a `gap_id` in `09-missing-facts.md`. No question is a broad-checklist question. No new BP-* identifiers are introduced.

