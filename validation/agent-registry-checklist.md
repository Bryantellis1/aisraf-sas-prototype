# Agent Registry Checklist

Package: AISRAF SAS Prototype v0.1.2

Build Package 06 — Prototype agents, PRA specs, and `.agent.md` adapter model.

This checklist validates `prototype-agents/prototype-agent-registry.yaml` against the Build Package 06 contract. It complements `validation/package-06-agents-checklist.md` (acceptance gate) and `validation/prompt-skill-agent-mapping-checklist.md` (prompt-skill-PRA-adapter mapping detail).

## Schema And Identity

- [ ] `schema_version: aisraf_prototype_agent_registry.v0_1_2`.
- [ ] `registry_id: prototype-agent-registry`.
- [ ] `title: AISRAF SAS Prototype Agent Registry`.
- [ ] `package_version: v0.1.2`.
- [ ] `owning_build_package: "06"`.
- [ ] `status: active`.
- [ ] `pra_count: 8`.
- [ ] `adapter_count: 7`.
- [ ] `prompt_count_mapped: 23`.
- [ ] `skill_count_mapped: 26`.

## Scope Block

- [ ] `canonical_pra_root: prototype-agents`.
- [ ] `canonical_adapter_root: .agents`.
- [ ] `pra_specs_are_runtime_agents: false`.
- [ ] `adapters_are_runtime_agents: false`.
- [ ] `adapters_duplicate_full_prompt_or_skill_bodies: false`.
- [ ] `adapters_claim_external_postback: false`.
- [ ] `adapters_claim_runtime_or_cloud_execution: false`.
- [ ] `adapters_claim_release_or_diagram_export: false`.

## Parameter Contract

- [ ] `parameter_contract.required_run_profile_fields` lists exactly the seven authoritative variables: `{{run_id}}`, `{{input_root}}`, `{{expected_root}}`, `{{output_root}}`, `{{mode}}`, `{{postback_execution_status}}`, `{{output_destination_mode}}`.
- [ ] `parameter_contract.rejected_non_schema_variables` lists `{{catalog_root}}`, `{{prompt_root}}`, `{{skill_root}}`, `{{template_root}}`, `{{diagram_root}}`, `{{validation_root}}`.
- [ ] `parameter_contract.output_root_rule` is `every_pra_and_adapter_write_path_must_resolve_under_output_root`.
- [ ] `parameter_contract.schema_authority` is `config/run-profile.schema.yaml`.
- [ ] `parameter_contract.canonical_artefact_paths_are_literal: true`.

## Required Sections

- [ ] `required_pra_sections` has 13 entries that match the PRA template.
- [ ] `required_adapter_sections` has 12 entries that match the adapter contract.

## Forbidden Claims

- [ ] `forbidden_claims` lists every prohibited claim: runtime/cloud, ADK, Vertex/GCP, MCP, Jira, Confluence, Rovo, database, Terraform, release/zip, diagram generation, scoring outside `SK-ACCURACY-SCORE`, hardcoded values, prompt/skill modification, prompt/skill registry modification, baseline modification, full prompt/skill body duplication.

## Placeholder Resolution

- [ ] `placeholder_resolution_notes.placeholder_to_pra_map` resolves every `future_pra_owner` placeholder appearing in `prompts/prompt-registry.yaml` and `skills/skill-registry.yaml` to one or more concrete `PRA-NN-NAME` IDs.
- [ ] No placeholder resolution requires a write to `prompts/` or `skills/` (founder decision Q2).
- [ ] The map covers at minimum: `PRA-RS-REVIEW`, `PRA-INTAKE`, `PRA-DFD-READER`, `PRA-DESIGN-FACT-EXTRACTOR`, `PRA-REVIEW-TABLE-BUILDER`, `PRA-MISSING-FACT-INTERVIEWER`, `PRA-AI-CLASSIFIER`, `PRA-BLUEPRINT-MATCHER`, `PRA-RISK-WRITER`, `PRA-HANDOFF-BUILDER`, `PRA-VALIDATION-NOTE-WRITER`, `PRA-VALIDATION-SCORER`, `PRA-DFD-EXTRACTOR`.

## prototype_agents List

- [ ] `prototype_agents` list length = 8.
- [ ] Each entry contains `pra_id`, `pra_name`, `pra_file`, `status`, `owned_prompts`, `owned_skills`, `output_artifacts`, and `mapped_adapter`.
- [ ] Each `pra_file` path resolves to an existing file under `prototype-agents/`.
- [ ] `PRA-01-SAS-REVIEW-ORCHESTRATOR` has `owned_skills: []`.
- [ ] `PRA-04-LEGEND-NORMALIZER.has_dedicated_adapter` is `false` and `mapped_adapter` is `.agents/aisraf-dfd-extractor.agent.md`.
- [ ] No PRA `output_artifacts` entry resolves outside `{{output_root}}` (or `{{output_root}}/dfd/` for DFD subskill outputs).

## adapters List

- [ ] `adapters` list length = 7.
- [ ] Each entry contains `adapter_id`, `display_name`, `adapter_file`, `wraps_pras`, `user_invocable`, `tools_allowed`, `handoffs`.
- [ ] Each `adapter_file` path resolves to an existing file under `.agents/`.
- [ ] Every `wraps_pras` value names a `pra_id` from `prototype_agents`.
- [ ] `aisraf-dfd-extractor.wraps_pras` contains both `PRA-03-DFD-EXTRACTOR` and `PRA-04-LEGEND-NORMALIZER`.
- [ ] Every `tools_allowed` value is `[read, search, edit]`.
- [ ] Every `user_invocable` value is `true`.
- [ ] No adapter pins a Copilot Chat model.

## prompt_skill_agent_crosswalk

- [ ] `rs_family` lists all 14 RS prompt entries (PR-RS-00..PR-RS-13).
- [ ] `dfd_family` lists all 9 DFD prompt entries (PR-DFD-02..PR-DFD-10).
- [ ] Total prompt entries = 23 (counted as the 23 mapped prompts).
- [ ] Every entry contains `prompt_id`, `prompt_file`, `skills`, `pra`, `adapter`.
- [ ] Sum of `skills` lengths = 26 across the crosswalk (matches Build Package 05 total).
- [ ] PR-RS-00 has `skills: []` and `pra: PRA-01-SAS-REVIEW-ORCHESTRATOR`.
- [ ] PR-RS-03 has `pra: PRA-04-LEGEND-NORMALIZER` and `adapter: .agents/aisraf-dfd-extractor.agent.md`.
- [ ] PR-RS-04 (`04-design-fact-extract.prompt.md`) maps to `SK-COMPONENT-EXTRACT` and `SK-FLOW-EXTRACT`, both owned by PRA-03.
- [ ] PR-RS-05 (`05-boundary-stack-detect.prompt.md`) maps to `SK-BOUNDARY-CROSSING-DETECT` and `SK-SECURITY-STACK-ASSESS`, both owned by PRA-05.
- [ ] PR-RS-07 (`07-missing-fact-question-generate.prompt.md`) maps to `SK-MISSING-FACT-IDENTIFY` and `SK-TARGETED-QUESTION-GENERATE`, both owned by PRA-06.
- [ ] PR-RS-10 (`10-finding-recommendation-write.prompt.md`) maps to `SK-FINDING-CLASSIFY` and `SK-RECOMMENDATION-WRITE`, both owned by PRA-07.
- [ ] Every DFD-family entry maps to exactly one `SK-DFD-0[1-9]-*` skill and `pra: PRA-03-DFD-EXTRACTOR`.
- [ ] Every entry's `prompt_file` and each `skills` path resolves to an existing file.

## planned_future_adk_alignment

- [ ] `status: future_only`.
- [ ] `runtime_deployed: false`.
- [ ] `adk_deployed: false`.
- [ ] `cloud_resources_created: false`.
- [ ] `database_jobs_created: false`.
- [ ] `mcp_execution_available: false`.
- [ ] `jira_confluence_execution_available: false`.
- [ ] `pra_intent` enumerates all 8 PRAs.
- [ ] No claim of current ADK, MCP, Jira/Confluence, runtime, cloud, or database is recorded anywhere in the registry.
