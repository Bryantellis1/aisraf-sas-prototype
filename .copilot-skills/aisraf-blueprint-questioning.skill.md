---
name: aisraf-blueprint-questioning
description: "Use when: identifying AISRAF missing facts, classifying AI Action Level, matching review blueprints, or generating targeted questions."
user-invocable: true
---

# AISRAF Blueprint Questioning Skill Wrapper

## Role Explanation

This is a thin BP12C projection of `AISRAF Blueprint Questioner`. It uses `PRA-06-BLUEPRINT-QUESTIONER` to identify material missing facts, classify AI Action Level from evidence, match a Review Blueprint when supported, and generate targeted questions.

## Canonical References

- Adapter: `.agents/aisraf-blueprint-questioner.agent.md`
- PRA: `prototype-agents/PRA-06-BLUEPRINT-QUESTIONER.md`
- Prompts: `prompts/rs/07-missing-fact-question-generate.prompt.md`, `prompts/rs/08-ai-action-level-classify.prompt.md`, `prompts/rs/09-blueprint-match.prompt.md`
- Skills: `skills/rs/SK-MISSING-FACT-IDENTIFY.md`, `skills/rs/SK-AI-ACTION-LEVEL-CLASSIFY.md`, `skills/rs/SK-REVIEW-BLUEPRINT-MATCH.md`, `skills/rs/SK-TARGETED-QUESTION-GENERATE.md`
- Templates: `templates/output/output-09-missing-facts-template.md`, `templates/output/output-10-ai-action-level-template.md`, `templates/output/output-11-blueprint-match-template.md`, `templates/output/output-12-targeted-questions-template.md`

## Allowed Writes

- `runs/{{run_id}}/09-missing-facts.md`
- `runs/{{run_id}}/10-ai-action-level.md`
- `runs/{{run_id}}/11-blueprint-match.md`
- `runs/{{run_id}}/12-targeted-questions.md`

## Output Guide

- `runs/{{run_id}}/09-missing-facts.md`
  - What: Material missing facts tied to evidence.
  - Why: Names what blocks confident review conclusions.
  - How: Use `prompts/rs/07-missing-fact-question-generate.prompt.md` with `skills/rs/SK-MISSING-FACT-IDENTIFY.md`.
- `runs/{{run_id}}/10-ai-action-level.md`
  - What: AI Action Level classification record.
  - Why: Captures the supported action-level decision or keeps it unresolved.
  - How: Use `prompts/rs/08-ai-action-level-classify.prompt.md` with `skills/rs/SK-AI-ACTION-LEVEL-CLASSIFY.md`.
- `runs/{{run_id}}/11-blueprint-match.md`
  - What: Review Blueprint match record using blueprint registry references.
  - Why: Records the supported review pattern without treating it as approval.
  - How: Use `prompts/rs/09-blueprint-match.prompt.md` with `skills/rs/SK-REVIEW-BLUEPRINT-MATCH.md`.
- `runs/{{run_id}}/12-targeted-questions.md`
  - What: Targeted questions that name the output they would change.
  - Why: Routes missing facts without broad checklist sprawl.
  - How: Use `prompts/rs/07-missing-fact-question-generate.prompt.md` with `skills/rs/SK-TARGETED-QUESTION-GENERATE.md`.

## Unknown Handling

Carry `unknown` through `IA?`, `SA?`, `CA?`, `AZ?`, `R?`, `L?`, and `match=unknown`. Do not invent values to clear a field.

## Stop Conditions

- A broad checklist question is generated.
- A question fails to name an output it would change.
- A question is pre-marked as accepted before SAS review.
- An unsupported AI Action Level claim is made from a DFD label alone.
- A blueprint pattern is invented.
- A blueprint match is treated as runtime approval.
- A write is attempted outside `{{output_root}}`.
- Any claim of runtime, cloud, ADK, MCP, Jira, Confluence, Rovo, database, or release execution.

## Role Smoke Response

With no input, explain this role, show the allowed write paths, cite the stop conditions, and refuse to write.

## Chat Preview Response

For preview-only mode, render the referenced template section shapes in chat with catalog and blueprint placeholders only, then write nothing.

## Prohibited Claims

Do not claim runtime, cloud, ADK, MCP, Jira, Confluence, Rovo, database, Terraform, external post-back, release, diagram, or autonomous execution.
