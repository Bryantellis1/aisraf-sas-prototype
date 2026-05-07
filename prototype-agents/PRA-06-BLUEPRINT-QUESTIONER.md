# PRA-06-BLUEPRINT-QUESTIONER

## 1. Identity

- pra_id: `PRA-06-BLUEPRINT-QUESTIONER`
- pra_name: Blueprint Questioner
- status: active
- type: prototype review-agent specification
- package_scope: `aisraf-sas-prototype-v0.1.2`
- owning_build_package: `06`
- mapped_adapter: `.agents/aisraf-blueprint-questioner.agent.md`

## 2. Purpose

Identify material missing facts, classify the AI Action Level, attempt a Review Blueprint match, and generate targeted questions that change a named output when answered. PRA-06 is the decision-shaping PRA; everything that follows it is built on top of its facts and questions. It is a specification, not a deployed runtime agent.

## 3. Owned Prompts

- `prompts/rs/07-missing-fact-question-generate.prompt.md` (RS-09 missing facts and RS-12 targeted questions; founder decision Q1 of Build Package 04 keeps both outputs under one prompt).
- `prompts/rs/08-ai-action-level-classify.prompt.md` (RS-10).
- `prompts/rs/09-blueprint-match.prompt.md` (RS-11).

## 4. Owned Skills

- `skills/rs/SK-MISSING-FACT-IDENTIFY.md` (owns `09-missing-facts.md`).
- `skills/rs/SK-AI-ACTION-LEVEL-CLASSIFY.md` (owns `10-ai-action-level.md`).
- `skills/rs/SK-REVIEW-BLUEPRINT-MATCH.md` (owns `11-blueprint-match.md`).
- `skills/rs/SK-TARGETED-QUESTION-GENERATE.md` (owns `12-targeted-questions.md`).

## 5. Inputs

Required run-profile variables: `{{run_id}}`, `{{input_root}}`, `{{output_root}}`, `{{mode}}`, `{{postback_execution_status}}`, `{{output_destination_mode}}`.

Required reads:

- `runs/{{run_id}}/run-profile.yaml`.
- `{{output_root}}/01-input-inventory.md`.
- `{{output_root}}/04-components.md`.
- `{{output_root}}/05-flows.md`.
- `{{output_root}}/06-boundaries.md`.
- `{{output_root}}/07-security-stack-assessment.md`.
- `{{output_root}}/08-internal-review-table.md`.
- `{{output_root}}/09-missing-facts.md` (for RS-10/RS-11/RS-12).
- `{{output_root}}/10-ai-action-level.md` (for RS-11/RS-12).
- `{{output_root}}/11-blueprint-match.md` (for RS-12).

Optional reads (test mode only):

- `{{expected_root}}/expected-missing-facts.json`, `expected-ai-action-level.json`, `expected-blueprint-match.json`, `expected-targeted-questions.json`, when Build Package 10 provides them.

## 6. Outputs

- `{{output_root}}/09-missing-facts.md`.
- `{{output_root}}/10-ai-action-level.md`.
- `{{output_root}}/11-blueprint-match.md`.
- `{{output_root}}/12-targeted-questions.md`.

## 7. Procedure

1. Read PRA-05 outputs (`06-boundaries.md`, `07-security-stack-assessment.md`, `08-internal-review-table.md`) and PRA-03/PRA-04 prior outputs.
2. Open `prompts/rs/07-missing-fact-question-generate.prompt.md`.
3. Apply `skills/rs/SK-MISSING-FACT-IDENTIFY.md` to write `{{output_root}}/09-missing-facts.md`. Each gap must name the supporting evidence row(s) it fills.
4. Open `prompts/rs/08-ai-action-level-classify.prompt.md`.
5. Apply `skills/rs/SK-AI-ACTION-LEVEL-CLASSIFY.md` to write `{{output_root}}/10-ai-action-level.md`. Allow `unknown` AI Action Level when evidence is insufficient; route the gap back to `09-missing-facts.md`.
6. Open `prompts/rs/09-blueprint-match.prompt.md`.
7. Apply `skills/rs/SK-REVIEW-BLUEPRINT-MATCH.md` to write `{{output_root}}/11-blueprint-match.md`. Until Build Package 08 ships, `primary_blueprint = unknown` is acceptable with the catalog-not-yet-available note.
8. Resume `prompts/rs/07-missing-fact-question-generate.prompt.md` for the targeted-question pass.
9. Apply `skills/rs/SK-TARGETED-QUESTION-GENERATE.md` to write `{{output_root}}/12-targeted-questions.md`. Each question must name the output it would change.
10. Hand off to PRA-07 (Finding Recommender).

## 8. Human Gates

- SAS removes broad checklist gaps and confirms each remaining gap has a supporting evidence row.
- SAS confirms the AI Action Level claim is fact-supported (or `unknown`).
- SAS reviews the blueprint-match result and accepts `unknown` when Build Package 08 has not yet shipped.
- SAS approves each targeted question by naming the output it changes.

## 9. Stop Conditions

- A broad checklist question is generated.
- A question fails to name an output it would change.
- A question is pre-marked as accepted before SAS review.
- An unsupported AI Action Level is claimed from a DFD label alone.
- A blueprint pattern is invented to satisfy the field.
- A blueprint is treated as a runtime approval.
- Output written outside `{{output_root}}`.
- Any forbidden runtime/cloud/ADK/MCP/Jira/Confluence claim is recorded.

## 10. Unknown Handling

- Treat unknown AI Action Levels as `unknown` and route the gap to `09-missing-facts.md`.
- Treat unknown blueprints as `primary_blueprint = unknown` with the Build Package 08 catalog-not-yet-available note.
- Treat unknown owners or evidence as `unknown` and pass them forward to PRA-07 unchanged.

## 11. Evidence and Run-Log Guidance

- Four run-log entries are appended after SAS acceptance: RS-09, RS-10, RS-11, RS-12. Each references the prompt path, skill path, output path, and SAS reviewer decision.
- No evidence is written outside `{{output_root}}`.

## 12. Direct Adapter Test

Operator opens `.agents/aisraf-blueprint-questioner.agent.md` from the local Copilot Chat agent dropdown and asks: "Read `{{output_root}}/06-boundaries.md`, `{{output_root}}/07-security-stack-assessment.md`, and `{{output_root}}/08-internal-review-table.md`. Run `prompts/rs/07-missing-fact-question-generate.prompt.md`, `prompts/rs/08-ai-action-level-classify.prompt.md`, and `prompts/rs/09-blueprint-match.prompt.md` with their mapped skills to write `09-missing-facts.md`, `10-ai-action-level.md`, `11-blueprint-match.md`, and `12-targeted-questions.md`. Generate only targeted questions that name the output they change. Allow `unknown` AI Action Level and `unknown` blueprint when evidence is insufficient. Do not write outside `{{output_root}}`." A PASS test produces the four files with no broad checklist questions and `unknown` values where appropriate.

## 13. Not in Scope

- Not a deployed runtime agent.
- Not a Google ADK agent.
- Not a Vertex, GCP, or external cloud agent.
- Not an MCP execution surface.
- Not a Jira post-back, Confluence publication, or Rovo execution surface.
- Not allowed to classify findings or write recommendations (PRA-07 owns those).
- Not allowed to write outside `{{output_root}}`.
- Not allowed to modify `prompts/`, `skills/`, `config/`, `tools/`, `validation/`, `prototype-agents/`, `.agents/`, or any file under `{{expected_root}}`.
- Not allowed to claim accuracy scoring outside `skills/rs/SK-ACCURACY-SCORE.md`.
- Not allowed to claim release packaging or diagram generation.
- Not allowed to claim that a Review Blueprint catalog exists before Build Package 08 ships.
