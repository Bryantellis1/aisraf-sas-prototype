# Prompt Registry Checklist

Package: AISRAF SAS Prototype v0.1.2
Owning Build Package: Build Package 04.
Registry under check: [prompts/prompt-registry.yaml](../prompts/prompt-registry.yaml)
Schema authority: [config/run-profile.schema.yaml](../config/run-profile.schema.yaml)
No-drift authority: [validation/no-drift-rules.md](no-drift-rules.md)

This checklist focuses on the prompt registry itself. The broader Build Package 04 acceptance gate is [validation/package-04-prompts-checklist.md](package-04-prompts-checklist.md).

## 1. Registry presence and shape

| # | Check | Status | Evidence |
|---|---|---|---|
| 1.1 | [prompts/prompt-registry.yaml](../prompts/prompt-registry.yaml) exists | PASS | file present |
| 1.2 | Top-level fields present: `schema_version`, `registry_id`, `package_version`, `owning_build_package`, `status`, `prompt_count`, `prompt_family_counts`, `prompt_families`, `parameter_contract`, `required_prompt_sections`, `forbidden_claims`, `placeholder_conventions`, `compatibility_notes`, `prompts` | PASS | top-of-file structure |
| 1.3 | `schema_version: aisraf_prompt_registry.v0_1_2` | PASS | top of file |
| 1.4 | `package_version: v0.1.2` | PASS | top of file |
| 1.5 | `owning_build_package: "04"` | PASS | top of file |
| 1.6 | `status: active` | PASS | top of file |

## 2. Count parity

| # | Check | Status | Evidence |
|---|---|---|---|
| 2.1 | `prompt_count: 23` | PASS | top of file |
| 2.2 | `prompt_family_counts.rs: 14` | PASS | top of file |
| 2.3 | `prompt_family_counts.dfd: 9` | PASS | top of file |
| 2.4 | Number of `prompts:` entries equals 23 | PASS | 14 RS + 9 DFD entries |
| 2.5 | Number of files matching `prompts/rs/*.prompt.md` equals 14 | PASS | filesystem inventory |
| 2.6 | Number of files matching `prompts/dfd/*.prompt.md` equals 9 | PASS | filesystem inventory |
| 2.7 | Registry RS-family entries equal RS files on disk | PASS | inventory match |
| 2.8 | Registry DFD-family entries equal DFD files on disk | PASS | inventory match |

## 3. Uniqueness

| # | Check | Status | Evidence |
|---|---|---|---|
| 3.1 | Every `prompt_id` value is unique across all 23 entries | PASS | PR-RS-00..13 (14 unique) + PR-DFD-02..10 (9 unique) |
| 3.2 | Every `prompt_file` value is unique across all 23 entries | PASS | each entry points to a distinct file |
| 3.3 | No two entries share the same `output_artifact` filename for the same review/dfd step | PASS | per-step output paths are distinct |

## 4. File existence

| # | Check | Status | Evidence |
|---|---|---|---|
| 4.1 | Every `prompt_file` resolves to an existing file on disk | PASS | the 14 RS + 9 DFD `*.prompt.md` files exist |
| 4.2 | No registry entry points to a missing file | PASS | inventory match |
| 4.3 | No file under `prompts/rs/` or `prompts/dfd/` is missing from the registry (other than `README.md`) | PASS | inventory match |

## 5. Required entry fields

Each entry must include: `prompt_id`, `prompt_file`, `prompt_family`, `review_step` (RS) or `dfd_step` (DFD), `status`, `future_skill_id`, `future_pra_owner`, `input_dependencies`, `output_artifact`, `uses_run_profile_fields`, `stop_conditions_ref`, `direct_test_supported`, `notes`.

| # | Check | Status | Evidence |
|---|---|---|---|
| 5.1 | Every entry contains all required fields | PASS | uniform entry shape |
| 5.2 | Every RS entry has `review_step` and no `dfd_step` | PASS | enforced |
| 5.3 | Every DFD entry has `dfd_step` and no `review_step` | PASS | enforced |
| 5.4 | Every entry's `uses_run_profile_fields` lists exactly the seven required v0.1.2 variables | PASS | each entry lists `{{run_id}}`, `{{input_root}}`, `{{expected_root}}`, `{{output_root}}`, `{{mode}}`, `{{postback_execution_status}}`, `{{output_destination_mode}}` |
| 5.5 | Every entry's `direct_test_supported: true` | PASS | enforced |
| 5.6 | `stop_conditions_ref` points to the prompt file's "7. Stop Conditions" section | PASS | section anchor format `<file>#7-stop-conditions` |

## 6. Placeholder discipline

| # | Check | Status | Evidence |
|---|---|---|---|
| 6.1 | Every `future_skill_id` includes the suffix `(planned; defined in Build Package 05)` | PASS | enforced across 23 entries |
| 6.2 | Every `future_pra_owner` includes the suffix `(planned; defined in Build Package 06)` | PASS | enforced across 23 entries |
| 6.3 | `placeholder_conventions` block in the registry documents the suffixes and notes that they are non-binding | PASS | top-of-file |
| 6.4 | No prompt card or registry entry treats a placeholder skill or PRA ID as a hard read | PASS | future-package references in cards are explicitly "not required" |

## 7. Output coherence

| # | Check | Status | Evidence |
|---|---|---|---|
| 7.1 | Every entry's `output_artifact` paths use `{{output_root}}` (or `{{output_root}}/dfd/`) and resolve under `runs/{{run_id}}/` | PASS | enforced across 23 entries |
| 7.2 | Every entry's `output_artifact` matches Section 5 of the corresponding prompt card exactly | PASS | per-prompt audit |
| 7.3 | PR-RS-00 (`output_artifact: []`) writes nothing | PASS | wrapper status |
| 7.4 | PR-RS-07 (`output_artifact`) lists both `{{output_root}}/09-missing-facts.md` and `{{output_root}}/12-targeted-questions.md` | PASS | founder decision Q1 |
| 7.5 | PR-RS-10 (`output_artifact`) lists both `{{output_root}}/13-findings.md` and `{{output_root}}/14-recommendations.md` | PASS | per spec |
| 7.6 | PR-RS-04 (`output_artifact`) lists both `{{output_root}}/04-components.md` and `{{output_root}}/05-flows.md` | PASS | per spec |
| 7.7 | PR-RS-05 (`output_artifact`) lists both `{{output_root}}/06-boundaries.md` and `{{output_root}}/07-security-stack-assessment.md` | PASS | per spec |
| 7.8 | PR-RS-13 (`output_artifact: {{output_root}}/17-accuracy-score.md`) is the only entry whose prompt card produces a `qualitative_score` field | PASS | other prompts use `confidence` only |

## 8. Required-variable coverage

| # | Check | Status | Evidence |
|---|---|---|---|
| 8.1 | `parameter_contract.required_run_profile_fields` lists exactly the seven required v0.1.2 variables | PASS | top of file |
| 8.2 | `parameter_contract.no_hardcoded_values` lists `run_id`, `sample_id`, paths, URLs, `output_destination_mode`, and `postback_execution_status` | PASS | top of file |
| 8.3 | `parameter_contract.output_root_rule: every_write_path_must_resolve_under_output_root` | PASS | top of file |
| 8.4 | `parameter_contract.schema_authority: config/run-profile.schema.yaml` | PASS | top of file |

## 9. Forbidden-claims block

| # | Check | Status | Evidence |
|---|---|---|---|
| 9.1 | `forbidden_claims` includes `skill_execution`, `pra_execution`, `agent_md_adapter_execution`, `jira_postback_execution`, `confluence_publication_execution`, `rovo_execution`, `mcp_execution`, `runtime_or_cloud_execution`, `database_execution`, `terraform_or_adk_execution`, `release_or_zip_export_from_a_prompt`, `diagram_generation_from_a_prompt`, `scoring_proof_outside_13_accuracy_score`, `hardcoded_run_id_paths_or_urls` | PASS | top of file |
| 9.2 | No prompt card violates a `forbidden_claims` entry | PASS | per-prompt audit |
| 9.3 | `compatibility_notes.rs_full_chain_wrapper.decision: planned_only` | PASS | founder decision Q2 |
| 9.4 | `compatibility_notes.rs_output_12_targeted_questions.decision: retained` | PASS | founder decision Q1 |
| 9.5 | `compatibility_notes.dfd_prompt_numbering.decision: preserved_02_through_10` | PASS | founder decision Q4 |

## 10. Direct-test flag and notes

| # | Check | Status | Evidence |
|---|---|---|---|
| 10.1 | Every entry has `direct_test_supported: true` | PASS | enforced |
| 10.2 | The `notes` field for each entry is a single short string describing scope and any conditional behavior | PASS | per-prompt audit |
| 10.3 | PR-RS-13 `notes` records the conditional scoring posture (gate based on `scoring_enabled`, `expected_baseline_required`, populated `{{expected_root}}`) | PASS | registry entry |
| 10.4 | PR-RS-09 `notes` records that `blueprints/` is owned by Build Package 08 and that `no_blueprint_available` is the honest result in Package 04 | PASS | registry entry |
| 10.5 | PR-RS-00 `notes` records that the wrapper writes nothing of its own and claims no orchestration or execution | PASS | registry entry |

## 11. No external-claim leakage

| # | Check | Status | Evidence |
|---|---|---|---|
| 11.1 | No registry entry's `notes` claims Jira post-back, Confluence publication, Rovo execution, MCP execution, runtime, cloud, database, scoring proof, diagram generation, or release export | PASS | per-entry audit |
| 11.2 | The registry's `scope` block declares `prompt_cards_are_runtime_tools: false` and `prompt_cards_claim_external_postback: false` and similar | PASS | top of file |
| 11.3 | No registry entry's `output_artifact` resolves outside `runs/{{run_id}}/` | PASS | per-entry audit |
