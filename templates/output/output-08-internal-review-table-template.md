# Template: Internal Review Table Output Shape

## 1. Template Metadata

| field | value |
|---|---|
| template_id | TPL-OUT-08-INTERNAL-REVIEW-TABLE |
| template_name | Internal Review Table Output Shape |
| owning_build_package | Build Package 09 |
| status | active |
| purpose | Define the file-level shape of `{{output_root}}/08-internal-review-table.md`, written by PR-RS-06 / SK-DATA-FLOW-TABLE-BUILD / PRA-05. |
| intended_output | `{{output_root}}/08-internal-review-table.md` |
| consumers | Prompts: PR-RS-06. Skills: SK-DATA-FLOW-TABLE-BUILD. PRAs: PRA-05-REVIEW-TABLE-BUILDER. Adapters: aisraf-review-table-builder. Catalogs: catalogs/components/component-type-catalog.yaml; catalogs/interactions/interaction-type-catalog.yaml; catalogs/boundaries/boundary-type-catalog.yaml; catalogs/security-stacks/security-stack-marker-catalog.yaml; catalogs/data-protection/data-class-catalog.yaml; catalogs/data-protection/confidence-level-catalog.yaml. |
| inputs_expected | `runs/{{run_id}}/run-profile.yaml`; `{{output_root}}/04-components.md`; `{{output_root}}/05-flows.md`; `{{output_root}}/06-boundaries.md`; `{{output_root}}/07-security-stack-assessment.md` |
| placeholders | `{{run_id}}`, `{{input_root}}`, `{{output_root}}`, `{{mode}}`, `{{postback_execution_status}}`, `{{output_destination_mode}}` |
| required_sections | Header; Review Table Rows; Unknowns; Stop Conditions Recorded |
| prohibited_content | hidden inference; controlled-value enumeration; severity / score computation; finding or recommendation prose |
| output_boundary | under_resolved_output_root_only |
| source_reference | aisraf-sas-prototype-skill-chain-pack-v0.01/templates/internal-data-flow-review-table-template.md (rebuilt; v0.01 was a stub) |
| version_notes | Rebuilt for v0.1.2. |

## 2. Output Boundary

This template defines output shape only. It assembles supported facts from RS-04, RS-05, and RS-05's security-stack output into a single review table; it does not classify findings or compute scoring.

## 3. Allowed Placeholders

Only the seven approved run-profile variables. Other run-profile fields are referenced descriptively.

## 4. File Header

```markdown
# Internal Review Table — {{run_id}}

| field | value |
|---|---|
| run_id | {{run_id}} |
| sample_id | [copy from runs/{{run_id}}/run-profile.yaml#sample_id] |
| mode | {{mode}} |
| output_root | {{output_root}} |
| step | RS-06 |
| prompt | prompts/rs/06-review-table-build.prompt.md |
| skill | skills/rs/SK-DATA-FLOW-TABLE-BUILD.md |
| owning_pra | PRA-05-REVIEW-TABLE-BUILDER |
```

## 5. Required Sections

1. **Header**
2. **Review Table Rows** — one row per flow-with-context entry:

   | row_id | flow_id_referenced | source_component_role | destination_component_role | interaction_type | crossing_id_referenced | data_class | transport_protection_marker | identity_marker | confidence | source_facts | notes |
   |---|---|---|---|---|---|---|---|---|---|---|---|

   - `source_component_role` and `destination_component_role` use `<value-from-catalogs/components/component-role-catalog.yaml>`.
   - `interaction_type` uses `<value-from-catalogs/interactions/interaction-type-catalog.yaml>`.
   - `data_class` uses `<value-from-catalogs/data-protection/data-class-catalog.yaml>`.
   - `transport_protection_marker` and `identity_marker` reference `07-security-stack-assessment.md` rows; populate `<value-from-catalogs/...>` placeholders accordingly.
   - `confidence` uses `<value-from-catalogs/data-protection/confidence-level-catalog.yaml>`.
   - `source_facts` records the artifact paths and row IDs that supported each cell.

3. **Unknowns** — rows with one or more unresolved fields; reference the catalog and the gap.
4. **Stop Conditions Recorded**.

## 6. Prohibited Content

- Inventing flows, components, or boundaries not present in the prior outputs.
- Severity, score, or AI Action Level computation.
- Finding or recommendation prose.
- Enumerated catalog values.

## 7. Source Reference

`aisraf-sas-prototype-skill-chain-pack-v0.01/templates/internal-data-flow-review-table-template.md` (rebuilt; v0.01 was a stub).

## 8. Version Notes

Rebuilt for v0.1.2.
