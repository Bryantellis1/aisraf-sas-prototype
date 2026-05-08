---
expected_baseline_id: EXP-DFD-03-COMPONENT-CATALOG
sample_id: sample-001-dfd-crop
mirrors_template: templates/output/output-dfd-03-component-catalog-template.md
prompt: prompts/dfd/04-component-extract.prompt.md
skill: skills/dfd/SK-DFD-03-COMPONENT-EXTRACT.md
owning_pra: PRA-03-DFD-EXTRACTOR
adapter: .agents/aisraf-dfd-extractor.agent.md
target_run_output: "{{output_root}}/dfd/03-component-catalog.md"
expected_outcome: PASS_READY_FOR_REVIEW
scoring_basis: template-aligned qualitative baseline; numeric scoring deferred to Build Package 11 run execution
package_version: v0.1.2
---

# DFD Component Catalog — sample-001-dfd-crop

| field | value |
|---|---|
| run_id | `{{run_id}}` |
| sample_id | sample-001-dfd-crop |
| mode | `{{mode}}` |
| output_root | `{{output_root}}` |
| dfd_step | DFD-03 |
| prompt | prompts/dfd/04-component-extract.prompt.md |
| skill | skills/dfd/SK-DFD-03-COMPONENT-EXTRACT.md |
| owning_pra | PRA-03-DFD-EXTRACTOR |

## Component Catalog Rows

| component_id | label | component_type | component_role | parent_boundary_id | source_location | evidence_rule_applied | confidence | notes |
|---|---|---|---|---|---|---|---|---|
| CMP-01 | Reviewer Browser | `<value-from-catalogs/components/component-type-catalog.yaml#CT-EXTERNAL-ACTOR>` | `<value-from-catalogs/components/component-role-catalog.yaml#CR-ACTOR>` | BND-01 | `dfd-crop.png` External User / Internet Zone | `catalogs/components/component-evidence-rule-catalog.yaml#CER-VISIBLE-LABEL-SUPPORTS-TYPE` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Internal reviewer at a browser; treated as external_actor pre-authentication. |
| CMP-02 | Review Portal Web App | `<value-from-catalogs/components/component-type-catalog.yaml#CT-APPLICATION-SERVICE>` | `<value-from-catalogs/components/component-role-catalog.yaml#CR-INTERMEDIATE-HOP>` | BND-05 | `dfd-crop.png` Application subnet | `catalogs/components/component-evidence-rule-catalog.yaml#CER-VISIBLE-LABEL-SUPPORTS-TYPE` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | First-party UI service. |
| CMP-03 | API Gateway | `<value-from-catalogs/components/component-type-catalog.yaml#CT-GATEWAY-SERVICE>` | `<value-from-catalogs/components/component-role-catalog.yaml#CR-CONTROL-PLANE>` | BND-05 | `dfd-crop.png` Application subnet | `catalogs/components/component-evidence-rule-catalog.yaml#CER-VISIBLE-LABEL-SUPPORTS-TYPE` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | API entry control plane; gateway label is signal only (`SR-GATEWAY-NOT-ENFORCEMENT`). |
| CMP-04 | Review Metadata Cloud SQL | `<value-from-catalogs/components/component-type-catalog.yaml#CT-DATA-STORE>` | `<value-from-catalogs/components/component-role-catalog.yaml#CR-STORE>` | BND-06 | `dfd-crop.png` Data subnet | `catalogs/components/component-evidence-rule-catalog.yaml#CER-VISIBLE-LABEL-SUPPORTS-TYPE`; `catalogs/components/component-evidence-rule-catalog.yaml#CER-COMPONENT-MARKER-IS-COMPONENT-SCOPE` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Visible storage tuple `C4 • R1 • Enc`; KMS / key rotation / scope unknown (drives MF-02). |
| CMP-05 | External AI Model Endpoint | `<value-from-catalogs/components/component-type-catalog.yaml#CT-MODEL-ENDPOINT>` | `<value-from-catalogs/components/component-role-catalog.yaml#CR-DESTINATION>` | BND-07 | `dfd-crop.png` External AI SaaS Provider Zone | `catalogs/components/component-evidence-rule-catalog.yaml#CER-VISIBLE-LABEL-SUPPORTS-TYPE`; `catalogs/components/component-evidence-rule-catalog.yaml#CER-CLOUD-LABEL-IS-CANDIDATE` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | External SaaS confirmed by `cloud-triage-notes.md` and `review-transcript.md`. |
| CMP-06 | Policy Reference Store | `<value-from-catalogs/components/component-type-catalog.yaml#CT-DATA-STORE>` | `<value-from-catalogs/components/component-role-catalog.yaml#CR-STORE>` | BND-06 | `dfd-crop.png` Data subnet | `catalogs/components/component-evidence-rule-catalog.yaml#CER-VISIBLE-LABEL-SUPPORTS-TYPE` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Visible storage tuple `C2 • R1 • Enc`. Internal policy reference. |
| CMP-07 | Findings Store | `<value-from-catalogs/components/component-type-catalog.yaml#CT-DATA-STORE>` | `<value-from-catalogs/components/component-role-catalog.yaml#CR-STORE>` | BND-06 | `dfd-crop.png` Data subnet | `catalogs/components/component-evidence-rule-catalog.yaml#CER-VISIBLE-LABEL-SUPPORTS-TYPE` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Visible storage tuple `C4 • R1 • Enc`. Internal finding records. |
| CMP-08 | Jira / Confluence API | `<value-from-catalogs/components/component-type-catalog.yaml#CT-TOOL-OR-API-SURFACE>` | `<value-from-catalogs/components/component-role-catalog.yaml#CR-DESTINATION>` | BND-08 | `dfd-crop.png` Atlassian Cloud / Jira-Confluence Zone | `catalogs/components/component-evidence-rule-catalog.yaml#CER-VISIBLE-LABEL-SUPPORTS-TYPE`; `catalogs/components/component-evidence-rule-catalog.yaml#CER-INFERENCE-NOT-ALLOWED` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | F14 destination; `formatted_only` — no executed_by_operator claim from this step. |
| CMP-09 | Cloud Load Balancer | `<value-from-catalogs/components/component-type-catalog.yaml#CT-APPLICATION-SERVICE>` | `<value-from-catalogs/components/component-role-catalog.yaml#CR-INTERMEDIATE-HOP>` | BND-04 | `dfd-crop.png` Edge subnet | `catalogs/components/component-evidence-rule-catalog.yaml#CER-VISIBLE-LABEL-SUPPORTS-TYPE` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | L7 HTTPS LB at the GCP edge. |
| CMP-10 | Cloud Armor / WAF | `<value-from-catalogs/components/component-type-catalog.yaml#CT-GATEWAY-SERVICE>` | `<value-from-catalogs/components/component-role-catalog.yaml#CR-CONTROL-PLANE>` | BND-04 | `dfd-crop.png` Edge subnet (carries `S1 ◇`) | `catalogs/components/component-evidence-rule-catalog.yaml#CER-VISIBLE-LABEL-SUPPORTS-TYPE`; `catalogs/components/component-evidence-rule-catalog.yaml#CER-COMPONENT-MARKER-IS-COMPONENT-SCOPE` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | `S1 ◇` is a security-stack signal at the internet edge; not approved-stack proof (drives MF-01). |
| CMP-11 | Review Orchestrator Service | `<value-from-catalogs/components/component-type-catalog.yaml#CT-APPLICATION-SERVICE>` | `<value-from-catalogs/components/component-role-catalog.yaml#CR-CONTROL-PLANE>` | BND-05 | `dfd-crop.png` Application subnet | `catalogs/components/component-evidence-rule-catalog.yaml#CER-VISIBLE-LABEL-SUPPORTS-TYPE` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Fans out to data subnet, AI Connector, and Atlassian destination. |
| CMP-12 | AI Analysis Connector | `<value-from-catalogs/components/component-type-catalog.yaml#CT-APPLICATION-SERVICE>` | `<value-from-catalogs/components/component-role-catalog.yaml#CR-INTERMEDIATE-HOP>` | BND-05 | `dfd-crop.png` Application subnet | `catalogs/components/component-evidence-rule-catalog.yaml#CER-VISIBLE-LABEL-SUPPORTS-TYPE` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Egress connector to External AI Model Endpoint. Whether the connector redacts before transmission drives MF-03. |
| CMP-13 | Review Artifact Bucket | `<value-from-catalogs/components/component-type-catalog.yaml#CT-DATA-STORE>` | `<value-from-catalogs/components/component-role-catalog.yaml#CR-STORE>` | BND-06 | `dfd-crop.png` Data subnet | `catalogs/components/component-evidence-rule-catalog.yaml#CER-VISIBLE-LABEL-SUPPORTS-TYPE` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Visible storage tuple `C4 • R1 • Enc`. Object store for handoff packs. |
| CMP-14 | Audit Log Store | `<value-from-catalogs/components/component-type-catalog.yaml#CT-DATA-STORE>` | `<value-from-catalogs/components/component-role-catalog.yaml#CR-STORE>` | BND-06 | `dfd-crop.png` Data subnet | `catalogs/components/component-evidence-rule-catalog.yaml#CER-VISIBLE-LABEL-SUPPORTS-TYPE` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Visible storage tuple `C4 • R1 • Enc`. Audit event sink. |

## Unknowns

None at this step. Every visible component classifies to a controlled value with at least high confidence. KMS / key rotation / scope on the five Data subnet stores is recorded as a downstream missing fact at DFD-07 / RS-09, not as a component-extraction unknown.

## Stop Conditions Recorded

None at this step.
