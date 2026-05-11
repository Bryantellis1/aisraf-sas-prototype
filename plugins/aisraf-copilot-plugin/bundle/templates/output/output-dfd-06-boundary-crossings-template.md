# Template: DFD Boundary Crossings Output Shape

## 1. Template Metadata

| field | value |
|---|---|
| template_id | TPL-OUT-DFD-06-BOUNDARY-CROSSINGS |
| template_name | DFD Boundary Crossings Output Shape |
| owning_build_package | Build Package 09 |
| status | active |
| purpose | Define the file-level shape of `{{output_root}}/dfd/06-boundary-crossings.md`, written by PR-DFD-07 / SK-DFD-06-BOUNDARY-CROSSING-DETECT / PRA-03. |
| intended_output | `{{output_root}}/dfd/06-boundary-crossings.md` |
| consumers | Prompts: PR-DFD-07. Skills: SK-DFD-06-BOUNDARY-CROSSING-DETECT. PRAs: PRA-03-DFD-EXTRACTOR. Adapters: aisraf-dfd-extractor. Catalogs: catalogs/boundaries/boundary-crossing-rule-catalog.yaml. |
| inputs_expected | `runs/{{run_id}}/run-profile.yaml`; `{{output_root}}/dfd/02-boundary-catalog.md`; `{{output_root}}/dfd/03-component-catalog.md`; `{{output_root}}/dfd/04-flow-inventory.md`; `{{output_root}}/dfd/05-annotation-resolution.md` |
| placeholders | `{{run_id}}`, `{{input_root}}`, `{{output_root}}`, `{{mode}}`, `{{postback_execution_status}}`, `{{output_destination_mode}}` |
| required_sections | Header; Boundary Crossing Rows; Unknowns; Stop Conditions Recorded |
| prohibited_content | hidden inference; controlled-value enumeration; severity / score computation; finding or recommendation prose |
| output_boundary | under_resolved_output_root_dfd_subfolder_only |
| source_reference | aisraf-sas-prototype-skill-chain-pack-v0.01/templates/boundary-crossing-template.md (rebuilt for v0.1.2 DFD chain) |
| version_notes | Rebuilt for v0.1.2. |

## 2. Output Boundary

This template defines output shape only. It records boundary crossings derived from boundary, component, and flow evidence; it does not assert encrypted transport or authentication.

## 3. Allowed Placeholders

Only the seven approved run-profile variables. Other run-profile fields are referenced descriptively.

## 4. File Header

```markdown
# DFD Boundary Crossings — {{run_id}}

| field | value |
|---|---|
| run_id | {{run_id}} |
| sample_id | [copy from runs/{{run_id}}/run-profile.yaml#sample_id] |
| mode | {{mode}} |
| output_root | {{output_root}} |
| dfd_step | DFD-06 |
| prompt | prompts/dfd/07-boundary-crossing-detect.prompt.md |
| skill | skills/dfd/SK-DFD-06-BOUNDARY-CROSSING-DETECT.md |
| owning_pra | PRA-03-DFD-EXTRACTOR |
```

## 5. Required Sections

1. **Header**
2. **Boundary Crossing Rows**:

   | crossing_id | flow_id_referenced | source_boundary_id | destination_boundary_id | crossing_rule_applied | confidence | notes |
   |---|---|---|---|---|---|---|

   `crossing_rule_applied` references `catalogs/boundaries/boundary-crossing-rule-catalog.yaml`. `confidence` uses `<value-from-catalogs/data-protection/confidence-level-catalog.yaml>`.

3. **Unknowns**.
4. **Stop Conditions Recorded**.

## 6. Prohibited Content

- Inferring transport, identity, or storage protection (those live in DFD-05 and DFD-07).
- Severity, score, or AI Action Level computation.
- Finding or recommendation prose.
- Enumerated catalog values.

## 7. Source Reference

`aisraf-sas-prototype-skill-chain-pack-v0.01/templates/boundary-crossing-template.md` (rebuilt for v0.1.2 DFD chain).

## 8. Version Notes

Rebuilt for v0.1.2.
