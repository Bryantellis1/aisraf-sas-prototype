# Template: DFD Intake Quality Check Output Shape

## 1. Template Metadata

| field | value |
|---|---|
| template_id | TPL-OUT-DFD-01-INTAKE-QUALITY-CHECK |
| template_name | DFD Intake Quality Check Output Shape |
| owning_build_package | Build Package 09 |
| status | active |
| purpose | Define the file-level shape of `{{output_root}}/dfd/01-intake-quality-check.md`, written by PR-DFD-02 / SK-DFD-01-INTAKE-QUALITY-CHECK / PRA-03. |
| intended_output | `{{output_root}}/dfd/01-intake-quality-check.md` |
| consumers | Prompts: PR-DFD-02. Skills: SK-DFD-01-INTAKE-QUALITY-CHECK. PRAs: PRA-03-DFD-EXTRACTOR. Adapters: aisraf-dfd-extractor. Catalogs: catalogs/data-protection/confidence-level-catalog.yaml. |
| inputs_expected | `runs/{{run_id}}/run-profile.yaml`; `{{input_root}}/` |
| placeholders | `{{run_id}}`, `{{input_root}}`, `{{output_root}}`, `{{mode}}`, `{{postback_execution_status}}`, `{{output_destination_mode}}` |
| required_sections | Header; Intake Quality Findings; Material Gaps; Stop Conditions Recorded |
| prohibited_content | hidden inference; controlled-value enumeration; severity / score computation; finding or recommendation prose |
| output_boundary | under_resolved_output_root_dfd_subfolder_only |
| source_reference | New for v0.1.2 |
| version_notes | New for v0.1.2. |

## 2. Output Boundary

This template defines output shape only. It records intake quality observations (legibility, presence of legend, missing labels) and material gaps that block extraction; it does not classify components, flows, or boundaries.

## 3. Allowed Placeholders

Only the seven approved run-profile variables. Other run-profile fields are referenced descriptively.

## 4. File Header

```markdown
# DFD Intake Quality Check — {{run_id}}

| field | value |
|---|---|
| run_id | {{run_id}} |
| sample_id | [copy from runs/{{run_id}}/run-profile.yaml#sample_id] |
| mode | {{mode}} |
| input_root | {{input_root}} |
| output_root | {{output_root}} |
| dfd_step | DFD-01 |
| prompt | prompts/dfd/02-dfd-intake-quality-check.prompt.md |
| skill | skills/dfd/SK-DFD-01-INTAKE-QUALITY-CHECK.md |
| owning_pra | PRA-03-DFD-EXTRACTOR |
```

## 5. Required Sections

1. **Header**
2. **Intake Quality Findings** — table:

   | finding_id | observation | impact_on_extraction | source_location | confidence | notes |
   |---|---|---|---|---|---|

   `confidence` uses `<value-from-catalogs/data-protection/confidence-level-catalog.yaml>`.

3. **Material Gaps** — gaps that prevent the DFD subskill chain from continuing. Each gap is a candidate stop condition.
4. **Stop Conditions Recorded**.

## 6. Prohibited Content

- Component, flow, boundary, or security-stack classification.
- Severity, score, or AI Action Level computation.
- Finding or recommendation prose.
- Enumerated catalog values.

## 7. Source Reference

New for v0.1.2.

## 8. Version Notes

New for v0.1.2.
