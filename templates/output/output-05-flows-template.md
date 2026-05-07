# Template: Flows Output Shape

## 1. Template Metadata

| field | value |
|---|---|
| template_id | TPL-OUT-05-FLOWS |
| template_name | Flows Output Shape |
| owning_build_package | Build Package 09 |
| status | active |
| purpose | Define the file-level shape of `{{output_root}}/05-flows.md`, written by PR-RS-04 / SK-FLOW-EXTRACT / PRA-03. |
| intended_output | `{{output_root}}/05-flows.md` |
| consumers | Prompts: PR-RS-04. Skills: SK-FLOW-EXTRACT. PRAs: PRA-03-DFD-EXTRACTOR. Adapters: aisraf-dfd-extractor. Catalogs: catalogs/interactions/interaction-type-catalog.yaml; flow-direction-catalog.yaml; flow-evidence-rule-catalog.yaml. |
| inputs_expected | `runs/{{run_id}}/run-profile.yaml`; `{{output_root}}/02-visible-dfd-objects.md`; `{{output_root}}/03-legend-normalization.md`; `{{input_root}}/` |
| placeholders | `{{run_id}}`, `{{input_root}}`, `{{output_root}}`, `{{mode}}`, `{{postback_execution_status}}`, `{{output_destination_mode}}` |
| required_sections | Header; Flows Table; Unknowns; Stop Conditions Recorded |
| prohibited_content | hidden inference; controlled-value enumeration; severity / score computation; finding or recommendation prose |
| output_boundary | under_resolved_output_root_only |
| source_reference | aisraf-sas-prototype-skill-chain-pack-v0.01/templates/flow-table-template.md (rebuilt for v0.1.2) |
| version_notes | Rebuilt for v0.1.2. |

## 2. Output Boundary

This template defines output shape only. It records flows by visible evidence and the catalog rule that supported each row; it does not infer transport encryption, identity, or hidden controls beyond the visible legend.

## 3. Allowed Placeholders

Only the seven approved run-profile variables. Other run-profile fields are referenced descriptively.

## 4. File Header

```markdown
# Flows — {{run_id}}

| field | value |
|---|---|
| run_id | {{run_id}} |
| sample_id | [copy from runs/{{run_id}}/run-profile.yaml#sample_id] |
| mode | {{mode}} |
| output_root | {{output_root}} |
| step | RS-04 |
| prompt | prompts/rs/04-design-fact-extract.prompt.md |
| skill | skills/rs/SK-FLOW-EXTRACT.md |
| owning_pra | PRA-03-DFD-EXTRACTOR |
```

## 5. Required Sections

1. **Header**
2. **Flows Table** — one row per flow:

   | flow_id | source_component_id | destination_component_id | interaction_type | flow_direction | data_payload_observed | source_location | evidence_rule_applied | confidence | notes |
   |---|---|---|---|---|---|---|---|---|---|

   - `interaction_type` uses `<value-from-catalogs/interactions/interaction-type-catalog.yaml>`.
   - `flow_direction` uses `<value-from-catalogs/interactions/flow-direction-catalog.yaml>`.
   - `data_payload_observed` records the visible label or payload description; if unobserved, record `unknown` and surface in §3.
   - `evidence_rule_applied` references `catalogs/interactions/flow-evidence-rule-catalog.yaml`.
   - `confidence` uses `<value-from-catalogs/data-protection/confidence-level-catalog.yaml>`.

3. **Unknowns** — flows whose endpoints, type, direction, or payload could not be resolved from supported evidence.
4. **Stop Conditions Recorded**.

## 6. Prohibited Content

- Inferring transport protection or authentication unless visibly annotated. Those belong to RS-05.
- Enumerating catalog values inside the template body.
- Finding or recommendation prose.

## 7. Source Reference

`aisraf-sas-prototype-skill-chain-pack-v0.01/templates/flow-table-template.md` (rebuilt).

## 8. Version Notes

Rebuilt for v0.1.2.
