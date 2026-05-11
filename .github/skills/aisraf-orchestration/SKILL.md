---
name: aisraf-orchestration
description: "Coordinate AISRAF SAS local review orchestration, explain PRA-01, map the canonical run-log prompt and template, and preview or guard controlled output. Use when asked for AISRAF orchestration, run profiles, run logs, role smoke, or skill wiring."
argument-hint: "[preview only | skill wiring | sample input/output]"
user-invocable: true
---

# AISRAF Orchestration

This provider skill package is a thin Agent Skills projection. It is not the source of truth. Canonical authority remains in the AISRAF registries, PRAs, prompts, skills, templates, validation files, run profiles, and `tools/Test-*.ps1`.

## Purpose

Use this skill to explain or preview the AISRAF orchestration role without writing files. It maps to the existing `.copilot-skills/aisraf-orchestration.skill.md` projection and the owning AISRAF agent `AISRAF Orchestrator`.

## Canonical References

- Owning agent: `AISRAF Orchestrator`
- Canonical adapter: `.agents/aisraf-orchestrator.agent.md`
- Copilot agent projection: `.github/agents/aisraf-orchestrator.agent.md`
- Canonical PRA: `prototype-agents/PRA-01-SAS-REVIEW-ORCHESTRATOR.md`
- Canonical prompt: `prompts/rs/00-run-full-chain.prompt.md`
- Canonical skill: owns no skill
- Canonical template: `templates/output/output-00-run-log-template.md`
- Local wrapper projection: `.copilot-skills/aisraf-orchestration.skill.md`
- Operator card: `.copilot-skills/aisraf-orchestration.operator-card.md`

## Accepted Input

- Read-only run profile context such as `runs/RUN-001/run-profile.yaml`.
- Read-only references to downstream AISRAF output paths under `runs/{{run_id}}/`.
- Operator prompts that explicitly say `preview only` or `write nothing`.

## Expected Chat-Preview Output

Return the role identity, inputs read, theoretical writes, stop conditions, expected output shape, and prohibited claims. When showing output shape, reference `templates/output/output-00-run-log-template.md` by path and render only headings or one-line shape hints.

## Controlled Output

Controlled file output remains deferred until founder approval. If Mode B is later approved, the only approved output path for this role is `runs/{{run_id}}/00-run-log.md`.

## Stop Conditions

- Run-profile variable cannot be resolved.
- An attempt is made to write outside `{{output_root}}`.
- A coordinated PRA reports a critical miss that is not resolved.
- A request attempts to modify canonical prompts, skills, registries, or baselines.

## Prohibited Claims

Do not claim runtime, cloud, ADK, MCP, Jira, Confluence, Rovo, database, Terraform, external post-back, release, diagram, or autonomous execution. Unknown values stay unknown.