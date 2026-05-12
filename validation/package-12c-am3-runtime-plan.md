# WP-12C-AM3-PLAN — Live AM3 Runtime Scope, Architecture, And Lane Definition

| Field | Value |
|---|---|
| Work package | WP-12C-AM3-PLAN — Live AM3 Runtime Scope, Architecture, And Test Plan |
| Mission | Define the minimum implementation and test plan required to move AISRAF from AL2 controlled-output local workbench to AL3 local orchestrated multi-agent runtime ("AM3") without claiming AM4 external execution. |
| Predecessor accepted state | WP-12C-REL0_C_STAGE_COMMIT_PASS_READY_FOR_AM3_PLAN. |
| Founder direction | AM3 / AL3 runtime is now an in-release target before final v0.1.2 release/publish. AM4 adapters remain future. |
| Agents | `AG-AISRAF-ARCHITECTURE-TRACEABILITY-R1`, `AG-AISRAF-RELEASE-MANAGER-R1`, `AG-AISRAF-SECURITY-OVERCLAIM-GUARD-R1`, `AG-AISRAF-VERSION-CONTROL-HYGIENE-R1` |
| Mode | Planning only. No runtime code is created by this WP. No AM3 runner exists yet. No AM4 work begins. No push, publish, or stage. |
| Current release truth (before AM3 lane completes) | AISRAF v0.1.2 is an AL2 controlled-output local security architecture review workbench. It is orchestrator-first and multi-agent packaged. It is not yet a true AL3 runtime. |
| Target release truth (after AM3 lane completes) | AISRAF v0.1.2 ships an AL3 local orchestrated multi-agent runtime ("AM3"). External execution (AL4 / AM4) remains deferred and unmade. |

This document is the AM3-PLAN scope and architecture artifact. It defines what AM3 is, what AM3 is not, the runtime shape, the runtime artifacts, the minimum specialist chain, and the security boundary that separates AM3 from AM4. Implementation is gated behind a later WP-12C-AM3-CONTRACTS work package and a still-later WP-12C-AM3-RUNTIME work package.

---

## 1. AM3 Definition (Scope-In)

AM3 is a **local orchestrated multi-agent runtime** in which:

- The AISRAF Orchestrator (`PRA-01-SAS-REVIEW-ORCHESTRATOR`, surfaced as `.agents/aisraf-orchestrator.agent.md`) owns run state from PRA-01 entry to PRA-08 close.
- The Orchestrator delegates each step to the owning specialist agent (PRA-02 through PRA-08) via an explicit, structured handoff.
- Each specialist returns a structured output back to the Orchestrator.
- Each transition is recorded as a checkpoint/event in the run log and a dedicated runtime event log under `{{output_root}}`.
- Each transition is validator-gated: the run cannot advance until the per-step validator confirms the produced output is well-formed and within the controlled-output boundary.
- Human approval gates remain explicit at the points already defined in PRA-01 §8 ("Human Gates") — the runtime pauses and waits.
- All artifacts are local files under `{{output_root}}`. Nothing is posted back to an external system. Nothing is written outside `{{output_root}}` or `{{output_root}}/dfd/`.

AM3 is the runtime expression of the existing PRA chain. AM3 does not invent new review logic, new prompts, new skills, or new templates. AM3 enforces that the existing chain executes under an orchestrator-owned, state-bearing, validator-gated, locally-bounded runtime model.

## 2. AM3 Definition (Scope-Out)

AM3 explicitly excludes, and AM3 evidence must explicitly disprove the presence of:

- Jira ticket intake execution.
- Confluence post-back execution.
- Lucidchart direct adapter execution.
- Rovo MCP execution.
- Anthropic / Azure AI Foundry / Google ADK / Microsoft Agent Framework runtime adapters.
- Cloud runtime execution.
- Database-backed runtime state (no database write-back of any kind).
- Terraform / infrastructure-as-code execution.
- Event bus integration.
- Telemetry backend emission.
- Closed-loop autonomy (no decision-to-action without a human gate).
- Any AM4 / AL4 adapter operation, current or partial.

If AM3 implementation, AM3 evidence, or AM3 surface material introduces or hints at any of the scope-out items, the AM3 lane fails the overclaim guard.

## 3. AM3 Runtime Shape

AM3 has six runtime elements. Each element is local-only.

| Element | Responsibility |
|---|---|
| **Local orchestrator control plane** | A local process / session, owned by `.agents/aisraf-orchestrator.agent.md`, that holds the active run profile, current step pointer, the handoff cursor, and the human-gate flag. It does not call cloud APIs, MCP, or any external network endpoint. |
| **Run-state file** | A single file under `{{output_root}}/runtime/run-state.yaml` (schema: `am3.run_state.v0_1_2`) holding `run_id`, `schema_version`, `package_version`, `current_step`, `last_completed_step`, `pending_human_gate`, `last_checkpoint_id`, and timestamps. |
| **Event / checkpoint log** | An append-only NDJSON file under `{{output_root}}/runtime/events.ndjson` (schema: `am3.event.v0_1_2`) holding one event per orchestrator decision, per specialist handoff, per specialist return, per validator outcome, per human-gate request, per human-gate decision, and per stop condition. |
| **Specialist handoff files** | Per-step files under `{{output_root}}/runtime/handoffs/<step-id>/request.yaml` and `{{output_root}}/runtime/handoffs/<step-id>/response.yaml` (schemas: `am3.handoff_request.v0_1_2`, `am3.handoff_response.v0_1_2`) carrying the structured inputs and outputs of each PRA invocation. |
| **Validator-gated transitions** | After each specialist response, a per-step validator confirms the structured response is conformant and the run-log step output exists and is within `{{output_root}}`. Failure halts the run and records a stop event. |
| **Human approval gates** | The orchestrator pauses at the four human gates defined by PRA-01 §8 and at the final PASS / PARTIAL / FAIL / `not_applicable` decision. Resumption requires an explicit human-gate decision event. |

The control plane, the run-state file, the event log, the handoff files, and the validator are all local. No network call is part of AM3.

## 4. AM3 Runtime Artifacts (To Be Authored In Later WPs)

The following artifacts are **named here but not authored here**. They will be authored in the WP-12C-AM3-CONTRACTS and WP-12C-AM3-RUNTIME work packages.

| Artifact | Purpose | Authoring WP |
|---|---|---|
| `config/am3.orchestrator-contract.v0_1_2.yaml` | The orchestrator-side contract: required run-profile fields, owned state, transition rules, allowed and forbidden side-effects, stop conditions. | WP-12C-AM3-CONTRACTS |
| `config/am3.handoff-contract.v0_1_2.yaml` | The handoff contract every specialist must obey: required inputs, required outputs, validator coupling, sensitive-data screen, path guard. | WP-12C-AM3-CONTRACTS |
| `config/am3.run-state.schema.v0_1_2.yaml` | JSON Schema for the run-state file. | WP-12C-AM3-CONTRACTS |
| `config/am3.event.schema.v0_1_2.yaml` | JSON Schema for the NDJSON event records. | WP-12C-AM3-CONTRACTS |
| `runs/RUN-SMOKE-AM3-001/run-profile.yaml` | AM3 smoke run profile (local-only, controlled-output, sensitive-data screen affirmed). | WP-12C-AM3-RUNTIME (authoring) / human gate (input staging) |
| `tools/Test-AisrafAm3Runtime.ps1` | AM3 validator route: schema conformance of run-state, events, handoffs; ordering invariants; controlled-output proof; no-external-execution proof. | WP-12C-AM3-RUNTIME |
| `tools/Invoke-AisrafAm3LocalRun.ps1` | The minimum AM3 local runner that drives the orchestrator over the existing PRA chain. Local-only. Path-guarded. Validator-gated. | WP-12C-AM3-RUNTIME |

Authoring order is contracts first, then runtime, then test, then smoke evidence. Skipping order is not authorized.

## 5. AM3 Minimum Specialist Chain

The AM3 lane uses the existing PRA chain. No new specialist is invented. The minimum AM3 chain, in execution order, is:

| Step | Specialist | Role In AM3 |
|---|---|---|
| AM3-01 | `PRA-02-INPUT-READER` (Input Reader) | Confirms staged inputs, produces `{{output_root}}/01-input-inventory.md`, returns a structured handoff response naming the inventory file and the input-readiness verdict. |
| AM3-02 | `PRA-03-DFD-EXTRACTOR` (DFD Extractor) | Runs the DFD subskill chain (PR-DFD-02 through PR-DFD-10) and the design-fact extract. Produces the DFD subskill outputs under `{{output_root}}/dfd/` and the component / flow / boundary RS outputs. Returns a structured handoff response naming each output file and the DFD intake verdict. |
| AM3-03 | `PRA-05-REVIEW-TABLE-BUILDER` (Review Table Builder) | Produces `{{output_root}}/07-security-stack-assessment.md` and `{{output_root}}/08-internal-review-table.md`. Returns a structured handoff response naming both files. |
| AM3-04 | `PRA-06-BLUEPRINT-QUESTIONER` (Blueprint Questioner) | Produces `{{output_root}}/09-missing-facts.md`, `{{output_root}}/10-ai-action-level.md`, `{{output_root}}/11-blueprint-match.md`, `{{output_root}}/12-targeted-questions.md`. Returns a structured handoff response. |
| AM3-05 | `PRA-07-FINDING-RECOMMENDER` (Finding Recommender) | Produces `{{output_root}}/13-findings.md`, `{{output_root}}/14-recommendations.md`. Returns a structured handoff response. |
| AM3-06 | `PRA-08-HANDOFF-QA-SCORER` (Handoff QA Scorer) | Produces `{{output_root}}/15-handoff-pack.md`, `{{output_root}}/16-validation-notes.md`, and (if scoring eligible) `{{output_root}}/17-accuracy-score.md`. Returns the final PASS / PARTIAL / FAIL / `not_applicable` decision via a structured handoff response. |

PRA-01 owns the control plane and the run log. PRA-04 (Legend Normalizer) is invoked within AM3-02 as the legend normalization subskill of the DFD chain; AM3 does not promote PRA-04 to its own AM3 step. AM3 does not change which prompts or skills are owned by which PRA.

## 6. AM3 Evidence Requirements

Evidence that AM3 is real (not a façade) must show all of:

| Evidence claim | Evidence artifact |
|---|---|
| Orchestrator owns state | `{{output_root}}/runtime/run-state.yaml` exists, validates against `am3.run_state.v0_1_2`, and is the single source of `current_step` for the run. |
| Each specialist receives an explicit handoff | One `request.yaml` per AM3 step under `{{output_root}}/runtime/handoffs/<step-id>/`, schema-valid, naming the specialist and the required inputs. |
| Each specialist returns a structured output | One `response.yaml` per AM3 step under the same folder, schema-valid, naming the produced output files and the per-step verdict. |
| Each transition records a checkpoint / event | One NDJSON line per orchestrator decision, handoff, return, validator outcome, gate request, gate decision, and stop in `{{output_root}}/runtime/events.ndjson`. The line ordering is monotonically increasing. |
| Validators run between steps | The event log records a `validator_outcome` event after each specialist `response`. The runtime halts on a FAIL validator outcome and emits a `stop` event. |
| Human gates are explicit | Each of the four PRA-01 §8 human gates plus the final PASS / PARTIAL / FAIL / `not_applicable` decision shows a paired `gate_request` and `gate_decision` event with a recorded reviewer identity. |
| All outputs remain local-only | `git diff -- runs/RUN-SMOKE-AM3-001/` shows the new run folder contents; all other surfaces are unchanged; no external destination URL is recorded in any event; no external connector status is anything other than `not_required` / `unavailable`. |

Absence of any of these evidence rows is an AM3 lane failure.

## 7. AM3 Security Boundary And Sensitive-Data Posture

AM3 keeps every sensitive-data rule already enforced by AL2:

- `config/sensitive-data-rules.md` continues to apply to every string field in run-state, events, handoffs, and specialist outputs.
- The run profile's `sensitive_data_confirmed_redacted` flag remains required and remains the gating control for any AM3 smoke run.
- `output_destination_mode` must be `local_only`. `postback_execution_status` must be `deferred`. `jira_connector_status` / `confluence_connector_status` / `mcp_execution_status` must be `not_required`. `rovo_mcp_available` must be `false`.
- The orchestrator's path guard rejects any specialist response that names an output file outside `{{output_root}}` or `{{output_root}}/dfd/` or `{{output_root}}/runtime/`.
- The orchestrator's sensitive-data screen rejects any specialist response that records a destination URL, a credential, an email address, or a customer-identifying string.

AM3 changes the runtime; AM3 does not loosen the security posture. The same overclaim guard applies to AM3 artifacts.

## 8. AM3 vs AM4 Boundary (Explicit)

| Property | AM3 (in this release lane) | AM4 (deferred) |
|---|---|---|
| Where execution happens | Local process, local files only | External systems (Jira, Confluence, Lucidchart, MCP, cloud, database, Terraform, event bus, telemetry) |
| Where state lives | `{{output_root}}/runtime/run-state.yaml` (local file) | External durable store (deferred) |
| What records state changes | `{{output_root}}/runtime/events.ndjson` (local file) | External event bus / telemetry backend (deferred) |
| What writes outputs | Specialist responses → orchestrator → local Markdown under `{{output_root}}` | External post-back pipeline (deferred) |
| Human-in-the-loop | Required at PRA-01 §8 gates and at final decision | Same (no closed-loop autonomy is on the roadmap) |
| Network calls | None | The defining feature of AM4 |

If any AM3 implementation or AM3 evidence artifact crosses the right-hand column, that artifact must be rejected and the AM3 lane status set to BLOCKED.

## 9. Forbidden In This WP

WP-12C-AM3-PLAN must not:

- Create or commit any runtime code.
- Create `tools/Invoke-AisrafAm3LocalRun.ps1` or `tools/Test-AisrafAm3Runtime.ps1`.
- Create or stage `runs/RUN-SMOKE-AM3-001/`.
- Author the AM3 schemas or contracts (those belong to WP-12C-AM3-CONTRACTS).
- Modify `runs/RUN-001/` or `samples/`.
- Modify canonical surfaces (`prompts/`, `skills/`, `prototype-agents/`, `templates/`, `catalogs/`, `blueprints/`, `config/`).
- Modify projection surfaces (`.agents/`, `.github/agents/`, `.github/skills/`, `.github/hooks/`, `.copilot-skills/`).
- Edit `plugin.json` or `plugin.yaml`.
- Begin AM4 work in any form.
- Push, publish, or stage.

## 10. Authorized Files Touched By WP-12C-AM3-PLAN

| File | Purpose |
|---|---|
| `validation/package-12c-am3-runtime-plan.md` | This document. |
| `validation/package-12c-am3-definition-of-done.md` | AM3 lane Definition of Done. |
| `validation/package-12c-am3-test-plan.md` | AM3 test plan. |
| `validation/package-12c-am3-risk-register.md` | AM3 risk register. |
| `tools/Test-AisrafPackage.ps1` | Allow-list extension for the four new validation files only. |
| `tools/Test-AisrafBp12AReadiness.ps1` | Drift allow-list extension naming `docs/ROADMAP.md` only (no broad `docs/` allowance). |
| `docs/ROADMAP.md` | Repositions AM3 as the in-release lane preceding final v0.1.2 publish, with AM4 still deferred. |
| `PACKAGE-MANIFEST.yaml` | Marks WP-12C-AM3-PLAN active and records `current_autonomy_level` unchanged at AL2 with `target_autonomy_level_for_v0_1_2: AL3_local_orchestrated_multi_agent_runtime`. |
| Plugin bundle copies of the two validators, plus the bundle checksum manifest | Regenerated only via `tools/Build-AisrafCopilotPluginBundle.ps1 -Clean`. |

No other file is touched in this WP.

## 11. Gate Map

```text
WP-12C-REL0_C_STAGE_COMMIT_PASS (predecessor accepted)
  → WP-12C-AM3-PLAN          (this WP — scope, architecture, DoD, tests, risks)
  → WP-12C-AM3-CONTRACTS     (next WP — author contracts + schemas; still no runtime code)
  → WP-12C-AM3-RUNTIME       (after CONTRACTS — author runner + AM3 validator + smoke run)
  → WP-12C-AM3-EVIDENCE      (after RUNTIME — execute smoke; capture evidence; overclaim guard)
  → WP-12C-REL0-CLOSE        (founder-authorized public release gate closure, now AL3-bearing)
  → WP-13 release visuals    (still blocked by REL0 closure and BP12-SAMPLE-DFD blocker)
  → WP-AM4-ADAPTERS          (future; one adapter per WP; none in v0.1.2)
```

Each gate requires the previous gate's evidence. Skipping gates is not authorized.

## 12. Exit Status For This WP

Authorized exit statuses:

- `WP-12C-AM3_PLAN_PASS_READY_FOR_AM3_CONTRACTS` — all four plan documents present, validator allow-lists updated, bundle rebuilt, four-validator ladder 0 FAIL, no overclaim, no canonical or projection drift.
- `WP-12C-AM3_PLAN_PARTIAL_WITH_GAPS` — one or more plan documents incomplete, but no validator FAIL.
- `WP-12C-AM3_PLAN_BLOCKED_WITH_REASON` — validator FAIL, overclaim found, or canonical/projection drift detected.

The closure register and final report are recorded as the WP-12C-AM3-PLAN final report in the assistant response (not as a separate file).
