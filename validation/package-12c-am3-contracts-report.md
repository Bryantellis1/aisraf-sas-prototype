# WP-12C-AM3-CONTRACTS — Orchestrator, Handoff, State, Event, Gate, And Validation Contracts

| Field | Value |
|---|---|
| Work package | WP-12C-AM3-CONTRACTS — AM3 Orchestrator Contract, Handoff Contract, Run-State Schema, Event/Checkpoint Schema, Human-Gate Contract |
| Mission | Author the AM3 contract layer only. Define the orchestrator contract, specialist handoff contract, run-state schema, event/checkpoint schema, and human-gate contract required for the later AM3 runtime. Do not implement runtime code in this gate. |
| Predecessor accepted state | `WP-12C-AM3_PLAN_PASS_READY_FOR_AM3_CONTRACTS`. REL0-C baseline committed; AM3-PLAN defined scope, architecture, definition of done, test plan, and risk register. |
| Founder direction | AM3 is now an in-release target before final v0.1.2 publish. AM4 adapters remain future. AL5 closed-loop autonomy remains out of scope. |
| Agents | `AG-AISRAF-ARCHITECTURE-TRACEABILITY-R1`, `AG-AISRAF-RELEASE-MANAGER-R1`, `AG-AISRAF-VERSION-CONTROL-HYGIENE-R1`, `AG-AISRAF-SECURITY-OVERCLAIM-GUARD-R1` |
| Current release truth (before AM3 lane completes) | AISRAF v0.1.2 is an AL2 controlled-output local security architecture review workbench. It is orchestrator-first and multi-agent packaged. It is not yet a true AL3 runtime. |
| Target release truth (after AM3 lane completes) | AISRAF v0.1.2 may claim AL3 local orchestrated multi-agent runtime only after AM3-CONTRACTS, AM3-RUNTIME, AM3-EVIDENCE/SMOKE, and AM3-QA pass. |
| Mode | Contracts only. No runtime code is created by this WP. No AM3 runner exists yet. No AM3 smoke run is created. No push, publish, or stage. |

This report is the closure artifact for WP-12C-AM3-CONTRACTS. It records the AM3 contract layer authored under `config/`, the validator allow-list extensions required to admit those files, the manifest and roadmap re-positioning, the bundle rebuild, the four-validator ladder result, and the git-hygiene posture.

---

## 1. Orchestrator Contract

**Status:** authored.

**File:** `config/am3.orchestrator-contract.v0_1_2.yaml`.

**Contract ID:** `am3.orchestrator-contract.v0_1_2`. **Owner:** `PRA-01-SAS-REVIEW-ORCHESTRATOR` (projection: `.agents/aisraf-orchestrator.agent.md`). **Autonomy target:** `AL3_local_orchestrated_multi_agent_runtime`.

State ownership records that the orchestrator owns the run-state file at `{{output_root}}/runtime/run-state.yaml`, that specialists do not mutate run-state directly, that specialists return structured responses (`am3.handoff_response.v0_1_2`), and that the orchestrator advances, pauses, or stops the run.

The delegation map encodes the AM3 step→specialist binding exactly as planned, with no extra AM3 steps and no role collapse:

- `AM3-INIT` → `PRA-01-SAS-REVIEW-ORCHESTRATOR` (orchestrator-internal; no specialist handoff).
- `AM3-01` → `PRA-02-INPUT-READER`.
- `AM3-02` → `PRA-03-DFD-EXTRACTOR` with `PRA-04-LEGEND-NORMALIZER` invoked inside as the legend normalization subskill (PR-DFD-04); PRA-04 is not promoted to a separate AM3 step.
- `AM3-03` → `PRA-05-REVIEW-TABLE-BUILDER`.
- `AM3-04` → `PRA-06-BLUEPRINT-QUESTIONER`.
- `AM3-05` → `PRA-07-FINDING-RECOMMENDER`.
- `AM3-06` → `PRA-08-HANDOFF-QA-SCORER`.
- `AM3-FINAL-GATE` → `PRA-01-SAS-REVIEW-ORCHESTRATOR` (orchestrator-internal; final PASS / PARTIAL / FAIL / `not_applicable` decision requires an explicit gate event).

Human gates encode the five required gates from PRA-01 §8 plus the final-verdict gate: `pre_run_approval`, `pre_output_generation_approval`, `final_review_approval`, `release_or_claim_approval`, and `final_pass_partial_fail_not_applicable_decision`. Each gate carries `gate_id`, `gate_reason`, `approval_required_by`, `approved_action`, `forbidden_actions`, `evidence_required`, and `stop_condition`. The orchestrator must pause until a paired `gate_decision` event is received; it may not skip or self-approve a required gate.

Stop conditions: `validator fail`, `schema fail`, `missing handoff response`, `output outside allowed path`, `external execution attempt`, `sensitive-data violation`, `unsupported connector state`, and `human gate denied`. Each stop emits a `stop` event and sets run-state.status to `stopped` or `failed`.

Forbidden side effects (closed, exact list): no Jira execution, no Confluence post-back execution, no Lucidchart adapter execution, no Rovo/MCP execution, no Anthropic/Azure AI Foundry/Google ADK/Microsoft Agent Framework runtime adapter execution, no cloud runtime, no database write-back, no Terraform execution, no event bus integration, no telemetry backend emission, no closed-loop autonomy, and no AM4 / AL4 adapter operation of any kind.

## 2. Specialist Handoff Contract

**Status:** authored.

**File:** `config/am3.handoff-contract.v0_1_2.yaml`.

**Contract ID:** `am3.handoff-contract.v0_1_2`.

Request path target: `{{output_root}}/runtime/handoffs/<step-id>/request.yaml`. Response path target: `{{output_root}}/runtime/handoffs/<step-id>/response.yaml`. The step-id token is restricted to `AM3-01` through `AM3-06`; `AM3-INIT`, `AM3-FINAL-GATE`, `AM3-COMPLETE`, and `AM3-STOPPED` are orchestrator-internal and do not issue handoffs.

Required request fields: `schema_version`, `run_id`, `step_id`, `specialist_agent_id`, `required_inputs`, `allowed_output_paths`, `upstream_artifacts`, `expected_outputs`, `validation_route`, `human_gate_required`, `external_execution_allowed` (constant `false`).

Required response fields: `schema_version`, `run_id`, `step_id`, `specialist_agent_id`, `produced_outputs`, `missing_inputs`, `unknowns_preserved`, `validation_status`, `evidence_refs`, `next_recommended_state`, `external_execution_performed` (constant `false`).

The contract closes the handoff loop with explicit invariants: request precedes specialist invocation, response precedes validator outcome, validator outcome precedes the next request, human-gate request precedes human-gate decision, steps may not be skipped, replay with modified request or response is rejected, and any response that sets `external_execution_performed: true` or names a destination URL triggers an immediate `stop` event.

## 3. Run-State Schema

**Status:** authored.

**File:** `config/am3.run-state.schema.v0_1_2.yaml`.

**Schema ID:** `am3.run_state.v0_1_2`. **Path target:** `{{output_root}}/runtime/run-state.yaml`.

Required fields: `schema_version`, `package_version`, `run_id`, `current_step`, `last_completed_step`, `pending_human_gate`, `last_checkpoint_id`, `status`, `created_at`, `updated_at`, `output_root`, `event_log_path`.

`current_step` enum (closed): `AM3-INIT`, `AM3-01`, `AM3-02`, `AM3-03`, `AM3-04`, `AM3-05`, `AM3-06`, `AM3-FINAL-GATE`, `AM3-COMPLETE`, `AM3-STOPPED`.

`status` enum (closed): `initialized`, `running`, `waiting_for_human`, `stopped`, `complete`, `failed`.

`pending_human_gate` is either `null` or one of the five required gate identifiers from the orchestrator contract. `event_log_path` is pinned by pattern to `runtime/events.ndjson` so the absolute event log path is `{{output_root}}/runtime/events.ndjson`.

Strict-field rule: `additionalProperties: false`. The schema enumerates a closed `forbidden_fields` list (`destination_url`, `jira_ticket_id`, `confluence_page_id`, `lucidchart_document_id`, `mcp_server_url`, `mcp_client_token`, `cloud_resource_id`, `database_connection_string`, `terraform_workspace`, `event_bus_topic`, `telemetry_backend_endpoint`, credentials, API keys, email addresses, and customer-identifying strings) so that no permitted extension can re-introduce external-execution surface.

Allowed transitions encode the exact step order plus the universal `AM3-STOPPED` terminal sink. `AM3-COMPLETE` and `AM3-STOPPED` have no successors.

## 4. Event / Checkpoint Schema

**Status:** authored.

**File:** `config/am3.event.schema.v0_1_2.yaml`.

**Schema ID:** `am3.event.v0_1_2`. **Path target:** `{{output_root}}/runtime/events.ndjson`. Append-only, one event per line, UTF-8, line-delimited.

Required fields per event: `schema_version`, `event_id`, `run_id`, `timestamp`, `event_type`, `step_id`, `actor`, `checkpoint_id`, `previous_state`, `next_state`, `input_ref`, `output_ref`, `validator_ref`, `policy_decision`, `human_gate_ref`.

`event_type` enum (closed): `orchestrator_decision`, `handoff_request`, `handoff_response`, `validator_outcome`, `gate_request`, `gate_decision`, `stop`.

`actor` enum (closed): the orchestrator (`PRA-01-SAS-REVIEW-ORCHESTRATOR`), the seven specialist PRAs including `PRA-04-LEGEND-NORMALIZER`, `human_reviewer`, and `validator`.

Per-event-type invariants pin the actor, the required policy decision values, and the required predecessor event. The schema records ordering invariants: monotonically increasing `event_id`, non-decreasing `timestamp`, `handoff_request → handoff_response → validator_outcome → next handoff_request` ordering, paired `gate_request → gate_decision`, and `stop` as terminal for the run.

Strict-field rule: `additionalProperties: false`. The same closed `forbidden_fields` list as the run-state schema applies.

## 5. Human-Gate Contract

**Status:** authored (embedded in the orchestrator contract under `human_gates`).

**Required fields per gate:** `gate_id`, `gate_reason`, `approval_required_by`, `approved_action`, `forbidden_actions`, `evidence_required`, `stop_condition`.

**Required gates (exact list):**

- `pre_run_approval` — reviewer confirms run profile, sensitive-data redaction, and controlled-output posture before any specialist handoff is issued.
- `pre_output_generation_approval` — reviewer confirms DFD intake results are within controlled-output posture before downstream specialists generate review outputs.
- `final_review_approval` — reviewer confirms findings, recommendations, and handoff pack are complete before the final verdict is recorded.
- `release_or_claim_approval` — reviewer confirms the AM3 evidence does not overclaim AM4 / AL4 / AL5 capability and does not loosen AL2 security controls.
- `final_pass_partial_fail_not_applicable_decision` — final PASS / PARTIAL / FAIL / `not_applicable` decision requires an explicit gate event regardless of internal verdict.

Pause semantics: the orchestrator pauses run-state at `waiting_for_human` until a paired `gate_decision` event is received; the orchestrator may not skip a required gate; the orchestrator may not self-approve a gate.

## 6. AM3 vs AM4 Boundary

The orchestrator and handoff contracts both declare the AM3 / AM4 boundary explicitly. AM3 may create local state files, append a local event log, emit local checkpoints, emit local handoff files, and produce local controlled outputs under `{{output_root}}`. AM3 may not execute Jira, Confluence, Lucidchart, Rovo MCP, any other MCP server or client, any cloud runtime, any database write-back, Terraform, an event bus, or a telemetry backend, and may not post back any artifact. AM4 begins only after AM3 is implemented, smoked, and QA-passed. AL5 closed-loop autonomy remains out of scope. The contract layer enforces this boundary via the closed `forbidden_side_effects` list, the closed `forbidden_fields` lists on the run-state and event schemas, the constant `false` values on `external_execution_allowed` and `external_execution_performed`, and the stop-event coupling for any boundary violation.

## 7. Manifest And Roadmap Alignment

**Status:** aligned.

`PACKAGE-MANIFEST.yaml` re-positions the current build package to `12C-AM3-CONTRACTS` (`active_am3_contracts_orchestrator_handoff_run_state_event_human_gate`) and the next build package to `12C-AM3-RUNTIME` (`blocked_pending_wp_12c_am3_contracts_pass`). `wp12c_am3_plan_status` advances to `BLACK_CLOSED`, `wp12c_am3_contracts_status` advances to `ACTIVE`, `wp12c_am3_runtime_status` remains `BLOCKED_PENDING_WP_12C_AM3_CONTRACTS_PASS`, and the `current_gate` / `next_gate` fields are advanced accordingly. `current_autonomy_level` remains `AL2_controlled_output_local_workbench`; `target_autonomy_level_for_v0_1_2` remains `AL3_local_orchestrated_multi_agent_runtime_via_wp_12c_am3_lane`. No AL3 claim is asserted; no AM4 claim is asserted.

`docs/ROADMAP.md` adds a `Contracts authored by` header row, marks WP-12C-AM3-PLAN as predecessor, names the four AM3 contract / schema files explicitly under WP-12C-AM3-CONTRACTS, and updates the release-gate sequence to identify WP-12C-AM3-CONTRACTS as the current gate.

## 8. Validator Allow-List Extension

**Status:** extended.

`tools/Test-AisrafPackage.ps1` is extended as follows:

- `$validationAllowed` is extended with one exact filename: `package-12c-am3-contracts-report.md` (this report).
- `$configAllowed` is extended with four exact filenames: `am3.orchestrator-contract.v0_1_2.yaml`, `am3.handoff-contract.v0_1_2.yaml`, `am3.run-state.schema.v0_1_2.yaml`, `am3.event.schema.v0_1_2.yaml`. A narrow comment above the append-list records that the extension exists only because WP-12C-AM3-CONTRACTS deliberately authored the four AM3 contract / schema files under `config/`.
- The `13-config-allowed` PASS message is updated in place to name the new WP-12C-AM3-CONTRACTS allowance for traceability.

No wildcards are introduced. No broad `config/` allowance is introduced. No broad `validation/` allowance is introduced.

`tools/Test-AisrafBp12AReadiness.ps1` is **not** modified in this WP. The four tracked-drift paths touched here (`PACKAGE-MANIFEST.yaml`, `docs/ROADMAP.md`, `tools/Test-AisrafPackage.ps1`, `tools/Test-AisrafBp12AReadiness.ps1`) are already covered by the existing exact-path allow-list groups (`$wp12cK1bAuthorityPatchDrift`, `$wp12cAm3PlanRoadmapDrift`, `$wp12cK3bValidatorPatchDrift`), and the bundle-side paths are already covered by `$wp12cK3cExactFutureDrift` and `$wp12cK3cExactFutureDriftPrefixes`. The four new `config/am3.*.yaml` files are new untracked files and therefore do not appear in `git diff --name-only`; they are admitted by the `13-config-allowed` package validator check, which is exhaustive for `config/`.

## 9. Plugin Bundle Rebuild

**Status:** rebuilt; checksum matched.

```
pwsh -NoProfile -File ./tools/Build-AisrafCopilotPluginBundle.ps1 -Clean
```

Result: `PASS  199 files bundled, all source/target SHA-256 match.` The plugin-bundle copies of `tools/Test-AisrafPackage.ps1` and `tools/Test-AisrafBp12AReadiness.ps1`, plus the bundle checksum manifest at `plugins/aisraf-copilot-plugin/bundle-checksum-manifest.yaml`, are regenerated only via `tools/Build-AisrafCopilotPluginBundle.ps1 -Clean` (the documented K3C pattern). `plugin.json` and `plugin.yaml` are untouched.

## 10. Four-Validator Ladder

| Validator | Result |
|---|---|
| `tools/Test-AisrafPackage.ps1` | 83 PASS, 2 WARN, 0 FAIL |
| `tools/Test-AisrafBp12AReadiness.ps1` | 77 PASS, 0 FAIL |
| `tools/Test-AisrafRunProfile.ps1 -RunProfilePath ./runs/RUN-SMOKE-PLUGIN-L2B-001/run-profile.yaml -ExecutionReady` | 12 PASS, 0 FAIL |
| `tools/Test-AisrafRunProfile.ps1 -RunProfilePath ./runs/RUN-001/run-profile.yaml -ExecutionReady` | 12 PASS, 0 FAIL |

The two `Test-AisrafPackage.ps1` WARNs are the pre-existing `14-runs-readme-only` notices for `runs/RUN-SMOKE-LOCAL-001/` and `runs/RUN-SMOKE-PLUGIN-L2B-001/` (gitignored smoke run folders flagged for removal before human git stage). No new WARN or FAIL is introduced by WP-12C-AM3-CONTRACTS.

## 11. Git Hygiene Posture

| Command | Posture |
|---|---|
| `git status --short` | clean: only the AM3-PLAN and AM3-CONTRACTS files modified or newly added; no broader workspace drift. |
| `git diff --name-only` | restricted to `PACKAGE-MANIFEST.yaml`, `docs/ROADMAP.md`, `plugins/aisraf-copilot-plugin/bundle-checksum-manifest.yaml`, `plugins/aisraf-copilot-plugin/bundle/tools/Test-AisrafBp12AReadiness.ps1`, `plugins/aisraf-copilot-plugin/bundle/tools/Test-AisrafPackage.ps1`, `tools/Test-AisrafBp12AReadiness.ps1`, `tools/Test-AisrafPackage.ps1`. All within existing BP12A exact-path allow-list groups. |
| `git diff --staged --name-only` | empty (nothing staged; WP-12C-AM3-CONTRACTS does not stage). |
| `git ls-files -- .claude` | empty (`.claude/` is not tracked). |
| `git diff --cached --name-only -- .claude` | empty. |
| `git check-ignore -v .claude/ runs/RUN-SMOKE-LOCAL-001/ runs/RUN-SMOKE-PLUGIN-L2B-001/` | `.claude/` and smoke run folders are gitignored (matched against `.git/info/exclude`). |
| `git diff -- runs/RUN-001/` | empty (RUN-001 fixture untouched). |
| `git diff -- samples/` | empty (samples surface untouched). |
| `git diff -- prompts/ skills/ prototype-agents/ templates/ catalogs/ blueprints/` | empty (canonical review-chain surfaces untouched). |
| `git diff -- .agents/ .github/agents/ .github/skills/ .github/hooks/ .copilot-skills/` | empty (projection surfaces untouched). |

The seven modified tracked files are all admitted by existing BP12A exact-path allow-list groups. No allow-list extension was required for AM3-CONTRACTS in `tools/Test-AisrafBp12AReadiness.ps1`. The four new `config/am3.*.yaml` files and this report (`validation/package-12c-am3-contracts-report.md`) are new untracked files, admitted by the `13-config-allowed` and `11-validation-allowed` checks in the extended `tools/Test-AisrafPackage.ps1`.

## 12. Closure Register

```yaml
work_package_status: WP-12C-AM3_CONTRACTS_PASS_READY_FOR_AM3_RUNTIME
files_created:
  - config/am3.orchestrator-contract.v0_1_2.yaml
  - config/am3.handoff-contract.v0_1_2.yaml
  - config/am3.run-state.schema.v0_1_2.yaml
  - config/am3.event.schema.v0_1_2.yaml
  - validation/package-12c-am3-contracts-report.md
files_changed:
  - tools/Test-AisrafPackage.ps1
  - PACKAGE-MANIFEST.yaml
  - docs/ROADMAP.md
  - plugins/aisraf-copilot-plugin/bundle/tools/Test-AisrafPackage.ps1
  - plugins/aisraf-copilot-plugin/bundle/tools/Test-AisrafBp12AReadiness.ps1
  - plugins/aisraf-copilot-plugin/bundle-checksum-manifest.yaml
orchestrator_contract_status: authored_owner_pra_01_state_owned_delegation_map_complete_human_gates_complete_stop_conditions_complete_forbidden_side_effects_complete
specialist_handoff_contract_status: authored_request_and_response_field_sets_complete_external_execution_constants_false_path_guard_and_sensitive_data_screen_coupled_validator_coupled
runtime_state_schema_status: authored_required_field_set_complete_current_step_enum_closed_status_enum_closed_additional_properties_false_allowed_transitions_pinned
event_checkpoint_schema_status: authored_required_field_set_complete_event_type_enum_closed_actor_enum_closed_per_event_type_invariants_pinned_ordering_invariants_pinned_additional_properties_false
human_gate_contract_status: authored_embedded_in_orchestrator_contract_required_fields_complete_five_required_gates_listed_pause_semantics_pinned
am3_vs_am4_boundary_status: explicit_local_only_for_am3_external_systems_deferred_for_am4_constants_false_on_external_execution_flags_no_destination_url_field_anywhere
manifest_alignment_status: package_manifest_yaml_marks_wp_12c_am3_contracts_active_and_wp_12c_am3_plan_black_closed_current_gate_and_next_gate_advanced_no_al3_claim
roadmap_alignment_status: docs_roadmap_md_marks_wp_12c_am3_contracts_current_gate_names_four_authored_config_files_no_al3_or_am4_overclaim
validator_results:
  test_aisraf_package: 83 PASS, 2 WARN, 0 FAIL
  test_aisraf_bp12a_readiness: 77 PASS, 0 FAIL
  test_aisraf_run_profile_smoke_l2b: 12 PASS, 0 FAIL
  test_aisraf_run_profile_run_001: 12 PASS, 0 FAIL
git_hygiene_results:
  staged_files: none
  claude_tracked_or_staged: no
  smoke_run_folders_gitignored: yes
  run001_diff: empty
  samples_diff: empty
  canonical_surface_diff: empty
  projection_surface_diff: empty
  tracked_drift_admitted_by_existing_bp12a_exact_path_groups: yes
  new_untracked_files_admitted_by_extended_test_aisraf_package_ps1_allow_lists: yes
run001_status: untouched_clean
samples_status: untouched_clean
canonical_surface_status: untouched_clean
projection_surface_status: untouched_clean
plugin_bundle_status: rebuilt_and_checksum_matched_199_files_all_sha_256_pairs_validate
remaining_blockers: none for WP-12C-AM3-CONTRACTS; WP-12C-AM3-RUNTIME remains blocked until founder authorizes the runner / runtime validator / smoke run; WP-13 release visuals remain blocked by REL0 closure and BP12-SAMPLE-DFD blocker.
may_AM3_RUNTIME_proceed: yes_after_founder_sign_off_of_wp_12c_am3_contracts
may_AM3_SMOKE_proceed: no_blocked_pending_wp_12c_am3_runtime_pass
may_AM4_ADAPTERS_proceed: no_future_only_blocked_pending_wp_12c_am3_evidence_and_wp_12c_am3_qa_close
may_WP13_proceed: no_blocked_pending_rel0_closure_and_bp12_sample_dfd_blocker_resolution
may_push_or_publish_proceed: no_not_authorized_in_this_wp
exact_next_gate: WP-12C-AM3-RUNTIME (author tools/Invoke-AisrafAm3LocalRun.ps1 local runner, tools/Test-AisrafAm3Runtime.ps1 runtime validator, and runs/RUN-SMOKE-AM3-001/run-profile.yaml smoke run profile; local-only; no AM4 adapter work).
```

---

## 13. Forbidden / Out-Of-Scope Confirmation

The following were not started, modified, or claimed during WP-12C-AM3-CONTRACTS:

- AM3 runner — not implemented; `tools/Invoke-AisrafAm3LocalRun.ps1` does not exist.
- AM3 runtime validator — not authored; `tools/Test-AisrafAm3Runtime.ps1` does not exist.
- AM3 smoke run — not created; `runs/RUN-SMOKE-AM3-001/` does not exist.
- AM4 adapters — not started; future lane.
- AL5 closed-loop autonomy — out of scope.
- Any push, publish, stage, `git add .`, or `git add -A` — none performed.
- Any edit to `RUN-001/`, `samples/`, `prompts/`, `skills/`, `prototype-agents/`, `templates/`, `catalogs/`, `blueprints/`, `.agents/`, `.github/agents/`, `.github/skills/`, `.github/hooks/`, or `.copilot-skills/` — none performed.
- Any edit to `plugin.json` or `plugin.yaml` — none performed.
- Any AL3 / AL4 / AL5 current-state claim — none made.
- Any claim that AM3 is implemented — none made; AM3-CONTRACTS authors contracts only.
