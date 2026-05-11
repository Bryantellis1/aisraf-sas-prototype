---
name: aisraf-handoff-qa-score
description: "Build AISRAF handoff-pack, validation-note, and accuracy-score previews, explain PRA-08, and map canonical scoring conditions. Use when asked for handoff QA, validation notes, accuracy scoring gates, role smoke, or skill wiring."
argument-hint: "[preview only | skill wiring | sample input/output]"
user-invocable: true
---

# AISRAF Handoff QA Score

This provider skill package is a thin Agent Skills projection. It is not the source of truth. Canonical authority remains in the AISRAF registries, PRAs, prompts, skills, templates, validation files, run profiles, and `tools/Test-*.ps1`.

## Purpose

Use this skill to explain or preview the AISRAF handoff, validation-note, and scoring role without writing files. It maps to the existing `.copilot-skills/aisraf-handoff-qa-score.skill.md` projection and the owning AISRAF agent `AISRAF Handoff QA Scorer`.

## Canonical References

- Owning agent: `AISRAF Handoff QA Scorer`
- Canonical adapter: `.agents/aisraf-handoff-qa-scorer.agent.md`
- Copilot agent projection: `.github/agents/aisraf-handoff-qa-scorer.agent.md`
- Canonical PRA: `prototype-agents/PRA-08-HANDOFF-QA-SCORER.md`
- Canonical prompts: `prompts/rs/11-handoff-pack-build.prompt.md`, `prompts/rs/12-validation-note-write.prompt.md`, `prompts/rs/13-accuracy-score.prompt.md`
- Canonical skills: `skills/rs/SK-HANDOFF-PACK-BUILD.md`, `skills/rs/SK-VALIDATION-NOTE-WRITE.md`, `skills/rs/SK-ACCURACY-SCORE.md`
- Canonical templates: `templates/output/output-15-handoff-pack-template.md`, `templates/output/output-16-validation-notes-template.md`, `templates/output/output-17-accuracy-score-template.md`
- Local wrapper projection: `.copilot-skills/aisraf-handoff-qa-score.skill.md`
- Operator card: `.copilot-skills/aisraf-handoff-qa-score.operator-card.md`

## Accepted Input

- Read-only upstream outputs such as `runs/{{run_id}}/13-findings.md`, `runs/{{run_id}}/14-recommendations.md`, and the full prior chain output set.
- Read-only expected baselines when scoring conditions are met.
- Operator prompts that explicitly say `preview only` or `write nothing`.

## Expected Chat-Preview Output

Return handoff-pack, validation-note, and accuracy-score output shapes by canonical template path. State scoring conditions before any score claim. In preview, use `<numeric_score_pending_chain_execution>` and write nothing.

## Controlled Output

Controlled file output remains deferred until founder approval. If Mode B is later approved, approved output paths are `runs/{{run_id}}/15-handoff-pack.md`, `runs/{{run_id}}/16-validation-notes.md`, and `runs/{{run_id}}/17-accuracy-score.md`.

## Stop Conditions

- Validation-ticket evidence is found inside the handoff pack or vice versa.
- An accuracy claim is made when scoring conditions are not met.
- A baseline file under `{{expected_root}}` is modified by this adapter.
- A write is attempted outside `{{output_root}}`.

## Prohibited Claims

Do not claim runtime, cloud, ADK, MCP, Jira, Confluence, Rovo, database, Terraform, external post-back, release, diagram, or autonomous execution. Unknown values stay unknown.