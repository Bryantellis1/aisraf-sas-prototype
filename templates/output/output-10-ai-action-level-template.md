# Template: AI Action Level Output Shape

## 1. Template Metadata

| field | value |
|---|---|
| template_id | TPL-OUT-10-AI-ACTION-LEVEL |
| template_name | AI Action Level Output Shape |
| owning_build_package | Build Package 09 |
| status | active |
| purpose | Define the file-level shape of `{{output_root}}/10-ai-action-level.md`, written by PR-RS-08 / SK-AI-ACTION-LEVEL-CLASSIFY / PRA-06. The AI Action Level is selected by the skill plus human review; this template records the result, supporting evidence, and the human-review gate status only. |
| intended_output | `{{output_root}}/10-ai-action-level.md` |
| consumers | Prompts: PR-RS-08. Skills: SK-AI-ACTION-LEVEL-CLASSIFY. PRAs: PRA-06-BLUEPRINT-QUESTIONER. Adapters: aisraf-blueprint-questioner. Catalogs: catalogs/review/ai-action-level-catalog.yaml; catalogs/data-protection/confidence-level-catalog.yaml. |
| inputs_expected | `runs/{{run_id}}/run-profile.yaml`; `{{output_root}}/04-components.md`; `{{output_root}}/05-flows.md`; `{{output_root}}/08-internal-review-table.md` |
| placeholders | `{{run_id}}`, `{{input_root}}`, `{{output_root}}`, `{{mode}}`, `{{postback_execution_status}}`, `{{output_destination_mode}}` |
| required_sections | Header; Selected AI Action Level; Supporting Evidence; Unknowns; Human Review Gate Status; Stop Conditions Recorded |
| prohibited_content | AI Action Level computation inside the template; controlled-value enumeration; severity / score computation; finding or recommendation prose |
| output_boundary | under_resolved_output_root_only |
| source_reference | New for v0.1.2 (v0.01 had no dedicated AI Action Level template) |
| version_notes | New for v0.1.2. |

## 2. Output Boundary

This template defines output shape only. The AI Action Level is selected by `skills/rs/SK-AI-ACTION-LEVEL-CLASSIFY.md` plus human review; this template records the result and never computes the value inside the template body.

## 3. Allowed Placeholders

Only the seven approved run-profile variables. Other run-profile fields are referenced descriptively.

## 4. File Header

```markdown
# AI Action Level — {{run_id}}

| field | value |
|---|---|
| run_id | {{run_id}} |
| sample_id | [copy from runs/{{run_id}}/run-profile.yaml#sample_id] |
| mode | {{mode}} |
| output_root | {{output_root}} |
| step | RS-08 |
| prompt | prompts/rs/08-ai-action-level-classify.prompt.md |
| skill | skills/rs/SK-AI-ACTION-LEVEL-CLASSIFY.md |
| owning_pra | PRA-06-BLUEPRINT-QUESTIONER |
```

## 5. Required Sections

1. **Header**
2. **Selected AI Action Level**

   | field | value |
   |---|---|
   | selected_level | `<value-from-catalogs/review/ai-action-level-catalog.yaml>` |
   | confidence | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml>` |
   | selected_at | [ISO 8601 UTC timestamp] |

3. **Supporting Evidence** — list source rows and artifacts that supported the level selection. Each entry references a row id from `04-components.md`, `05-flows.md`, or `08-internal-review-table.md`.
4. **Unknowns** — facts the level depends on that could not be resolved.
5. **Human Review Gate Status** — `<value-from-catalogs/review/review-status-catalog.yaml>`.
6. **Stop Conditions Recorded**.

## 6. Prohibited Content

- Computing or deriving the AI Action Level inside the template body. Selection logic lives in the skill.
- Inventing new AI Action Level entries beyond `catalogs/review/ai-action-level-catalog.yaml`.
- Severity, score, or blueprint-match computation.
- Finding or recommendation prose.

## 7. Source Reference

New for v0.1.2.

## 8. Version Notes

New template for v0.1.2; aligns with PR-RS-08 / SK-AI-ACTION-LEVEL-CLASSIFY which were absent in v0.01.
