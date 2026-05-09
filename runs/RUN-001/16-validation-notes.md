# Validation Notes — RUN-001
| field | value |
|---|---|
| run_id | `RUN-001` |
| sample_id | sample-001-dfd-crop |
| mode | `folder_first_test` |
| output_root | `runs/RUN-001` |
| step | RS-12 |
| prompt | prompts/rs/12-validation-note-write.prompt.md |
| skill | skills/rs/SK-VALIDATION-NOTE-WRITE.md |
| owning_pra | PRA-08-HANDOFF-QA-SCORER |

## Validation Note Rows

| validation_note_id | concern | evidence_required_for_validation_ticket | source_fact_refs | owner_or_route_if_known | review_status | notes |
|---|---|---|---|---|---|---|
| VN-01 | At-rest encryption implementation on the current Data subnet stores (CMP-04, CMP-06, CMP-07, CMP-13, CMP-14: KMS, key rotation, key scope) — beyond the visible `Enc` markers. | KMS configuration evidence; key-rotation policy artifact; key-scope assignment record; data-team sign-off. | `09-missing-facts.md#MF-02`; `13-findings.md#FN-02`; `14-recommendations.md#REC-02` | unknown (data-team owner; not named in the inputs) | `<value-from-catalogs/review/review-status-catalog.yaml#RS-AWAITING-INPUTS>` | separation_confirmed: yes — does not appear in `15-handoff-pack.md` finding/recommendation rows. |
| VN-02 | Approved-stack control evidence at CMP-10 Cloud Armor / WAF — beyond the visible `S1` diamond. | Approved-stack inventory entry; control-gate map for the WAF / edge control; edge-control owner sign-off. | `09-missing-facts.md#MF-01`; `13-findings.md#FN-02`; `14-recommendations.md#REC-01` | unknown (edge-control owner; not named in the inputs) | `<value-from-catalogs/review/review-status-catalog.yaml#RS-AWAITING-INPUTS>` | separation_confirmed: yes — does not appear in `15-handoff-pack.md` finding/recommendation rows. |

## Separation From Findings/Recommendations

This file is not a duplicate of `13-findings.md` or `14-recommendations.md`. Validation notes describe **what evidence is required for implementation verification**, not new finding categories or new recommendation prose. The design review handoff pack at `15-handoff-pack.md` records design-review state only; the two validation notes above flow to a separate validation-ticket workflow.

## Stop Conditions Recorded

None at this step. No implementation-proof claim. No mixing of design-review closeout content. Owners remain `unknown` until evidence arrives.

