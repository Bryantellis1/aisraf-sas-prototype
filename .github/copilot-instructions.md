# Copilot Instructions For AISRAF SAS Prototype v0.1.2

This workspace is the clean rebuild root for **AISRAF SAS Prototype v0.1.2**. Confirm the workspace root is `D:/E-Way 2/AISRAF- SAS Prototype v0.1.2` before reading or writing package artifacts.

## Package Boundary

- The old package at `D:/E-Way 2/aisraf-sas-prototype-skill-chain-pack-v0.01` is read-only reference material.
- Do not modify the old package.
- Do not copy old generated outputs, stale release artifacts, failed diagrams, run proof, or temporary reports into this workspace.
- Use [PACKAGE-MANIFEST.yaml](../PACKAGE-MANIFEST.yaml), [FOLDER-CONTRACTS.md](../FOLDER-CONTRACTS.md), and [BUILD-ORDER.md](../BUILD-ORDER.md) as the current source of Build Package, Root Area, and filesystem structure truth.

## Current State

Build Packages 01–04 are committed. Build Package 04 added prompts and the prompt registry (`prompts/`, 23 cards). Later Build Packages must follow their own build contracts before adding skill contracts, PRA specs, `.agent.md` adapters, catalogs, blueprints, templates beyond authoring-agent templates, samples, runs, diagrams, documentation, release packaging, or final QA artifacts. The next allowed Build Package is Build Package 05 — Skills and skill registry.

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

- Prompt: reusable instruction file for Copilot or an agent, deferred to Build Package 04.
- Skill: reusable work contract, not an executable tool, deferred to Build Package 05.
- PRA: Prototype Review Agent specification, not a deployed runtime agent, deferred to Build Package 06.
- `.agent.md` adapter: local VS Code/GitHub Copilot wrapper around canonical PRA/prompt/skill artifacts, deferred to Build Package 06.
- Catalog: controlled vocabulary source, deferred to Build Package 07.
- Blueprint: reusable review pattern, deferred to Build Package 08.
- Template: reusable output shape, deferred to Build Package 09 except Build Package 01 authoring-agent templates.
- Run: self-contained execution evidence folder, deferred to Build Package 11.
- Validation: evidence-bound checks and gates, expanded in Build Package 12.
- Release: generated reader artifacts only, deferred to Build Package 15.

## Evidence And Claims

Do not claim tests, external post-back, live Copilot adapter selection, cloud runtime, MCP execution, ADK execution, release packaging, or final QA unless the correct package authorizes the action and evidence exists in the governed location.

## Stop Conditions

Stop and report the issue before writing if a requested change would create a prohibited artifact, write outside the allowed package surfaces, modify the old reference workspace, introduce secrets, or claim functionality that has not been implemented by the proper package.
