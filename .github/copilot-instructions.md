# Copilot Instructions For AISRAF SAS Prototype v0.1.2

This workspace is the clean rebuild root for **AISRAF SAS Prototype v0.1.2**. Confirm the workspace root is `D:/E-Way 2/AISRAF- SAS Prototype v0.1.2` before reading or writing package artifacts.

## Package Boundary

- The old package at `D:/E-Way 2/aisraf-sas-prototype-skill-chain-pack-v0.01` is read-only reference material.
- Do not modify the old package.
- Do not copy old generated outputs, stale release artifacts, failed diagrams, run proof, or temporary reports into this workspace.
- Use [PACKAGE-MANIFEST.yaml](../PACKAGE-MANIFEST.yaml), [FOLDER-CONTRACTS.md](../FOLDER-CONTRACTS.md), and [BUILD-ORDER.md](../BUILD-ORDER.md) as the current source of Build Package, Root Area, and filesystem structure truth.

## Current State

Build Packages 01–11 are active. Build Package 11 added the run-evidence model and the first canonical governed run fixture `runs/RUN-001/` for `sample-001-dfd-crop` plus four governance checklists (`validation/package-11-runs-checklist.md`, `validation/run-folder-shape-checklist.md`, `validation/run-log-checklist.md`, `validation/run-comparison-checklist.md`). RUN-001 carries `runs/RUN-001/README.md`, `runs/RUN-001/run-profile.yaml` (Build Package 02 schema-compliant; `mode: folder_first_test`, `output_destination_mode: local_only`, `postback_execution_status: deferred`, `sensitive_data_confirmed_redacted: true`, `expected_baseline_required: true`, `scoring_enabled: true`), `runs/RUN-001/00-run-log.md` (Build Package 09 file-shape compliant per `templates/output/output-00-run-log-template.md`; Step Entries / Post-Back Evidence / Stop Conditions Recorded sections empty), 6 byte-copies of the sample-001 inputs under `runs/RUN-001/inputs/`, and an empty governed `runs/RUN-001/dfd/` folder. The 17 RS chain outputs (`runs/RUN-001/01-input-inventory.md` through `17-accuracy-score.md`) and the 9 DFD outputs (`runs/RUN-001/dfd/dfd-01-intake-quality-check.md` through `dfd-09-extraction-summary.md`) are reserved future paths produced when the operator executes the Build Package 04–09 chain — Build Package 11 does NOT execute the chain and does NOT create any of the 26 outputs. Numeric accuracy scoring is owned by `prompts/rs/13-accuracy-score.prompt.md` / `skills/rs/SK-ACCURACY-SCORE.md` and activates only when the operator executes the chain. Build Package 11 did not modify any prompt, skill, prototype-agent, adapter, catalog, blueprint, template, sample, or config registry, and did not modify `tools/New-AisrafRun.ps1` or `tools/Test-AisrafRunProfile.ps1`. Other `runs/RUN-*` folders are smoke runs from `tools/New-AisrafRun.ps1` and must be removed before human git stage; `tools/Test-AisrafPackage.ps1` records each non-RUN-001 folder as WARN. The known mismatch between `tools/New-AisrafRun.ps1`'s legacy 00-run-log header and the Package 09 file shape is recorded as a future Build Package 03 increment compatibility note in `validation/run-log-checklist.md`. The next allowed Build Package is Build Package 12 — Validation.

## Foundation Rules

- Keep work inside the active workspace unless an instruction explicitly says to read the old reference package.
- Prefer editing existing Build Package 01 files over creating new files.
- Create only files authorized by the current Build Package contract.
- Do not create unlisted root files or folders.
- Use “Build Package” for the 01-16 implementation sequence.
- Use “Root Area” for package-tree and folder diagram numbering.
- Use the exact lowercase filesystem folder names listed in [FOLDER-CONTRACTS.md](../FOLDER-CONTRACTS.md).
- Do not create diagrams before Build Package 13.
- Do not create run outputs other than the governed Build Package 11 fixture `runs/RUN-001/`. Do not create the 17 RS chain outputs or the 9 DFD outputs inside Build Package 11 — those are reserved future paths produced when the operator executes the Build Package 04–09 chain.
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
- Run: self-contained execution evidence folder, active in Build Package 11 (`runs/<run_id>/` with `README.md`, `run-profile.yaml`, `00-run-log.md`, `inputs/` byte-copies, and `dfd/` reserved). The first canonical governed fixture is `runs/RUN-001/` for `sample-001-dfd-crop`. Build Package 11 establishes the run-evidence model only; it does not execute the chain. The 17 RS chain outputs at the run-folder root and 9 DFD outputs under `dfd/` are reserved future paths produced when the operator executes the Build Package 04–09 chain. Run logs follow the Build Package 09 file shape (`templates/output/output-00-run-log-template.md`) with row patterns from `templates/run/`. Post-back rows are admissible only when `postback_execution_status: executed_by_operator` plus `output_destination_mode: external_postback_executed` plus a destination URL is set. Other `runs/RUN-*` folders are smoke runs and must be removed before commit.
- Validation: evidence-bound checks and gates, expanded in Build Package 12.
- Release: generated reader artifacts only, deferred to Build Package 15.

## Evidence And Claims

Do not claim tests, external post-back, live Copilot adapter execution, cloud runtime, MCP execution, ADK execution, Vertex/GCP execution, Jira/Confluence/Rovo execution, database execution, Terraform execution, release packaging, diagram generation, or final QA unless the correct package authorizes the action and evidence exists in the governed location. Build Package 06 PRA specs and `.agent.md` adapters are local-only specifications and wrappers; selecting an adapter from the Copilot Chat dropdown is not equivalent to runtime execution.

## Stop Conditions

Stop and report the issue before writing if a requested change would create a prohibited artifact, write outside the allowed package surfaces, modify the old reference workspace, introduce secrets, or claim functionality that has not been implemented by the proper package.
