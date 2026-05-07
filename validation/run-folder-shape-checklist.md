# Run Folder Shape Checklist

Authored by: BUILD-AG-11-RUNS-R1.

Scope: pins the canonical layout for `runs/<run_id>/` folders in AISRAF SAS Prototype v0.1.2. Build Package 11 establishes this contract; every later run must follow it.

## 1. Allowed Top-Level Files Under `runs/`

- `runs/README.md` — root README describing the run-folder shape (active, owned by Build Package 11).

No other files are allowed at `runs/` root. JSON, YAML, executable scripts, release artefacts, diagrams, and DOCX/PDF/PPTX/ZIP are all forbidden here.

## 2. Allowed Top-Level Folders Under `runs/`

- `runs/RUN-001/` — the first canonical governed run fixture. Build Package 11 builds and validates this folder.
- Any other `runs/RUN-*/` folder is a smoke run produced by `tools/New-AisrafRun.ps1` and must be removed before human git stage (per Build Package 03 cleanup rule and `validation/no-drift-rules.md`). `tools/Test-AisrafPackage.ps1` records each non-RUN-001 folder as WARN.

## 3. Allowed Files Inside `runs/<run_id>/`

A governed run folder contains exactly:

- `README.md` — describes the run scope, posture, and reserved future outputs (required for `RUN-001`; recommended for any future governed run).
- `run-profile.yaml` — Build Package 02 schema-compliant; the run profile resolved against `config/run-profile.template.yaml`.
- `00-run-log.md` — Build Package 09 file-shape compliant; mirrors `templates/output/output-00-run-log-template.md`.
- The 17 RS outputs as `01-input-inventory.md` through `17-accuracy-score.md` (top level), each mirroring `templates/output/output-NN-*-template.md`. Created when the chain executes; NOT created by Build Package 11.
- (Optional after operator-driven post-back) `jira-ticket-draft.md` and/or `confluence-page-draft.md` per `templates/jira/jira-ticket-draft-template.md` / `templates/confluence/confluence-page-draft-template.md`.

No other files are permitted at the run-folder root.

## 4. Allowed Subfolders Inside `runs/<run_id>/`

- `inputs/` — staged inputs for the run. For RUN-001 this is byte-copies of `samples/sample-001-dfd-crop/inputs/` (the 6 sample files).
- `dfd/` — DFD subskill outputs as `dfd/dfd-01-intake-quality-check.md` through `dfd/dfd-09-extraction-summary.md`. Build Package 11 reserves `runs/RUN-001/dfd/` empty; the 9 outputs are produced when the operator executes the DFD subskill chain.

No other subfolders are permitted under a governed run folder.

## 5. RUN-001 Concrete Surface

### Files

- `runs/RUN-001/README.md`
- `runs/RUN-001/run-profile.yaml`
- `runs/RUN-001/00-run-log.md`

### Subfolders

- `runs/RUN-001/inputs/` containing exactly 6 byte-copies:
  - `dfd-crop.png`
  - `dfd-crop.mmd`
  - `dfd-legend-excerpt.md`
  - `cloud-triage-notes.md`
  - `review-transcript.md`
  - `intake-ticket.md`
- `runs/RUN-001/dfd/` empty (governed reservation for the 9 DFD subskill outputs).

### Reserved future-output paths (not created by Build Package 11)

| reserved path | mirrors template |
|---|---|
| `runs/RUN-001/01-input-inventory.md` | `templates/output/output-01-input-inventory-template.md` |
| `runs/RUN-001/02-visible-dfd-objects.md` | `templates/output/output-02-visible-dfd-objects-template.md` |
| `runs/RUN-001/03-legend-normalization.md` | `templates/output/output-03-legend-normalization-template.md` |
| `runs/RUN-001/04-components.md` | `templates/output/output-04-components-template.md` |
| `runs/RUN-001/05-flows.md` | `templates/output/output-05-flows-template.md` |
| `runs/RUN-001/06-boundaries.md` | `templates/output/output-06-boundaries-template.md` |
| `runs/RUN-001/07-security-stack-assessment.md` | `templates/output/output-07-security-stack-assessment-template.md` |
| `runs/RUN-001/08-internal-review-table.md` | `templates/output/output-08-internal-review-table-template.md` |
| `runs/RUN-001/09-missing-facts.md` | `templates/output/output-09-missing-facts-template.md` |
| `runs/RUN-001/10-ai-action-level.md` | `templates/output/output-10-ai-action-level-template.md` |
| `runs/RUN-001/11-blueprint-match.md` | `templates/output/output-11-blueprint-match-template.md` |
| `runs/RUN-001/12-targeted-questions.md` | `templates/output/output-12-targeted-questions-template.md` |
| `runs/RUN-001/13-findings.md` | `templates/output/output-13-findings-template.md` |
| `runs/RUN-001/14-recommendations.md` | `templates/output/output-14-recommendations-template.md` |
| `runs/RUN-001/15-handoff-pack.md` | `templates/output/output-15-handoff-pack-template.md` |
| `runs/RUN-001/16-validation-notes.md` | `templates/output/output-16-validation-notes-template.md` |
| `runs/RUN-001/17-accuracy-score.md` | `templates/output/output-17-accuracy-score-template.md` |
| `runs/RUN-001/dfd/dfd-01-intake-quality-check.md` | `templates/output/output-dfd-01-intake-quality-check-template.md` |
| `runs/RUN-001/dfd/dfd-02-boundary-catalog.md` | `templates/output/output-dfd-02-boundary-catalog-template.md` |
| `runs/RUN-001/dfd/dfd-03-component-catalog.md` | `templates/output/output-dfd-03-component-catalog-template.md` |
| `runs/RUN-001/dfd/dfd-04-flow-inventory.md` | `templates/output/output-dfd-04-flow-inventory-template.md` |
| `runs/RUN-001/dfd/dfd-05-annotation-resolution.md` | `templates/output/output-dfd-05-annotation-resolution-template.md` |
| `runs/RUN-001/dfd/dfd-06-boundary-crossings.md` | `templates/output/output-dfd-06-boundary-crossings-template.md` |
| `runs/RUN-001/dfd/dfd-07-control-signals.md` | `templates/output/output-dfd-07-control-signals-template.md` |
| `runs/RUN-001/dfd/dfd-08-confidence-score.md` | `templates/output/output-dfd-08-confidence-score-template.md` |
| `runs/RUN-001/dfd/dfd-09-extraction-summary.md` | `templates/output/output-dfd-09-extraction-summary-template.md` |

## 6. Forbidden Content

- Any file under `runs/<run_id>/` that does not match an entry in §3 or a reserved future-output path in §5.
- Any subfolder under `runs/<run_id>/` other than `inputs/` and `dfd/`.
- Any nested folder beneath `inputs/` (inputs/ is flat).
- Any nested folder beneath `dfd/` (dfd/ is flat).
- DOCX / PDF / PPTX / ZIP / executable / image binary other than the byte-copied `inputs/dfd-crop.png` (which is the visible DFD input).
- Any expected-baseline file. Expected baselines belong only under `samples/<sample_id>/expected/` and are read-only at run time.
- Any file claiming runtime / cloud / ADK / MCP / Jira post-back / Confluence publication / Rovo / database / Terraform execution unless `postback_execution_status: executed_by_operator` plus a matching `templates/run/postback-log-entry-row-template.md` row in `00-run-log.md` exists.
- Any modification to files under `samples/<sample_id>/` from a run.

## 7. Naming Rules

- `run_id` matches `^RUN-[A-Z0-9][A-Z0-9-]*$` (length 5–64) per `config/run-profile.schema.yaml`.
- Top-level RS outputs match `^(0[1-9]|1[0-7])-[a-z0-9-]+\.md$`.
- DFD outputs under `dfd/` match `^dfd-0[1-9]-[a-z0-9-]+\.md$`.
- Input file names match exactly the sample input file names (no rename allowed during copy).

## 8. Folder Discipline

- The run folder is self-contained. All inputs the chain reads should resolve under `input_root` (`runs/<run_id>/inputs/`). Reading directly from `samples/<sample_id>/inputs/` is allowed only when `input_root` itself points there; for governed runs, the convention is to copy.
- All writes resolve under `output_root` (`runs/<run_id>/`). Writes to `config/`, `prompts/`, `skills/`, `prototype-agents/`, `.agents/`, `catalogs/`, `blueprints/`, `templates/`, `samples/`, `diagrams/`, `docs/`, `release/`, `tools/`, or `validation/` from a run are forbidden.
- The old reference workspace (`D:/E-Way 2/aisraf-sas-prototype-skill-chain-pack-v0.01`) must not be written from a run.

## 9. Acceptance

This checklist passes when the actual `runs/RUN-001/` layout matches §3, §4, and §5; no forbidden content from §6 exists; and naming/discipline from §7 and §8 hold. `tools/Test-AisrafPackage.ps1` Check `08i-runs-content-limits` enforces this.
