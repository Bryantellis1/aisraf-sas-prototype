# Catalog Registry Checklist

Package: AISRAF SAS Prototype v0.1.2
Build Package: 07
Subject: `catalogs/catalog-registry.yaml`
Status: active

This checklist validates the Build Package 07 catalog registry. It confirms that the registry indexes every catalog file, records all required fields, captures consumer maps without modifying upstream registries, and documents known compatibility notes.

## 1. Top-Level Fields

- [ ] `registry_id: aisraf-catalog-registry`
- [ ] `schema_version: aisraf_catalog_registry.v0_1_2`
- [ ] `package_version: v0.1.2`
- [ ] `owning_build_package: Build Package 07`
- [ ] `status: active`
- [ ] `catalog_count: 24`
- [ ] `catalog_family_count: 7`
- [ ] `readme_count: 8`
- [ ] `total_files_under_catalogs: 33`
- [ ] `unknown_value: unknown`

## 2. Global Evidence Rules

- [ ] `global_evidence_rules:` includes rules covering: visible-label-not-proof; cloud-label-not-runtime; authn-not-authz; transit-not-at-rest; marker-not-effectiveness; unknown-stays-unknown; component-marker-no-propagation; future-not-current.

## 3. Prohibited Claims

- [ ] `prohibited_claims:` includes at least: runtime_or_cloud_execution; mcp_jira_confluence_rovo_execution; adk_or_vertex_or_gcp_execution; database_or_terraform_execution; implementation_proof_from_marker_alone; approved_security_stack_from_diamond_alone; authorization_from_authentication_marker_alone; blueprint_match_from_catalog_entry_alone; severity_or_scoring_outcome_from_catalog_entry_alone.

## 4. Cross-Cutting Catalogs

- [ ] `cross_cutting_catalogs:` includes `proof-vs-signal-rule-catalog` with `family_id: security-stacks`, path `catalogs/security-stacks/proof-vs-signal-rule-catalog.yaml`, `flag: global_rule`, and `referenced_by_every_catalog_in_evidence_rules: true`.
- [ ] `cross_cutting_catalogs:` includes `confidence-level-catalog` with `family_id: data-protection`, path `catalogs/data-protection/confidence-level-catalog.yaml`, `flag: cross_cutting_catalog`, `primary_family: data-protection`, and `applies_to:` covering DFD extraction, annotation resolution, component classification, boundary classification, finding confidence, accuracy scoring.

## 5. Catalog Families

- [ ] Exactly 7 entries in `catalog_families:`: `components`, `interactions`, `boundaries`, `identity-access`, `data-protection`, `security-stacks`, `review`.
- [ ] Each family entry includes: `family_id`, `title`, `path`, `purpose`, `catalog_files`, `catalog_file_count`.
- [ ] `catalog_file_count` per family: components=3, interactions=3, boundaries=3, identity-access=3, data-protection=4, security-stacks=3, review=5. Sum = 24.

## 6. Catalogs Inventory

- [ ] `catalogs:` lists all 24 controlled-vocabulary YAML files exactly once.
- [ ] Every entry has `catalog_id`, `family_id`, `path`, `purpose`.
- [ ] The cross-cutting flags (`cross_cutting_catalog: true`, `global_rule: true`) are recorded on the matching entries.

## 7. Prompt Consumption Map

- [ ] `prompt_consumption_map:` covers all 23 Build Package 04 prompts: PR-RS-00 through PR-RS-13 (14 RS prompts) and PR-DFD-02 through PR-DFD-10 (9 DFD prompts).
- [ ] Each prompt entry includes `prompt_path` and `catalogs` (which may be an empty list for PR-RS-00 because the full-chain wrapper is `status: planned`).
- [ ] No prompt entry references a Build Package 08 blueprint identifier.

## 8. Skill Consumption Map

- [ ] `skill_consumption_map:` covers all 26 Build Package 05 skills: 17 RS skills (SK-INPUT-PACKAGE-READ, SK-DFD-VISUAL-READ, SK-LEGEND-NORMALIZE, SK-COMPONENT-EXTRACT, SK-FLOW-EXTRACT, SK-BOUNDARY-CROSSING-DETECT, SK-SECURITY-STACK-ASSESS, SK-DATA-FLOW-TABLE-BUILD, SK-MISSING-FACT-IDENTIFY, SK-AI-ACTION-LEVEL-CLASSIFY, SK-REVIEW-BLUEPRINT-MATCH, SK-TARGETED-QUESTION-GENERATE, SK-FINDING-CLASSIFY, SK-RECOMMENDATION-WRITE, SK-HANDOFF-PACK-BUILD, SK-VALIDATION-NOTE-WRITE, SK-ACCURACY-SCORE) plus 9 DFD subskills (SK-DFD-01 through SK-DFD-09).
- [ ] Each skill entry includes `skill_path` and `catalogs`.

## 9. PRA Consumption Map

- [ ] `pra_consumption_map:` covers all 8 PRAs: PRA-01 through PRA-08.
- [ ] Each PRA entry includes `pra_path` and `catalogs`.

## 10. Adapter Consumption Map

- [ ] `adapter_consumption_map:` covers all 7 adapters: aisraf-orchestrator, aisraf-input-reader, aisraf-dfd-extractor, aisraf-review-table-builder, aisraf-blueprint-questioner, aisraf-finding-recommender, aisraf-handoff-qa-scorer.
- [ ] `aisraf-dfd-extractor` records `canonical_pras: [PRA-03-DFD-EXTRACTOR, PRA-04-LEGEND-NORMALIZER]` per Build Package 06 founder decision Q1.
- [ ] Each adapter entry includes `adapter_path`, `canonical_pra` (or `canonical_pras`), `catalogs`.

## 11. Future Blueprint Consumption Notes

- [ ] `future_blueprint_consumption_notes:` is `status: future_only`.
- [ ] `blueprint_consumers: deferred_to_build_package_08`.
- [ ] `blueprint_identifiers_recorded: false`.
- [ ] No BP-* identifier appears anywhere in the registry.

## 12. Sealed Upstream Registries

- [ ] `sealed_upstream_registries:` lists `prompts/prompt-registry.yaml`, `skills/skill-registry.yaml`, `prototype-agents/prototype-agent-registry.yaml`.
- [ ] The policy field states that Build Package 07 must not modify any of those files.
- [ ] All consumer mapping is recorded only in this catalog-registry.yaml and in `validation/catalog-consumption-checklist.md`.

## 13. Compatibility Notes

- [ ] `compatibility_notes.documented_count_arithmetic_discrepancy:` documents the founder approval Q7 figures (28 catalogs / 38 total files) versus the actual figures (24 catalogs / 33 total files). The recommended_future_fix records that the founder confirms inventory at next governed update.
- [ ] `compatibility_notes.known_upstream_drift:` records `known_upstream_drift: true`, `source_file: prototype-agents/prototype-agent-registry.yaml`, the reason (the registry's `rejected_non_schema_variables` list at line 45 names `{{catalog_root}}`), `package_07_action: documented only; no upstream edit.`, and the recommended_future_fix.

## 14. Version Notes

- [ ] `version_notes:` records the initial Build Package 07 release and reiterates that no upstream registry was modified.

## Sign-Off

- [ ] All sections above are checked.
- [ ] No upstream registry modification is detected.
- [ ] Registry counts match the actual catalogs and files in `catalogs/`.
