# Build Package 08 — Blueprints Checklist

This checklist is the human-review gate for Build Package 08. Every line must pass before founder approval converts the package from `agents_active`/draft to committed.

## File Surface

- [ ] `blueprints/README.md` is the active Build Package 08 README (overwrites the Build Package 01 placeholder).
- [ ] `blueprints/blueprint-registry.yaml` exists.
- [ ] `blueprints/blueprint-template.yaml` exists with `status: template_only`.
- [ ] `blueprints/platform-independent/README.md` exists.
- [ ] `blueprints/cloud-patterns/README.md` exists.
- [ ] `blueprints/platform-independent/` contains exactly 8 `BP-*.yaml` files plus `README.md`.
- [ ] `blueprints/cloud-patterns/` contains exactly 1 `BP-*.yaml` file (`BP-AI-SAAS-INTEGRATION.yaml`) plus `README.md`.
- [ ] No Markdown blueprint files exist anywhere under `blueprints/` (only `README.md` files are Markdown).
- [ ] Total files under `blueprints/`: 14.

## Blueprint Inventory (founder Q2 / Q6)

- [ ] `blueprint_count: 9` recorded in `blueprints/blueprint-registry.yaml`.
- [ ] `blueprint_category_count: 2` recorded in the registry.
- [ ] `total_files_under_blueprints: 14` recorded in the registry.
- [ ] Eight platform-independent blueprints present:
  - [ ] `BP-NON-AI-DATAFLOW-BASELINE`
  - [ ] `BP-RAG-RETRIEVAL`
  - [ ] `BP-MODEL-ENDPOINT-CALL`
  - [ ] `BP-TOOL-USING-AGENT`
  - [ ] `BP-API-WRITEBACK`
  - [ ] `BP-HITL-APPROVAL`
  - [ ] `BP-AGENT-TO-AGENT`
  - [ ] `BP-AI-WORKFLOW`
- [ ] One cloud-pattern blueprint present:
  - [ ] `BP-AI-SAAS-INTEGRATION`
- [ ] No 10th blueprint, no fine-tuning, no multimodal, no vector-governance, no model-evaluation, no CSP-specific variants in this package.

## Match-State Model (founder Q1)

- [ ] `blueprint_match_states: [matched, candidate, no_match, unknown]` recorded in the registry.
- [ ] Every BP-*.yaml populates `match_conditions`, `candidate_conditions`, `no_match_conditions`, and `unknown_conditions` with at least one condition each.
- [ ] No BP-*.yaml uses the old v0.01 three-state model.

## Required Fields (the 19)

For every BP-*.yaml, all 19 required fields are present:
- [ ] `blueprint_id`
- [ ] `blueprint_name`
- [ ] `owning_build_package` set to `Build Package 08`
- [ ] `status` set to `active`
- [ ] `purpose`
- [ ] `applicability`
- [ ] `catalog_dependencies`
- [ ] `required_inputs`
- [ ] `match_conditions`
- [ ] `candidate_conditions`
- [ ] `no_match_conditions`
- [ ] `unknown_conditions`
- [ ] `material_missing_facts`
- [ ] `supported_finding_categories`
- [ ] `supported_recommendation_types`
- [ ] `human_review_gate` with `required: true`
- [ ] `prohibited_claims`
- [ ] `source_reference`
- [ ] `version_notes`

## Required Policy Blocks

For every BP-*.yaml:
- [ ] `match_evidence_policy` block present with all five flags set.
- [ ] `catalog_value_policy` block present with all three keys set.
- [ ] `output_boundary` block present with all four keys set.

## Runtime / External Execution Flags (founder Q8)

For every BP-*.yaml and `blueprints/blueprint-registry.yaml`:
- [ ] `runtime_and_external_execution.runtime_deployed: false`
- [ ] `runtime_and_external_execution.adk_deployed: false`
- [ ] `runtime_and_external_execution.cloud_resources_created: false`
- [ ] `runtime_and_external_execution.database_jobs_created: false`
- [ ] `runtime_and_external_execution.mcp_execution_available: false`
- [ ] `runtime_and_external_execution.jira_confluence_execution_available: false`

## Catalog References (founder Q4)

- [ ] Every BP-*.yaml references only Build Package 07 catalog IDs.
- [ ] Every BP-*.yaml references `confidence-level-catalog` in `catalog_dependencies`.
- [ ] Every BP-*.yaml references `proof-vs-signal-rule-catalog` in `catalog_dependencies`.
- [ ] Every BP-*.yaml references `interaction-type-catalog` in `catalog_dependencies`.
- [ ] No BP-*.yaml introduces a catalog ID that does not appear in `catalogs/catalog-registry.yaml`.
- [ ] No BP-*.yaml introduces a new catalog value (controlled values come from Package 07 catalogs only).

## Sealed Upstream Registries (founder Q4)

- [ ] No edits made to `prompts/` or any prompt card.
- [ ] No edits made to `prompts/prompt-registry.yaml`.
- [ ] No edits made to `skills/` or any skill contract.
- [ ] No edits made to `skills/skill-registry.yaml`.
- [ ] No edits made to `prototype-agents/` or any PRA spec.
- [ ] No edits made to `prototype-agents/prototype-agent-registry.yaml`.
- [ ] No edits made to `.agents/` or any `.agent.md` adapter.
- [ ] No edits made to `catalogs/` or any catalog YAML.
- [ ] No edits made to `catalogs/catalog-registry.yaml`.
- [ ] Catalog count remains 24; catalog file total under `catalogs/` remains 33.

## Forbidden Content (no prose, no computation, no implementation)

For every BP-*.yaml and the registry:
- [ ] No final recommendation prose (categories only).
- [ ] No handoff prose.
- [ ] No validation-ticket prose.
- [ ] No severity computation.
- [ ] No score computation.
- [ ] No AI Action Level computation.
- [ ] No owner routing prose.
- [ ] No implementation proof claims.
- [ ] No runtime / cloud / ADK / Vertex / GCP / MCP / Jira / Confluence / Rovo / database / Terraform claims.
- [ ] No diagram, template, sample, or run-output content.

## Governance Updates

- [ ] `PACKAGE-MANIFEST.yaml` carries a `build_package_08_allowed_writes` block listing the Package 08 file surface.
- [ ] `PACKAGE-MANIFEST.yaml#current_build_package` is set to Build Package 08 (active).
- [ ] `PACKAGE-MANIFEST.yaml#next_build_package` is set to Build Package 09 — Templates.
- [ ] `PACKAGE-MANIFEST.yaml#blueprint_status` is `active`.
- [ ] `FOLDER-CONTRACTS.md` Root Area 10 (`blueprints/`) reflects Build Package 08 active status and the layout above.
- [ ] `validation/no-drift-rules.md` includes the Build Package 08 rules (no upstream registry edits, no catalog edits, no prose, four-state matching, etc.).
- [ ] `README.md` and `START-HERE.md` reference Build Package 08 as active.
- [ ] `.github/copilot-instructions.md` reflects Build Package 08 active.

## Tool Patch (founder Q5)

- [ ] `tools/Test-AisrafPackage.ps1` header/synopsis updated from "Build Package 01-07" to "Build Package 01-08".
- [ ] `blueprints/` removed from the README-only folder rule.
- [ ] `Check 08f-blueprints-content-limits` added enforcing the exact Package 08 layout.
- [ ] Check 11 validation allowed list extended with the three Package 08 checklists.
- [ ] No other validator behavior modified.
- [ ] `validation/package-03-tools-checklist.md`, `validation/package-04-prompts-checklist.md`, `validation/prompt-registry-checklist.md`, `validation/package-05-skills-checklist.md`, `validation/skill-registry-checklist.md`, `validation/package-06-agents-checklist.md`, `validation/agent-registry-checklist.md`, `validation/prompt-skill-agent-mapping-checklist.md`, `validation/package-07-catalogs-checklist.md`, `validation/catalog-registry-checklist.md`, `validation/catalog-consumption-checklist.md` are unchanged (frozen acceptance evidence).

## Validation Run

- [ ] `tools/Test-AisrafPackage.ps1` exits 0 (no FAIL rows). WARN rows are allowed only for `runs/<run_id>/` smoke folders that must be cleaned before stage.

## Old Reference Workspace

- [ ] No file created, edited, deleted, moved, or renamed under `D:/E-Way 2/aisraf-sas-prototype-skill-chain-pack-v0.01/`.
- [ ] No old release artifact, failed diagram, run output, or temporary report copied into `D:/E-Way 2/AISRAF- SAS Prototype v0.1.2/`.

## Next Build Package Gate

- [ ] After founder approval, the next allowed Build Package is Build Package 09 — Templates.
