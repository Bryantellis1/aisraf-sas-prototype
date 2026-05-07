---
expected_baseline_id: EXP-RS-05-FLOWS
sample_id: sample-001-dfd-crop
mirrors_template: templates/output/output-05-flows-template.md
prompt: prompts/rs/04-design-fact-extract.prompt.md
skill: skills/rs/SK-FLOW-EXTRACT.md
owning_pra: PRA-03-DFD-EXTRACTOR
adapter: .agents/aisraf-dfd-extractor.agent.md
target_run_output: "{{output_root}}/05-flows.md"
expected_outcome: PASS_READY_FOR_REVIEW
scoring_basis: template-aligned qualitative baseline; numeric scoring deferred to Build Package 11 run execution
package_version: v0.1.2
---

# Flows — sample-001-dfd-crop

| field | value |
|---|---|
| run_id | `{{run_id}}` |
| sample_id | sample-001-dfd-crop |
| mode | `{{mode}}` |
| output_root | `{{output_root}}` |
| step | RS-04 |
| prompt | prompts/rs/04-design-fact-extract.prompt.md |
| skill | skills/rs/SK-FLOW-EXTRACT.md |
| owning_pra | PRA-03-DFD-EXTRACTOR |

## Flows Table

| flow_id | source_component_id | destination_component_id | interaction_type | flow_direction | data_payload_observed | source_location | evidence_rule_applied | confidence | notes |
|---|---|---|---|---|---|---|---|---|---|
| F1 | CMP-01 | CMP-02 | `<value-from-catalogs/interactions/interaction-type-catalog.yaml#IT-DATA-FLOW>` | `<value-from-catalogs/interactions/flow-direction-catalog.yaml#FD-REQUEST-RESPONSE>` | C4 review request payload; `IA1`; `T1` | `dfd-crop.png` F1 | `catalogs/interactions/flow-evidence-rule-catalog.yaml#FER-VISIBLE-FLOW-SUPPORTS-ROW`; `catalogs/interactions/flow-evidence-rule-catalog.yaml#FER-ANNOTATION-TOKEN-PER-CATALOG` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | HTTPS label normalised to `T1` transit marker. |
| F2 | CMP-02 | CMP-03 | `<value-from-catalogs/interactions/interaction-type-catalog.yaml#IT-DATA-FLOW>` | `<value-from-catalogs/interactions/flow-direction-catalog.yaml#FD-REQUEST-RESPONSE>` | API call; `SA1` | `dfd-crop.png` F2 | `catalogs/interactions/flow-evidence-rule-catalog.yaml#FER-VISIBLE-FLOW-SUPPORTS-ROW` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Service-to-service auth on F2; AZ scope is recorded separately. |
| F3 | CMP-03 | CMP-04 | `<value-from-catalogs/interactions/interaction-type-catalog.yaml#IT-WRITE-BACK>` | `<value-from-catalogs/interactions/flow-direction-catalog.yaml#FD-ONE-WAY>` | C4P metadata write; `E1` marker on destination | `dfd-crop.png` F3 | `catalogs/interactions/flow-evidence-rule-catalog.yaml#FER-VISIBLE-FLOW-SUPPORTS-ROW`; `catalogs/interactions/flow-evidence-rule-catalog.yaml#FER-COMPONENT-MARKER-DOES-NOT-PROPAGATE` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | E1 is component-scope on CMP-04, not a flow-scope encryption claim. |
| F4 | CMP-03 | CMP-05 | `<value-from-catalogs/interactions/interaction-type-catalog.yaml#IT-MODEL-CALL>` | `<value-from-catalogs/interactions/flow-direction-catalog.yaml#FD-REQUEST-RESPONSE>` | model call; `SA1`; request body data class **unknown** | `dfd-crop.png` F4 | `catalogs/interactions/flow-evidence-rule-catalog.yaml#FER-VISIBLE-FLOW-SUPPORTS-ROW`; `catalogs/interactions/flow-evidence-rule-catalog.yaml#FER-MISSING-FACT-IF-MATERIAL` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-MEDIUM>` | Cross-internet to external SaaS. Request payload class drives MF-03. |
| F5 | CMP-05 | CMP-03 | `<value-from-catalogs/interactions/interaction-type-catalog.yaml#IT-DATA-FLOW>` | `<value-from-catalogs/interactions/flow-direction-catalog.yaml#FD-ONE-WAY>` | model response; data class **unknown** | `dfd-crop.png` F5 | `catalogs/interactions/flow-evidence-rule-catalog.yaml#FER-VISIBLE-FLOW-SUPPORTS-ROW`; `catalogs/interactions/flow-evidence-rule-catalog.yaml#FER-MISSING-FACT-IF-MATERIAL` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-LOW>` | Response body class is genuinely unknown until MF-03 resolves. |
| F6 | CMP-03 | CMP-07 | `<value-from-catalogs/interactions/interaction-type-catalog.yaml#IT-WRITE-BACK>` | `<value-from-catalogs/interactions/flow-direction-catalog.yaml#FD-ONE-WAY>` | C4 finding-record write | `dfd-crop.png` F6 | `catalogs/interactions/flow-evidence-rule-catalog.yaml#FER-VISIBLE-FLOW-SUPPORTS-ROW` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Findings store. |
| F7 | CMP-03 | CMP-06 | `<value-from-catalogs/interactions/interaction-type-catalog.yaml#IT-DATA-FLOW>` | `<value-from-catalogs/interactions/flow-direction-catalog.yaml#FD-REQUEST-RESPONSE>` | C2 policy reference read | `dfd-crop.png` F7 | `catalogs/interactions/flow-evidence-rule-catalog.yaml#FER-VISIBLE-FLOW-SUPPORTS-ROW` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Read-only. |
| F8 | CMP-03 | CMP-08 | `<value-from-catalogs/interactions/interaction-type-catalog.yaml#IT-TOOL-CALL>` | `<value-from-catalogs/interactions/flow-direction-catalog.yaml#FD-ONE-WAY>` | formatted_only draft handoff | `dfd-crop.png` F8 | `catalogs/interactions/flow-evidence-rule-catalog.yaml#FER-VISIBLE-FLOW-SUPPORTS-ROW`; `catalogs/interactions/flow-evidence-rule-catalog.yaml#FER-VALIDATION-ROUTE-IF-PROOF-NEEDED` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Local draft only. No external post-back claim. |

## Unknowns

| unknown_id | flow_id | what_is_unknown | catalog_reference_checked | gap |
|---|---|---|---|---|
| UNK-06 | F4 | Data class on the model-call request body | `catalogs/data-protection/data-class-catalog.yaml` | Drives MF-03; resolved by TQ-03. |
| UNK-07 | F5 | Data class on the model-response payload | `catalogs/data-protection/data-class-catalog.yaml` | Drives MF-03; same targeted question. |
| UNK-08 | F4 | Authorization scope at CMP-05 SaaS endpoint | `catalogs/identity-access/authorization-catalog.yaml` | Drives MF-04; resolved by TQ-04. |

## Stop Conditions Recorded

None at this step.
