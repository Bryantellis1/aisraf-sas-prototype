# WP-12C-AM3 — Test Plan

| Field | Value |
|---|---|
| Work package family | WP-12C-AM3 (PLAN → CONTRACTS → RUNTIME → EVIDENCE) |
| This document | Test plan for the full AM3 lane (authored during PLAN, executed during RUNTIME and EVIDENCE). |
| Scope | Six required tests across AM3 scaffold, state transitions, handoff contract, controlled-output smoke, no-external-execution proof, and no-overclaim proof. |
| Out of scope | AM4 / AL4 testing. AL5 testing. Load testing. External performance benchmarks. |

This document defines the six tests AM3 must pass before the AM3 lane may close. Tests are authored as runnable validators / scripts in WP-12C-AM3-RUNTIME and executed during WP-12C-AM3-EVIDENCE. Pass / fail outcomes for every test must be recorded in the AM3 evidence report.

---

## 1. Test Suite Overview

| ID | Test | Authored In | Executed In | Pass Criterion |
|---|---|---|---|---|
| AM3-T1 | AM3 scaffold validation | WP-12C-AM3-CONTRACTS | WP-12C-AM3-RUNTIME (initial), then re-run every gate | All four AM3 contract / schema files present and conformant; orchestrator-side state container shape matches `am3.run_state.v0_1_2`. |
| AM3-T2 | AM3 state transition validation | WP-12C-AM3-RUNTIME | WP-12C-AM3-RUNTIME, WP-12C-AM3-EVIDENCE | Run-state `current_step` advances only through the AM3-01 → AM3-06 sequence; no skipping; no re-entry without a recorded gate decision. |
| AM3-T3 | AM3 handoff contract validation | WP-12C-AM3-RUNTIME | WP-12C-AM3-RUNTIME, WP-12C-AM3-EVIDENCE | Each AM3 step shows a schema-valid `request.yaml` and `response.yaml`; each response names a within-`{{output_root}}` output file; each response carries a per-step verdict. |
| AM3-T4 | AM3 controlled-output smoke | WP-12C-AM3-RUNTIME | WP-12C-AM3-EVIDENCE | Full local AM3 smoke run completes against `runs/RUN-SMOKE-AM3-001/`, produces the 17 RS outputs + 9 DFD subskill outputs + runtime state + events log; nothing is written outside `{{output_root}}` (incl. its `dfd/` and `runtime/` subfolders). |
| AM3-T5 | AM3 no-external-execution proof | WP-12C-AM3-RUNTIME | WP-12C-AM3-EVIDENCE | No event, handoff, run-state field, or specialist output records a destination URL, Jira ticket id, Confluence page id, Lucidchart document id, MCP server identifier, cloud endpoint, database connection string, Terraform action, event bus topic, or telemetry sink. |
| AM3-T6 | AM3 no-overclaim proof | WP-12C-AM3-RUNTIME | WP-12C-AM3-EVIDENCE | No AM3 lane artifact claims AM4 / AL4 is implemented, claims AL5 is in scope, claims AM3 is delivered before WP-12C-AM3-EVIDENCE closes, or claims closed-loop autonomy. |

All six tests must report 0 FAIL before the AM3 lane may close.

## 2. AM3-T1 — AM3 Scaffold Validation

Purpose: prove that the AM3 lane authored its contracts and schemas before any runtime code runs.

Test procedure:

1. Confirm presence of:
   - `config/am3.orchestrator-contract.v0_1_2.yaml`
   - `config/am3.handoff-contract.v0_1_2.yaml`
   - `config/am3.run-state.schema.v0_1_2.yaml`
   - `config/am3.event.schema.v0_1_2.yaml`
2. Parse each YAML; reject on parse error.
3. Confirm each schema has `$id` ending in `.v0_1_2`, `type: object`, and `additionalProperties: false` for closed structural types.
4. Confirm the orchestrator contract enumerates exactly six AM3 steps (AM3-01 through AM3-06) and lists exactly the four PRA-01 §8 human gates plus the final decision gate.
5. Confirm the handoff contract requires both `request.yaml` and `response.yaml` per step under `{{output_root}}/runtime/handoffs/<step-id>/`.
6. Confirm the event schema constrains `event_type` to: `orchestrator_decision`, `handoff_request`, `handoff_response`, `validator_outcome`, `gate_request`, `gate_decision`, `stop`.
7. Confirm no contract field allows an external destination URL, external connector reference, MCP execution, database write-back, or cloud reference.

Failure modes:

- Missing file → FAIL.
- Parse error → FAIL.
- Schema not closed (`additionalProperties: true` on a closed structural type) → FAIL.
- Step enumeration wrong → FAIL.
- Event type set wrong → FAIL.
- Any forbidden external field present → FAIL.

Implementer: `tools/Test-AisrafAm3Runtime.ps1` (authored in WP-12C-AM3-RUNTIME).

## 3. AM3-T2 — AM3 State Transition Validation

Purpose: prove the orchestrator advances state only through legal transitions.

Test procedure:

1. Load `runs/RUN-SMOKE-AM3-001/runtime/run-state.yaml`; confirm schema conformance.
2. Load `runs/RUN-SMOKE-AM3-001/runtime/events.ndjson`; confirm each line is schema-valid against `am3.event.v0_1_2`.
3. Confirm ordered events show:
   - exactly one `orchestrator_decision` per step entry,
   - exactly one `handoff_request` per step,
   - exactly one `handoff_response` per step,
   - exactly one `validator_outcome` per step (after the response),
   - paired `gate_request` / `gate_decision` events at each required gate,
   - and `current_step` advancing monotonically AM3-01 → AM3-02 → AM3-03 → AM3-04 → AM3-05 → AM3-06.
4. Confirm no `current_step` value outside the AM3 step enumeration.
5. Confirm any `stop` event is the final event and is preceded by a `validator_outcome: FAIL` or a `gate_decision: stop`.

Failure modes:

- Out-of-order events → FAIL.
- Skipped step → FAIL.
- Missing validator_outcome after a handoff_response → FAIL.
- Missing gate_decision after a gate_request before the next step begins → FAIL.
- run-state inconsistent with last event → FAIL.

Implementer: `tools/Test-AisrafAm3Runtime.ps1`.

## 4. AM3-T3 — AM3 Handoff Contract Validation

Purpose: prove every specialist invocation produced both a schema-valid request and a schema-valid response.

Test procedure:

1. Enumerate `runs/RUN-SMOKE-AM3-001/runtime/handoffs/`; confirm exactly six subfolders named `AM3-01` through `AM3-06`.
2. For each subfolder confirm presence of `request.yaml` and `response.yaml`.
3. Validate each `request.yaml` against `am3.handoff_request.v0_1_2`:
   - names the owning PRA,
   - names the required inputs (file paths under `{{input_root}}` or `{{output_root}}`),
   - sets `output_destination_mode: local_only`.
4. Validate each `response.yaml` against `am3.handoff_response.v0_1_2`:
   - names the produced output files (all under `{{output_root}}`, `{{output_root}}/dfd/`, or `{{output_root}}/runtime/`),
   - carries the per-step verdict from the closed set defined by the handoff contract,
   - carries the sensitive-data screen result (PASS only).
5. Cross-check: every output file named in a response actually exists on disk under the run output root.

Failure modes:

- Missing subfolder → FAIL.
- Missing request.yaml or response.yaml → FAIL.
- Schema violation → FAIL.
- Response names an output outside `{{output_root}}` family → FAIL.
- Named output file does not exist on disk → FAIL.

Implementer: `tools/Test-AisrafAm3Runtime.ps1`.

## 5. AM3-T4 — AM3 Controlled-Output Smoke

Purpose: prove a full local AM3 smoke run completes without writing outside `{{output_root}}` and without external execution.

Test procedure:

1. Pre-conditions:
   - `runs/RUN-SMOKE-AM3-001/` exists and was created during WP-12C-AM3-RUNTIME setup.
   - Run profile validates 12 PASS / 0 FAIL.
   - `sensitive_data_confirmed_redacted: true` for the staged inputs.
2. Execute `tools/Invoke-AisrafAm3LocalRun.ps1 -RunProfilePath ./runs/RUN-SMOKE-AM3-001/run-profile.yaml`.
3. Confirm the runner walks AM3-01 → AM3-06.
4. Confirm produced outputs:
   - `00-run-log.md` through `17-accuracy-score.md` (or the eligible subset) under `{{output_root}}`.
   - `dfd/01-intake-quality-check.md` through `dfd/09-extraction-summary.md` under `{{output_root}}/dfd/`.
   - `runtime/run-state.yaml`, `runtime/events.ndjson`, and the six `handoffs/AM3-0X/{request,response}.yaml` files under `{{output_root}}/runtime/`.
5. Confirm `git diff --name-only` shows only files under `runs/RUN-SMOKE-AM3-001/`.
6. Confirm `git diff -- runs/RUN-001/` is empty.
7. Confirm `git diff -- samples/` is empty.
8. Confirm `git diff -- prompts/ skills/ prototype-agents/ templates/ catalogs/ blueprints/ config/` is empty.
9. Confirm `git diff -- .agents/ .github/agents/ .github/skills/ .github/hooks/ .copilot-skills/` is empty.

Failure modes:

- Runner writes outside `{{output_root}}` → FAIL.
- Any sealed surface changes → FAIL.
- Any AM3 step does not complete → FAIL.
- Any human gate is bypassed → FAIL.

Implementer: `tools/Invoke-AisrafAm3LocalRun.ps1` (authored WP-12C-AM3-RUNTIME); evidence reviewed in WP-12C-AM3-EVIDENCE.

## 6. AM3-T5 — AM3 No-External-Execution Proof

Purpose: prove AM3 made no network call, no external write-back, and recorded no external destination.

Test procedure:

1. Scan `runs/RUN-SMOKE-AM3-001/runtime/events.ndjson` for any event field containing any of:
   - `http://`, `https://`, `wss://`, `mcp://`,
   - a Jira issue key pattern (`[A-Z]+-\d+`) where the surrounding context implies a Jira destination,
   - a Confluence page ID pattern in a destination context,
   - a Lucidchart document ID in a destination context,
   - a cloud SDK call signature, a Terraform action string, a database connection string,
   - an event bus topic / telemetry sink identifier.
2. Scan all `runs/RUN-SMOKE-AM3-001/runtime/handoffs/**/*.yaml` files for the same patterns.
3. Confirm `output_destination_mode: local_only`, `postback_execution_status: deferred`, `jira_connector_status: not_required`, `confluence_connector_status: not_required`, `rovo_mcp_available: false`, `mcp_execution_status: not_required` are all present in the run profile and the AM3 run-state file.
4. Confirm no `Invoke-WebRequest`, `Invoke-RestMethod`, `curl`, or `wget` call is present in `tools/Invoke-AisrafAm3LocalRun.ps1` (static scan).

Failure modes:

- Any destination URL present → FAIL.
- Any external connector status not in the allowed `not_required` / `unavailable` set → FAIL.
- Any network call signature in the runner → FAIL.

Implementer: `tools/Test-AisrafAm3Runtime.ps1` (NDJSON / YAML scan) + `tools/Test-AisrafPackage.ps1` overclaim guard (static scan).

## 7. AM3-T6 — AM3 No-Overclaim Proof

Purpose: prove AM3 lane artifacts do not claim AM4 / AL4 / AL5 / closed-loop autonomy is implemented or current.

Test procedure:

1. Scan every file under `validation/package-12c-am3-*.md`, `config/am3.*`, `tools/Invoke-AisrafAm3LocalRun.ps1`, `tools/Test-AisrafAm3Runtime.ps1`, the AM3 smoke run folder, the AM3 evidence report, the manifest, and the roadmap for any of:
   - "AM4 implemented", "AL4 implemented", "AL5 implemented",
   - "closed-loop autonomy" claimed as current,
   - "Jira / Confluence / Lucidchart / Rovo / MCP / cloud / database / Terraform / event bus / telemetry" claimed as current execution surfaces,
   - "production cloud service", "marketplace published", "live external integration" claimed as current.
2. Confirm `docs/ROADMAP.md` keeps AM4 in the deferred section even after AM3-EVIDENCE closes.
3. Confirm `PACKAGE-MANIFEST.yaml` records `al4_status` and `al5_status` per their existing scope-out language; AM3 lane work does not relax those statuses.
4. Confirm `current_autonomy_level` in the manifest is not raised above `AL2_controlled_output_local_workbench` before WP-12C-AM3-EVIDENCE closes; and at AM3-EVIDENCE close, is raised only to `AL3_local_orchestrated_multi_agent_runtime`, not higher.

Failure modes:

- Any AM4 / AL4 / AL5 / closed-loop-autonomy-implemented claim → FAIL.
- AM3 implemented claim prior to AM3-EVIDENCE close → FAIL.
- Autonomy level raised above AL3 anywhere → FAIL.

Implementer: `tools/Test-AisrafPackage.ps1` text-pattern overclaim guard (extension to be authored in WP-12C-AM3-RUNTIME as part of the AM3 validator route), plus manual cross-read during WP-12C-AM3-EVIDENCE.

## 8. Per-Gate Test Execution Matrix

| Gate | AM3-T1 | AM3-T2 | AM3-T3 | AM3-T4 | AM3-T5 | AM3-T6 |
|---|---|---|---|---|---|---|
| WP-12C-AM3-PLAN (this gate) | n/a (contracts not authored yet) | n/a | n/a | n/a | n/a | run as manual cross-read of the four plan documents |
| WP-12C-AM3-CONTRACTS | required | n/a | n/a | n/a | run as static scan of contracts | required |
| WP-12C-AM3-RUNTIME | required | required (against a CONTRACTS-only mock run if needed) | required | required (first full smoke) | required | required |
| WP-12C-AM3-EVIDENCE | required | required | required | required (founder-approved final smoke) | required | required |

A test marked `n/a` for a gate must still be re-evaluated at the next gate where it becomes applicable; tests do not become permanently waived.

## 9. Smoke Run Boundary

The AM3 smoke run is local-only:

- Folder: `runs/RUN-SMOKE-AM3-001/` (created in WP-12C-AM3-RUNTIME, not in WP-12C-AM3-PLAN).
- Inputs: copied from a designated sample under `samples/sample-001-dfd-crop/inputs/` after operator review and `sensitive_data_confirmed_redacted: true`.
- Outputs: under the run folder only.
- Excluded from staging until WP-12C-AM3-EVIDENCE close authorizes it. Smoke runs under `runs/RUN-SMOKE-*/` follow the existing gitignore / staging exclusion posture defined for L2B smoke evidence.

## 10. Pass / Fail Reporting

Each AM3 test reports one of `PASS` / `FAIL` / `n/a` with:

- Test ID.
- Test name.
- Pre-conditions met (yes/no).
- Detailed observation (counts, paths, schema results).
- Linked artifacts (file paths under the run folder).

The AM3 evidence report (`validation/package-12c-am3-evidence-report.md`) records the per-test outcome plus the five-validator ladder counts and the git hygiene posture.
