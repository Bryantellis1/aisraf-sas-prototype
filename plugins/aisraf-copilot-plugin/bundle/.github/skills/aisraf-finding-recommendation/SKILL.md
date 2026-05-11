---
name: aisraf-finding-recommendation
description: "Classify AISRAF findings, write evidence-bound recommendation previews, explain PRA-07, and map canonical finding/recommendation prompt and skills. Use when asked for findings, recommendations, parent finding traceability, role smoke, or skill wiring."
argument-hint: "[preview only | skill wiring | sample input/output]"
user-invocable: true
---

# AISRAF Finding Recommendation

This provider skill package is a thin Agent Skills projection. It is not the source of truth. Canonical authority remains in the AISRAF registries, PRAs, prompts, skills, templates, validation files, run profiles, and `tools/Test-*.ps1`.

## Purpose

Use this skill to explain or preview the AISRAF finding-and-recommendation role without writing files. It maps to the existing `.copilot-skills/aisraf-finding-recommendation.skill.md` projection and the owning AISRAF agent `AISRAF Finding Recommender`.

## Canonical References

- Owning agent: `AISRAF Finding Recommender`
- Canonical adapter: `.agents/aisraf-finding-recommender.agent.md`
- Copilot agent projection: `.github/agents/aisraf-finding-recommender.agent.md`
- Canonical PRA: `prototype-agents/PRA-07-FINDING-RECOMMENDER.md`
- Canonical prompt: `prompts/rs/10-finding-recommendation-write.prompt.md`
- Canonical skills: `skills/rs/SK-FINDING-CLASSIFY.md`, `skills/rs/SK-RECOMMENDATION-WRITE.md`
- Canonical templates: `templates/output/output-13-findings-template.md`, `templates/output/output-14-recommendations-template.md`
- Local wrapper projection: `.copilot-skills/aisraf-finding-recommendation.skill.md`
- Operator card: `.copilot-skills/aisraf-finding-recommendation.operator-card.md`

## Accepted Input

- Read-only upstream outputs such as `runs/{{run_id}}/09-missing-facts.md` through `runs/{{run_id}}/12-targeted-questions.md`.
- Read-only review-table and blueprint-match context.
- Operator prompts that explicitly say `preview only` or `write nothing`.

## Expected Chat-Preview Output

Return findings and recommendations output shapes by canonical template path. Recommendations must name parent-finding traceability. In preview, files written must be `none in preview`.

## Controlled Output

Controlled file output remains deferred until founder approval. If Mode B is later approved, approved output paths are `runs/{{run_id}}/13-findings.md` and `runs/{{run_id}}/14-recommendations.md`.

## Stop Conditions

- A finding is recorded without a supporting evidence row.
- A control, owner, or evidence reference is invented.
- A recommendation does not cite a parent finding.
- A write is attempted outside `{{output_root}}`.

## Prohibited Claims

Do not claim runtime, cloud, ADK, MCP, Jira, Confluence, Rovo, database, Terraform, external post-back, release, diagram, or autonomous execution. Unknown values stay unknown.