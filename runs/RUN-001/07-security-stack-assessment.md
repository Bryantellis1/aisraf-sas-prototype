# Security Stack Assessment — RUN-001
| field | value |
|---|---|
| run_id | `RUN-001` |
| sample_id | sample-001-dfd-crop |
| mode | `folder_first_test` |
| output_root | `runs/RUN-001` |
| step | RS-05 |
| prompt | prompts/rs/05-boundary-stack-detect.prompt.md |
| skill | skills/rs/SK-SECURITY-STACK-ASSESS.md |
| owning_pra | PRA-05-REVIEW-TABLE-BUILDER |
| global_rule | catalogs/security-stacks/proof-vs-signal-rule-catalog.yaml |

## Security Stack Marker Table

| marker_id | component_or_flow_referenced | marker_kind | marker_value | proof_or_signal | source_location | confidence | notes |
|---|---|---|---|---|---|---|---|
| SSM-01 | CMP-10 Cloud Armor / WAF | `<value-from-catalogs/security-stacks/security-stack-marker-catalog.yaml#SSM-STACK-DIAMOND>` | `S1` | signal (`catalogs/security-stacks/proof-vs-signal-rule-catalog.yaml#SR-DIAMOND-NOT-APPROVED-STACK`) | `dfd-crop.png` Cloud Armor / WAF diamond | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Approved-stack scope is unknown until the inventory at CMP-10 is confirmed (MF-01). |
| SSM-02 | CMP-03 API Gateway | `<value-from-catalogs/security-stacks/security-stack-marker-catalog.yaml#SSM-GATEWAY-OR-POLICY-CHECKPOINT>` | gateway label | signal (`catalogs/security-stacks/proof-vs-signal-rule-catalog.yaml#SR-GATEWAY-NOT-ENFORCEMENT`) | `dfd-crop.png` API Gateway | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Checkpoint signal; enforcement is unknown. |

## Identity Markers

| marker_id | component_referenced | authentication_marker | authorization_marker | identity_evidence_rule_applied | proof_or_signal | confidence | notes |
|---|---|---|---|---|---|---|---|
| IDM-01 | F1 / F2 / F3 (CMP-01 → CMP-09 → CMP-10 → CMP-02) | `<value-from-catalogs/identity-access/authentication-catalog.yaml#AU-INTERNAL-AUTHENTICATION>` (`IA1`) | `<value-from-catalogs/identity-access/authorization-catalog.yaml#AZ-UNKNOWN>` | `catalogs/identity-access/identity-evidence-rule-catalog.yaml#IER-TOKEN-VALIDATION` | signal (`catalogs/security-stacks/proof-vs-signal-rule-catalog.yaml#SR-AUTHN-NOT-AUTHZ`) | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | AuthN visible (`IA1`); AZ scope unknown — no `AZ#` token in the visible flow tuple. |
| IDM-02 | F4..F8, F11..F14 (CMP-02 → CMP-03 → CMP-11 → fan-out) | `<value-from-catalogs/identity-access/authentication-catalog.yaml#AU-SERVICE-AUTHENTICATION>` (`SA5`) | `<value-from-catalogs/identity-access/authorization-catalog.yaml#AZ-UNKNOWN>` | `catalogs/identity-access/identity-evidence-rule-catalog.yaml#IER-LEAST-PRIVILEGE` | signal (`catalogs/security-stacks/proof-vs-signal-rule-catalog.yaml#SR-AUTHN-NOT-AUTHZ`) | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Internal service-to-service AuthN; AZ unknown across all internal hops. |
| IDM-03 | F9 / F10 (CMP-12 ↔ CMP-05) | `<value-from-catalogs/identity-access/authentication-catalog.yaml#AU-SERVICE-AUTHENTICATION>` (`SA7`) | `<value-from-catalogs/identity-access/authorization-catalog.yaml#AZ-UNKNOWN>` | `catalogs/identity-access/identity-evidence-rule-catalog.yaml#IER-ROLE-SCOPE` | signal (`catalogs/security-stacks/proof-vs-signal-rule-catalog.yaml#SR-AUTHN-NOT-AUTHZ`) | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-MEDIUM>` | Drives MF-04 — AZ at the External AI Model Endpoint. |

## Data Protection Markers

| marker_id | flow_or_store_referenced | transport_protection | at_rest_protection | proof_or_signal | confidence | notes |
|---|---|---|---|---|---|---|
| DPM-01 | every flow F1..F14 | `<value-from-catalogs/data-protection/transport-protection-catalog.yaml#TP-T-MARKER>` (`T1`) | `<value-from-catalogs/data-protection/at-rest-protection-catalog.yaml#AR-UNKNOWN>` | signal (`catalogs/security-stacks/proof-vs-signal-rule-catalog.yaml#SR-MARKER-NOT-PROOF`) | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Transit marker visible on every flow tuple. |
| DPM-02 | CMP-04 Review Metadata Cloud SQL | `<value-from-catalogs/data-protection/transport-protection-catalog.yaml#TP-UNKNOWN>` | `<value-from-catalogs/data-protection/at-rest-protection-catalog.yaml#AR-ENC-WORD>` (`Enc`) | signal (`catalogs/security-stacks/proof-vs-signal-rule-catalog.yaml#SR-MARKER-NOT-PROOF`; `#SR-AT-REST-NOT-TRANSIT`) | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | KMS / scope unknown — drives MF-02. |
| DPM-03 | CMP-06 Policy Reference Store | `<value-from-catalogs/data-protection/transport-protection-catalog.yaml#TP-UNKNOWN>` | `<value-from-catalogs/data-protection/at-rest-protection-catalog.yaml#AR-ENC-WORD>` (`Enc`) | signal | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | At-rest marker only. |
| DPM-04 | CMP-07 Findings Store | `<value-from-catalogs/data-protection/transport-protection-catalog.yaml#TP-UNKNOWN>` | `<value-from-catalogs/data-protection/at-rest-protection-catalog.yaml#AR-ENC-WORD>` (`Enc`) | signal | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | At-rest marker only. |
| DPM-05 | CMP-13 Review Artifact Bucket | `<value-from-catalogs/data-protection/transport-protection-catalog.yaml#TP-UNKNOWN>` | `<value-from-catalogs/data-protection/at-rest-protection-catalog.yaml#AR-ENC-WORD>` (`Enc`) | signal | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | At-rest marker only. |
| DPM-06 | CMP-14 Audit Log Store | `<value-from-catalogs/data-protection/transport-protection-catalog.yaml#TP-UNKNOWN>` | `<value-from-catalogs/data-protection/at-rest-protection-catalog.yaml#AR-ENC-WORD>` (`Enc`) | signal | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | At-rest marker only. |
| DPM-07 | F9 / F10 (cross-internet to External AI Model Endpoint) | `<value-from-catalogs/data-protection/transport-protection-catalog.yaml#TP-T-MARKER>` (`T1`) | `<value-from-catalogs/data-protection/at-rest-protection-catalog.yaml#AR-UNKNOWN>` | signal | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-MEDIUM>` | Transit marker visible; data-class redaction posture drives MF-03. |

## Unknowns

| unknown_id | concern | catalog_reference_checked | gap |
|---|---|---|---|
| UNK-11 | Approved-stack inventory at CMP-10 Cloud Armor / WAF | `catalogs/security-stacks/security-stack-marker-catalog.yaml`; `catalogs/security-stacks/proof-vs-signal-rule-catalog.yaml#SR-DIAMOND-NOT-APPROVED-STACK` | Drives MF-01. |
| UNK-12 | KMS / key rotation / scope on the five Data subnet stores | `catalogs/data-protection/at-rest-protection-catalog.yaml` | Drives MF-02. |

## Stop Conditions Recorded

None at this step. `security_stack_present` is intentionally not asserted from any marker alone.

