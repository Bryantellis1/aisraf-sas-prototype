# Template: DFD Confidence Score Output Shape

## 1. Template Metadata

| field | value |
|---|---|
| template_id | TPL-OUT-DFD-08-CONFIDENCE-SCORE |
| template_name | DFD Confidence Score Output Shape |
| owning_build_package | Build Package 09 |
| status | active |
| purpose | Define the file-level shape of `{{output_root}}/dfd/08-confidence-score.md`, written by PR-DFD-09 / SK-DFD-08-CONFIDENCE-SCORE / PRA-03. This is per-row extraction confidence; not the accuracy score (which lives in `17-accuracy-score.md`). |
| intended_output | `{{output_root}}/dfd/08-confidence-score.md` |
| consumers | Prompts: PR-DFD-09. Skills: SK-DFD-08-CONFIDENCE-SCORE. PRAs: PRA-03-DFD-EXTRACTOR. Adapters: aisraf-dfd-extractor. Catalogs: catalogs/data-protection/confidence-level-catalog.yaml. |
| inputs_expected | `runs/{{run_id}}/run-profile.yaml`; all DFD outputs 02-07 |
| placeholders | `{{run_id}}`, `{{input_root}}`, `{{output_root}}`, `{{mode}}`, `{{postback_execution_status}}`, `{{output_destination_mode}}` |
| required_sections | Header; Per-Row Confidence Assignments; Confidence Level Distribution; Stop Conditions Recorded |
| prohibited_content | accuracy score claim; scoring outside SK-ACCURACY-SCORE; controlled-value enumeration; severity / finding / recommendation prose |
| output_boundary | under_resolved_output_root_dfd_subfolder_only |
| source_reference | New for v0.1.2 |
| version_notes | New for v0.1.2; explicit "not an accuracy score" disclaimer. |

## 2. Output Boundary

This template defines output shape only. Confidence levels are assigned per-row using the cross-cutting confidence catalog. This file is **not** an accuracy score; only `SK-ACCURACY-SCORE` and `17-accuracy-score.md` produce an accuracy score, and only when the run profile permits it.

## 3. Allowed Placeholders

Only the seven approved run-profile variables. Other run-profile fields are referenced descriptively.

## 4. File Header

```markdown
# DFD Confidence Score — {{run_id}}

| field | value |
|---|---|
| run_id | {{run_id}} |
| sample_id | [copy from runs/{{run_id}}/run-profile.yaml#sample_id] |
| mode | {{mode}} |
| output_root | {{output_root}} |
| dfd_step | DFD-08 |
| prompt | prompts/dfd/09-confidence-score.prompt.md |
| skill | skills/dfd/SK-DFD-08-CONFIDENCE-SCORE.md |
| owning_pra | PRA-03-DFD-EXTRACTOR |
| disclaimer | This is a per-row extraction confidence assignment. It is not an accuracy score. |
```

## 5. Required Sections

1. **Header**
2. **Per-Row Confidence Assignments** — table:

   | row_id | source_artifact | confidence | reason | notes |
   |---|---|---|---|---|

   `source_artifact` is one of `02-boundary-catalog.md` through `07-control-signals.md`. `confidence` uses `<value-from-catalogs/data-protection/confidence-level-catalog.yaml>`.

3. **Confidence Level Distribution** — count of rows per confidence value, by source artifact (descriptive only; no aggregate score).
4. **Stop Conditions Recorded**.

## 6. Prohibited Content

- Producing an accuracy score, qualitative_score, or any aggregate verdict.
- Severity, finding, or recommendation prose.
- Enumerated catalog values.

## 7. Source Reference

New for v0.1.2.

## 8. Version Notes

New for v0.1.2.
