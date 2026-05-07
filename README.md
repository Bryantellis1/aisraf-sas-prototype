# AISRAF SAS Prototype v0.1.2

AISRAF SAS means AISRAF Security Advisory Services. This package is a local-first security advisory review prototype for testing how VS Code, GitHub Copilot, prompt cards, skill contracts, PRA specifications, local adapter wrappers, catalogs, blueprints, templates, samples, run profiles, validation checks, diagrams, and practitioner documentation work together.

## Purpose

The prototype lets a practitioner test security-review methods locally before any runtime, cloud, MCP, or release layer is claimed. A user stages a DFD and supporting notes in a local run folder, uses governed instructions to read from `input_root`, writes structured outputs only under `output_root`, and compares against `expected_root` when baselines exist.

## Practical Value

The package is designed to test prompts, skills, adapters, DFD extraction, structured review outputs, validation, and handoff patterns locally. Later packages will add the artifacts needed to produce input inventories, visible objects, components, flows, boundaries, review tables, missing facts, AI Action Level, blueprint matches, questions, findings, recommendations, handoff packs, validation notes, and accuracy scores.

## Current State

Build Packages 01–10 are active (Build Package 10 is the most recent, pending human review before commit):

- **Build Package 01** — Foundation, root structure, charter, manifest, folder contracts, build order, and authoring-agent instruction standard.
- **Build Package 02** — Config and run-profile variable model (`config/`).
- **Build Package 03** — Tools and setup/test/export scripts (`tools/`).
- **Build Package 04** — Prompts and prompt registry (`prompts/`): 23 canonical prompt cards (14 RS, 9 DFD) plus [prompts/prompt-registry.yaml](prompts/prompt-registry.yaml).
- **Build Package 05** — Skills and skill registry (`skills/`): 26 canonical skill contracts (17 RS, 9 DFD) plus [skills/skill-registry.yaml](skills/skill-registry.yaml). Each skill contract wraps one Build Package 04 prompt card with a 14-section reusable work contract.
- **Build Package 06** — Prototype agents, PRA specs, and `.agent.md` adapter model (`prototype-agents/`, `.agents/`): 8 canonical Prototype Review Agent specs (PRA-01..PRA-08) plus [prototype-agents/prototype-agent-registry.yaml](prototype-agents/prototype-agent-registry.yaml), and 7 thin local `.agent.md` adapter wrappers under [.agents/](.agents/) (orchestrator, input-reader, dfd-extractor, review-table-builder, blueprint-questioner, finding-recommender, handoff-qa-scorer). PRA-04-LEGEND-NORMALIZER has no dedicated adapter; it is wrapped jointly with PRA-03 by [.agents/aisraf-dfd-extractor.agent.md](.agents/aisraf-dfd-extractor.agent.md). PRAs and adapters are specifications/wrappers, not deployed runtime agents.
- **Build Package 07** — Catalogs (`catalogs/`): 24 controlled-vocabulary YAML catalogs across 7 families (components, interactions, boundaries, identity-access, data-protection, security-stacks, review) plus [catalogs/catalog-registry.yaml](catalogs/catalog-registry.yaml) and 8 READMEs. Two catalogs are cross-cutting: [catalogs/security-stacks/proof-vs-signal-rule-catalog.yaml](catalogs/security-stacks/proof-vs-signal-rule-catalog.yaml) (`global_rule: true`) and [catalogs/data-protection/confidence-level-catalog.yaml](catalogs/data-protection/confidence-level-catalog.yaml) (`cross_cutting_catalog: true`). Catalogs are read-only at runtime; they are not executable tools, runtime services, blueprints, prompts, skills, agent logic, or runbooks. Build Package 07 did not modify any prompt, skill, prototype-agent, or adapter registry.
- **Build Package 08** — Blueprints (`blueprints/`): 9 controlled YAML blueprints split across two category folders (8 under [blueprints/platform-independent/](blueprints/platform-independent/) and 1 under [blueprints/cloud-patterns/](blueprints/cloud-patterns/)) plus [blueprints/blueprint-registry.yaml](blueprints/blueprint-registry.yaml), [blueprints/blueprint-template.yaml](blueprints/blueprint-template.yaml), and 3 READMEs (14 files total). Match states are fixed at four values: `matched`, `candidate`, `no_match`, `unknown`. Each blueprint references Build Package 07 catalog identifiers only; no new catalog values are introduced. Blueprints scope catalog evidence and surface material missing facts; selection of severity, AI Action Level, finding categories, recommendation types, and final disposition is owned by the consuming Build Package 05 skills and human review. Build Package 08 did not modify any prompt, skill, prototype-agent, adapter, or catalog registry.
- **Build Package 09** — Templates (`templates/`): 31 reusable Markdown output-shape templates across 4 family folders (27 under [templates/output/](templates/output/), 1 under [templates/jira/](templates/jira/), 1 under [templates/confluence/](templates/confluence/), 2 under [templates/run/](templates/run/)) plus [templates/template-registry.yaml](templates/template-registry.yaml) and 5 READMEs (37 files total). Templates define output shape only; they do not execute the review, do not compute severity / score / AI Action Level / blueprint match, do not invent finding facts or recommendation prose, and do not claim Jira / Confluence / Rovo / MCP / runtime / cloud / ADK / database / Terraform execution. Templates use only the seven approved run-profile placeholder variables; other run-profile fields are referenced descriptively as `[copy from runs/{{run_id}}/run-profile.yaml#field_name]`. Catalog values are referenced via `<value-from-catalogs/...>` placeholder syntax (no enumeration inside template bodies; founder decision Q3). Build Package 09 did not modify any prompt, skill, prototype-agent, adapter, catalog, or blueprint registry; template→prompt, template→skill, template→PRA, template→adapter, template→blueprint, and template→catalog consumer maps are recorded only in [templates/template-registry.yaml](templates/template-registry.yaml) and the validation checklists.
- **Build Package 10** — Samples and expected baselines (`samples/`): 1 active sample (`sample-001-dfd-crop` — AI SaaS Security Review Portal scenario) plus [samples/sample-registry.yaml](samples/sample-registry.yaml). Sample-001 carries 6 synthetic inputs (`inputs/dfd-crop.png`, `inputs/dfd-crop.mmd`, `inputs/dfd-legend-excerpt.md`, `inputs/cloud-triage-notes.md`, `inputs/review-transcript.md`, `inputs/intake-ticket.md`) and 26 Markdown expected baselines (17 RS mirroring `templates/output/output-01..17-*-template.md` and 9 DFD mirroring `templates/output/output-dfd-01..09-*-template.md`). `expected-00-run-log.md` is intentionally not created (founder decision Q2: run logs are run artefacts deferred to Build Package 11). Samples 002–008 are recorded as `planned_or_deferred_samples` entries inside [samples/sample-registry.yaml](samples/sample-registry.yaml) only — no folders or files (founder decision Q8). Samples are test fixtures: synthetic only, no real PII / PAN / SSN / PHI / secrets / credentials / production endpoints; no Jira post-back / Confluence publication / Rovo / MCP / runtime / cloud / ADK / Vertex / GCP / database / Terraform execution claims; no severity / finding-category / AI Action Level / blueprint-match / accuracy-score computation inside expected-baseline bodies; no new BP-* identifiers or controlled values introduced. Numeric scoring is qualitative (`PASS_READY_FOR_REVIEW`) until Build Package 11 run execution validates numeric scoring (founder decision Q5; the v0.01 reference 151/160 is recorded as `legacy_reference_score` only). Build Package 10 did not modify any prompt, skill, prototype-agent, adapter, catalog, blueprint, template, or config registry.

These ten packages do not create live runs, diagrams, docs/runbooks, DOCX/PDF/PPTX/ZIP artifacts, runtime code, schemas outside `config/`, cloud resources, MCP proof, or ADK proof.

Build Package numbers define the implementation sequence. Root Area numbers define visible package-tree rows and folder ownership. Root Area 01 is Root & Top-Level Files, followed by the 17 actual root folders.

## Reference Policy

The old package at `D:/E-Way 2/aisraf-sas-prototype-skill-chain-pack-v0.01` is reference-only. It may be read for intent, naming, lessons learned, and useful patterns. It must not be modified, and stale release artifacts, low-quality diagrams, failed outputs, run proof, and temporary reports must not be copied into this clean rebuild.

## Where To Start

1. Read [START-HERE.md](START-HERE.md).
2. Read [PROTOTYPE-CHARTER.md](PROTOTYPE-CHARTER.md).
3. Read [BUILD-ORDER.md](BUILD-ORDER.md).
4. Use [FOLDER-CONTRACTS.md](FOLDER-CONTRACTS.md) before writing anything in a later package.

## Build Order

The governed build sequence is recorded in [BUILD-ORDER.md](BUILD-ORDER.md). The next allowed Build Package after Build Package 10 is **Build Package 11 — Runs and execution evidence model**.

## Not Yet Created

- No release artifacts yet.
- No diagrams yet.
- No live run outputs yet (samples are test fixtures, not runs).
- No runtime, cloud, MCP, Jira/Confluence post-back, or ADK proof yet.
