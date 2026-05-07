# AISRAF SAS Prototype v0.1.2

AISRAF SAS means AISRAF Security Advisory Services. This package is a local-first security advisory review prototype for testing how VS Code, GitHub Copilot, prompt cards, skill contracts, PRA specifications, local adapter wrappers, catalogs, blueprints, templates, samples, run profiles, validation checks, diagrams, and practitioner documentation work together.

## Purpose

The prototype lets a practitioner test security-review methods locally before any runtime, cloud, MCP, or release layer is claimed. A user stages a DFD and supporting notes in a local run folder, uses governed instructions to read from `input_root`, writes structured outputs only under `output_root`, and compares against `expected_root` when baselines exist.

## Practical Value

The package is designed to test prompts, skills, adapters, DFD extraction, structured review outputs, validation, and handoff patterns locally. Later packages will add the artifacts needed to produce input inventories, visible objects, components, flows, boundaries, review tables, missing facts, AI Action Level, blueprint matches, questions, findings, recommendations, handoff packs, validation notes, and accuracy scores.

## Current State

This workspace currently contains **Build Package 01 foundation only**. It creates the governed shell, charter, manifest, folder contracts, build order, Root Area README placeholders, authoring-agent instruction standard, and Build Package 01 validation checklists.

Build Package 01 does not create diagrams, prompts, skills, PRA specifications, `.agent.md` adapters, catalogs, blueprints, templates beyond authoring-agent templates, samples, run outputs, DOCX/PDF/PPTX/ZIP artifacts, runtime code, schemas, cloud resources, MCP proof, or ADK proof.

Build Package numbers define the implementation sequence. Root Area numbers define visible package-tree rows and folder ownership. Root Area 01 is Root & Top-Level Files, followed by the 17 actual root folders.

## Reference Policy

The old package at `D:/E-Way 2/aisraf-sas-prototype-skill-chain-pack-v0.01` is reference-only. It may be read for intent, naming, lessons learned, and useful patterns. It must not be modified, and stale release artifacts, low-quality diagrams, failed outputs, run proof, and temporary reports must not be copied into this clean rebuild.

## Where To Start

1. Read [START-HERE.md](START-HERE.md).
2. Read [PROTOTYPE-CHARTER.md](PROTOTYPE-CHARTER.md).
3. Read [BUILD-ORDER.md](BUILD-ORDER.md).
4. Use [FOLDER-CONTRACTS.md](FOLDER-CONTRACTS.md) before writing anything in a later package.

## Build Order

The governed build sequence is recorded in [BUILD-ORDER.md](BUILD-ORDER.md). The next allowed Build Package after this foundation is **Build Package 02 — Config and run-profile variable model**.

## Not Yet Created

- No release artifacts yet.
- No diagrams yet.
- No run outputs yet.
- No runtime, cloud, MCP, Jira/Confluence post-back, or ADK proof yet.
