# Visible DFD Objects — RUN-001
| field | value |
|---|---|
| run_id | `RUN-001` |
| sample_id | sample-001-dfd-crop |
| mode | `folder_first_test` |
| input_root | `runs/RUN-001/inputs` |
| output_root | `runs/RUN-001` |
| step | RS-02 |
| prompt | prompts/rs/02-dfd-visual-read.prompt.md |
| skill | skills/rs/SK-DFD-VISUAL-READ.md |
| owning_pra | PRA-03-DFD-EXTRACTOR |

## Visible Object Table

The `label_visible_on_diagram` column records the verbatim visible label as rendered on `dfd-crop.png`. Build Package 10A note: visible labels are real architecture names (no `BND-*`, `CMP-*`, or `F#` extraction IDs as primary visual language); extraction IDs are analyst-assigned and live only in this baseline's downstream rows.

| object_id | label_visible_on_diagram | object_kind_observed | source_location | visible_annotations | confidence | notes |
|---|---|---|---|---|---|---|
| OBJ-01 | Reviewer Browser | `<value-from-catalogs/components/component-type-catalog.yaml#CT-EXTERNAL-ACTOR>` | `dfd-crop.png` (External User / Internet Zone subgraph) | none | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Internal reviewer at a browser; treated as external_actor pre-authentication. |
| OBJ-02 | Cloud Load Balancer | `<value-from-catalogs/components/component-type-catalog.yaml#CT-APPLICATION-SERVICE>` | `dfd-crop.png` (Edge subnet subgraph) | none | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | L7 HTTPS LB at the GCP edge. |
| OBJ-03 | Cloud Armor / WAF ◇ | `<value-from-catalogs/components/component-type-catalog.yaml#CT-GATEWAY-SERVICE>` | `dfd-crop.png` (Edge subnet subgraph) | S1 (security-stack diamond) | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Diamond is a marker, not approved-stack proof (`SR-DIAMOND-NOT-APPROVED-STACK`). |
| OBJ-04 | Review Portal Web App | `<value-from-catalogs/components/component-type-catalog.yaml#CT-APPLICATION-SERVICE>` | `dfd-crop.png` (Application subnet subgraph) | none | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | First-party UI service. |
| OBJ-05 | API Gateway | `<value-from-catalogs/components/component-type-catalog.yaml#CT-GATEWAY-SERVICE>` | `dfd-crop.png` (Application subnet subgraph) | gateway label | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Gateway label is signal only (`SR-GATEWAY-NOT-ENFORCEMENT`). |
| OBJ-06 | Review Orchestrator Service | `<value-from-catalogs/components/component-type-catalog.yaml#CT-APPLICATION-SERVICE>` | `dfd-crop.png` (Application subnet subgraph) | none | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Fans out to data subnet, AI Connector, and Atlassian destination. |
| OBJ-07 | AI Analysis Connector | `<value-from-catalogs/components/component-type-catalog.yaml#CT-APPLICATION-SERVICE>` | `dfd-crop.png` (Application subnet subgraph) | none | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Egress connector to External AI Model Endpoint. |
| OBJ-08 | External AI Model Endpoint | `<value-from-catalogs/components/component-type-catalog.yaml#CT-MODEL-ENDPOINT>` | `dfd-crop.png` (External AI SaaS Provider Zone subgraph) | none | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | External SaaS endpoint. |
| OBJ-09 | Review Metadata Cloud SQL | `<value-from-catalogs/components/component-type-catalog.yaml#CT-DATA-STORE>` | `dfd-crop.png` (Data subnet subgraph) | C4 • R1 • Enc | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Storage tuple visible; KMS / scope unknown (drives MF-02). |
| OBJ-10 | Policy Reference Store | `<value-from-catalogs/components/component-type-catalog.yaml#CT-DATA-STORE>` | `dfd-crop.png` (Data subnet subgraph) | C2 • R1 • Enc | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Storage tuple visible. |
| OBJ-11 | Findings Store | `<value-from-catalogs/components/component-type-catalog.yaml#CT-DATA-STORE>` | `dfd-crop.png` (Data subnet subgraph) | C4 • R1 • Enc | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Storage tuple visible. |
| OBJ-12 | Review Artifact Bucket | `<value-from-catalogs/components/component-type-catalog.yaml#CT-DATA-STORE>` | `dfd-crop.png` (Data subnet subgraph) | C4 • R1 • Enc | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Storage tuple visible. |
| OBJ-13 | Audit Log Store | `<value-from-catalogs/components/component-type-catalog.yaml#CT-DATA-STORE>` | `dfd-crop.png` (Data subnet subgraph) | C4 • R1 • Enc | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Storage tuple visible. |
| OBJ-14 | Jira / Confluence API | `<value-from-catalogs/components/component-type-catalog.yaml#CT-TOOL-OR-API-SURFACE>` | `dfd-crop.png` (Atlassian Cloud / Jira-Confluence Zone subgraph) | formatted_only (semantic) | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | F14 destination; no executed_by_operator claim. |
| OBJ-15 | External User / Internet Zone | `<value-from-catalogs/components/component-type-catalog.yaml#CT-GROUPED-BOUNDARY-BOX>` | `dfd-crop.png` (subgraph) | n/a | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Boundary container around CMP-01. |
| OBJ-16 | GCP Project: aisraf-review-dev | `<value-from-catalogs/components/component-type-catalog.yaml#CT-GROUPED-BOUNDARY-BOX>` | `dfd-crop.png` (subgraph) | n/a | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Outer GCP project boundary; contains the VPC. |
| OBJ-17 | VPC: review-platform-vpc | `<value-from-catalogs/components/component-type-catalog.yaml#CT-GROUPED-BOUNDARY-BOX>` | `dfd-crop.png` (subgraph) | n/a | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | VPC boundary; contains the three subnets. |
| OBJ-18 | Edge subnet | `<value-from-catalogs/components/component-type-catalog.yaml#CT-GROUPED-BOUNDARY-BOX>` | `dfd-crop.png` (subgraph) | n/a | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Boundary container around Cloud LB and Cloud Armor / WAF. |
| OBJ-19 | Application subnet | `<value-from-catalogs/components/component-type-catalog.yaml#CT-GROUPED-BOUNDARY-BOX>` | `dfd-crop.png` (subgraph) | n/a | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Boundary container around Web App, API Gateway, Orchestrator, AI Connector. |
| OBJ-20 | Data subnet | `<value-from-catalogs/components/component-type-catalog.yaml#CT-GROUPED-BOUNDARY-BOX>` | `dfd-crop.png` (subgraph) | n/a | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Boundary container around the five managed data stores. |
| OBJ-21 | External AI SaaS Provider Zone | `<value-from-catalogs/components/component-type-catalog.yaml#CT-GROUPED-BOUNDARY-BOX>` | `dfd-crop.png` (subgraph) | n/a | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Boundary container around External AI Model Endpoint. |
| OBJ-22 | Atlassian Cloud / Jira-Confluence Zone | `<value-from-catalogs/components/component-type-catalog.yaml#CT-GROUPED-BOUNDARY-BOX>` | `dfd-crop.png` (subgraph) | n/a | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Boundary container around Jira / Confluence API. |
| OBJ-23 | Legend — visible markers are review signals, not implementation proof | `<value-from-catalogs/components/component-type-catalog.yaml#CT-GROUPED-BOUNDARY-BOX>` | `dfd-crop.png` (`subgraph LEGEND` panel) | C#, T#, IA#, SA#, CA#, AZ#, AZ?, R#, Enc, ◇/S#, "authentication does not imply authorization" | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Compact embedded legend panel rendered as part of the DFD. Operator-facing on-canvas vocabulary reference; supporting documentation lives in `dfd-legend-excerpt.md`. |

## Unknowns

| unknown_id | object_observed | what_is_unknown | catalog_reference_checked | gap |
|---|---|---|---|---|
| UNK-02 | F9 / F10 | Whether AI Analysis Connector redacts `C4` review-IP before transmission to the External AI Model Endpoint (and whether the inbound response carries C4 review-IP back). | `catalogs/data-protection/data-class-catalog.yaml` | Resolved at RS-04 / RS-06 / RS-07 — drives MF-03. |
| UNK-03 | every flow with `IA#` or `SA#` | Authorization scope (no `AZ#` token visible). | `catalogs/identity-access/authorization-catalog.yaml` | Resolved at RS-07 / RS-09 — drives MF-04. |

## Stop Conditions Recorded

None at this step. The DFD image and Mermaid source are legible; every visible component, boundary, and flow carries a real architecture label.

