# Template: DFD Boundary Catalog Output Shape

## 1. Template Metadata

| field | value |
|---|---|
| template_id | TPL-OUT-DFD-02-BOUNDARY-CATALOG |
| template_name | DFD Boundary Catalog Output Shape |
| owning_build_package | Build Package 09 |
| status | active |
| purpose | Define the file-level shape of `{{output_root}}/dfd/02-boundary-catalog.md`, written by PR-DFD-03 / SK-DFD-02-BOUNDARY-EXTRACT / PRA-03. |
| intended_output | `{{output_root}}/dfd/02-boundary-catalog.md` |
| consumers | Prompts: PR-DFD-03. Skills: SK-DFD-02-BOUNDARY-EXTRACT. PRAs: PRA-03-DFD-EXTRACTOR. Adapters: aisraf-dfd-extractor. Catalogs: catalogs/boundaries/boundary-type-catalog.yaml; trust-zone-catalog.yaml. |
| inputs_expected | `runs/{{run_id}}/run-profile.yaml`; `{{output_root}}/dfd/01-intake-quality-check.md`; `{{input_root}}/` |
| placeholders | `{{run_id}}`, `{{input_root}}`, `{{output_root}}`, `{{mode}}`, `{{postback_execution_status}}`, `{{output_destination_mode}}` |
| required_sections | Header; Boundary Catalog Rows; Unknowns; Stop Conditions Recorded |
| prohibited_content | hidden inference; controlled-value enumeration; severity / score computation; finding or recommendation prose |
| output_boundary | under_resolved_output_root_dfd_subfolder_only |
| source_reference | aisraf-sas-prototype-skill-chain-pack-v0.01/templates/dfd-boundary-catalog-template.md (rebuilt for v0.1.2) |
| version_notes | Rebuilt for v0.1.2. |

## 2. Output Boundary

This template defines output shape only. It records boundaries visible in the DFD with the catalog values that classify them; it does not infer trust-zone behavior beyond visible labeling.

## 3. Allowed Placeholders

Only the seven approved run-profile variables. Other run-profile fields are referenced descriptively.

## 4. File Header

```markdown
# DFD Boundary Catalog — {{run_id}}

| field | value |
|---|---|
| run_id | {{run_id}} |
| sample_id | [copy from runs/{{run_id}}/run-profile.yaml#sample_id] |
| mode | {{mode}} |
| input_root | {{input_root}} |
| output_root | {{output_root}} |
| dfd_step | DFD-02 |
| prompt | prompts/dfd/03-boundary-extract.prompt.md |
| skill | skills/dfd/SK-DFD-02-BOUNDARY-EXTRACT.md |
| owning_pra | PRA-03-DFD-EXTRACTOR |
```

## 5. Required Sections

1. **Header**
2. **Boundary Catalog Rows**:

   | boundary_id | label | boundary_type | trust_zone_inside | trust_zone_outside | source_location | confidence | notes |
   |---|---|---|---|---|---|---|---|

   `boundary_type` uses `<value-from-catalogs/boundaries/boundary-type-catalog.yaml>`. Trust zones use `<value-from-catalogs/boundaries/trust-zone-catalog.yaml>`. `confidence` uses `<value-from-catalogs/data-protection/confidence-level-catalog.yaml>`.

3. **Unknowns**.
4. **Stop Conditions Recorded**.

## 6. Prohibited Content

- Inferring crossing behavior or controls. Crossings live in `06-boundary-crossings.md`.
- Severity, score, or AI Action Level computation.
- Finding or recommendation prose.
- Enumerated catalog values.

## 7. Source Reference

`aisraf-sas-prototype-skill-chain-pack-v0.01/templates/dfd-boundary-catalog-template.md` (rebuilt).

## 8. Version Notes

Rebuilt for v0.1.2.
