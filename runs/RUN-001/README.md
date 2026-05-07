# RUN-001 — first governed run fixture

Owning Build Package: Build Package 11 — Runs and execution evidence model.

Run class: **first canonical governed fixture** for `sample-001-dfd-crop` (AI SaaS Security Review Portal).

> **Synthetic-data guarantee.** All staged inputs under `inputs/` are byte-copies of the synthetic inputs at [samples/sample-001-dfd-crop/inputs/](../../samples/sample-001-dfd-crop/inputs/). No real PII, PAN, SSN, PHI, customer identifiers, internal employee identifiers, secrets, credentials, or production endpoints appear here, and none must be added.

## 1. What This Fixture Is

RUN-001 is the v0.1.2 reference run folder. It establishes the run-evidence model that every later run must follow:

- a Build Package 02 schema-compliant `run-profile.yaml`,
- a Build Package 09 file-shape-compliant `00-run-log.md`,
- a self-contained `inputs/` copy of the sample inputs,
- a governed `dfd/` folder reserved for the 9 DFD subskill outputs,
- a top-level surface reserved for the 17 RS outputs.

Build Package 11 does **not** execute the chain. The 26 future outputs (17 RS + 9 DFD) are reserved paths only; they are produced when the operator runs the prompts/skills/PRAs against `inputs/` and `expected_root`.

## 2. Run Profile Posture

Recorded in [run-profile.yaml](run-profile.yaml):

| field | value |
|---|---|
| run_id | RUN-001 |
| sample_id | sample-001-dfd-crop |
| mode | folder_first_test |
| input_root | runs/RUN-001/inputs |
| expected_root | samples/sample-001-dfd-crop/expected |
| output_root | runs/RUN-001 |
| output_destination_mode | local_only |
| postback_execution_status | deferred |
| jira_connector_status | not_required |
| confluence_connector_status | not_required |
| mcp_execution_status | not_required |
| rovo_mcp_available | false |
| sensitive_data_confirmed_redacted | true |
| expected_baseline_required | true |
| scoring_enabled | true |

`folder_first_test` pins the integration surface to safe defaults via `config/run-profile.schema.yaml#allOf`; no Jira / Confluence / Rovo / MCP / external execution is claimed.

## 3. Folder Shape

```
runs/RUN-001/
├── README.md                  (this file)
├── run-profile.yaml           (Package 02 schema-compliant)
├── 00-run-log.md              (Package 09 file-shape compliant; rows empty)
├── inputs/                    (6 byte-copies of sample-001 inputs)
│   ├── dfd-crop.png
│   ├── dfd-crop.mmd
│   ├── dfd-legend-excerpt.md
│   ├── cloud-triage-notes.md
│   ├── review-transcript.md
│   └── intake-ticket.md
└── dfd/                       (empty governed folder; reserved for 9 DFD outputs)
```

## 4. Inputs (6, byte-copied)

| input | source | role |
|---|---|---|
| `inputs/dfd-crop.png` | [samples/sample-001-dfd-crop/inputs/dfd-crop.png](../../samples/sample-001-dfd-crop/inputs/dfd-crop.png) | Visible DFD; copy used as the run input. |
| `inputs/dfd-crop.mmd` | [samples/sample-001-dfd-crop/inputs/dfd-crop.mmd](../../samples/sample-001-dfd-crop/inputs/dfd-crop.mmd) | Mermaid source for reproducibility. |
| `inputs/dfd-legend-excerpt.md` | [samples/sample-001-dfd-crop/inputs/dfd-legend-excerpt.md](../../samples/sample-001-dfd-crop/inputs/dfd-legend-excerpt.md) | Legend tokens with normalization paths. |
| `inputs/cloud-triage-notes.md` | [samples/sample-001-dfd-crop/inputs/cloud-triage-notes.md](../../samples/sample-001-dfd-crop/inputs/cloud-triage-notes.md) | Component, AAL, boundary, and uncertainty narrative. |
| `inputs/review-transcript.md` | [samples/sample-001-dfd-crop/inputs/review-transcript.md](../../samples/sample-001-dfd-crop/inputs/review-transcript.md) | Synthetic review-call transcript with role labels only. |
| `inputs/intake-ticket.md` | [samples/sample-001-dfd-crop/inputs/intake-ticket.md](../../samples/sample-001-dfd-crop/inputs/intake-ticket.md) | Synthetic intake ticket; scope and pass criteria. |

## 5. Reserved Future Outputs (NOT created by Build Package 11)

When the operator executes the chain, the following 26 artefacts will land under `output_root`. Build Package 11 does **not** create them; they appear only after a Build Package 04–09 chain execution.

### Reserved 17 RS outputs (top level of `runs/RUN-001/`)

| # | reserved future path | mirrors template |
|---|---|---|
| 1 | `01-input-inventory.md` | [templates/output/output-01-input-inventory-template.md](../../templates/output/output-01-input-inventory-template.md) |
| 2 | `02-visible-dfd-objects.md` | [templates/output/output-02-visible-dfd-objects-template.md](../../templates/output/output-02-visible-dfd-objects-template.md) |
| 3 | `03-legend-normalization.md` | [templates/output/output-03-legend-normalization-template.md](../../templates/output/output-03-legend-normalization-template.md) |
| 4 | `04-components.md` | [templates/output/output-04-components-template.md](../../templates/output/output-04-components-template.md) |
| 5 | `05-flows.md` | [templates/output/output-05-flows-template.md](../../templates/output/output-05-flows-template.md) |
| 6 | `06-boundaries.md` | [templates/output/output-06-boundaries-template.md](../../templates/output/output-06-boundaries-template.md) |
| 7 | `07-security-stack-assessment.md` | [templates/output/output-07-security-stack-assessment-template.md](../../templates/output/output-07-security-stack-assessment-template.md) |
| 8 | `08-internal-review-table.md` | [templates/output/output-08-internal-review-table-template.md](../../templates/output/output-08-internal-review-table-template.md) |
| 9 | `09-missing-facts.md` | [templates/output/output-09-missing-facts-template.md](../../templates/output/output-09-missing-facts-template.md) |
| 10 | `10-ai-action-level.md` | [templates/output/output-10-ai-action-level-template.md](../../templates/output/output-10-ai-action-level-template.md) |
| 11 | `11-blueprint-match.md` | [templates/output/output-11-blueprint-match-template.md](../../templates/output/output-11-blueprint-match-template.md) |
| 12 | `12-targeted-questions.md` | [templates/output/output-12-targeted-questions-template.md](../../templates/output/output-12-targeted-questions-template.md) |
| 13 | `13-findings.md` | [templates/output/output-13-findings-template.md](../../templates/output/output-13-findings-template.md) |
| 14 | `14-recommendations.md` | [templates/output/output-14-recommendations-template.md](../../templates/output/output-14-recommendations-template.md) |
| 15 | `15-handoff-pack.md` | [templates/output/output-15-handoff-pack-template.md](../../templates/output/output-15-handoff-pack-template.md) |
| 16 | `16-validation-notes.md` | [templates/output/output-16-validation-notes-template.md](../../templates/output/output-16-validation-notes-template.md) |
| 17 | `17-accuracy-score.md` | [templates/output/output-17-accuracy-score-template.md](../../templates/output/output-17-accuracy-score-template.md) |

### Reserved 9 DFD outputs (under `runs/RUN-001/dfd/`)

| # | reserved future path | mirrors template |
|---|---|---|
| 1 | `dfd/dfd-01-intake-quality-check.md` | [templates/output/output-dfd-01-intake-quality-check-template.md](../../templates/output/output-dfd-01-intake-quality-check-template.md) |
| 2 | `dfd/dfd-02-boundary-catalog.md` | [templates/output/output-dfd-02-boundary-catalog-template.md](../../templates/output/output-dfd-02-boundary-catalog-template.md) |
| 3 | `dfd/dfd-03-component-catalog.md` | [templates/output/output-dfd-03-component-catalog-template.md](../../templates/output/output-dfd-03-component-catalog-template.md) |
| 4 | `dfd/dfd-04-flow-inventory.md` | [templates/output/output-dfd-04-flow-inventory-template.md](../../templates/output/output-dfd-04-flow-inventory-template.md) |
| 5 | `dfd/dfd-05-annotation-resolution.md` | [templates/output/output-dfd-05-annotation-resolution-template.md](../../templates/output/output-dfd-05-annotation-resolution-template.md) |
| 6 | `dfd/dfd-06-boundary-crossings.md` | [templates/output/output-dfd-06-boundary-crossings-template.md](../../templates/output/output-dfd-06-boundary-crossings-template.md) |
| 7 | `dfd/dfd-07-control-signals.md` | [templates/output/output-dfd-07-control-signals-template.md](../../templates/output/output-dfd-07-control-signals-template.md) |
| 8 | `dfd/dfd-08-confidence-score.md` | [templates/output/output-dfd-08-confidence-score-template.md](../../templates/output/output-dfd-08-confidence-score-template.md) |
| 9 | `dfd/dfd-09-extraction-summary.md` | [templates/output/output-dfd-09-extraction-summary-template.md](../../templates/output/output-dfd-09-extraction-summary-template.md) |

`expected/expected-00-run-log.md` is intentionally **not** in the expected baseline set (Package 10 founder decision Q2). The run log is a run artefact owned by Build Package 11; the file shape comes from `templates/output/output-00-run-log-template.md` and the row patterns come from `templates/run/run-log-entry-row-template.md` and `templates/run/postback-log-entry-row-template.md`.

## 6. Comparison And Scoring (When The Chain Executes)

Comparison procedure is recorded in [validation/run-comparison-checklist.md](../../validation/run-comparison-checklist.md):

1. Operator executes the Build Package 04 prompt chain against `input_root` (`runs/RUN-001/inputs/`).
2. Each step writes its output under `output_root` (`runs/RUN-001/`) using the matching `templates/output/output-NN-*-template.md` shape and appends a row to `00-run-log.md` per `templates/run/run-log-entry-row-template.md`.
3. The accuracy step (`prompts/rs/13-accuracy-score.prompt.md` / `skills/rs/SK-ACCURACY-SCORE.md`) compares each `output_root/<NN-name>.md` against the corresponding `expected_root/expected-<NN-name>.md`. Comparison is Markdown-content-aware; sample baselines under `expected_root` are read-only.
4. The run-level qualitative verdict is `PASS_READY_FOR_REVIEW` until numeric scoring lands; the v0.01 `legacy_reference_score` 151/160 is recorded only as reference.
5. Critical misses (per `samples/sample-001-dfd-crop/README.md` § 7) stop the run. They must not be suppressed to achieve a PASS verdict.

## 7. What This Fixture Does Not Prove

- Runtime, cloud, ADK, Vertex/GCP, MCP, Jira post-back, Confluence publication, Rovo execution, database jobs, or Terraform.
- That any prompt, skill, PRA, or adapter has executed. The chain has not run.
- That any of the 17 RS outputs or 9 DFD outputs exist. The 26 paths in § 5 are reserved future paths only.
- A numeric accuracy score. Numeric scoring activates when the operator executes `skills/rs/SK-ACCURACY-SCORE.md`.
- Diagram rendering beyond the local Mermaid PNG used as the sample image.

## 8. Source Reference

Built for AISRAF SAS Prototype v0.1.2 Build Package 11. Conceptually informed by the v0.01 run-folder layout; not bit-copied. The run-profile shape comes from [config/run-profile.template.yaml](../../config/run-profile.template.yaml). The run-log file shape comes from [templates/output/output-00-run-log-template.md](../../templates/output/output-00-run-log-template.md). Per-step and post-back row patterns come from [templates/run/run-log-entry-row-template.md](../../templates/run/run-log-entry-row-template.md) and [templates/run/postback-log-entry-row-template.md](../../templates/run/postback-log-entry-row-template.md). The 6 inputs are byte-copies of the synthetic sample inputs under [samples/sample-001-dfd-crop/inputs/](../../samples/sample-001-dfd-crop/inputs/).
