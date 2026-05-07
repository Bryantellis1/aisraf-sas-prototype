---
expected_baseline_id: EXP-RS-13-FINDINGS
sample_id: sample-001-dfd-crop
mirrors_template: templates/output/output-13-findings-template.md
prompt: prompts/rs/10-finding-recommendation-write.prompt.md
skill: skills/rs/SK-FINDING-CLASSIFY.md
owning_pra: PRA-07-FINDING-RECOMMENDER
adapter: .agents/aisraf-finding-recommender.agent.md
target_run_output: "{{output_root}}/13-findings.md"
expected_outcome: PASS_READY_FOR_REVIEW
scoring_basis: template-aligned qualitative baseline; numeric scoring deferred to Build Package 11 run execution
package_version: v0.1.2
---

# Findings — sample-001-dfd-crop

| field | value |
|---|---|
| run_id | `{{run_id}}` |
| sample_id | sample-001-dfd-crop |
| mode | `{{mode}}` |
| output_root | `{{output_root}}` |
| step | RS-10 |
| prompt | prompts/rs/10-finding-recommendation-write.prompt.md |
| skill | skills/rs/SK-FINDING-CLASSIFY.md |
| owning_pra | PRA-07-FINDING-RECOMMENDER |

## Finding Rows

| finding_id | source_fact_refs | finding_statement | finding_category | severity | supporting_evidence | confidence | review_status | human_reviewer | notes |
|---|---|---|---|---|---|---|---|---|---|
| FN-01 | `06-boundaries.md#BC-02`; `08-internal-review-table.md#RT-04`; `09-missing-facts.md#MF-04` | The reviewed system crosses BND-02 to an external AI SaaS endpoint without a confirmed authorization scope at the destination, beyond the visible `SA1` service-authentication marker. | `<value-from-catalogs/review/finding-category-catalog.yaml#FC-GAP>` | `<value-from-catalogs/review/severity-catalog.yaml#SV-MEDIUM>` | F4 has `SA1` (AuthN); AZ scope is unknown per `review-transcript.md` § 4 and `cloud-triage-notes.md` § 5. | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | `<value-from-catalogs/review/review-status-catalog.yaml#RS-AWAITING-HUMAN-REVIEW>` | `[copy from runs/{{run_id}}/run-profile.yaml#reviewer_name]` | Severity selected by skill + human review; `SV-MEDIUM` reflects that AuthN is in place and the boundary is reachable today. |
| FN-02 | `07-security-stack-assessment.md#SSM-01`; `09-missing-facts.md#MF-01`; `09-missing-facts.md#MF-02` | Approved-stack and at-rest-encryption claims at CMP-03 (`S1`) and CMP-04 (`E1`) are visible markers only; implementation evidence is not in the design materials. | `<value-from-catalogs/review/finding-category-catalog.yaml#FC-EVIDENCE-GAP>` | `<value-from-catalogs/review/severity-catalog.yaml#SV-MEDIUM>` | Proof-vs-signal global rule applies (`catalogs/security-stacks/proof-vs-signal-rule-catalog.yaml#SR-DIAMOND-NOT-APPROVED-STACK`, `#SR-MARKER-NOT-PROOF`). | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | `<value-from-catalogs/review/review-status-catalog.yaml#RS-AWAITING-HUMAN-REVIEW>` | `[copy from runs/{{run_id}}/run-profile.yaml#reviewer_name]` | Routes to validation notes for separate evidence collection. |
| FN-03 | `05-flows.md#F4`; `08-internal-review-table.md#RT-04`; `09-missing-facts.md#MF-03` | The model-call request body on F4 may carry C4 review-IP content to the external AI SaaS without explicit data-class confirmation or implemented redaction. | `<value-from-catalogs/review/finding-category-catalog.yaml#FC-OBSERVATION>` | `<value-from-catalogs/review/severity-catalog.yaml#SV-LOW>` | `cloud-triage-notes.md` § 5 records the open data-class scope on F4; `review-transcript.md` § 4 records that redaction is discussed but not implemented. | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-MEDIUM>` | `<value-from-catalogs/review/review-status-catalog.yaml#RS-AWAITING-HUMAN-REVIEW>` | `[copy from runs/{{run_id}}/run-profile.yaml#reviewer_name]` | Promotion to FC-GAP requires confirmation of C4 (or higher) class actually traversing F4. |

## Unknowns

| unknown_id | finding_id | what_is_unknown | catalog_reference_checked |
|---|---|---|---|
| UNK-17 | FN-01 | Final `severity` once AZ scope at CMP-05 is confirmed | `catalogs/review/severity-catalog.yaml` |
| UNK-18 | FN-03 | Final `finding_category` once F4 payload class is confirmed | `catalogs/review/finding-category-catalog.yaml` |

## Human Review Gate Status

`<value-from-catalogs/review/review-status-catalog.yaml#RS-AWAITING-HUMAN-REVIEW>`

## Stop Conditions Recorded

None at this step. No invented finding facts. Severity and category selection remain with `skills/rs/SK-FINDING-CLASSIFY.md` plus human review.
