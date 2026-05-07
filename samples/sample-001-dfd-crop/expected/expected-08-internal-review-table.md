---
expected_baseline_id: EXP-RS-08-INTERNAL-REVIEW-TABLE
sample_id: sample-001-dfd-crop
mirrors_template: templates/output/output-08-internal-review-table-template.md
prompt: prompts/rs/06-review-table-build.prompt.md
skill: skills/rs/SK-DATA-FLOW-TABLE-BUILD.md
owning_pra: PRA-05-REVIEW-TABLE-BUILDER
adapter: .agents/aisraf-review-table-builder.agent.md
target_run_output: "{{output_root}}/08-internal-review-table.md"
expected_outcome: PASS_READY_FOR_REVIEW
scoring_basis: template-aligned qualitative baseline; numeric scoring deferred to Build Package 11 run execution
package_version: v0.1.2
---

# Internal Review Table — sample-001-dfd-crop

| field | value |
|---|---|
| run_id | `{{run_id}}` |
| sample_id | sample-001-dfd-crop |
| mode | `{{mode}}` |
| output_root | `{{output_root}}` |
| step | RS-06 |
| prompt | prompts/rs/06-review-table-build.prompt.md |
| skill | skills/rs/SK-DATA-FLOW-TABLE-BUILD.md |
| owning_pra | PRA-05-REVIEW-TABLE-BUILDER |

## Review Table Rows

| row_id | flow_id_referenced | source_component_role | destination_component_role | interaction_type | crossing_id_referenced | data_class | transport_protection_marker | identity_marker | confidence | source_facts | notes |
|---|---|---|---|---|---|---|---|---|---|---|---|
| RT-01 | F1 | `<value-from-catalogs/components/component-role-catalog.yaml#CR-ACTOR>` | `<value-from-catalogs/components/component-role-catalog.yaml#CR-INTERMEDIATE-HOP>` | `<value-from-catalogs/interactions/interaction-type-catalog.yaml#IT-DATA-FLOW>` | BC-01 | `<value-from-catalogs/data-protection/data-class-catalog.yaml#DC-C4>` | `<value-from-catalogs/data-protection/transport-protection-catalog.yaml#TP-T-MARKER>` | `<value-from-catalogs/identity-access/authentication-catalog.yaml#AU-INTERNAL-AUTHENTICATION>` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | `05-flows.md#F1`; `06-boundaries.md#BC-01`; `07-security-stack-assessment.md#IDM-01,#DPM-01` | Inbound C4 review request from authenticated reviewer. |
| RT-02 | F2 | `<value-from-catalogs/components/component-role-catalog.yaml#CR-INTERMEDIATE-HOP>` | `<value-from-catalogs/components/component-role-catalog.yaml#CR-CONTROL-PLANE>` | `<value-from-catalogs/interactions/interaction-type-catalog.yaml#IT-DATA-FLOW>` | n/a | `<value-from-catalogs/data-protection/data-class-catalog.yaml#DC-UNKNOWN>` | `<value-from-catalogs/data-protection/transport-protection-catalog.yaml#TP-UNKNOWN>` | `<value-from-catalogs/identity-access/authentication-catalog.yaml#AU-SERVICE-AUTHENTICATION>` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-MEDIUM>` | `05-flows.md#F2`; `07-security-stack-assessment.md#IDM-02,#DPM-02` | Service-to-service inside BND-03; transport marker not visible. |
| RT-03 | F3 | `<value-from-catalogs/components/component-role-catalog.yaml#CR-CONTROL-PLANE>` | `<value-from-catalogs/components/component-role-catalog.yaml#CR-STORE>` | `<value-from-catalogs/interactions/interaction-type-catalog.yaml#IT-WRITE-BACK>` | BC-04 | `<value-from-catalogs/data-protection/data-class-catalog.yaml#DC-C5P>` | `<value-from-catalogs/data-protection/transport-protection-catalog.yaml#TP-UNKNOWN>` | `<value-from-catalogs/identity-access/authentication-catalog.yaml#AU-UNKNOWN>` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-MEDIUM>` | `05-flows.md#F3`; `07-security-stack-assessment.md#DPM-03` | Sample uses C4P; recorded under closest catalog entry DC-C5P (raw_pattern `^C[1-5]P$`); E1 marker is component-scope only. |
| RT-04 | F4 | `<value-from-catalogs/components/component-role-catalog.yaml#CR-CONTROL-PLANE>` | `<value-from-catalogs/components/component-role-catalog.yaml#CR-DESTINATION>` | `<value-from-catalogs/interactions/interaction-type-catalog.yaml#IT-MODEL-CALL>` | BC-02 | `<value-from-catalogs/data-protection/data-class-catalog.yaml#DC-UNKNOWN>` | `<value-from-catalogs/data-protection/transport-protection-catalog.yaml#TP-UNKNOWN>` | `<value-from-catalogs/identity-access/authentication-catalog.yaml#AU-SERVICE-AUTHENTICATION>` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-LOW>` | `05-flows.md#F4`; `06-boundaries.md#BC-02`; `07-security-stack-assessment.md#IDM-03,#DPM-04` | Cross-internet to external SaaS; data-class scope drives MF-03. |
| RT-05 | F5 | `<value-from-catalogs/components/component-role-catalog.yaml#CR-DESTINATION>` | `<value-from-catalogs/components/component-role-catalog.yaml#CR-CONTROL-PLANE>` | `<value-from-catalogs/interactions/interaction-type-catalog.yaml#IT-DATA-FLOW>` | BC-03 | `<value-from-catalogs/data-protection/data-class-catalog.yaml#DC-UNKNOWN>` | `<value-from-catalogs/data-protection/transport-protection-catalog.yaml#TP-UNKNOWN>` | `<value-from-catalogs/identity-access/authentication-catalog.yaml#AU-SERVICE-AUTHENTICATION>` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-LOW>` | `05-flows.md#F5`; `06-boundaries.md#BC-03` | Inbound response from external SaaS. |
| RT-06 | F6 | `<value-from-catalogs/components/component-role-catalog.yaml#CR-CONTROL-PLANE>` | `<value-from-catalogs/components/component-role-catalog.yaml#CR-STORE>` | `<value-from-catalogs/interactions/interaction-type-catalog.yaml#IT-WRITE-BACK>` | BC-05 | `<value-from-catalogs/data-protection/data-class-catalog.yaml#DC-C4>` | `<value-from-catalogs/data-protection/transport-protection-catalog.yaml#TP-UNKNOWN>` | `<value-from-catalogs/identity-access/authentication-catalog.yaml#AU-UNKNOWN>` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | `05-flows.md#F6` | Findings store. |
| RT-07 | F7 | `<value-from-catalogs/components/component-role-catalog.yaml#CR-CONTROL-PLANE>` | `<value-from-catalogs/components/component-role-catalog.yaml#CR-STORE>` | `<value-from-catalogs/interactions/interaction-type-catalog.yaml#IT-DATA-FLOW>` | BC-06 | `<value-from-catalogs/data-protection/data-class-catalog.yaml#DC-C2>` | `<value-from-catalogs/data-protection/transport-protection-catalog.yaml#TP-UNKNOWN>` | `<value-from-catalogs/identity-access/authentication-catalog.yaml#AU-UNKNOWN>` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | `05-flows.md#F7` | Read-only policy reference. |
| RT-08 | F8 | `<value-from-catalogs/components/component-role-catalog.yaml#CR-CONTROL-PLANE>` | `<value-from-catalogs/components/component-role-catalog.yaml#CR-DESTINATION>` | `<value-from-catalogs/interactions/interaction-type-catalog.yaml#IT-TOOL-CALL>` | BC-07 | `<value-from-catalogs/data-protection/data-class-catalog.yaml#DC-UNKNOWN>` | `<value-from-catalogs/data-protection/transport-protection-catalog.yaml#TP-UNKNOWN>` | `<value-from-catalogs/identity-access/authentication-catalog.yaml#AU-UNKNOWN>` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | `05-flows.md#F8` | `formatted_only`; not external post-back. |

## Unknowns

| unknown_id | row_id | what_is_unknown | catalog_reference_checked | gap |
|---|---|---|---|---|
| UNK-13 | RT-04 | data class on F4 model-call request body | `catalogs/data-protection/data-class-catalog.yaml` | Drives MF-03. |
| UNK-14 | RT-05 | data class on F5 model response | `catalogs/data-protection/data-class-catalog.yaml` | Drives MF-03. |
| UNK-15 | RT-04 | AZ scope at CMP-05 | `catalogs/identity-access/authorization-catalog.yaml` | Drives MF-04. |
| UNK-16 | RT-03 | KMS / at-rest scope at CMP-04 | `catalogs/data-protection/at-rest-protection-catalog.yaml` | Drives MF-02. |

## Stop Conditions Recorded

None at this step.
