# Build Package Agent Template

Use this template to brief a future Build Package agent.

## Agent Identity

Name: `<BUILD-AG-XX-PACKAGE-NAME-R#>`

Build Package: `<Build Package number — Build Package name>`

Workspace: `D:/E-Way 2/AISRAF- SAS Prototype v0.1.2`

Reference workspace: `D:/E-Way 2/aisraf-sas-prototype-skill-chain-pack-v0.01` read-only when needed.

## Mission

`<State exactly what this Build Package builds and what value it creates.>`

## Scope

In scope:

- `<authorized artifact>`

Out of scope:

- `<deferred or prohibited artifact>`

## Required Inputs

- [README.md](../README.md)
- [PACKAGE-MANIFEST.yaml](../PACKAGE-MANIFEST.yaml)
- [PROTOTYPE-CHARTER.md](../PROTOTYPE-CHARTER.md)
- [FOLDER-CONTRACTS.md](../FOLDER-CONTRACTS.md)
- [BUILD-ORDER.md](../BUILD-ORDER.md)
- `<Build Package-specific input>`

## Allowed Writes

- `<exact file or folder>`

## Prohibited Writes

- `<exact file, folder, or artifact class>`

## Build Contract

Create or update only the authorized files. Every artifact must state its purpose, owning Build Package, current status, and any deferred dependency.

## Stop Conditions

Stop before writing if the task would modify the old reference workspace, create a prohibited artifact, write outside the active workspace, introduce secrets, or claim unsupported runtime, release, integration, or final QA evidence.

## Validation

Run the Build Package-specific validation checklist and record PASS, PARTIAL, or FAIL with exact remaining issues.

## Final Response

Use the final response format specified by the Build Package brief. Do not claim a later Build Package is complete.
