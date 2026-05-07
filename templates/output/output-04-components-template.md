# Template: Components Output Shape

## 1. Template Metadata

| field | value |
|---|---|
| template_id | TPL-OUT-04-COMPONENTS |
| template_name | Components Output Shape |
| owning_build_package | Build Package 09 |
| status | active |
| purpose | Define the file-level shape of `{{output_root}}/04-components.md`, written by PR-RS-04 / SK-COMPONENT-EXTRACT / PRA-03. |
| intended_output | `{{output_root}}/04-components.md` |
| consumers | Prompts: PR-RS-04. Skills: SK-COMPONENT-EXTRACT. PRAs: PRA-03-DFD-EXTRACTOR. Adapters: aisraf-dfd-extractor. Catalogs: catalogs/components/component-type-catalog.yaml; component-role-catalog.yaml; component-evidence-rule-catalog.yaml. |
| inputs_expected | `runs/{{run_id}}/run-profile.yaml`; `{{output_root}}/02-visible-dfd-objects.md`; `{{output_root}}/03-legend-normalization.md`; `{{input_root}}/` |
| placeholders | `{{run_id}}`, `{{input_root}}`, `{{output_root}}`, `{{mode}}`, `{{postback_execution_status}}`, `{{output_destination_mode}}` |
| required_sections | Header; Components Table; Unknowns; Stop Conditions Recorded |
| prohibited_content | hidden inference; controlled-value enumeration; severity / score computation; finding or recommendation prose |
| output_boundary | under_resolved_output_root_only |
| source_reference | aisraf-sas-prototype-skill-chain-pack-v0.01/templates/component-table-template.md (rebuilt for v0.1.2) |
| version_notes | Rebuilt for v0.1.2. |

## 2. Output Boundary

This template defines output shape only. It records components classified by visible evidence and the catalog rule that supported each classification; it does not infer hidden controls or compute scoring.

## 3. Allowed Placeholders

Only the seven approved run-profile variables. Other run-profile fields are referenced descriptively.

## 4. File Header

```markdown
# Components — {{run_id}}

| field | value |
|---|---|
| run_id | {{run_id}} |
| sample_id | [copy from runs/{{run_id}}/run-profile.yaml#sample_id] |
| mode | {{mode}} |
| output_root | {{output_root}} |
| step | RS-04 |
| prompt | prompts/rs/04-design-fact-extract.prompt.md |
| skill | skills/rs/SK-COMPONENT-EXTRACT.md |
| owning_pra | PRA-03-DFD-EXTRACTOR |
```

## 5. Required Sections

1. **Header**
2. **Components Table** — one row per component:

   | component_id | label | component_type | component_role | source_location | evidence_rule_applied | confidence | notes |
   |---|---|---|---|---|---|---|---|

   - `component_type` uses `<value-from-catalogs/components/component-type-catalog.yaml>`.
   - `component_role` uses `<value-from-catalogs/components/component-role-catalog.yaml>`.
   - `evidence_rule_applied` references the rule entry from `catalogs/components/component-evidence-rule-catalog.yaml`.
   - `confidence` uses `<value-from-catalogs/data-protection/confidence-level-catalog.yaml>`.

3. **Unknowns** — components whose type or role cannot be resolved from supported evidence.
4. **Stop Conditions Recorded**.

## 6. Prohibited Content

- Inventing component types or roles outside the catalog.
- Hidden control assumption (no `tls_terminated`, `auth_enforced`, etc., unless directly visible — those belong to RS-05 and RS-07).
- Enumerated catalog values inside the template.
- Finding or recommendation prose.

## 7. Source Reference

`aisraf-sas-prototype-skill-chain-pack-v0.01/templates/component-table-template.md` (rebuilt).

## 8. Version Notes

Rebuilt for v0.1.2.
