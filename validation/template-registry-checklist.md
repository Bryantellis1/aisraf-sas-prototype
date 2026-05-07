# Template Registry Checklist

Authority: `templates/template-registry.yaml`.

## 1. Top-Level Fields

- [ ] `registry_id: aisraf-template-registry`
- [ ] `schema_version: aisraf_template_registry.v0_1_2`
- [ ] `package_version: v0.1.2`
- [ ] `owning_build_package: Build Package 09`
- [ ] `status: active`
- [ ] `template_count: 31`
- [ ] `template_family_count: 4`
- [ ] `template_family_counts: {output: 27, jira: 1, confluence: 1, run: 2}`
- [ ] `total_files_under_templates: 37`
- [ ] `unknown_value: unknown`
- [ ] `purpose` present
- [ ] `scope` block with `canonical_template_root: templates`, `template_subfolders` listing all four families, all six false flags
- [ ] `parameter_contract` block with the seven approved variables, six rejected non-schema variables, and `descriptive_field_reference_pattern`
- [ ] `required_template_metadata_fields` lists 14 entries
- [ ] `prohibited_claims` block enumerating runtime / cloud / MCP / Jira / Confluence / Rovo / ADK / database / Terraform / severity / score / AI Action Level / blueprint-match / finding-prose / recommendation-prose / catalog-value-introduction / blueprint-override / implementation-proof claims
- [ ] `runtime_and_external_execution` block with all six false flags
- [ ] `sealed_upstream_registries` lists 5 registries (prompts, skills, prototype-agents, catalogs, blueprints)
- [ ] `sealed_upstream_policy` text present
- [ ] `founder_decisions` records Q1, Q2, Q3, Q4, Q5, Q6
- [ ] `output_destination_modes_supported` matches `config/run-profile.schema.yaml#output_destination_mode.enum`
- [ ] `postback_execution_status_values` matches `config/run-profile.schema.yaml#postback_execution_status.enum`

## 2. Templates Inventory

- [ ] `templates:` array contains exactly 31 entries.
- [ ] Each entry carries the 14 required metadata fields.
- [ ] Each entry's `template_file` resolves to an actual file under `templates/`.
- [ ] Each entry's `owning_build_package: Build Package 09`.
- [ ] Each entry's `status: active`.
- [ ] Each entry's `output_boundary` resolves to under `{{output_root}}` (or `{{output_root}}/dfd/` for DFD) or append-only into `{{output_root}}/00-run-log.md`.

### Output family (27 entries)

- [ ] TPL-OUT-00-RUN-LOG, TPL-OUT-01-INPUT-INVENTORY, TPL-OUT-02-VISIBLE-DFD-OBJECTS, TPL-OUT-03-LEGEND-NORMALIZATION, TPL-OUT-04-COMPONENTS, TPL-OUT-05-FLOWS, TPL-OUT-06-BOUNDARIES, TPL-OUT-07-SECURITY-STACK-ASSESSMENT, TPL-OUT-08-INTERNAL-REVIEW-TABLE, TPL-OUT-09-MISSING-FACTS, TPL-OUT-10-AI-ACTION-LEVEL, TPL-OUT-11-BLUEPRINT-MATCH, TPL-OUT-12-TARGETED-QUESTIONS, TPL-OUT-13-FINDINGS, TPL-OUT-14-RECOMMENDATIONS, TPL-OUT-15-HANDOFF-PACK, TPL-OUT-16-VALIDATION-NOTES, TPL-OUT-17-ACCURACY-SCORE all present.
- [ ] TPL-OUT-DFD-01..09 all present.

### Jira family (1 entry)

- [ ] TPL-JIRA-TICKET-DRAFT present.

### Confluence family (1 entry)

- [ ] TPL-CONFLUENCE-PAGE-DRAFT present.

### Run family (2 entries)

- [ ] TPL-RUN-LOG-ENTRY-ROW present.
- [ ] TPL-RUN-POSTBACK-LOG-ENTRY-ROW present.

## 3. Consumer Maps

- [ ] `consumer_maps.template_to_prompt.pairs` covers all 27 output templates plus the Jira and Confluence drafts.
- [ ] `consumer_maps.template_to_pra.pairs` covers all 31 templates.
- [ ] `consumer_maps.template_to_adapter.pairs_by_family` covers each family.
- [ ] `consumer_maps.template_to_blueprint.pairs` references only the 9 BP-* identifiers from `blueprints/blueprint-registry.yaml#blueprints[]`. No new BP-* identifiers.
- [ ] `consumer_maps.template_to_catalog.catalogs_referenced` lists 24 catalog file paths matching `catalogs/catalog-registry.yaml#catalogs[]`. No invented catalogs.

## 4. Compatibility Notes

- [ ] `compatibility_notes.v0_01_template_inventory_collapse` records the rejection of `diagram-spec-template`, `evidence-record-template`, and `recommendation-rule-template` and the collapse of v0.01's degenerate stubs.
- [ ] `compatibility_notes.run_profile_template_yaml_location` records that `templates/run-profile-template.yaml` from v0.01 is `out_of_scope_for_package_09` (lives at `config/run-profile.template.yaml`).
- [ ] `compatibility_notes.connector_field_placeholders_in_jira_confluence_drafts` records the descriptive-reference policy.
- [ ] `compatibility_notes.founder_q1_run_log_split`, `founder_q3_no_catalog_value_enumeration`, and `founder_q4_naming_convention` all record `decision: applied`.

## 5. Sealed Upstream Verification

- [ ] No commit in this Build Package modifies `prompts/prompt-registry.yaml`.
- [ ] No commit modifies `skills/skill-registry.yaml`.
- [ ] No commit modifies `prototype-agents/prototype-agent-registry.yaml`.
- [ ] No commit modifies `catalogs/catalog-registry.yaml`.
- [ ] No commit modifies `blueprints/blueprint-registry.yaml`.
