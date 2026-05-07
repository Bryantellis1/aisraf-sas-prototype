# tools/

Root Area: Root Area 05.

Owning Build Package: Build Package 03 — Tools and setup/test/export scripts.

## Purpose

Local PowerShell helper scripts that operationalize the Build Package 02 run-profile variable model. Tools prepare folder-first run scaffolds, validate run-profile YAML against the canonical schema, and smoke-test the package surface.

Tools are local helper scripts, not runtime services.

## Authority

| Concern | Authority |
|---|---|
| Schema | [config/run-profile.schema.yaml](../config/run-profile.schema.yaml) |
| Template | [config/run-profile.template.yaml](../config/run-profile.template.yaml) |
| Validation rules | [config/run-profile.validation-rules.md](../config/run-profile.validation-rules.md) |
| Path rules | [config/path-resolution-rules.md](../config/path-resolution-rules.md) |
| Sensitive-data rules | [config/sensitive-data-rules.md](../config/sensitive-data-rules.md) |
| No-drift rules | [validation/no-drift-rules.md](../validation/no-drift-rules.md) |

Tools never invent run-profile fields outside the schema.

## What These Tools Do Not Do

The Build Package 03 tools do not:

- run prompt cards (Build Package 04 surface);
- execute skill contracts (Build Package 05 surface);
- execute PRA specifications or `.agent.md` adapters (Build Package 06 surface);
- read controlled vocabulary catalogs at runtime (Build Package 07 surface);
- match blueprint patterns at runtime (Build Package 08 surface);
- generate templated outputs at runtime (Build Package 09 surface);
- create or edit sample inputs or expected baselines (Build Package 10 surface);
- create run outputs beyond the empty scaffold (Build Package 11 surface);
- perform package, prompt, skill, run, or release validation beyond the smoke checks declared here (Build Package 12 surface);
- generate diagrams (Build Package 13 surface);
- generate runbooks or practitioner guides (Build Package 14 surface);
- export release artifacts (Build Package 15 surface);
- perform final QA seal (Build Package 16 surface);
- call Jira, Confluence, Atlassian Rovo, or any MCP server;
- create cloud, GCP, ADK, database, or Terraform resources;
- read or write secrets, API keys, tokens, or session credentials;
- modify the old reference workspace at `D:/E-Way 2/aisraf-sas-prototype-skill-chain-pack-v0.01`.

## Tool Inventory

| Tool | Purpose |
|---|---|
| [New-AisrafRun.ps1](New-AisrafRun.ps1) | Scaffold `runs/<RunId>/` with `inputs/`, `dfd/`, a resolved `run-profile.yaml` from the Build Package 02 template, and an initial `00-run-log.md`. Does not execute prompts, skills, PRAs, or adapters. Refuses to overwrite an existing run folder; `-Force` is intentionally not implemented. |
| [Test-AisrafRunProfile.ps1](Test-AisrafRunProfile.ps1) | Validate one `run-profile.yaml` against `config/run-profile.schema.yaml` and `config/run-profile.validation-rules.md`. Two levels: `-ProfileShape` (default; allows `sensitive_data_confirmed_redacted: false`) and `-ExecutionReady` (requires `sensitive_data_confirmed_redacted: true`). Exit code 1 on any FAIL. |
| [Test-AisrafPackage.ps1](Test-AisrafPackage.ps1) | Smoke-test the Build Package 01-03 surface: required root files, folder READMEs, Build Package 02 config files, Build Package 03 tool files, and forbidden later-package artifacts. WARNs on `runs/RUN-*/` folders; FAILs on forbidden artifacts and committed later-package content. |

## Dependencies

- PowerShell 7+ (`pwsh`) on Windows. The scripts use `Set-StrictMode -Version Latest` and `$ErrorActionPreference = 'Stop'`.
- No external PowerShell modules. The flat-scalar YAML used by `run-profile.yaml` is parsed in-script.
- Scripts resolve `PackageRoot` as the parent of `$PSScriptRoot` (this `tools/` directory's parent), so they can be invoked from anywhere.

## Common Commands

Scaffold a new folder-first run:

```powershell
.\tools\New-AisrafRun.ps1 -RunId RUN-LOCAL-001
```

Scaffold and copy sample inputs:

```powershell
.\tools\New-AisrafRun.ps1 -RunId RUN-LOCAL-001 -CopySampleInputs
```

Dry-run preview without writing files:

```powershell
.\tools\New-AisrafRun.ps1 -RunId RUN-LOCAL-001 -WhatIf
```

Validate the run profile shape (default level):

```powershell
.\tools\Test-AisrafRunProfile.ps1 -RunProfilePath .\runs\RUN-LOCAL-001\run-profile.yaml
```

Validate the run profile under execution-ready rules:

```powershell
.\tools\Test-AisrafRunProfile.ps1 -RunProfilePath .\runs\RUN-LOCAL-001\run-profile.yaml -ExecutionReady
```

Smoke-test the package surface:

```powershell
.\tools\Test-AisrafPackage.ps1
```

## Stop Conditions

The tools refuse to proceed and exit with an error when:

- `RunId` does not match `^RUN-[A-Z0-9][A-Z0-9-]*$` (length 5-64).
- `SampleId` does not match `^sample-[0-9]{3}[a-z0-9-]*$` (length 11-64).
- `Mode` is not one of the six values in `config/run-profile.schema.yaml`.
- The target `runs/<RunId>/` already exists.
- `config/run-profile.template.yaml` is missing.
- A resolved write target lies outside the active workspace root.
- The validator finds any FAIL in the schema, type, enum, identifier, path, no-drift, mode-coupling, post-back, connector, scoring, or sensitive-data checks.
- `Test-AisrafPackage` finds a forbidden release binary (`*.docx`, `*.pdf`, `*.pptx`, `*.zip`), an `.agent.md` file, content beyond `README.md` in a folder owned by a later Build Package, or unexpected files in `tools/`, `config/`, `validation/`, `samples/`, or `authoring-agents/`.

## Operator Reminder

`config/run-profile.template.yaml` ships `sensitive_data_confirmed_redacted: false`. The operator must explicitly flip this field to `true` in `runs/<RunId>/run-profile.yaml` after confirming inputs are clean per `config/sensitive-data-rules.md`. `Test-AisrafRunProfile.ps1 -ExecutionReady` enforces this gate; `-ProfileShape` does not.

## Current Build Package 03 Status

Active. The three scripts and this README are the complete Build Package 03 tool surface. `tools/Export-AisrafRelease.ps1` is intentionally deferred to Build Package 15 — release packaging.
