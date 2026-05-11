# Template: Missing Facts Output Shape

## 1. Template Metadata

| field | value |
|---|---|
| template_id | TPL-OUT-09-MISSING-FACTS |
| template_name | Missing Facts Output Shape |
| owning_build_package | Build Package 09 |
| status | active |
| purpose | Define the file-level shape of `{{output_root}}/09-missing-facts.md`, written by PR-RS-07 / SK-MISSING-FACT-IDENTIFY / PRA-06. |
| intended_output | `{{output_root}}/09-missing-facts.md` |
| consumers | Prompts: PR-RS-07. Skills: SK-MISSING-FACT-IDENTIFY. PRAs: PRA-06-BLUEPRINT-QUESTIONER. Adapters: aisraf-blueprint-questioner. Blueprints: BP-NON-AI-DATAFLOW-BASELINE, BP-RAG-RETRIEVAL, BP-MODEL-ENDPOINT-CALL, BP-TOOL-USING-AGENT, BP-API-WRITEBACK, BP-HITL-APPROVAL, BP-AGENT-TO-AGENT, BP-AI-WORKFLOW, BP-AI-SAAS-INTEGRATION (cross-references only — no introduction). Catalogs: catalogs/data-protection/confidence-level-catalog.yaml. |
| inputs_expected | `runs/{{run_id}}/run-profile.yaml`; `{{output_root}}/01-input-inventory.md`; `{{output_root}}/04-components.md`; `{{output_root}}/05-flows.md`; `{{output_root}}/06-boundaries.md`; `{{output_root}}/07-security-stack-assessment.md`; `{{output_root}}/08-internal-review-table.md` |
| placeholders | `{{run_id}}`, `{{input_root}}`, `{{output_root}}`, `{{mode}}`, `{{postback_execution_status}}`, `{{output_destination_mode}}` |
| required_sections | Header; Missing Material Fact Rows; Cross-Reference to Blueprint material_missing_facts; Stop Conditions Recorded |
| prohibited_content | hidden inference; controlled-value enumeration; severity / score computation; finding or recommendation prose; blueprint match decision |
| output_boundary | under_resolved_output_root_only |
| source_reference | aisraf-sas-prototype-skill-chain-pack-v0.01/templates/missing-material-fact-template.md (rebuilt; v0.01 was a stub) |
| version_notes | Rebuilt for v0.1.2; references blueprint material_missing_facts but does not invent or modify them. |

## 2. Output Boundary

This template defines output shape only. It records material gaps that block matching against blueprints; it does not decide a blueprint match (that lives in `11-blueprint-match.md`) and does not classify findings or compute scoring.

## 3. Allowed Placeholders

Only the seven approved run-profile variables. Other run-profile fields are referenced descriptively.

## 4. File Header

```markdown
# Missing Material Facts — {{run_id}}

| field | value |
|---|---|
| run_id | {{run_id}} |
| sample_id | [copy from runs/{{run_id}}/run-profile.yaml#sample_id] |
| mode | {{mode}} |
| output_root | {{output_root}} |
| step | RS-07 |
| prompt | prompts/rs/07-missing-fact-question-generate.prompt.md |
| skill | skills/rs/SK-MISSING-FACT-IDENTIFY.md |
| owning_pra | PRA-06-BLUEPRINT-QUESTIONER |
```

## 5. Required Sections

1. **Header**
2. **Missing Material Fact Rows** — one row per gap that prevents matching the design against a candidate blueprint:

   | gap_id | concern | catalog_reference_for_required_value | blueprint_material_missing_fact_referenced | source_artifacts_searched | confidence | notes |
   |---|---|---|---|---|---|---|

   - `catalog_reference_for_required_value` records the catalog file path the value should come from (e.g., `catalogs/identity-access/authentication-catalog.yaml`).
   - `blueprint_material_missing_fact_referenced` cross-references the BP-* `material_missing_facts` entry that names the gap. Populate as `<blueprint_id>#<material_missing_fact_id>`. No new BP-* identifiers are introduced.
   - `confidence` uses `<value-from-catalogs/data-protection/confidence-level-catalog.yaml>`.

3. **Cross-Reference to Blueprint material_missing_facts** — a flat list confirming each referenced BP-* entry exists in `blueprints/blueprint-registry.yaml`.
4. **Stop Conditions Recorded**.

## 6. Prohibited Content

- Inventing new BP-* identifiers or new `material_missing_fact` entries.
- Deciding a blueprint match (that is owned by `11-blueprint-match.md`).
- Severity, score, or AI Action Level computation.
- Finding or recommendation prose.

## 7. Source Reference

`aisraf-sas-prototype-skill-chain-pack-v0.01/templates/missing-material-fact-template.md` (rebuilt; v0.01 was a stub).

## 8. Version Notes

Rebuilt for v0.1.2; founder decision Q3 (no controlled-value enumeration) and Q5 (templates do not modify catalogs or blueprints) applied.
