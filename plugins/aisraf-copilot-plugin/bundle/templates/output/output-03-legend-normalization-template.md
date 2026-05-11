# Template: Legend Normalization Output Shape

## 1. Template Metadata

| field | value |
|---|---|
| template_id | TPL-OUT-03-LEGEND-NORMALIZATION |
| template_name | Legend Normalization Output Shape |
| owning_build_package | Build Package 09 |
| status | active |
| purpose | Define the file-level shape of `{{output_root}}/03-legend-normalization.md`, written by PR-RS-03 / SK-LEGEND-NORMALIZE / PRA-04. |
| intended_output | `{{output_root}}/03-legend-normalization.md` |
| consumers | Prompts: PR-RS-03. Skills: SK-LEGEND-NORMALIZE. PRAs: PRA-04-LEGEND-NORMALIZER. Adapters: aisraf-dfd-extractor (joint with PRA-03 per founder decision Q1 of Build Package 06). |
| inputs_expected | `runs/{{run_id}}/run-profile.yaml`; `{{output_root}}/01-input-inventory.md`; `{{output_root}}/02-visible-dfd-objects.md`; `{{input_root}}/` |
| placeholders | `{{run_id}}`, `{{input_root}}`, `{{output_root}}`, `{{mode}}`, `{{postback_execution_status}}`, `{{output_destination_mode}}` |
| required_sections | Header; Normalization Table; Unknowns; Stop Conditions Recorded |
| prohibited_content | hidden inference; controlled-value enumeration; severity / score computation; finding or recommendation prose |
| output_boundary | under_resolved_output_root_only |
| source_reference | aisraf-sas-prototype-skill-chain-pack-v0.01/templates/legend-normalization-template.md (rebuilt for v0.1.2) |
| version_notes | Rebuilt for v0.1.2. |

## 2. Output Boundary

This template defines output shape only. It records the normalization mapping from raw legend labels to controlled vocabulary; it does not classify components, infer hidden controls, or compute scoring.

## 3. Allowed Placeholders

Only the seven approved run-profile variables. Other run-profile fields are referenced descriptively.

## 4. File Header

```markdown
# Legend Normalization — {{run_id}}

| field | value |
|---|---|
| run_id | {{run_id}} |
| sample_id | [copy from runs/{{run_id}}/run-profile.yaml#sample_id] |
| mode | {{mode}} |
| output_root | {{output_root}} |
| step | RS-03 |
| prompt | prompts/rs/03-legend-normalization.prompt.md |
| skill | skills/rs/SK-LEGEND-NORMALIZE.md |
| owning_pra | PRA-04-LEGEND-NORMALIZER |
```

## 5. Required Sections

1. **Header** (the table above)
2. **Normalization Table** — one row per raw label observed in the legend or annotations:

   | raw_label | source_location | normalized_term | normalization_basis | confidence | notes |
   |---|---|---|---|---|---|

   - `normalization_basis` records exactly which catalog or evidence rule supported the normalization (e.g., `catalogs/components/component-type-catalog.yaml#api-gateway`).
   - `confidence` uses `<value-from-catalogs/data-protection/confidence-level-catalog.yaml>`.

3. **Unknowns** — labels that could not be normalized; record the catalog reference checked and the gap that prevented resolution.
4. **Stop Conditions Recorded**.

## 6. Prohibited Content

- Inventing a normalized term that does not exist in the referenced catalog.
- Component classification, boundary detection, or security-stack assertion.
- Enumerating catalog entries.
- Finding or recommendation prose.

## 7. Source Reference

`aisraf-sas-prototype-skill-chain-pack-v0.01/templates/legend-normalization-template.md` (rebuilt for v0.1.2).

## 8. Version Notes

Rebuilt for v0.1.2.
