---
expected_baseline_id: EXP-DFD-02-BOUNDARY-CATALOG
sample_id: sample-001-dfd-crop
mirrors_template: templates/output/output-dfd-02-boundary-catalog-template.md
prompt: prompts/dfd/03-boundary-extract.prompt.md
skill: skills/dfd/SK-DFD-02-BOUNDARY-EXTRACT.md
owning_pra: PRA-03-DFD-EXTRACTOR
adapter: .agents/aisraf-dfd-extractor.agent.md
target_run_output: "{{output_root}}/dfd/02-boundary-catalog.md"
expected_outcome: PASS_READY_FOR_REVIEW
scoring_basis: template-aligned qualitative baseline; numeric scoring deferred to Build Package 11 run execution
package_version: v0.1.2
---

# DFD Boundary Catalog — sample-001-dfd-crop

| field | value |
|---|---|
| run_id | `{{run_id}}` |
| sample_id | sample-001-dfd-crop |
| mode | `{{mode}}` |
| input_root | `{{input_root}}` |
| output_root | `{{output_root}}` |
| dfd_step | DFD-02 |
| prompt | prompts/dfd/03-boundary-extract.prompt.md |
| skill | skills/dfd/SK-DFD-02-BOUNDARY-EXTRACT.md |
| owning_pra | PRA-03-DFD-EXTRACTOR |

## Boundary Catalog Rows

| boundary_id | label | boundary_type | trust_zone_inside | trust_zone_outside | source_location | confidence | notes |
|---|---|---|---|---|---|---|---|
| BND-01 | Internet boundary | `<value-from-catalogs/boundaries/boundary-type-catalog.yaml#BT-EXTERNAL-CONTEXT>` | `<value-from-catalogs/boundaries/trust-zone-catalog.yaml#TZ-INTERNET>` | `<value-from-catalogs/boundaries/trust-zone-catalog.yaml#TZ-APPLICATION>` | `dfd-crop.png` BND-01 subgraph | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Same boundary appears in `06-boundaries.md`; recorded here as DFD-extraction evidence. |
| BND-02 | External AI SaaS boundary | `<value-from-catalogs/boundaries/boundary-type-catalog.yaml#BT-ENTERPRISE-OR-PROVIDER-BOUNDARY>` | `<value-from-catalogs/boundaries/trust-zone-catalog.yaml#TZ-APPLICATION>` | `<value-from-catalogs/boundaries/trust-zone-catalog.yaml#TZ-THIRD-PARTY-SERVICE>` | `dfd-crop.png` BND-02 subgraph | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Hosts CMP-05. |
| BND-03 | Application zone | `<value-from-catalogs/boundaries/boundary-type-catalog.yaml#BT-TRUST-OR-FUNCTIONAL-ZONE>` | `<value-from-catalogs/boundaries/trust-zone-catalog.yaml#TZ-APPLICATION>` | `<value-from-catalogs/boundaries/trust-zone-catalog.yaml#TZ-INTERNAL-SERVICE>` | `dfd-crop.png` BND-03 subgraph | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Hosts CMP-02, CMP-03, CMP-08. |
| BND-04 | Internal data zone | `<value-from-catalogs/boundaries/boundary-type-catalog.yaml#BT-TRUST-OR-FUNCTIONAL-ZONE>` | `<value-from-catalogs/boundaries/trust-zone-catalog.yaml#TZ-DATA>` | `<value-from-catalogs/boundaries/trust-zone-catalog.yaml#TZ-APPLICATION>` | `dfd-crop.png` BND-04 subgraph | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Hosts CMP-04, CMP-06, CMP-07. |

## Unknowns

None at this step. Every boundary container in `dfd-crop.png` is named and resolves to a controlled value.

## Stop Conditions Recorded

None at this step.
