# config/

Root Area: Root Area 04.

Owning Build Package: Build Package 02 — Config and run-profile variable model.

## Purpose

Canonical configuration and run-profile variable model for AISRAF SAS Prototype v0.1.2. Every Build Package from 03 through 16 resolves run-time `{{variable}}` references against the schema and rules declared here.

## What Belongs Here

- The run-profile schema, template, samples, field catalog, validation rules, path resolution rules, integration fields documentation, and sensitive-data rules added by Build Package 02.
- Future config registries (CFG-* style) added only by their owning Build Package (catalogs in Build Package 07; scoring registry referenced from Build Package 12; etc.) once that Build Package authorizes them.

## What Does Not Belong Here

Secrets, credentials, local tokens, scripts, runtime services, generated reports, run outputs, release artifacts, cloud configuration claims, prompt cards, skill contracts, PRA specs, `.agent.md` adapters, catalogs, blueprints, samples, diagrams, or templates.

## Files

Build Package 02 active files:

- [run-profile.schema.yaml](run-profile.schema.yaml) — canonical schema for `runs/<run_id>/run-profile.yaml`. Required fields, types, enums, conditional rules.
- [run-profile.template.yaml](run-profile.template.yaml) — canonical template copied into a new run folder by the Build Package 03 setup helper.
- [run-profile.sample.folder-first.yaml](run-profile.sample.folder-first.yaml) — concrete folder-first example without Jira, Confluence, Rovo, or MCP.
- [run-profile.sample.integration.yaml](run-profile.sample.integration.yaml) — concrete example with optional integration metadata; post-back stays deferred until human evidence.
- [run-profile.field-catalog.md](run-profile.field-catalog.md) — per-field catalog: type, allowed values, default, edited-by, derived, used-by Build Packages, sensitivity, example.
- [run-profile.validation-rules.md](run-profile.validation-rules.md) — 14 validation checks Build Packages 03 and 12 enforce.
- [path-resolution-rules.md](path-resolution-rules.md) — how relative paths resolve from the workspace root; output write-boundary; no-hardcoded-paths rule.
- [integration-fields.md](integration-fields.md) — Jira/Confluence/Rovo/MCP field semantics; no-claim-without-evidence rule.
- [sensitive-data-rules.md](sensitive-data-rules.md) — categorical prohibitions, lint targets, incident response.

## Read order

For a new contributor:

1. [run-profile.schema.yaml](run-profile.schema.yaml) — what fields exist.
2. [run-profile.field-catalog.md](run-profile.field-catalog.md) — what each field means.
3. [run-profile.template.yaml](run-profile.template.yaml) — what a fresh profile looks like.
4. [run-profile.sample.folder-first.yaml](run-profile.sample.folder-first.yaml) and [run-profile.sample.integration.yaml](run-profile.sample.integration.yaml) — concrete examples.
5. [path-resolution-rules.md](path-resolution-rules.md), [integration-fields.md](integration-fields.md), [sensitive-data-rules.md](sensitive-data-rules.md) — operational rules.
6. [run-profile.validation-rules.md](run-profile.validation-rules.md) — what passes and what fails.

## Validation

Build Package 02 acceptance is gated by [../validation/package-02-config-checklist.md](../validation/package-02-config-checklist.md).

## Status

Build Package 02 status: **active** — configuration and run-profile variable model is in place and ready for Build Package 03 (Tools and setup/test/export scripts) to consume.
