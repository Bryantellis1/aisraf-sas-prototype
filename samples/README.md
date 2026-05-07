# samples/

Root Area: Root Area 12.

Owning Build Package: Build Package 10 — Samples and expected baselines.

Status: active. One sample is currently active; seven samples are recorded as planned/deferred in `samples/sample-registry.yaml` without folders or files.

## Purpose

Synthetic sample input packages and expected baselines for the AISRAF SAS Prototype v0.1.2 prompt → skill → PRA → adapter → blueprint → catalog → template chain. Samples are **test fixtures**. They are not live run outputs, not runtime evidence, not release artefacts, not diagrams package assets, and not external Jira / Confluence / MCP proof.

## Sample Classes

| class | meaning | baseline expectation in v0.1.2 |
|---|---|---|
| `gold-standard scored sample` | Clean end-to-end qualitative baseline for the full RS + DFD chain. | 17 RS Markdown baselines mirroring `templates/output/output-NN-*-template.md` plus 9 DFD Markdown baselines mirroring `templates/output/output-dfd-NN-*-template.md`. Numeric scoring is qualitative until Build Package 11 run execution. |
| `targeted behavior baseline` | Focused fixture for one or more prompt, skill, adapter, or full-chain behaviours. | Subset of Markdown baselines aligned to the targeted behaviour's templates. |
| `exploratory sample` | Future intake or review package without scored expectations. | Must be labeled exploratory and must not be scored until expected baselines are approved. |

## Active Sample (Build Package 10)

| sample | class | scenario | status |
|---|---|---|---|
| `sample-001-dfd-crop/` | `gold-standard scored sample` | AI SaaS Security Review Portal — internal review web app that calls an external AI Analysis Service and renders local Jira/Confluence drafts. | active |

## Planned/Deferred Samples (registry only — no folders)

`samples/sample-registry.yaml` records the following targeted-behavior samples for a future governed package; **Build Package 10 does not create folders or files for them**:

- `sample-002-annotation-token-matrix` (targeted: annotation token semantics)
- `sample-003-nested-cloud-boundaries` (targeted: nested provider/folder/project/region/VPC/subnet boundaries)
- `sample-004-overlapping-lines-low-confidence` (targeted: raw-flow preservation, low confidence, unknown endpoints)
- `sample-005-storage-and-backup-flows` (targeted: storage markers, backup/restore flows)
- `sample-006-cross-boundary-authz-gap` (targeted: AuthN/AuthZ separation)
- `sample-007-security-stack-diamonds` (targeted: stack-diamonds as review signal only)
- `sample-008-jira-confluence-formatted-output` (targeted: local Jira/Confluence formatting; `formatted_only`)

## Allowed File Types

Markdown for sample READMEs, expected baselines, and sample input narratives; PNG for the DFD image; Mermaid `.mmd` for the DFD source companion; and YAML for `sample-registry.yaml` only.

## What Belongs Here

- Synthetic input packages under `samples/<sample_id>/inputs/`.
- Expected baselines under `samples/<sample_id>/expected/`.
- A sample-level README that documents scenario, scope, expected blueprint disposition, expected AI Action Level, critical-miss list, and what the sample does not prove.
- A registry (`samples/sample-registry.yaml`) that pins active and deferred samples, mirrors templates / consumers, and carries the global runtime / external-execution flags as `false`.

## What Does Not Belong Here

- Real PII, PAN, SSN, PHI, customer identifiers, internal employee identifiers, secrets, credentials, or production endpoints.
- Live run outputs (those belong under `runs/<run_id>/` per Build Package 11).
- Release artefacts, diagrams package assets, documentation runbooks.
- New prompts, skills, PRAs, adapters, catalogs, blueprints, or templates.
- Jira post-back claims, Confluence publication claims, Rovo / MCP / ADK / Vertex / GCP / database / Terraform execution claims.
- Numeric accuracy thresholds rebased to force a pass — `expected_score_threshold` is not lowered by samples.
- JSON expected baselines — Package 10 uses Markdown-only expected baselines (founder decision Q1).

## Sample Authoring Rules

- Synthetic-data only; no real customer or production material.
- Unknowns are allowed and must be explicit. Silent unknowns are prohibited.
- Each expected baseline mirrors its Package 09 template's `required_sections` exactly.
- Optional YAML front matter is allowed for traceability and scoring metadata only (no JSON baselines).
- Catalog values are referenced via `<value-from-catalogs/...>` placeholders. No new controlled values are introduced.
- Blueprint identifiers are referenced via `<value-from-blueprints/blueprint-registry.yaml#blueprint_id>`. The four-state match model `matched / candidate / no_match / unknown` applies. No new BP-* identifiers are introduced.
- Other run-profile fields (`sample_id`, `source_ticket_url`, `destination_ticket_url`, `destination_confluence_url`, `jira_connector_status`, `confluence_connector_status`, `rovo_mcp_available`, `mcp_execution_status`, `operator_name`, `reviewer_name`) are referenced descriptively as `[copy from runs/{{run_id}}/run-profile.yaml#field_name]`.
- The Jira/Confluence formatter outputs are `formatted_only`; no template, sample, prompt, skill, PRA, adapter, run output, or governance file may claim Jira post-back or Confluence publication unless `runs/{{run_id}}/run-profile.yaml#postback_execution_status` is `executed_by_operator` and `{{output_root}}/00-run-log.md` records timestamp + destination URL.

## Validation

- `validation/package-10-samples-checklist.md` — Build Package 10 acceptance checklist.
- `validation/sample-registry-checklist.md` — sample-registry shape checks.
- `validation/sample-baseline-checklist.md` — per-baseline lint (template alignment, allowed placeholders, no invented catalog/blueprint values, no real PII/PAN/SSN/PHI/secrets/production endpoints, no runtime / cloud / MCP / Jira / Confluence / Rovo / ADK / database / Terraform claims).
- `tools/Test-AisrafPackage.ps1` — surface check (Check `08h-samples-content-limits` enforces the Package 10 sample folder layout).

## Common Mistakes

- Adding a real production endpoint, real customer record, real credential, or real ticket URL.
- Forcing F4 / F5 data class to `DC-C5` or `DC-C4` for `sample-001-dfd-crop` instead of the supported `DC-UNKNOWN`.
- Treating `S1` / `E1` / `T1` as proof rather than signal.
- Producing Jira post-back or Confluence publication claims from the F8 `formatted_only` flow.
- Adding a JSON expected baseline (Package 10 is Markdown-only).
- Creating folders or files for `sample-002` through `sample-008` (registry only).
- Mixing implementation-validation evidence into the handoff pack.
