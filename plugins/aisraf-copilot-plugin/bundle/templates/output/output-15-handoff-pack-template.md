# Template: Handoff Pack Output Shape

## 1. Template Metadata

| field | value |
|---|---|
| template_id | TPL-OUT-15-HANDOFF-PACK |
| template_name | Handoff Pack Output Shape |
| owning_build_package | Build Package 09 |
| status | active |
| purpose | Define the file-level shape of `{{output_root}}/15-handoff-pack.md`, written by PR-RS-11 / SK-HANDOFF-PACK-BUILD / PRA-08. Assembles prior accepted RS outputs into a single review-closeout artifact. |
| intended_output | `{{output_root}}/15-handoff-pack.md` |
| consumers | Prompts: PR-RS-11. Skills: SK-HANDOFF-PACK-BUILD. PRAs: PRA-08-HANDOFF-QA-SCORER. Adapters: aisraf-handoff-qa-scorer. |
| inputs_expected | `runs/{{run_id}}/run-profile.yaml`; `{{output_root}}/08-internal-review-table.md`; `{{output_root}}/09-missing-facts.md`; `{{output_root}}/10-ai-action-level.md`; `{{output_root}}/11-blueprint-match.md`; `{{output_root}}/12-targeted-questions.md`; `{{output_root}}/13-findings.md`; `{{output_root}}/14-recommendations.md` |
| placeholders | `{{run_id}}`, `{{input_root}}`, `{{output_root}}`, `{{mode}}`, `{{postback_execution_status}}`, `{{output_destination_mode}}` |
| required_sections | Header; Review Summary; Scope and Inputs; Flow and Boundary Summary; Findings and Recommendations; Targeted Questions; Material Missing Facts; AI Action Level; Blueprint Match; Human Review Gate Status; Separation From Validation Notes; Stop Conditions Recorded |
| prohibited_content | final execution proof; implementation-proof claim; external post-back claim; severity / score computation; recommendation prose invention |
| output_boundary | under_resolved_output_root_only |
| source_reference | aisraf-sas-prototype-skill-chain-pack-v0.01/templates/handoff-pack-template.md (rebuilt; v0.01 was a stub) |
| version_notes | Rebuilt for v0.1.2; explicit separation from validation-notes section. |

## 2. Output Boundary

This template defines output shape only. The handoff pack assembles content from accepted prior outputs by reference. It does not invent findings or recommendations and does not claim external post-back; that lives in `templates/jira/` / `templates/confluence/` and the post-back row template.

## 3. Allowed Placeholders

Only the seven approved run-profile variables. Other run-profile fields are referenced descriptively.

## 4. File Header

```markdown
# Design Review Handoff Pack — {{run_id}}

| field | value |
|---|---|
| run_id | {{run_id}} |
| sample_id | [copy from runs/{{run_id}}/run-profile.yaml#sample_id] |
| mode | {{mode}} |
| output_root | {{output_root}} |
| output_destination_mode | {{output_destination_mode}} |
| postback_execution_status | {{postback_execution_status}} |
| step | RS-11 |
| prompt | prompts/rs/11-handoff-pack-build.prompt.md |
| skill | skills/rs/SK-HANDOFF-PACK-BUILD.md |
| owning_pra | PRA-08-HANDOFF-QA-SCORER |
```

## 5. Required Sections

1. **Header**
2. **Review Summary** — narrative summary derived from the accepted handoff content. No new claims.
3. **Scope and Inputs** — references rows in `01-input-inventory.md`.
4. **Flow and Boundary Summary** — references selected rows in `06-boundaries.md`, `07-security-stack-assessment.md`, and `08-internal-review-table.md`.
5. **Findings and Recommendations** — references accepted rows in `13-findings.md` and `14-recommendations.md` only.
6. **Targeted Questions** — references accepted rows in `12-targeted-questions.md` only.
7. **Material Missing Facts** — references rows in `09-missing-facts.md`.
8. **AI Action Level** — references the value recorded in `10-ai-action-level.md`.
9. **Blueprint Match** — references the state recorded in `11-blueprint-match.md`.
10. **Human Review Gate Status** — gate disposition with reviewer name and timestamp.
11. **Separation From Validation Notes** — explicit pointer that validation-ticket follow-up lives in `16-validation-notes.md` and is not mixed into this handoff pack.
12. **Stop Conditions Recorded**.

## 6. Prohibited Content

- Inventing findings, recommendations, owner routings, or implementation-proof claims.
- Mixing validation-ticket follow-up content into the handoff sections (validation notes have their own file).
- Severity, score, AI Action Level, or blueprint-match computation.
- Any "Jira post-back: executed_by_operator" or "Confluence published" claim. Those live in `templates/jira/`, `templates/confluence/`, and the post-back row template, gated on `executed_by_operator` evidence.

## 7. Source Reference

`aisraf-sas-prototype-skill-chain-pack-v0.01/templates/handoff-pack-template.md` (rebuilt; v0.01 was a stub).

## 8. Version Notes

Rebuilt for v0.1.2.
