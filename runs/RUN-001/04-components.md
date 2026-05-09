# Components — RUN-001
| field | value |
|---|---|
| run_id | `RUN-001` |
| sample_id | sample-001-dfd-crop |
| mode | `folder_first_test` |
| output_root | `runs/RUN-001` |
| step | RS-04 |
| prompt | prompts/rs/04-design-fact-extract.prompt.md |
| skill | skills/rs/SK-COMPONENT-EXTRACT.md |
| owning_pra | PRA-03-DFD-EXTRACTOR |

## Components Table

| component_id | label | component_type | component_role | source_location | evidence_rule_applied | confidence | notes |
|---|---|---|---|---|---|---|---|
| CMP-01 | Reviewer Browser | `<value-from-catalogs/components/component-type-catalog.yaml#CT-EXTERNAL-ACTOR>` | `<value-from-catalogs/components/component-role-catalog.yaml#CR-ACTOR>` | `dfd-crop.png` (External User / Internet Zone) | `catalogs/components/component-evidence-rule-catalog.yaml#CER-VISIBLE-LABEL-SUPPORTS-TYPE` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Reviewer is internal personnel but is treated as external_actor pre-authentication per `cloud-triage-notes.md`. |
| CMP-02 | Review Portal Web App | `<value-from-catalogs/components/component-type-catalog.yaml#CT-APPLICATION-SERVICE>` | `<value-from-catalogs/components/component-role-catalog.yaml#CR-INTERMEDIATE-HOP>` | `dfd-crop.png` (Application subnet) | `catalogs/components/component-evidence-rule-catalog.yaml#CER-VISIBLE-LABEL-SUPPORTS-TYPE` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | First-party UI service. |
| CMP-03 | API Gateway | `<value-from-catalogs/components/component-type-catalog.yaml#CT-GATEWAY-SERVICE>` | `<value-from-catalogs/components/component-role-catalog.yaml#CR-CONTROL-PLANE>` | `dfd-crop.png` (Application subnet) | `catalogs/components/component-evidence-rule-catalog.yaml#CER-VISIBLE-LABEL-SUPPORTS-TYPE` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Gateway label is signal only. |
| CMP-04 | Review Metadata Cloud SQL | `<value-from-catalogs/components/component-type-catalog.yaml#CT-DATA-STORE>` | `<value-from-catalogs/components/component-role-catalog.yaml#CR-STORE>` | `dfd-crop.png` (Data subnet; visible storage tuple `C4 • R1 • Enc`) | `catalogs/components/component-evidence-rule-catalog.yaml#CER-VISIBLE-LABEL-SUPPORTS-TYPE`; `catalogs/components/component-evidence-rule-catalog.yaml#CER-COMPONENT-MARKER-IS-COMPONENT-SCOPE` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | `Enc` is component-scope only; KMS / scope unknown until separately confirmed (MF-02). |
| CMP-05 | External AI Model Endpoint | `<value-from-catalogs/components/component-type-catalog.yaml#CT-MODEL-ENDPOINT>` | `<value-from-catalogs/components/component-role-catalog.yaml#CR-DESTINATION>` | `dfd-crop.png` (External AI SaaS Provider Zone) | `catalogs/components/component-evidence-rule-catalog.yaml#CER-VISIBLE-LABEL-SUPPORTS-TYPE`; `catalogs/components/component-evidence-rule-catalog.yaml#CER-CLOUD-LABEL-IS-CANDIDATE` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | External SaaS confirmed by `cloud-triage-notes.md` and `review-transcript.md`. |
| CMP-06 | Policy Reference Store | `<value-from-catalogs/components/component-type-catalog.yaml#CT-DATA-STORE>` | `<value-from-catalogs/components/component-role-catalog.yaml#CR-STORE>` | `dfd-crop.png` (Data subnet; visible storage tuple `C2 • R1 • Enc`) | `catalogs/components/component-evidence-rule-catalog.yaml#CER-VISIBLE-LABEL-SUPPORTS-TYPE` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Internal C2 reference store. |
| CMP-07 | Findings Store | `<value-from-catalogs/components/component-type-catalog.yaml#CT-DATA-STORE>` | `<value-from-catalogs/components/component-role-catalog.yaml#CR-STORE>` | `dfd-crop.png` (Data subnet; visible storage tuple `C4 • R1 • Enc`) | `catalogs/components/component-evidence-rule-catalog.yaml#CER-VISIBLE-LABEL-SUPPORTS-TYPE` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Internal C4 finding records. |
| CMP-08 | Jira / Confluence API | `<value-from-catalogs/components/component-type-catalog.yaml#CT-TOOL-OR-API-SURFACE>` | `<value-from-catalogs/components/component-role-catalog.yaml#CR-DESTINATION>` | `dfd-crop.png` (Atlassian Cloud / Jira-Confluence Zone) | `catalogs/components/component-evidence-rule-catalog.yaml#CER-VISIBLE-LABEL-SUPPORTS-TYPE`; `catalogs/components/component-evidence-rule-catalog.yaml#CER-INFERENCE-NOT-ALLOWED` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | `formatted_only` — no executed_by_operator claim from this step. |
| CMP-09 | Cloud Load Balancer | `<value-from-catalogs/components/component-type-catalog.yaml#CT-APPLICATION-SERVICE>` | `<value-from-catalogs/components/component-role-catalog.yaml#CR-INTERMEDIATE-HOP>` | `dfd-crop.png` (Edge subnet) | `catalogs/components/component-evidence-rule-catalog.yaml#CER-VISIBLE-LABEL-SUPPORTS-TYPE` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | L7 HTTPS LB at the GCP edge. |
| CMP-10 | Cloud Armor / WAF | `<value-from-catalogs/components/component-type-catalog.yaml#CT-GATEWAY-SERVICE>` | `<value-from-catalogs/components/component-role-catalog.yaml#CR-CONTROL-PLANE>` | `dfd-crop.png` (Edge subnet; carries `S1 ◇`) | `catalogs/components/component-evidence-rule-catalog.yaml#CER-VISIBLE-LABEL-SUPPORTS-TYPE`; `catalogs/components/component-evidence-rule-catalog.yaml#CER-COMPONENT-MARKER-IS-COMPONENT-SCOPE` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Edge security-stack diamond; not approved-stack proof (drives MF-01). |
| CMP-11 | Review Orchestrator Service | `<value-from-catalogs/components/component-type-catalog.yaml#CT-APPLICATION-SERVICE>` | `<value-from-catalogs/components/component-role-catalog.yaml#CR-CONTROL-PLANE>` | `dfd-crop.png` (Application subnet) | `catalogs/components/component-evidence-rule-catalog.yaml#CER-VISIBLE-LABEL-SUPPORTS-TYPE` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Fans out to data subnet, AI Connector, and Atlassian destination. |
| CMP-12 | AI Analysis Connector | `<value-from-catalogs/components/component-type-catalog.yaml#CT-APPLICATION-SERVICE>` | `<value-from-catalogs/components/component-role-catalog.yaml#CR-INTERMEDIATE-HOP>` | `dfd-crop.png` (Application subnet) | `catalogs/components/component-evidence-rule-catalog.yaml#CER-VISIBLE-LABEL-SUPPORTS-TYPE` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Egress connector; redaction posture before transmission to External AI Model Endpoint drives MF-03. |
| CMP-13 | Review Artifact Bucket | `<value-from-catalogs/components/component-type-catalog.yaml#CT-DATA-STORE>` | `<value-from-catalogs/components/component-role-catalog.yaml#CR-STORE>` | `dfd-crop.png` (Data subnet; visible storage tuple `C4 • R1 • Enc`) | `catalogs/components/component-evidence-rule-catalog.yaml#CER-VISIBLE-LABEL-SUPPORTS-TYPE` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Object store for handoff packs. |
| CMP-14 | Audit Log Store | `<value-from-catalogs/components/component-type-catalog.yaml#CT-DATA-STORE>` | `<value-from-catalogs/components/component-role-catalog.yaml#CR-STORE>` | `dfd-crop.png` (Data subnet; visible storage tuple `C4 • R1 • Enc`) | `catalogs/components/component-evidence-rule-catalog.yaml#CER-VISIBLE-LABEL-SUPPORTS-TYPE` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Audit event sink. |

## Unknowns

| unknown_id | component_id | what_is_unknown | catalog_reference_checked | gap |
|---|---|---|---|---|
| UNK-04 | CMP-04 / CMP-06 / CMP-07 / CMP-13 / CMP-14 | KMS / key rotation / scope on the five Data subnet stores | `catalogs/data-protection/at-rest-protection-catalog.yaml` | Routes to MF-02 in `09-missing-facts.md`. |
| UNK-05 | CMP-05 | Specific external SaaS provider not named in this synthetic sample | `catalogs/components/component-type-catalog.yaml#ER-CT-03` | Routes to BP-AI-SAAS-INTEGRATION-MMF-01 in `09-missing-facts.md`. |
| UNK-06 | CMP-12 | Whether the AI Analysis Connector redacts `C4` review-IP before transmission to CMP-05 | `catalogs/data-protection/data-class-catalog.yaml` | Routes to MF-03. |

## Stop Conditions Recorded

None at this step.

