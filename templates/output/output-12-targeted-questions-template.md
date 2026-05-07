# Template: Targeted Questions Output Shape

## 1. Template Metadata

| field | value |
|---|---|
| template_id | TPL-OUT-12-TARGETED-QUESTIONS |
| template_name | Targeted Questions Output Shape |
| owning_build_package | Build Package 09 |
| status | active |
| purpose | Define the file-level shape of `{{output_root}}/12-targeted-questions.md`, written by PR-RS-07 / SK-TARGETED-QUESTION-GENERATE / PRA-06. |
| intended_output | `{{output_root}}/12-targeted-questions.md` |
| consumers | Prompts: PR-RS-07. Skills: SK-TARGETED-QUESTION-GENERATE. PRAs: PRA-06-BLUEPRINT-QUESTIONER. Adapters: aisraf-blueprint-questioner. Blueprints: all 9 BP-* (cross-reference only). |
| inputs_expected | `runs/{{run_id}}/run-profile.yaml`; `{{output_root}}/09-missing-facts.md` |
| placeholders | `{{run_id}}`, `{{input_root}}`, `{{output_root}}`, `{{mode}}`, `{{postback_execution_status}}`, `{{output_destination_mode}}` |
| required_sections | Header; Targeted Question Rows; Stop Conditions Recorded |
| prohibited_content | finding or recommendation prose; blueprint match decision; severity / score computation |
| output_boundary | under_resolved_output_root_only |
| source_reference | aisraf-sas-prototype-skill-chain-pack-v0.01/templates/targeted-question-template.md (rebuilt for v0.1.2) |
| version_notes | Rebuilt for v0.1.2. Founder decision Q1 of Build Package 04 retained 12-targeted-questions.md as a separate output written by PR-RS-07 (no separate prompt). |

## 2. Output Boundary

This template defines output shape only. Each question must be tied to a missing material fact in `09-missing-facts.md`. Questions never decide blueprint matches and never assert findings.

## 3. Allowed Placeholders

Only the seven approved run-profile variables. Other run-profile fields are referenced descriptively.

## 4. File Header

```markdown
# Targeted Questions — {{run_id}}

| field | value |
|---|---|
| run_id | {{run_id}} |
| sample_id | [copy from runs/{{run_id}}/run-profile.yaml#sample_id] |
| mode | {{mode}} |
| output_root | {{output_root}} |
| step | RS-07 |
| prompt | prompts/rs/07-missing-fact-question-generate.prompt.md |
| skill | skills/rs/SK-TARGETED-QUESTION-GENERATE.md |
| owning_pra | PRA-06-BLUEPRINT-QUESTIONER |
```

## 5. Required Sections

1. **Header**
2. **Targeted Question Rows** — one row per material question:

   | question_id | question_text | source_missing_fact_id | evidence_requested | blueprint_cross_reference | owner_or_route_if_known | notes |
   |---|---|---|---|---|---|---|

   - `source_missing_fact_id` references a `gap_id` row in `{{output_root}}/09-missing-facts.md`. Every question must trace to a missing fact.
   - `blueprint_cross_reference` records the BP-* / `material_missing_fact` pair the question helps resolve. No new BP-* identifiers are introduced.

3. **Stop Conditions Recorded**.

## 6. Prohibited Content

- Questions not tied to a missing material fact.
- Finding, recommendation, or validation-ticket prose.
- Blueprint match decisions.
- Severity, score, or AI Action Level computation.

## 7. Source Reference

`aisraf-sas-prototype-skill-chain-pack-v0.01/templates/targeted-question-template.md` (rebuilt for v0.1.2).

## 8. Version Notes

Rebuilt for v0.1.2.
