# skills/dfd/

Root Area: Root Area 07 — `skills/`.

Owning Build Package: Build Package 05 — Skills and skill registry.

## Purpose

Reusable DFD subskill contracts for narrow DFD work units that feed the RS chain. Nine subskills cover the v0.1.2 DFD steps DFD-01..DFD-09. Each contract wraps one Build Package 04 DFD prompt card and produces a discrete artifact under `{{output_root}}/dfd/`.

## Inventory (9 contracts)

| # | Subskill ID | DFD Step | Mapped prompt | Owns output |
|---|---|---|---|---|
| 1 | [SK-DFD-01-INTAKE-QUALITY-CHECK](SK-DFD-01-INTAKE-QUALITY-CHECK.md) | DFD-01 | [PR-DFD-02](../../prompts/dfd/02-dfd-intake-quality-check.prompt.md) | `dfd/01-intake-quality-check.md` |
| 2 | [SK-DFD-02-BOUNDARY-EXTRACT](SK-DFD-02-BOUNDARY-EXTRACT.md) | DFD-02 | [PR-DFD-03](../../prompts/dfd/03-boundary-extract.prompt.md) | `dfd/02-boundary-catalog.md` |
| 3 | [SK-DFD-03-COMPONENT-EXTRACT](SK-DFD-03-COMPONENT-EXTRACT.md) | DFD-03 | [PR-DFD-04](../../prompts/dfd/04-component-extract.prompt.md) | `dfd/03-component-catalog.md` |
| 4 | [SK-DFD-04-FLOW-EXTRACT](SK-DFD-04-FLOW-EXTRACT.md) | DFD-04 | [PR-DFD-05](../../prompts/dfd/05-flow-extract.prompt.md) | `dfd/04-flow-inventory.md` |
| 5 | [SK-DFD-05-ANNOTATION-RESOLVE](SK-DFD-05-ANNOTATION-RESOLVE.md) | DFD-05 | [PR-DFD-06](../../prompts/dfd/06-annotation-resolve.prompt.md) | `dfd/05-annotation-resolution.md` |
| 6 | [SK-DFD-06-BOUNDARY-CROSSING-DETECT](SK-DFD-06-BOUNDARY-CROSSING-DETECT.md) | DFD-06 | [PR-DFD-07](../../prompts/dfd/07-boundary-crossing-detect.prompt.md) | `dfd/06-boundary-crossings.md` |
| 7 | [SK-DFD-07-CONTROL-SIGNAL-DETECT](SK-DFD-07-CONTROL-SIGNAL-DETECT.md) | DFD-07 | [PR-DFD-08](../../prompts/dfd/08-control-signal-detect.prompt.md) | `dfd/07-control-signals.md` |
| 8 | [SK-DFD-08-CONFIDENCE-SCORE](SK-DFD-08-CONFIDENCE-SCORE.md) | DFD-08 | [PR-DFD-09](../../prompts/dfd/09-confidence-score.prompt.md) | `dfd/08-confidence-score.md` |
| 9 | [SK-DFD-09-EXTRACTION-SUMMARIZE](SK-DFD-09-EXTRACTION-SUMMARIZE.md) | DFD-09 | [PR-DFD-10](../../prompts/dfd/10-dfd-extraction-summarize.prompt.md) | `dfd/09-extraction-summary.md` |

## DFD Subskill Layers

- `intake_precondition` — DFD-01.
- `visual_structure` — DFD-02, DFD-03, DFD-04.
- `annotation_semantics` — DFD-05.
- `review_interpretation` — DFD-06, DFD-07.
- `extraction_quality` — DFD-08, DFD-09.

## Numbering Note

The DFD prompt family is numbered `02..10` in `prompts/dfd/` (founder decision recorded in Build Package 04 compatibility notes). The DFD output files under `{{output_root}}/dfd/` are renumbered `01..09`. The DFD subskill IDs use the `01..09` semantic to match the output paths and the `dfd_step` values in the registry.

## DFD vs RS

DFD subskills extract the visual structure and resolve token semantics. RS skills consume DFD outputs to build the SAS review surface (review table, missing facts, AI Action Level, blueprint match, findings, recommendations, handoff pack, validation notes, accuracy score). Accuracy scoring is owned exclusively by [SK-ACCURACY-SCORE](../rs/SK-ACCURACY-SCORE.md) (RS-17). DFD subskills produce confidence and summary outputs but never an accuracy score.

## What Belongs Here

- Nine `SK-DFD-NN-*.md` subskill files matching `^SK-DFD-0[1-9]-[A-Z0-9-]+\.md$`, each containing the 14 required sections.
- This README.

## What Does Not Belong Here

- Executable runtime code, scripts, services, libraries, or SDKs.
- Prompt cards (those live under `prompts/dfd/`).
- PRA specifications, `.agent.md` adapters, catalogs, blueprints, templates beyond authoring-agent templates, samples, run outputs, diagrams, docs/runbooks, release artifacts (deferred to later Build Packages).
- Schemas outside `config/`.
- RS skills (those live under `skills/rs/`).

## Required Sections In Every DFD Subskill

Every contract in this folder contains all 14 sections in order:

1. Identity
2. Purpose
3. Required Inputs
4. Optional Inputs
5. Required Outputs
6. Procedure
7. Stop Conditions
8. Unknown Handling
9. Confidence Handling
10. Critical Misses
11. Human Review Gate
12. Validation / Scoring Relationship
13. Direct Skill Test
14. Not In Scope

## Related Build Packages

- Build Package 02 — [config/](../../config/) — run-profile variable model.
- Build Package 04 — [prompts/dfd/](../../prompts/dfd/) — DFD prompt cards.
- Build Package 06 — [prototype-agents/](../../prototype-agents/) — will replace each subskill's `future_pra_owner` placeholder (`PRA-DFD-EXTRACTOR`).
- Build Package 12 — [validation/](../../validation/) — broader validation gates.
