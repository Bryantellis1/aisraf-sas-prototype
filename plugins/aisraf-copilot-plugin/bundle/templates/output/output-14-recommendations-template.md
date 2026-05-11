# Template: Recommendations Output Shape

## 1. Template Metadata

| field | value |
|---|---|
| template_id | TPL-OUT-14-RECOMMENDATIONS |
| template_name | Recommendations Output Shape |
| owning_build_package | Build Package 09 |
| status | active |
| purpose | Define the file-level shape of `{{output_root}}/14-recommendations.md`, written by PR-RS-10 / SK-RECOMMENDATION-WRITE / PRA-07. |
| intended_output | `{{output_root}}/14-recommendations.md` |
| consumers | Prompts: PR-RS-10. Skills: SK-RECOMMENDATION-WRITE. PRAs: PRA-07-FINDING-RECOMMENDER. Adapters: aisraf-finding-recommender. Catalogs: catalogs/review/recommendation-type-catalog.yaml; review-status-catalog.yaml; catalogs/data-protection/confidence-level-catalog.yaml. |
| inputs_expected | `runs/{{run_id}}/run-profile.yaml`; `{{output_root}}/13-findings.md` |
| placeholders | `{{run_id}}`, `{{input_root}}`, `{{output_root}}`, `{{mode}}`, `{{postback_execution_status}}`, `{{output_destination_mode}}` |
| required_sections | Header; Recommendation Rows; Unknowns; Human Review Gate Status; Stop Conditions Recorded |
| prohibited_content | recommendation prose invented inside the template; controlled-value enumeration; owner invention; evidence invention; implementation-proof claim; approval claim |
| output_boundary | under_resolved_output_root_only |
| source_reference | aisraf-sas-prototype-skill-chain-pack-v0.01/templates/recommendation-template.md (column shape reused; rebuilt for v0.1.2) |
| version_notes | Rebuilt for v0.1.2; recommendation-rule-template from v0.01 rejected because catalogs/review/recommendation-type-catalog.yaml owns the taxonomy. |

## 2. Output Boundary

This template defines output shape only. Each recommendation must trace to a finding in `13-findings.md`. The recommendation type comes from the catalog; the recommendation statement names the supported concern and the next action without inventing controls, owners, or evidence.

## 3. Allowed Placeholders

Only the seven approved run-profile variables. Other run-profile fields are referenced descriptively.

## 4. File Header

```markdown
# Recommendations — {{run_id}}

| field | value |
|---|---|
| run_id | {{run_id}} |
| sample_id | [copy from runs/{{run_id}}/run-profile.yaml#sample_id] |
| mode | {{mode}} |
| output_root | {{output_root}} |
| step | RS-10 |
| prompt | prompts/rs/10-finding-recommendation-write.prompt.md |
| skill | skills/rs/SK-RECOMMENDATION-WRITE.md |
| owning_pra | PRA-07-FINDING-RECOMMENDER |
```

## 5. Required Sections

1. **Header**
2. **Recommendation Rows** — one row per recommendation:

   | recommendation_id | source_finding_id | recommendation_type | recommendation_statement | supporting_concern | expected_next_action | owner_or_route_if_known | confidence | review_status | unknown_fields | notes |
   |---|---|---|---|---|---|---|---|---|---|---|

   - `recommendation_type` uses `<value-from-catalogs/review/recommendation-type-catalog.yaml>`.
   - `confidence` uses `<value-from-catalogs/data-protection/confidence-level-catalog.yaml>`.
   - `review_status` uses `<value-from-catalogs/review/review-status-catalog.yaml>`.
   - `source_finding_id` references a row in `13-findings.md`. Every recommendation must trace to a finding.
   - `owner_or_route_if_known` records what is visibly known. Unknown owners remain `unknown` and may route to validation notes.

3. **Unknowns** — recommendations with unresolved owner/route/evidence fields.
4. **Human Review Gate Status**.
5. **Stop Conditions Recorded**.

## 6. Prohibited Content

- Inventing controls, evidence, or owners not supported by `13-findings.md` or visible facts.
- Implementation-proof claims (a recommendation is a recommendation, not a sign-off).
- Severity, score, AI Action Level, or blueprint-match computation.
- Enumerating catalog values inside the template.

## 7. Source Reference

`aisraf-sas-prototype-skill-chain-pack-v0.01/templates/recommendation-template.md` (column shape reused).

## 8. Version Notes

Rebuilt for v0.1.2.
