# WP-12C-L2B Controlled Scratch-Output Smoke Plan

| Field | Value |
|---|---|
| Work package | WP-12C-L2B-PLAN - Controlled Scratch-Output Smoke Plan |
| Agent | AG-AISRAF-SMOKE-TEST-OPERATOR-R1 |
| Status | WP-12C-L2B_PLAN_PASS_READY_FOR_CONTROLLED_OUTPUT_APPROVAL |
| Mode | Planning only; controlled output execution is not authorized by this file |
| Primary scratch run | `runs/RUN-SMOKE-PLUGIN-L2B-001/` |
| Input source | `samples/sample-001-dfd-crop/` |
| Evidence posture | Local-only, no external execution, no post-back execution |

This plan defines how AISRAF will prove controlled local output generation in a founder-approved scratch run while preserving sealed fixtures, canonical assets, provider projections, plugin bundle authority, documentation, release, diagrams, and external integration boundaries.

## 1. Work Package Name And Status

WP-12C-L2B-PLAN - Controlled Scratch-Output Smoke Plan.

Status: WP-12C-L2B_PLAN_PASS_READY_FOR_CONTROLLED_OUTPUT_APPROVAL.

This is a planning gate only. It does not create the scratch run, copy inputs, write a run profile, run prompts, execute skills, invoke PRAs, write outputs, stage files, publish anything, or start WP-13.

## 2. Objective

Prove, during a later approved execution gate, that the installed/plugin-oriented AISRAF operator path can write only the declared local run outputs under one approved scratch run folder.

The proof must show:

- `runs/RUN-001/` remains unchanged.
- `samples/` remains unchanged.
- Canonical assets remain unchanged: `prompts/`, `skills/`, `prototype-agents/`, `templates/`, `catalogs/`, `blueprints/`, and `config/`.
- Provider projections remain unchanged: `.agents/`, `.github/agents/`, `.github/skills/`, `.github/hooks/`, and `.copilot-skills/`.
- The plugin bundle remains unchanged except when validator allow-list changes require bundle/checksum alignment.
- The installed plugin cache remains unchanged.
- `docs/`, `release/`, and `diagrams/` remain unchanged.
- No Jira, Confluence, Lucidchart, MCP, cloud, database, Terraform, or external post-back execution occurs.

## 3. Preconditions

Before L2B execution may begin, all of these must be true:

| Gate | Required Condition |
|---|---|
| Founder approval | Explicit founder approval exists for controlled output execution into `runs/RUN-SMOKE-PLUGIN-L2B-001/`. |
| Clean planning gate | This plan is present in `validation/` and allowed by `tools/Test-AisrafPackage.ps1` using the exact filename only. |
| Scratch run absent before approval | `runs/RUN-SMOKE-PLUGIN-L2B-001/` does not exist before approved execution setup. |
| RUN-001 sealed | `git diff -- runs/RUN-001/` is empty before and after execution. |
| samples sealed | `git diff -- samples/` is empty before and after execution. |
| Canonical surfaces sealed | `git diff -- prompts/ skills/ prototype-agents/ templates/ catalogs/ blueprints/ config/` is empty before and after execution. |
| Provider projections sealed | `git diff -- .agents/ .github/agents/ .github/skills/ .github/hooks/ .copilot-skills/` is empty before and after execution. |
| External integrations disabled | Jira, Confluence, Lucidchart, MCP, cloud, database, Terraform, and external post-back execution remain disabled. |
| Sensitive data review | Operator reviews the scratch inputs and sets `sensitive_data_confirmed_redacted: true` only after confirming no secrets or prohibited data. |
| Known warning acknowledged | `runs/RUN-SMOKE-LOCAL-001/` may remain present as a known WARN and must remain excluded from staging until L3. |

## 4. Proposed Scratch Run Folder

Proposed folder: `runs/RUN-SMOKE-PLUGIN-L2B-001/`.

The folder must not be created during planning. During approved execution setup only, the operator may create this exact folder shape:

```text
runs/RUN-SMOKE-PLUGIN-L2B-001/
  README.md
  run-profile.yaml
  00-run-log.md
  inputs/
  dfd/
```

The folder is scratch evidence, not a replacement for `runs/RUN-001/`. It must remain unstaged unless a later founder-approved evidence package explicitly names it.

## 5. Proposed Input Source

Source: `samples/sample-001-dfd-crop/`.

Planned execution setup after approval:

1. Create `runs/RUN-SMOKE-PLUGIN-L2B-001/inputs/`.
2. Byte-copy the six sample input files from `samples/sample-001-dfd-crop/inputs/` into the scratch inputs folder.
3. Do not edit the source sample files.
4. Do not create or edit `samples/sample-001-dfd-crop/expected/`.
5. Use `samples/sample-001-dfd-crop/expected/` as the read-only expected baseline root.

Required copied input names:

- `dfd-crop.png`
- `dfd-crop.mmd`
- `dfd-legend-excerpt.md`
- `cloud-triage-notes.md`
- `review-transcript.md`
- `intake-ticket.md`

## 6. Planned Run-Profile Fields

The future execution run profile must remain schema-valid under `config/run-profile.schema.yaml`. The schema has `additionalProperties: false`; therefore `external_execution_status` must not be written as a YAML key unless the schema is changed in a separate approved work package. For L2B, `external_execution_status: disabled` is recorded as a planning and evidence-control assertion, represented in the run profile by the local-only fields below.

Planned run-profile posture:

```yaml
schema_version: run_profile.v0_1_2
package_version: v0.1.2
run_id: "RUN-SMOKE-PLUGIN-L2B-001"
sample_id: "sample-001-dfd-crop"
mode: "folder_first_test"
workspace_root: "."
input_root: "runs/RUN-SMOKE-PLUGIN-L2B-001/inputs"
expected_root: "samples/sample-001-dfd-crop/expected"
output_root: "runs/RUN-SMOKE-PLUGIN-L2B-001"
old_reference_workspace: "D:/E-Way 2/aisraf-sas-prototype-skill-chain-pack-v0.01"
source_ticket_url: ""
destination_ticket_url: ""
destination_confluence_url: ""
output_destination_mode: "local_only"
postback_execution_status: "deferred"
jira_connector_status: "not_required"
confluence_connector_status: "not_required"
rovo_mcp_available: false
mcp_execution_status: "not_required"
operator_name: "SAS reviewer"
reviewer_name: "SAS reviewer"
sensitive_data_confirmed_redacted: true
expected_baseline_required: true
scoring_enabled: true
created_at: "<UTC timestamp at approved execution setup>"
notes: "WP-12C-L2B controlled scratch-output smoke run. external_execution_status=disabled as evidence posture; no external post-back execution."
```

Planning-only posture that must be reflected in evidence, not added as unknown YAML fields:

- `external_execution_status: disabled`
- `installed_plugin_cache_changed: false`
- `external_postback_execution: false`

## 7. Planned Output Set

Approved root outputs under `runs/RUN-SMOKE-PLUGIN-L2B-001/`:

- `00-run-log.md`
- `01-input-inventory.md`
- `02-visible-dfd-objects.md`
- `03-legend-normalization.md`
- `04-components.md`
- `05-flows.md`
- `06-boundaries.md`
- `07-security-stack-assessment.md`
- `08-internal-review-table.md`
- `09-missing-facts.md`
- `10-ai-action-level.md`
- `11-blueprint-match.md`
- `12-targeted-questions.md`
- `13-findings.md`
- `14-recommendations.md`
- `15-handoff-pack.md`
- `16-validation-notes.md`
- `17-accuracy-score.md`

Approved DFD outputs under `runs/RUN-SMOKE-PLUGIN-L2B-001/dfd/`:

- `01-intake-quality-check.md`
- `02-boundary-catalog.md`
- `03-component-catalog.md`
- `04-flow-inventory.md`
- `05-annotation-resolution.md`
- `06-boundary-crossings.md`
- `07-control-signals.md`
- `08-confidence-score.md`
- `09-extraction-summary.md`

No Jira draft, Confluence draft, diagram, release, ZIP, DOCX, PDF, PPTX, JSON baseline, database artifact, Terraform artifact, MCP transcript, cloud output, or external post-back artifact is part of this output set.

## 8. Planned Write Order

The approved execution gate must write in this order only:

1. Create the scratch folder and `inputs/` plus `dfd/` folders after approval.
2. Copy the six sample input files into the scratch `inputs/` folder.
3. Write `run-profile.yaml` with the schema-valid fields in Section 6.
4. Run `tools/Test-AisrafRunProfile.ps1 -ExecutionReady` against the scratch run profile.
5. Write or initialize `00-run-log.md`.
6. Write `01-input-inventory.md`.
7. Write `02-visible-dfd-objects.md` through `05-flows.md`.
8. Write `dfd/01-intake-quality-check.md` through `dfd/09-extraction-summary.md`.
9. Write `06-boundaries.md` through `08-internal-review-table.md`.
10. Write `09-missing-facts.md` through `12-targeted-questions.md`.
11. Write `13-findings.md` and `14-recommendations.md`.
12. Write `15-handoff-pack.md` through `17-accuracy-score.md`.
13. Append validation and evidence rows to `00-run-log.md` only if they describe local execution and validator results.

Any proposed write outside this order stops the run unless the founder approves a revised L2B execution plan before the write occurs.

## 9. Planned Role Sequence

| Step | Role | Wrapper | Planned Outputs |
|---|---|---|---|
| R1 | AISRAF Orchestrator | `aisraf-orchestration` | `00-run-log.md` |
| R2 | AISRAF Input Reader | `aisraf-input-read` | `01-input-inventory.md` |
| R3 | AISRAF DFD Extractor | `aisraf-dfd-extraction` | `02-visible-dfd-objects.md` through `05-flows.md`; `dfd/01` through `dfd/09` |
| R4 | AISRAF Review Table Builder | `aisraf-review-table-build` | `06-boundaries.md`, `07-security-stack-assessment.md`, `08-internal-review-table.md` |
| R5 | AISRAF Blueprint Questioner | `aisraf-blueprint-questioning` | `09-missing-facts.md`, `10-ai-action-level.md`, `11-blueprint-match.md`, `12-targeted-questions.md` |
| R6 | AISRAF Finding Recommender | `aisraf-finding-recommendation` | `13-findings.md`, `14-recommendations.md` |
| R7 | AISRAF Handoff QA Scorer | `aisraf-handoff-qa-score` | `15-handoff-pack.md`, `16-validation-notes.md`, `17-accuracy-score.md` |

Each role must read only the approved run profile, scratch inputs, upstream scratch outputs, and canonical references by path. No role may edit canonical assets, provider projections, plugin bundle files, installed plugin cache files, `RUN-001`, `samples/`, `docs/`, `release/`, or `diagrams/`.

## 10. Planned Hook / Validator Sequence

Guard hardening note for WP-12C-L2B-GUARD-MP1: during L2B controlled-output retry, the prewrite guard allow-list must pass only the exact approved scratch output paths under `runs/RUN-SMOKE-PLUGIN-L2B-001/`. It must block every proposed write under `runs/RUN-001/`, `samples/`, canonical assets, provider projections, `docs/`, `release/`, and `diagrams/`. The existing scratch run may be reused for retry only after explicit post-MP1 approval; MP1 itself does not authorize output generation.

For every planned write during approved execution:

1. Run `tools/hooks/aisraf-allowed-path-prewrite-guard.ps1 -TargetPath <target>`.
2. Write the single approved target only if the prewrite guard returns PASS.
3. Run `tools/hooks/aisraf-focused-validator-postwrite.ps1 -TargetPath <target>`.
4. Stop if the focused validator returns FAIL.
5. Record the command, target, PASS/FAIL, and timestamp in `runs/RUN-SMOKE-PLUGIN-L2B-001/00-run-log.md`.

Planning-gate commands to run now:

```powershell
pwsh -NoProfile -File ./tools/Test-AisrafPackage.ps1
pwsh -NoProfile -File ./tools/Test-AisrafBp12AReadiness.ps1
pwsh -NoProfile -File ./tools/Test-AisrafRunProfile.ps1 -RunProfilePath ./runs/RUN-001/run-profile.yaml -ExecutionReady
```

Validation commands preserved for final L2B execution:

```powershell
pwsh -NoProfile -File ./tools/Test-AisrafPackage.ps1
pwsh -NoProfile -File ./tools/Test-AisrafBp12AReadiness.ps1
pwsh -NoProfile -File ./tools/Test-AisrafRunProfile.ps1 -RunProfilePath ./runs/RUN-SMOKE-PLUGIN-L2B-001/run-profile.yaml -ExecutionReady
```

Known evidence-capture issue: the stop hook summary may throw a PowerShell quoting or parser warning. This does not block planning. If it affects L2B evidence capture during execution, stop and report before continuing.

## 11. Planned Final Validator Ladder

After approved L2B execution, run this ladder from the governed repo root:

```powershell
pwsh -NoProfile -File ./tools/Test-AisrafRunProfile.ps1 -RunProfilePath ./runs/RUN-SMOKE-PLUGIN-L2B-001/run-profile.yaml -ExecutionReady
pwsh -NoProfile -File ./tools/Test-AisrafPackage.ps1
pwsh -NoProfile -File ./tools/Test-AisrafBp12AReadiness.ps1
```

If `tools/Test-AisrafPackage.ps1` changes at any point, run the governed bundle builder before final package validation:

```powershell
pwsh -NoProfile -File ./tools/Build-AisrafCopilotPluginBundle.ps1 -Clean
pwsh -NoProfile -File ./tools/Test-AisrafPackage.ps1
```

The bundle/checksum alignment proof is the package validator Check 16b PASS plus the builder PASS line confirming all source and target SHA-256 values match.

## 12. Planned Git Hygiene Checks

Run these commands before execution setup, after setup, after each role if practical, and at final closeout:

```powershell
git status --short
git diff --name-only
git diff --staged --name-only
git ls-files -- .claude
git diff --cached --name-only -- .claude
git diff -- runs/RUN-001/
git diff -- samples/
git diff -- prompts/ skills/ prototype-agents/ templates/ catalogs/ blueprints/ config/ .agents/ .github/agents/ .github/skills/ .github/hooks/ .copilot-skills/
```

Expected planning result:

- No staged files.
- `.claude/` has no tracked files and no staged files.
- `runs/RUN-001/` diff is empty.
- `samples/` diff is empty.
- Protected canonical/provider diffs are empty.
- Only the L2B plan, the exact validator allow-list update, and validator-required bundle/checksum realignment may appear as planning diffs.

## 13. Evidence Capture Method

During approved L2B execution, capture evidence in `runs/RUN-SMOKE-PLUGIN-L2B-001/00-run-log.md` and in the final operator report. Evidence must include:

- Founder approval reference for L2B execution.
- Scratch run creation timestamp.
- Six input copy checks with source path, target path, and SHA-256 or byte equality evidence.
- Run-profile validation result.
- Per-output prewrite guard PASS.
- Per-output focused postwrite validator PASS.
- Role sequence transcript summary, not copied canonical prompt/skill/PRA bodies.
- Final validator ladder summaries.
- Git hygiene summaries proving sealed surfaces stayed unchanged.
- Statement that installed plugin cache was not modified.
- Statement that no Jira, Confluence, Lucidchart, MCP, cloud, database, Terraform, or external post-back execution occurred.

Do not capture secrets, tokens, real customer PII, production endpoints, or unredacted sensitive payloads.

## 14. Stop Conditions

Stop immediately if any condition occurs:

- Founder approval for L2B execution is absent or ambiguous.
- `runs/RUN-SMOKE-PLUGIN-L2B-001/` already exists before approved setup and no explicit reuse approval is recorded.
- Any write is proposed outside `runs/RUN-SMOKE-PLUGIN-L2B-001/`.
- Any write is proposed to `runs/RUN-001/`, `samples/`, canonical assets, provider projections, plugin bundle files, installed plugin cache, `docs/`, `release/`, or `diagrams/`.
- Any role claims Jira, Confluence, Lucidchart, MCP, cloud, database, Terraform, or external post-back execution.
- Any role invents external runtime, provider execution, or deployment proof.
- The prewrite guard refuses a path.
- The focused postwrite validator fails.
- The run-profile validator fails.
- `Test-AisrafPackage.ps1` or `Test-AisrafBp12AReadiness.ps1` returns FAIL.
- Git hygiene shows staged files, `.claude/` staged content, `RUN-001` drift, sample drift, canonical/provider drift, docs/release/diagram drift, or unapproved plugin bundle drift.
- The stop hook warning prevents reliable evidence capture; report before continuing.

## 15. Known Risks

- The requested `external_execution_status: disabled` posture is not a run-profile schema field. Adding it to `run-profile.yaml` would fail strict validation, so it must remain an evidence-control assertion for L2B.
- The known `runs/RUN-SMOKE-LOCAL-001/` warning remains and must stay excluded from staging until L3.
- Controlled output execution can create many local scratch files; operator discipline is required to avoid accidental staging.
- Hook summary quoting/parser warnings may complicate evidence capture during execution.
- Installed plugin cache behavior may vary by provider, so L2B must prove cache non-mutation by observation rather than by writing to the cache.

## 16. Remaining Blockers

- L2B execution requires explicit founder approval after this plan is accepted.
- `runs/RUN-SMOKE-PLUGIN-L2B-001/` must not be created until that approval exists.
- After WP-12C-L2B-GUARD-MP1, `runs/RUN-SMOKE-PLUGIN-L2B-001/` may already exist from the stopped execution attempt. Reuse still requires explicit approval after guard MP1 passes.
- Inputs must not be copied until execution approval exists.
- L3 remains blocked until L2B controlled-output execution evidence is accepted.
- WP-13 remains blocked until the required BP12C operator evidence gates are accepted.

## 17. Whether L2B Plan Passed

L2B plan passed for planning purposes when:

- This file exists under `validation/`.
- `tools/Test-AisrafPackage.ps1` allow-lists only the exact filename.
- Bundle/checksum alignment is refreshed if the validator changed.
- Planning-gate validators return PASS with only the known smoke-run WARN allowed.
- Git hygiene confirms no sealed-surface drift.

Current planned verdict: yes, pending command evidence in the operator closeout for this planning gate.

## 18. Whether L2B Execution May Proceed After Explicit Founder Approval

Yes. L2B execution may proceed only after explicit founder approval and only into `runs/RUN-SMOKE-PLUGIN-L2B-001/` using this plan.

Approval for execution does not authorize L3, WP-13, release work, diagram creation, publication, external integration execution, or broad staging.

## 19. Whether L3 Remains Blocked

Yes. L3 remains blocked until L2B controlled-output execution is approved, executed, validated, and accepted.

## 20. Whether WP-13 Remains Blocked

Yes. WP-13 remains blocked. This plan does not start diagrams, docs promotion, release packaging, publication, or any WP-13 activity.

## Final Planning Gate Summary

| Gate | Result |
|---|---|
| work_package_status | WP-12C-L2B_PLAN_PASS_READY_FOR_CONTROLLED_OUTPUT_APPROVAL |
| proposed_scratch_run_folder | `runs/RUN-SMOKE-PLUGIN-L2B-001/` |
| proposed_input_source | `samples/sample-001-dfd-crop/` copied into scratch `inputs/` after approval only |
| planned_run_profile_fields | Schema-valid fields in Section 6; `external_execution_status=disabled` recorded as evidence posture only |
| planned_output_set | 18 root Markdown outputs plus 9 DFD Markdown outputs listed in Section 7 |
| planned_write_order | Section 8 |
| planned_role_sequence | Section 9 |
| planned_hook_validator_sequence | Section 10 |
| planned_final_validator_ladder | Section 11 |
| planned_git_hygiene_checks | Section 12 |
| evidence_capture_method | Section 13 |
| stop_conditions | Section 14 |
| remaining_risks | Section 15 |
| whether_L2B_plan_passed | yes, subject to planning-gate command evidence |
| whether_L2B_execution_may_proceed_after_founder_approval | yes, controlled-output execution only |
| whether_QA1_may_proceed | no; not unlocked by planning alone |
| whether_ED1_may_proceed | no; not unlocked by planning alone |
| whether_L3_remains_blocked | yes |
| whether_WP13_remains_blocked | yes |
| exact_next_gate | Founder controlled-output approval for WP-12C-L2B execution |