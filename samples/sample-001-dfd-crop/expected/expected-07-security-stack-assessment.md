---
expected_baseline_id: EXP-RS-07-SECURITY-STACK-ASSESSMENT
sample_id: sample-001-dfd-crop
mirrors_template: templates/output/output-07-security-stack-assessment-template.md
prompt: prompts/rs/05-boundary-stack-detect.prompt.md
skill: skills/rs/SK-SECURITY-STACK-ASSESS.md
owning_pra: PRA-05-REVIEW-TABLE-BUILDER
adapter: .agents/aisraf-review-table-builder.agent.md
target_run_output: "{{output_root}}/07-security-stack-assessment.md"
expected_outcome: PASS_READY_FOR_REVIEW
scoring_basis: template-aligned qualitative baseline; numeric scoring deferred to Build Package 11 run execution
package_version: v0.1.2
---

# Security Stack Assessment — sample-001-dfd-crop

| field | value |
|---|---|
| run_id | `{{run_id}}` |
| sample_id | sample-001-dfd-crop |
| mode | `{{mode}}` |
| output_root | `{{output_root}}` |
| step | RS-05 |
| prompt | prompts/rs/05-boundary-stack-detect.prompt.md |
| skill | skills/rs/SK-SECURITY-STACK-ASSESS.md |
| owning_pra | PRA-05-REVIEW-TABLE-BUILDER |
| global_rule | catalogs/security-stacks/proof-vs-signal-rule-catalog.yaml |

## Security Stack Marker Table

| marker_id | component_or_flow_referenced | marker_kind | marker_value | proof_or_signal | source_location | confidence | notes |
|---|---|---|---|---|---|---|---|
| SSM-01 | CMP-03 Review API Gateway | `<value-from-catalogs/security-stacks/security-stack-marker-catalog.yaml#SSM-STACK-DIAMOND>` | `S1` | signal (`catalogs/security-stacks/proof-vs-signal-rule-catalog.yaml#SR-DIAMOND-NOT-APPROVED-STACK`) | `dfd-crop.png` CMP-03 diamond | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Approved-stack scope is unknown until the inventory at CMP-03 is confirmed (MF-01). |
| SSM-02 | CMP-03 Review API Gateway | `<value-from-catalogs/security-stacks/security-stack-marker-catalog.yaml#SSM-GATEWAY-OR-POLICY-CHECKPOINT>` | gateway label | signal (`catalogs/security-stacks/proof-vs-signal-rule-catalog.yaml#SR-GATEWAY-NOT-ENFORCEMENT`) | `dfd-crop.png` CMP-03 | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Checkpoint signal; enforcement is unknown. |

## Identity Markers

| marker_id | component_referenced | authentication_marker | authorization_marker | identity_evidence_rule_applied | proof_or_signal | confidence | notes |
|---|---|---|---|---|---|---|---|
| IDM-01 | F1 (CMP-01 → CMP-02) | `<value-from-catalogs/identity-access/authentication-catalog.yaml#AU-INTERNAL-AUTHENTICATION>` (`IA1`) | `<value-from-catalogs/identity-access/authorization-catalog.yaml#AZ-UNKNOWN>` | `catalogs/identity-access/identity-evidence-rule-catalog.yaml#IER-TOKEN-VALIDATION` | signal (`catalogs/security-stacks/proof-vs-signal-rule-catalog.yaml#SR-AUTHN-NOT-AUTHZ`) | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | AuthN visible; AZ scope on F1 is unknown. |
| IDM-02 | F2 (CMP-02 → CMP-03) | `<value-from-catalogs/identity-access/authentication-catalog.yaml#AU-SERVICE-AUTHENTICATION>` (`SA1`) | `<value-from-catalogs/identity-access/authorization-catalog.yaml#AZ-UNKNOWN>` | `catalogs/identity-access/identity-evidence-rule-catalog.yaml#IER-LEAST-PRIVILEGE` | signal (`catalogs/security-stacks/proof-vs-signal-rule-catalog.yaml#SR-AUTHN-NOT-AUTHZ`) | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Service-to-service AuthN; AZ unknown. |
| IDM-03 | F4 (CMP-03 → CMP-05) | `<value-from-catalogs/identity-access/authentication-catalog.yaml#AU-SERVICE-AUTHENTICATION>` (`SA1`) | `<value-from-catalogs/identity-access/authorization-catalog.yaml#AZ-UNKNOWN>` | `catalogs/identity-access/identity-evidence-rule-catalog.yaml#IER-ROLE-SCOPE` | signal (`catalogs/security-stacks/proof-vs-signal-rule-catalog.yaml#SR-AUTHN-NOT-AUTHZ`) | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-MEDIUM>` | Drives MF-04 — AZ at the SaaS endpoint. |

## Data Protection Markers

| marker_id | flow_or_store_referenced | transport_protection | at_rest_protection | proof_or_signal | confidence | notes |
|---|---|---|---|---|---|---|
| DPM-01 | F1 | `<value-from-catalogs/data-protection/transport-protection-catalog.yaml#TP-T-MARKER>` (`T1`) | `<value-from-catalogs/data-protection/at-rest-protection-catalog.yaml#AR-UNKNOWN>` | signal (`catalogs/security-stacks/proof-vs-signal-rule-catalog.yaml#SR-MARKER-NOT-PROOF`) | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Transit marker visible. |
| DPM-02 | F2 | `<value-from-catalogs/data-protection/transport-protection-catalog.yaml#TP-UNKNOWN>` | `<value-from-catalogs/data-protection/at-rest-protection-catalog.yaml#AR-UNKNOWN>` | signal | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-MEDIUM>` | No visible transport marker on F2. |
| DPM-03 | CMP-04 (F3 destination) | `<value-from-catalogs/data-protection/transport-protection-catalog.yaml#TP-UNKNOWN>` | `<value-from-catalogs/data-protection/at-rest-protection-catalog.yaml#AR-ENC-WORD>` (`E1`) | signal (`catalogs/security-stacks/proof-vs-signal-rule-catalog.yaml#SR-MARKER-NOT-PROOF`; `#SR-AT-REST-NOT-TRANSIT`) | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | E1 is a marker; KMS / scope unknown — drives MF-02. |
| DPM-04 | F4 (cross-internet) | `<value-from-catalogs/data-protection/transport-protection-catalog.yaml#TP-UNKNOWN>` | `<value-from-catalogs/data-protection/at-rest-protection-catalog.yaml#AR-UNKNOWN>` | signal | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-LOW>` | No transit marker visible on F4 in this sample DFD. |

## Unknowns

| unknown_id | concern | catalog_reference_checked | gap |
|---|---|---|---|
| UNK-11 | Approved-stack inventory at CMP-03 | `catalogs/security-stacks/security-stack-marker-catalog.yaml`; `catalogs/security-stacks/proof-vs-signal-rule-catalog.yaml#SR-DIAMOND-NOT-APPROVED-STACK` | Drives MF-01. |
| UNK-12 | F4 transport encryption | `catalogs/data-protection/transport-protection-catalog.yaml` | The DFD does not visibly mark F4 transport; record honestly as `TP-UNKNOWN`. |

## Stop Conditions Recorded

None at this step. `security_stack_present` is intentionally not asserted from any marker alone.
