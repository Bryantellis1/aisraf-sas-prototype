---
name: aisraf-input-read
description: "Inventory AISRAF input packages, explain PRA-02, map the canonical input-read prompt and skill, and preview 01-input-inventory without writing. Use when asked for AISRAF input reading, sample input preview, role smoke, or skill wiring."
argument-hint: "[preview only | skill wiring | sample input/output]"
user-invocable: true
---

# AISRAF Input Read

This provider skill package is a thin Agent Skills projection. It is not the source of truth. Canonical authority remains in the AISRAF registries, PRAs, prompts, skills, templates, validation files, run profiles, and `tools/Test-*.ps1`.

## Purpose

Use this skill to explain or preview the AISRAF input inventory role without writing files. It maps to the existing `.copilot-skills/aisraf-input-read.skill.md` projection and the owning AISRAF agent `AISRAF Input Reader`.

## Canonical References

- Owning agent: `AISRAF Input Reader`
- Canonical adapter: `.agents/aisraf-input-reader.agent.md`
- Copilot agent projection: `.github/agents/aisraf-input-reader.agent.md`
- Canonical PRA: `prototype-agents/PRA-02-INPUT-READER.md`
- Canonical prompt: `prompts/rs/01-input-package-read.prompt.md`
- Canonical skill: `skills/rs/SK-INPUT-PACKAGE-READ.md`
- Canonical template: `templates/output/output-01-input-inventory-template.md`
- Local wrapper projection: `.copilot-skills/aisraf-input-read.skill.md`
- Operator card: `.copilot-skills/aisraf-input-read.operator-card.md`

## Accepted Input

- Read-only input roots such as `runs/RUN-001/inputs/` or `samples/sample-001-dfd-crop/inputs/`.
- Read-only run profile context such as `runs/RUN-001/run-profile.yaml`.
- Operator prompts that explicitly say `preview only` or `write nothing`.

## Expected Chat-Preview Output

Return inputs read, inputs ignored, why those inputs matter, expected unknowns, files written, and stop conditions for input reading. In preview, files written must be `none in preview`.

## Controlled Output

Controlled file output remains deferred until founder approval. If Mode B is later approved, the only approved output path for this role is `runs/{{run_id}}/01-input-inventory.md`.

## Stop Conditions

- `{{input_root}}` cannot be resolved or read.
- An invented input is recorded as received.
- The inventory claims automatic chat-attachment movement.
- A write is attempted outside `{{output_root}}`.

## Prohibited Claims

Do not claim runtime, cloud, ADK, MCP, Jira, Confluence, Rovo, database, Terraform, external post-back, release, diagram, or autonomous execution. Unknown values stay unknown.