# .agents/

Root Area: Root Area 03.

Owning Build Package: Build Package 06 — Prototype agents, PRA specs, and `.agent.md` adapter model.

## Purpose

Local VS Code/GitHub Copilot adapter wrappers for AISRAF SAS Prototype v0.1.2. Each `.agent.md` file is a thin wrapper that points to canonical PRA specs (under [prototype-agents/](../prototype-agents/)), prompt cards (under [prompts/](../prompts/)), and skill contracts (under [skills/](../skills/)). Adapters are not deployed runtime agents; they appear only as entries in the local Copilot Chat agent dropdown when this workspace is open.

## Adapter Inventory (7)

- [aisraf-orchestrator.agent.md](aisraf-orchestrator.agent.md) — wraps `PRA-01-SAS-REVIEW-ORCHESTRATOR`.
- [aisraf-input-reader.agent.md](aisraf-input-reader.agent.md) — wraps `PRA-02-INPUT-READER`.
- [aisraf-dfd-extractor.agent.md](aisraf-dfd-extractor.agent.md) — wraps `PRA-03-DFD-EXTRACTOR` and `PRA-04-LEGEND-NORMALIZER` jointly (founder decision Q1; PRA-04 has no dedicated adapter).
- [aisraf-review-table-builder.agent.md](aisraf-review-table-builder.agent.md) — wraps `PRA-05-REVIEW-TABLE-BUILDER`.
- [aisraf-blueprint-questioner.agent.md](aisraf-blueprint-questioner.agent.md) — wraps `PRA-06-BLUEPRINT-QUESTIONER`.
- [aisraf-finding-recommender.agent.md](aisraf-finding-recommender.agent.md) — wraps `PRA-07-FINDING-RECOMMENDER`.
- [aisraf-handoff-qa-scorer.agent.md](aisraf-handoff-qa-scorer.agent.md) — wraps `PRA-08-HANDOFF-QA-SCORER`.

The adapter count is fixed at 7 in v0.1.2. Adding an eighth adapter requires a Build Package contract change.

## Adapter Contract

Every adapter file is a thin wrapper. It must:

- Carry YAML frontmatter with `name`, `description`, `tools: [read, search, edit]`, `user-invocable: true`, and `handoffs`.
- Reference its canonical PRA spec by repository-relative path.
- Reference each prompt card it relies on by repository-relative path under `prompts/`.
- Reference each skill contract it relies on by repository-relative path under `skills/`.
- Use only the seven authoritative run-profile variables: `{{run_id}}`, `{{input_root}}`, `{{expected_root}}`, `{{output_root}}`, `{{mode}}`, `{{postback_execution_status}}`, `{{output_destination_mode}}`.
- Declare an Allowed Writes section that resolves under `{{output_root}}` only.
- Declare a Prohibited Writes section that names every other folder explicitly.
- Provide a short Operator Test Prompt the operator can paste verbatim.
- Declare Stop Conditions and Not in Scope sections.

Every adapter file must NOT:

- Duplicate the full body of any prompt card or skill contract. Adapters point to canonical artefacts only.
- Pin a specific Copilot Chat model.
- Declare any tool other than `read`, `search`, and `edit`.
- Claim runtime, cloud, ADK, MCP, Jira post-back, Confluence publication, Rovo execution, database, Terraform, or release execution.
- Invent run-profile variables outside the seven authoritative ones.
- Modify `prompts/`, `skills/`, `prompts/prompt-registry.yaml`, `skills/skill-registry.yaml`, or any file under `{{expected_root}}`.

## Test The Adapter Surface

1. Open this workspace in VS Code.
2. Open Copilot Chat and verify the seven adapters appear in the agent dropdown by their `name`.
3. Pick one adapter, paste the Operator Test Prompt from the adapter file, and confirm Copilot reads only the canonical references and writes only under `{{output_root}}`.

## Stop Conditions

- An adapter referencing a missing PRA, prompt, or skill path.
- An adapter declaring a write outside `{{output_root}}`.
- An adapter pinning a Copilot model.
- An adapter declaring a tool outside `read`, `search`, or `edit`.
- An adapter duplicating a full prompt or skill body.
- An adapter claiming runtime, cloud, ADK, MCP, Jira, Confluence, Rovo, database, or release execution.
- An adapter modifying frozen Build Package 04/05 artefacts.
