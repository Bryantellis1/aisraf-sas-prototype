# Template: Visible DFD Objects Output Shape

## 1. Template Metadata

| field | value |
|---|---|
| template_id | TPL-OUT-02-VISIBLE-DFD-OBJECTS |
| template_name | Visible DFD Objects Output Shape |
| owning_build_package | Build Package 09 |
| status | active |
| purpose | Define the file-level shape of `{{output_root}}/02-visible-dfd-objects.md`, written by PR-RS-02 / SK-DFD-VISUAL-READ / PRA-03. |
| intended_output | `{{output_root}}/02-visible-dfd-objects.md` |
| consumers | Prompts: PR-RS-02. Skills: SK-DFD-VISUAL-READ. PRAs: PRA-03-DFD-EXTRACTOR. Adapters: aisraf-dfd-extractor. Catalogs: catalogs/components/component-type-catalog.yaml; catalogs/components/component-role-catalog.yaml. |
| inputs_expected | `runs/{{run_id}}/run-profile.yaml`; `{{output_root}}/01-input-inventory.md`; `{{input_root}}/` |
| placeholders | `{{run_id}}`, `{{input_root}}`, `{{output_root}}`, `{{mode}}`, `{{postback_execution_status}}`, `{{output_destination_mode}}` |
| required_sections | Header; Visible Object Table; Unknowns; Stop Conditions Recorded |
| prohibited_content | hidden inference; controlled-value enumeration; severity / score / AI Action Level / blueprint-match computation; finding or recommendation prose |
| output_boundary | under_resolved_output_root_only |
| source_reference | aisraf-sas-prototype-skill-chain-pack-v0.01/templates/dfd-visible-object-template.md (collapsed with visible-dfd-object-template.md and rebuilt) |
| version_notes | Rebuilt for v0.1.2; v0.01 had two near-duplicate templates. |

## 2. Output Boundary

This template defines output shape only. It records visible DFD objects and the source location where each was read; it does not infer hidden controls, compute scoring, or invent findings.

## 3. Allowed Placeholders

Only the seven approved run-profile variables. Other run-profile fields are referenced descriptively as `[copy from runs/{{run_id}}/run-profile.yaml#field_name]`.

## 4. File Header

```markdown
# Visible DFD Objects — {{run_id}}

| field | value |
|---|---|
| run_id | {{run_id}} |
| sample_id | [copy from runs/{{run_id}}/run-profile.yaml#sample_id] |
| mode | {{mode}} |
| input_root | {{input_root}} |
| output_root | {{output_root}} |
| step | RS-02 |
| prompt | prompts/rs/02-dfd-visual-read.prompt.md |
| skill | skills/rs/SK-DFD-VISUAL-READ.md |
| owning_pra | PRA-03-DFD-EXTRACTOR |
```

## 5. Required Sections

1. **Header** (the table above)
2. **Visible Object Table** — one row per object visible on the staged DFD or design materials:

   | object_id | label_visible_on_diagram | object_kind_observed | source_location | visible_annotations | confidence | notes |
   |---|---|---|---|---|---|---|

   - `object_kind_observed` references `<value-from-catalogs/components/component-type-catalog.yaml>`.
   - `confidence` references `<value-from-catalogs/data-protection/confidence-level-catalog.yaml>`.
   - `source_location` records the exact artifact path under `{{input_root}}/` plus an in-artifact location (page, region, label).

3. **Unknowns** — visible objects whose kind, role, or label could not be resolved. Each row references the catalog the value should come from and the gap that blocks resolution.
4. **Stop Conditions Recorded** — record any stop condition triggered (no DFD found, illegible artifact, missing legend referenced as required by `prompts/rs/02-dfd-visual-read.prompt.md`).

## 6. Prohibited Content

- Hidden inference. Only objects visible in the input materials may be recorded.
- Enumerated catalog values inside the template body.
- Component role, security stack, or boundary classification — those are owned by later steps.
- Finding or recommendation prose.

## 7. Source Reference

`aisraf-sas-prototype-skill-chain-pack-v0.01/templates/dfd-visible-object-template.md` and `visible-dfd-object-template.md` (collapsed and rebuilt for v0.1.2).

## 8. Version Notes

Rebuilt for v0.1.2.
