---
expected_baseline_id: EXP-DFD-04-FLOW-INVENTORY
sample_id: sample-001-dfd-crop
mirrors_template: templates/output/output-dfd-04-flow-inventory-template.md
prompt: prompts/dfd/05-flow-extract.prompt.md
skill: skills/dfd/SK-DFD-04-FLOW-EXTRACT.md
owning_pra: PRA-03-DFD-EXTRACTOR
adapter: .agents/aisraf-dfd-extractor.agent.md
target_run_output: "{{output_root}}/dfd/04-flow-inventory.md"
expected_outcome: PASS_READY_FOR_REVIEW
scoring_basis: template-aligned qualitative baseline; numeric scoring deferred to Build Package 11 run execution
package_version: v0.1.2
---

# DFD Flow Inventory — sample-001-dfd-crop

| field | value |
|---|---|
| run_id | `{{run_id}}` |
| sample_id | sample-001-dfd-crop |
| mode | `{{mode}}` |
| output_root | `{{output_root}}` |
| dfd_step | DFD-04 |
| prompt | prompts/dfd/05-flow-extract.prompt.md |
| skill | skills/dfd/SK-DFD-04-FLOW-EXTRACT.md |
| owning_pra | PRA-03-DFD-EXTRACTOR |

## Raw Flow Inventory

| raw_flow_id | source_label | destination_label | visible_payload | source_location | notes |
|---|---|---|---|---|---|
| RF-01 | CMP-01 Reviewer Browser | CMP-02 Review Portal Web App | "F1 HTTPS · IA1 · T1 · C4 review request" | `dfd-crop.png` arrow F1 | Inbound app entry. |
| RF-02 | CMP-02 Review Portal Web App | CMP-03 Review API Gateway | "F2 API call · SA1" | `dfd-crop.png` arrow F2 | Internal hop. |
| RF-03 | CMP-03 Review API Gateway | CMP-04 Review Metadata DB | "F3 write · C4P · E1 marker" | `dfd-crop.png` arrow F3 | Metadata write. |
| RF-04 | CMP-03 Review API Gateway | CMP-05 AI Analysis Service | "F4 model call · SA1 · request payload class unknown" | `dfd-crop.png` arrow F4 | Cross-internet to external SaaS. |
| RF-05 | CMP-05 AI Analysis Service | CMP-03 Review API Gateway | "F5 model response · class unknown" | `dfd-crop.png` arrow F5 | Inbound response. |
| RF-06 | CMP-03 Review API Gateway | CMP-07 Findings Store | "F6 write · C4 finding record" | `dfd-crop.png` arrow F6 | Findings write. |
| RF-07 | CMP-03 Review API Gateway | CMP-06 Policy Reference Store | "F7 read · C2 policy reference" | `dfd-crop.png` arrow F7 | Policy read. |
| RF-08 | CMP-03 Review API Gateway | CMP-08 Jira/Confluence Draft Formatter | "F8 formatted_only draft handoff" | `dfd-crop.png` arrow F8 | Local draft only. |

## Normalized Flow Table

| flow_id | raw_flow_id_referenced | source_component_id | destination_component_id | interaction_type | flow_direction | evidence_rule_applied | confidence | notes |
|---|---|---|---|---|---|---|---|---|
| F1 | RF-01 | CMP-01 | CMP-02 | `<value-from-catalogs/interactions/interaction-type-catalog.yaml#IT-DATA-FLOW>` | `<value-from-catalogs/interactions/flow-direction-catalog.yaml#FD-REQUEST-RESPONSE>` | `catalogs/interactions/flow-evidence-rule-catalog.yaml#FER-VISIBLE-FLOW-SUPPORTS-ROW` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Inbound. |
| F2 | RF-02 | CMP-02 | CMP-03 | `<value-from-catalogs/interactions/interaction-type-catalog.yaml#IT-DATA-FLOW>` | `<value-from-catalogs/interactions/flow-direction-catalog.yaml#FD-REQUEST-RESPONSE>` | `catalogs/interactions/flow-evidence-rule-catalog.yaml#FER-VISIBLE-FLOW-SUPPORTS-ROW` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Internal. |
| F3 | RF-03 | CMP-03 | CMP-04 | `<value-from-catalogs/interactions/interaction-type-catalog.yaml#IT-WRITE-BACK>` | `<value-from-catalogs/interactions/flow-direction-catalog.yaml#FD-ONE-WAY>` | `catalogs/interactions/flow-evidence-rule-catalog.yaml#FER-VISIBLE-FLOW-SUPPORTS-ROW`; `catalogs/interactions/flow-evidence-rule-catalog.yaml#FER-COMPONENT-MARKER-DOES-NOT-PROPAGATE` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Metadata write. |
| F4 | RF-04 | CMP-03 | CMP-05 | `<value-from-catalogs/interactions/interaction-type-catalog.yaml#IT-MODEL-CALL>` | `<value-from-catalogs/interactions/flow-direction-catalog.yaml#FD-REQUEST-RESPONSE>` | `catalogs/interactions/flow-evidence-rule-catalog.yaml#FER-VISIBLE-FLOW-SUPPORTS-ROW`; `catalogs/interactions/flow-evidence-rule-catalog.yaml#FER-MISSING-FACT-IF-MATERIAL` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-MEDIUM>` | Model call to external SaaS. |
| F5 | RF-05 | CMP-05 | CMP-03 | `<value-from-catalogs/interactions/interaction-type-catalog.yaml#IT-DATA-FLOW>` | `<value-from-catalogs/interactions/flow-direction-catalog.yaml#FD-ONE-WAY>` | `catalogs/interactions/flow-evidence-rule-catalog.yaml#FER-VISIBLE-FLOW-SUPPORTS-ROW`; `catalogs/interactions/flow-evidence-rule-catalog.yaml#FER-MISSING-FACT-IF-MATERIAL` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-LOW>` | Response. |
| F6 | RF-06 | CMP-03 | CMP-07 | `<value-from-catalogs/interactions/interaction-type-catalog.yaml#IT-WRITE-BACK>` | `<value-from-catalogs/interactions/flow-direction-catalog.yaml#FD-ONE-WAY>` | `catalogs/interactions/flow-evidence-rule-catalog.yaml#FER-VISIBLE-FLOW-SUPPORTS-ROW` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Findings store. |
| F7 | RF-07 | CMP-03 | CMP-06 | `<value-from-catalogs/interactions/interaction-type-catalog.yaml#IT-DATA-FLOW>` | `<value-from-catalogs/interactions/flow-direction-catalog.yaml#FD-REQUEST-RESPONSE>` | `catalogs/interactions/flow-evidence-rule-catalog.yaml#FER-VISIBLE-FLOW-SUPPORTS-ROW` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Read-only. |
| F8 | RF-08 | CMP-03 | CMP-08 | `<value-from-catalogs/interactions/interaction-type-catalog.yaml#IT-TOOL-CALL>` | `<value-from-catalogs/interactions/flow-direction-catalog.yaml#FD-ONE-WAY>` | `catalogs/interactions/flow-evidence-rule-catalog.yaml#FER-VISIBLE-FLOW-SUPPORTS-ROW`; `catalogs/interactions/flow-evidence-rule-catalog.yaml#FER-VALIDATION-ROUTE-IF-PROOF-NEEDED` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | `formatted_only`. |

## Unknowns

| unknown_id | flow_id | what_is_unknown | catalog_reference_checked |
|---|---|---|---|
| UDF-01 | F4 | request payload class | `catalogs/data-protection/data-class-catalog.yaml` |
| UDF-02 | F5 | response payload class | `catalogs/data-protection/data-class-catalog.yaml` |

## Stop Conditions Recorded

None at this step.
