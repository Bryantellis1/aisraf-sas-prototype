# Blueprint Catalog Consumption Checklist

Confirms that every BP-*.yaml's `catalog_dependencies` matches the registry's `blueprint_catalog_map`, that every catalog ID resolves to a Build Package 07 controlled catalog, and that no blueprint introduces new vocabulary.

## Reference

- Catalog inventory truth: `catalogs/catalog-registry.yaml` (24 controlled-vocabulary YAMLs across 7 families).
- Per-blueprint catalog map: `blueprints/blueprint-registry.yaml#blueprint_catalog_map`.

## Mandatory Catalogs (every blueprint)

- [ ] Every BP-*.yaml lists `confidence-level-catalog` in `catalog_dependencies`.
- [ ] Every BP-*.yaml lists `proof-vs-signal-rule-catalog` in `catalog_dependencies`.
- [ ] Every BP-*.yaml lists `interaction-type-catalog` in `catalog_dependencies`.

## Catalog ID Validity

- [ ] Every `catalog_id` cited in any `catalog_dependencies` block exists in `catalogs/catalog-registry.yaml#catalogs[].catalog_id`.
- [ ] Every `catalog_id` cited under `material_missing_facts[].catalog_reference` exists in the catalog registry.
- [ ] Every `catalog: catalogs/...` path under `supported_finding_categories[]` and `supported_recommendation_types[]` resolves to an existing catalog file.
- [ ] No `BP-*` introduces a `catalog_id` not present in the catalog registry.
- [ ] No `BP-*` introduces a new controlled value not present in the cited catalog's `entries[]`.

## Per-Blueprint Verification

For each blueprint below, confirm that the `catalog_dependencies` list in the BP-*.yaml is a subset of the `blueprint_catalog_map` entry in the registry, and that the registry list is consistent with the per-blueprint match conditions.

### BP-NON-AI-DATAFLOW-BASELINE
- [ ] interaction-type-catalog
- [ ] flow-direction-catalog
- [ ] flow-evidence-rule-catalog
- [ ] boundary-type-catalog
- [ ] boundary-crossing-rule-catalog
- [ ] trust-zone-catalog
- [ ] authentication-catalog
- [ ] data-class-catalog
- [ ] transport-protection-catalog
- [ ] confidence-level-catalog
- [ ] ai-action-level-catalog
- [ ] finding-category-catalog
- [ ] recommendation-type-catalog
- [ ] proof-vs-signal-rule-catalog

### BP-RAG-RETRIEVAL
- [ ] interaction-type-catalog
- [ ] flow-direction-catalog
- [ ] flow-evidence-rule-catalog
- [ ] boundary-type-catalog
- [ ] boundary-crossing-rule-catalog
- [ ] trust-zone-catalog
- [ ] authentication-catalog
- [ ] authorization-catalog
- [ ] data-class-catalog
- [ ] transport-protection-catalog
- [ ] at-rest-protection-catalog
- [ ] confidence-level-catalog
- [ ] ai-action-level-catalog
- [ ] finding-category-catalog
- [ ] recommendation-type-catalog
- [ ] proof-vs-signal-rule-catalog

### BP-MODEL-ENDPOINT-CALL
- [ ] interaction-type-catalog
- [ ] flow-direction-catalog
- [ ] flow-evidence-rule-catalog
- [ ] boundary-type-catalog
- [ ] boundary-crossing-rule-catalog
- [ ] trust-zone-catalog
- [ ] authentication-catalog
- [ ] authorization-catalog
- [ ] data-class-catalog
- [ ] transport-protection-catalog
- [ ] confidence-level-catalog
- [ ] ai-action-level-catalog
- [ ] finding-category-catalog
- [ ] recommendation-type-catalog
- [ ] proof-vs-signal-rule-catalog

### BP-TOOL-USING-AGENT
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
- [ ] confidence-level-catalog
- [ ] ai-action-level-catalog
- [ ] finding-category-catalog
- [ ] recommendation-type-catalog
- [ ] proof-vs-signal-rule-catalog

### BP-API-WRITEBACK
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
- [ ] confidence-level-catalog
- [ ] security-stack-marker-catalog
- [ ] control-signal-catalog
- [ ] ai-action-level-catalog
- [ ] finding-category-catalog
- [ ] recommendation-type-catalog
- [ ] proof-vs-signal-rule-catalog

### BP-HITL-APPROVAL
- [ ] interaction-type-catalog
- [ ] flow-direction-catalog
- [ ] flow-evidence-rule-catalog
- [ ] boundary-type-catalog
- [ ] trust-zone-catalog
- [ ] authentication-catalog
- [ ] authorization-catalog
- [ ] identity-evidence-rule-catalog
- [ ] confidence-level-catalog
- [ ] ai-action-level-catalog
- [ ] finding-category-catalog
- [ ] recommendation-type-catalog
- [ ] proof-vs-signal-rule-catalog

### BP-AGENT-TO-AGENT
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
- [ ] confidence-level-catalog
- [ ] ai-action-level-catalog
- [ ] finding-category-catalog
- [ ] recommendation-type-catalog
- [ ] proof-vs-signal-rule-catalog

### BP-AI-WORKFLOW
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
- [ ] confidence-level-catalog
- [ ] security-stack-marker-catalog
- [ ] control-signal-catalog
- [ ] ai-action-level-catalog
- [ ] finding-category-catalog
- [ ] recommendation-type-catalog
- [ ] review-status-catalog
- [ ] proof-vs-signal-rule-catalog

### BP-AI-SAAS-INTEGRATION
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
- [ ] confidence-level-catalog
- [ ] security-stack-marker-catalog
- [ ] control-signal-catalog
- [ ] ai-action-level-catalog
- [ ] finding-category-catalog
- [ ] recommendation-type-catalog
- [ ] proof-vs-signal-rule-catalog

## Catalog Surface Untouched

- [ ] `catalogs/catalog-registry.yaml#catalog_count` is still 24.
- [ ] `catalogs/catalog-registry.yaml#total_files_under_catalogs` is still 33.
- [ ] No catalog YAML in `catalogs/` was modified during Build Package 08.
- [ ] No catalog YAML in `catalogs/` was added or removed during Build Package 08.
- [ ] `catalogs/catalog-registry.yaml#future_blueprint_consumption_notes.status` is still `future_only` (Package 07 did not pre-record blueprint identifiers; this remains true after Package 08 since Package 08 records its consumer maps in its own registry).

## Sealed Skill / PRA / Adapter / Prompt Surfaces

- [ ] `skills/skill-registry.yaml` unchanged. SK-REVIEW-BLUEPRINT-MATCH minimal placeholder catalog list (`trust-zone-catalog` plus `confidence-level-catalog`) is preserved verbatim; the divergence from the per-blueprint catalog dependencies is recorded in `blueprints/blueprint-registry.yaml#compatibility_notes.upstream_blueprint_match_skill_placeholder`.
- [ ] `prompts/prompt-registry.yaml` unchanged.
- [ ] `prototype-agents/prototype-agent-registry.yaml` unchanged.
- [ ] `.agents/*.agent.md` files unchanged.

## Material Missing Facts Reference Catalogs

- [ ] Every `material_missing_facts[].catalog_reference` value resolves to an existing `catalog_id` in `catalogs/catalog-registry.yaml`.
- [ ] No `material_missing_facts` entry invents a catalog or controlled value.
