# Template: Input Inventory Output Shape

## 1. Template Metadata

| field | value |
|---|---|
| template_id | TPL-OUT-01-INPUT-INVENTORY |
| template_name | Input Inventory Output Shape |
| owning_build_package | Build Package 09 |
| status | active |
| purpose | Define the file-level shape of `{{output_root}}/01-input-inventory.md`, written by PR-RS-01 / SK-INPUT-PACKAGE-READ / PRA-02. |
| intended_output | `{{output_root}}/01-input-inventory.md` |
| consumers | Prompts: PR-RS-01. Skills: SK-INPUT-PACKAGE-READ. PRAs: PRA-02-INPUT-READER. Adapters: aisraf-input-reader. |
| inputs_expected | `runs/{{run_id}}/run-profile.yaml`; `{{input_root}}/` |
| placeholders | `{{run_id}}`, `{{input_root}}`, `{{output_root}}`, `{{mode}}`, `{{postback_execution_status}}`, `{{output_destination_mode}}` |
| required_sections | Header; Inventory Table; Unknowns; Stop Conditions Recorded |
| prohibited_content | severity / score / AI Action Level / blueprint-match computation; finding prose; recommendation prose; controlled-value enumeration |
| output_boundary | under_resolved_output_root_only |
| source_reference | aisraf-sas-prototype-skill-chain-pack-v0.01/templates/input-inventory-template.md (rebuilt — v0.01 was a stub) |
| version_notes | Rebuilt for v0.1.2. |

## 2. Output Boundary

This template defines output shape only. It does not execute the review, compute severity / score / AI Action Level / blueprint match, invent findings or recommendations, claim runtime / cloud / MCP / Jira / Confluence / Rovo / ADK execution, or override catalogs or blueprints.

## 3. Allowed Placeholders

Only the seven approved run-profile variables. Other run-profile fields are referenced descriptively as `[copy from runs/{{run_id}}/run-profile.yaml#field_name]`.

## 4. File Header

```markdown
# Input Inventory — {{run_id}}

| field | value |
|---|---|
| run_id | {{run_id}} |
| sample_id | [copy from runs/{{run_id}}/run-profile.yaml#sample_id] |
| mode | {{mode}} |
| input_root | {{input_root}} |
| output_root | {{output_root}} |
| step | RS-01 |
| prompt | prompts/rs/01-input-package-read.prompt.md |
| skill | skills/rs/SK-INPUT-PACKAGE-READ.md |
| owning_pra | PRA-02-INPUT-READER |
```

## 5. Required Sections

1. **Header** (the table above)
2. **Inventory Table** — one row per artifact discovered under `{{input_root}}/`:

   | artifact_id | path_under_input_root | artifact_type | summary | required_for_review | confidence | notes |
   |---|---|---|---|---|---|---|

   - `artifact_type` values come from observable evidence in the file (DFD, narrative, screenshot, ticket-export, sample-design, vendor-doc, other). Do not invent types.
   - `confidence` uses `<value-from-catalogs/data-protection/confidence-level-catalog.yaml>`.

3. **Unknowns** — list every `unknown` value with the catalog reference and the gap that prevents resolution.
4. **Stop Conditions Recorded** — record any stop condition triggered during this step (input root empty, unreadable input, sensitive-data flagged, etc.) with timestamp and reason.

## 6. Prohibited Content

- Hidden inference about controls, components, or boundaries. Only what is visibly readable in the staged inputs may be recorded.
- Enumerated catalog values inside the template body. Use `<value-from-catalogs/...>` placeholder syntax.
- Finding prose or recommendation prose.
- Severity, score, or AI Action Level computation.

## 7. Source Reference

`aisraf-sas-prototype-skill-chain-pack-v0.01/templates/input-inventory-template.md` (rebuilt; v0.01 was a 4-line stub).

## 8. Version Notes

Rebuilt for v0.1.2 to align with PR-RS-01 / SK-INPUT-PACKAGE-READ / PRA-02 declared output path.
