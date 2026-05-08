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

Each `visible_payload` is the verbatim flow label from the DFD. The flow-label grammar is `<data/action name> / <C#>,<T#>,<SA#|CA#|IA#>`. Authorization (`AZ#`) is intentionally not present in any visible flow label; downstream baselines record `authorization_visible = unknown` per the founder rule that authentication never implies authorization.

| raw_flow_id | source_label | destination_label | visible_payload | source_location | notes |
|---|---|---|---|---|---|
| RF-01 | Reviewer Browser | Cloud Load Balancer | "Review Request / C4,T1,IA1,AZ?" | `dfd-crop.png` arrow F1 | Inbound app entry from internet. |
| RF-02 | Cloud Load Balancer | Cloud Armor / WAF | "Inspected Request / C4,T1,IA1,AZ?" | `dfd-crop.png` arrow F2 | Stays in Edge subnet. |
| RF-03 | Cloud Armor / WAF | Review Portal Web App | "Forwarded Request / C4,T1,IA1,AZ?" | `dfd-crop.png` arrow F3 | Edge subnet → Application subnet. |
| RF-04 | Review Portal Web App | API Gateway | "API Call / C4,T1,SA5,AZ?" | `dfd-crop.png` arrow F4 | Internal hop. |
| RF-05 | API Gateway | Review Orchestrator Service | "Orchestrate Review / C4,T1,SA5,AZ?" | `dfd-crop.png` arrow F5 | Internal hop. |
| RF-06 | Review Orchestrator Service | Review Metadata Cloud SQL | "Metadata Write / C4,T1,SA5,AZ?" | `dfd-crop.png` arrow F6 | Application → Data subnet write. |
| RF-07 | Review Orchestrator Service | Policy Reference Store | "Policy Lookup / C2,T1,SA5,AZ?" | `dfd-crop.png` arrow F7 | Application → Data subnet read. |
| RF-08 | Review Orchestrator Service | AI Analysis Connector | "Analysis Request / C4,T1,SA5,AZ?" | `dfd-crop.png` arrow F8 | Internal hop to egress connector. |
| RF-09 | AI Analysis Connector | External AI Model Endpoint | "Model Prompt / C4,T1,SA7,AZ?" | `dfd-crop.png` arrow F9 | Cross-internet to external SaaS. |
| RF-10 | External AI Model Endpoint | AI Analysis Connector | "Model Response / C4,T1,SA7,AZ?" | `dfd-crop.png` arrow F10 | Inbound response from external SaaS. |
| RF-11 | Review Orchestrator Service | Findings Store | "Finding Write / C4,T1,SA5,AZ?" | `dfd-crop.png` arrow F11 | Application → Data subnet write. |
| RF-12 | Review Orchestrator Service | Review Artifact Bucket | "Handoff Pack Write / C4,T1,SA5,AZ?" | `dfd-crop.png` arrow F12 | Application → Data subnet write. |
| RF-13 | Review Orchestrator Service | Audit Log Store | "Audit Event / C4,T1,SA5,AZ?" | `dfd-crop.png` arrow F13 | Application → Data subnet audit. |
| RF-14 | Review Orchestrator Service | Jira / Confluence API | "Draft Handoff / C4,T1,SA5,AZ?" | `dfd-crop.png` arrow F14 | Local draft only; `formatted_only`. |

## Normalized Flow Table

| flow_id | raw_flow_id_referenced | source_component_id | destination_component_id | interaction_type | flow_direction | evidence_rule_applied | confidence | notes |
|---|---|---|---|---|---|---|---|---|
| F1 | RF-01 | CMP-01 | CMP-09 | `<value-from-catalogs/interactions/interaction-type-catalog.yaml#IT-DATA-FLOW>` | `<value-from-catalogs/interactions/flow-direction-catalog.yaml#FD-REQUEST-RESPONSE>` | `catalogs/interactions/flow-evidence-rule-catalog.yaml#FER-VISIBLE-FLOW-SUPPORTS-ROW` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Inbound from internet to LB. |
| F2 | RF-02 | CMP-09 | CMP-10 | `<value-from-catalogs/interactions/interaction-type-catalog.yaml#IT-DATA-FLOW>` | `<value-from-catalogs/interactions/flow-direction-catalog.yaml#FD-ONE-WAY>` | `catalogs/interactions/flow-evidence-rule-catalog.yaml#FER-VISIBLE-FLOW-SUPPORTS-ROW` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Edge-internal hop. |
| F3 | RF-03 | CMP-10 | CMP-02 | `<value-from-catalogs/interactions/interaction-type-catalog.yaml#IT-DATA-FLOW>` | `<value-from-catalogs/interactions/flow-direction-catalog.yaml#FD-REQUEST-RESPONSE>` | `catalogs/interactions/flow-evidence-rule-catalog.yaml#FER-VISIBLE-FLOW-SUPPORTS-ROW` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Edge → Application subnet. |
| F4 | RF-04 | CMP-02 | CMP-03 | `<value-from-catalogs/interactions/interaction-type-catalog.yaml#IT-DATA-FLOW>` | `<value-from-catalogs/interactions/flow-direction-catalog.yaml#FD-REQUEST-RESPONSE>` | `catalogs/interactions/flow-evidence-rule-catalog.yaml#FER-VISIBLE-FLOW-SUPPORTS-ROW` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Internal API call. |
| F5 | RF-05 | CMP-03 | CMP-11 | `<value-from-catalogs/interactions/interaction-type-catalog.yaml#IT-DATA-FLOW>` | `<value-from-catalogs/interactions/flow-direction-catalog.yaml#FD-REQUEST-RESPONSE>` | `catalogs/interactions/flow-evidence-rule-catalog.yaml#FER-VISIBLE-FLOW-SUPPORTS-ROW` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Internal orchestration hop. |
| F6 | RF-06 | CMP-11 | CMP-04 | `<value-from-catalogs/interactions/interaction-type-catalog.yaml#IT-WRITE-BACK>` | `<value-from-catalogs/interactions/flow-direction-catalog.yaml#FD-ONE-WAY>` | `catalogs/interactions/flow-evidence-rule-catalog.yaml#FER-VISIBLE-FLOW-SUPPORTS-ROW`; `catalogs/interactions/flow-evidence-rule-catalog.yaml#FER-COMPONENT-MARKER-DOES-NOT-PROPAGATE` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Metadata write into Data subnet. |
| F7 | RF-07 | CMP-11 | CMP-06 | `<value-from-catalogs/interactions/interaction-type-catalog.yaml#IT-DATA-FLOW>` | `<value-from-catalogs/interactions/flow-direction-catalog.yaml#FD-REQUEST-RESPONSE>` | `catalogs/interactions/flow-evidence-rule-catalog.yaml#FER-VISIBLE-FLOW-SUPPORTS-ROW` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Read-only policy reference. |
| F8 | RF-08 | CMP-11 | CMP-12 | `<value-from-catalogs/interactions/interaction-type-catalog.yaml#IT-DATA-FLOW>` | `<value-from-catalogs/interactions/flow-direction-catalog.yaml#FD-REQUEST-RESPONSE>` | `catalogs/interactions/flow-evidence-rule-catalog.yaml#FER-VISIBLE-FLOW-SUPPORTS-ROW` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Internal application-subnet hop to egress connector. |
| F9 | RF-09 | CMP-12 | CMP-05 | `<value-from-catalogs/interactions/interaction-type-catalog.yaml#IT-MODEL-CALL>` | `<value-from-catalogs/interactions/flow-direction-catalog.yaml#FD-REQUEST-RESPONSE>` | `catalogs/interactions/flow-evidence-rule-catalog.yaml#FER-VISIBLE-FLOW-SUPPORTS-ROW`; `catalogs/interactions/flow-evidence-rule-catalog.yaml#FER-MISSING-FACT-IF-MATERIAL` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-MEDIUM>` | Model call to external SaaS; visible label asserts `C4` but whether the AI Connector redacts before transmission drives MF-03. |
| F10 | RF-10 | CMP-05 | CMP-12 | `<value-from-catalogs/interactions/interaction-type-catalog.yaml#IT-DATA-FLOW>` | `<value-from-catalogs/interactions/flow-direction-catalog.yaml#FD-ONE-WAY>` | `catalogs/interactions/flow-evidence-rule-catalog.yaml#FER-VISIBLE-FLOW-SUPPORTS-ROW`; `catalogs/interactions/flow-evidence-rule-catalog.yaml#FER-MISSING-FACT-IF-MATERIAL` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-MEDIUM>` | Inbound model response carrying `C4`. |
| F11 | RF-11 | CMP-11 | CMP-07 | `<value-from-catalogs/interactions/interaction-type-catalog.yaml#IT-WRITE-BACK>` | `<value-from-catalogs/interactions/flow-direction-catalog.yaml#FD-ONE-WAY>` | `catalogs/interactions/flow-evidence-rule-catalog.yaml#FER-VISIBLE-FLOW-SUPPORTS-ROW` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Findings store. |
| F12 | RF-12 | CMP-11 | CMP-13 | `<value-from-catalogs/interactions/interaction-type-catalog.yaml#IT-WRITE-BACK>` | `<value-from-catalogs/interactions/flow-direction-catalog.yaml#FD-ONE-WAY>` | `catalogs/interactions/flow-evidence-rule-catalog.yaml#FER-VISIBLE-FLOW-SUPPORTS-ROW` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Handoff pack write. |
| F13 | RF-13 | CMP-11 | CMP-14 | `<value-from-catalogs/interactions/interaction-type-catalog.yaml#IT-WRITE-BACK>` | `<value-from-catalogs/interactions/flow-direction-catalog.yaml#FD-ONE-WAY>` | `catalogs/interactions/flow-evidence-rule-catalog.yaml#FER-VISIBLE-FLOW-SUPPORTS-ROW` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Audit event write. |
| F14 | RF-14 | CMP-11 | CMP-08 | `<value-from-catalogs/interactions/interaction-type-catalog.yaml#IT-TOOL-CALL>` | `<value-from-catalogs/interactions/flow-direction-catalog.yaml#FD-ONE-WAY>` | `catalogs/interactions/flow-evidence-rule-catalog.yaml#FER-VISIBLE-FLOW-SUPPORTS-ROW`; `catalogs/interactions/flow-evidence-rule-catalog.yaml#FER-VALIDATION-ROUTE-IF-PROOF-NEEDED` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | `formatted_only` draft handoff to Atlassian Cloud. |

## Unknowns

| unknown_id | flow_id | what_is_unknown | catalog_reference_checked |
|---|---|---|---|
| UDF-01 | F9 | Whether the AI Analysis Connector redacts the request body before transmission to the external SaaS (the visible label asserts `C4`, but the operator must confirm whether C4 review-IP is sent verbatim or redacted) | `catalogs/data-protection/data-class-catalog.yaml` |
| UDF-02 | F10 | Same as UDF-01 for the inbound response payload (does the response carry C4 review-IP back, or only synthesised summary text?) | `catalogs/data-protection/data-class-catalog.yaml` |
| UDF-03 | every flow carrying `IA#` or `SA#` | Authorization scope (`AZ-UNKNOWN`); not visibly represented on the diagram per the founder rule that authentication never implies authorization | `catalogs/identity-access/authorization-catalog.yaml` |

## Stop Conditions Recorded

None at this step.
