# Template: DFD Extraction Summary Output Shape

## 1. Template Metadata

| field | value |
|---|---|
| template_id | TPL-OUT-DFD-09-EXTRACTION-SUMMARY |
| template_name | DFD Extraction Summary Output Shape |
| owning_build_package | Build Package 09 |
| status | active |
| purpose | Define the file-level shape of `{{output_root}}/dfd/09-extraction-summary.md`, written by PR-DFD-10 / SK-DFD-09-EXTRACTION-SUMMARIZE / PRA-03. |
| intended_output | `{{output_root}}/dfd/09-extraction-summary.md` |
| consumers | Prompts: PR-DFD-10. Skills: SK-DFD-09-EXTRACTION-SUMMARIZE. PRAs: PRA-03-DFD-EXTRACTOR. Adapters: aisraf-dfd-extractor. Catalogs: catalogs/data-protection/confidence-level-catalog.yaml. |
| inputs_expected | `runs/{{run_id}}/run-profile.yaml`; all DFD outputs 01-08 |
| placeholders | `{{run_id}}`, `{{input_root}}`, `{{output_root}}`, `{{mode}}`, `{{postback_execution_status}}`, `{{output_destination_mode}}` |
| required_sections | Header; Extraction State Summary; Residual Gaps; Cross-Reference to RS Outputs; Stop Conditions Recorded |
| prohibited_content | accuracy score claim; scoring outside SK-ACCURACY-SCORE; controlled-value enumeration; severity / finding / recommendation prose |
| output_boundary | under_resolved_output_root_dfd_subfolder_only |
| source_reference | New for v0.1.2 |
| version_notes | New for v0.1.2. |

## 2. Output Boundary

This template defines output shape only. It summarizes the DFD extraction state and residual gaps so the RS chain can consume the DFD output. It does not assert an accuracy score and does not classify findings.

## 3. Allowed Placeholders

Only the seven approved run-profile variables. Other run-profile fields are referenced descriptively.

## 4. File Header

```markdown
# DFD Extraction Summary — {{run_id}}

| field | value |
|---|---|
| run_id | {{run_id}} |
| sample_id | [copy from runs/{{run_id}}/run-profile.yaml#sample_id] |
| mode | {{mode}} |
| output_root | {{output_root}} |
| dfd_step | DFD-09 |
| prompt | prompts/dfd/10-dfd-extraction-summarize.prompt.md |
| skill | skills/dfd/SK-DFD-09-EXTRACTION-SUMMARIZE.md |
| owning_pra | PRA-03-DFD-EXTRACTOR |
| disclaimer | DFD extraction summary; not an accuracy score. |
```

## 5. Required Sections

1. **Header**
2. **Extraction State Summary** — narrative paragraph describing what the DFD chain extracted, counts per artifact, and overall confidence band (descriptive only).
3. **Residual Gaps** — rows that remain `unknown` after DFD-01..08. Cross-reference each to the artifact that holds the unknown.
4. **Cross-Reference to RS Outputs** — pointer to the RS-side outputs the DFD chain feeds: `04-components.md`, `05-flows.md`, `06-boundaries.md`, `07-security-stack-assessment.md`.
5. **Stop Conditions Recorded**.

## 6. Prohibited Content

- Producing an accuracy score, qualitative_score, or aggregate verdict.
- Severity, finding, or recommendation prose.
- Enumerated catalog values.

## 7. Source Reference

New for v0.1.2.

## 8. Version Notes

New for v0.1.2.
