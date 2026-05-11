# Template: Boundaries Output Shape

## 1. Template Metadata

| field | value |
|---|---|
| template_id | TPL-OUT-06-BOUNDARIES |
| template_name | Boundaries Output Shape |
| owning_build_package | Build Package 09 |
| status | active |
| purpose | Define the file-level shape of `{{output_root}}/06-boundaries.md`, written by PR-RS-05 / SK-BOUNDARY-CROSSING-DETECT / PRA-05. |
| intended_output | `{{output_root}}/06-boundaries.md` |
| consumers | Prompts: PR-RS-05. Skills: SK-BOUNDARY-CROSSING-DETECT. PRAs: PRA-05-REVIEW-TABLE-BUILDER. Adapters: aisraf-review-table-builder. Catalogs: catalogs/boundaries/boundary-type-catalog.yaml; boundary-crossing-rule-catalog.yaml; trust-zone-catalog.yaml. |
| inputs_expected | `runs/{{run_id}}/run-profile.yaml`; `{{output_root}}/03-legend-normalization.md`; `{{output_root}}/04-components.md`; `{{output_root}}/05-flows.md` |
| placeholders | `{{run_id}}`, `{{input_root}}`, `{{output_root}}`, `{{mode}}`, `{{postback_execution_status}}`, `{{output_destination_mode}}` |
| required_sections | Header; Boundary Table; Boundary Crossing Table; Unknowns; Stop Conditions Recorded |
| prohibited_content | hidden inference; controlled-value enumeration; severity / score computation; finding or recommendation prose |
| output_boundary | under_resolved_output_root_only |
| source_reference | aisraf-sas-prototype-skill-chain-pack-v0.01/templates/boundary-crossing-template.md (rebuilt for v0.1.2) |
| version_notes | Rebuilt for v0.1.2. |

## 2. Output Boundary

This template defines output shape only. It records boundaries and crossings by visible evidence; it does not assert encrypted transport, authentication, or other security-stack proofs (those live in `07-security-stack-assessment.md`).

## 3. Allowed Placeholders

Only the seven approved run-profile variables. Other run-profile fields are referenced descriptively.

## 4. File Header

```markdown
# Boundaries — {{run_id}}

| field | value |
|---|---|
| run_id | {{run_id}} |
| sample_id | [copy from runs/{{run_id}}/run-profile.yaml#sample_id] |
| mode | {{mode}} |
| output_root | {{output_root}} |
| step | RS-05 |
| prompt | prompts/rs/05-boundary-stack-detect.prompt.md |
| skill | skills/rs/SK-BOUNDARY-CROSSING-DETECT.md |
| owning_pra | PRA-05-REVIEW-TABLE-BUILDER |
```

## 5. Required Sections

1. **Header**
2. **Boundary Table** — one row per identified boundary:

   | boundary_id | boundary_label | boundary_type | trust_zone_inside | trust_zone_outside | source_location | confidence | notes |
   |---|---|---|---|---|---|---|---|

   - `boundary_type` uses `<value-from-catalogs/boundaries/boundary-type-catalog.yaml>`.
   - `trust_zone_inside` and `trust_zone_outside` use `<value-from-catalogs/boundaries/trust-zone-catalog.yaml>`.

3. **Boundary Crossing Table** — one row per crossing:

   | crossing_id | flow_id_referenced | source_boundary | destination_boundary | crossing_rule_applied | confidence | notes |
   |---|---|---|---|---|---|---|

   - `crossing_rule_applied` references `catalogs/boundaries/boundary-crossing-rule-catalog.yaml`.
   - `flow_id_referenced` cross-references rows in `{{output_root}}/05-flows.md`.

4. **Unknowns**.
5. **Stop Conditions Recorded**.

## 6. Prohibited Content

- Inferring authentication, transport encryption, or rest protection (those live in RS-05's security-stack-assessment output).
- Enumerated catalog values inside the template.
- Finding or recommendation prose.

## 7. Source Reference

`aisraf-sas-prototype-skill-chain-pack-v0.01/templates/boundary-crossing-template.md` (rebuilt for v0.1.2).

## 8. Version Notes

Rebuilt for v0.1.2.
