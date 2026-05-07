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
| CMP-01 | Reviewer Browser | `<value-from-catalogs/components/component-type-catalog.yaml#CT-EXTERNAL-ACTOR>` | `<value-from-catalogs/components/component-role-catalog.yaml#CR-ACTOR>` | BND-01 | `dfd-crop.png` BND-01 | `catalogs/components/component-evidence-rule-catalog.yaml#CER-VISIBLE-LABEL-SUPPORTS-TYPE` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Treated as external_actor pre-authentication. |
| CMP-02 | Review Portal Web App | `<value-from-catalogs/components/component-type-catalog.yaml#CT-APPLICATION-SERVICE>` | `<value-from-catalogs/components/component-role-catalog.yaml#CR-INTERMEDIATE-HOP>` | BND-03 | `dfd-crop.png` BND-03 | `catalogs/components/component-evidence-rule-catalog.yaml#CER-VISIBLE-LABEL-SUPPORTS-TYPE` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | First-party UI service. |
| CMP-03 | Review API Gateway | `<value-from-catalogs/components/component-type-catalog.yaml#CT-GATEWAY-SERVICE>` | `<value-from-catalogs/components/component-role-catalog.yaml#CR-CONTROL-PLANE>` | BND-03 | `dfd-crop.png` BND-03 | `catalogs/components/component-evidence-rule-catalog.yaml#CER-VISIBLE-LABEL-SUPPORTS-TYPE`; `catalogs/components/component-evidence-rule-catalog.yaml#CER-COMPONENT-MARKER-IS-COMPONENT-SCOPE` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | S1 marker is component-scope only. |
| CMP-04 | Review Metadata DB | `<value-from-catalogs/components/component-type-catalog.yaml#CT-DATA-STORE>` | `<value-from-catalogs/components/component-role-catalog.yaml#CR-STORE>` | BND-04 | `dfd-crop.png` BND-04 | `catalogs/components/component-evidence-rule-catalog.yaml#CER-VISIBLE-LABEL-SUPPORTS-TYPE`; `catalogs/components/component-evidence-rule-catalog.yaml#CER-COMPONENT-MARKER-IS-COMPONENT-SCOPE` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | E1 marker is component-scope only. |
| CMP-05 | AI Analysis Service | `<value-from-catalogs/components/component-type-catalog.yaml#CT-MODEL-ENDPOINT>` | `<value-from-catalogs/components/component-role-catalog.yaml#CR-DESTINATION>` | BND-02 | `dfd-crop.png` BND-02 | `catalogs/components/component-evidence-rule-catalog.yaml#CER-VISIBLE-LABEL-SUPPORTS-TYPE`; `catalogs/components/component-evidence-rule-catalog.yaml#CER-CLOUD-LABEL-IS-CANDIDATE` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | External SaaS endpoint. |
| CMP-06 | Policy Reference Store | `<value-from-catalogs/components/component-type-catalog.yaml#CT-DATA-STORE>` | `<value-from-catalogs/components/component-role-catalog.yaml#CR-STORE>` | BND-04 | `dfd-crop.png` BND-04 | `catalogs/components/component-evidence-rule-catalog.yaml#CER-VISIBLE-LABEL-SUPPORTS-TYPE` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Internal C2. |
| CMP-07 | Findings Store | `<value-from-catalogs/components/component-type-catalog.yaml#CT-DATA-STORE>` | `<value-from-catalogs/components/component-role-catalog.yaml#CR-STORE>` | BND-04 | `dfd-crop.png` BND-04 | `catalogs/components/component-evidence-rule-catalog.yaml#CER-VISIBLE-LABEL-SUPPORTS-TYPE` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Internal C4. |
| CMP-08 | Jira/Confluence Draft Formatter | `<value-from-catalogs/components/component-type-catalog.yaml#CT-TOOL-OR-API-SURFACE>` | `<value-from-catalogs/components/component-role-catalog.yaml#CR-DESTINATION>` | BND-03 | `dfd-crop.png` BND-03 | `catalogs/components/component-evidence-rule-catalog.yaml#CER-VISIBLE-LABEL-SUPPORTS-TYPE`; `catalogs/components/component-evidence-rule-catalog.yaml#CER-INFERENCE-NOT-ALLOWED` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | `formatted_only`. |

## Unknowns

None at this step. Every visible component classifies to a controlled value with at least high confidence.

## Stop Conditions Recorded

None at this step.
