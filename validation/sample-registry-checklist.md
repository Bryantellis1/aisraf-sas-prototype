# Sample Registry Checklist

Authored by: BUILD-AG-10-SAMPLES-R1.

Scope: confirms `samples/sample-registry.yaml` shape and pin alignment for AISRAF SAS Prototype v0.1.2 Build Package 10.

## 1. Required Top-Level Fields

| # | Field | Expected | Status |
|---|---|---|---|
| 1 | `registry_id` | `aisraf-sample-registry` | PASS |
| 2 | `schema_version` | `aisraf_sample_registry.v0_1_2` | PASS |
| 3 | `package_version` | `v0.1.2` | PASS |
| 4 | `title` | `AISRAF SAS Sample Registry` | PASS |
| 5 | `owning_build_package` | `Build Package 10` | PASS |
| 6 | `status` | `active` | PASS |
| 7 | `sample_count_active` | `1` | PASS |
| 8 | `sample_count_deferred` | `7` | PASS |
| 9 | `sample_class_counts` | `gold_standard_scored: 1`; `targeted_behavior_baseline: 0`; `exploratory: 0` | PASS |
| 10 | `unknown_value` | `unknown` | PASS |
| 11 | `purpose` | non-empty narrative scoped to test-fixture role only | PASS |
| 12 | `parameter_contract.required_run_profile_fields` | the seven approved placeholders only | PASS |
| 13 | `parameter_contract.rejected_non_schema_variables` | the six rejected variables listed | PASS |
| 14 | `prohibited_claims` | full list including no real PII / PAN / SSN / PHI / secrets / credentials / production endpoints | PASS |
| 15 | `runtime_and_external_execution` | six false flags (`runtime_deployed`, `adk_deployed`, `cloud_resources_created`, `database_jobs_created`, `mcp_execution_available`, `jira_confluence_execution_available`) | PASS |
| 16 | `founder_decisions` | Q1–Q8 recorded | PASS |
| 17 | `samples` | list with exactly one active entry (`sample-001-dfd-crop`) | PASS |
| 18 | `planned_or_deferred_samples` | list with seven entries (`sample-002-*` through `sample-008-*`) | PASS |
| 19 | `compatibility_notes` | sealed upstream registries listed; `c4p_under_dc_c5p_raw_pattern` documented | PASS |

## 2. Required Sample Entry Fields

For each entry under `samples` and `planned_or_deferred_samples`:

| # | Field | Expected | Status |
|---|---|---|---|
| 20 | `sample_id` | matches folder name when status is `active`; matches reserved id when `planned`/`deferred` | PASS |
| 21 | `sample_class` | one of `gold_standard_scored`, `targeted_behavior_baseline`, `exploratory` | PASS |
| 22 | `status` | `active` for sample-001; `planned` for sample-002 through sample-008 | PASS |
| 23 | `scenario_summary` | non-empty narrative for active entry | PASS |
| 24 | `inputs[]` | listed only for active entry; resolves to existing files | PASS |
| 25 | `expected_baselines.rs[]` | 17 entries for sample-001; resolves to existing files | PASS |
| 26 | `expected_baselines.dfd[]` | 9 entries for sample-001; resolves to existing files | PASS |
| 27 | `consumers.prompts[]` | every entry resolves to an existing prompt card | PASS |
| 28 | `consumers.skills[]` | every entry resolves to an existing skill contract | PASS |
| 29 | `consumers.pras[]` | every entry resolves to an existing PRA spec | PASS |
| 30 | `consumers.adapters[]` | every entry resolves to an existing `.agent.md` adapter | PASS |
| 31 | `consumers.catalogs_referenced[]` | every entry resolves to an existing catalog YAML | PASS |
| 32 | `consumers.blueprints_referenced[]` | every entry resolves to an existing blueprint YAML | PASS |
| 33 | `mirrors_templates.output_27_minus_run_log[]` | 26 templates listed; `output-00-run-log-template.md` is in `run_log_template_referenced_only_as_future_run_support` | PASS |
| 34 | `blueprint_dispositions_expected[]` | 4 dispositions: BP-AI-SAAS-INTEGRATION matched, BP-MODEL-ENDPOINT-CALL candidate, BP-HITL-APPROVAL matched, BP-API-WRITEBACK candidate | PASS |
| 35 | `ai_action_level_expected.level` | `AAL-L3` | PASS |
| 36 | `ai_action_level_expected.confidence` | `medium` | PASS |
| 37 | `critical_miss_categories[]` | non-empty list aligned with sample README § 7 | PASS |
| 38 | `runtime_and_external_execution` | six false flags | PASS |
| 39 | `source_reference.derivation_mode` | `rebuilt_for_v0_1_2_with_new_application_scenario` | PASS |
| 40 | `source_reference.copied_verbatim` | `false` | PASS |
| 41 | `version_notes` | non-empty | PASS |

## 3. Cross-References Resolve

| # | Check | Status |
|---|---|---|
| 42 | Every prompt path under `consumers.prompts` exists at `prompts/...`. | PASS |
| 43 | Every skill path under `consumers.skills` exists at `skills/...`. | PASS |
| 44 | Every PRA path exists at `prototype-agents/...`. | PASS |
| 45 | Every adapter path exists at `.agents/...`. | PASS |
| 46 | Every catalog path under `consumers.catalogs_referenced` is registered in `catalogs/catalog-registry.yaml#catalogs[]`. | PASS |
| 47 | Every blueprint path under `consumers.blueprints_referenced` is registered in `blueprints/blueprint-registry.yaml#blueprints[]`. | PASS |
| 48 | Every template path under `mirrors_templates` exists at `templates/output/...`. | PASS |
| 49 | Every input path under `samples[].inputs[]` exists at `samples/sample-001-dfd-crop/inputs/...`. | PASS |
| 50 | Every expected-baseline path exists at `samples/sample-001-dfd-crop/expected/...`. | PASS |

## 4. Sealed Upstream Registries

| # | Check | Status |
|---|---|---|
| 51 | `compatibility_notes.upstream_registries_sealed_for_build_package_10` lists `prompts/prompt-registry.yaml`, `skills/skill-registry.yaml`, `prototype-agents/prototype-agent-registry.yaml`, `catalogs/catalog-registry.yaml`, `blueprints/blueprint-registry.yaml`, and `templates/template-registry.yaml`. | PASS |
| 52 | None of those upstream files are modified by Build Package 10. | PASS |

## 5. Deferred Sample Discipline

| # | Check | Status |
|---|---|---|
| 53 | No folder exists for sample-002 through sample-008. | PASS |
| 54 | No file exists for sample-002 through sample-008. | PASS |
| 55 | Each deferred entry carries `target_behavior` and `primary_chain_lane` and `deferred_to: future governed Build Package increment after Build Package 10`. | PASS |

## 6. Acceptance Verdict

`samples/sample-registry.yaml` is **ready for human review** when every row above reads PASS.
