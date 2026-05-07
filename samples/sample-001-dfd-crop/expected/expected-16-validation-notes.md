---
expected_baseline_id: EXP-RS-16-VALIDATION-NOTES
sample_id: sample-001-dfd-crop
mirrors_template: templates/output/output-16-validation-notes-template.md
prompt: prompts/rs/12-validation-note-write.prompt.md
skill: skills/rs/SK-VALIDATION-NOTE-WRITE.md
owning_pra: PRA-08-HANDOFF-QA-SCORER
adapter: .agents/aisraf-handoff-qa-scorer.agent.md
target_run_output: "{{output_root}}/16-validation-notes.md"
expected_outcome: PASS_READY_FOR_REVIEW
scoring_basis: template-aligned qualitative baseline; numeric scoring deferred to Build Package 11 run execution
package_version: v0.1.2
---

# Validation Notes — sample-001-dfd-crop

| field | value |
|---|---|
| run_id | `{{run_id}}` |
| sample_id | sample-001-dfd-crop |
| mode | `{{mode}}` |
| output_root | `{{output_root}}` |
| step | RS-12 |
| prompt | prompts/rs/12-validation-note-write.prompt.md |
| skill | skills/rs/SK-VALIDATION-NOTE-WRITE.md |
| owning_pra | PRA-08-HANDOFF-QA-SCORER |

## Validation Note Rows

| validation_note_id | concern | evidence_required_for_validation_ticket | source_fact_refs | owner_or_route_if_known | review_status | notes |
|---|---|---|---|---|---|---|
| VN-01 | At-rest encryption implementation on CMP-04 Review Metadata DB (KMS, key rotation, key scope) — beyond the visible `E1` marker. | KMS configuration evidence; key-rotation policy artifact; key-scope assignment record; data-team sign-off. | `09-missing-facts.md#MF-02`; `13-findings.md#FN-02`; `14-recommendations.md#REC-02` | unknown (data-team owner; not named in the inputs) | `<value-from-catalogs/review/review-status-catalog.yaml#RS-AWAITING-INPUTS>` | separation_confirmed: yes — does not appear in `15-handoff-pack.md` finding/recommendation rows. |
| VN-02 | Approved-stack control evidence at CMP-03 Review API Gateway — beyond the visible `S1` diamond. | Approved-stack inventory entry; control-gate map for the gateway; gateway-owner sign-off. | `09-missing-facts.md#MF-01`; `13-findings.md#FN-02`; `14-recommendations.md#REC-01` | unknown (gateway owner; not named in the inputs) | `<value-from-catalogs/review/review-status-catalog.yaml#RS-AWAITING-INPUTS>` | separation_confirmed: yes — does not appear in `15-handoff-pack.md` finding/recommendation rows. |

## Separation From Findings/Recommendations

This file is not a duplicate of `13-findings.md` or `14-recommendations.md`. Validation notes describe **what evidence is required for implementation verification**, not new finding categories or new recommendation prose. The design review handoff pack at `15-handoff-pack.md` records design-review state only; the two validation notes above flow to a separate validation-ticket workflow.

## Stop Conditions Recorded

None at this step. No implementation-proof claim. No mixing of design-review closeout content. Owners remain `unknown` until evidence arrives.
