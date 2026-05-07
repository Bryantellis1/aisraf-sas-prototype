# Prompt-Skill-Agent Mapping Checklist

Package: AISRAF SAS Prototype v0.1.2

Build Package 06 — Prototype agents, PRA specs, and `.agent.md` adapter model.

This checklist resolves the `future_pra_owner` placeholders that the Build Package 04 prompt registry and the Build Package 05 skill registry deliberately deferred to Build Package 06. The two upstream registries are NOT edited (founder decision Q2). The concrete mapping below is authoritative.

## Resolution Of Placeholder Owners (No Registry Edits)

| Placeholder name (registries) | Concrete PRA in Build Package 06 |
| --- | --- |
| `PRA-RS-REVIEW` | `PRA-01-SAS-REVIEW-ORCHESTRATOR` |
| `PRA-INTAKE` | `PRA-02-INPUT-READER` |
| `PRA-DFD-READER` | `PRA-03-DFD-EXTRACTOR` (visible objects, components, flows) and `PRA-04-LEGEND-NORMALIZER` (legend normalization) |
| `PRA-DESIGN-FACT-EXTRACTOR` | `PRA-03-DFD-EXTRACTOR` for component/flow extraction (PR-RS-04); `PRA-05-REVIEW-TABLE-BUILDER` for boundary/stack assessment (PR-RS-05) |
| `PRA-REVIEW-TABLE-BUILDER` | `PRA-05-REVIEW-TABLE-BUILDER` |
| `PRA-MISSING-FACT-INTERVIEWER` | `PRA-06-BLUEPRINT-QUESTIONER` |
| `PRA-AI-CLASSIFIER` | `PRA-06-BLUEPRINT-QUESTIONER` |
| `PRA-BLUEPRINT-MATCHER` | `PRA-06-BLUEPRINT-QUESTIONER` |
| `PRA-RISK-WRITER` | `PRA-07-FINDING-RECOMMENDER` |
| `PRA-HANDOFF-BUILDER` | `PRA-08-HANDOFF-QA-SCORER` |
| `PRA-VALIDATION-NOTE-WRITER` | `PRA-08-HANDOFF-QA-SCORER` |
| `PRA-VALIDATION-SCORER` | `PRA-08-HANDOFF-QA-SCORER` |
| `PRA-DFD-EXTRACTOR` | `PRA-03-DFD-EXTRACTOR` |

The Build Package 04 prompt registry and the Build Package 05 skill registry retain their `future_pra_owner` placeholder strings. Build Package 06 records the resolved mapping in `prototype-agents/prototype-agent-registry.yaml#prompt_skill_agent_crosswalk` and in this checklist; no upstream registry is edited.

## Naming-Drift Items Carried Forward From Build Package 05

The following naming-drift items are recorded under `skills/skill-registry.yaml#compatibility_notes` and are honoured by every Build Package 06 PRA spec, adapter, and registry entry:

- Prompt-registry placeholder `SK-DFD-LEGEND-NORMALIZE` → canonical Package 05 skill `SK-LEGEND-NORMALIZE`. Owned by `PRA-04-LEGEND-NORMALIZER`.
- Prompt-registry placeholder `SK-SECURITY-STACK-DETECT` → canonical Package 05 skill `SK-SECURITY-STACK-ASSESS`. Owned by `PRA-05-REVIEW-TABLE-BUILDER`.

`SK-CHAIN-WRAPPER` (referenced by `prompts/rs/00-run-full-chain.prompt.md`) is recorded under `skills/skill-registry.yaml#planned_future_skills` only and is not counted in the 26 canonical skills. Build Package 06 maps PR-RS-00 to `PRA-01-SAS-REVIEW-ORCHESTRATOR` with `skills: []`.

## Prompt → Skill → PRA → Adapter Crosswalk

### RS Family (14 prompts)

- [ ] `prompts/rs/00-run-full-chain.prompt.md` (PR-RS-00) → no skill (planned `SK-CHAIN-WRAPPER` is deferred) → `PRA-01-SAS-REVIEW-ORCHESTRATOR` → `.agents/aisraf-orchestrator.agent.md`.
- [ ] `prompts/rs/01-input-package-read.prompt.md` (PR-RS-01) → `skills/rs/SK-INPUT-PACKAGE-READ.md` → `PRA-02-INPUT-READER` → `.agents/aisraf-input-reader.agent.md`.
- [ ] `prompts/rs/02-dfd-visual-read.prompt.md` (PR-RS-02) → `skills/rs/SK-DFD-VISUAL-READ.md` → `PRA-03-DFD-EXTRACTOR` → `.agents/aisraf-dfd-extractor.agent.md`.
- [ ] `prompts/rs/03-legend-normalization.prompt.md` (PR-RS-03) → `skills/rs/SK-LEGEND-NORMALIZE.md` → `PRA-04-LEGEND-NORMALIZER` → `.agents/aisraf-dfd-extractor.agent.md` (no dedicated adapter; founder Q1).
- [ ] `prompts/rs/04-design-fact-extract.prompt.md` (PR-RS-04) → `skills/rs/SK-COMPONENT-EXTRACT.md` and `skills/rs/SK-FLOW-EXTRACT.md` → `PRA-03-DFD-EXTRACTOR` → `.agents/aisraf-dfd-extractor.agent.md`.
- [ ] `prompts/rs/05-boundary-stack-detect.prompt.md` (PR-RS-05) → `skills/rs/SK-BOUNDARY-CROSSING-DETECT.md` and `skills/rs/SK-SECURITY-STACK-ASSESS.md` → `PRA-05-REVIEW-TABLE-BUILDER` → `.agents/aisraf-review-table-builder.agent.md`.
- [ ] `prompts/rs/06-review-table-build.prompt.md` (PR-RS-06) → `skills/rs/SK-DATA-FLOW-TABLE-BUILD.md` → `PRA-05-REVIEW-TABLE-BUILDER` → `.agents/aisraf-review-table-builder.agent.md`.
- [ ] `prompts/rs/07-missing-fact-question-generate.prompt.md` (PR-RS-07) → `skills/rs/SK-MISSING-FACT-IDENTIFY.md` and `skills/rs/SK-TARGETED-QUESTION-GENERATE.md` → `PRA-06-BLUEPRINT-QUESTIONER` → `.agents/aisraf-blueprint-questioner.agent.md`.
- [ ] `prompts/rs/08-ai-action-level-classify.prompt.md` (PR-RS-08) → `skills/rs/SK-AI-ACTION-LEVEL-CLASSIFY.md` → `PRA-06-BLUEPRINT-QUESTIONER` → `.agents/aisraf-blueprint-questioner.agent.md`.
- [ ] `prompts/rs/09-blueprint-match.prompt.md` (PR-RS-09) → `skills/rs/SK-REVIEW-BLUEPRINT-MATCH.md` → `PRA-06-BLUEPRINT-QUESTIONER` → `.agents/aisraf-blueprint-questioner.agent.md`.
- [ ] `prompts/rs/10-finding-recommendation-write.prompt.md` (PR-RS-10) → `skills/rs/SK-FINDING-CLASSIFY.md` and `skills/rs/SK-RECOMMENDATION-WRITE.md` → `PRA-07-FINDING-RECOMMENDER` → `.agents/aisraf-finding-recommender.agent.md`.
- [ ] `prompts/rs/11-handoff-pack-build.prompt.md` (PR-RS-11) → `skills/rs/SK-HANDOFF-PACK-BUILD.md` → `PRA-08-HANDOFF-QA-SCORER` → `.agents/aisraf-handoff-qa-scorer.agent.md`.
- [ ] `prompts/rs/12-validation-note-write.prompt.md` (PR-RS-12) → `skills/rs/SK-VALIDATION-NOTE-WRITE.md` → `PRA-08-HANDOFF-QA-SCORER` → `.agents/aisraf-handoff-qa-scorer.agent.md`.
- [ ] `prompts/rs/13-accuracy-score.prompt.md` (PR-RS-13) → `skills/rs/SK-ACCURACY-SCORE.md` → `PRA-08-HANDOFF-QA-SCORER` → `.agents/aisraf-handoff-qa-scorer.agent.md`.

### DFD Family (9 prompts; one-to-one with the 9 SK-DFD-* skills)

- [ ] `prompts/dfd/02-dfd-intake-quality-check.prompt.md` (PR-DFD-02) → `skills/dfd/SK-DFD-01-INTAKE-QUALITY-CHECK.md` → `PRA-03-DFD-EXTRACTOR` → `.agents/aisraf-dfd-extractor.agent.md`.
- [ ] `prompts/dfd/03-boundary-extract.prompt.md` (PR-DFD-03) → `skills/dfd/SK-DFD-02-BOUNDARY-EXTRACT.md` → `PRA-03-DFD-EXTRACTOR` → `.agents/aisraf-dfd-extractor.agent.md`.
- [ ] `prompts/dfd/04-component-extract.prompt.md` (PR-DFD-04) → `skills/dfd/SK-DFD-03-COMPONENT-EXTRACT.md` → `PRA-03-DFD-EXTRACTOR` → `.agents/aisraf-dfd-extractor.agent.md`.
- [ ] `prompts/dfd/05-flow-extract.prompt.md` (PR-DFD-05) → `skills/dfd/SK-DFD-04-FLOW-EXTRACT.md` → `PRA-03-DFD-EXTRACTOR` → `.agents/aisraf-dfd-extractor.agent.md`.
- [ ] `prompts/dfd/06-annotation-resolve.prompt.md` (PR-DFD-06) → `skills/dfd/SK-DFD-05-ANNOTATION-RESOLVE.md` → `PRA-03-DFD-EXTRACTOR` → `.agents/aisraf-dfd-extractor.agent.md`.
- [ ] `prompts/dfd/07-boundary-crossing-detect.prompt.md` (PR-DFD-07) → `skills/dfd/SK-DFD-06-BOUNDARY-CROSSING-DETECT.md` → `PRA-03-DFD-EXTRACTOR` → `.agents/aisraf-dfd-extractor.agent.md`.
- [ ] `prompts/dfd/08-control-signal-detect.prompt.md` (PR-DFD-08) → `skills/dfd/SK-DFD-07-CONTROL-SIGNAL-DETECT.md` → `PRA-03-DFD-EXTRACTOR` → `.agents/aisraf-dfd-extractor.agent.md`.
- [ ] `prompts/dfd/09-confidence-score.prompt.md` (PR-DFD-09) → `skills/dfd/SK-DFD-08-CONFIDENCE-SCORE.md` → `PRA-03-DFD-EXTRACTOR` → `.agents/aisraf-dfd-extractor.agent.md`.
- [ ] `prompts/dfd/10-dfd-extraction-summarize.prompt.md` (PR-DFD-10) → `skills/dfd/SK-DFD-09-EXTRACTION-SUMMARIZE.md` → `PRA-03-DFD-EXTRACTOR` → `.agents/aisraf-dfd-extractor.agent.md`.

### Coverage Totals

- [ ] Distinct prompts mapped: 23 (= 14 RS + 9 DFD).
- [ ] Distinct skills mapped: 26 (= 17 RS + 9 DFD).
- [ ] PRA-01 owns 1 prompt and 0 skills (chain wrapper).
- [ ] PRA-02 owns 1 prompt and 1 skill.
- [ ] PRA-03 owns 11 prompts (RS-02, RS-04 + 9 DFD) and 12 skills (3 RS + 9 DFD).
- [ ] PRA-04 owns 1 prompt and 1 skill.
- [ ] PRA-05 owns 2 prompts and 3 skills.
- [ ] PRA-06 owns 3 prompts and 4 skills.
- [ ] PRA-07 owns 1 prompt and 2 skills.
- [ ] PRA-08 owns 3 prompts and 3 skills.
- [ ] Sum of PRA prompt counts: 1 + 1 + 11 + 1 + 2 + 3 + 1 + 3 = 23.
- [ ] Sum of PRA skill counts: 0 + 1 + 12 + 1 + 3 + 4 + 2 + 3 = 26.

## Adapter Coverage

- [ ] 7 adapters total. Every adapter `wraps_pras` value is a real PRA from the 8-PRA inventory.
- [ ] `aisraf-dfd-extractor.agent.md` is the only adapter that wraps two PRAs (PRA-03 and PRA-04; founder Q1).
- [ ] No PRA is wrapped by zero adapters except `PRA-04-LEGEND-NORMALIZER`, and that PRA is wrapped via `aisraf-dfd-extractor.agent.md`.
- [ ] No adapter references a missing PRA, prompt, or skill path.
- [ ] No adapter duplicates the full body of any prompt card or skill contract.
- [ ] Every adapter Operator Test Prompt names the canonical PRA, prompt, and skill paths and uses only the seven authoritative run-profile variables.

## Frozen Surfaces (Verification)

- [ ] `prompts/prompt-registry.yaml` content is byte-identical to the Build Package 04 commit `c57d584`.
- [ ] `skills/skill-registry.yaml` content is byte-identical to the Build Package 05 commit `a8221eb`.
- [ ] No file under `prompts/` was modified by Build Package 06.
- [ ] No file under `skills/` was modified by Build Package 06.
- [ ] No file under `{{expected_root}}` was created or modified by Build Package 06.
- [ ] Old reference workspace at `D:/E-Way 2/aisraf-sas-prototype-skill-chain-pack-v0.01` is unchanged.
