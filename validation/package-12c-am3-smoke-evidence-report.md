# WP-12C-AM3-SMOKE Evidence Report

work_package_status: WP-12C-AM3_SMOKE_BLOCKED_WITH_REASON

files_created:
- runs/RUN-SMOKE-AM3-001/
- runs/RUN-SMOKE-AM3-001/00-run-log.md
- runs/RUN-SMOKE-AM3-001/run-profile.yaml
- runs/RUN-SMOKE-AM3-001/dfd/
- runs/RUN-SMOKE-AM3-001/inputs/cloud-triage-notes.md
- runs/RUN-SMOKE-AM3-001/inputs/dfd-crop.mmd
- runs/RUN-SMOKE-AM3-001/inputs/dfd-crop.png
- runs/RUN-SMOKE-AM3-001/inputs/dfd-legend-excerpt.md
- runs/RUN-SMOKE-AM3-001/inputs/intake-ticket.md
- runs/RUN-SMOKE-AM3-001/inputs/review-transcript.md
- runs/RUN-SMOKE-AM3-001/runtime/ (empty; runner created directory before blocking)
- validation/package-12c-am3-smoke-evidence-report.md

files_changed:
- runs/RUN-SMOKE-AM3-001/run-profile.yaml (new file; sensitive_data_confirmed_redacted set true after sample input screen)
- tools/Test-AisrafPackage.ps1 (exact validation allow-list addition for this evidence report)
- plugins/aisraf-copilot-plugin/bundle/tools/Test-AisrafPackage.ps1 (bundle projection via tools/Build-AisrafCopilotPluginBundle.ps1 -Clean)
- plugins/aisraf-copilot-plugin/bundle-checksum-manifest.yaml (bundle checksum refresh via tools/Build-AisrafCopilotPluginBundle.ps1 -Clean)

smoke_run_created: true_under_runs_RUN-SMOKE-AM3-001_only
run_profile_status: pass_after_operator_screen; New-AisrafRun scaffold initially produced 11 PASS, 1 FAIL until sensitive_data_confirmed_redacted was set true; final validator result was 12 PASS, 0 FAIL

runner_parameter_discovery:
- tools/Invoke-AisrafAm3LocalRun.ps1 supports RunProfilePath, HumanGateDecision approve_or_deny, DenyGateId, and Force
- tools/Test-AisrafAm3Runtime.ps1 runtime mode supports RunProfilePath and optional OutputRoot; it does not expose RunRoot

runner_invocation: pwsh -NoProfile -File ./tools/Invoke-AisrafAm3LocalRun.ps1 -RunProfilePath ./runs/RUN-SMOKE-AM3-001/run-profile.yaml -HumanGateDecision approve
runner_result: blocked_before_first_handoff; Cannot bind argument to parameter 'UpstreamArtifacts' because it is an empty array.

runtime_state_status: fail_missing_runs_RUN-SMOKE-AM3-001_runtime_run-state_yaml
event_log_status: fail_missing_runs_RUN-SMOKE-AM3-001_runtime_events_ndjson
event_count: 0
handoff_request_status: fail_AM3_01_through_AM3_06_request_yaml_missing
handoff_response_status: fail_AM3_01_through_AM3_06_response_yaml_missing
step_order_status: blocked_no_event_log_or_handoff_sequence_to_validate
orchestrator_state_ownership_status: blocked_no_run_state_written_by_orchestrator
specialist_handoff_status: blocked_no_structured_specialist_handoff_pairs_written
pra04_inside_am3_02_status: blocked_missing_AM3_02_handoff; validator check 19 failed because PRA-04 embedded evidence is absent
human_gate_status: blocked_not_represented_in_runtime_events; invocation supplied HumanGateDecision approve but runner stopped before writing gate_request/gate_decision events
stop_path_status: not_executed; denial mode is discoverable in the runner, but runtime-negative execution was not attempted because positive smoke blocked and AM3 plan/test docs did not explicitly authorize a runtime-negative run-profile workaround
am3_vs_am4_boundary_status: pass_local_only_no_AM4_adapter_execution_no_AM4_artifacts_no_external_postback
sensitive_data_status: pass_for_run_profile_and_validator_fixture_screen; sample inputs are governed synthetic fixture files, run profile sensitive-data screen passed, and runtime validator sensitive-data screen had no runtime hits because runtime artifacts were not written
external_execution_status: pass_no_Jira_no_Confluence_no_Lucidchart_no_Rovo_MCP_no_cloud_no_database_no_Terraform_no_event_bus_no_telemetry_no_postback_no_push_no_publish_no_stage

am3_validator_results:
- pwsh -NoProfile -File ./tools/Test-AisrafAm3Runtime.ps1 -ContractsOnly: PASS 4 PASS, 0 FAIL
- pwsh -NoProfile -File ./tools/Test-AisrafAm3Runtime.ps1 -RunProfilePath ./runs/RUN-SMOKE-AM3-001/run-profile.yaml: FAIL 8 PASS, 16 FAIL
- runtime_failures: missing run-state.yaml, missing events.ndjson, missing AM3-01 through AM3-06 request/response files, no events parsed, PRA-04 embedded evidence missing from AM3-02 handoff

full_validator_results:
- preflight pwsh -NoProfile -File ./tools/Test-AisrafPackage.ps1: PASS 83 PASS, 2 WARN, 0 FAIL
- preflight pwsh -NoProfile -File ./tools/Test-AisrafBp12AReadiness.ps1: PASS 77 PASS, 0 FAIL
- preflight pwsh -NoProfile -File ./tools/Test-AisrafRunProfile.ps1 -RunProfilePath ./runs/RUN-SMOKE-PLUGIN-L2B-001/run-profile.yaml -ExecutionReady: PASS 12 PASS, 0 FAIL
- preflight pwsh -NoProfile -File ./tools/Test-AisrafRunProfile.ps1 -RunProfilePath ./runs/RUN-001/run-profile.yaml -ExecutionReady: PASS 12 PASS, 0 FAIL
- preflight pwsh -NoProfile -File ./tools/Test-AisrafAm3Runtime.ps1 -ContractsOnly: PASS 4 PASS, 0 FAIL
- create-run final pwsh -NoProfile -File ./tools/Test-AisrafRunProfile.ps1 -RunProfilePath ./runs/RUN-SMOKE-AM3-001/run-profile.yaml -ExecutionReady: PASS 12 PASS, 0 FAIL
- full ladder pwsh -NoProfile -File ./tools/Test-AisrafPackage.ps1: PASS 83 PASS, 3 WARN, 0 FAIL
- full ladder pwsh -NoProfile -File ./tools/Test-AisrafBp12AReadiness.ps1: PASS 77 PASS, 0 FAIL
- full ladder pwsh -NoProfile -File ./tools/Test-AisrafRunProfile.ps1 -RunProfilePath ./runs/RUN-SMOKE-AM3-001/run-profile.yaml -ExecutionReady: PASS 12 PASS, 0 FAIL
- full ladder pwsh -NoProfile -File ./tools/Test-AisrafRunProfile.ps1 -RunProfilePath ./runs/RUN-SMOKE-PLUGIN-L2B-001/run-profile.yaml -ExecutionReady: PASS 12 PASS, 0 FAIL
- full ladder pwsh -NoProfile -File ./tools/Test-AisrafRunProfile.ps1 -RunProfilePath ./runs/RUN-001/run-profile.yaml -ExecutionReady: PASS 12 PASS, 0 FAIL
- full ladder pwsh -NoProfile -File ./tools/Test-AisrafAm3Runtime.ps1 -ContractsOnly: PASS 4 PASS, 0 FAIL
- full ladder pwsh -NoProfile -File ./tools/Test-AisrafAm3Runtime.ps1 -RunProfilePath ./runs/RUN-SMOKE-AM3-001/run-profile.yaml: FAIL 8 PASS, 16 FAIL
- post-report package validator before allow-list patch: FAIL 82 PASS, 3 WARN, 1 FAIL for validation/package-12c-am3-smoke-evidence-report.md
- post-allow-list package validator: PASS 83 PASS, 3 WARN, 0 FAIL
- post-allow-list full ladder final result: all non-runtime validators PASS; AM3 runtime mode remains FAIL 8 PASS, 16 FAIL due missing runtime artifacts

git_hygiene_results:
- git status --short after evidence report and allow-list patch: 24 rows; no staged files; includes pre-existing AM3 contract/runtime artifacts plus runs/RUN-SMOKE-AM3-001/ and validation/package-12c-am3-smoke-evidence-report.md
- git diff --name-only after evidence report and allow-list patch: PACKAGE-MANIFEST.yaml, docs/ROADMAP.md, plugins/aisraf-copilot-plugin/bundle-checksum-manifest.yaml, plugins/aisraf-copilot-plugin/bundle/tools/Test-AisrafBp12AReadiness.ps1, plugins/aisraf-copilot-plugin/bundle/tools/Test-AisrafPackage.ps1, tools/Build-AisrafCopilotPluginBundle.ps1, tools/Test-AisrafBp12AReadiness.ps1, tools/Test-AisrafPackage.ps1
- git diff --staged --name-only: empty
- git ls-files -- .claude: empty
- git diff --cached --name-only -- .claude: empty
- git check-ignore -v .claude/ runs/RUN-SMOKE-LOCAL-001/ runs/RUN-SMOKE-PLUGIN-L2B-001/: all three ignored by .git/info/exclude
- git diff -- runs/RUN-001/: empty
- git diff -- samples/: empty
- git diff -- prompts/ skills/ prototype-agents/ templates/ catalogs/ blueprints/ config/ .agents/ .github/agents/ .github/skills/ .github/hooks/ .copilot-skills/: empty
- smoke output location: runs/RUN-SMOKE-AM3-001/ only
- staged_files_status: none

run001_status: unchanged_git_diff_empty
samples_status: unchanged_git_diff_empty
canonical_surface_status: unchanged_for_prompts_skills_prototype-agents_templates_catalogs_blueprints_config
projection_surface_status: unchanged_for_agents_github_agents_github_skills_github_hooks_and_copilot_skills
plugin_bundle_status: rebuilt_by_tools_Build_AisrafCopilotPluginBundle_ps1_Clean_201_entries_after_exact_validation_allowlist_patch

remaining_blockers:
- Positive AM3 smoke runner blocks before AM3-01 because Write-HandoffPair receives an empty UpstreamArtifacts array on the first step.
- Required runtime evidence artifacts were not produced: run-state.yaml, events.ndjson, and AM3-01 through AM3-06 request/response pairs.
- Human gates, step order, orchestrator state ownership, specialist handoffs, and PRA-04-inside-AM3-02 evidence cannot be proven until the runner bug is fixed under an authorized runtime repair gate.
- AM3 QA remains blocked until a successful AM3 smoke/evidence rerun passes runtime validation.
- AM4 adapters, WP13, push, and publish remain blocked.

may_AM3_QA_proceed: false
may_AM4_ADAPTERS_proceed: false
may_WP13_proceed: false
may_push_or_publish_proceed: false
exact_next_gate: WP-12C-AM3-RUNTIME-REPAIR_THEN_WP-12C-AM3-SMOKE_RERUN