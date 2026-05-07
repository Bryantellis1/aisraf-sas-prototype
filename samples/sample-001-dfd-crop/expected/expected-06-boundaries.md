---
expected_baseline_id: EXP-RS-06-BOUNDARIES
sample_id: sample-001-dfd-crop
mirrors_template: templates/output/output-06-boundaries-template.md
prompt: prompts/rs/05-boundary-stack-detect.prompt.md
skill: skills/rs/SK-BOUNDARY-CROSSING-DETECT.md
owning_pra: PRA-05-REVIEW-TABLE-BUILDER
adapter: .agents/aisraf-review-table-builder.agent.md
target_run_output: "{{output_root}}/06-boundaries.md"
expected_outcome: PASS_READY_FOR_REVIEW
scoring_basis: template-aligned qualitative baseline; numeric scoring deferred to Build Package 11 run execution
package_version: v0.1.2
---

# Boundaries — sample-001-dfd-crop

| field | value |
|---|---|
| run_id | `{{run_id}}` |
| sample_id | sample-001-dfd-crop |
| mode | `{{mode}}` |
| output_root | `{{output_root}}` |
| step | RS-05 |
| prompt | prompts/rs/05-boundary-stack-detect.prompt.md |
| skill | skills/rs/SK-BOUNDARY-CROSSING-DETECT.md |
| owning_pra | PRA-05-REVIEW-TABLE-BUILDER |

## Boundary Table

| boundary_id | boundary_label | boundary_type | trust_zone_inside | trust_zone_outside | source_location | confidence | notes |
|---|---|---|---|---|---|---|---|
| BND-01 | Internet boundary | `<value-from-catalogs/boundaries/boundary-type-catalog.yaml#BT-EXTERNAL-CONTEXT>` | `<value-from-catalogs/boundaries/trust-zone-catalog.yaml#TZ-INTERNET>` | `<value-from-catalogs/boundaries/trust-zone-catalog.yaml#TZ-APPLICATION>` | `dfd-crop.png` BND-01 subgraph | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | F1 crosses inward. |
| BND-02 | External AI SaaS boundary | `<value-from-catalogs/boundaries/boundary-type-catalog.yaml#BT-ENTERPRISE-OR-PROVIDER-BOUNDARY>` | `<value-from-catalogs/boundaries/trust-zone-catalog.yaml#TZ-APPLICATION>` | `<value-from-catalogs/boundaries/trust-zone-catalog.yaml#TZ-THIRD-PARTY-SERVICE>` | `dfd-crop.png` BND-02 subgraph | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | F4 / F5 cross. |
| BND-03 | Application zone | `<value-from-catalogs/boundaries/boundary-type-catalog.yaml#BT-TRUST-OR-FUNCTIONAL-ZONE>` | `<value-from-catalogs/boundaries/trust-zone-catalog.yaml#TZ-APPLICATION>` | `<value-from-catalogs/boundaries/trust-zone-catalog.yaml#TZ-INTERNAL-SERVICE>` | `dfd-crop.png` BND-03 subgraph | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Contains CMP-02, CMP-03, CMP-08. |
| BND-04 | Internal data zone | `<value-from-catalogs/boundaries/boundary-type-catalog.yaml#BT-TRUST-OR-FUNCTIONAL-ZONE>` | `<value-from-catalogs/boundaries/trust-zone-catalog.yaml#TZ-DATA>` | `<value-from-catalogs/boundaries/trust-zone-catalog.yaml#TZ-APPLICATION>` | `dfd-crop.png` BND-04 subgraph | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | F3 / F6 / F7 cross. |

## Boundary Crossing Table

| crossing_id | flow_id_referenced | source_boundary | destination_boundary | crossing_rule_applied | confidence | notes |
|---|---|---|---|---|---|---|
| BC-01 | F1 | BND-01 (Internet) | BND-03 (Application) | `catalogs/boundaries/boundary-crossing-rule-catalog.yaml#BC-INTERNET-EXPOSURE` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Internet exposure at the app entry. |
| BC-02 | F4 | BND-03 (Application) | BND-02 (External AI SaaS) | `catalogs/boundaries/boundary-crossing-rule-catalog.yaml#BC-MODEL-ENDPOINT-CROSSING`; `catalogs/boundaries/boundary-crossing-rule-catalog.yaml#BC-INTERNET-EXPOSURE` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Model-endpoint crossing to a third-party SaaS over the internet. |
| BC-03 | F5 | BND-02 (External AI SaaS) | BND-03 (Application) | `catalogs/boundaries/boundary-crossing-rule-catalog.yaml#BC-MODEL-ENDPOINT-CROSSING` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-MEDIUM>` | Inbound response. |
| BC-04 | F3 | BND-03 (Application) | BND-04 (Internal data) | `catalogs/boundaries/boundary-crossing-rule-catalog.yaml#BC-DATA-STORE-CROSSING` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Write to Review Metadata DB. |
| BC-05 | F6 | BND-03 (Application) | BND-04 (Internal data) | `catalogs/boundaries/boundary-crossing-rule-catalog.yaml#BC-DATA-STORE-CROSSING` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Write to Findings Store. |
| BC-06 | F7 | BND-03 (Application) | BND-04 (Internal data) | `catalogs/boundaries/boundary-crossing-rule-catalog.yaml#BC-DATA-STORE-CROSSING` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Read from Policy Reference Store. |
| BC-07 | F8 | BND-03 (Application) | BND-03 (Application — internal tool surface) | `catalogs/boundaries/boundary-crossing-rule-catalog.yaml#BC-TOOL-API-SURFACE-CROSSING` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-MEDIUM>` | F8 stays inside BND-03; recorded as a tool-surface crossing for completeness. |

## Unknowns

| unknown_id | concern | catalog_reference_checked | gap |
|---|---|---|---|
| UNK-09 | F4 / BC-02 | `catalogs/identity-access/authorization-catalog.yaml` | AZ scope at CMP-05 — drives MF-04. |
| UNK-10 | F4 payload class on BC-02 | `catalogs/data-protection/data-class-catalog.yaml` | Drives MF-03. |

## Stop Conditions Recorded

None at this step.
