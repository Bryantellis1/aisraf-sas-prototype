# Copilot Instructions For AISRAF SAS Prototype v0.1.2

This workspace is the clean rebuild root for **AISRAF SAS Prototype v0.1.2**. Confirm the workspace root is `D:/E-Way 2/AISRAF- SAS Prototype v0.1.2` before reading or writing package artifacts.

## Package Boundary

- The old package at `D:/E-Way 2/aisraf-sas-prototype-skill-chain-pack-v0.01` is read-only reference material.
- Do not modify the old package.
- Do not copy old generated outputs, stale release artifacts, failed diagrams, run proof, or temporary reports into this workspace.
- Use [PACKAGE-MANIFEST.yaml](../PACKAGE-MANIFEST.yaml), [FOLDER-CONTRACTS.md](../FOLDER-CONTRACTS.md), and [BUILD-ORDER.md](../BUILD-ORDER.md) as the current source of Build Package, Root Area, and filesystem structure truth.

## Current State

Build Packages 01–09 are active. Build Package 09 added 31 reusable Markdown output-shape templates under `templates/` across four family folders (27 under `templates/output/`, 1 under `templates/jira/`, 1 under `templates/confluence/`, 2 under `templates/run/`), the template registry (`templates/template-registry.yaml`), and 5 READMEs (37 files total; founder decision Q5). Templates define output shape only; they do not execute the review, do not compute severity / score / AI Action Level / blueprint match, do not invent finding facts or recommendation prose, do not claim runtime / cloud / MCP / Jira / Confluence / Rovo / ADK / database / Terraform execution, and do not override catalogs or blueprints. Templates use only the seven approved run-profile placeholders (`{{run_id}}`, `{{input_root}}`, `{{expected_root}}`, `{{output_root}}`, `{{mode}}`, `{{postback_execution_status}}`, `{{output_destination_mode}}`); other run-profile schema fields are referenced descriptively as `[copy from runs/{{run_id}}/run-profile.yaml#field_name]` (founder decision Q2). Catalog controlled values are referenced via `<value-from-catalogs/...>` placeholder syntax — no enumeration inside template bodies and no new controlled values introduced (founder decision Q3). Output templates use the `output-NN-name-template.md` naming convention so the template file is unambiguously distinct from the future `runs/<run_id>/<output_root>/NN-name.md` artifact (founder decision Q4). The run-log template is split: `templates/output/output-00-run-log-template.md` defines the file shape; `templates/run/run-log-entry-row-template.md` and `templates/run/postback-log-entry-row-template.md` define row patterns (founder decision Q1). Build Package 09 did not modify any prompt, skill, prototype-agent, adapter, catalog, or blueprint registry; template→prompt, template→skill, template→PRA, template→adapter, template→blueprint, and template→catalog consumer maps are recorded only in `templates/template-registry.yaml` and the validation checklists. Template extension (a 32nd template, new family, etc.) requires a future governed template update. The next allowed Build Package is Build Package 10 — Samples and expected baselines.

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
- Run: self-contained execution evidence folder, deferred to Build Package 11.
- Validation: evidence-bound checks and gates, expanded in Build Package 12.
- Release: generated reader artifacts only, deferred to Build Package 15.

## Evidence And Claims

Do not claim tests, external post-back, live Copilot adapter execution, cloud runtime, MCP execution, ADK execution, Vertex/GCP execution, Jira/Confluence/Rovo execution, database execution, Terraform execution, release packaging, diagram generation, or final QA unless the correct package authorizes the action and evidence exists in the governed location. Build Package 06 PRA specs and `.agent.md` adapters are local-only specifications and wrappers; selecting an adapter from the Copilot Chat dropdown is not equivalent to runtime execution.

## Stop Conditions

Stop and report the issue before writing if a requested change would create a prohibited artifact, write outside the allowed package surfaces, modify the old reference workspace, introduce secrets, or claim functionality that has not been implemented by the proper package.
