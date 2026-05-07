---
expected_baseline_id: EXP-RS-04-COMPONENTS
sample_id: sample-001-dfd-crop
mirrors_template: templates/output/output-04-components-template.md
prompt: prompts/rs/04-design-fact-extract.prompt.md
skill: skills/rs/SK-COMPONENT-EXTRACT.md
owning_pra: PRA-03-DFD-EXTRACTOR
adapter: .agents/aisraf-dfd-extractor.agent.md
target_run_output: "{{output_root}}/04-components.md"
expected_outcome: PASS_READY_FOR_REVIEW
scoring_basis: template-aligned qualitative baseline; numeric scoring deferred to Build Package 11 run execution
package_version: v0.1.2
---

# Components — sample-001-dfd-crop

| field | value |
|---|---|
| run_id | `{{run_id}}` |
| sample_id | sample-001-dfd-crop |
| mode | `{{mode}}` |
| output_root | `{{output_root}}` |
| step | RS-04 |
| prompt | prompts/rs/04-design-fact-extract.prompt.md |
| skill | skills/rs/SK-COMPONENT-EXTRACT.md |
| owning_pra | PRA-03-DFD-EXTRACTOR |

## Components Table

| component_id | label | component_type | component_role | source_location | evidence_rule_applied | confidence | notes |
|---|---|---|---|---|---|---|---|
| CMP-01 | Reviewer Browser | `<value-from-catalogs/components/component-type-catalog.yaml#CT-EXTERNAL-ACTOR>` | `<value-from-catalogs/components/component-role-catalog.yaml#CR-ACTOR>` | `dfd-crop.png` (BND-01) | `catalogs/components/component-evidence-rule-catalog.yaml#CER-VISIBLE-LABEL-SUPPORTS-TYPE` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Reviewer is internal personnel but is treated as external_actor pre-authentication per `cloud-triage-notes.md` § 2. |
| CMP-02 | Review Portal Web App | `<value-from-catalogs/components/component-type-catalog.yaml#CT-APPLICATION-SERVICE>` | `<value-from-catalogs/components/component-role-catalog.yaml#CR-INTERMEDIATE-HOP>` | `dfd-crop.png` (BND-03) | `catalogs/components/component-evidence-rule-catalog.yaml#CER-VISIBLE-LABEL-SUPPORTS-TYPE` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | First-party UI service; visible label is sufficient evidence. |
| CMP-03 | Review API Gateway | `<value-from-catalogs/components/component-type-catalog.yaml#CT-GATEWAY-SERVICE>` | `<value-from-catalogs/components/component-role-catalog.yaml#CR-CONTROL-PLANE>` | `dfd-crop.png` (BND-03; S1 diamond) | `catalogs/components/component-evidence-rule-catalog.yaml#CER-VISIBLE-LABEL-SUPPORTS-TYPE`; `catalogs/components/component-evidence-rule-catalog.yaml#CER-COMPONENT-MARKER-IS-COMPONENT-SCOPE` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | S1 diamond is a component-scope marker; does not propagate to flows. |
| CMP-04 | Review Metadata DB | `<value-from-catalogs/components/component-type-catalog.yaml#CT-DATA-STORE>` | `<value-from-catalogs/components/component-role-catalog.yaml#CR-STORE>` | `dfd-crop.png` (BND-04; E1 marker) | `catalogs/components/component-evidence-rule-catalog.yaml#CER-VISIBLE-LABEL-SUPPORTS-TYPE`; `catalogs/components/component-evidence-rule-catalog.yaml#CER-COMPONENT-MARKER-IS-COMPONENT-SCOPE` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | E1 is component-scope only; KMS / scope unknown until separately confirmed (MF-02). |
| CMP-05 | AI Analysis Service | `<value-from-catalogs/components/component-type-catalog.yaml#CT-MODEL-ENDPOINT>` | `<value-from-catalogs/components/component-role-catalog.yaml#CR-DESTINATION>` | `dfd-crop.png` (BND-02) | `catalogs/components/component-evidence-rule-catalog.yaml#CER-VISIBLE-LABEL-SUPPORTS-TYPE`; `catalogs/components/component-evidence-rule-catalog.yaml#CER-CLOUD-LABEL-IS-CANDIDATE` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | External SaaS confirmed by `cloud-triage-notes.md` § 4 and `review-transcript.md` § 4. |
| CMP-06 | Policy Reference Store | `<value-from-catalogs/components/component-type-catalog.yaml#CT-DATA-STORE>` | `<value-from-catalogs/components/component-role-catalog.yaml#CR-STORE>` | `dfd-crop.png` (BND-04) | `catalogs/components/component-evidence-rule-catalog.yaml#CER-VISIBLE-LABEL-SUPPORTS-TYPE` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Internal C2. |
| CMP-07 | Findings Store | `<value-from-catalogs/components/component-type-catalog.yaml#CT-DATA-STORE>` | `<value-from-catalogs/components/component-role-catalog.yaml#CR-STORE>` | `dfd-crop.png` (BND-04) | `catalogs/components/component-evidence-rule-catalog.yaml#CER-VISIBLE-LABEL-SUPPORTS-TYPE` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Internal C4 finding records. |
| CMP-08 | Jira/Confluence Draft Formatter | `<value-from-catalogs/components/component-type-catalog.yaml#CT-TOOL-OR-API-SURFACE>` | `<value-from-catalogs/components/component-role-catalog.yaml#CR-DESTINATION>` | `dfd-crop.png` (BND-03) | `catalogs/components/component-evidence-rule-catalog.yaml#CER-VISIBLE-LABEL-SUPPORTS-TYPE`; `catalogs/components/component-evidence-rule-catalog.yaml#CER-INFERENCE-NOT-ALLOWED` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | `formatted_only` — no executed_by_operator claim from this step. |

## Unknowns

| unknown_id | component_id | what_is_unknown | catalog_reference_checked | gap |
|---|---|---|---|---|
| UNK-04 | CMP-04 | KMS / key rotation / scope | `catalogs/data-protection/at-rest-protection-catalog.yaml` | Routes to MF-02 in `09-missing-facts.md`. |
| UNK-05 | CMP-05 | Specific external SaaS provider not named in this synthetic sample | `catalogs/components/component-type-catalog.yaml#ER-CT-03` | Routes to BP-AI-SAAS-INTEGRATION-MMF-01 in `09-missing-facts.md`. |

## Stop Conditions Recorded

None at this step.
