# Blueprint Registry Checklist

Confirms that `blueprints/blueprint-registry.yaml` is consistent with the controlled blueprint set, the four-state match model, the sealed upstream registries, and the founder decisions for Build Package 08.

## Top-Level Fields

- [ ] `registry_id: aisraf-blueprint-registry`
- [ ] `schema_version: aisraf_blueprint_registry.v0_1_2`
- [ ] `package_version: v0.1.2`
- [ ] `owning_build_package: Build Package 08`
- [ ] `status: active`
- [ ] `blueprint_count: 9`
- [ ] `blueprint_category_count: 2`
- [ ] `total_files_under_blueprints: 14`
- [ ] `unknown_value: unknown`

## Match States (founder Q1)

- [ ] `blueprint_match_states` lists exactly four values, in order:
  - matched
  - candidate
  - no_match
  - unknown

## Prohibited Claims

The registry's `prohibited_claims` list must contain at least:
- [ ] runtime_or_cloud_execution
- [ ] mcp_jira_confluence_rovo_execution
- [ ] adk_or_vertex_or_gcp_execution
- [ ] database_or_terraform_execution
- [ ] implementation_proof_from_blueprint_match
- [ ] severity_computed_inside_blueprint
- [ ] ai_action_level_computed_inside_blueprint
- [ ] score_computed_inside_blueprint
- [ ] finding_prose_inside_blueprint
- [ ] recommendation_prose_inside_blueprint
- [ ] handoff_prose_inside_blueprint
- [ ] validation_ticket_prose_inside_blueprint
- [ ] owner_routing_inside_blueprint
- [ ] new_catalog_value_introduced_inside_blueprint
- [ ] approved_security_stack_from_blueprint_match

## Runtime / External Execution (founder Q8)

`runtime_and_external_execution` block must contain:
- [ ] `runtime_deployed: false`
- [ ] `adk_deployed: false`
- [ ] `cloud_resources_created: false`
- [ ] `database_jobs_created: false`
- [ ] `mcp_execution_available: false`
- [ ] `jira_confluence_execution_available: false`

## Sealed Upstream Registries (founder Q4)

`sealed_upstream_registries` lists exactly:
- [ ] `prompts/prompt-registry.yaml`
- [ ] `skills/skill-registry.yaml`
- [ ] `prototype-agents/prototype-agent-registry.yaml`
- [ ] `catalogs/catalog-registry.yaml`

`sealed_upstream_policy` is present and states that Package 08 records consumer mapping in this registry and the validation checklists only.

## Human Review Gate Policy

`human_review_gate_policy` is present with at minimum:
- [ ] `every_blueprint_match_is_a_review_hypothesis: true`
- [ ] `selection_of_match_state_requires_human_review: true`
- [ ] `ai_action_level_selection_remains_with_skills_and_human_review: true`
- [ ] `finding_severity_selection_remains_with_skills_and_human_review: true`
- [ ] `final_disposition_remains_with_skills_and_human_review: true`

## Blueprint Categories (founder Q3 / Q7)

`blueprint_categories` lists exactly two entries:
- [ ] `platform-independent` at `blueprints/platform-independent/` with `blueprint_count: 8`
- [ ] `cloud-patterns` at `blueprints/cloud-patterns/` with `blueprint_count: 1`

## Blueprint Inventory

`blueprints` lists exactly 9 entries. Each entry has `blueprint_id`, `blueprint_name`, `category`, `path`, `status: active`, `purpose_summary`, `primary_interaction_types`. All blueprint paths resolve to existing files:

- [ ] `BP-NON-AI-DATAFLOW-BASELINE` -> `blueprints/platform-independent/BP-NON-AI-DATAFLOW-BASELINE.yaml`
- [ ] `BP-RAG-RETRIEVAL` -> `blueprints/platform-independent/BP-RAG-RETRIEVAL.yaml`
- [ ] `BP-MODEL-ENDPOINT-CALL` -> `blueprints/platform-independent/BP-MODEL-ENDPOINT-CALL.yaml`
- [ ] `BP-TOOL-USING-AGENT` -> `blueprints/platform-independent/BP-TOOL-USING-AGENT.yaml`
- [ ] `BP-API-WRITEBACK` -> `blueprints/platform-independent/BP-API-WRITEBACK.yaml`
- [ ] `BP-HITL-APPROVAL` -> `blueprints/platform-independent/BP-HITL-APPROVAL.yaml`
- [ ] `BP-AGENT-TO-AGENT` -> `blueprints/platform-independent/BP-AGENT-TO-AGENT.yaml`
- [ ] `BP-AI-WORKFLOW` -> `blueprints/platform-independent/BP-AI-WORKFLOW.yaml`
- [ ] `BP-AI-SAAS-INTEGRATION` -> `blueprints/cloud-patterns/BP-AI-SAAS-INTEGRATION.yaml`

## Consumer Map Coverage

`blueprint_catalog_map`, `blueprint_skill_map`, `blueprint_pra_map`, `blueprint_adapter_map`, `blueprint_prompt_map` each contain exactly 9 keys, one per BP-*.yaml. For each map:

- [ ] No reference points to a non-existing catalog, skill, PRA, adapter, or prompt.
- [ ] Every map entry's IDs match the canonical paths in the upstream registries.

## Skill Reference Sanity

For every blueprint:
- [ ] `skills/rs/SK-REVIEW-BLUEPRINT-MATCH.md` is referenced.
- [ ] `skills/rs/SK-TARGETED-QUESTION-GENERATE.md` is referenced.
- [ ] `skills/rs/SK-FINDING-CLASSIFY.md` is referenced.
- [ ] `skills/rs/SK-RECOMMENDATION-WRITE.md` is referenced.
- [ ] `skills/rs/SK-AI-ACTION-LEVEL-CLASSIFY.md` is referenced when the blueprint applies above AAL-L0.

## PRA Reference Sanity

For every blueprint:
- [ ] `prototype-agents/PRA-06-BLUEPRINT-QUESTIONER.md` is referenced.
- [ ] `prototype-agents/PRA-07-FINDING-RECOMMENDER.md` is referenced.
- [ ] `prototype-agents/PRA-08-HANDOFF-QA-SCORER.md` is referenced for blueprints that surface validation-ticket dependencies (BP-API-WRITEBACK, BP-AGENT-TO-AGENT, BP-AI-WORKFLOW, BP-AI-SAAS-INTEGRATION).

## Adapter Reference Sanity

For every blueprint:
- [ ] `.agents/aisraf-blueprint-questioner.agent.md` is referenced.
- [ ] `.agents/aisraf-finding-recommender.agent.md` is referenced.
- [ ] `.agents/aisraf-handoff-qa-scorer.agent.md` is referenced when the blueprint maps to PRA-08.

## Prompt Reference Sanity

For every blueprint:
- [ ] `prompts/rs/09-blueprint-match.prompt.md` is referenced.
- [ ] `prompts/rs/07-missing-fact-question-generate.prompt.md` is referenced.

## Compatibility Notes

`compatibility_notes` documents the two known reconciliations without editing upstream files:
- [ ] `upstream_blueprint_match_skill_placeholder` block present.
- [ ] `pra_06_catalog_alignment` block present.

## Future ADK Block

`planned_future_adk_alignment` block present with `status: future_only` and the six false flags from founder Q8.

## Source Reference and Version Notes

- [ ] `source_reference.v0_01_artifact` points to `blueprints/blueprint-index.yaml`.
- [ ] `source_reference.derivation_mode: restructured_and_improved`.
- [ ] `version_notes` records the initial Build Package 08 release.
