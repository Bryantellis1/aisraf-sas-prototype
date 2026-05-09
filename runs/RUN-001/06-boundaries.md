# Boundaries — RUN-001
| field | value |
|---|---|
| run_id | `RUN-001` |
| sample_id | sample-001-dfd-crop |
| mode | `folder_first_test` |
| output_root | `runs/RUN-001` |
| step | RS-05 |
| prompt | prompts/rs/05-boundary-stack-detect.prompt.md |
| skill | skills/rs/SK-BOUNDARY-CROSSING-DETECT.md |
| owning_pra | PRA-05-REVIEW-TABLE-BUILDER |

## Boundary Table

| boundary_id | boundary_label | boundary_type | trust_zone_inside | trust_zone_outside | source_location | confidence | notes |
|---|---|---|---|---|---|---|---|
| BND-01 | External User / Internet Zone | `<value-from-catalogs/boundaries/boundary-type-catalog.yaml#BT-EXTERNAL-CONTEXT>` | `<value-from-catalogs/boundaries/trust-zone-catalog.yaml#TZ-INTERNET>` | n/a (root context) | `dfd-crop.png` outermost left subgraph | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | F1 originates here. |
| BND-02 | GCP Project: aisraf-review-dev | `<value-from-catalogs/boundaries/boundary-type-catalog.yaml#BT-ENTERPRISE-OR-PROVIDER-BOUNDARY>` | `<value-from-catalogs/boundaries/trust-zone-catalog.yaml#TZ-APPLICATION>` | `<value-from-catalogs/boundaries/trust-zone-catalog.yaml#TZ-INTERNET>` | `dfd-crop.png` GCP project subgraph | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Outer GCP project boundary; encloses the VPC. |
| BND-03 | VPC: review-platform-vpc | `<value-from-catalogs/boundaries/boundary-type-catalog.yaml#BT-TRUST-OR-FUNCTIONAL-ZONE>` | `<value-from-catalogs/boundaries/trust-zone-catalog.yaml#TZ-APPLICATION>` | `<value-from-catalogs/boundaries/trust-zone-catalog.yaml#TZ-APPLICATION>` | `dfd-crop.png` VPC subgraph | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | VPC boundary; contains BND-04 / BND-05 / BND-06. |
| BND-04 | Edge subnet | `<value-from-catalogs/boundaries/boundary-type-catalog.yaml#BT-TRUST-OR-FUNCTIONAL-ZONE>` | `<value-from-catalogs/boundaries/trust-zone-catalog.yaml#TZ-APPLICATION>` | `<value-from-catalogs/boundaries/trust-zone-catalog.yaml#TZ-INTERNAL-SERVICE>` | `dfd-crop.png` Edge subnet subgraph | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Hosts CMP-09, CMP-10. |
| BND-05 | Application subnet | `<value-from-catalogs/boundaries/boundary-type-catalog.yaml#BT-TRUST-OR-FUNCTIONAL-ZONE>` | `<value-from-catalogs/boundaries/trust-zone-catalog.yaml#TZ-APPLICATION>` | `<value-from-catalogs/boundaries/trust-zone-catalog.yaml#TZ-INTERNAL-SERVICE>` | `dfd-crop.png` Application subnet subgraph | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Hosts CMP-02, CMP-03, CMP-11, CMP-12. |
| BND-06 | Data subnet | `<value-from-catalogs/boundaries/boundary-type-catalog.yaml#BT-TRUST-OR-FUNCTIONAL-ZONE>` | `<value-from-catalogs/boundaries/trust-zone-catalog.yaml#TZ-DATA>` | `<value-from-catalogs/boundaries/trust-zone-catalog.yaml#TZ-APPLICATION>` | `dfd-crop.png` Data subnet subgraph | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Hosts CMP-04, CMP-06, CMP-07, CMP-13, CMP-14. |
| BND-07 | External AI SaaS Provider Zone | `<value-from-catalogs/boundaries/boundary-type-catalog.yaml#BT-ENTERPRISE-OR-PROVIDER-BOUNDARY>` | `<value-from-catalogs/boundaries/trust-zone-catalog.yaml#TZ-THIRD-PARTY-SERVICE>` | `<value-from-catalogs/boundaries/trust-zone-catalog.yaml#TZ-INTERNET>` | `dfd-crop.png` External AI SaaS Provider Zone subgraph | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | F9 / F10 cross. |
| BND-08 | Atlassian Cloud / Jira-Confluence Zone | `<value-from-catalogs/boundaries/boundary-type-catalog.yaml#BT-ENTERPRISE-OR-PROVIDER-BOUNDARY>` | `<value-from-catalogs/boundaries/trust-zone-catalog.yaml#TZ-THIRD-PARTY-SERVICE>` | `<value-from-catalogs/boundaries/trust-zone-catalog.yaml#TZ-INTERNET>` | `dfd-crop.png` Atlassian Cloud subgraph | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | F14 destination. |

## Boundary Crossing Table

| crossing_id | flow_id_referenced | source_boundary | destination_boundary | crossing_rule_applied | confidence | notes |
|---|---|---|---|---|---|---|
| BC-01 | F1 | BND-01 (Internet) | BND-04 (Edge subnet) | `catalogs/boundaries/boundary-crossing-rule-catalog.yaml#BC-INTERNET-EXPOSURE` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Internet exposure at the GCP edge (transitively crosses BND-02 GCP Project and BND-03 VPC). |
| BC-02 | F3 | BND-04 (Edge subnet) | BND-05 (Application subnet) | `catalogs/boundaries/boundary-crossing-rule-catalog.yaml#BC-TOOL-API-SURFACE-CROSSING` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Edge → Application post-WAF forward. |
| BC-03 | F6 | BND-05 (Application subnet) | BND-06 (Data subnet) | `catalogs/boundaries/boundary-crossing-rule-catalog.yaml#BC-DATA-STORE-CROSSING` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Cloud SQL metadata write. |
| BC-04 | F7 | BND-05 (Application subnet) | BND-06 (Data subnet) | `catalogs/boundaries/boundary-crossing-rule-catalog.yaml#BC-DATA-STORE-CROSSING` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Policy reference read. |
| BC-05 | F9 | BND-05 (Application subnet) | BND-07 (External AI SaaS) | `catalogs/boundaries/boundary-crossing-rule-catalog.yaml#BC-MODEL-ENDPOINT-CROSSING`; `catalogs/boundaries/boundary-crossing-rule-catalog.yaml#BC-INTERNET-EXPOSURE` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Cross-internet model call. |
| BC-06 | F10 | BND-07 (External AI SaaS) | BND-05 (Application subnet) | `catalogs/boundaries/boundary-crossing-rule-catalog.yaml#BC-MODEL-ENDPOINT-CROSSING` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-MEDIUM>` | Inbound response. |
| BC-07 | F11 | BND-05 (Application subnet) | BND-06 (Data subnet) | `catalogs/boundaries/boundary-crossing-rule-catalog.yaml#BC-DATA-STORE-CROSSING` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Findings write. |
| BC-08 | F12 | BND-05 (Application subnet) | BND-06 (Data subnet) | `catalogs/boundaries/boundary-crossing-rule-catalog.yaml#BC-DATA-STORE-CROSSING` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Handoff pack write. |
| BC-09 | F13 | BND-05 (Application subnet) | BND-06 (Data subnet) | `catalogs/boundaries/boundary-crossing-rule-catalog.yaml#BC-DATA-STORE-CROSSING` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Audit event write. |
| BC-10 | F14 | BND-05 (Application subnet) | BND-08 (Atlassian Cloud) | `catalogs/boundaries/boundary-crossing-rule-catalog.yaml#BC-TOOL-API-SURFACE-CROSSING`; `catalogs/boundaries/boundary-crossing-rule-catalog.yaml#BC-INTERNET-EXPOSURE` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-MEDIUM>` | `formatted_only` handoff to Atlassian Cloud; not external post-back. |

## Unknowns

| unknown_id | concern | catalog_reference_checked | gap |
|---|---|---|---|
| UNK-09 | F9 / BC-05 | `catalogs/identity-access/authorization-catalog.yaml` | AZ scope at CMP-05 — drives MF-04. |
| UNK-10 | F9 / F10 redaction posture on BC-05 / BC-06 | `catalogs/data-protection/data-class-catalog.yaml` | Drives MF-03. |

## Stop Conditions Recorded

None at this step.

