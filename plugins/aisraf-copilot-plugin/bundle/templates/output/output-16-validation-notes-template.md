# Template: Validation Notes Output Shape

## 1. Template Metadata

| field | value |
|---|---|
| template_id | TPL-OUT-16-VALIDATION-NOTES |
| template_name | Validation Notes Output Shape |
| owning_build_package | Build Package 09 |
| status | active |
| purpose | Define the file-level shape of `{{output_root}}/16-validation-notes.md`, written by PR-RS-12 / SK-VALIDATION-NOTE-WRITE / PRA-08. Validation-ticket follow-up that must remain separate from the design-review handoff pack. |
| intended_output | `{{output_root}}/16-validation-notes.md` |
| consumers | Prompts: PR-RS-12. Skills: SK-VALIDATION-NOTE-WRITE. PRAs: PRA-08-HANDOFF-QA-SCORER. Adapters: aisraf-handoff-qa-scorer. Catalogs: catalogs/review/review-status-catalog.yaml. |
| inputs_expected | `runs/{{run_id}}/run-profile.yaml`; `{{output_root}}/08-internal-review-table.md`; `{{output_root}}/09-missing-facts.md`; `{{output_root}}/10-ai-action-level.md`; `{{output_root}}/12-targeted-questions.md`; `{{output_root}}/13-findings.md`; `{{output_root}}/14-recommendations.md` |
| placeholders | `{{run_id}}`, `{{input_root}}`, `{{output_root}}`, `{{mode}}`, `{{postback_execution_status}}`, `{{output_destination_mode}}` |
| required_sections | Header; Validation Note Rows; Separation From Findings/Recommendations; Stop Conditions Recorded |
| prohibited_content | implementation-proof claim; finding severity computation; recommendation prose; mixing design-review closeout with validation follow-up |
| output_boundary | under_resolved_output_root_only |
| source_reference | aisraf-sas-prototype-skill-chain-pack-v0.01/templates/validation-ticket-note-template.md (rebuilt; v0.01 was a stub) |
| version_notes | Rebuilt for v0.1.2. |

## 2. Output Boundary

This template defines output shape only. Validation notes capture concerns that need a separate validation-ticket workflow — implementation evidence, environment-specific verification, etc. They do not assert that implementation has happened.

## 3. Allowed Placeholders

Only the seven approved run-profile variables. Other run-profile fields are referenced descriptively.

## 4. File Header

```markdown
# Validation Notes — {{run_id}}

| field | value |
|---|---|
| run_id | {{run_id}} |
| sample_id | [copy from runs/{{run_id}}/run-profile.yaml#sample_id] |
| mode | {{mode}} |
| output_root | {{output_root}} |
| step | RS-12 |
| prompt | prompts/rs/12-validation-note-write.prompt.md |
| skill | skills/rs/SK-VALIDATION-NOTE-WRITE.md |
| owning_pra | PRA-08-HANDOFF-QA-SCORER |
```

## 5. Required Sections

1. **Header**
2. **Validation Note Rows** — one row per validation-ticket concern:

   | validation_note_id | concern | evidence_required_for_validation_ticket | source_fact_refs | owner_or_route_if_known | review_status | notes |
   |---|---|---|---|---|---|---|

   - `review_status` uses `<value-from-catalogs/review/review-status-catalog.yaml>`.
   - `source_fact_refs` records artifact paths and row IDs (in `13-findings.md`, `14-recommendations.md`, `09-missing-facts.md`, etc.) the validation note depends on.

3. **Separation From Findings/Recommendations** — explicit pointer that this file does not duplicate finding or recommendation rows. Validation notes are about evidence-required-for-implementation-verification, not about design issues.
4. **Stop Conditions Recorded**.

## 6. Prohibited Content

- Implementation-proof claims (validation notes describe what evidence is required, not what evidence has been gathered).
- Finding severity computation or recommendation prose.
- Mixing design-review closeout content into this file.
- Enumerating catalog values inside the template.

## 7. Source Reference

`aisraf-sas-prototype-skill-chain-pack-v0.01/templates/validation-ticket-note-template.md` (rebuilt; v0.01 was a stub).

## 8. Version Notes

Rebuilt for v0.1.2.
