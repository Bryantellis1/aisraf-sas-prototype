---
plugin_id: aisraf-copilot-plugin
work_package: WP-12C-K4
lifecycle_status: packaged_not_installed
test_card_status: k4_validation_defined_install_deferred
external_execution: disabled
postback_execution_status: deferred
output_destination_mode: local_only
runtime_claims: none
---

# AISRAF Copilot Plugin — Test Card (WP-12C-K4 Package Validation)

## 1. Read This First

This test card preserves the future interactive smoke steps authored at K2
and adds the current K4 non-interactive package validation rows. K4 does
not install the plugin and does not execute interactive smoke tests.

The plugin under test is a packaged projection bundle, not an installed
runtime. No install attempt is made in this gate. Install testing is the
explicit scope of WP-12C-L.

## 2. Test Posture

| Aspect | Today (WP-12C-K4) | Future Gate |
|---|---|---|
| Plugin existence | Scaffold files + K3C bundle + checksum manifest | Same; no install evidence |
| Plugin assembly | K3C bundle exists; no manual bundle edits | Rebuild only by approved build script |
| Manifest schema | Validated at K4 | Revalidate after any manifest change |
| Plugin install | Not attempted | WP-12C-L |
| Post-install discovery | Not attempted | WP-12C-L |
| Post-install role smoke | Not attempted | WP-12C-L |
| Post-install chat preview | Not attempted | WP-12C-L |
| Post-install hook smoke | Not attempted | WP-12C-L |
| Post-install validators | Not attempted | WP-12C-L |
| External execution | Disabled | Disabled (no work package introduces it) |
| Output destination | Local only | Local only (no work package introduces external post-back) |

## 3. Future Test Steps (Not Executed In K2)

### 3.0 Future Interactive Smoke Script (Authored At K2A — Deferred Until WP-12C-L)

This script lists the **interactive operator prompts** that a tester will
read aloud (or paste into a chat surface) **after the plugin is installed
in a clean operator environment at WP-12C-L**. None of these prompts run
in K2, K2A, K3, or K4. They are authored here so the K2 scaffold proves
that interactive testing is planned and traceable.

Each row is **DEFERRED — to be executed at WP-12C-L** until the install
checklist (`validation/package-12c-plugin-install-and-publication-checklist.md`,
authored at WP-12C-L) opens.

| # | Layer | Prompt operator will issue | Expected provider behavior | Pass criterion | Evidence captured | Status |
|---|---|---|---|---|---|---|
| S1 | Discovery | `Show me the AISRAF agents this plugin exposes.` | Provider lists 7 AISRAF agents drawn from `.github/agents/`. | 7 agents listed; ids match `.agents/aisraf-*.agent.md`. | Chat transcript + `git status --short` snapshot. | DEFERRED — to WP-12C-L |
| S2 | Discovery | `Show me the AISRAF skills this plugin exposes.` | Provider lists 7 Agent Skills drawn from `.github/skills/`. | 7 skills listed; names match `.github/skills/<id>/SKILL.md` frontmatter. | Chat transcript. | DEFERRED — to WP-12C-L |
| S3 | Role smoke | `@aisraf-orchestrator preview only — explain your role and the run-log shape.` | Role explains identity, inputs read, theoretical write (`runs/{{run_id}}/00-run-log.md`), stop conditions, output shape. No file written. | Output references `templates/output/output-00-run-log-template.md` by path; no `runs/RUN-001/` modification. | Chat transcript + `git diff -- runs/RUN-001/` empty. | DEFERRED — to WP-12C-L |
| S4 | Role smoke | `@aisraf-input-reader preview only — explain your role.` | Role explains identity, inputs (`samples/sample-001-dfd-crop/inputs/`), theoretical write (`runs/{{run_id}}/01-input-inventory.md`). | No file written; canonical paths quoted. | Chat transcript. | DEFERRED — to WP-12C-L |
| S5 | Role smoke | `@aisraf-dfd-extractor preview only — explain your role.` | Role explains DFD extraction inputs, theoretical writes (`runs/{{run_id}}/02-visible-dfd-objects.md`, `runs/{{run_id}}/03-legend-normalization.md`, `runs/{{run_id}}/04-components.md`, `runs/{{run_id}}/05-flows.md`, `runs/{{run_id}}/dfd/01-intake-quality-check.md`, `runs/{{run_id}}/dfd/02-boundary-catalog.md`, `runs/{{run_id}}/dfd/03-component-catalog.md`, `runs/{{run_id}}/dfd/04-flow-inventory.md`, `runs/{{run_id}}/dfd/05-annotation-resolution.md`, `runs/{{run_id}}/dfd/06-boundary-crossings.md`, `runs/{{run_id}}/dfd/07-control-signals.md`, `runs/{{run_id}}/dfd/08-confidence-score.md`, `runs/{{run_id}}/dfd/09-extraction-summary.md`). | No file written; references `prompts/dfd/`. | Chat transcript. | DEFERRED — to WP-12C-L |
| S6 | Role smoke | `@aisraf-review-table-builder preview only — explain your role.` | Role explains review table inputs, theoretical writes (`runs/{{run_id}}/06-boundaries.md`, `runs/{{run_id}}/07-security-stack-assessment.md`, `runs/{{run_id}}/08-internal-review-table.md`). | No file written; references `templates/output/output-08-internal-review-table-template.md`. | Chat transcript. | DEFERRED — to WP-12C-L |
| S7 | Role smoke | `@aisraf-blueprint-questioner preview only — explain your role.` | Role explains blueprint questioning inputs, theoretical writes (`runs/{{run_id}}/09-missing-facts.md`, `runs/{{run_id}}/10-ai-action-level.md`, `runs/{{run_id}}/11-blueprint-match.md`, `runs/{{run_id}}/12-targeted-questions.md`). | No file written; references `blueprints/`. | Chat transcript. | DEFERRED — to WP-12C-L |
| S8 | Role smoke | `@aisraf-finding-recommender preview only — explain your role.` | Role explains findings inputs, theoretical writes (`runs/{{run_id}}/13-findings.md`, `runs/{{run_id}}/14-recommendations.md`). | No file written; references review table outputs. | Chat transcript. | DEFERRED — to WP-12C-L |
| S9 | Role smoke | `@aisraf-handoff-qa-scorer preview only — explain your role.` | Role explains handoff QA inputs, theoretical writes (`runs/{{run_id}}/15-handoff-pack.md`, `runs/{{run_id}}/16-validation-notes.md`, `runs/{{run_id}}/17-accuracy-score.md`). | No file written; references `skills/rs/SK-ACCURACY-SCORE.md`. | Chat transcript. | DEFERRED — to WP-12C-L |
| S10 | Chat preview | `/aisraf-orchestration preview only — show the run-log output shape.` | Skill renders headings or one-line shape hints from `templates/output/output-00-run-log-template.md`. | No body duplication; only shape hints. | Chat transcript. | DEFERRED — to WP-12C-L |
| S11 | Chat preview | `/aisraf-input-read sample input/output` | Skill references `samples/sample-001-dfd-crop/inputs/` + `samples/sample-001-dfd-crop/expected/`. | Sample paths quoted; no canonical body duplicated. | Chat transcript. | DEFERRED — to WP-12C-L |
| S12 | Chat preview | `/aisraf-dfd-extraction skill wiring` | Skill explains canonical wiring (PRA, adapter, prompt, skill, template). | All five canonical layers named. | Chat transcript. | DEFERRED — to WP-12C-L |
| S13 | Hook smoke | Attempt to write `runs/RUN-001/test.txt` from a chat tool call. | PreToolUse hook (`aisraf-allowed-path-prewrite-guard.ps1`) blocks the write with non-zero exit. | Write blocked; chat shows guard error message. | Chat transcript + `git diff -- runs/RUN-001/` empty. | DEFERRED — to WP-12C-L |
| S14 | Hook smoke | Attempt to write `runs/RUN-SMOKE-LOCAL-XXX/test.txt` from a chat tool call. | PreToolUse hook permits the write per `tools/hooks/hook-allow-list.yaml`. | Write succeeds; PostToolUse runs focused validator. | Chat transcript + scratch run path on disk; `runs/RUN-001/` byte-stable. | DEFERRED — to WP-12C-L |
| S15 | Hook smoke | End the chat session. | Stop hook (`aisraf-session-stop-summary.ps1`) emits a session summary to chat. | Summary includes wrapper id, inputs read, outputs written, validators invoked. | Chat transcript. | DEFERRED — to WP-12C-L |
| S16 | Controlled output | After §S14 succeeds, run `pwsh -NoProfile -File ./tools/Test-AisrafRunProfile.ps1 -RunProfilePath ./runs/RUN-SMOKE-LOCAL-XXX/run-profile.yaml -ExecutionReady`. | Validator reports 12 PASS, 0 FAIL on the scratch run. | 0 FAIL; canonical surfaces unchanged. | Validator transcript. | DEFERRED — to WP-12C-L |
| S17 | Controlled output | Run `pwsh -NoProfile -File ./tools/Test-AisrafBp12AReadiness.ps1`. | Validator reports 0 FAIL; tracked-drift only includes the scratch run paths. | 0 FAIL; sealed surfaces unchanged. | Validator transcript. | DEFERRED — to WP-12C-L |
| S18 | Negative — external execution | `Deploy this AISRAF agent to Azure Foundry now.` | Agent refuses; cites `external_execution: disabled`. | No deployment attempted; agent quotes posture. | Chat transcript. | DEFERRED — to WP-12C-L |
| S19 | Negative — sealed surface | `Edit prompts/rs/00-run-full-chain.prompt.md to add a new step.` | PreToolUse hook blocks; agent declines; references sealed-surface posture. | Edit blocked; `git diff -- prompts/` empty. | Chat transcript. | DEFERRED — to WP-12C-L |
| S20 | Negative — external post-back | `Post the review findings to Jira.` | Agent refuses; cites `output_destination_mode: local_only`. | No external post-back attempted. | Chat transcript. | DEFERRED — to WP-12C-L |

### 3.1 Section Coverage Matrix For The Smoke Script

| Coverage requirement (per WP-12C-K2A audit) | Smoke-script rows |
|---|---|
| Role smoke test placeholder | S3 – S9 (one row per agent) |
| Chat preview placeholder | S10 – S12 |
| Hook smoke placeholder | S13 – S15 |
| Controlled output placeholder | S16 – S17 |
| Negative-path / posture placeholder | S18 – S20 |
| Discovery placeholder | S1 – S2 |

Every row is `DEFERRED — to WP-12C-L`. No row is run in K2, K2A, K3, or K4.



### Section A — Scaffold Existence (To Be Executed At K3 Open)

| # | Step | Expected | Status |
|---|---|---|---|
| A1 | Confirm `plugins/` exists. | Folder present. | DEFERRED — to be executed at K3 open |
| A2 | Confirm `plugins/aisraf-copilot-plugin/` exists. | Folder present. | DEFERRED — to be executed at K3 open |
| A3 | Confirm `plugins/aisraf-copilot-plugin/README.md` exists. | File present. | DEFERRED — to be executed at K3 open |
| A4 | Confirm `plugins/aisraf-copilot-plugin/PLUGIN-PACKAGING-PLAN.md` exists. | File present. | DEFERRED — to be executed at K3 open |
| A5 | Confirm `plugins/aisraf-copilot-plugin/PLUGIN-TEST-CARD.md` exists. | File present. | DEFERRED — to be executed at K3 open |
| A6 | Confirm `plugins/aisraf-copilot-plugin/EVIDENCE-CHECKLIST.md` exists. | File present. | DEFERRED — to be executed at K3 open |
| A7 | Confirm `plugins/aisraf-copilot-plugin/plugin.yaml` exists. | File present. | DEFERRED — to be executed at K3 open |
| A8 | Confirm no other files exist directly under `plugins/aisraf-copilot-plugin/`. | Only the 5 files above. | DEFERRED — to be executed at K3 open |
| A9 | Confirm no subfolders exist under `plugins/aisraf-copilot-plugin/` at K2 close. | Zero subfolders. | DEFERRED — to be executed at K3 open |
| A10 | Confirm no file or subfolder exists at `plugins/` root other than `aisraf-copilot-plugin/`. | Only `aisraf-copilot-plugin/`. | DEFERRED — to be executed at K3 open |

### Section B — Manifest Parse (To Be Executed At K3 Or K4)

| # | Step | Expected | Status |
|---|---|---|---|
| B1 | Parse `plugin.yaml` as YAML. | Valid YAML; no syntax errors. | DEFERRED — to be executed at K3 / K4 |
| B2 | Confirm `plugin_id: aisraf-copilot-plugin` field present. | Exact value. | DEFERRED — to be executed at K3 / K4 |
| B3 | Confirm `lifecycle_status: scaffold_only` field present. | Exact value at K2; updated at K3 / K4. | DEFERRED — to be executed at K3 / K4 |
| B4 | Confirm `external_execution: disabled` field present. | Exact value. | DEFERRED — to be executed at K3 / K4 |
| B5 | Confirm `runtime_claims: none` field present. | Exact value. | DEFERRED — to be executed at K3 / K4 |
| B6 | Confirm `install_validation: deferred` field present. | Exact value at K2. | DEFERRED — to be executed at K3 / K4 |
| B7 | Confirm canonical source references list at least the canonical surfaces in §2 of `PLUGIN-PACKAGING-PLAN.md`. | All canonical surface paths present as strings; no canonical body copied. | DEFERRED — to be executed at K3 / K4 |

### Section C — No Bundle Folders At K2 (To Be Executed At K3 Open)

| # | Step | Expected | Status |
|---|---|---|---|
| C1 | Confirm `plugins/aisraf-copilot-plugin/agents/` does NOT exist. | Absent. | DEFERRED — to be executed at K3 open |
| C2 | Confirm `plugins/aisraf-copilot-plugin/skills/` does NOT exist. | Absent. | DEFERRED — to be executed at K3 open |
| C3 | Confirm `plugins/aisraf-copilot-plugin/hooks/` does NOT exist. | Absent. | DEFERRED — to be executed at K3 open |
| C4 | Confirm `plugins/aisraf-copilot-plugin/prompts/` does NOT exist. | Absent. | DEFERRED — to be executed at K3 open |
| C5 | Confirm `plugins/aisraf-copilot-plugin/tools/` does NOT exist. | Absent. | DEFERRED — to be executed at K3 open |
| C6 | Confirm `plugins/aisraf-copilot-plugin/templates/` does NOT exist. | Absent. | DEFERRED — to be executed at K3 open |
| C7 | Confirm `plugins/aisraf-copilot-plugin/catalogs/` does NOT exist. | Absent. | DEFERRED — to be executed at K3 open |
| C8 | Confirm `plugins/aisraf-copilot-plugin/blueprints/` does NOT exist. | Absent. | DEFERRED — to be executed at K3 open |
| C9 | Confirm `plugins/aisraf-copilot-plugin/registries/` does NOT exist. | Absent. | DEFERRED — to be executed at K3 open |
| C10 | Confirm `plugins/aisraf-copilot-plugin/validation/` does NOT exist. | Absent. | DEFERRED — to be executed at K3 open |
| C11 | Confirm `plugins/aisraf-copilot-plugin/evidence/` does NOT exist. | Absent. | DEFERRED — to be executed at K3 open |
| C12 | Confirm `plugins/aisraf-copilot-plugin/mcp/` does NOT exist. | Absent. | DEFERRED — to be executed at K3 open |
| C13 | Confirm no `bundle-checksum-manifest.yaml` exists at K2 close. | Absent. | DEFERRED — to be executed at K3 open |

### Section D — Validator Confirmation (To Be Executed At K3 Open)

| # | Step | Expected | Status |
|---|---|---|---|
| D1 | Run `pwsh -NoProfile -File ./tools/Test-AisrafPackage.ps1`. | 0 FAIL. | DEFERRED — to be executed at K3 open and at every later gate |
| D2 | Run `pwsh -NoProfile -File ./tools/Test-AisrafBp12AReadiness.ps1`. | 0 FAIL. | DEFERRED — to be executed at K3 open and at every later gate |
| D3 | Run `pwsh -NoProfile -File ./tools/Test-AisrafRunProfile.ps1 -RunProfilePath ./runs/RUN-001/run-profile.yaml -ExecutionReady`. | 12 PASS, 0 FAIL. | DEFERRED — to be executed at K3 open and at every later gate |
| D4 | Confirm `Check 16-plugin-content-limits` PASSes after K2 scaffold lands. | PASS. | DEFERRED — to be executed at K3 open |
| D5 | Confirm `Test-AisrafBp12AReadiness.ps1 tracked-drift` PASS includes only the 5 K2 paths under `plugins/aisraf-copilot-plugin/`. | PASS. | DEFERRED — to be executed at K3 open |

### Section E — Install Test Deferral (To Be Executed At WP-12C-L Open)

| # | Step | Expected | Status |
|---|---|---|---|
| E1 | Plugin install attempt. | Not attempted at K2 / K3 / K4. | DEFERRED — to WP-12C-L |
| E2 | Post-install discovery. | Not attempted at K2 / K3 / K4. | DEFERRED — to WP-12C-L |
| E3 | Post-install role smoke. | Not attempted at K2 / K3 / K4. | DEFERRED — to WP-12C-L |
| E4 | Post-install chat preview. | Not attempted at K2 / K3 / K4. | DEFERRED — to WP-12C-L |
| E5 | Post-install hook smoke. | Not attempted at K2 / K3 / K4. | DEFERRED — to WP-12C-L |
| E6 | Post-install validator ladder. | Not attempted at K2 / K3 / K4. | DEFERRED — to WP-12C-L |
| E7 | Post-install canonical-byte-stability spot check. | Not attempted at K2 / K3 / K4. | DEFERRED — to WP-12C-L |

### Section F — No External Execution Claims (To Be Executed At K3 Open)

| # | Step | Expected | Status |
|---|---|---|---|
| F1 | Grep every plugin file for `runtime_deployed:\s*true`. | No match. | DEFERRED — to be executed at K3 open |
| F2 | Grep every plugin file for `cloud_resources_created:\s*true`. | No match. | DEFERRED — to be executed at K3 open |
| F3 | Grep every plugin file for `mcp_execution_available:\s*true`. | No match. | DEFERRED — to be executed at K3 open |
| F4 | Grep every plugin file for `jira_confluence_execution_available:\s*true`. | No match. | DEFERRED — to be executed at K3 open |
| F5 | Grep every plugin file for `postback_execution_status:\s*executed_by_operator`. | No match. | DEFERRED — to be executed at K3 open |
| F6 | Grep every plugin file for `output_destination_mode:\s*external_postback_executed`. | No match. | DEFERRED — to be executed at K3 open |
| F7 | Grep every plugin file for positive Terraform apply proof phrases. | No match. | DEFERRED — to be executed at K3 open |
| F8 | Grep every plugin file for positive Jira post-back completion phrases. | No match. | DEFERRED — to be executed at K3 open |
| F9 | Grep every plugin file for positive Confluence publication completion phrases. | No match. | DEFERRED — to be executed at K3 open |
| F10 | Grep every plugin file for AAL-L4 autonomous claim patterns. | No match. | DEFERRED — to be executed at K3 open |

### Section G — K4 Non-Interactive Package Validation

These rows are the K4 validation scope. They are read-only and do not
install the plugin, execute role smoke, publish to Git, generate diagrams,
or create release artifacts.

| # | Step | Expected | Status |
|---|---|---|---|
| G1 | Validate `plugin.yaml` required K4 manifest fields. | Required fields present; install remains deferred; external execution disabled. | PASS — VERIFIED AT K4 CLOSE |
| G2 | Validate `bundle-checksum-manifest.yaml` required fields and entry schema. | Manifest header fields present; every entry has source path, target path, source SHA-256, and target SHA-256. | PASS — VERIFIED AT K4 CLOSE |
| G3 | Recompute every source and target SHA-256 from the checksum manifest. | Recorded source hash, recorded target hash, and recomputed source / target hash all match. | PASS — VERIFIED AT K4 CLOSE |
| G4 | Compare bundle files to checksum manifest entries. | No bundle file exists without a manifest entry. | PASS — VERIFIED AT K4 CLOSE |
| G5 | Check bundle source and target boundaries. | Sources stay in the K3C allow-list; targets stay under `plugins/aisraf-copilot-plugin/bundle/`; excluded surfaces are absent. | PASS — VERIFIED AT K4 CLOSE |
| G6 | Run no-external-execution lint over plugin metadata and bundle metadata. | No plugin-level external execution claim exists. | PASS — VERIFIED AT K4 CLOSE |
| G7 | Confirm UX / documentation posture. | Docs describe value, later interaction, roles, projection layers, local-only I/O, and future integration deferrals. | PASS — VERIFIED AT K4 CLOSE |
| G8 | Run the three governed validators. | Package, readiness, and RUN-001 run-profile validators return 0 FAIL. | PASS — VERIFIED AT K4 CLOSE |
| G9 | Run Git hygiene checks. | Nothing staged; `.claude/` untracked and unstaged; RUN-001, samples, canonical, and provider surfaces unchanged. | PASS — VERIFIED AT K4 CLOSE |

K4 closeout status:
`WP-12C-K4_PLUGIN_PACKAGE_VALIDATION_PASS_READY_FOR_INSTALL_TESTING`.
Parent WP-12C-K status:
`WP-12C-K_PACKAGE_COMPLETE_READY_FOR_INSTALL_READINESS_PREFLIGHT`.
These statuses do not install the plugin and do not run interactive smoke.
WP-12C-L0 is next only after explicit approval; WP-12C-L1, WP-12C-L2,
WP-12C-L3, and WP-13 remain blocked.

## 4. Test Card Posture Restatement

- This card lists **future steps only**. No row is executed in WP-12C-K2.
- Plugin install is **deferred to WP-12C-L**.
- All Section F grep checks must remain "No match" at every later gate.
- Drift between this card and the canonical roadmap
  (`validation/package-12c-plugin-roadmap.md`) is to be reconciled in
  the canonical roadmap, not in this card.

## 5. Stop Conditions

Halt and escalate if:

- Any Section A row reports an extra file or subfolder under
  `plugins/aisraf-copilot-plugin/` at K2 close.
- Any Section C row reports an unexpected subfolder.
- Any Section D row reports a non-zero FAIL count from any validator.
- Any Section F grep matches in any plugin file.
- Any test row claims external execution at any point.
