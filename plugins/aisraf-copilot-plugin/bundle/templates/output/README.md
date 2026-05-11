# templates/output/

Owning Build Package: Build Package 09 — Templates.

## Purpose

File-shape templates that match the canonical run-output paths declared by `prompts/prompt-registry.yaml`. Each template here defines the structure of one Markdown file under `{{output_root}}/` or `{{output_root}}/dfd/`. Templates define output shape only — they do not execute the review and do not compute severity, score, AI Action Level, or blueprint match.

## Inventory

27 file-shape templates: 18 RS (00 through 17) + 9 DFD (01 through 09).

### RS chain (18 templates)

| template file | shapes output | primary prompt | primary skill | owning PRA |
|---|---|---|---|---|
| `output-00-run-log-template.md` | `{{output_root}}/00-run-log.md` | (file shape; rows are appended via `templates/run/`) | (n/a) | PRA-01-SAS-REVIEW-ORCHESTRATOR |
| `output-01-input-inventory-template.md` | `{{output_root}}/01-input-inventory.md` | PR-RS-01 | SK-INPUT-PACKAGE-READ | PRA-02-INPUT-READER |
| `output-02-visible-dfd-objects-template.md` | `{{output_root}}/02-visible-dfd-objects.md` | PR-RS-02 | SK-DFD-VISUAL-READ | PRA-03-DFD-EXTRACTOR |
| `output-03-legend-normalization-template.md` | `{{output_root}}/03-legend-normalization.md` | PR-RS-03 | SK-LEGEND-NORMALIZE | PRA-04-LEGEND-NORMALIZER |
| `output-04-components-template.md` | `{{output_root}}/04-components.md` | PR-RS-04 | SK-COMPONENT-EXTRACT | PRA-03-DFD-EXTRACTOR |
| `output-05-flows-template.md` | `{{output_root}}/05-flows.md` | PR-RS-04 | SK-FLOW-EXTRACT | PRA-03-DFD-EXTRACTOR |
| `output-06-boundaries-template.md` | `{{output_root}}/06-boundaries.md` | PR-RS-05 | SK-BOUNDARY-CROSSING-DETECT | PRA-05-REVIEW-TABLE-BUILDER |
| `output-07-security-stack-assessment-template.md` | `{{output_root}}/07-security-stack-assessment.md` | PR-RS-05 | SK-SECURITY-STACK-ASSESS | PRA-05-REVIEW-TABLE-BUILDER |
| `output-08-internal-review-table-template.md` | `{{output_root}}/08-internal-review-table.md` | PR-RS-06 | SK-DATA-FLOW-TABLE-BUILD | PRA-05-REVIEW-TABLE-BUILDER |
| `output-09-missing-facts-template.md` | `{{output_root}}/09-missing-facts.md` | PR-RS-07 | SK-MISSING-FACT-IDENTIFY | PRA-06-BLUEPRINT-QUESTIONER |
| `output-10-ai-action-level-template.md` | `{{output_root}}/10-ai-action-level.md` | PR-RS-08 | SK-AI-ACTION-LEVEL-CLASSIFY | PRA-06-BLUEPRINT-QUESTIONER |
| `output-11-blueprint-match-template.md` | `{{output_root}}/11-blueprint-match.md` | PR-RS-09 | SK-REVIEW-BLUEPRINT-MATCH | PRA-06-BLUEPRINT-QUESTIONER |
| `output-12-targeted-questions-template.md` | `{{output_root}}/12-targeted-questions.md` | PR-RS-07 | SK-TARGETED-QUESTION-GENERATE | PRA-06-BLUEPRINT-QUESTIONER |
| `output-13-findings-template.md` | `{{output_root}}/13-findings.md` | PR-RS-10 | SK-FINDING-CLASSIFY | PRA-07-FINDING-RECOMMENDER |
| `output-14-recommendations-template.md` | `{{output_root}}/14-recommendations.md` | PR-RS-10 | SK-RECOMMENDATION-WRITE | PRA-07-FINDING-RECOMMENDER |
| `output-15-handoff-pack-template.md` | `{{output_root}}/15-handoff-pack.md` | PR-RS-11 | SK-HANDOFF-PACK-BUILD | PRA-08-HANDOFF-QA-SCORER |
| `output-16-validation-notes-template.md` | `{{output_root}}/16-validation-notes.md` | PR-RS-12 | SK-VALIDATION-NOTE-WRITE | PRA-08-HANDOFF-QA-SCORER |
| `output-17-accuracy-score-template.md` | `{{output_root}}/17-accuracy-score.md` | PR-RS-13 | SK-ACCURACY-SCORE | PRA-08-HANDOFF-QA-SCORER |

### DFD subskill chain (9 templates)

| template file | shapes output | primary prompt | primary skill | owning PRA |
|---|---|---|---|---|
| `output-dfd-01-intake-quality-check-template.md` | `{{output_root}}/dfd/01-intake-quality-check.md` | PR-DFD-02 | SK-DFD-01-INTAKE-QUALITY-CHECK | PRA-03-DFD-EXTRACTOR |
| `output-dfd-02-boundary-catalog-template.md` | `{{output_root}}/dfd/02-boundary-catalog.md` | PR-DFD-03 | SK-DFD-02-BOUNDARY-EXTRACT | PRA-03-DFD-EXTRACTOR |
| `output-dfd-03-component-catalog-template.md` | `{{output_root}}/dfd/03-component-catalog.md` | PR-DFD-04 | SK-DFD-03-COMPONENT-EXTRACT | PRA-03-DFD-EXTRACTOR |
| `output-dfd-04-flow-inventory-template.md` | `{{output_root}}/dfd/04-flow-inventory.md` | PR-DFD-05 | SK-DFD-04-FLOW-EXTRACT | PRA-03-DFD-EXTRACTOR |
| `output-dfd-05-annotation-resolution-template.md` | `{{output_root}}/dfd/05-annotation-resolution.md` | PR-DFD-06 | SK-DFD-05-ANNOTATION-RESOLVE | PRA-03-DFD-EXTRACTOR |
| `output-dfd-06-boundary-crossings-template.md` | `{{output_root}}/dfd/06-boundary-crossings.md` | PR-DFD-07 | SK-DFD-06-BOUNDARY-CROSSING-DETECT | PRA-03-DFD-EXTRACTOR |
| `output-dfd-07-control-signals-template.md` | `{{output_root}}/dfd/07-control-signals.md` | PR-DFD-08 | SK-DFD-07-CONTROL-SIGNAL-DETECT | PRA-03-DFD-EXTRACTOR |
| `output-dfd-08-confidence-score-template.md` | `{{output_root}}/dfd/08-confidence-score.md` | PR-DFD-09 | SK-DFD-08-CONFIDENCE-SCORE | PRA-03-DFD-EXTRACTOR |
| `output-dfd-09-extraction-summary-template.md` | `{{output_root}}/dfd/09-extraction-summary.md` | PR-DFD-10 | SK-DFD-09-EXTRACTION-SUMMARIZE | PRA-03-DFD-EXTRACTOR |

## Naming Convention

`output-NN-name-template.md` (or `output-dfd-NN-name-template.md`). The `output-` prefix and `-template.md` suffix make the template file distinct from the generated `runs/<run_id>/<output_root>/NN-name.md` artifact (founder decision Q4).

## Boundary

Every template directs writes only under `{{output_root}}` (or `{{output_root}}/dfd/`). No template instructs a write to any other folder, hardcodes a `run_id`/`sample_id`/path/URL, computes severity/score/AI Action Level/blueprint match, invents finding facts or recommendation prose, or claims runtime/cloud/MCP/Jira/Confluence/Rovo/ADK/database/Terraform execution.
