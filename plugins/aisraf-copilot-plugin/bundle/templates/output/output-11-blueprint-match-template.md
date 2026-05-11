# Template: Blueprint Match Output Shape

## 1. Template Metadata

| field | value |
|---|---|
| template_id | TPL-OUT-11-BLUEPRINT-MATCH |
| template_name | Blueprint Match Output Shape |
| owning_build_package | Build Package 09 |
| status | active |
| purpose | Define the file-level shape of `{{output_root}}/11-blueprint-match.md`, written by PR-RS-09 / SK-REVIEW-BLUEPRINT-MATCH / PRA-06. Match-state selection is performed by the skill plus human review; this template records the resulting state and supporting catalog evidence only. |
| intended_output | `{{output_root}}/11-blueprint-match.md` |
| consumers | Prompts: PR-RS-09. Skills: SK-REVIEW-BLUEPRINT-MATCH. PRAs: PRA-06-BLUEPRINT-QUESTIONER. Adapters: aisraf-blueprint-questioner. Blueprints: all 9 BP-* (cross-reference only). Catalogs: catalogs/data-protection/confidence-level-catalog.yaml. |
| inputs_expected | `runs/{{run_id}}/run-profile.yaml`; `{{output_root}}/04-components.md`; `{{output_root}}/05-flows.md`; `{{output_root}}/06-boundaries.md`; `{{output_root}}/08-internal-review-table.md`; `{{output_root}}/10-ai-action-level.md` |
| placeholders | `{{run_id}}`, `{{input_root}}`, `{{output_root}}`, `{{mode}}`, `{{postback_execution_status}}`, `{{output_destination_mode}}` |
| required_sections | Header; Candidate Blueprint; Match State; Supporting Catalog Evidence; Material Missing Facts; Human Review Gate Status; Stop Conditions Recorded |
| prohibited_content | blueprint-match computation inside the template; blueprint definition override; controlled-value enumeration; severity / score computation; finding or recommendation prose; approval claim |
| output_boundary | under_resolved_output_root_only |
| source_reference | New for v0.1.2 (v0.01 had no dedicated blueprint-match template) |
| version_notes | New for v0.1.2; uses the four-state match model from blueprint-registry.yaml. |

## 2. Output Boundary

This template defines output shape only. The match state is determined by `skills/rs/SK-REVIEW-BLUEPRINT-MATCH.md` plus human review against `blueprints/blueprint-registry.yaml`. This template records the result and never invents new BP-* identifiers, controlled values, or match conditions.

## 3. Allowed Placeholders

Only the seven approved run-profile variables. Other run-profile fields are referenced descriptively.

## 4. File Header

```markdown
# Blueprint Match — {{run_id}}

| field | value |
|---|---|
| run_id | {{run_id}} |
| sample_id | [copy from runs/{{run_id}}/run-profile.yaml#sample_id] |
| mode | {{mode}} |
| output_root | {{output_root}} |
| step | RS-09 |
| prompt | prompts/rs/09-blueprint-match.prompt.md |
| skill | skills/rs/SK-REVIEW-BLUEPRINT-MATCH.md |
| owning_pra | PRA-06-BLUEPRINT-QUESTIONER |
| match_state_model | matched / candidate / no_match / unknown (from blueprints/blueprint-registry.yaml#blueprint_match_states) |
```

## 5. Required Sections

1. **Header**
2. **Candidate Blueprint**

   | field | value |
   |---|---|
   | candidate_blueprint_id | `<value-from-blueprints/blueprint-registry.yaml#blueprint_id>` |
   | category | `platform-independent` or `cloud-patterns` |
   | confidence | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml>` |

3. **Match State** — one of `matched`, `candidate`, `no_match`, `unknown` (from `blueprints/blueprint-registry.yaml#blueprint_match_states`). Record the state, the human reviewer name, and the timestamp.
4. **Supporting Catalog Evidence** — table of catalog values that satisfied (or failed) the blueprint's `match_conditions`:

   | condition_id | catalog_id_referenced | catalog_value_observed | status_for_match |
   |---|---|---|---|

   `catalog_id_referenced` must resolve to an existing entry in `catalogs/catalog-registry.yaml#catalogs[]`. `status_for_match` is `met`, `unmet`, or `unknown`.

5. **Material Missing Facts** — cross-reference rows in `{{output_root}}/09-missing-facts.md` that map to the blueprint's `material_missing_facts`.
6. **Human Review Gate Status** — `<value-from-catalogs/review/review-status-catalog.yaml>`.
7. **Stop Conditions Recorded**.

## 6. Prohibited Content

- Computing or deciding the match state inside the template body.
- Introducing new BP-* identifiers or new controlled values.
- Modifying the blueprint definitions (those live under `blueprints/`).
- Severity, score, or AI Action Level computation.
- Finding, recommendation, or approval prose.
- Implementation-proof claims from a blueprint match.

## 7. Source Reference

New for v0.1.2.

## 8. Version Notes

New template for v0.1.2; consumes the four-state model and the 9 BP-* identifiers exactly as registered.
