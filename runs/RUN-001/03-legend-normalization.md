# Legend Normalization — RUN-001
| field | value |
|---|---|
| run_id | `RUN-001` |
| sample_id | sample-001-dfd-crop |
| mode | `folder_first_test` |
| output_root | `runs/RUN-001` |
| step | RS-03 |
| prompt | prompts/rs/03-legend-normalization.prompt.md |
| skill | skills/rs/SK-LEGEND-NORMALIZE.md |
| owning_pra | PRA-04-LEGEND-NORMALIZER |

## Normalization Table

| raw_label | source_location | normalized_term | normalization_basis | confidence | notes |
|---|---|---|---|---|---|
| `IA1` | `dfd-crop.png` F1 / F2 / F3 visible flow tuples; `dfd-legend-excerpt.md` § 1 | `<value-from-catalogs/identity-access/authentication-catalog.yaml#AU-INTERNAL-AUTHENTICATION>` | `catalogs/identity-access/authentication-catalog.yaml#AU-INTERNAL-AUTHENTICATION` (raw_pattern `^IA[0-9]+[OS]?$`) | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Internal SSO per `review-transcript.md`. |
| `SA5` | `dfd-crop.png` F4 / F5 / F6 / F7 / F8 / F11 / F12 / F13 / F14 visible flow tuples; `dfd-legend-excerpt.md` § 1 | `<value-from-catalogs/identity-access/authentication-catalog.yaml#AU-SERVICE-AUTHENTICATION>` | `catalogs/identity-access/authentication-catalog.yaml#AU-SERVICE-AUTHENTICATION` (raw_pattern `^SA[0-9]+[OS]?$`) | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Internal service-to-service authentication; numerical subtype is sample-specific. Authorization scope is recorded separately as `AZ-UNKNOWN`. |
| `SA7` | `dfd-crop.png` F9 / F10 visible flow tuples; `dfd-legend-excerpt.md` § 1 | `<value-from-catalogs/identity-access/authentication-catalog.yaml#AU-SERVICE-AUTHENTICATION>` | `catalogs/identity-access/authentication-catalog.yaml#AU-SERVICE-AUTHENTICATION` (raw_pattern `^SA[0-9]+[OS]?$`) | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Cross-internet service-to-service auth to External AI Model Endpoint; numerical subtype is sample-specific. |
| `S1` (◇) | `dfd-crop.png` Cloud Armor / WAF diamond; `dfd-legend-excerpt.md` § 1 | `<value-from-catalogs/security-stacks/security-stack-marker-catalog.yaml#SSM-STACK-DIAMOND>` | `catalogs/security-stacks/security-stack-marker-catalog.yaml#SSM-STACK-DIAMOND` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Marker only. Proof-vs-signal rule `SR-DIAMOND-NOT-APPROVED-STACK` applies. |
| `T1` | `dfd-crop.png` every visible flow tuple; `dfd-legend-excerpt.md` § 1 | `<value-from-catalogs/data-protection/transport-protection-catalog.yaml#TP-T-MARKER>` | `catalogs/data-protection/transport-protection-catalog.yaml#TP-T-MARKER` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Standalone T# is a transit-encryption marker. |
| `Enc` | `dfd-crop.png` every Data subnet store visible storage tuple; `dfd-legend-excerpt.md` § 1 | `<value-from-catalogs/data-protection/at-rest-protection-catalog.yaml#AR-ENC-WORD>` | `catalogs/data-protection/at-rest-protection-catalog.yaml#AR-ENC-WORD` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | At-rest encryption marker; KMS / scope unknown. |
| `R1` | `dfd-crop.png` every Data subnet store visible storage tuple; `dfd-legend-excerpt.md` § 1, § 3 | descriptive (legend-anchored sample-specific raw token; no controlled-vocabulary entry) | `dfd-legend-excerpt.md` § 3 | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-MEDIUM>` | Single-region / regional managed-resource marker; cross-region replication is not asserted. |
| `C2` | `dfd-crop.png` F7 visible flow tuple; Policy Reference Store store label; `dfd-legend-excerpt.md` § 1 | `<value-from-catalogs/data-protection/data-class-catalog.yaml#DC-C2>` | `catalogs/data-protection/data-class-catalog.yaml#DC-C2` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Internal policy reference. |
| `C4` | `dfd-crop.png` F1, F2, F3, F4, F5, F6, F8, F9, F10, F11, F12, F13, F14 visible flow tuples; Review Metadata Cloud SQL, Findings Store, Review Artifact Bucket, Audit Log Store store labels | `<value-from-catalogs/data-protection/data-class-catalog.yaml#DC-C4>` | `catalogs/data-protection/data-class-catalog.yaml#DC-C4` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Restricted design / IP / review record class. |
| `AZ?` | `dfd-crop.png` every visible flow tuple's 4th position (all 14 flows); `dfd-legend-excerpt.md` § 1; embedded LEGEND panel inside the DFD | `<value-from-catalogs/identity-access/authorization-catalog.yaml#AZ-UNKNOWN>` | `catalogs/identity-access/authorization-catalog.yaml#AZ-UNKNOWN`; `catalogs/identity-access/authentication-catalog.yaml#ER-AU-03` (authentication does not prove authorization) | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Explicit authorization-unknown sentinel required by the 4-token flow grammar when authorization is not visibly proven. Honest unknown — authorization is intentionally not visible. |
| `formatted_only` (component-level semantic on Jira / Confluence API) | `dfd-crop.png` Jira / Confluence API; F14 destination semantics | descriptive (no controlled vocabulary needed) | `templates/jira/jira-ticket-draft-template.md`; `templates/confluence/confluence-page-draft-template.md` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Not external post-back. |

## Unknowns

| unknown_id | label_observed | catalog_reference_checked | gap |
|---|---|---|---|
| UNK-03 | None at this step. | n/a | Material gaps belong to step RS-07. The `R1` and `AZ-UNKNOWN` rows above are recorded with the appropriate confidence and notes. |

## Stop Conditions Recorded

None at this step. Every visible token resolves to a v0.1.2 catalog path with at most a medium-confidence annotation on `R1`.

