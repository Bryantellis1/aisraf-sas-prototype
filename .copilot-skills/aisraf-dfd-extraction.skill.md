---
name: aisraf-dfd-extraction
description: "Use when: extracting AISRAF DFD facts, explaining PRA-03/PRA-04, previewing visible DFD object outputs, or checking DFD stop conditions."
user-invocable: true
---

# AISRAF DFD Extraction Skill Wrapper

## Role Explanation

This is a thin BP12C projection of `AISRAF DFD Extractor`. It jointly wraps `PRA-03-DFD-EXTRACTOR` and `PRA-04-LEGEND-NORMALIZER` to read staged DFD inputs, extract visible objects, normalize labels, and write only canonical DFD extraction outputs.

## Canonical References

- Adapter: `.agents/aisraf-dfd-extractor.agent.md`
- PRAs: `prototype-agents/PRA-03-DFD-EXTRACTOR.md`, `prototype-agents/PRA-04-LEGEND-NORMALIZER.md`
- RS prompts: `prompts/rs/02-dfd-visual-read.prompt.md`, `prompts/rs/03-legend-normalization.prompt.md`, `prompts/rs/04-design-fact-extract.prompt.md`
- DFD prompts: `prompts/dfd/02-dfd-intake-quality-check.prompt.md` through `prompts/dfd/10-dfd-extraction-summarize.prompt.md`
- RS skills: `skills/rs/SK-DFD-VISUAL-READ.md`, `skills/rs/SK-LEGEND-NORMALIZE.md`, `skills/rs/SK-COMPONENT-EXTRACT.md`, `skills/rs/SK-FLOW-EXTRACT.md`
- Handoff reference: `skills/rs/SK-BOUNDARY-CROSSING-DETECT.md` is consumed by `aisraf-review-table-build`.
- DFD skills: `skills/dfd/SK-DFD-01-INTAKE-QUALITY-CHECK.md` through `skills/dfd/SK-DFD-09-EXTRACTION-SUMMARIZE.md`

## Allowed Writes

- `runs/{{run_id}}/02-visible-dfd-objects.md`
- `runs/{{run_id}}/03-legend-normalization.md`
- `runs/{{run_id}}/04-components.md`
- `runs/{{run_id}}/05-flows.md`
- `runs/{{run_id}}/dfd/01-intake-quality-check.md`
- `runs/{{run_id}}/dfd/02-boundary-catalog.md`
- `runs/{{run_id}}/dfd/03-component-catalog.md`
- `runs/{{run_id}}/dfd/04-flow-inventory.md`
- `runs/{{run_id}}/dfd/05-annotation-resolution.md`
- `runs/{{run_id}}/dfd/06-boundary-crossings.md`
- `runs/{{run_id}}/dfd/07-control-signals.md`
- `runs/{{run_id}}/dfd/08-confidence-score.md`
- `runs/{{run_id}}/dfd/09-extraction-summary.md`

## Output Guide

- `runs/{{run_id}}/02-visible-dfd-objects.md`
  - What: Visible DFD object inventory.
  - Why: Establishes what was actually seen before normalization.
  - How: Use `prompts/rs/02-dfd-visual-read.prompt.md` with `skills/rs/SK-DFD-VISUAL-READ.md`.
- `runs/{{run_id}}/03-legend-normalization.md`
  - What: Normalized DFD labels and legend notes.
  - Why: Preserves label evidence without treating labels as implementation proof.
  - How: Use `prompts/rs/03-legend-normalization.prompt.md` with `skills/rs/SK-LEGEND-NORMALIZE.md`.
- `runs/{{run_id}}/04-components.md`
  - What: Component extraction table.
  - Why: Provides supported component facts for later review.
  - How: Use `prompts/rs/04-design-fact-extract.prompt.md` with `skills/rs/SK-COMPONENT-EXTRACT.md`.
- `runs/{{run_id}}/05-flows.md`
  - What: Flow extraction table.
  - Why: Provides supported flow facts for boundary and review-table steps.
  - How: Use `prompts/rs/04-design-fact-extract.prompt.md` with `skills/rs/SK-FLOW-EXTRACT.md`.
- `runs/{{run_id}}/dfd/01-intake-quality-check.md`
  - What: DFD intake quality gate.
  - Why: Decides whether the DFD subchain can proceed.
  - How: Use `prompts/dfd/02-dfd-intake-quality-check.prompt.md` with `skills/dfd/SK-DFD-01-INTAKE-QUALITY-CHECK.md`.
- `runs/{{run_id}}/dfd/02-boundary-catalog.md`
  - What: DFD boundary catalog.
  - Why: Captures visible boundary candidates from the DFD.
  - How: Use `prompts/dfd/03-boundary-extract.prompt.md` with `skills/dfd/SK-DFD-02-BOUNDARY-EXTRACT.md`.
- `runs/{{run_id}}/dfd/03-component-catalog.md`
  - What: DFD component catalog.
  - Why: Captures visible components from the DFD.
  - How: Use `prompts/dfd/04-component-extract.prompt.md` with `skills/dfd/SK-DFD-03-COMPONENT-EXTRACT.md`.
- `runs/{{run_id}}/dfd/04-flow-inventory.md`
  - What: DFD flow inventory.
  - Why: Captures visible DFD flows and evidence notes.
  - How: Use `prompts/dfd/05-flow-extract.prompt.md` with `skills/dfd/SK-DFD-04-FLOW-EXTRACT.md`.
- `runs/{{run_id}}/dfd/05-annotation-resolution.md`
  - What: Annotation resolution notes.
  - Why: Records how visible annotations were interpreted or kept unknown.
  - How: Use `prompts/dfd/06-annotation-resolve.prompt.md` with `skills/dfd/SK-DFD-05-ANNOTATION-RESOLVE.md`.
- `runs/{{run_id}}/dfd/06-boundary-crossings.md`
  - What: DFD boundary-crossing candidates.
  - Why: Supplies evidence for review-table boundary work.
  - How: Use `prompts/dfd/07-boundary-crossing-detect.prompt.md` with `skills/dfd/SK-DFD-06-BOUNDARY-CROSSING-DETECT.md`.
- `runs/{{run_id}}/dfd/07-control-signals.md`
  - What: Visible control-signal inventory.
  - Why: Separates observed signals from proof.
  - How: Use `prompts/dfd/08-control-signal-detect.prompt.md` with `skills/dfd/SK-DFD-07-CONTROL-SIGNAL-DETECT.md`.
- `runs/{{run_id}}/dfd/08-confidence-score.md`
  - What: DFD extraction confidence notes.
  - Why: Records extraction confidence without computing review accuracy.
  - How: Use `prompts/dfd/09-confidence-score.prompt.md` with `skills/dfd/SK-DFD-08-CONFIDENCE-SCORE.md`.
- `runs/{{run_id}}/dfd/09-extraction-summary.md`
  - What: DFD extraction summary.
  - Why: Summarizes subchain evidence and limits.
  - How: Use `prompts/dfd/10-dfd-extraction-summarize.prompt.md` with `skills/dfd/SK-DFD-09-EXTRACTION-SUMMARIZE.md`.

## Unknown Handling

Carry `unknown` through `IA?`, `SA?`, `CA?`, `AZ?`, `R?`, `L?`, and `match=unknown`. Do not invent values to clear a field.

## Stop Conditions

- A required prior output is missing or empty.
- An object, component, flow, label, protocol, owner, control, evidence, or implementation proof is invented.
- A material model, tool/API, write-back flow, data-store, SaaS, human actor, or internet-facing flow is missed.
- An S# label is treated as approved security stack rather than as a review signal.
- A DFD subskill claims accuracy scoring (only `skills/rs/SK-ACCURACY-SCORE.md` may produce an accuracy score).
- The DFD intake gate (`{{output_root}}/dfd/01-intake-quality-check.md`) reports `proceed = false` and the chain attempts to continue.
- A write is attempted outside `{{output_root}}` or `{{output_root}}/dfd/`.
- Any claim of runtime, cloud, ADK, MCP, Jira, Confluence, Rovo, database, or release execution.

## Role Smoke Response

With no input, explain this role, show the allowed write paths, cite the stop conditions, and refuse to write.

## Chat Preview Response

For preview-only mode, render the referenced template section shapes in chat, show DFD subchain order, and write nothing.

## Prohibited Claims

Do not claim runtime, cloud, ADK, MCP, Jira, Confluence, Rovo, database, Terraform, external post-back, release, diagram, or autonomous execution.
