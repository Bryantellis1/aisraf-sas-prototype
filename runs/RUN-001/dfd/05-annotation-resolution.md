# DFD Annotation Resolution — RUN-001
| field | value |
|---|---|
| run_id | `RUN-001` |
| sample_id | sample-001-dfd-crop |
| mode | `folder_first_test` |
| output_root | `runs/RUN-001` |
| dfd_step | DFD-05 |
| prompt | prompts/dfd/06-annotation-resolve.prompt.md |
| skill | skills/dfd/SK-DFD-05-ANNOTATION-RESOLVE.md |
| owning_pra | PRA-03-DFD-EXTRACTOR |

## Resolved Annotations

| annotation_id | annotation_visible | resolved_to_catalog_value | resolution_basis | source_location | confidence | notes |
|---|---|---|---|---|---|---|
| AN-01 | `IA1` | `<value-from-catalogs/identity-access/authentication-catalog.yaml#AU-INTERNAL-AUTHENTICATION>` | `catalogs/identity-access/authentication-catalog.yaml#AU-INTERNAL-AUTHENTICATION` (raw_pattern `^IA[0-9]+[OS]?$`) | `dfd-crop.png` F1 / F2 / F3 visible flow tuples | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Internal SSO per `review-transcript.md`. |
| AN-02 | `SA5` | `<value-from-catalogs/identity-access/authentication-catalog.yaml#AU-SERVICE-AUTHENTICATION>` | `catalogs/identity-access/authentication-catalog.yaml#AU-SERVICE-AUTHENTICATION` (raw_pattern `^SA[0-9]+[OS]?$`) | `dfd-crop.png` F4 / F5 / F6 / F7 / F8 / F11 / F12 / F13 / F14 visible flow tuples | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Internal service-to-service auth across the GCP Application subnet. SA# numerical subtype is sample-specific and recorded in legend §1. |
| AN-03 | `SA7` | `<value-from-catalogs/identity-access/authentication-catalog.yaml#AU-SERVICE-AUTHENTICATION>` | `catalogs/identity-access/authentication-catalog.yaml#AU-SERVICE-AUTHENTICATION` (raw_pattern `^SA[0-9]+[OS]?$`) | `dfd-crop.png` F9 / F10 visible flow tuples | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Cross-internet service-to-service auth to External AI Model Endpoint. SA# numerical subtype is sample-specific and recorded in legend §1. |
| AN-04 | `S1` (◇ diamond) | `<value-from-catalogs/security-stacks/security-stack-marker-catalog.yaml#SSM-STACK-DIAMOND>` | `catalogs/security-stacks/security-stack-marker-catalog.yaml#SSM-STACK-DIAMOND` | `dfd-crop.png` Cloud Armor / WAF diamond | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Marker only. Proof-vs-signal rule `SR-DIAMOND-NOT-APPROVED-STACK` applies. |
| AN-05 | `T1` | `<value-from-catalogs/data-protection/transport-protection-catalog.yaml#TP-T-MARKER>` | `catalogs/data-protection/transport-protection-catalog.yaml#TP-T-MARKER` | `dfd-crop.png` every visible flow tuple | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Standalone T# is a transit-encryption marker (data-class-catalog ER-DC-06). |
| AN-06 | `Enc` | `<value-from-catalogs/data-protection/at-rest-protection-catalog.yaml#AR-ENC-WORD>` | `catalogs/data-protection/at-rest-protection-catalog.yaml#AR-ENC-WORD` | `dfd-crop.png` Data subnet store labels (CMP-04 / CMP-06 / CMP-07 / CMP-13 / CMP-14) | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | At-rest encryption marker; KMS / scope unknown — drives MF-02. |
| AN-07 | `R1` | sample-specific raw token; recorded in legend §3 with `CL-MEDIUM` confidence | descriptive only (legend-anchored, no controlled-vocabulary entry); cross-references `catalogs/data-protection/at-rest-protection-catalog.yaml` for adjacent at-rest semantics | `dfd-crop.png` Data subnet store labels | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-MEDIUM>` | Single-region / regional managed-resource marker; does not prove cross-region replication, multi-region failover, or regional residency configuration. |
| AN-08 | `C2` | `<value-from-catalogs/data-protection/data-class-catalog.yaml#DC-C2>` | `catalogs/data-protection/data-class-catalog.yaml#DC-C2` | `dfd-crop.png` F7 visible flow tuple; CMP-06 store label | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Internal policy data. |
| AN-09 | `C4` | `<value-from-catalogs/data-protection/data-class-catalog.yaml#DC-C4>` | `catalogs/data-protection/data-class-catalog.yaml#DC-C4` | `dfd-crop.png` F1, F2, F3, F4, F5, F6, F8, F9, F10, F11, F12, F13, F14 visible flow tuples; CMP-04, CMP-07, CMP-13, CMP-14 store labels | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Restricted design / IP / review record class. |
| AN-10 | `AZ?` | `<value-from-catalogs/identity-access/authorization-catalog.yaml#AZ-UNKNOWN>` | `catalogs/identity-access/authorization-catalog.yaml#AZ-UNKNOWN`; `catalogs/identity-access/authentication-catalog.yaml#ER-AU-03` (authentication does not prove authorization) | `dfd-crop.png` every visible flow tuple's 4th position (14 flows); embedded LEGEND panel inside the DFD | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Explicit authorization-unknown sentinel required by the 4-token flow grammar; honest unknown rather than absence. |

## Unresolved Annotations

None at this step. Every visible token in the DFD resolves to a catalog entry or to a legend-anchored sample-specific marker (`R1`) recorded with reduced confidence. The absence-of-`AZ#` pattern resolves to `AZ-UNKNOWN` and is recorded as a resolved annotation rather than an unresolved one.

## Stop Conditions Recorded

None at this step.

