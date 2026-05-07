# Build Package 11 — Runs Acceptance Checklist

Authored by: BUILD-AG-11-RUNS-R1.

Scope: confirms the Build Package 11 surface for AISRAF SAS Prototype v0.1.2 — the run-evidence model and the first canonical governed run fixture `runs/RUN-001/` for `sample-001-dfd-crop`.

Build Package 11 establishes the run-evidence model. It does not execute the Build Package 04–09 chain, does not create the 17 RS or 9 DFD output files yet, and does not modify sealed upstream packages.

## 1. Surface Inventory

| # | Check | Expected | Status |
|---|---|---|---|
| 1 | `runs/README.md` updated to describe the run-folder shape and point to RUN-001 as the first governed fixture. | present and updated | PASS |
| 2 | `runs/RUN-001/` folder exists. | present | PASS |
| 3 | `runs/RUN-001/README.md` present and documents the run scope, posture, and reserved future outputs. | present | PASS |
| 4 | `runs/RUN-001/run-profile.yaml` present and Build Package 02 schema-compliant. | present | PASS |
| 5 | `runs/RUN-001/00-run-log.md` present and mirrors `templates/output/output-00-run-log-template.md` required sections. | present | PASS |
| 6 | `runs/RUN-001/inputs/` contains exactly 6 byte-copies of the sample-001 inputs. | 6 files | PASS |
| 7 | `runs/RUN-001/dfd/` folder exists and is empty (governed reservation for the 9 DFD subskill outputs). | empty folder | PASS |
| 8 | No `runs/RUN-001/01-input-inventory.md` through `runs/RUN-001/17-accuracy-score.md` exists. The 17 RS outputs are reserved future paths only. | absent | PASS |
| 9 | No `runs/RUN-001/dfd/dfd-01-intake-quality-check.md` through `runs/RUN-001/dfd/dfd-09-extraction-summary.md` exists. The 9 DFD outputs are reserved future paths only. | absent | PASS |
| 10 | No other `runs/RUN-*` folder is committed. Smoke-run folders other than the governed RUN-001 fixture continue to WARN per Build Package 03 cleanup rule. | only RUN-001 | PASS |

## 2. Run-Profile Posture

| # | Check | Expected | Status |
|---|---|---|---|
| 11 | `schema_version` is `run_profile.v0_1_2`. | const | PASS |
| 12 | `package_version` is `v0.1.2`. | const | PASS |
| 13 | `run_id` is `RUN-001` and matches the folder name under `runs/`. | match | PASS |
| 14 | `sample_id` is `sample-001-dfd-crop`. | match | PASS |
| 15 | `mode` is `folder_first_test`. | match | PASS |
| 16 | `input_root` is `runs/RUN-001/inputs`. | match | PASS |
| 17 | `expected_root` is `samples/sample-001-dfd-crop/expected`. | match | PASS |
| 18 | `output_root` is `runs/RUN-001` (forward-slash, no drive letter, no `..`). | match | PASS |
| 19 | `output_destination_mode` is `local_only` (folder_first_test pin). | match | PASS |
| 20 | `postback_execution_status` is `deferred` (folder_first_test pin). | match | PASS |
| 21 | `jira_connector_status`, `confluence_connector_status`, and `mcp_execution_status` are all `not_required`. | match | PASS |
| 22 | `rovo_mcp_available` is `false`. | match | PASS |
| 23 | `source_ticket_url`, `destination_ticket_url`, `destination_confluence_url` are all empty (folder_first_test pin). | empty | PASS |
| 24 | `operator_name` and `reviewer_name` are role labels with no PII. | role labels | PASS |
| 25 | `sensitive_data_confirmed_redacted` is `true` (synthetic sample inputs). | true | PASS |
| 26 | `expected_baseline_required` is `true`. | true | PASS |
| 27 | `scoring_enabled` is `true`. | true | PASS |
| 28 | `created_at` matches the ISO 8601 UTC pattern `yyyy-MM-ddTHH:mm:ssZ`. | match | PASS |
| 29 | `tools/Test-AisrafRunProfile.ps1 -RunProfilePath runs/RUN-001/run-profile.yaml -ExecutionReady` returns 0 FAIL. | 0 FAIL | PASS |

## 3. Run-Log Posture

| # | Check | Expected | Status |
|---|---|---|---|
| 30 | `runs/RUN-001/00-run-log.md` includes the File Header section with the run identity table. | present | PASS |
| 31 | `runs/RUN-001/00-run-log.md` includes the Run Identity narrative naming the active prompts/skills/PRAs the operator will execute. | present | PASS |
| 32 | `runs/RUN-001/00-run-log.md` includes a Step Entries section that is empty (no chain execution claimed). | present, empty | PASS |
| 33 | `runs/RUN-001/00-run-log.md` includes a Post-Back Evidence section that is empty (no `executed_by_operator` row). | present, empty | PASS |
| 34 | `runs/RUN-001/00-run-log.md` includes a Stop Conditions Recorded section that is empty (no chain execution). | present, empty | PASS |
| 35 | `runs/RUN-001/00-run-log.md` includes Append Rules. | present | PASS |
| 36 | The run log uses only the seven approved run-profile placeholders. Other run-profile fields are referenced descriptively as `[copy from runs/{{run_id}}/run-profile.yaml#field_name]`. | match | PASS |
| 37 | The run log contains no severity / score / AI Action Level / blueprint-match computation. | absent | PASS |
| 38 | The run log contains no finding prose, recommendation prose, or validation-ticket prose. | absent | PASS |
| 39 | The run log contains no `executed_by_operator` claim. | absent | PASS |

## 4. Inputs (Byte-Copy Discipline)

| # | Check | Expected | Status |
|---|---|---|---|
| 40 | `runs/RUN-001/inputs/dfd-crop.png` byte-equals `samples/sample-001-dfd-crop/inputs/dfd-crop.png`. | byte-equal | PASS |
| 41 | `runs/RUN-001/inputs/dfd-crop.mmd` byte-equals `samples/sample-001-dfd-crop/inputs/dfd-crop.mmd`. | byte-equal | PASS |
| 42 | `runs/RUN-001/inputs/dfd-legend-excerpt.md` byte-equals the sample copy. | byte-equal | PASS |
| 43 | `runs/RUN-001/inputs/cloud-triage-notes.md` byte-equals the sample copy. | byte-equal | PASS |
| 44 | `runs/RUN-001/inputs/review-transcript.md` byte-equals the sample copy. | byte-equal | PASS |
| 45 | `runs/RUN-001/inputs/intake-ticket.md` byte-equals the sample copy. | byte-equal | PASS |
| 46 | `runs/RUN-001/inputs/` contains no other files beyond the 6 byte-copies. | exactly 6 | PASS |

## 5. Sealed Upstream Surfaces

| # | Check | Expected | Status |
|---|---|---|---|
| 47 | `prompts/`, `skills/`, `prototype-agents/`, `.agents/`, `catalogs/`, `blueprints/`, `templates/`, `samples/`, `config/` are not modified by Build Package 11. | unchanged | PASS |
| 48 | `tools/New-AisrafRun.ps1` and `tools/Test-AisrafRunProfile.ps1` are not modified by Build Package 11. | unchanged | PASS |
| 49 | The old reference workspace `D:\E-Way 2\aisraf-sas-prototype-skill-chain-pack-v0.01` is not modified. | unchanged | PASS |
| 50 | No file under `samples/sample-001-dfd-crop/expected/` is modified. Sample baselines remain read-only. | unchanged | PASS |

## 6. No Forbidden Claims

| # | Check | Expected | Status |
|---|---|---|---|
| 51 | No runtime / cloud / ADK / Vertex / GCP / MCP / Jira post-back / Confluence publication / Rovo / database / Terraform claim appears in the fixture. | absent | PASS |
| 52 | No `executed_by_operator` claim appears anywhere in the fixture. | absent | PASS |
| 53 | No new BP-* identifiers introduced. | absent | PASS |
| 54 | No new catalog values introduced. | absent | PASS |
| 55 | No severity / finding-category / AI Action Level / blueprint-match / accuracy-score computation inside any fixture artefact. | absent | PASS |
| 56 | No invented run-profile field outside `config/run-profile.schema.yaml`. | absent | PASS |

## 7. Synthetic-Data Safety

| # | Check | Expected | Status |
|---|---|---|---|
| 57 | No real PII / PAN / SSN / PHI in any input copy or fixture artefact. | absent | PASS |
| 58 | No real secrets / credentials in any fixture artefact. | absent | PASS |
| 59 | No real production endpoints in any fixture artefact. | absent | PASS |
| 60 | The fixture inherits the synthetic-data guarantee from `samples/sample-001-dfd-crop/README.md` § 1 because inputs are exact copies. | inherited | PASS |

## 8. Tool Compatibility

| # | Check | Expected | Status |
|---|---|---|---|
| 61 | `tools/Test-AisrafPackage.ps1` carries the Build Package 11 surgical patch (header text "Build Package 01-11"; runs/ removed from the README-only WARN-everywhere posture; new Check `08i-runs-content-limits` added; Check 11 validation allow-list extended). | patched | PASS |
| 62 | `tools/Test-AisrafPackage.ps1` runs to 0 FAIL after Build Package 11. | 0 FAIL | PASS |
| 63 | `tools/Test-AisrafRunProfile.ps1` runs unmodified. | unchanged | PASS |
| 64 | `tools/New-AisrafRun.ps1` runs unmodified. The known mismatch between the legacy 00-run-log header it emits and the Package 09 file shape is documented in `validation/run-log-checklist.md` as a future Package 03 increment compatibility note. | unchanged | PASS |

## 9. Compatibility Note — New-AisrafRun.ps1 vs. Package 09 Run-Log Shape

`tools/New-AisrafRun.ps1` predates Build Package 09 founder decision Q1, which split the run-log file shape (`templates/output/output-00-run-log-template.md`) from the per-step row pattern (`templates/run/run-log-entry-row-template.md`). The tool's 00-run-log emission therefore does not match the Package 09 file shape. RUN-001 was built by hand for this reason; the tool stays sealed (Build Package 03 contract). A future governed Build Package 03 increment may align the tool's emission to the Package 09 file shape.

## 10. Acceptance Verdict

Build Package 11 is **ready for human review** when every row above reads PASS. Numeric scoring of run outputs against expected baselines is owned by `prompts/rs/13-accuracy-score.prompt.md` / `skills/rs/SK-ACCURACY-SCORE.md` and activates when the operator executes the chain — not in this package.

## Out-of-Scope For Build Package 11

- Executing the Build Package 04 prompt chain.
- Producing any of the 17 RS or 9 DFD outputs.
- Numeric accuracy scoring.
- Modifying any sealed upstream artefact (`prompts/`, `skills/`, `prototype-agents/`, `.agents/`, `catalogs/`, `blueprints/`, `templates/`, `samples/`, `config/`, `tools/New-AisrafRun.ps1`, `tools/Test-AisrafRunProfile.ps1`).
- Diagrams package assets (Build Package 13).
- Practitioner / runbook prose (Build Package 14).
- Release artefacts / ZIP (Build Package 15).
- Final QA seal (Build Package 16).
- A second governed run fixture (`RUN-002` and beyond).
