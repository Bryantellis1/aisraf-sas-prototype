# WP-12C-AM3 — Definition Of Done

| Field | Value |
|---|---|
| Work package family | WP-12C-AM3 (PLAN → CONTRACTS → RUNTIME → EVIDENCE) |
| This document | Definition of Done for the full AM3 lane (not just AM3-PLAN). |
| Scope | The conditions under which AISRAF v0.1.2 may claim AL3 local orchestrated multi-agent runtime ("AM3"). |
| Out of scope | AM4 / AL4 (any external adapter execution). AL5 closed-loop autonomy. |

The Definition of Done ("DoD") below applies to the **AM3 lane as a whole**. Each gated AM3 work package (PLAN, CONTRACTS, RUNTIME, EVIDENCE) must satisfy its own subset and must satisfy that no later gate's evidence is claimed before its own gate closes.

---

## 1. DoD For WP-12C-AM3-PLAN (This Gate)

WP-12C-AM3-PLAN is **done** when all of the following are true:

1. The four AM3 plan documents exist at the exact paths:
   - `validation/package-12c-am3-runtime-plan.md`
   - `validation/package-12c-am3-definition-of-done.md` (this document)
   - `validation/package-12c-am3-test-plan.md`
   - `validation/package-12c-am3-risk-register.md`
2. Each plan document explicitly distinguishes AM3 (in-release) from AM4 (deferred) and names the AM4 scope-out list.
3. `tools/Test-AisrafPackage.ps1` `$validationAllowed` includes exactly the four AM3 filenames above (exact names only, no wildcards, no broad allowance).
4. `tools/Test-AisrafBp12AReadiness.ps1` `tracked-drift` allow-list explicitly names `docs/ROADMAP.md` (exact path only, no broad `docs/` allowance) for the WP-12C-AM3-PLAN gate.
5. `docs/ROADMAP.md` is updated to position AM3 as the in-release lane preceding final v0.1.2 publish, with AM4 still listed as deferred adapter work.
6. `PACKAGE-MANIFEST.yaml` records `wp12c_am3_plan_status: ACTIVE` and records that `current_autonomy_level` remains `AL2_controlled_output_local_workbench` until AM3-EVIDENCE closes.
7. The plugin bundle is rebuilt via `tools/Build-AisrafCopilotPluginBundle.ps1 -Clean`; the bundle checksum manifest matches source SHA-256 values for every bundled file.
8. The four-validator ladder shows 0 FAIL:
   - `tools/Test-AisrafPackage.ps1`
   - `tools/Test-AisrafBp12AReadiness.ps1`
   - `tools/Test-AisrafRunProfile.ps1 -RunProfilePath ./runs/RUN-SMOKE-PLUGIN-L2B-001/run-profile.yaml -ExecutionReady`
   - `tools/Test-AisrafRunProfile.ps1 -RunProfilePath ./runs/RUN-001/run-profile.yaml -ExecutionReady`
9. `git status --short` shows only the WP-12C-AM3-PLAN authorized files. No staging is performed. No push is performed. No publish is performed.
10. No AM3 runtime code, no AM3 contract YAML, no AM3 schema YAML, no AM3 runner, no AM3 smoke run folder exists yet.
11. `runs/RUN-001/`, `samples/`, canonical surfaces, and projection surfaces are byte-unchanged.
12. No artifact in this WP claims AM3 is implemented; no artifact in this WP claims AM4 / AL4 is current.

## 2. DoD For WP-12C-AM3-CONTRACTS (Next Gate)

WP-12C-AM3-CONTRACTS is **done** when all of the following are true:

1. The AM3 contract and schema files exist at the exact paths:
   - `config/am3.orchestrator-contract.v0_1_2.yaml`
   - `config/am3.handoff-contract.v0_1_2.yaml`
   - `config/am3.run-state.schema.v0_1_2.yaml`
   - `config/am3.event.schema.v0_1_2.yaml`
2. Each file pins `schema_version` and `package_version` to `v0.1.2` constants where applicable.
3. The orchestrator contract names exactly the six AM3 steps from the AM3-PLAN minimum specialist chain (AM3-01 through AM3-06) and the four PRA-01 §8 human gates plus the final decision gate.
4. The handoff contract requires per-step `request.yaml` and `response.yaml` files under `{{output_root}}/runtime/handoffs/<step-id>/`, both schema-bound.
5. The run-state schema constrains `current_step` to the AM3 step enumeration and forbids unknown fields (`additionalProperties: false`).
6. The event schema constrains `event_type` to the closed set defined in the AM3 PLAN runtime shape (`orchestrator_decision`, `handoff_request`, `handoff_response`, `validator_outcome`, `gate_request`, `gate_decision`, `stop`).
7. No contract field permits an external destination URL, external connector reference, MCP execution, database write-back, or cloud reference.
8. The four-validator ladder shows 0 FAIL on the same four validators listed in §1.8.
9. No AM3 runner code is authored in this gate. No AM3 smoke run is created in this gate.
10. The plan documents from WP-12C-AM3-PLAN are unchanged or only re-cross-referenced; their authority is not weakened.

## 3. DoD For WP-12C-AM3-RUNTIME (Subsequent Gate)

WP-12C-AM3-RUNTIME is **done** when all of the following are true:

1. The minimum local runner exists at `tools/Invoke-AisrafAm3LocalRun.ps1`, drives the orchestrator over the six AM3 steps, reads only from `{{input_root}}` and `{{output_root}}`, writes only under `{{output_root}}`, and makes no network call.
2. The AM3 validator exists at `tools/Test-AisrafAm3Runtime.ps1` and enforces:
   - Schema conformance of `run-state.yaml`, `events.ndjson`, and per-step `request.yaml` / `response.yaml`.
   - Monotonic ordering of event records.
   - Presence of `validator_outcome` after each `handoff_response`.
   - Presence of `gate_request` / `gate_decision` pairs at all required gates.
   - Path-guard enforcement: no recorded output file is outside `{{output_root}}` or `{{output_root}}/dfd/` or `{{output_root}}/runtime/`.
   - Sensitive-data screen enforcement: no event, no handoff, no run-state field contains a destination URL, credential, email, or customer-identifying string.
3. The AM3 smoke run profile exists at `runs/RUN-SMOKE-AM3-001/run-profile.yaml`, validates 12 PASS / 0 FAIL under `Test-AisrafRunProfile.ps1 -ExecutionReady`, and pins `output_destination_mode: local_only`, `postback_execution_status: deferred`, `jira_connector_status: not_required`, `confluence_connector_status: not_required`, `rovo_mcp_available: false`, `mcp_execution_status: not_required`, `sensitive_data_confirmed_redacted: true`.
4. The five-validator ladder shows 0 FAIL:
   - `tools/Test-AisrafPackage.ps1`
   - `tools/Test-AisrafBp12AReadiness.ps1`
   - `tools/Test-AisrafRunProfile.ps1` against `runs/RUN-SMOKE-PLUGIN-L2B-001/run-profile.yaml`
   - `tools/Test-AisrafRunProfile.ps1` against `runs/RUN-001/run-profile.yaml`
   - `tools/Test-AisrafRunProfile.ps1` against `runs/RUN-SMOKE-AM3-001/run-profile.yaml`
5. `runs/RUN-001/` and `samples/` remain byte-unchanged.
6. No AM4 / AL4 artifact, claim, or reference is introduced.

## 4. DoD For WP-12C-AM3-EVIDENCE (Final AM3 Gate Before REL0-CLOSE)

WP-12C-AM3-EVIDENCE is **done** when all of the following are true:

1. A founder-approved AM3 smoke run is executed locally against `runs/RUN-SMOKE-AM3-001/`. The run produces all six steps' handoff request/response pairs, the run-state file, the events log, and the per-step Markdown outputs under `{{output_root}}`.
2. `tools/Test-AisrafAm3Runtime.ps1` against the smoke run reports 0 FAIL.
3. The five-validator ladder (§3.4) reports 0 FAIL.
4. The AM3 evidence report (`validation/package-12c-am3-evidence-report.md`, authored in that gate) records:
   - Each AM3 step's specialist, handoff timestamps, validator outcome, and produced output paths.
   - Each human gate's request, decision, reviewer identity, and timestamp.
   - Explicit overclaim-guard pass: no destination URL, no external connector activation, no MCP, no cloud, no database, no Terraform, no event bus, no telemetry backend, no closed-loop autonomy.
   - `git diff` proof that canonical surfaces, projection surfaces, `runs/RUN-001/`, and `samples/` are unchanged.
5. `PACKAGE-MANIFEST.yaml` is updated to `current_autonomy_level: AL3_local_orchestrated_multi_agent_runtime` and `wp12c_am3_evidence_status: PASS`. `al4_status` remains `future_external_adapter_post_back_execution_not_current_release`.
6. `docs/ROADMAP.md` is updated to reflect that AM3 is delivered in v0.1.2; AM4 remains deferred.
7. Founder sign-off is recorded for `WP-12C-AM3_EVIDENCE_PASS_READY_FOR_REL0_CLOSE`.

## 5. AM3 Lane DoD Roll-Up

The AM3 lane as a whole is **done** when:

- WP-12C-AM3-PLAN, WP-12C-AM3-CONTRACTS, WP-12C-AM3-RUNTIME, and WP-12C-AM3-EVIDENCE all closed in order with their per-gate DoDs satisfied.
- No AM4 / AL4 artifact, capability, or claim exists in any AM3 lane file.
- No closed-loop autonomy artifact, capability, or claim exists.
- The five-validator ladder is 0 FAIL.
- Canonical and projection surfaces are byte-unchanged from their post-REL0-C-FIX-A state, except for the explicitly authorized AM3 lane files.

## 6. Non-Goals (Explicit)

AM3 lane DoD does **not** require:

- A second sample under `samples/`.
- A change to `runs/RUN-001/` content.
- A new prompt, a new skill, a new PRA, or a new template.
- A new catalog or blueprint.
- A new provider projection.
- A diagram or release visual (those are WP-13).
- A marketplace publication or external integration.
- Any AM4 / AL4 capability.

If any of these appear in AM3 lane work, the lane fails the overclaim guard and the AM3 status is set to BLOCKED.
