# Flows — RUN-001
| field | value |
|---|---|
| run_id | `RUN-001` |
| sample_id | sample-001-dfd-crop |
| mode | `folder_first_test` |
| output_root | `runs/RUN-001` |
| step | RS-04 |
| prompt | prompts/rs/04-design-fact-extract.prompt.md |
| skill | skills/rs/SK-FLOW-EXTRACT.md |
| owning_pra | PRA-03-DFD-EXTRACTOR |

## Flows Table

Each `data_payload_observed` cell records the verbatim visible flow tuple from the DFD; flow-label grammar is `<data/action name> / <C#>,<T#>,<SA#|CA#|IA#>,<AZ#|AZ?>`. `AZ?` is visible on every flow and resolves to `AZ-UNKNOWN`; authentication never implies authorization.

| flow_id | source_component_id | destination_component_id | interaction_type | flow_direction | data_payload_observed | source_location | evidence_rule_applied | confidence | notes |
|---|---|---|---|---|---|---|---|---|---|
| F1 | CMP-01 | CMP-09 | `<value-from-catalogs/interactions/interaction-type-catalog.yaml#IT-DATA-FLOW>` | `<value-from-catalogs/interactions/flow-direction-catalog.yaml#FD-REQUEST-RESPONSE>` | `Review Request / C4,T1,IA1,AZ?` | `dfd-crop.png` F1 | `catalogs/interactions/flow-evidence-rule-catalog.yaml#FER-VISIBLE-FLOW-SUPPORTS-ROW`; `catalogs/interactions/flow-evidence-rule-catalog.yaml#FER-ANNOTATION-TOKEN-PER-CATALOG` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Inbound app entry from internet to GCP edge. |
| F2 | CMP-09 | CMP-10 | `<value-from-catalogs/interactions/interaction-type-catalog.yaml#IT-DATA-FLOW>` | `<value-from-catalogs/interactions/flow-direction-catalog.yaml#FD-ONE-WAY>` | `Inspected Request / C4,T1,IA1,AZ?` | `dfd-crop.png` F2 | `catalogs/interactions/flow-evidence-rule-catalog.yaml#FER-VISIBLE-FLOW-SUPPORTS-ROW` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Edge-internal hop. |
| F3 | CMP-10 | CMP-02 | `<value-from-catalogs/interactions/interaction-type-catalog.yaml#IT-DATA-FLOW>` | `<value-from-catalogs/interactions/flow-direction-catalog.yaml#FD-REQUEST-RESPONSE>` | `Forwarded Request / C4,T1,IA1,AZ?` | `dfd-crop.png` F3 | `catalogs/interactions/flow-evidence-rule-catalog.yaml#FER-VISIBLE-FLOW-SUPPORTS-ROW` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Edge → Application subnet. |
| F4 | CMP-02 | CMP-03 | `<value-from-catalogs/interactions/interaction-type-catalog.yaml#IT-DATA-FLOW>` | `<value-from-catalogs/interactions/flow-direction-catalog.yaml#FD-REQUEST-RESPONSE>` | `API Call / C4,T1,SA5,AZ?` | `dfd-crop.png` F4 | `catalogs/interactions/flow-evidence-rule-catalog.yaml#FER-VISIBLE-FLOW-SUPPORTS-ROW` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Service-to-service AuthN; AZ scope unknown. |
| F5 | CMP-03 | CMP-11 | `<value-from-catalogs/interactions/interaction-type-catalog.yaml#IT-DATA-FLOW>` | `<value-from-catalogs/interactions/flow-direction-catalog.yaml#FD-REQUEST-RESPONSE>` | `Orchestrate Review / C4,T1,SA5,AZ?` | `dfd-crop.png` F5 | `catalogs/interactions/flow-evidence-rule-catalog.yaml#FER-VISIBLE-FLOW-SUPPORTS-ROW` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Internal orchestration hop. |
| F6 | CMP-11 | CMP-04 | `<value-from-catalogs/interactions/interaction-type-catalog.yaml#IT-WRITE-BACK>` | `<value-from-catalogs/interactions/flow-direction-catalog.yaml#FD-ONE-WAY>` | `Metadata Write / C4,T1,SA5,AZ?` | `dfd-crop.png` F6 | `catalogs/interactions/flow-evidence-rule-catalog.yaml#FER-VISIBLE-FLOW-SUPPORTS-ROW`; `catalogs/interactions/flow-evidence-rule-catalog.yaml#FER-COMPONENT-MARKER-DOES-NOT-PROPAGATE` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Cloud SQL metadata write. `Enc` on CMP-04 is component-scope, not a flow-scope encryption claim. |
| F7 | CMP-11 | CMP-06 | `<value-from-catalogs/interactions/interaction-type-catalog.yaml#IT-DATA-FLOW>` | `<value-from-catalogs/interactions/flow-direction-catalog.yaml#FD-REQUEST-RESPONSE>` | `Policy Lookup / C2,T1,SA5,AZ?` | `dfd-crop.png` F7 | `catalogs/interactions/flow-evidence-rule-catalog.yaml#FER-VISIBLE-FLOW-SUPPORTS-ROW` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Read-only policy reference. |
| F8 | CMP-11 | CMP-12 | `<value-from-catalogs/interactions/interaction-type-catalog.yaml#IT-DATA-FLOW>` | `<value-from-catalogs/interactions/flow-direction-catalog.yaml#FD-REQUEST-RESPONSE>` | `Analysis Request / C4,T1,SA5,AZ?` | `dfd-crop.png` F8 | `catalogs/interactions/flow-evidence-rule-catalog.yaml#FER-VISIBLE-FLOW-SUPPORTS-ROW` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Internal application-subnet hop to egress connector. |
| F9 | CMP-12 | CMP-05 | `<value-from-catalogs/interactions/interaction-type-catalog.yaml#IT-MODEL-CALL>` | `<value-from-catalogs/interactions/flow-direction-catalog.yaml#FD-REQUEST-RESPONSE>` | `Model Prompt / C4,T1,SA7,AZ?` | `dfd-crop.png` F9 | `catalogs/interactions/flow-evidence-rule-catalog.yaml#FER-VISIBLE-FLOW-SUPPORTS-ROW`; `catalogs/interactions/flow-evidence-rule-catalog.yaml#FER-MISSING-FACT-IF-MATERIAL` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-MEDIUM>` | Cross-internet to External AI Model Endpoint. Whether AI Connector redacts before transmission drives MF-03. |
| F10 | CMP-05 | CMP-12 | `<value-from-catalogs/interactions/interaction-type-catalog.yaml#IT-DATA-FLOW>` | `<value-from-catalogs/interactions/flow-direction-catalog.yaml#FD-ONE-WAY>` | `Model Response / C4,T1,SA7,AZ?` | `dfd-crop.png` F10 | `catalogs/interactions/flow-evidence-rule-catalog.yaml#FER-VISIBLE-FLOW-SUPPORTS-ROW`; `catalogs/interactions/flow-evidence-rule-catalog.yaml#FER-MISSING-FACT-IF-MATERIAL` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-MEDIUM>` | Inbound model response carrying `C4`. |
| F11 | CMP-11 | CMP-07 | `<value-from-catalogs/interactions/interaction-type-catalog.yaml#IT-WRITE-BACK>` | `<value-from-catalogs/interactions/flow-direction-catalog.yaml#FD-ONE-WAY>` | `Finding Write / C4,T1,SA5,AZ?` | `dfd-crop.png` F11 | `catalogs/interactions/flow-evidence-rule-catalog.yaml#FER-VISIBLE-FLOW-SUPPORTS-ROW` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Findings store. |
| F12 | CMP-11 | CMP-13 | `<value-from-catalogs/interactions/interaction-type-catalog.yaml#IT-WRITE-BACK>` | `<value-from-catalogs/interactions/flow-direction-catalog.yaml#FD-ONE-WAY>` | `Handoff Pack Write / C4,T1,SA5,AZ?` | `dfd-crop.png` F12 | `catalogs/interactions/flow-evidence-rule-catalog.yaml#FER-VISIBLE-FLOW-SUPPORTS-ROW` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Handoff pack write. |
| F13 | CMP-11 | CMP-14 | `<value-from-catalogs/interactions/interaction-type-catalog.yaml#IT-WRITE-BACK>` | `<value-from-catalogs/interactions/flow-direction-catalog.yaml#FD-ONE-WAY>` | `Audit Event / C4,T1,SA5,AZ?` | `dfd-crop.png` F13 | `catalogs/interactions/flow-evidence-rule-catalog.yaml#FER-VISIBLE-FLOW-SUPPORTS-ROW` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Audit event write. |
| F14 | CMP-11 | CMP-08 | `<value-from-catalogs/interactions/interaction-type-catalog.yaml#IT-TOOL-CALL>` | `<value-from-catalogs/interactions/flow-direction-catalog.yaml#FD-ONE-WAY>` | `Draft Handoff / C4,T1,SA5,AZ?` | `dfd-crop.png` F14 | `catalogs/interactions/flow-evidence-rule-catalog.yaml#FER-VISIBLE-FLOW-SUPPORTS-ROW`; `catalogs/interactions/flow-evidence-rule-catalog.yaml#FER-VALIDATION-ROUTE-IF-PROOF-NEEDED` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Local draft only. No external post-back claim. |

## Unknowns

| unknown_id | flow_id | what_is_unknown | catalog_reference_checked | gap |
|---|---|---|---|---|
| UNK-06 | F9 | Whether AI Analysis Connector redacts `C4` review-IP before transmission to External AI Model Endpoint | `catalogs/data-protection/data-class-catalog.yaml` | Drives MF-03. |
| UNK-07 | F10 | Whether the inbound model response carries `C4` review-IP back, or only synthesised summary text | `catalogs/data-protection/data-class-catalog.yaml` | Drives MF-03. |
| UNK-08 | every flow with `IA#` or `SA#` | Authorization scope (`AZ-UNKNOWN`); not visibly represented per founder rule | `catalogs/identity-access/authorization-catalog.yaml` | Drives MF-04. |

## Stop Conditions Recorded

None at this step.

