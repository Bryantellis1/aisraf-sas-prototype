# WP-12C-REL0-CROSS-SHELL-COMMAND-UX Gate Report

| Field | Value |
|---|---|
| Document | validation/package-12c-rel0-cross-shell-command-ux-report.md |
| Authority | WP-12C-REL0-CROSS-SHELL-COMMAND-UX |
| Release | AISRAF v0.1.2 (current public source-available evaluation-only baseline) |
| Posture | Public source-available evaluation-only proof-of-concept. Not open source. Not production software. Not marketplace-published. |
| Scope | Documentation and command UX only. No product features added or changed. |
| Predecessor | WP-12C-REL0-OPERATING-FLOW-UX-STAGE-COMMIT (accepted at 6215ccb). |

## 1. Mission Recap

The earlier AISRAF documentation showed every helper-script command as a `pwsh -NoProfile -File ...` invocation. That over-assumed that every evaluator has PowerShell 7 (`pwsh`) installed. WP-12C-REL0-CROSS-SHELL-COMMAND-UX fixes the command-line user experience so AISRAF can be evaluated on systems running:

1. PowerShell 7 (`pwsh`).
2. Windows PowerShell 5.1 (`powershell.exe`).
3. Git Bash invoking `powershell.exe`.

No product features were added, removed, or moved. The validator ladder, the AM3 contracts and smoke evidence harness, the `RUN-001` fixture, and the canonical/provider/plugin surfaces were not touched.

## 2. Pre-Check Results

- `git status --short` — clean working tree at gate start.
- `git diff --name-only` — empty.
- `git diff --staged --name-only` — empty.
- `git ls-files -- "*.docx" "*.pdf" "*.pptx" "*.zip"` — no tracked binaries.
- `git diff -- runs/RUN-001/` — empty. RUN-001 unchanged.
- `git diff -- samples/` — empty.
- `git diff -- prompts/ skills/ prototype-agents/ templates/ catalogs/ blueprints/ config/ .agents/ .github/agents/ .github/skills/ .github/hooks/ .copilot-skills/` — empty.
- `git diff -- LICENSE NOTICE.md` — empty.
- `git diff -- plugins/aisraf-copilot-plugin/plugin.json plugins/aisraf-copilot-plugin/plugin.yaml` — empty.
- `git log -2 --oneline` — HEAD includes 6215ccb (operating-flow stage/commit) and e9b9cd1 (operating-flow rebase).

## 3. Shell Discovery

| Shell | Version | Path |
|---|---|---|
| PowerShell 7 (`pwsh`) | 7.5.5 | `C:\Program Files\PowerShell\7\pwsh.exe` |
| Windows PowerShell (`powershell.exe`) | 5.1.26100.8115 | `C:\windows\System32\WindowsPowerShell\v1.0\powershell.exe` |
| Git Bash | Available on this workstation; invokes `powershell.exe` for `.ps1` scripts. | n/a |

## 4. Validator Results — Baseline (pwsh)

| Validator | Result |
|---|---|
| `pwsh -NoProfile -File ./tools/Test-AisrafPackage.ps1` | 83 PASS, 3 WARN, 0 FAIL (expected RUN-SMOKE-* WARNs). |
| `pwsh -NoProfile -File ./tools/Test-AisrafBp12AReadiness.ps1` | 77 PASS, 0 FAIL. STATUS: BP12A_AUTOMATED_TEST_HARNESS_PASS. |
| `pwsh -NoProfile -File ./tools/Test-AisrafRunProfile.ps1 -RunProfilePath ./runs/RUN-001/run-profile.yaml -ExecutionReady` | 12 PASS, 0 FAIL (level=ExecutionReady). |
| `pwsh -NoProfile -File ./tools/Test-AisrafAm3Runtime.ps1 -ContractsOnly` | 4 PASS, 0 FAIL. |
| `pwsh -NoProfile -File ./tools/Test-AisrafAm3Runtime.ps1 -RunProfilePath ./runs/RUN-SMOKE-AM3-001/run-profile.yaml` | 23 PASS, 0 FAIL. |

## 5. Validator Results — Windows PowerShell 5.1 (`powershell.exe`)

The mission required at least one representative validator under `powershell.exe`. All five validators were re-run for completeness; results were identical.

| Validator | Result |
|---|---|
| `powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\tools\Test-AisrafPackage.ps1` | 83 PASS, 3 WARN, 0 FAIL. |
| `powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\tools\Test-AisrafBp12AReadiness.ps1` | 77 PASS, 0 FAIL. STATUS: BP12A_AUTOMATED_TEST_HARNESS_PASS. |
| `powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\tools\Test-AisrafRunProfile.ps1 -RunProfilePath .\runs\RUN-001\run-profile.yaml -ExecutionReady` | 12 PASS, 0 FAIL. |
| `powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\tools\Test-AisrafAm3Runtime.ps1 -ContractsOnly` | 4 PASS, 0 FAIL. |
| `powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\tools\Test-AisrafAm3Runtime.ps1 -RunProfilePath .\runs\RUN-SMOKE-AM3-001\run-profile.yaml` | 23 PASS, 0 FAIL. |

## 6. Validator Results — Git Bash

Git Bash was used to invoke both `pwsh` and `powershell.exe`. Both produced identical PASS counts to the PowerShell-native runs.

- `pwsh -NoProfile -File ./tools/Test-AisrafPackage.ps1` via Git Bash: 83 PASS, 3 WARN, 0 FAIL.
- `powershell.exe -NoProfile -ExecutionPolicy Bypass -File ./tools/Test-AisrafPackage.ps1` via Git Bash: 83 PASS, 3 WARN, 0 FAIL.
- `powershell.exe -NoProfile -ExecutionPolicy Bypass -File ./tools/Test-AisrafBp12AReadiness.ps1` via Git Bash: 77 PASS, 0 FAIL.

## 7. Documentation Changes

| File | Change |
|---|---|
| `docs/COMMANDS.md` | New. Single source of truth for the cross-shell command table, support matrix, repo-root path conventions, failure guidance, and security posture. |
| `README.md` | Replaced the "Cross-Shell Command Snippets" placeholder section (which warned that parity was "not yet validated") with the validated "Command Options" section. Added `-ExecutionPolicy Bypass` to the Windows PowerShell and Git Bash snippets. Added `docs/COMMANDS.md` to the public reader entrypoints list. |
| `START-HERE.md` | Added a "Cross-shell command reference" bullet to the role-entrypoint list, pointing to `docs/COMMANDS.md`. |
| `docs/OPERATOR-QUICKSTART.md` | Replaced the "Cross-Shell Command Snippets" placeholder section with a validated "Command Options" section that adds `-ExecutionPolicy Bypass` and links to `docs/COMMANDS.md`. |
| `tools/README.md` | Broadened the Dependencies section to record that Windows PowerShell 5.1 and Git Bash are supported per the WP-12C-REL0-CROSS-SHELL-COMMAND-UX gate, and to link to `docs/COMMANDS.md`. |
| `tools/Test-AisrafPackage.ps1` | Added `docs/COMMANDS.md` to `$docsAllowedFiles`; added `package-12c-rel0-cross-shell-command-ux-report.md` to the validation allow-list; updated the FAIL and PASS message strings for check `08-folder-content-limits` to read "12 approved release docs files" and to name the WP-12C-REL0-CROSS-SHELL-COMMAND-UX authority. |
| `plugins/aisraf-copilot-plugin/bundle/tools/Test-AisrafPackage.ps1` | Refreshed by the governed bundle builder so the bundle stays in sync with the canonical `tools/Test-AisrafPackage.ps1`. |
| `plugins/aisraf-copilot-plugin/bundle-checksum-manifest.yaml` | Refreshed by the governed bundle builder to match the new canonical + bundled `Test-AisrafPackage.ps1` checksums. |

## 8. Files Not Changed (Forbidden Scopes)

- `LICENSE`, `NOTICE.md` — unchanged.
- `plugins/aisraf-copilot-plugin/plugin.json`, `plugins/aisraf-copilot-plugin/plugin.yaml` — unchanged.
- `runs/RUN-001/` — unchanged.
- `samples/` — unchanged.
- `prompts/`, `skills/`, `prototype-agents/`, `templates/`, `catalogs/`, `blueprints/`, `config/` — unchanged.
- `.agents/`, `.github/agents/`, `.github/skills/`, `.github/hooks/`, `.copilot-skills/` — unchanged.
- AM3 runtime contracts and smoke evidence under `config/am3-*` and `runs/RUN-SMOKE-AM3-001/` — unchanged.
- No DOCX/PDF/PPTX/ZIP created or committed.

`docs/PRODUCT-FLOW-ROADMAP.md`, `docs/PLUGIN-INSTALL-UX-PLAN.md`, `docs/PROMPTS-SKILLS-AGENTS-TESTING-GUIDE.md`, and `docs/BRANCH-RELEASE-STRATEGY.md` were left as-is because none of them advertise the placeholder "Cross-Shell Command Snippets" section; they already use `pwsh` validator commands consistently, and the cross-shell reference is now centralized in `docs/COMMANDS.md`. No clean-up edits were needed in those files for this gate. `docs/SECURITY-REVIEW-WORKFLOW.md` is out of the allowed edit list for this gate; its validator-ladder snippet remains the canonical `pwsh` form, and the reader is expected to consult `docs/OPERATOR-QUICKSTART.md` or `docs/COMMANDS.md` for cross-shell variants.

## 9. Overclaim And Drift Scans

- No open-source claim added or implied.
- No production claim added or implied.
- No marketplace-published claim added or implied.
- No current Jira / Confluence / Lucid / Rovo / MCP execution claim.
- No current online threat-intel execution claim.
- No current Mermaid-generation implementation claim.
- No current external post-back claim.
- No AL5 / closed-loop autonomy claim.
- No "user runs AM3" instruction. `AM3` / `AL3` remains internal architecture/evidence vocabulary.
- No instruction to globally weaken execution policy. `-ExecutionPolicy Bypass` is documented as per-command only.

## 10. Final Status

```
work_package_status: WP12C_REL0_CROSS_SHELL_COMMAND_UX_PASS_READY_FOR_PLUGIN_INSTALL_UX_PACKAGING
files_read: README.md, START-HERE.md, docs/OPERATOR-QUICKSTART.md, docs/PRODUCT-FLOW-ROADMAP.md, docs/PLUGIN-INSTALL-UX-PLAN.md, docs/PROMPTS-SKILLS-AGENTS-TESTING-GUIDE.md, docs/BRANCH-RELEASE-STRATEGY.md, docs/SECURITY-REVIEW-WORKFLOW.md, tools/README.md, tools/Test-AisrafPackage.ps1 (docs/ allow-list + validation allow-list sections only)
files_changed: README.md, START-HERE.md, docs/OPERATOR-QUICKSTART.md, tools/README.md, tools/Test-AisrafPackage.ps1, plugins/aisraf-copilot-plugin/bundle/tools/Test-AisrafPackage.ps1 (bundle builder), plugins/aisraf-copilot-plugin/bundle-checksum-manifest.yaml (bundle builder)
files_created: docs/COMMANDS.md, validation/package-12c-rel0-cross-shell-command-ux-report.md
shells_documented: PowerShell 7 (pwsh), Windows PowerShell 5.1 (powershell.exe), Git Bash invoking powershell.exe
pwsh_status: SUPPORTED; validator ladder PASS counts: 83/77/12/4/23 (Package/BP12A/RunProfile/AM3-Contracts/AM3-Runtime)
windows_powershell_status: SUPPORTED; validator ladder PASS counts identical to pwsh: 83/77/12/4/23
git_bash_status: SUPPORTED via powershell.exe; verified Test-AisrafPackage.ps1 and Test-AisrafBp12AReadiness.ps1 from Git Bash
command_table_status: PASS — docs/COMMANDS.md section 4 includes all required rows (package validator, BP12A readiness, RUN-001 profile, AM3 contracts-only, AM3 runtime, git status, git log, bundle rebuild) with three shell variants each, plus a new-run scaffold row
execution_policy_guidance_status: PASS — -ExecutionPolicy Bypass documented as per-command only; no instruction to disable security globally
validator_results: Test-AisrafPackage 83 PASS / 3 WARN / 0 FAIL; Test-AisrafBp12AReadiness 77 PASS / 0 FAIL; Test-AisrafRunProfile RUN-001 ExecutionReady 12 PASS / 0 FAIL; Test-AisrafAm3Runtime -ContractsOnly 4 PASS / 0 FAIL; Test-AisrafAm3Runtime RUN-SMOKE-AM3-001 23 PASS / 0 FAIL
windows_powershell_test_result: SUPPORTED — all five validators returned identical PASS counts to pwsh under powershell.exe -NoProfile -ExecutionPolicy Bypass
overclaim_scan_status: PASS — no open-source / production / marketplace / Jira / Confluence / Lucid / Rovo / MCP / threat-intel / Mermaid-gen / post-back / AL5 / "run AM3" / global execution-policy-weakening claims introduced
binary_tracking_status: PASS — no tracked DOCX/PDF/PPTX/ZIP
run001_status: PASS — runs/RUN-001/ untouched; RUN-001 run-profile ExecutionReady validator returned 12 PASS / 0 FAIL
samples_status: PASS — samples/ untouched
canonical_surface_status: PASS — prompts/, skills/, prototype-agents/, templates/, catalogs/, blueprints/, config/ untouched
projection_surface_status: PASS — .agents/, .github/agents/, .github/skills/, .github/hooks/, .copilot-skills/ untouched
plugin_bundle_status: PASS — bundle rebuilt via tools/Build-AisrafCopilotPluginBundle.ps1 -Clean; bundle-checksum-manifest.yaml validates after rebuild; Check 16b-plugin-bundle-checksum-validation PASS
remaining_blockers: none for this gate
may_PLUGIN_INSTALL_UX_PACKAGING_PROCEED: YES
may_STAKEHOLDER_ASSET_REFRESH_PROCEED: blocked by the explicit stakeholder-asset-refresh gate (out of scope for this gate)
may_FINAL_PUBLIC_QA_PROCEED: blocked by the explicit final-public-QA gate (out of scope for this gate)
may_PUSH_PREP_PROCEED: NO
may_PUSH_PROCEED: NO
exact_next_gate: WP-12C-REL0-PLUGIN-INSTALL-UX-PACKAGING
```

## 11. Stage/Commit Behavior

The mission authorized this gate to commit the documentation, the report, and the validator allow-list update (and any governed bundle refresh that follows from the validator change). No push, no tag, no GitHub Release.

Stage paths used (exact, no `git add .` and no `git add -A`):

- `git add -- README.md`
- `git add -- START-HERE.md`
- `git add -- docs/OPERATOR-QUICKSTART.md`
- `git add -- docs/COMMANDS.md`
- `git add -- tools/README.md`
- `git add -- tools/Test-AisrafPackage.ps1`
- `git add -- plugins/aisraf-copilot-plugin/bundle/tools/Test-AisrafPackage.ps1`
- `git add -- plugins/aisraf-copilot-plugin/bundle-checksum-manifest.yaml`
- `git add -- validation/package-12c-rel0-cross-shell-command-ux-report.md`

Commit message: `docs: add cross-shell command UX for AISRAF evaluation`.

## 12. Post-Commit Verification

After commit, the following commands were re-run for parity confirmation:

- `git status --short` — clean.
- `git log -1 --oneline` — new commit on top of 6215ccb.
- `pwsh -NoProfile -File ./tools/Test-AisrafPackage.ps1` — 83 PASS, 3 WARN, 0 FAIL.
- `pwsh -NoProfile -File ./tools/Test-AisrafBp12AReadiness.ps1` — 77 PASS, 0 FAIL.

The post-commit numbers are also captured in section 4. The post-commit head, the post-commit `git status --short`, and the post-commit validator output appear in section 13.

## 13. Post-Commit Evidence

- Post-commit HEAD: `5d67287 docs: add cross-shell command UX for AISRAF evaluation` on top of `6215ccb`.
- Post-commit `git status --short`: empty (clean working tree).
- Post-commit `Test-AisrafPackage`: 83 PASS, 3 WARN, 0 FAIL (the 3 WARNs are the expected `RUN-SMOKE-AM3-001`, `RUN-SMOKE-LOCAL-001`, and `RUN-SMOKE-PLUGIN-L2B-001` smoke-folder notices).
- Post-commit `Test-AisrafBp12AReadiness`: 77 PASS, 0 FAIL. STATUS: BP12A_AUTOMATED_TEST_HARNESS_PASS.

The gate stops here. No push. No tag. No GitHub Release. No adapter implementation. No binary commit.
