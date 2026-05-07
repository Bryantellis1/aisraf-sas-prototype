# skills/rs/

Root Area: Root Area 07 — `skills/`.

Owning Build Package: Build Package 05 — Skills and skill registry.

## Purpose

Reusable skill contracts for the SAS Review Sequence (RS-01..RS-17). Each contract describes a discrete reusable work unit that wraps one Build Package 04 prompt card. Skills are not executable runtime tools; they are governed contracts with explicit purpose, inputs, outputs, stop conditions, unknown handling, confidence handling, critical misses, human review gates, validation/scoring relationships, direct skill tests, and out-of-scope claims.

## Inventory (17 contracts)

| # | Skill ID | Review Step | Mapped prompt | Owns output |
|---|---|---|---|---|
| 1 | [SK-INPUT-PACKAGE-READ](SK-INPUT-PACKAGE-READ.md) | RS-01 | [PR-RS-01](../../prompts/rs/01-input-package-read.prompt.md) | `01-input-inventory.md` |
| 2 | [SK-DFD-VISUAL-READ](SK-DFD-VISUAL-READ.md) | RS-02 | [PR-RS-02](../../prompts/rs/02-dfd-visual-read.prompt.md) | `02-visible-dfd-objects.md` |
| 3 | [SK-LEGEND-NORMALIZE](SK-LEGEND-NORMALIZE.md) | RS-03 | [PR-RS-03](../../prompts/rs/03-legend-normalization.prompt.md) | `03-legend-normalization.md` |
| 4 | [SK-COMPONENT-EXTRACT](SK-COMPONENT-EXTRACT.md) | RS-04 | [PR-RS-04](../../prompts/rs/04-design-fact-extract.prompt.md) (shared) | `04-components.md` |
| 5 | [SK-FLOW-EXTRACT](SK-FLOW-EXTRACT.md) | RS-05 | [PR-RS-04](../../prompts/rs/04-design-fact-extract.prompt.md) (shared) | `05-flows.md` |
| 6 | [SK-BOUNDARY-CROSSING-DETECT](SK-BOUNDARY-CROSSING-DETECT.md) | RS-06 | [PR-RS-05](../../prompts/rs/05-boundary-stack-detect.prompt.md) (shared) | `06-boundaries.md` |
| 7 | [SK-SECURITY-STACK-ASSESS](SK-SECURITY-STACK-ASSESS.md) | RS-07 | [PR-RS-05](../../prompts/rs/05-boundary-stack-detect.prompt.md) (shared) | `07-security-stack-assessment.md` |
| 8 | [SK-DATA-FLOW-TABLE-BUILD](SK-DATA-FLOW-TABLE-BUILD.md) | RS-08 | [PR-RS-06](../../prompts/rs/06-review-table-build.prompt.md) | `08-internal-review-table.md` |
| 9 | [SK-MISSING-FACT-IDENTIFY](SK-MISSING-FACT-IDENTIFY.md) | RS-09 | [PR-RS-07](../../prompts/rs/07-missing-fact-question-generate.prompt.md) (shared) | `09-missing-facts.md` |
| 10 | [SK-AI-ACTION-LEVEL-CLASSIFY](SK-AI-ACTION-LEVEL-CLASSIFY.md) | RS-10 | [PR-RS-08](../../prompts/rs/08-ai-action-level-classify.prompt.md) | `10-ai-action-level.md` |
| 11 | [SK-REVIEW-BLUEPRINT-MATCH](SK-REVIEW-BLUEPRINT-MATCH.md) | RS-11 | [PR-RS-09](../../prompts/rs/09-blueprint-match.prompt.md) | `11-blueprint-match.md` |
| 12 | [SK-TARGETED-QUESTION-GENERATE](SK-TARGETED-QUESTION-GENERATE.md) | RS-12 | [PR-RS-07](../../prompts/rs/07-missing-fact-question-generate.prompt.md) (shared) | `12-targeted-questions.md` |
| 13 | [SK-FINDING-CLASSIFY](SK-FINDING-CLASSIFY.md) | RS-13 | [PR-RS-10](../../prompts/rs/10-finding-recommendation-write.prompt.md) (shared) | `13-findings.md` |
| 14 | [SK-RECOMMENDATION-WRITE](SK-RECOMMENDATION-WRITE.md) | RS-14 | [PR-RS-10](../../prompts/rs/10-finding-recommendation-write.prompt.md) (shared) | `14-recommendations.md` |
| 15 | [SK-HANDOFF-PACK-BUILD](SK-HANDOFF-PACK-BUILD.md) | RS-15 | [PR-RS-11](../../prompts/rs/11-handoff-pack-build.prompt.md) | `15-handoff-pack.md` |
| 16 | [SK-VALIDATION-NOTE-WRITE](SK-VALIDATION-NOTE-WRITE.md) | RS-16 | [PR-RS-12](../../prompts/rs/12-validation-note-write.prompt.md) | `16-validation-notes.md` |
| 17 | [SK-ACCURACY-SCORE](SK-ACCURACY-SCORE.md) | RS-17 | [PR-RS-13](../../prompts/rs/13-accuracy-score.prompt.md) | `17-accuracy-score.md` |

## Shared-Prompt Pairs

Four Build Package 04 prompts cover two skills each. The shared prompt writes both output artifacts; each skill is the canonical contract for one of the artifacts.

- [PR-RS-04](../../prompts/rs/04-design-fact-extract.prompt.md) — `SK-COMPONENT-EXTRACT` (RS-04) + `SK-FLOW-EXTRACT` (RS-05).
- [PR-RS-05](../../prompts/rs/05-boundary-stack-detect.prompt.md) — `SK-BOUNDARY-CROSSING-DETECT` (RS-06) + `SK-SECURITY-STACK-ASSESS` (RS-07).
- [PR-RS-07](../../prompts/rs/07-missing-fact-question-generate.prompt.md) — `SK-MISSING-FACT-IDENTIFY` (RS-09) + `SK-TARGETED-QUESTION-GENERATE` (RS-12).
- [PR-RS-10](../../prompts/rs/10-finding-recommendation-write.prompt.md) — `SK-FINDING-CLASSIFY` (RS-13) + `SK-RECOMMENDATION-WRITE` (RS-14).

## Compatibility Notes

- Package 04 prompt registry uses placeholder `future_skill_id` values that diverge from Package 05 canonical names for two skills. The skill registry is authoritative. See [skills/skill-registry.yaml](../skill-registry.yaml) `compatibility_notes`.
  - `SK-DFD-LEGEND-NORMALIZE` (placeholder) → `SK-LEGEND-NORMALIZE` (canonical).
  - `SK-SECURITY-STACK-DETECT` (placeholder) → `SK-SECURITY-STACK-ASSESS` (canonical).
- Some Package 04 prompt registry `review_step` fields use prompt-sequence labels rather than the SAS RS-01..RS-17 semantic. Skill registry is authoritative for the canonical RS step.
- `PR-RS-00` (full-chain wrapper) is `status: planned` and writes nothing. It does not have a Package 05 skill contract. The placeholder name `SK-CHAIN-WRAPPER` is recorded in the registry's `planned_future_skills` block, outside the 26-skill count.

## What Belongs Here

- Seventeen `SK-*.md` skill contract files, each containing the 14 required sections.
- This README.

## What Does Not Belong Here

- Executable runtime code, scripts, services, libraries, or SDKs.
- Prompt cards (those live under `prompts/rs/`).
- PRA specifications (deferred to Build Package 06).
- `.agent.md` adapters (deferred to Build Package 06).
- Catalogs (deferred to Build Package 07), blueprints (Build Package 08), templates beyond authoring-agent templates (Build Package 09), samples (Build Package 10), run outputs (Build Package 11), diagrams (Build Package 13), docs/runbooks (Build Package 14), release artifacts (Build Package 15).
- Schemas outside `config/`.
- Old v0.01 skill copies, stale baselines, or scoring proof.

## Required Sections In Every RS Skill

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
- Build Package 03 — [tools/](../../tools/) — `New-AisrafRun.ps1`, `Test-AisrafRunProfile.ps1`, `Test-AisrafPackage.ps1`.
- Build Package 04 — [prompts/rs/](../../prompts/rs/) — RS prompt cards.
- Build Package 06 — [prototype-agents/](../../prototype-agents/) — will replace each skill's `future_pra_owner` placeholder.
- Build Package 12 — [validation/](../../validation/) — broader validation gates.
