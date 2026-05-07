---
expected_baseline_id: EXP-RS-12-TARGETED-QUESTIONS
sample_id: sample-001-dfd-crop
mirrors_template: templates/output/output-12-targeted-questions-template.md
prompt: prompts/rs/07-missing-fact-question-generate.prompt.md
skill: skills/rs/SK-TARGETED-QUESTION-GENERATE.md
owning_pra: PRA-06-BLUEPRINT-QUESTIONER
adapter: .agents/aisraf-blueprint-questioner.agent.md
target_run_output: "{{output_root}}/12-targeted-questions.md"
expected_outcome: PASS_READY_FOR_REVIEW
scoring_basis: template-aligned qualitative baseline; numeric scoring deferred to Build Package 11 run execution
package_version: v0.1.2
---

# Targeted Questions — sample-001-dfd-crop

| field | value |
|---|---|
| run_id | `{{run_id}}` |
| sample_id | sample-001-dfd-crop |
| mode | `{{mode}}` |
| output_root | `{{output_root}}` |
| step | RS-07 |
| prompt | prompts/rs/07-missing-fact-question-generate.prompt.md |
| skill | skills/rs/SK-TARGETED-QUESTION-GENERATE.md |
| owning_pra | PRA-06-BLUEPRINT-QUESTIONER |

## Targeted Question Rows

| question_id | question_text | source_missing_fact_id | evidence_requested | blueprint_cross_reference | owner_or_route_if_known | notes |
|---|---|---|---|---|---|---|
| TQ-01 | What is the approved-stack inventory implemented at CMP-03 Review API Gateway, and which control gates does the `S1` diamond signal correspond to? | MF-01 | Approved-stack catalogue entry; gateway control-gate inventory | BP-MODEL-ENDPOINT-CALL#BP-MODEL-ENDPOINT-CALL-MMF-04 | unknown (route to gateway owner via validation note VN-02) | Cites `catalogs/security-stacks/proof-vs-signal-rule-catalog.yaml#SR-DIAMOND-NOT-APPROVED-STACK`. |
| TQ-02 | What KMS / key rotation / key scope protects CMP-04 Review Metadata DB at rest, beyond the visible `E1` marker? | MF-02 | KMS configuration; key rotation policy; key scope | BP-API-WRITEBACK#BP-API-WRITEBACK-MMF-03 | unknown (route to data team via validation note VN-01) | Cites `catalogs/security-stacks/proof-vs-signal-rule-catalog.yaml#SR-MARKER-NOT-PROOF`. |
| TQ-03 | What data class is in the request payload sent on F4 from CMP-03 to the AI Analysis Service, and is prompt-content redaction implemented? | MF-03 | Sample payload; redaction logic | BP-MODEL-ENDPOINT-CALL#BP-MODEL-ENDPOINT-CALL-MMF-03; BP-AI-SAAS-INTEGRATION#BP-AI-SAAS-INTEGRATION-MMF-02 | unknown (route to AI platform owner) | Drives whether the BP-AI-SAAS-INTEGRATION match remains the primary disposition. |
| TQ-04 | What authorization scope and policy enforce calls from CMP-03 to CMP-05, beyond the `SA1` service authentication marker? | MF-04 | AZ policy at the SaaS endpoint; scope of vendor-side enforcement | BP-AI-SAAS-INTEGRATION#BP-AI-SAAS-INTEGRATION-MMF-03; BP-MODEL-ENDPOINT-CALL#BP-MODEL-ENDPOINT-CALL-MMF-01 | unknown (route to AI platform owner) | Cites `catalogs/security-stacks/proof-vs-signal-rule-catalog.yaml#SR-AUTHN-NOT-AUTHZ`. |

## Stop Conditions Recorded

None at this step. Every question traces to a `gap_id` in `09-missing-facts.md`. No question is a broad-checklist question. No new BP-* identifiers are introduced.
