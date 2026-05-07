# Copilot Instructions For AISRAF SAS Prototype v0.1.2

This workspace is the clean rebuild root for **AISRAF SAS Prototype v0.1.2**. Confirm the workspace root is `D:/E-Way 2/AISRAF- SAS Prototype v0.1.2` before reading or writing package artifacts.

## Package Boundary

- The old package at `D:/E-Way 2/aisraf-sas-prototype-skill-chain-pack-v0.01` is read-only reference material.
- Do not modify the old package.
- Do not copy old generated outputs, stale release artifacts, failed diagrams, run proof, or temporary reports into this workspace.
- Use [PACKAGE-MANIFEST.yaml](../PACKAGE-MANIFEST.yaml), [FOLDER-CONTRACTS.md](../FOLDER-CONTRACTS.md), and [BUILD-ORDER.md](../BUILD-ORDER.md) as the current source of Build Package, Root Area, and filesystem structure truth.

## Current State

Build Packages 01–08 are active. Build Package 08 added 9 controlled YAML blueprints under `blueprints/` across two category folders (8 under `blueprints/platform-independent/` and 1 under `blueprints/cloud-patterns/`), the blueprint registry (`blueprints/blueprint-registry.yaml`), the blueprint template (`blueprints/blueprint-template.yaml`), and 3 READMEs (14 files total). Match states are fixed at four values: `matched`, `candidate`, `no_match`, `unknown` (founder decision Q1). Every blueprint references Build Package 07 catalog identifiers only; no new catalog values are introduced. Blueprints scope catalog evidence and surface material missing facts; selection of severity, AI Action Level, finding categories, recommendation types, and final disposition is owned by the consuming Build Package 05 skills and human review. Build Package 08 did not modify any prompt, skill, prototype-agent, adapter, or catalog registry; blueprint→catalog, blueprint→skill, blueprint→PRA, blueprint→adapter, and blueprint→prompt consumer maps are recorded only in `blueprints/blueprint-registry.yaml` and the validation checklists. Blueprint extension (a 10th blueprint, a new category, fine-tuning, multimodal, vector-governance, model-evaluation, or CSP-specific variants) requires a future governed blueprint update. The next allowed Build Package is Build Package 09 — Templates.

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
- Template: reusable output shape, deferred to Build Package 09 except Build Package 01 authoring-agent templates.
- Run: self-contained execution evidence folder, deferred to Build Package 11.
- Validation: evidence-bound checks and gates, expanded in Build Package 12.
- Release: generated reader artifacts only, deferred to Build Package 15.

## Evidence And Claims

Do not claim tests, external post-back, live Copilot adapter execution, cloud runtime, MCP execution, ADK execution, Vertex/GCP execution, Jira/Confluence/Rovo execution, database execution, Terraform execution, release packaging, diagram generation, or final QA unless the correct package authorizes the action and evidence exists in the governed location. Build Package 06 PRA specs and `.agent.md` adapters are local-only specifications and wrappers; selecting an adapter from the Copilot Chat dropdown is not equivalent to runtime execution.

## Stop Conditions

Stop and report the issue before writing if a requested change would create a prohibited artifact, write outside the allowed package surfaces, modify the old reference workspace, introduce secrets, or claim functionality that has not been implemented by the proper package.
