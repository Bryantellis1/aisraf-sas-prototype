# Sample Baseline Checklist

Authored by: BUILD-AG-10-SAMPLES-R1.

Scope: per-baseline lint for the 26 expected-baseline files under `samples/sample-001-dfd-crop/expected/`. Applies to every Markdown baseline in Build Package 10.

## 1. Per-Baseline Front Matter (Allowed YAML Front Matter Only)

| # | Field | Expected | Status |
|---|---|---|---|
| 1 | `expected_baseline_id` | `EXP-RS-NN-*` for RS baselines; `EXP-DFD-NN-*` for DFD baselines | PASS |
| 2 | `sample_id` | `sample-001-dfd-crop` | PASS |
| 3 | `mirrors_template` | resolves to a file under `templates/output/` | PASS |
| 4 | `prompt` | resolves to a prompt card under `prompts/` | PASS |
| 5 | `skill` | resolves to a skill contract under `skills/` | PASS |
| 6 | `owning_pra` | resolves to a PRA spec under `prototype-agents/` | PASS |
| 7 | `adapter` | resolves to a `.agent.md` adapter under `.agents/` (`aisraf-dfd-extractor.agent.md` for DFD baselines, etc.) | PASS |
| 8 | `target_run_output` | declared `{{output_root}}/...` path matches the mirroring template's `intended_output` | PASS |
| 9 | `expected_outcome` | `PASS_READY_FOR_REVIEW` | PASS |
| 10 | `scoring_basis` | template-aligned qualitative baseline; numeric scoring deferred to Build Package 11 run execution | PASS |
| 11 | `package_version` | `v0.1.2` | PASS |

## 2. Required Sections Mirror The Package 09 Template

For each baseline:

| # | Check | Status |
|---|---|---|
| 12 | The baseline's section headings match the named template's `required_sections` list, in order. | PASS |
| 13 | The baseline carries the file-header table required by the named template. | PASS |
| 14 | The baseline's tables have the exact columns the named template specifies. | PASS |

Per-baseline mapping:

| baseline | mirrors template | required_sections covered |
|---|---|---|
| `expected-01-input-inventory.md` | `output-01-input-inventory-template.md` | Header; Inventory Table; Unknowns; Stop Conditions Recorded |
| `expected-02-visible-dfd-objects.md` | `output-02-visible-dfd-objects-template.md` | Header; Visible Object Table; Unknowns; Stop Conditions Recorded |
| `expected-03-legend-normalization.md` | `output-03-legend-normalization-template.md` | Header; Normalization Table; Unknowns; Stop Conditions Recorded |
| `expected-04-components.md` | `output-04-components-template.md` | Header; Components Table; Unknowns; Stop Conditions Recorded |
| `expected-05-flows.md` | `output-05-flows-template.md` | Header; Flows Table; Unknowns; Stop Conditions Recorded |
| `expected-06-boundaries.md` | `output-06-boundaries-template.md` | Header; Boundary Table; Boundary Crossing Table; Unknowns; Stop Conditions Recorded |
| `expected-07-security-stack-assessment.md` | `output-07-security-stack-assessment-template.md` | Header; Security Stack Marker Table; Identity Markers; Data Protection Markers; Unknowns; Stop Conditions Recorded |
| `expected-08-internal-review-table.md` | `output-08-internal-review-table-template.md` | Header; Review Table Rows; Unknowns; Stop Conditions Recorded |
| `expected-09-missing-facts.md` | `output-09-missing-facts-template.md` | Header; Missing Material Fact Rows; Cross-Reference to Blueprint material_missing_facts; Stop Conditions Recorded |
| `expected-10-ai-action-level.md` | `output-10-ai-action-level-template.md` | Header; Selected AI Action Level; Supporting Evidence; Unknowns; Human Review Gate Status; Stop Conditions Recorded |
| `expected-11-blueprint-match.md` | `output-11-blueprint-match-template.md` | Header; Candidate Blueprint; Match State; Supporting Catalog Evidence; Material Missing Facts; Human Review Gate Status; Stop Conditions Recorded |
| `expected-12-targeted-questions.md` | `output-12-targeted-questions-template.md` | Header; Targeted Question Rows; Stop Conditions Recorded |
| `expected-13-findings.md` | `output-13-findings-template.md` | Header; Finding Rows; Unknowns; Human Review Gate Status; Stop Conditions Recorded |
| `expected-14-recommendations.md` | `output-14-recommendations-template.md` | Header; Recommendation Rows; Unknowns; Human Review Gate Status; Stop Conditions Recorded |
| `expected-15-handoff-pack.md` | `output-15-handoff-pack-template.md` | Header; Review Summary; Scope and Inputs; Flow and Boundary Summary; Findings and Recommendations; Targeted Questions; Material Missing Facts; AI Action Level; Blueprint Match; Human Review Gate Status; Separation From Validation Notes; Stop Conditions Recorded |
| `expected-16-validation-notes.md` | `output-16-validation-notes-template.md` | Header; Validation Note Rows; Separation From Findings/Recommendations; Stop Conditions Recorded |
| `expected-17-accuracy-score.md` | `output-17-accuracy-score-template.md` | Header; Scoring Eligibility Check; Per-Output Comparison Table; Critical Miss Status; Qualitative Score / Verdict; Stop Conditions Recorded |
| `expected-dfd-01-intake-quality-check.md` | `output-dfd-01-intake-quality-check-template.md` | Header; Intake Quality Findings; Material Gaps; Stop Conditions Recorded |
| `expected-dfd-02-boundary-catalog.md` | `output-dfd-02-boundary-catalog-template.md` | Header; Boundary Catalog Rows; Unknowns; Stop Conditions Recorded |
| `expected-dfd-03-component-catalog.md` | `output-dfd-03-component-catalog-template.md` | Header; Component Catalog Rows; Unknowns; Stop Conditions Recorded |
| `expected-dfd-04-flow-inventory.md` | `output-dfd-04-flow-inventory-template.md` | Header; Raw Flow Inventory; Normalized Flow Table; Unknowns; Stop Conditions Recorded |
| `expected-dfd-05-annotation-resolution.md` | `output-dfd-05-annotation-resolution-template.md` | Header; Resolved Annotations; Unresolved Annotations; Stop Conditions Recorded |
| `expected-dfd-06-boundary-crossings.md` | `output-dfd-06-boundary-crossings-template.md` | Header; Boundary Crossing Rows; Unknowns; Stop Conditions Recorded |
| `expected-dfd-07-control-signals.md` | `output-dfd-07-control-signals-template.md` | Header; Control Signal Rows; Unknowns; Stop Conditions Recorded |
| `expected-dfd-08-confidence-score.md` | `output-dfd-08-confidence-score-template.md` | Header; Per-Row Confidence Assignments; Confidence Level Distribution; Stop Conditions Recorded |
| `expected-dfd-09-extraction-summary.md` | `output-dfd-09-extraction-summary-template.md` | Header; Extraction State Summary; Residual Gaps; Cross-Reference to RS Outputs; Stop Conditions Recorded |

## 3. Allowed Placeholders Only

| # | Check | Status |
|---|---|---|
| 15 | Each baseline body uses only the seven approved run-profile placeholders (`{{run_id}}`, `{{input_root}}`, `{{expected_root}}`, `{{output_root}}`, `{{mode}}`, `{{postback_execution_status}}`, `{{output_destination_mode}}`). | PASS |
| 16 | Other run-profile fields (`sample_id`, `source_ticket_url`, `destination_ticket_url`, `destination_confluence_url`, `jira_connector_status`, `confluence_connector_status`, `rovo_mcp_available`, `mcp_execution_status`, `operator_name`, `reviewer_name`, `scoring_enabled`, `expected_baseline_required`) are referenced descriptively as `[copy from runs/{{run_id}}/run-profile.yaml#field_name]`. | PASS |
| 17 | No baseline introduces non-schema variables (`{{catalog_root}}`, `{{prompt_root}}`, `{{skill_root}}`, `{{template_root}}`, `{{diagram_root}}`, `{{validation_root}}`). | PASS |

## 4. Catalog And Blueprint Referencing

| # | Check | Status |
|---|---|---|
| 18 | Catalog values are referenced via `<value-from-catalogs/...>` placeholders only. No baseline enumerates catalog entries inside its body. | PASS |
| 19 | Every catalog file path cited resolves to an existing entry under `catalogs/catalog-registry.yaml#catalogs[]`. | PASS |
| 20 | Every BP-* identifier cited resolves to an existing entry in `blueprints/blueprint-registry.yaml`. | PASS |
| 21 | Every `material_missing_fact` ID cited (e.g., `BP-MODEL-ENDPOINT-CALL-MMF-03`) resolves in the named blueprint's `material_missing_facts[]`. | PASS |
| 22 | The four-state match model `matched / candidate / no_match / unknown` is used in `expected-11-blueprint-match.md`. No new state is introduced. | PASS |
| 23 | The `C4P` token is recorded under `DC-C5P` raw_pattern with a CL-MEDIUM confidence note. No new catalog entry is introduced. | PASS |

## 5. Synthetic-Data Safety

| # | Check | Status |
|---|---|---|
| 24 | No real PII / PAN / SSN / PHI in any baseline. | PASS |
| 25 | No real secrets / credentials in any baseline. | PASS |
| 26 | No real production endpoints, vendor commercial product names asserted as mandatory, or real ticket URLs in any baseline. | PASS |

## 6. No Forbidden Claims

| # | Check | Status |
|---|---|---|
| 27 | No baseline claims runtime / cloud / ADK / Vertex / GCP / MCP / Jira post-back / Confluence publication / Rovo / database / Terraform execution. | PASS |
| 28 | No baseline asserts `executed_by_operator`. | PASS |
| 29 | No baseline computes severity, finding category, AI Action Level, blueprint match, or accuracy score inside the body. The selection lives in the named skill plus human review; the baseline records the outcome only. | PASS |
| 30 | No baseline produces a numeric `qualitative_score`. `expected-17-accuracy-score.md` records the `PASS_READY_FOR_REVIEW` qualitative verdict and explicitly defers numeric scoring to Build Package 11. | PASS |
| 31 | No baseline modifies `{{expected_root}}` (baselines under `samples/sample-001-dfd-crop/expected/` are read-only at run time). | PASS |
| 32 | No baseline lowers `expected_score_threshold` to force a pass. | PASS |
| 33 | No baseline invents owners, controls, or evidence. Owners remain `unknown` honestly when not named in the inputs. | PASS |
| 34 | No baseline mixes implementation-validation evidence into `expected-15-handoff-pack.md`; that material lives in `expected-16-validation-notes.md`. | PASS |

## 7. Critical-Miss Vocabulary

`expected-17-accuracy-score.md` records the 12-category critical-miss vocabulary that aligns to the Package 04 prompt cards' critical-miss list. None are flagged for sample-001.

| # | Check | Status |
|---|---|---|
| 35 | Critical-miss vocabulary appears in `expected-17-accuracy-score.md` § Critical Miss Status. | PASS |
| 36 | No critical miss is flagged for sample-001 in the baseline (status `none`). | PASS |

## 8. Sealed Upstream

| # | Check | Status |
|---|---|---|
| 37 | No baseline modifies `prompts/`, `skills/`, `prototype-agents/`, `.agents/`, `catalogs/`, `blueprints/`, `templates/`, or `config/`. | PASS |
| 38 | No baseline modifies the old reference workspace. | PASS |

## 9. Acceptance Verdict

A baseline passes when every row above reads PASS for that baseline. Build Package 10 baselines (26 of 26) pass per this checklist.
