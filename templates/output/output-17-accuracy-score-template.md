# Template: Accuracy Score Output Shape

## 1. Template Metadata

| field | value |
|---|---|
| template_id | TPL-OUT-17-ACCURACY-SCORE |
| template_name | Accuracy Score Output Shape |
| owning_build_package | Build Package 09 |
| status | active |
| purpose | Define the file-level shape of `{{output_root}}/17-accuracy-score.md`, written by PR-RS-13 / SK-ACCURACY-SCORE / PRA-08. Conditional output produced only when `scoring_enabled: true`, `expected_baseline_required: true`, and `{{expected_root}}` is non-empty. |
| intended_output | `{{output_root}}/17-accuracy-score.md` |
| consumers | Prompts: PR-RS-13. Skills: SK-ACCURACY-SCORE. PRAs: PRA-08-HANDOFF-QA-SCORER. Adapters: aisraf-handoff-qa-scorer. Catalogs: catalogs/review/review-status-catalog.yaml; catalogs/data-protection/confidence-level-catalog.yaml. |
| inputs_expected | `runs/{{run_id}}/run-profile.yaml`; `{{expected_root}}/`; every `{{output_root}}/01-..17-*.md` excluding 17 itself |
| placeholders | `{{run_id}}`, `{{input_root}}`, `{{expected_root}}`, `{{output_root}}`, `{{mode}}`, `{{postback_execution_status}}`, `{{output_destination_mode}}` |
| required_sections | Header; Scoring Eligibility Check; Per-Output Comparison Table; Critical Miss Status; Qualitative Score / Verdict; Stop Conditions Recorded |
| prohibited_content | scoring outside SK-ACCURACY-SCORE; baseline modification under expected_root; severity / finding / recommendation prose; controlled-value enumeration; lowering expected_score_threshold to force a pass |
| output_boundary | under_resolved_output_root_only |
| source_reference | aisraf-sas-prototype-skill-chain-pack-v0.01/templates/accuracy-score-template.md (rebuilt; v0.01 was a stub) |
| version_notes | Rebuilt for v0.1.2. |

## 2. Output Boundary

This template defines output shape only. Scoring eligibility is gated on the schema fields above. The skill performs the comparison; this template records the result. Baselines under `{{expected_root}}` are read-only.

## 3. Allowed Placeholders

The seven approved run-profile variables. `{{expected_root}}` is always read-only. Other run-profile fields are referenced descriptively.

## 4. File Header

```markdown
# Accuracy Score — {{run_id}}

| field | value |
|---|---|
| run_id | {{run_id}} |
| sample_id | [copy from runs/{{run_id}}/run-profile.yaml#sample_id] |
| mode | {{mode}} |
| expected_root | {{expected_root}} |
| output_root | {{output_root}} |
| step | RS-13 |
| prompt | prompts/rs/13-accuracy-score.prompt.md |
| skill | skills/rs/SK-ACCURACY-SCORE.md |
| owning_pra | PRA-08-HANDOFF-QA-SCORER |
```

## 5. Required Sections

1. **Header**
2. **Scoring Eligibility Check**

   | gate | value |
   |---|---|
   | scoring_enabled | [copy from runs/{{run_id}}/run-profile.yaml#scoring_enabled] |
   | expected_baseline_required | [copy from runs/{{run_id}}/run-profile.yaml#expected_baseline_required] |
   | expected_root_populated | true / false |
   | scoring_runs | true / false |

   If `scoring_runs` is false, the rest of the file records that scoring did not apply for this run, with the reason; no per-output comparison rows are produced.

3. **Per-Output Comparison Table** — one row per scored output:

   | output_artifact | baseline_artifact | comparison_result | unknowns_at_extract_time | confidence | notes |
   |---|---|---|---|---|---|

   `comparison_result` is `match`, `partial_match`, `mismatch`, `unknown`. `confidence` uses `<value-from-catalogs/data-protection/confidence-level-catalog.yaml>`.

4. **Critical Miss Status** — `none` or `flagged` with description. A flagged critical miss stops the run.
5. **Qualitative Score / Verdict** — single sentence verdict line; the underlying numeric score (if any) lives in the skill's calculation, not in the template body.
6. **Stop Conditions Recorded**.

## 6. Prohibited Content

- Modifying baselines under `{{expected_root}}`.
- Producing a `qualitative_score` outside `SK-ACCURACY-SCORE`.
- Lowering `expected_score_threshold` to force a pass verdict.
- Severity, finding, or recommendation prose.
- Enumerated catalog values.

## 7. Source Reference

`aisraf-sas-prototype-skill-chain-pack-v0.01/templates/accuracy-score-template.md` (rebuilt; v0.01 was a stub).

## 8. Version Notes

Rebuilt for v0.1.2.
