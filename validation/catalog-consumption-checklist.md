# Catalog Consumption Checklist

Package: AISRAF SAS Prototype v0.1.2
Build Package: 07
Subject: prompt / skill / PRA / adapter consumption of Build Package 07 catalogs
Status: active

This checklist validates that the Build Package 07 catalog consumer maps are complete and self-consistent without modifying any upstream prompt, skill, prototype-agent, or adapter registry. Consumer mapping is the responsibility of `catalogs/catalog-registry.yaml`; this checklist is the human-review gate over that mapping.

## 1. Sealed Upstream Registries

The following files must be unchanged from the Build Package 06 commit state. Verification: compare hash or `git diff` against commit `4eab128`.

- [ ] `prompts/prompt-registry.yaml`
- [ ] `skills/skill-registry.yaml`
- [ ] `prototype-agents/prototype-agent-registry.yaml`
- [ ] No file under `prompts/`, `skills/`, `prototype-agents/`, or `.agents/` was created or modified by Build Package 07.

## 2. Prompt Consumption Coverage

All 23 Build Package 04 prompts must appear exactly once in `catalog-registry.yaml#prompt_consumption_map`. PR-RS-00 may have an empty `catalogs:` list because the full-chain wrapper is `status: planned`.

- [ ] PR-RS-00-RUN-FULL-CHAIN — empty catalogs allowed
- [ ] PR-RS-01-INPUT-PACKAGE-READ
- [ ] PR-RS-02-DFD-VISUAL-READ
- [ ] PR-RS-03-LEGEND-NORMALIZATION
- [ ] PR-RS-04-DESIGN-FACT-EXTRACT
- [ ] PR-RS-05-BOUNDARY-STACK-DETECT
- [ ] PR-RS-06-REVIEW-TABLE-BUILD
- [ ] PR-RS-07-MISSING-FACT-QUESTION-GENERATE
- [ ] PR-RS-08-AI-ACTION-LEVEL-CLASSIFY
- [ ] PR-RS-09-BLUEPRINT-MATCH
- [ ] PR-RS-10-FINDING-RECOMMENDATION-WRITE
- [ ] PR-RS-11-HANDOFF-PACK-BUILD
- [ ] PR-RS-12-VALIDATION-NOTE-WRITE
- [ ] PR-RS-13-ACCURACY-SCORE
- [ ] PR-DFD-02-DFD-INTAKE-QUALITY-CHECK
- [ ] PR-DFD-03-BOUNDARY-EXTRACT
- [ ] PR-DFD-04-COMPONENT-EXTRACT
- [ ] PR-DFD-05-FLOW-EXTRACT
- [ ] PR-DFD-06-ANNOTATION-RESOLVE
- [ ] PR-DFD-07-BOUNDARY-CROSSING-DETECT
- [ ] PR-DFD-08-CONTROL-SIGNAL-DETECT
- [ ] PR-DFD-09-CONFIDENCE-SCORE
- [ ] PR-DFD-10-DFD-EXTRACTION-SUMMARIZE

## 3. Skill Consumption Coverage

All 26 Build Package 05 skills must appear exactly once in `catalog-registry.yaml#skill_consumption_map`.

RS skills (17):

- [ ] SK-INPUT-PACKAGE-READ
- [ ] SK-DFD-VISUAL-READ
- [ ] SK-LEGEND-NORMALIZE
- [ ] SK-COMPONENT-EXTRACT
- [ ] SK-FLOW-EXTRACT
- [ ] SK-BOUNDARY-CROSSING-DETECT
- [ ] SK-SECURITY-STACK-ASSESS
- [ ] SK-DATA-FLOW-TABLE-BUILD
- [ ] SK-MISSING-FACT-IDENTIFY
- [ ] SK-AI-ACTION-LEVEL-CLASSIFY
- [ ] SK-REVIEW-BLUEPRINT-MATCH
- [ ] SK-TARGETED-QUESTION-GENERATE
- [ ] SK-FINDING-CLASSIFY
- [ ] SK-RECOMMENDATION-WRITE
- [ ] SK-HANDOFF-PACK-BUILD
- [ ] SK-VALIDATION-NOTE-WRITE
- [ ] SK-ACCURACY-SCORE

DFD subskills (9):

- [ ] SK-DFD-01-INTAKE-QUALITY-CHECK
- [ ] SK-DFD-02-BOUNDARY-EXTRACT
- [ ] SK-DFD-03-COMPONENT-EXTRACT
- [ ] SK-DFD-04-FLOW-EXTRACT
- [ ] SK-DFD-05-ANNOTATION-RESOLVE
- [ ] SK-DFD-06-BOUNDARY-CROSSING-DETECT
- [ ] SK-DFD-07-CONTROL-SIGNAL-DETECT
- [ ] SK-DFD-08-CONFIDENCE-SCORE
- [ ] SK-DFD-09-EXTRACTION-SUMMARIZE

## 4. PRA Consumption Coverage

All 8 PRAs must appear exactly once in `catalog-registry.yaml#pra_consumption_map`.

- [ ] PRA-01-SAS-REVIEW-ORCHESTRATOR
- [ ] PRA-02-INPUT-READER
- [ ] PRA-03-DFD-EXTRACTOR
- [ ] PRA-04-LEGEND-NORMALIZER
- [ ] PRA-05-REVIEW-TABLE-BUILDER
- [ ] PRA-06-BLUEPRINT-QUESTIONER
- [ ] PRA-07-FINDING-RECOMMENDER
- [ ] PRA-08-HANDOFF-QA-SCORER

## 5. Adapter Consumption Coverage

All 7 adapters must appear exactly once in `catalog-registry.yaml#adapter_consumption_map`.

- [ ] aisraf-orchestrator (canonical_pra: PRA-01-SAS-REVIEW-ORCHESTRATOR)
- [ ] aisraf-input-reader (canonical_pra: PRA-02-INPUT-READER)
- [ ] aisraf-dfd-extractor (canonical_pras: [PRA-03-DFD-EXTRACTOR, PRA-04-LEGEND-NORMALIZER]) — Build Package 06 founder decision Q1
- [ ] aisraf-review-table-builder (canonical_pra: PRA-05-REVIEW-TABLE-BUILDER)
- [ ] aisraf-blueprint-questioner (canonical_pra: PRA-06-BLUEPRINT-QUESTIONER)
- [ ] aisraf-finding-recommender (canonical_pra: PRA-07-FINDING-RECOMMENDER)
- [ ] aisraf-handoff-qa-scorer (canonical_pra: PRA-08-HANDOFF-QA-SCORER)

## 6. Reverse Coverage (every catalog has at least one consumer)

Every controlled-vocabulary YAML catalog must be referenced by at least one prompt, skill, PRA, or adapter consumer entry. The cross-cutting catalogs are referenced by all 8 PRAs and all 7 adapters.

- [ ] component-type-catalog
- [ ] component-role-catalog
- [ ] component-evidence-rule-catalog
- [ ] interaction-type-catalog
- [ ] flow-direction-catalog
- [ ] flow-evidence-rule-catalog
- [ ] boundary-type-catalog
- [ ] boundary-crossing-rule-catalog
- [ ] trust-zone-catalog
- [ ] authentication-catalog
- [ ] authorization-catalog
- [ ] identity-evidence-rule-catalog
- [ ] data-class-catalog
- [ ] transport-protection-catalog
- [ ] at-rest-protection-catalog
- [ ] confidence-level-catalog (cross-cutting; appears in all 8 PRAs and all 7 adapters)
- [ ] security-stack-marker-catalog
- [ ] control-signal-catalog
- [ ] proof-vs-signal-rule-catalog (global; appears in all 8 PRAs and all 7 adapters)
- [ ] finding-category-catalog
- [ ] severity-catalog
- [ ] recommendation-type-catalog
- [ ] ai-action-level-catalog
- [ ] review-status-catalog

## 7. Future Blueprint Consumption (status: future_only)

- [ ] `future_blueprint_consumption_notes:` is `status: future_only`.
- [ ] `blueprint_identifiers_recorded: false`.
- [ ] No BP-* identifier appears anywhere in `catalog-registry.yaml` or in any of the 24 catalog files.
- [ ] `expected_blueprint_inputs:` lists catalog IDs only (no blueprint IDs).

## 8. Known Upstream Drift Recording

- [ ] `catalog-registry.yaml#compatibility_notes.known_upstream_drift` is present.
- [ ] `known_upstream_drift: true`.
- [ ] `source_file: prototype-agents/prototype-agent-registry.yaml`.
- [ ] `reason:` describes the existing `{{catalog_root}}` reference inside the registry's `rejected_non_schema_variables` list at line 45.
- [ ] `package_07_action: documented only; no upstream edit.`.
- [ ] `recommended_future_fix:` describes the controlled cleanup path in a future package.

## 9. Documented Count Arithmetic Discrepancy

- [ ] `catalog-registry.yaml#compatibility_notes.documented_count_arithmetic_discrepancy` is present.
- [ ] The note records that the founder approval Q7 stated 28 catalogs / 38 total files, but the explicit file list contains 24 catalogs / 33 total files.
- [ ] The registry's headline counts use the actual figures (24, 33), not the founder approval figures.

## 10. Sign-Off

- [ ] All sections above are checked.
- [ ] No prompt, skill, PRA, or adapter file is missing from its consumption map.
- [ ] No catalog is missing from at least one consumer.
- [ ] No upstream registry edit was performed.
- [ ] Build Package 07 catalog consumption mapping is committed only inside `catalogs/catalog-registry.yaml`, this checklist, and `validation/package-07-catalogs-checklist.md`.
