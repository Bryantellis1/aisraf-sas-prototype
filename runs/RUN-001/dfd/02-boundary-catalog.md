# DFD Boundary Catalog — RUN-001
| field | value |
|---|---|
| run_id | `RUN-001` |
| sample_id | sample-001-dfd-crop |
| mode | `folder_first_test` |
| input_root | `runs/RUN-001/inputs` |
| output_root | `runs/RUN-001` |
| dfd_step | DFD-02 |
| prompt | prompts/dfd/03-boundary-extract.prompt.md |
| skill | skills/dfd/SK-DFD-02-BOUNDARY-EXTRACT.md |
| owning_pra | PRA-03-DFD-EXTRACTOR |

## Boundary Catalog Rows

| boundary_id | label | boundary_type | trust_zone_inside | trust_zone_outside | source_location | confidence | notes |
|---|---|---|---|---|---|---|---|
| BND-01 | External User / Internet Zone | `<value-from-catalogs/boundaries/boundary-type-catalog.yaml#BT-EXTERNAL-CONTEXT>` | `<value-from-catalogs/boundaries/trust-zone-catalog.yaml#TZ-INTERNET>` | n/a (root context) | `dfd-crop.png` outermost left subgraph | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Hosts Reviewer Browser (CMP-01). |
| BND-02 | GCP Project: aisraf-review-dev | `<value-from-catalogs/boundaries/boundary-type-catalog.yaml#BT-ENTERPRISE-OR-PROVIDER-BOUNDARY>` | `<value-from-catalogs/boundaries/trust-zone-catalog.yaml#TZ-APPLICATION>` | `<value-from-catalogs/boundaries/trust-zone-catalog.yaml#TZ-INTERNET>` | `dfd-crop.png` GCP project subgraph | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Outer GCP project boundary; contains BND-03 (VPC). |
| BND-03 | VPC: review-platform-vpc | `<value-from-catalogs/boundaries/boundary-type-catalog.yaml#BT-TRUST-OR-FUNCTIONAL-ZONE>` | `<value-from-catalogs/boundaries/trust-zone-catalog.yaml#TZ-APPLICATION>` | `<value-from-catalogs/boundaries/trust-zone-catalog.yaml#TZ-APPLICATION>` | `dfd-crop.png` VPC subgraph (inside GCP project) | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Contains BND-04 / BND-05 / BND-06 subnets. |
| BND-04 | Edge subnet | `<value-from-catalogs/boundaries/boundary-type-catalog.yaml#BT-TRUST-OR-FUNCTIONAL-ZONE>` | `<value-from-catalogs/boundaries/trust-zone-catalog.yaml#TZ-APPLICATION>` | `<value-from-catalogs/boundaries/trust-zone-catalog.yaml#TZ-INTERNAL-SERVICE>` | `dfd-crop.png` Edge subnet subgraph | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Hosts Cloud Load Balancer (CMP-09) and Cloud Armor / WAF (CMP-10). |
| BND-05 | Application subnet | `<value-from-catalogs/boundaries/boundary-type-catalog.yaml#BT-TRUST-OR-FUNCTIONAL-ZONE>` | `<value-from-catalogs/boundaries/trust-zone-catalog.yaml#TZ-APPLICATION>` | `<value-from-catalogs/boundaries/trust-zone-catalog.yaml#TZ-INTERNAL-SERVICE>` | `dfd-crop.png` Application subnet subgraph | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Hosts Review Portal Web App (CMP-02), API Gateway (CMP-03), Review Orchestrator Service (CMP-11), AI Analysis Connector (CMP-12). |
| BND-06 | Data subnet | `<value-from-catalogs/boundaries/boundary-type-catalog.yaml#BT-TRUST-OR-FUNCTIONAL-ZONE>` | `<value-from-catalogs/boundaries/trust-zone-catalog.yaml#TZ-DATA>` | `<value-from-catalogs/boundaries/trust-zone-catalog.yaml#TZ-APPLICATION>` | `dfd-crop.png` Data subnet subgraph | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Hosts Review Metadata Cloud SQL (CMP-04), Policy Reference Store (CMP-06), Findings Store (CMP-07), Review Artifact Bucket (CMP-13), Audit Log Store (CMP-14). |
| BND-07 | External AI SaaS Provider Zone | `<value-from-catalogs/boundaries/boundary-type-catalog.yaml#BT-ENTERPRISE-OR-PROVIDER-BOUNDARY>` | `<value-from-catalogs/boundaries/trust-zone-catalog.yaml#TZ-THIRD-PARTY-SERVICE>` | `<value-from-catalogs/boundaries/trust-zone-catalog.yaml#TZ-INTERNET>` | `dfd-crop.png` External AI SaaS Provider Zone subgraph | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Hosts External AI Model Endpoint (CMP-05). |
| BND-08 | Atlassian Cloud / Jira-Confluence Zone | `<value-from-catalogs/boundaries/boundary-type-catalog.yaml#BT-ENTERPRISE-OR-PROVIDER-BOUNDARY>` | `<value-from-catalogs/boundaries/trust-zone-catalog.yaml#TZ-THIRD-PARTY-SERVICE>` | `<value-from-catalogs/boundaries/trust-zone-catalog.yaml#TZ-INTERNET>` | `dfd-crop.png` Atlassian Cloud subgraph | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Hosts Jira / Confluence API (CMP-08); F14 destination. |

## Unknowns

None at this step. Every boundary container in `dfd-crop.png` is named with a real architecture concept and resolves to a controlled value.

## Stop Conditions Recorded

None at this step.

