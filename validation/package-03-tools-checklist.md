# Build Package 03 — Tools and Setup/Test Helpers Checklist

Package: AISRAF SAS Prototype v0.1.2
Owning Build Package: Build Package 03.
Schema authority: [config/run-profile.schema.yaml](../config/run-profile.schema.yaml)
Validation authority: [config/run-profile.validation-rules.md](../config/run-profile.validation-rules.md)
No-drift authority: [validation/no-drift-rules.md](no-drift-rules.md)

This checklist is the acceptance gate for Build Package 03. Every required item must read PASS before Build Package 04 (Prompts and prompt registry) may begin. FAIL items must be resolved or recorded as explicit blockers.

## 1. Tool file presence

| # | Check | Status | Evidence |
|---|---|---|---|
| 1.1 | `tools/New-AisrafRun.ps1` exists | PASS | [tools/New-AisrafRun.ps1](../tools/New-AisrafRun.ps1) |
| 1.2 | `tools/Test-AisrafRunProfile.ps1` exists | PASS | [tools/Test-AisrafRunProfile.ps1](../tools/Test-AisrafRunProfile.ps1) |
| 1.3 | `tools/Test-AisrafPackage.ps1` exists | PASS | [tools/Test-AisrafPackage.ps1](../tools/Test-AisrafPackage.ps1) |
| 1.4 | `tools/README.md` updated for Build Package 03 | PASS | [tools/README.md](../tools/README.md) |
| 1.5 | `validation/package-03-tools-checklist.md` exists | PASS | this file |
| 1.6 | `tools/Export-AisrafRelease.ps1` NOT created (deferred to Build Package 15) | PASS | absent from [tools/](../tools/) |

## 2. Tool authority and posture

| # | Check | Status | Evidence |
|---|---|---|---|
| 2.1 | Tools resolve `PackageRoot` as the parent of `tools/` (`(Resolve-Path (Join-Path $PSScriptRoot '..')).Path`) | PASS | identical pattern in all three scripts |
| 2.2 | Tools use `Set-StrictMode -Version Latest` and `$ErrorActionPreference = 'Stop'` | PASS | top of each script |
| 2.3 | Tools target PowerShell 7+ and take no external module dependency | PASS | flat YAML parsed in-script in `Test-AisrafRunProfile.ps1` |
| 2.4 | Tools never claim execution of prompts, skills, PRAs, `.agent.md` adapters, Jira, Confluence, Rovo, MCP, scoring, diagrams, or release export | PASS | console output and `00-run-log.md` skeleton declare "no prompt/skill/PRA/adapter/Jira/Confluence/Rovo/MCP/scoring/diagram/release execution" |
| 2.5 | Tools never modify the old reference workspace at `D:/E-Way 2/aisraf-sas-prototype-skill-chain-pack-v0.01` | PASS | tools only join paths under the active workspace; `Assert-WorkspaceChild` jails writes |

## 3. New-AisrafRun.ps1 behavior

| # | Check | Status | Evidence |
|---|---|---|---|
| 3.1 | Accepts `-RunId` (required), `-SampleId` (default `sample-001-dfd-crop`), `-Mode` (default `folder_first_test`), `-CopySampleInputs` switch | PASS | param block in [tools/New-AisrafRun.ps1](../tools/New-AisrafRun.ps1) |
| 3.2 | Validates `RunId` against `^RUN-[A-Z0-9][A-Z0-9-]*$` (length 5-64) | PASS | RunId guard in script |
| 3.3 | Validates `SampleId` against `^sample-[0-9]{3}[a-z0-9-]*$` (length 11-64) | PASS | SampleId guard in script |
| 3.4 | Restricts `Mode` to the six v0.1.2 enum values via `ValidateSet` | PASS | `[ValidateSet(...)]` attribute in script |
| 3.5 | Reads `config/run-profile.template.yaml` as the source of truth | PASS | `$templatePath = config/run-profile.template.yaml` |
| 3.6 | Resolves `run_id`, `sample_id`, `mode`, `input_root`, `expected_root`, `output_root`, `created_at` only; leaves other template defaults intact (including `sensitive_data_confirmed_redacted: false`) | PASS | `Set-YamlScalarValue` calls in script |
| 3.7 | `created_at` is written as ISO 8601 UTC in the form `yyyy-MM-ddTHH:mm:ssZ` | PASS | `[DateTime]::UtcNow.ToString("yyyy-MM-ddTHH:mm:ssZ")` |
| 3.8 | Creates `runs/<RunId>/`, `runs/<RunId>/inputs/`, `runs/<RunId>/dfd/`, `runs/<RunId>/run-profile.yaml`, `runs/<RunId>/00-run-log.md` | PASS | five `New-Item`/`Set-Content` blocks |
| 3.9 | `dfd/` is created as an empty folder (no `dfd/README.md`, no DFD outputs) | PASS | only `New-Item -ItemType Directory` for `$dfdFolder` |
| 3.10 | `-CopySampleInputs` opt-in. When set with missing `samples/<SampleId>/inputs/`, warns and leaves `inputs/` empty (does not invent inputs) | PASS | `Write-Warning` branch in script |
| 3.11 | Never copies `samples/<SampleId>/expected/` | PASS | only `samples/<SampleId>/inputs/` is referenced |
| 3.12 | Refuses to overwrite an existing `runs/<RunId>/`; `-Force` is intentionally not implemented | PASS | `Stop-Setup` on `Test-Path $runFolder` |
| 3.13 | Supports `-WhatIf` dry-run preview via `[CmdletBinding(SupportsShouldProcess = $true)]` | PASS | `ShouldProcess` guards every write |
| 3.14 | Path discipline enforced: forward slashes only, no drive letter, no leading `/`, no `..`, every absolute write resolves under the active workspace root | PASS | `Assert-RelativeForwardSlashPath` and `Assert-WorkspaceChild` |

## 4. Test-AisrafRunProfile.ps1 behavior

| # | Check | Status | Evidence |
|---|---|---|---|
| 4.1 | Accepts `-RunProfilePath` (required), `-ProfileShape` (default), `-ExecutionReady` switches | PASS | param block in [tools/Test-AisrafRunProfile.ps1](../tools/Test-AisrafRunProfile.ps1) |
| 4.2 | `-ProfileShape` is the default level when neither switch is supplied | PASS | `if ($ExecutionReady.IsPresent) ... else { 'ProfileShape' }` |
| 4.3 | Parses YAML with an in-script flat-scalar parser; rejects nested or unparseable input | PASS | `ConvertFrom-FlatYaml` |
| 4.4 | Enforces required-field presence for the 25 required fields | PASS | `Check 01-required-fields` |
| 4.5 | Enforces type, enum, and constant rules including `schema_version` and `package_version` constants | PASS | `Check 02-type-enum` |
| 4.6 | Enforces identifier patterns for `run_id`, `sample_id`, `created_at` | PASS | `Check 03-identifier-patterns` |
| 4.7 | Enforces path rules: relative, forward-slash, no `..`, no drive letter, no leading `/`, `output_root` matches `^runs/RUN-[A-Z0-9][A-Z0-9-]*(/.*)?$`, `output_root` run segment matches `run_id`, `workspace_root == "."` | PASS | `Check 04-path-resolution` |
| 4.8 | Rejects unknown fields outside `config/run-profile.schema.yaml` | PASS | `Check 05-no-drift-fields` |
| 4.9 | Enforces folder-first mode coupling: `output_destination_mode == local_only`, `postback_execution_status == deferred`, connectors and MCP in `not_required`/`unavailable`, URLs empty, `rovo_mcp_available == false` | PASS | `Check 06-mode-coupling` |
| 4.10 | Enforces output-destination URL coupling for `jira_draft`, `confluence_draft`, `jira_and_confluence_draft`, `external_postback_executed` | PASS | `Check 07-destination-urls` |
| 4.11 | Enforces post-back biconditional (`external_postback_executed ⇔ executed_by_operator`) | PASS | `Check 08-post-back-honesty` |
| 4.12 | Enforces connector and MCP honesty (`executed_by_operator` requires post-back execution and a destination URL) | PASS | `Check 09-connector-honesty` |
| 4.13 | Enforces scoring coupling (`scoring_enabled ⇒ expected_baseline_required ⇒ expected_root non-empty`) | PASS | `Check 10-scoring-coupling` |
| 4.14 | Screens every string value against the sensitive-data substrings in `config/sensitive-data-rules.md` | PASS | `Check 11-sensitive-data-screen` |
| 4.15 | `-ExecutionReady` requires `sensitive_data_confirmed_redacted: true`; `-ProfileShape` allows it to be `false` | PASS | `Check 12-sensitive-data-confirmed` |
| 4.16 | Exit code 0 on all PASS; exit code 1 on any FAIL | PASS | final `exit` branch |

## 5. Test-AisrafPackage.ps1 behavior

| # | Check | Status | Evidence |
|---|---|---|---|
| 5.1 | Confirms required root files exist | PASS | `Check 01-root-files` |
| 5.2 | Confirms 17 required root folders exist | PASS | `Check 02-root-folders` |
| 5.3 | Confirms `.github/copilot-instructions.md` and 16 folder READMEs exist | PASS | `Check 03-folder-readmes` |
| 5.4 | Confirms Build Package 02 config files and the Build Package 02 checklist | PASS | `Check 04-package-02-config` |
| 5.5 | Confirms Build Package 03 tool files and the Build Package 03 checklist | PASS | `Check 05-package-03-tools` |
| 5.6 | FAILs on any DOCX/PDF/PPTX/ZIP under the workspace (excluding `.git/`) | PASS | `Check 06-no-release-binaries` |
| 5.7 | FAILs on any `.agent.md` adapter file | PASS | `Check 07-no-agent-md` |
| 5.8 | FAILs on any content beyond `README.md` in `prompts/`, `skills/`, `prototype-agents/`, `.agents/`, `catalogs/`, `blueprints/`, `templates/`, `diagrams/`, `docs/`, `release/` | PASS | `Check 08-folder-content-limits` |
| 5.9 | FAILs on any content beyond `README.md` in `samples/` (Build Package 10 surface) | PASS | `Check 09-samples-deferred` |
| 5.10 | FAILs on unexpected files in `tools/`, `config/`, `validation/`, `authoring-agents/` | PASS | `Checks 10-12, 13` |
| 5.11 | WARNs on `runs/RUN-*/` folders (smoke runs); does not FAIL | PASS | `Check 14-runs-readme-only` |
| 5.12 | Acknowledges old reference workspace path as read-only | PASS | `Check 15-old-reference-readonly` |
| 5.13 | Exit code 0 when no FAIL row exists; exit code 1 on any FAIL | PASS | final `exit` branch |

## 6. Smoke validation evidence

| # | Check | Status | Evidence |
|---|---|---|---|
| 6.1 | `New-AisrafRun.ps1 -WhatIf` produced no writes and reported planned actions | PASS | recorded in commit message and Build Package 03 final status |
| 6.2 | `New-AisrafRun.ps1 -RunId RUN-PKG03-SMOKE` created `runs/RUN-PKG03-SMOKE/` with `inputs/`, `dfd/`, `run-profile.yaml`, `00-run-log.md` | PASS | recorded in commit message |
| 6.3 | `Test-AisrafRunProfile.ps1 -ProfileShape` PASS on the smoke run | PASS | recorded in commit message |
| 6.4 | `Test-AisrafRunProfile.ps1 -ExecutionReady` FAIL on the smoke run because `sensitive_data_confirmed_redacted: false` | PASS | recorded in commit message |
| 6.5 | `runs/RUN-PKG03-SMOKE/` removed before human git stage | PASS | required before Build Package 03 commit |
| 6.6 | `Test-AisrafPackage.ps1` returns 0 (no FAIL rows) after smoke folder removal | PASS | recorded in commit message |

## 7. No-drift gates

| # | Check | Status | Evidence |
|---|---|---|---|
| 7.1 | Tools enforce `config/run-profile.schema.yaml` field set; no invented fields | PASS | `Check 05-no-drift-fields` in `Test-AisrafRunProfile.ps1` |
| 7.2 | Tools reject unsafe paths (drive letters, leading `/`, `..`) | PASS | `Assert-RelativeForwardSlashPath` and Test-RelativePath |
| 7.3 | Tools do not overwrite existing run folders | PASS | `Stop-Setup` guard in `New-AisrafRun.ps1` |
| 7.4 | Tools do not create release exports | PASS | no `tools/Export-AisrafRelease.ps1` exists |
| 7.5 | Tools do not create prompts, skills, PRA specs, `.agent.md` adapters, catalogs, blueprints, samples, diagrams, runbooks, or release artifacts | PASS | `Test-AisrafPackage.ps1` `Checks 08, 09, 10, 11, 12, 13` |
| 7.6 | Old reference workspace untouched | PASS | tools never reference the old workspace path for write; `Assert-WorkspaceChild` jails writes under active workspace |

## 8. Manifest and governance updates

| # | Check | Status | Evidence |
|---|---|---|---|
| 8.1 | `PACKAGE-MANIFEST.yaml` advances `current_build_package` to `03` and `next_build_package` to `04` | PASS | [PACKAGE-MANIFEST.yaml](../PACKAGE-MANIFEST.yaml) |
| 8.2 | `PACKAGE-MANIFEST.yaml` declares `build_package_03_allowed_writes` block | PASS | [PACKAGE-MANIFEST.yaml](../PACKAGE-MANIFEST.yaml) |
| 8.3 | `validation/no-drift-rules.md` adds Package 03 entries (no invented fields, no writes outside `runs/<run_id>/`, no execution claims, no release-export tool, smoke runs removed before commit) | PASS | [validation/no-drift-rules.md](no-drift-rules.md) |

## 9. Operator pre-commit gates

| # | Check | Status | Evidence |
|---|---|---|---|
| 9.1 | Working tree contains no `runs/<run_id>/` folder produced during Build Package 03 smoke testing | PASS | smoke folder removed |
| 9.2 | `Test-AisrafPackage.ps1` returns exit code 0 with no FAIL rows | PASS | recorded in final status |
| 9.3 | Operator review of [tools/README.md](../tools/README.md) for accuracy and scope | TODO | requires human review |
| 9.4 | Operator review of generated `runs/<RunId>/run-profile.yaml` against `config/run-profile.schema.yaml` (sample run) | TODO | requires human review |

## 10. Next allowed Build Package

| # | Check | Status | Evidence |
|---|---|---|---|
| 10.1 | Next allowed Build Package is Build Package 04 — Prompts and prompt registry | PASS | [BUILD-ORDER.md](../BUILD-ORDER.md) and `next_build_package` in [PACKAGE-MANIFEST.yaml](../PACKAGE-MANIFEST.yaml) |
