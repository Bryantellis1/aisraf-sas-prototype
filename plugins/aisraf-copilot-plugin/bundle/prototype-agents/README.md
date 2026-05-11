# prototype-agents/

Root Area: Root Area 08.

Owning Build Package: Build Package 06 — Prototype agents, PRA specs, and `.agent.md` adapter model.

## Purpose

Canonical Prototype Review Agent (PRA) specifications for AISRAF SAS Prototype v0.1.2. Each PRA groups Build Package 04 prompts and Build Package 05 skills into a role-oriented review responsibility. PRAs are specifications, not deployed runtime agents; they describe how the local VS Code/GitHub Copilot prototype is meant to operate when an operator runs the chain.

## What Belongs Here

Build Package 06 authorises the following content:

- [prototype-agent-registry.yaml](prototype-agent-registry.yaml) — registry indexing the 8 PRAs, the 7 adapters, and the prompt-skill-agent crosswalk.
- [prototype-agent-template.md](prototype-agent-template.md) — 13-section authoring template every PRA must follow.
- 8 canonical PRA specs:
  - [PRA-01-SAS-REVIEW-ORCHESTRATOR.md](PRA-01-SAS-REVIEW-ORCHESTRATOR.md)
  - [PRA-02-INPUT-READER.md](PRA-02-INPUT-READER.md)
  - [PRA-03-DFD-EXTRACTOR.md](PRA-03-DFD-EXTRACTOR.md)
  - [PRA-04-LEGEND-NORMALIZER.md](PRA-04-LEGEND-NORMALIZER.md)
  - [PRA-05-REVIEW-TABLE-BUILDER.md](PRA-05-REVIEW-TABLE-BUILDER.md)
  - [PRA-06-BLUEPRINT-QUESTIONER.md](PRA-06-BLUEPRINT-QUESTIONER.md)
  - [PRA-07-FINDING-RECOMMENDER.md](PRA-07-FINDING-RECOMMENDER.md)
  - [PRA-08-HANDOFF-QA-SCORER.md](PRA-08-HANDOFF-QA-SCORER.md)

## What Does Not Belong Here

- Deployed runtime agents.
- `.agent.md` adapter wrappers (those live under [.agents/](../.agents/)).
- Cloud, ADK, Vertex, or MCP integration code.
- Generated outputs, diagrams, release artefacts, or implementation proof.
- Edits to `prompts/` or `skills/` (those are frozen by their owning Build Packages).

## Variable Contract

PRA specs use only the seven authoritative run-profile variables defined by Build Package 02:

`{{run_id}}`, `{{input_root}}`, `{{expected_root}}`, `{{output_root}}`, `{{mode}}`, `{{postback_execution_status}}`, `{{output_destination_mode}}`.

Canonical artefact paths under `prompts/` and `skills/` are referenced as repository-relative literals.

## Adapter Relationship

Each `.agents/aisraf-*.agent.md` adapter is a thin wrapper that points to one or more PRA specs in this folder. PRA-04-LEGEND-NORMALIZER has no dedicated adapter; it is wrapped jointly with PRA-03-DFD-EXTRACTOR by [.agents/aisraf-dfd-extractor.agent.md](../.agents/aisraf-dfd-extractor.agent.md).

## Stop Conditions

- A PRA must not claim runtime, cloud, ADK, MCP, Jira post-back, Confluence publication, Rovo execution, database, or release execution.
- A PRA must not declare write paths outside `{{output_root}}`.
- A PRA must not require an artefact owned by a future Build Package as a hard read.
- A PRA must not modify prompts, skills, or baselines under `{{expected_root}}`.
