---
name: aisraf-review-table-build
description: "Build AISRAF boundary, security-stack, and review-table previews, explain PRA-05, and map canonical review-table prompts and skills. Use when asked for boundary crossings, security-stack assessment, internal review table shape, role smoke, or skill wiring."
argument-hint: "[preview only | skill wiring | sample input/output]"
user-invocable: true
---

# AISRAF Review Table Build

This provider skill package is a thin Agent Skills projection. It is not the source of truth. Canonical authority remains in the AISRAF registries, PRAs, prompts, skills, templates, validation files, run profiles, and `tools/Test-*.ps1`.

## Purpose

Use this skill to explain or preview the AISRAF review-table role without writing files. It maps to the existing `.copilot-skills/aisraf-review-table-build.skill.md` projection and the owning AISRAF agent `AISRAF Review Table Builder`.

## Canonical References

- Owning agent: `AISRAF Review Table Builder`
- Canonical adapter: `.agents/aisraf-review-table-builder.agent.md`
- Copilot agent projection: `.github/agents/aisraf-review-table-builder.agent.md`
- Canonical PRA: `prototype-agents/PRA-05-REVIEW-TABLE-BUILDER.md`
- Canonical prompts: `prompts/rs/05-boundary-stack-detect.prompt.md`, `prompts/rs/06-review-table-build.prompt.md`
- Canonical skills: `skills/rs/SK-BOUNDARY-CROSSING-DETECT.md`, `skills/rs/SK-SECURITY-STACK-ASSESS.md`, `skills/rs/SK-DATA-FLOW-TABLE-BUILD.md`
- Canonical templates: `templates/output/output-06-boundaries-template.md`, `templates/output/output-07-security-stack-assessment-template.md`, `templates/output/output-08-internal-review-table-template.md`
- Local wrapper projection: `.copilot-skills/aisraf-review-table-build.skill.md`
- Operator card: `.copilot-skills/aisraf-review-table-build.operator-card.md`

## Accepted Input

- Read-only upstream DFD extraction outputs under `runs/{{run_id}}/` and `runs/{{run_id}}/dfd/`.
- Read-only catalog references by path.
- Operator prompts that explicitly say `preview only` or `write nothing`.

## Expected Chat-Preview Output

Return the upstream outputs read, boundary/review-table output shapes, material unknowns, and evidence limits. In preview, files written must be `none in preview`.

## Controlled Output

Controlled file output remains deferred until founder approval. If Mode B is later approved, approved output paths are `runs/{{run_id}}/06-boundaries.md`, `runs/{{run_id}}/07-security-stack-assessment.md`, and `runs/{{run_id}}/08-internal-review-table.md`.

## Stop Conditions

- A material boundary is missed.
- Controls are claimed from a boundary label alone.
- Security-stack visibility is invented.
- A write is attempted outside `{{output_root}}`.

## Prohibited Claims

Do not claim runtime, cloud, ADK, MCP, Jira, Confluence, Rovo, database, Terraform, external post-back, release, diagram, or autonomous execution. Unknown values stay unknown.