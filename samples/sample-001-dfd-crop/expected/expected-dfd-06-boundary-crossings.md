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

Each row records the most-specific source-and-destination boundary pair on the DFD. Where a flow visibly traverses nested zones (e.g., `External User / Internet Zone` → `GCP Project` → `VPC` → `Edge subnet`), the outer zones are recorded for context but the canonical crossing is between the most-specific source and destination zones.

| crossing_id | flow_id_referenced | source_boundary_id | destination_boundary_id | crossing_rule_applied | confidence | notes |
|---|---|---|---|---|---|---|
| BC-01 | F1 | BND-01 | BND-04 | `catalogs/boundaries/boundary-crossing-rule-catalog.yaml#BC-INTERNET-EXPOSURE` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Internet → GCP Edge subnet (transitively crosses BND-02 GCP Project and BND-03 VPC). |
| BC-02 | F3 | BND-04 | BND-05 | `catalogs/boundaries/boundary-crossing-rule-catalog.yaml#BC-TOOL-API-SURFACE-CROSSING` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Edge subnet → Application subnet (post-WAF forward). |
| BC-03 | F6 | BND-05 | BND-06 | `catalogs/boundaries/boundary-crossing-rule-catalog.yaml#BC-DATA-STORE-CROSSING` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Application → Data subnet — Cloud SQL metadata write. |
| BC-04 | F7 | BND-05 | BND-06 | `catalogs/boundaries/boundary-crossing-rule-catalog.yaml#BC-DATA-STORE-CROSSING` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Application → Data subnet — Policy reference read. |
| BC-05 | F9 | BND-05 | BND-07 | `catalogs/boundaries/boundary-crossing-rule-catalog.yaml#BC-MODEL-ENDPOINT-CROSSING`; `catalogs/boundaries/boundary-crossing-rule-catalog.yaml#BC-INTERNET-EXPOSURE` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Application subnet → External AI SaaS Provider Zone (cross-internet). |
| BC-06 | F10 | BND-07 | BND-05 | `catalogs/boundaries/boundary-crossing-rule-catalog.yaml#BC-MODEL-ENDPOINT-CROSSING` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-MEDIUM>` | Inbound model response. |
| BC-07 | F11 | BND-05 | BND-06 | `catalogs/boundaries/boundary-crossing-rule-catalog.yaml#BC-DATA-STORE-CROSSING` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Application → Data subnet — Findings write. |
| BC-08 | F12 | BND-05 | BND-06 | `catalogs/boundaries/boundary-crossing-rule-catalog.yaml#BC-DATA-STORE-CROSSING` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Application → Data subnet — Handoff pack write. |
| BC-09 | F13 | BND-05 | BND-06 | `catalogs/boundaries/boundary-crossing-rule-catalog.yaml#BC-DATA-STORE-CROSSING` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Application → Data subnet — Audit event write. |
| BC-10 | F14 | BND-05 | BND-08 | `catalogs/boundaries/boundary-crossing-rule-catalog.yaml#BC-TOOL-API-SURFACE-CROSSING`; `catalogs/boundaries/boundary-crossing-rule-catalog.yaml#BC-INTERNET-EXPOSURE` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-MEDIUM>` | Application subnet → Atlassian Cloud (formatted_only handoff; not external post-back). |

## Unknowns

None at this step. F2 (Cloud LB → Cloud Armor / WAF), F4 (Web App → API Gateway), F5 (API Gateway → Orchestrator), and F8 (Orchestrator → AI Connector) stay inside a single boundary and are not boundary crossings.

## Stop Conditions Recorded

None at this step.
