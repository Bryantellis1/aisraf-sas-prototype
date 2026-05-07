---
expected_baseline_id: EXP-RS-02-VISIBLE-DFD-OBJECTS
sample_id: sample-001-dfd-crop
mirrors_template: templates/output/output-02-visible-dfd-objects-template.md
prompt: prompts/rs/02-dfd-visual-read.prompt.md
skill: skills/rs/SK-DFD-VISUAL-READ.md
owning_pra: PRA-03-DFD-EXTRACTOR
adapter: .agents/aisraf-dfd-extractor.agent.md
target_run_output: "{{output_root}}/02-visible-dfd-objects.md"
expected_outcome: PASS_READY_FOR_REVIEW
scoring_basis: template-aligned qualitative baseline; numeric scoring deferred to Build Package 11 run execution
package_version: v0.1.2
---

# Visible DFD Objects — sample-001-dfd-crop

| field | value |
|---|---|
| run_id | `{{run_id}}` |
| sample_id | sample-001-dfd-crop |
| mode | `{{mode}}` |
| input_root | `{{input_root}}` |
| output_root | `{{output_root}}` |
| step | RS-02 |
| prompt | prompts/rs/02-dfd-visual-read.prompt.md |
| skill | skills/rs/SK-DFD-VISUAL-READ.md |
| owning_pra | PRA-03-DFD-EXTRACTOR |

## Visible Object Table

| object_id | label_visible_on_diagram | object_kind_observed | source_location | visible_annotations | confidence | notes |
|---|---|---|---|---|---|---|
| OBJ-01 | CMP-01 Reviewer Browser | `<value-from-catalogs/components/component-type-catalog.yaml#CT-EXTERNAL-ACTOR>` | `dfd-crop.png` (BND-01 box) | IA1 | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | External-actor classification for an internal reviewer is intentional — outside the application trust boundary until authenticated. |
| OBJ-02 | CMP-02 Review Portal Web App | `<value-from-catalogs/components/component-type-catalog.yaml#CT-APPLICATION-SERVICE>` | `dfd-crop.png` (BND-03 box) | none | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | First-party UI service. |
| OBJ-03 | CMP-03 Review API Gateway | `<value-from-catalogs/components/component-type-catalog.yaml#CT-GATEWAY-SERVICE>` | `dfd-crop.png` (BND-03 box) | S1 (security-stack diamond) | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Diamond is a marker, not approved-stack proof (rule SR-DIAMOND-NOT-APPROVED-STACK). |
| OBJ-04 | CMP-04 Review Metadata DB | `<value-from-catalogs/components/component-type-catalog.yaml#CT-DATA-STORE>` | `dfd-crop.png` (BND-04 box) | C4P; E1 marker | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Component-level marker is a component signal only (CER-COMPONENT-MARKER-IS-COMPONENT-SCOPE). |
| OBJ-05 | CMP-05 AI Analysis Service | `<value-from-catalogs/components/component-type-catalog.yaml#CT-MODEL-ENDPOINT>` | `dfd-crop.png` (BND-02 box) | SA1 | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | External SaaS endpoint per `cloud-triage-notes.md` § 4. |
| OBJ-06 | CMP-06 Policy Reference Store | `<value-from-catalogs/components/component-type-catalog.yaml#CT-DATA-STORE>` | `dfd-crop.png` (BND-04 box) | C2 | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Internal policy reference data. |
| OBJ-07 | CMP-07 Findings Store | `<value-from-catalogs/components/component-type-catalog.yaml#CT-DATA-STORE>` | `dfd-crop.png` (BND-04 box) | C4 | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Internal finding records. |
| OBJ-08 | CMP-08 Jira/Confluence Draft Formatter | `<value-from-catalogs/components/component-type-catalog.yaml#CT-TOOL-OR-API-SURFACE>` | `dfd-crop.png` (BND-03 box) | formatted_only | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | F8 produces draft text only; no executed_by_operator claim. |
| OBJ-09 | BND-01 Internet boundary | `<value-from-catalogs/components/component-type-catalog.yaml#CT-GROUPED-BOUNDARY-BOX>` | `dfd-crop.png` (subgraph) | n/a | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Boundary container around CMP-01. |
| OBJ-10 | BND-02 External AI SaaS boundary | `<value-from-catalogs/components/component-type-catalog.yaml#CT-GROUPED-BOUNDARY-BOX>` | `dfd-crop.png` (subgraph) | n/a | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Boundary container around CMP-05. |
| OBJ-11 | BND-03 Application zone | `<value-from-catalogs/components/component-type-catalog.yaml#CT-GROUPED-BOUNDARY-BOX>` | `dfd-crop.png` (subgraph) | n/a | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Boundary container around CMP-02, CMP-03, CMP-08. |
| OBJ-12 | BND-04 Internal data zone | `<value-from-catalogs/components/component-type-catalog.yaml#CT-GROUPED-BOUNDARY-BOX>` | `dfd-crop.png` (subgraph) | n/a | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Boundary container around CMP-04, CMP-06, CMP-07. |

## Unknowns

| unknown_id | object_observed | what_is_unknown | catalog_reference_checked | gap |
|---|---|---|---|---|
| UNK-02 | None at this step | Per-flow data class on F4 / F5 (model call request body and response payload). | `catalogs/data-protection/data-class-catalog.yaml` | Resolved at RS-04 / RS-06 / RS-07 — not at the visible-object step. |

## Stop Conditions Recorded

None at this step. The DFD image and Mermaid source are legible; every visible component carries a label.
