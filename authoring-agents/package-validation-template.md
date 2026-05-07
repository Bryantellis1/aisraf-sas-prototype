# Build Package Validation Template

Use this template to validate a Build Package after implementation.

## Validation Target

Build Package: `<Build Package number — Build Package name>`

Validator: `<agent or human>`

Date: `<YYYY-MM-DD>`

Workspace: `D:/E-Way 2/AISRAF- SAS Prototype v0.1.2`

## Preconditions

- [ ] Active workspace root is correct.
- [ ] Old reference workspace is read-only.
- [ ] Build Package dependencies are complete or explicitly marked partial.
- [ ] Allowed write surface is known.

## Structure Checks

- [ ] Required files exist.
- [ ] Required folders exist.
- [ ] No unlisted root files or folders were created.
- [ ] Folder README files are present where required.

## Content Checks

- [ ] Artifact purpose is clear.
- [ ] Owning Build Package is stated.
- [ ] Current status is honest.
- [ ] Deferred work is named without being claimed as implemented.
- [ ] Old reference material is not treated as current truth.

## Boundary Checks

- [ ] No release artifacts before Build Package 15.
- [ ] No diagrams before Build Package 13.
- [ ] No run outputs before Build Package 11.
- [ ] No prompt, skill, PRA, adapter, catalog, blueprint, sample, schema, runtime, cloud, MCP, or ADK claims outside the owning Build Package.
- [ ] No secrets or production payloads were introduced.

## Evidence

Validation evidence reviewed:

- `<file or check>`

## Verdict

Status: `PASS / PARTIAL_WITH_ISSUES / FAIL`

Remaining issues:

- `<issue or none>`

Next allowed Build Package:

- `<package>`
