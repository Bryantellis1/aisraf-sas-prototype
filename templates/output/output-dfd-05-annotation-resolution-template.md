# Template: DFD Annotation Resolution Output Shape

## 1. Template Metadata

| field | value |
|---|---|
| template_id | TPL-OUT-DFD-05-ANNOTATION-RESOLUTION |
| template_name | DFD Annotation Resolution Output Shape |
| owning_build_package | Build Package 09 |
| status | active |
| purpose | Define the file-level shape of `{{output_root}}/dfd/05-annotation-resolution.md`, written by PR-DFD-06 / SK-DFD-05-ANNOTATION-RESOLVE / PRA-03. |
| intended_output | `{{output_root}}/dfd/05-annotation-resolution.md` |
| consumers | Prompts: PR-DFD-06. Skills: SK-DFD-05-ANNOTATION-RESOLVE. PRAs: PRA-03-DFD-EXTRACTOR. Adapters: aisraf-dfd-extractor. Catalogs: catalogs/data-protection/data-class-catalog.yaml; transport-protection-catalog.yaml; at-rest-protection-catalog.yaml; catalogs/identity-access/authentication-catalog.yaml; authorization-catalog.yaml. |
| inputs_expected | `runs/{{run_id}}/run-profile.yaml`; `{{output_root}}/dfd/02-boundary-catalog.md`; `{{output_root}}/dfd/03-component-catalog.md`; `{{output_root}}/dfd/04-flow-inventory.md`; `{{input_root}}/` |
| placeholders | `{{run_id}}`, `{{input_root}}`, `{{output_root}}`, `{{mode}}`, `{{postback_execution_status}}`, `{{output_destination_mode}}` |
| required_sections | Header; Resolved Annotations; Unresolved Annotations; Stop Conditions Recorded |
| prohibited_content | hidden inference; controlled-value enumeration; severity / score computation; finding or recommendation prose |
| output_boundary | under_resolved_output_root_dfd_subfolder_only |
| source_reference | New for v0.1.2 |
| version_notes | New for v0.1.2. |

## 2. Output Boundary

This template defines output shape only. It resolves visible annotations (legend abbreviations, marker labels, payload tags) to controlled-vocabulary values without inferring controls that are not visibly annotated.

## 3. Allowed Placeholders

Only the seven approved run-profile variables. Other run-profile fields are referenced descriptively.

## 4. File Header

```markdown
# DFD Annotation Resolution — {{run_id}}

| field | value |
|---|---|
| run_id | {{run_id}} |
| sample_id | [copy from runs/{{run_id}}/run-profile.yaml#sample_id] |
| mode | {{mode}} |
| output_root | {{output_root}} |
| dfd_step | DFD-05 |
| prompt | prompts/dfd/06-annotation-resolve.prompt.md |
| skill | skills/dfd/SK-DFD-05-ANNOTATION-RESOLVE.md |
| owning_pra | PRA-03-DFD-EXTRACTOR |
```

## 5. Required Sections

1. **Header**
2. **Resolved Annotations**:

   | annotation_id | annotation_visible | resolved_to_catalog_value | resolution_basis | source_location | confidence | notes |
   |---|---|---|---|---|---|---|

   `resolved_to_catalog_value` records `<value-from-catalogs/...>` with the explicit catalog file path used. `resolution_basis` cites the catalog entry id or evidence rule.

3. **Unresolved Annotations** — annotations that could not be mapped to a controlled value; record the catalog checked and the gap.
4. **Stop Conditions Recorded**.

## 6. Prohibited Content

- Inferring annotations that are not visibly present.
- Severity, score, or AI Action Level computation.
- Finding or recommendation prose.
- Enumerated catalog values.

## 7. Source Reference

New for v0.1.2.

## 8. Version Notes

New for v0.1.2.
