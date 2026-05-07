# PRA Specification Template

Package: AISRAF SAS Prototype v0.1.2

Owning Build Package: Build Package 06 — Prototype agents, PRA specs, and `.agent.md` adapter model.

Use this template to author every `prototype-agents/PRA-NN-NAME.md` file. A PRA specification is a Prototype Review Agent description. It is not a deployed runtime agent. It is not a Google ADK implementation. It is not an external system integration. It does not write outside the resolved `{{output_root}}` of the current run. It does not claim Jira post-back, Confluence publication, Rovo execution, MCP execution, runtime, cloud, database, Terraform, or release execution.

Every PRA specification must include the 13 sections below and use only the seven authoritative run-profile variables defined by Build Package 02 (`{{run_id}}`, `{{input_root}}`, `{{expected_root}}`, `{{output_root}}`, `{{mode}}`, `{{postback_execution_status}}`, `{{output_destination_mode}}`). Canonical artefact paths are referenced as repository-relative literals (for example `prompts/rs/01-input-package-read.prompt.md`, `skills/rs/SK-INPUT-PACKAGE-READ.md`).

## 1. Identity

- pra_id: `PRA-NN-NAME`
- pra_name: Human-readable display name
- status: `active` | `draft`
- type: prototype review-agent specification
- package_scope: `aisraf-sas-prototype-v0.1.2`
- owning_build_package: `06`

## 2. Purpose

One short paragraph describing why this PRA exists and what role it plays in the local prototype review chain. State explicitly that the PRA is a specification, not a deployed runtime agent.

## 3. Owned Prompts

Bullet list of every Build Package 04 prompt this PRA owns, by canonical path under `prompts/`.

## 4. Owned Skills

Bullet list of every Build Package 05 skill this PRA owns, by canonical path under `skills/`. Use `none` and a short note if the PRA coordinates only.

## 5. Inputs

- Required run-profile variables.
- Required prior outputs under `{{output_root}}` (use the canonical RS-step file names).
- Required reads from `{{input_root}}` if any.
- Optional reads from `{{expected_root}}` only when scored test mode is permitted by the prompt and skill contracts.

## 6. Outputs

- Every artifact this PRA causes the operator to write under `{{output_root}}`, by canonical RS-step file name.
- A single PRA may produce multiple outputs across its owned prompts.

## 7. Procedure

Numbered step list describing the order in which the operator opens the owned prompts, runs the owned skills, and reaches the human review gates. Procedure steps reference canonical artefact paths only — they do not embed prompt or skill bodies.

## 8. Human Gates

- Which SAS reviewer decisions must occur.
- Which output(s) remain draft until accepted.
- Which decisions cannot be auto-approved.

## 9. Stop Conditions

- Unresolved run-profile variables.
- Output outside `{{output_root}}`.
- Critical miss recorded by an owned skill.
- Forbidden claim: runtime, cloud, database, ADK, MCP, Jira post-back, Confluence publication, Rovo execution, release export, diagram generation, accuracy scoring outside `SK-ACCURACY-SCORE`.
- Mixing of design-review closeout content with Separate Validation Ticket evidence.

## 10. Unknown Handling

- Treat unknown legends, unknown controls, unknown owners, unknown evidence, and unknown blueprints as `unknown`. Do not invent values to satisfy a field.
- Record unknowns as material gaps that route through PRA-06's missing-fact and targeted-question chain when applicable.

## 11. Evidence and Run-Log Guidance

- Every owned RS-step writes a run-log entry under `{{output_root}}/00-run-log.md` after SAS acceptance.
- Run-log entries record the prompt and skill reference, the file written, and the SAS reviewer decision.
- A PRA never produces evidence outside `{{output_root}}`.

## 12. Direct Adapter Test

Describe how an operator tests this PRA through its mapped `.agents/*.agent.md` adapter (or, when no dedicated adapter exists, through the adapter that wraps it). The test prompt is short, uses only the seven authoritative run-profile variables, and expects no runtime/cloud/MCP behavior.

## 13. Not in Scope

State explicitly:

- Not a deployed runtime agent.
- Not a Google ADK agent.
- Not a Google Cloud, Vertex, or external runtime integration.
- Not an MCP execution surface.
- Not a Jira post-back, Confluence publication, or Rovo execution surface.
- Not allowed to write outside `{{output_root}}`.
- Not allowed to modify `prompts/`, `skills/`, `prototype-agents/`, `config/`, `tools/`, `validation/`, or any file under `{{expected_root}}`.
- Not allowed to claim accuracy scoring outside `SK-ACCURACY-SCORE`.
- Not allowed to claim release packaging or diagram generation.
