---
name: aisraf-dfd-extraction
description: "Extract AISRAF DFD facts, explain PRA-03 and PRA-04, map canonical RS/DFD prompts and skills, and preview visible DFD object outputs without writing. Use when asked for DFD extraction, legend normalization, sample DFD preview, or skill wiring."
argument-hint: "[preview only | skill wiring | sample input/output]"
user-invocable: true
---

# AISRAF DFD Extraction

This provider skill package is a thin Agent Skills projection. It is not the source of truth. Canonical authority remains in the AISRAF registries, PRAs, prompts, skills, templates, validation files, run profiles, and `tools/Test-*.ps1`.

## Purpose

Use this skill to explain or preview the AISRAF DFD extraction role without writing files. It maps to the existing `.copilot-skills/aisraf-dfd-extraction.skill.md` projection and the owning AISRAF agent `AISRAF DFD Extractor`.

## Canonical References

- Owning agent: `AISRAF DFD Extractor`
- Canonical adapter: `.agents/aisraf-dfd-extractor.agent.md`
- Copilot agent projection: `.github/agents/aisraf-dfd-extractor.agent.md`
- Canonical PRAs: `prototype-agents/PRA-03-DFD-EXTRACTOR.md`, `prototype-agents/PRA-04-LEGEND-NORMALIZER.md`
- Canonical RS prompts: `prompts/rs/02-dfd-visual-read.prompt.md`, `prompts/rs/03-legend-normalization.prompt.md`, `prompts/rs/04-design-fact-extract.prompt.md`
- Canonical DFD prompts: `prompts/dfd/02-dfd-intake-quality-check.prompt.md`, `prompts/dfd/03-boundary-extract.prompt.md`, `prompts/dfd/04-component-extract.prompt.md`, `prompts/dfd/05-flow-extract.prompt.md`, `prompts/dfd/06-annotation-resolve.prompt.md`, `prompts/dfd/07-boundary-crossing-detect.prompt.md`, `prompts/dfd/08-control-signal-detect.prompt.md`, `prompts/dfd/09-confidence-score.prompt.md`, `prompts/dfd/10-dfd-extraction-summarize.prompt.md`
- Canonical RS skills: `skills/rs/SK-DFD-VISUAL-READ.md`, `skills/rs/SK-LEGEND-NORMALIZE.md`, `skills/rs/SK-COMPONENT-EXTRACT.md`, `skills/rs/SK-FLOW-EXTRACT.md`
- Canonical DFD skills: `skills/dfd/SK-DFD-01-INTAKE-QUALITY-CHECK.md`, `skills/dfd/SK-DFD-02-BOUNDARY-EXTRACT.md`, `skills/dfd/SK-DFD-03-COMPONENT-EXTRACT.md`, `skills/dfd/SK-DFD-04-FLOW-EXTRACT.md`, `skills/dfd/SK-DFD-05-ANNOTATION-RESOLVE.md`, `skills/dfd/SK-DFD-06-BOUNDARY-CROSSING-DETECT.md`, `skills/dfd/SK-DFD-07-CONTROL-SIGNAL-DETECT.md`, `skills/dfd/SK-DFD-08-CONFIDENCE-SCORE.md`, `skills/dfd/SK-DFD-09-EXTRACTION-SUMMARIZE.md`
- Local wrapper projection: `.copilot-skills/aisraf-dfd-extraction.skill.md`
- Operator card: `.copilot-skills/aisraf-dfd-extraction.operator-card.md`

## Accepted Input

- Read-only DFD image/source inputs such as `runs/RUN-001/inputs/dfd-crop.png` and `runs/RUN-001/inputs/dfd-crop.mmd`.
- Read-only supporting notes for legend hints and sample context.
- Operator prompts that explicitly say `preview only` or `write nothing`.

## Expected Chat-Preview Output

Return the visible DFD inputs read, expected unknowns, DFD subchain order, and output shapes by canonical template path. In preview, files written must be `none in preview`.

## Controlled Output

Controlled file output remains deferred until founder approval. If Mode B is later approved, approved output paths are `runs/{{run_id}}/02-visible-dfd-objects.md`, `runs/{{run_id}}/03-legend-normalization.md`, `runs/{{run_id}}/04-components.md`, `runs/{{run_id}}/05-flows.md`, and `runs/{{run_id}}/dfd/01-intake-quality-check.md` through `runs/{{run_id}}/dfd/09-extraction-summary.md`.

## Stop Conditions

- A required prior output is missing or empty.
- A visible DFD fact, label, protocol, owner, control, evidence, or implementation proof is invented.
- The DFD intake gate reports proceed false and the chain attempts to continue.
- A write is attempted outside `{{output_root}}` or `{{output_root}}/dfd/`.

## Prohibited Claims

Do not claim runtime, cloud, ADK, MCP, Jira, Confluence, Rovo, database, Terraform, external post-back, release, diagram, accuracy scoring, or autonomous execution. Unknown values stay unknown.