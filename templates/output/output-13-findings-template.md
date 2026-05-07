# Template: Findings Output Shape

## 1. Template Metadata

| field | value |
|---|---|
| template_id | TPL-OUT-13-FINDINGS |
| template_name | Findings Output Shape |
| owning_build_package | Build Package 09 |
| status | active |
| purpose | Define the file-level shape of `{{output_root}}/13-findings.md`, written by PR-RS-10 / SK-FINDING-CLASSIFY / PRA-07. Severity is selected by the skill plus human review; this template records the result and supporting evidence only. |
| intended_output | `{{output_root}}/13-findings.md` |
| consumers | Prompts: PR-RS-10. Skills: SK-FINDING-CLASSIFY. PRAs: PRA-07-FINDING-RECOMMENDER. Adapters: aisraf-finding-recommender. Catalogs: catalogs/review/finding-category-catalog.yaml; severity-catalog.yaml; review-status-catalog.yaml; catalogs/data-protection/confidence-level-catalog.yaml. |
| inputs_expected | `runs/{{run_id}}/run-profile.yaml`; `{{output_root}}/06-boundaries.md`; `{{output_root}}/07-security-stack-assessment.md`; `{{output_root}}/08-internal-review-table.md`; `{{output_root}}/09-missing-facts.md`; `{{output_root}}/10-ai-action-level.md`; `{{output_root}}/11-blueprint-match.md`; `{{output_root}}/12-targeted-questions.md` |
| placeholders | `{{run_id}}`, `{{input_root}}`, `{{output_root}}`, `{{mode}}`, `{{postback_execution_status}}`, `{{output_destination_mode}}` |
| required_sections | Header; Finding Rows; Unknowns; Human Review Gate Status; Stop Conditions Recorded |
| prohibited_content | severity computation inside the template; controlled-value enumeration; recommendation prose; blueprint match decision; approval claim |
| output_boundary | under_resolved_output_root_only |
| source_reference | aisraf-sas-prototype-skill-chain-pack-v0.01/templates/finding-register-template.md (column shape reused; rebuilt for v0.1.2) |
| version_notes | Rebuilt for v0.1.2 with controlled-vocabulary-by-catalog-path style. |

## 2. Output Boundary

This template defines output shape only. Severity, finding category, and review status are selected by the skill plus human review using the cited catalogs. This template never computes severity, never invents finding facts, and never enumerates catalog values.

## 3. Allowed Placeholders

Only the seven approved run-profile variables. Other run-profile fields are referenced descriptively.

## 4. File Header

```markdown
# Findings — {{run_id}}

| field | value |
|---|---|
| run_id | {{run_id}} |
| sample_id | [copy from runs/{{run_id}}/run-profile.yaml#sample_id] |
| mode | {{mode}} |
| output_root | {{output_root}} |
| step | RS-10 |
| prompt | prompts/rs/10-finding-recommendation-write.prompt.md |
| skill | skills/rs/SK-FINDING-CLASSIFY.md |
| owning_pra | PRA-07-FINDING-RECOMMENDER |
```

## 5. Required Sections

1. **Header**
2. **Finding Rows** — one row per finding:

   | finding_id | source_fact_refs | finding_statement | finding_category | severity | supporting_evidence | confidence | review_status | human_reviewer | notes |
   |---|---|---|---|---|---|---|---|---|---|

   - `finding_category` uses `<value-from-catalogs/review/finding-category-catalog.yaml>`.
   - `severity` uses `<value-from-catalogs/review/severity-catalog.yaml>`.
   - `confidence` uses `<value-from-catalogs/data-protection/confidence-level-catalog.yaml>`.
   - `review_status` uses `<value-from-catalogs/review/review-status-catalog.yaml>`.
   - `source_fact_refs` records artifact paths and row IDs in prior outputs.
   - `supporting_evidence` records the visible facts that support the finding (no inference beyond the cited rows).

3. **Unknowns** — findings whose severity or category cannot be resolved without a specific missing fact.
4. **Human Review Gate Status** — gate disposition for the file as a whole.
5. **Stop Conditions Recorded**.

## 6. Prohibited Content

- Severity computation inside the template (the skill + human review own selection).
- Recommendation prose (that lives in `14-recommendations.md`).
- Blueprint match decisions or AI Action Level changes.
- Approval, sign-off, or implementation-proof claims.
- Enumerating catalog values inside the template.

## 7. Source Reference

`aisraf-sas-prototype-skill-chain-pack-v0.01/templates/finding-register-template.md` (column shape reused).

## 8. Version Notes

Rebuilt for v0.1.2; catalog values referenced by path only (founder Q3).
