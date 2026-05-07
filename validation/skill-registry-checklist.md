# Skill Registry Checklist

Package: AISRAF SAS Prototype v0.1.2
Owning Build Package: Build Package 05.
Registry under check: [skills/skill-registry.yaml](../skills/skill-registry.yaml)
Schema authority: [config/run-profile.schema.yaml](../config/run-profile.schema.yaml)
No-drift authority: [validation/no-drift-rules.md](no-drift-rules.md)

This checklist focuses on the skill registry itself. The broader Build Package 05 acceptance gate is [validation/package-05-skills-checklist.md](package-05-skills-checklist.md).

## 1. Registry presence and shape

| # | Check | Status | Evidence |
|---|---|---|---|
| 1.1 | [skills/skill-registry.yaml](../skills/skill-registry.yaml) exists | PASS | file present |
| 1.2 | Top-level fields present: `schema_version`, `registry_id`, `title`, `package_version`, `owning_build_package`, `status`, `skill_count`, `skill_family_counts`, `skill_families`, `purpose`, `scope`, `parameter_contract`, `required_skill_sections`, `forbidden_claims`, `placeholder_conventions`, `compatibility_notes`, `planned_future_skills`, `skills` | PASS | top-of-file structure |
| 1.3 | `schema_version: aisraf_skill_registry.v0_1_2` | PASS | top of file |
| 1.4 | `package_version: v0.1.2` | PASS | top of file |
| 1.5 | `owning_build_package: "05"` | PASS | top of file |
| 1.6 | `status: active` | PASS | top of file |

## 2. Count parity

| # | Check | Status | Evidence |
|---|---|---|---|
| 2.1 | `skill_count: 26` | PASS | top of file |
| 2.2 | `skill_family_counts.rs: 17` | PASS | top of file |
| 2.3 | `skill_family_counts.dfd: 9` | PASS | top of file |
| 2.4 | Number of `skills:` entries equals 26 | PASS | 17 RS + 9 DFD entries |
| 2.5 | Number of files matching `skills/rs/SK-*.md` equals 17 | PASS | filesystem inventory |
| 2.6 | Number of files matching `skills/dfd/SK-DFD-0[1-9]-*.md` equals 9 | PASS | filesystem inventory |
| 2.7 | Registry RS-family entries equal RS files on disk | PASS | inventory match |
| 2.8 | Registry DFD-family entries equal DFD files on disk | PASS | inventory match |
| 2.9 | `planned_future_skills` block does NOT contribute to `skill_count` | PASS | recorded outside `skills:` list |

## 3. Uniqueness

| # | Check | Status | Evidence |
|---|---|---|---|
| 3.1 | Every `skill_id` value is unique across all 26 entries | PASS | 17 unique RS IDs + 9 unique DFD IDs |
| 3.2 | Every `skill_file` value is unique across all 26 entries | PASS | each entry points to a distinct file |
| 3.3 | Output artifact paths are unique (no two skills own the same output file) | PASS | each `output_artifacts` entry is owned by one skill |

## 4. File existence

| # | Check | Status | Evidence |
|---|---|---|---|
| 4.1 | Every `skill_file` resolves to an existing file on disk | PASS | 17 + 9 files present |
| 4.2 | No registry entry points to a missing skill file | PASS | inventory match |
| 4.3 | No file under `skills/rs/` or `skills/dfd/` is missing from the registry (other than `README.md`) | PASS | inventory match |
| 4.4 | Every `mapped_prompt_file` resolves to an existing file under `prompts/rs/` or `prompts/dfd/` | PASS | references match Build Package 04 prompt cards |
| 4.5 | Every `mapped_prompt_id` exists in [prompts/prompt-registry.yaml](../prompts/prompt-registry.yaml) | PASS | all 22 active mapped prompt IDs (PR-RS-01..PR-RS-13, PR-DFD-02..PR-DFD-10) exist |

## 5. Required entry fields

Each entry must include: `skill_id`, `skill_file`, `skill_family`, `review_step` (RS) or `dfd_step` (DFD), `mapped_prompt_id`, `mapped_prompt_file`, `future_pra_owner`, `input_dependencies`, `output_artifacts`, `expected_baseline`, `scoring_category`, `critical_miss_refs`, `direct_test_supported`, `notes`.

| # | Check | Status | Evidence |
|---|---|---|---|
| 5.1 | Every entry contains all required fields | PASS | uniform entry shape |
| 5.2 | Every RS entry has `review_step` and no `dfd_step` | PASS | enforced |
| 5.3 | Every DFD entry has `dfd_step` and no `review_step` | PASS | enforced |
| 5.4 | `review_step` ∈ `{RS-01..RS-17}` for RS entries | PASS | enforced |
| 5.5 | `dfd_step` ∈ `{DFD-01..DFD-09}` for DFD entries | PASS | enforced |
| 5.6 | `direct_test_supported: true` for every entry | PASS | enforced |

## 6. Placeholder conventions

| # | Check | Status | Evidence |
|---|---|---|---|
| 6.1 | Every `future_pra_owner` value ends with `(planned; defined in Build Package 06)` | PASS | enforced |
| 6.2 | Every `expected_baseline` value either uses the `(planned; defined in Build Package 10)` suffix or notes "no separate baseline" with reason | PASS | enforced; DFD-08 and DFD-09 use the no-baseline note |
| 6.3 | No skill claims a Build Package 06+ artifact as a hard required-input read | PASS | enforced |

## 7. Compatibility notes

| # | Check | Status | Evidence |
|---|---|---|---|
| 7.1 | `compatibility_notes.prompt_registry_naming_drift` documents both placeholder/canonical pairs | PASS | `SK-DFD-LEGEND-NORMALIZE` ↔ `SK-LEGEND-NORMALIZE`; `SK-SECURITY-STACK-DETECT` ↔ `SK-SECURITY-STACK-ASSESS` |
| 7.2 | `compatibility_notes.prompt_review_step_field_vs_skill_review_step` includes a per-prompt crosswalk | PASS | crosswalk recorded for PR-RS-01..PR-RS-13 |
| 7.3 | `planned_future_skills` records `SK-CHAIN-WRAPPER` as `status: deferred`, outside the 26-skill count | PASS | block present |

## 8. Forbidden claims

| # | Check | Status | Evidence |
|---|---|---|---|
| 8.1 | `forbidden_claims` lists `pra_execution`, `agent_md_adapter_execution`, `jira_postback_execution`, `confluence_publication_execution`, `rovo_execution`, `mcp_execution`, `runtime_or_cloud_execution`, `database_execution`, `terraform_or_adk_execution`, `release_or_zip_export_from_a_skill`, `diagram_generation_from_a_skill`, `scoring_proof_outside_sk_accuracy_score`, `hardcoded_run_id_paths_or_urls`, `prompt_card_modification`, `baseline_modification_under_expected_root` | PASS | enforced |
| 8.2 | No skill body asserts external post-back, runtime, cloud, or scoring proof outside `SK-ACCURACY-SCORE` | PASS | manual review of Section 14 of every contract |
| 8.3 | Only `SK-ACCURACY-SCORE` produces an accuracy score; DFD-08 and DFD-09 explicitly disclaim it | PASS | enforced |

## 9. Run-profile parameter contract

| # | Check | Status | Evidence |
|---|---|---|---|
| 9.1 | `parameter_contract.run_profile_source: runs/{{run_id}}/run-profile.yaml` | PASS | top of file |
| 9.2 | `parameter_contract.required_run_profile_fields` lists exactly the seven canonical v0.1.2 variables | PASS | top of file |
| 9.3 | `parameter_contract.no_hardcoded_values` lists `run_id`, `sample_id`, paths, URLs, and modes | PASS | top of file |
| 9.4 | `parameter_contract.output_root_rule: every_skill_write_path_must_resolve_under_output_root` | PASS | top of file |
| 9.5 | Schema authority points at `config/run-profile.schema.yaml` | PASS | top of file |
| 9.6 | Path resolution and sensitive-data references match the Package 04 prompt registry | PASS | top of file |

## 10. Notes per entry

| # | Check | Status | Evidence |
|---|---|---|---|
| 10.1 | Every entry has a non-empty `notes:` field | PASS | enforced |
| 10.2 | Notes mention shared-prompt skills (PR-RS-04, PR-RS-05, PR-RS-07, PR-RS-10) where applicable | PASS | enforced |
| 10.3 | Notes call out compatibility drift for `SK-LEGEND-NORMALIZE` and `SK-SECURITY-STACK-ASSESS` | PASS | enforced |
| 10.4 | DFD-08 and DFD-09 notes record that accuracy scoring is owned by `SK-ACCURACY-SCORE` only | PASS | enforced |

## Conclusion

If every row above reads PASS, the skill registry is internally consistent and aligned with the Build Package 04 prompt registry, the Build Package 02 run-profile contract, and the Package 05 spec. Any FAIL row must be resolved or recorded as an explicit blocker before Build Package 05 is staged.
