# Copilot Instructions For AISRAF SAS Prototype v0.1.2

This workspace is the clean rebuild root for **AISRAF SAS Prototype v0.1.2**. Confirm the workspace root is `D:/E-Way 2/AISRAF- SAS Prototype v0.1.2` before reading or writing package artifacts.

## Package Boundary

- The old package at `D:/E-Way 2/aisraf-sas-prototype-skill-chain-pack-v0.01` is read-only reference material.
- Do not modify the old package.
- Do not copy old generated outputs, stale release artifacts, failed diagrams, run proof, or temporary reports into this workspace.
- Use [PACKAGE-MANIFEST.yaml](../PACKAGE-MANIFEST.yaml), [FOLDER-CONTRACTS.md](../FOLDER-CONTRACTS.md), and [BUILD-ORDER.md](../BUILD-ORDER.md) as the current source of Build Package, Root Area, and filesystem structure truth.

## Current State

Build Packages 01–10 are active. Build Package 10 added 1 active gold-standard scored sample under `samples/sample-001-dfd-crop/` (AI SaaS Security Review Portal scenario) plus the sample registry `samples/sample-registry.yaml` (founder decisions Q1–Q8). Sample-001 carries 6 synthetic inputs (`inputs/dfd-crop.png`, `inputs/dfd-crop.mmd`, `inputs/dfd-legend-excerpt.md`, `inputs/cloud-triage-notes.md`, `inputs/review-transcript.md`, `inputs/intake-ticket.md`) and 26 Markdown expected baselines under `samples/sample-001-dfd-crop/expected/` (17 RS mirroring `templates/output/output-01..17-*-template.md` and 9 DFD mirroring `templates/output/output-dfd-01..09-*-template.md`). Samples are test fixtures: synthetic only, no real PII / PAN / SSN / PHI / secrets / credentials / production endpoints; no Jira post-back / Confluence publication / Rovo / MCP / runtime / cloud / ADK / Vertex / GCP / database / Terraform execution claims; no severity / finding-category / AI Action Level / blueprint-match / accuracy-score computation inside expected-baseline bodies. Expected baselines are Markdown-only with optional YAML front matter for traceability and scoring metadata (founder decision Q1: no JSON baselines). `expected-00-run-log.md` is intentionally not created — run logs are run artefacts deferred to Build Package 11 (founder decision Q2). All 9 DFD subskill expected baselines are included in sample-001 (founder decision Q3). The sample DFD PNG was regenerated from the v0.1.2 Mermaid source via `mmdc`; the v0.01 PNG is read-only conceptual reference only (founder decision Q4). Numeric accuracy scoring is qualitative (`PASS_READY_FOR_REVIEW`) until Build Package 11 run execution validates numeric scoring; the v0.01 reference 151/160 is recorded in `expected/expected-17-accuracy-score.md` as `legacy_reference_score` only (founder decision Q5). `samples/sample-registry.yaml` records the active sample-001 entry plus `planned_or_deferred_samples` entries for sample-002 through sample-008 — no folders or files exist for the deferred entries (founder decisions Q7 and Q8). Build Package 10 did not modify any prompt, skill, prototype-agent, adapter, catalog, blueprint, template, or config registry; consumer maps are recorded only in `samples/sample-registry.yaml` and the validation checklists. The next allowed Build Package is Build Package 11 — Runs and execution evidence model.

## Foundation Rules

- Keep work inside the active workspace unless an instruction explicitly says to read the old reference package.
- Prefer editing existing Build Package 01 files over creating new files.
- Create only files authorized by the current Build Package contract.
- Do not create unlisted root files or folders.
- Use “Build Package” for the 01-16 implementation sequence.
- Use “Root Area” for package-tree and folder diagram numbering.
- Use the exact lowercase filesystem folder names listed in [FOLDER-CONTRACTS.md](../FOLDER-CONTRACTS.md).
- Do not create diagrams before Build Package 13.
- Do not create run outputs before Build Package 11.
- Do not create release DOCX/PDF/PPTX/ZIP artifacts before Build Package 15.
- Do not claim final QA, seal, or export before Build Package 16.

## Artifact Boundaries

- Prompt: reusable instruction file for Copilot or an agent, active in Build Package 04 (`prompts/prompt-registry.yaml`, `prompts/rs/*.prompt.md`, `prompts/dfd/*.prompt.md`).
- Skill: reusable work contract, not an executable tool, active in Build Package 05 (`skills/skill-registry.yaml`, `skills/rs/SK-*.md`, `skills/dfd/SK-DFD-0[1-9]-*.md`).
- PRA: Prototype Review Agent specification, not a deployed runtime agent, active in Build Package 06 (`prototype-agents/prototype-agent-registry.yaml`, 8 `prototype-agents/PRA-0[1-8]-*.md` files, `prototype-agents/prototype-agent-template.md`).
- `.agent.md` adapter: local VS Code/GitHub Copilot thin wrapper around canonical PRA/prompt/skill artifacts, active in Build Package 06 (7 `.agents/aisraf-*.agent.md` files; PRA-04 has no dedicated adapter and is wrapped jointly by `.agents/aisraf-dfd-extractor.agent.md`).
- Catalog: controlled vocabulary source, active in Build Package 07 (`catalogs/catalog-registry.yaml`, plus 24 YAML catalogs across `catalogs/components/`, `catalogs/interactions/`, `catalogs/boundaries/`, `catalogs/identity-access/`, `catalogs/data-protection/`, `catalogs/security-stacks/`, `catalogs/review/`).
- Blueprint: reusable review pattern, active in Build Package 08 (`blueprints/blueprint-registry.yaml`, `blueprints/blueprint-template.yaml`, 8 `blueprints/platform-independent/BP-*.yaml` files, and 1 `blueprints/cloud-patterns/BP-AI-SAAS-INTEGRATION.yaml` file). Match states are fixed at four values (`matched`, `candidate`, `no_match`, `unknown`).
- Template: reusable output shape, active in Build Package 09 (`templates/template-registry.yaml`, plus 27 file-shape templates under `templates/output/`, 1 Jira draft under `templates/jira/`, 1 Confluence draft under `templates/confluence/`, and 2 row patterns under `templates/run/`). Templates define output shape only; they do not execute the review and do not compute severity, score, AI Action Level, blueprint match, finding facts, or recommendation prose. Catalog values are referenced via `<value-from-catalogs/...>` placeholders — never enumerated inside templates.
- Sample: synthetic test fixture, active in Build Package 10 (`samples/sample-registry.yaml`, plus `samples/sample-001-dfd-crop/` with 6 inputs and 26 Markdown expected baselines mirroring Package 09 templates). Samples are test fixtures, not runs. They do not produce live run outputs, are not runtime evidence, are not release artefacts, and are not external Jira / Confluence / MCP proof. Expected baselines are Markdown-only (founder decision Q1) with optional YAML front matter for traceability/scoring metadata. `expected-00-run-log.md` is not created (founder decision Q2). Samples 002–008 are registry-only `planned_or_deferred_samples` entries with no folders or files (founder decision Q8). Numeric scoring is qualitative until Build Package 11.
- Run: self-contained execution evidence folder, deferred to Build Package 11.
- Validation: evidence-bound checks and gates, expanded in Build Package 12.
- Release: generated reader artifacts only, deferred to Build Package 15.

## Evidence And Claims

Do not claim tests, external post-back, live Copilot adapter execution, cloud runtime, MCP execution, ADK execution, Vertex/GCP execution, Jira/Confluence/Rovo execution, database execution, Terraform execution, release packaging, diagram generation, or final QA unless the correct package authorizes the action and evidence exists in the governed location. Build Package 06 PRA specs and `.agent.md` adapters are local-only specifications and wrappers; selecting an adapter from the Copilot Chat dropdown is not equivalent to runtime execution.

## Stop Conditions

Stop and report the issue before writing if a requested change would create a prohibited artifact, write outside the allowed package surfaces, modify the old reference workspace, introduce secrets, or claim functionality that has not been implemented by the proper package.
