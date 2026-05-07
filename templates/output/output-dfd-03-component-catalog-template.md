# Template: DFD Component Catalog Output Shape

## 1. Template Metadata

| field | value |
|---|---|
| template_id | TPL-OUT-DFD-03-COMPONENT-CATALOG |
| template_name | DFD Component Catalog Output Shape |
| owning_build_package | Build Package 09 |
| status | active |
| purpose | Define the file-level shape of `{{output_root}}/dfd/03-component-catalog.md`, written by PR-DFD-04 / SK-DFD-03-COMPONENT-EXTRACT / PRA-03. |
| intended_output | `{{output_root}}/dfd/03-component-catalog.md` |
| consumers | Prompts: PR-DFD-04. Skills: SK-DFD-03-COMPONENT-EXTRACT. PRAs: PRA-03-DFD-EXTRACTOR. Adapters: aisraf-dfd-extractor. Catalogs: catalogs/components/component-type-catalog.yaml; component-role-catalog.yaml; component-evidence-rule-catalog.yaml. |
| inputs_expected | `runs/{{run_id}}/run-profile.yaml`; `{{output_root}}/dfd/01-intake-quality-check.md`; `{{output_root}}/dfd/02-boundary-catalog.md`; `{{input_root}}/` |
| placeholders | `{{run_id}}`, `{{input_root}}`, `{{output_root}}`, `{{mode}}`, `{{postback_execution_status}}`, `{{output_destination_mode}}` |
| required_sections | Header; Component Catalog Rows; Unknowns; Stop Conditions Recorded |
| prohibited_content | hidden inference; controlled-value enumeration; severity / score computation; finding or recommendation prose |
| output_boundary | under_resolved_output_root_dfd_subfolder_only |
| source_reference | aisraf-sas-prototype-skill-chain-pack-v0.01/templates/dfd-component-catalog-template.md (rebuilt for v0.1.2) |
| version_notes | Rebuilt for v0.1.2. |

## 2. Output Boundary

This template defines output shape only. Components are classified by visible evidence and the cited catalog rule.

## 3. Allowed Placeholders

Only the seven approved run-profile variables. Other run-profile fields are referenced descriptively.

## 4. File Header

```markdown
# DFD Component Catalog — {{run_id}}

| field | value |
|---|---|
| run_id | {{run_id}} |
| sample_id | [copy from runs/{{run_id}}/run-profile.yaml#sample_id] |
| mode | {{mode}} |
| output_root | {{output_root}} |
| dfd_step | DFD-03 |
| prompt | prompts/dfd/04-component-extract.prompt.md |
| skill | skills/dfd/SK-DFD-03-COMPONENT-EXTRACT.md |
| owning_pra | PRA-03-DFD-EXTRACTOR |
```

## 5. Required Sections

1. **Header**
2. **Component Catalog Rows**:

   | component_id | label | component_type | component_role | parent_boundary_id | source_location | evidence_rule_applied | confidence | notes |
   |---|---|---|---|---|---|---|---|---|

   `component_type` uses `<value-from-catalogs/components/component-type-catalog.yaml>`. `component_role` uses `<value-from-catalogs/components/component-role-catalog.yaml>`. `evidence_rule_applied` references `catalogs/components/component-evidence-rule-catalog.yaml`. `confidence` uses `<value-from-catalogs/data-protection/confidence-level-catalog.yaml>`.

3. **Unknowns**.
4. **Stop Conditions Recorded**.

## 6. Prohibited Content

- Inferring authentication, encryption, or storage behavior. Those belong to RS-05 / DFD-05 / DFD-07.
- Severity, score, or AI Action Level computation.
- Finding or recommendation prose.
- Enumerated catalog values.

## 7. Source Reference

`aisraf-sas-prototype-skill-chain-pack-v0.01/templates/dfd-component-catalog-template.md` (rebuilt).

## 8. Version Notes

Rebuilt for v0.1.2.
