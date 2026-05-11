---
name: aisraf-blueprint-questioning
description: "Identify AISRAF missing facts, classify AI Action Level by evidence, match review blueprints by path, and generate targeted question previews. Use when asked for PRA-06, missing facts, blueprint matching, targeted questions, role smoke, or skill wiring."
argument-hint: "[preview only | skill wiring | sample input/output]"
user-invocable: true
---

# AISRAF Blueprint Questioning

This provider skill package is a thin Agent Skills projection. It is not the source of truth. Canonical authority remains in the AISRAF registries, PRAs, prompts, skills, templates, validation files, run profiles, and `tools/Test-*.ps1`.

## Purpose

Use this skill to explain or preview the AISRAF blueprint-questioning role without writing files. It maps to the existing `.copilot-skills/aisraf-blueprint-questioning.skill.md` projection and the owning AISRAF agent `AISRAF Blueprint Questioner`.

## Canonical References

- Owning agent: `AISRAF Blueprint Questioner`
- Canonical adapter: `.agents/aisraf-blueprint-questioner.agent.md`
- Copilot agent projection: `.github/agents/aisraf-blueprint-questioner.agent.md`
- Canonical PRA: `prototype-agents/PRA-06-BLUEPRINT-QUESTIONER.md`
- Canonical prompts: `prompts/rs/07-missing-fact-question-generate.prompt.md`, `prompts/rs/08-ai-action-level-classify.prompt.md`, `prompts/rs/09-blueprint-match.prompt.md`
- Canonical skills: `skills/rs/SK-MISSING-FACT-IDENTIFY.md`, `skills/rs/SK-AI-ACTION-LEVEL-CLASSIFY.md`, `skills/rs/SK-REVIEW-BLUEPRINT-MATCH.md`, `skills/rs/SK-TARGETED-QUESTION-GENERATE.md`
- Canonical templates: `templates/output/output-09-missing-facts-template.md`, `templates/output/output-10-ai-action-level-template.md`, `templates/output/output-11-blueprint-match-template.md`, `templates/output/output-12-targeted-questions-template.md`
- Local wrapper projection: `.copilot-skills/aisraf-blueprint-questioning.skill.md`
- Operator card: `.copilot-skills/aisraf-blueprint-questioning.operator-card.md`

## Accepted Input

- Read-only upstream outputs such as `runs/{{run_id}}/06-boundaries.md`, `runs/{{run_id}}/07-security-stack-assessment.md`, and `runs/{{run_id}}/08-internal-review-table.md`.
- Read-only catalog and blueprint references by path.
- Operator prompts that explicitly say `preview only` or `write nothing`.

## Expected Chat-Preview Output

Return missing-fact, AI Action Level, blueprint-match, and targeted-question output shapes by canonical template path. Use placeholders for catalog and blueprint values. In preview, files written must be `none in preview`.

## Controlled Output

Controlled file output remains deferred until founder approval. If Mode B is later approved, approved output paths are `runs/{{run_id}}/09-missing-facts.md`, `runs/{{run_id}}/10-ai-action-level.md`, `runs/{{run_id}}/11-blueprint-match.md`, and `runs/{{run_id}}/12-targeted-questions.md`.

## Stop Conditions

- A broad checklist question is generated.
- A question fails to name an output it would change.
- An unsupported action-level claim is made from a DFD label alone.
- A write is attempted outside `{{output_root}}`.

## Prohibited Claims

Do not claim runtime, cloud, ADK, MCP, Jira, Confluence, Rovo, database, Terraform, external post-back, release, diagram, or autonomous execution. Unknown values stay unknown.