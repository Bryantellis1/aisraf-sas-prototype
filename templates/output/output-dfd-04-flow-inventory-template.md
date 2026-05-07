# Template: DFD Flow Inventory Output Shape

## 1. Template Metadata

| field | value |
|---|---|
| template_id | TPL-OUT-DFD-04-FLOW-INVENTORY |
| template_name | DFD Flow Inventory Output Shape |
| owning_build_package | Build Package 09 |
| status | active |
| purpose | Define the file-level shape of `{{output_root}}/dfd/04-flow-inventory.md`, written by PR-DFD-05 / SK-DFD-04-FLOW-EXTRACT / PRA-03. |
| intended_output | `{{output_root}}/dfd/04-flow-inventory.md` |
| consumers | Prompts: PR-DFD-05. Skills: SK-DFD-04-FLOW-EXTRACT. PRAs: PRA-03-DFD-EXTRACTOR. Adapters: aisraf-dfd-extractor. Catalogs: catalogs/interactions/interaction-type-catalog.yaml; flow-direction-catalog.yaml; flow-evidence-rule-catalog.yaml. |
| inputs_expected | `runs/{{run_id}}/run-profile.yaml`; `{{output_root}}/dfd/01-intake-quality-check.md`; `{{output_root}}/dfd/02-boundary-catalog.md`; `{{output_root}}/dfd/03-component-catalog.md`; `{{input_root}}/` |
| placeholders | `{{run_id}}`, `{{input_root}}`, `{{output_root}}`, `{{mode}}`, `{{postback_execution_status}}`, `{{output_destination_mode}}` |
| required_sections | Header; Raw Flow Inventory; Normalized Flow Table; Unknowns; Stop Conditions Recorded |
| prohibited_content | hidden inference; controlled-value enumeration; severity / score computation; finding or recommendation prose |
| output_boundary | under_resolved_output_root_dfd_subfolder_only |
| source_reference | aisraf-sas-prototype-skill-chain-pack-v0.01/templates/dfd-raw-flow-inventory-template.md plus dfd-normalized-flow-table-template.md (collapsed and rebuilt) |
| version_notes | Rebuilt for v0.1.2; v0.01 had two separate raw/normalized templates — collapsed into one file with two sections. |

## 2. Output Boundary

This template defines output shape only. Raw flows record what is visible on the diagram; normalized flows apply the catalog vocabulary using the cited evidence rule. No inference beyond visible labels.

## 3. Allowed Placeholders

Only the seven approved run-profile variables. Other run-profile fields are referenced descriptively.

## 4. File Header

```markdown
# DFD Flow Inventory — {{run_id}}

| field | value |
|---|---|
| run_id | {{run_id}} |
| sample_id | [copy from runs/{{run_id}}/run-profile.yaml#sample_id] |
| mode | {{mode}} |
| output_root | {{output_root}} |
| dfd_step | DFD-04 |
| prompt | prompts/dfd/05-flow-extract.prompt.md |
| skill | skills/dfd/SK-DFD-04-FLOW-EXTRACT.md |
| owning_pra | PRA-03-DFD-EXTRACTOR |
```

## 5. Required Sections

1. **Header**
2. **Raw Flow Inventory** — what is visible:

   | raw_flow_id | source_label | destination_label | visible_payload | source_location | notes |
   |---|---|---|---|---|---|

3. **Normalized Flow Table** — catalog-mapped:

   | flow_id | raw_flow_id_referenced | source_component_id | destination_component_id | interaction_type | flow_direction | evidence_rule_applied | confidence | notes |
   |---|---|---|---|---|---|---|---|---|

   `interaction_type` uses `<value-from-catalogs/interactions/interaction-type-catalog.yaml>`. `flow_direction` uses `<value-from-catalogs/interactions/flow-direction-catalog.yaml>`. `evidence_rule_applied` references `catalogs/interactions/flow-evidence-rule-catalog.yaml`. `confidence` uses `<value-from-catalogs/data-protection/confidence-level-catalog.yaml>`.

4. **Unknowns**.
5. **Stop Conditions Recorded**.

## 6. Prohibited Content

- Inferring transport encryption or authentication. Those live in DFD-05 / DFD-07.
- Severity, score, or AI Action Level computation.
- Finding or recommendation prose.
- Enumerated catalog values.

## 7. Source Reference

`aisraf-sas-prototype-skill-chain-pack-v0.01/templates/dfd-raw-flow-inventory-template.md` and `dfd-normalized-flow-table-template.md` (collapsed and rebuilt).

## 8. Version Notes

Rebuilt for v0.1.2.
