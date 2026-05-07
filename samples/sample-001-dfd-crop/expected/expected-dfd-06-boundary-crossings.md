---
expected_baseline_id: EXP-DFD-06-BOUNDARY-CROSSINGS
sample_id: sample-001-dfd-crop
mirrors_template: templates/output/output-dfd-06-boundary-crossings-template.md
prompt: prompts/dfd/07-boundary-crossing-detect.prompt.md
skill: skills/dfd/SK-DFD-06-BOUNDARY-CROSSING-DETECT.md
owning_pra: PRA-03-DFD-EXTRACTOR
adapter: .agents/aisraf-dfd-extractor.agent.md
target_run_output: "{{output_root}}/dfd/06-boundary-crossings.md"
expected_outcome: PASS_READY_FOR_REVIEW
scoring_basis: template-aligned qualitative baseline; numeric scoring deferred to Build Package 11 run execution
package_version: v0.1.2
---

# DFD Boundary Crossings — sample-001-dfd-crop

| field | value |
|---|---|
| run_id | `{{run_id}}` |
| sample_id | sample-001-dfd-crop |
| mode | `{{mode}}` |
| output_root | `{{output_root}}` |
| dfd_step | DFD-06 |
| prompt | prompts/dfd/07-boundary-crossing-detect.prompt.md |
| skill | skills/dfd/SK-DFD-06-BOUNDARY-CROSSING-DETECT.md |
| owning_pra | PRA-03-DFD-EXTRACTOR |

## Boundary Crossing Rows

| crossing_id | flow_id_referenced | source_boundary_id | destination_boundary_id | crossing_rule_applied | confidence | notes |
|---|---|---|---|---|---|---|
| BC-01 | F1 | BND-01 | BND-03 | `catalogs/boundaries/boundary-crossing-rule-catalog.yaml#BC-INTERNET-EXPOSURE` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Internet → application. |
| BC-02 | F4 | BND-03 | BND-02 | `catalogs/boundaries/boundary-crossing-rule-catalog.yaml#BC-MODEL-ENDPOINT-CROSSING`; `catalogs/boundaries/boundary-crossing-rule-catalog.yaml#BC-INTERNET-EXPOSURE` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Outbound to external SaaS. |
| BC-03 | F5 | BND-02 | BND-03 | `catalogs/boundaries/boundary-crossing-rule-catalog.yaml#BC-MODEL-ENDPOINT-CROSSING` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-MEDIUM>` | Inbound response. |
| BC-04 | F3 | BND-03 | BND-04 | `catalogs/boundaries/boundary-crossing-rule-catalog.yaml#BC-DATA-STORE-CROSSING` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Write to CMP-04. |
| BC-05 | F6 | BND-03 | BND-04 | `catalogs/boundaries/boundary-crossing-rule-catalog.yaml#BC-DATA-STORE-CROSSING` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Write to CMP-07. |
| BC-06 | F7 | BND-03 | BND-04 | `catalogs/boundaries/boundary-crossing-rule-catalog.yaml#BC-DATA-STORE-CROSSING` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Read from CMP-06. |
| BC-07 | F8 | BND-03 | BND-03 | `catalogs/boundaries/boundary-crossing-rule-catalog.yaml#BC-TOOL-API-SURFACE-CROSSING` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-MEDIUM>` | Internal tool surface. |

## Unknowns

None at this step. F2 stays inside BND-03 and is not a boundary crossing.

## Stop Conditions Recorded

None at this step.
