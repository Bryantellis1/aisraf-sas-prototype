# AISRAF Commands: PowerShell 7, Windows PowerShell, and Git Bash

| Field | Value |
|---|---|
| Document | docs/COMMANDS.md |
| Authority | WP-12C-REL0-CROSS-SHELL-COMMAND-UX |
| Release | AISRAF v0.1.2 (current public source-available evaluation-only baseline) |
| Posture | Public source-available evaluation-only proof-of-concept. Not open source. Not production software. Not marketplace-published. |
| Scope | Documentation. Command UX only. No product features added or changed. |
| Last validated | WP-12C-REL0-CROSS-SHELL-COMMAND-UX gate |

## 1. Why This Document Exists

The validator ladder and other AISRAF helper scripts are PowerShell scripts (`tools/*.ps1`). Earlier AISRAF documentation showed every command as a `pwsh -NoProfile -File ...` invocation. That over-assumed that every evaluator has PowerShell 7 (`pwsh`) installed.

This document gives every public AISRAF command three shell forms so an evaluator on any of the supported shells can run AISRAF without re-typing flags:

1. **PowerShell 7 (`pwsh`)** — the validator-tested shell on this repository.
2. **Windows PowerShell 5.1 (`powershell.exe`)** — preinstalled on Windows; works without installing PowerShell 7.
3. **Git Bash** — used for `git` commands and POSIX paths; calls `powershell.exe` explicitly when a PowerShell script is needed.

This is a documentation-only change. No product feature is added, removed, or moved. The legacy `AM` / `AL` / `Mode N` vocabulary remains internal architecture/evidence vocabulary; the public product flows live in [PRODUCT-FLOW-ROADMAP.md](PRODUCT-FLOW-ROADMAP.md).

## 2. Cross-Shell Support Matrix

The following matrix records the WP-12C-REL0-CROSS-SHELL-COMMAND-UX gate result on the evaluator workstation.

| Shell | Status in this gate | Notes |
|---|---|---|
| PowerShell 7 (`pwsh`) | Supported. Validator-tested. | Recommended when installed. Native `./path` and `.\path` both work. |
| Windows PowerShell 5.1 (`powershell.exe`) | Supported. Same PASS counts as `pwsh` for every validator in the ladder. | Preinstalled on Windows. Pass `-ExecutionPolicy Bypass` per command if the local execution policy is restricted. |
| Git Bash | Supported via `powershell.exe`. | Use Git Bash for `git` commands. For PowerShell scripts, call `powershell.exe` explicitly from Git Bash. |

Validator counts observed during the WP-12C-REL0-CROSS-SHELL-COMMAND-UX gate (pwsh and powershell.exe ran identically):

- `Test-AisrafPackage.ps1`: 83 PASS, 3 WARN, 0 FAIL (WARNs are the three expected `RUN-SMOKE-*` smoke-folder notices).
- `Test-AisrafBp12AReadiness.ps1`: 77 PASS, 0 FAIL.
- `Test-AisrafRunProfile.ps1 -RunProfilePath ./runs/RUN-001/run-profile.yaml -ExecutionReady`: 12 PASS, 0 FAIL.
- `Test-AisrafAm3Runtime.ps1 -ContractsOnly`: 4 PASS, 0 FAIL.
- `Test-AisrafAm3Runtime.ps1 -RunProfilePath ./runs/RUN-SMOKE-AM3-001/run-profile.yaml`: 23 PASS, 0 FAIL.

If a future change requires a feature that exists only in PowerShell 7, this document and the affected script's docstring must be updated to flag that script as PowerShell 7 only. As of this gate, no such script exists.

## 3. Repo Root Paths

From the repo root on Windows:

- PowerShell 7 / Windows PowerShell working directory:
  - `D:\E-Way 2\AISRAF- SAS Prototype v0.1.2`
- Git Bash working directory:
  - `/d/E-Way\ 2/AISRAF-\ SAS\ Prototype\ v0.1.2`

Quote any path that contains spaces. Prefer relative paths from the repo root (`./tools/Test-AisrafPackage.ps1` or `.\tools\Test-AisrafPackage.ps1`) so the same command works on every clone location.

## 4. Command Table

Each row gives the same command in three shells. `pwsh` is the recommended path when installed; `powershell.exe` and Git Bash invocations are equivalent for the AISRAF v0.1.2 script surface.

### 4.1 Run the package validator (Test-AisrafPackage)

| Shell | Command |
|---|---|
| PowerShell 7 | `pwsh -NoProfile -File ./tools/Test-AisrafPackage.ps1` |
| Windows PowerShell | `powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\tools\Test-AisrafPackage.ps1` |
| Git Bash | `powershell.exe -NoProfile -ExecutionPolicy Bypass -File ./tools/Test-AisrafPackage.ps1` |

### 4.2 Run the BP12A readiness validator

| Shell | Command |
|---|---|
| PowerShell 7 | `pwsh -NoProfile -File ./tools/Test-AisrafBp12AReadiness.ps1` |
| Windows PowerShell | `powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\tools\Test-AisrafBp12AReadiness.ps1` |
| Git Bash | `powershell.exe -NoProfile -ExecutionPolicy Bypass -File ./tools/Test-AisrafBp12AReadiness.ps1` |

### 4.3 Run the RUN-001 run-profile validator (execution-ready)

| Shell | Command |
|---|---|
| PowerShell 7 | `pwsh -NoProfile -File ./tools/Test-AisrafRunProfile.ps1 -RunProfilePath ./runs/RUN-001/run-profile.yaml -ExecutionReady` |
| Windows PowerShell | `powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\tools\Test-AisrafRunProfile.ps1 -RunProfilePath .\runs\RUN-001\run-profile.yaml -ExecutionReady` |
| Git Bash | `powershell.exe -NoProfile -ExecutionPolicy Bypass -File ./tools/Test-AisrafRunProfile.ps1 -RunProfilePath ./runs/RUN-001/run-profile.yaml -ExecutionReady` |

### 4.4 Run the AM3 contracts-only validator

| Shell | Command |
|---|---|
| PowerShell 7 | `pwsh -NoProfile -File ./tools/Test-AisrafAm3Runtime.ps1 -ContractsOnly` |
| Windows PowerShell | `powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\tools\Test-AisrafAm3Runtime.ps1 -ContractsOnly` |
| Git Bash | `powershell.exe -NoProfile -ExecutionPolicy Bypass -File ./tools/Test-AisrafAm3Runtime.ps1 -ContractsOnly` |

### 4.5 Run the AM3 runtime evidence validator against the local smoke evidence

| Shell | Command |
|---|---|
| PowerShell 7 | `pwsh -NoProfile -File ./tools/Test-AisrafAm3Runtime.ps1 -RunProfilePath ./runs/RUN-SMOKE-AM3-001/run-profile.yaml` |
| Windows PowerShell | `powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\tools\Test-AisrafAm3Runtime.ps1 -RunProfilePath .\runs\RUN-SMOKE-AM3-001\run-profile.yaml` |
| Git Bash | `powershell.exe -NoProfile -ExecutionPolicy Bypass -File ./tools/Test-AisrafAm3Runtime.ps1 -RunProfilePath ./runs/RUN-SMOKE-AM3-001/run-profile.yaml` |

`runs/RUN-SMOKE-AM3-001/` is internal local-only smoke evidence; it must not be staged or published.

### 4.6 Git status

| Shell | Command |
|---|---|
| PowerShell 7 | `git status --short` |
| Windows PowerShell | `git status --short` |
| Git Bash | `git status --short` |

### 4.7 Git log (recent commits)

| Shell | Command |
|---|---|
| PowerShell 7 | `git log -5 --oneline` |
| Windows PowerShell | `git log -5 --oneline` |
| Git Bash | `git log -5 --oneline` |

### 4.8 Rebuild the plugin bundle (only when `tools/Test-AisrafPackage.ps1` or another bundled tool changes)

| Shell | Command |
|---|---|
| PowerShell 7 | `pwsh -NoProfile -File ./tools/Build-AisrafCopilotPluginBundle.ps1 -Clean` |
| Windows PowerShell | `powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\tools\Build-AisrafCopilotPluginBundle.ps1 -Clean` |
| Git Bash | `powershell.exe -NoProfile -ExecutionPolicy Bypass -File ./tools/Build-AisrafCopilotPluginBundle.ps1 -Clean` |

Re-run `Test-AisrafPackage.ps1` and `Test-AisrafBp12AReadiness.ps1` after a bundle rebuild so the bundle checksum manifest (`plugins/aisraf-copilot-plugin/bundle-checksum-manifest.yaml`) revalidates.

### 4.9 Create a new personal run folder

| Shell | Command |
|---|---|
| PowerShell 7 | `pwsh -NoProfile -File ./tools/New-AisrafRun.ps1 -RunId RUN-MY-REVIEW-001 -SampleId sample-001-dfd-crop -CopySampleInputs` |
| Windows PowerShell | `powershell.exe -NoProfile -ExecutionPolicy Bypass -File .\tools\New-AisrafRun.ps1 -RunId RUN-MY-REVIEW-001 -SampleId sample-001-dfd-crop -CopySampleInputs` |
| Git Bash | `powershell.exe -NoProfile -ExecutionPolicy Bypass -File ./tools/New-AisrafRun.ps1 -RunId RUN-MY-REVIEW-001 -SampleId sample-001-dfd-crop -CopySampleInputs` |

## 5. Failure Guidance

These are the most common per-command failures and the safe response. Do not change global machine policy.

1. **`pwsh` is not recognized.** PowerShell 7 is not installed (or not on PATH). Use the `powershell.exe` row of the table instead. Optionally install PowerShell 7 from <https://aka.ms/powershell> if you want the recommended path.
2. **`powershell.exe` reports `cannot be loaded because running scripts is disabled on this system` or a similar `UnauthorizedAccess` error.** The local execution policy is restricted. Use `-ExecutionPolicy Bypass` on the single command shown in the table. This flag changes the policy for that one process only and does not change the machine policy. Do not run `Set-ExecutionPolicy ... -Scope LocalMachine`; this document does not authorize global policy changes.
3. **Path-with-spaces error in Git Bash.** Quote the path or use forward slashes: `powershell.exe -NoProfile -ExecutionPolicy Bypass -File "./tools/Test-AisrafPackage.ps1"`.
4. **Validator output is empty in Git Bash.** Confirm the working directory is the repo root: `cd "/d/E-Way 2/AISRAF- SAS Prototype v0.1.2"`. Validators resolve their package root from `$PSScriptRoot`, so they work from anywhere; the working directory only affects relative paths in arguments.
5. **A future script flags itself as PowerShell 7 only.** Follow the script's docstring guidance. As of this gate, every script in [tools/](../tools/) runs identically under `pwsh` 7.5 and `powershell.exe` 5.1.

## 6. Security Posture For Cross-Shell Invocations

- `-NoProfile` is recommended on every PowerShell invocation. It prevents user-profile drift from affecting validator output.
- `-ExecutionPolicy Bypass` is **per-command only**. Do not weaken the machine or user execution policy globally.
- AISRAF validators are read-only. They never call out to the network and never write outside the repo working tree. Cross-shell invocation does not change that posture.
- Do not run any AISRAF script with elevated privileges. Nothing in v0.1.2 requires Administrator.

## 7. What This Document Does Not Change

- No product claims change. v0.1.2 remains Public source-available evaluation-only proof-of-concept. Not open source. Not production software. Not marketplace-published.
- No external execution is added. No Jira, Confluence, Lucidchart, Rovo/MCP, cloud, database, Terraform, event bus, telemetry, or external post-back execution. Connected Review Flow (Flow 4) is planned for v0.2.0; Threat Intelligence Enrichment (Flow 5) is planned for v0.2.1; Mermaid Diagram Generation (Flow 6) and Plugin Install UX (Flow 7) are planned. Closed-loop autonomy (AL5) is out of scope.
- No script behavior changes. This is documentation only.

## 8. References

- [../README.md](../README.md) — public entry point; links to this command page.
- [../START-HERE.md](../START-HERE.md) — contributor entry point; links to this command page.
- [OPERATOR-QUICKSTART.md](OPERATOR-QUICKSTART.md) — operator quickstart; the validator ladder section links here.
- [../tools/README.md](../tools/README.md) — tools surface; references this page for shell variants.
- [PRODUCT-FLOW-ROADMAP.md](PRODUCT-FLOW-ROADMAP.md) — product flows; the public operating model.
- [../validation/package-12c-rel0-cross-shell-command-ux-report.md](../validation/package-12c-rel0-cross-shell-command-ux-report.md) — gate report that authorized this document.
