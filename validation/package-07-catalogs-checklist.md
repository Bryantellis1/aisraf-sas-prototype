# Build Package 07 — Catalogs Checklist

Package: AISRAF SAS Prototype v0.1.2
Build Package: 07
Owner: catalog authors and Build Package 07 validators
Status: active

This checklist is the human-review gate for Build Package 07 — Catalogs. It validates folder layout, required fields on every catalog, cross-cutting catalog flags, prohibited-claim discipline, registry integrity, sealed upstream registries, and Test-AisrafPackage compatibility. Build Package 07 catalog count is recorded as 24 controlled-vocabulary YAML catalogs (the founder approval Q7 mentioned 28; see catalogs/catalog-registry.yaml#compatibility_notes for the documented arithmetic discrepancy).

## 1. Folder Layout

- [ ] `catalogs/README.md` exists and overwrites the Build Package 01 placeholder.
- [ ] `catalogs/catalog-registry.yaml` exists.
- [ ] Exactly 7 catalog family folders exist: `components/`, `interactions/`, `boundaries/`, `identity-access/`, `data-protection/`, `security-stacks/`, `review/`.
- [ ] Each family folder has a `README.md`.
- [ ] No other folders exist directly under `catalogs/`.
- [ ] No file under `catalogs/` other than `README.md` and `catalog-registry.yaml` lives at the root of `catalogs/`.

## 2. Catalog Inventory

The exact controlled-vocabulary YAML catalog files committed in Build Package 07 are:

- [ ] `catalogs/components/component-type-catalog.yaml`
- [ ] `catalogs/components/component-role-catalog.yaml`
- [ ] `catalogs/components/component-evidence-rule-catalog.yaml`
- [ ] `catalogs/interactions/interaction-type-catalog.yaml`
- [ ] `catalogs/interactions/flow-direction-catalog.yaml`
- [ ] `catalogs/interactions/flow-evidence-rule-catalog.yaml`
- [ ] `catalogs/boundaries/boundary-type-catalog.yaml`
- [ ] `catalogs/boundaries/boundary-crossing-rule-catalog.yaml`
- [ ] `catalogs/boundaries/trust-zone-catalog.yaml`
- [ ] `catalogs/identity-access/authentication-catalog.yaml`
- [ ] `catalogs/identity-access/authorization-catalog.yaml`
- [ ] `catalogs/identity-access/identity-evidence-rule-catalog.yaml`
- [ ] `catalogs/data-protection/data-class-catalog.yaml`
- [ ] `catalogs/data-protection/transport-protection-catalog.yaml`
- [ ] `catalogs/data-protection/at-rest-protection-catalog.yaml`
- [ ] `catalogs/data-protection/confidence-level-catalog.yaml`
- [ ] `catalogs/security-stacks/security-stack-marker-catalog.yaml`
- [ ] `catalogs/security-stacks/control-signal-catalog.yaml`
- [ ] `catalogs/security-stacks/proof-vs-signal-rule-catalog.yaml`
- [ ] `catalogs/review/finding-category-catalog.yaml`
- [ ] `catalogs/review/severity-catalog.yaml`
- [ ] `catalogs/review/recommendation-type-catalog.yaml`
- [ ] `catalogs/review/ai-action-level-catalog.yaml`
- [ ] `catalogs/review/review-status-catalog.yaml`

Headline counts:

- [ ] 24 controlled-vocabulary YAML catalogs.
- [ ] 1 catalog registry YAML (`catalogs/catalog-registry.yaml`) — not counted as a controlled-vocabulary catalog.
- [ ] 8 README.md files (1 root + 7 family).
- [ ] 33 total files under `catalogs/`.

## 3. Required Top-Level Fields (every catalog YAML)

For every YAML in section 2 above, confirm presence of:

- [ ] `catalog_id`
- [ ] `catalog_name`
- [ ] `owning_build_package: Build Package 07`
- [ ] `status`
- [ ] `purpose`
- [ ] `consumers`
- [ ] `entries`
- [ ] `unknown_value`
- [ ] `evidence_rules`
- [ ] `prohibited_claims`
- [ ] `version_notes`
- [ ] `source_reference` (with `old_v0_01_reference`, `old_reference_paths`, `derivation_mode`, `copied_verbatim`)
- [ ] `controlled_value_policy` (with `closed_list`, `unknown_allowed`, `extension_requires`, `free_text_allowed_only_in`)
- [ ] `anti_inference_rules`

## 4. Required Entry Fields (every entry in every catalog YAML)

For every entry in `entries:`, confirm presence of:

- [ ] `id`
- [ ] `label`
- [ ] `description`
- [ ] `when_to_use`
- [ ] `when_not_to_use`
- [ ] `evidence_required`
- [ ] `confidence_guidance`
- [ ] `notes`

## 5. Cross-Cutting Catalog Flags

- [ ] `catalogs/security-stacks/proof-vs-signal-rule-catalog.yaml` has `global_rule: true` and `applies_to_all_catalogs: true`.
- [ ] Every other catalog in `catalogs/` references `catalogs/security-stacks/proof-vs-signal-rule-catalog.yaml` in its `evidence_rules`.
- [ ] `catalogs/data-protection/confidence-level-catalog.yaml` has `cross_cutting_catalog: true`, `primary_family: data-protection`, and an `applies_to:` list covering DFD extraction, annotation resolution, component classification, boundary classification, finding confidence, and accuracy scoring.

## 6. Anti-Inference and Prohibited-Claims Discipline

For every catalog in section 2:

- [ ] `anti_inference_rules` includes versions of: visible-label-not-proof, cloud-label-not-runtime, authn-not-authz, transit-not-at-rest, marker-not-effectiveness, unknown-stays-unknown.
- [ ] `prohibited_claims` enumerates at least one of: implementation_proof_from_marker_alone, runtime_or_cloud_resource_from_diagram_label_alone, authorization_from_authentication_marker_alone, blueprint_match_from_catalog_entry_alone, or another claim that is meaningful for the catalog's domain.
- [ ] No catalog claims runtime, cloud, MCP, ADK, Vertex/GCP, Jira, Confluence, Rovo, database, or Terraform execution.
- [ ] No catalog references a Build Package 08 blueprint identifier (no `BP-*`).
- [ ] No catalog uses the non-schema variables `{{catalog_root}}`, `{{prompt_root}}`, `{{skill_root}}`, `{{template_root}}`, `{{diagram_root}}`, or `{{validation_root}}`.

## 7. Catalog Registry Integrity

- [ ] `catalogs/catalog-registry.yaml` contains: `registry_id`, `schema_version: aisraf_catalog_registry.v0_1_2`, `package_version: v0.1.2`, `owning_build_package: Build Package 07`, `status: active`.
- [ ] `catalog_count: 24`, `catalog_family_count: 7`, `readme_count: 8`, `total_files_under_catalogs: 33`.
- [ ] `catalog_families:` covers all 7 families with the correct `catalog_files:` lists.
- [ ] `catalogs:` lists all 24 controlled-vocabulary YAML files exactly once.
- [ ] `cross_cutting_catalogs:` records `proof-vs-signal-rule-catalog` (global_rule) and `confidence-level-catalog` (cross_cutting_catalog).
- [ ] `prompt_consumption_map:` covers all 23 prompts (PR-RS-00 may have empty `catalogs:` per status=planned).
- [ ] `skill_consumption_map:` covers all 26 skills.
- [ ] `pra_consumption_map:` covers all 8 PRAs.
- [ ] `adapter_consumption_map:` covers all 7 adapters and notes that `aisraf-dfd-extractor` wraps PRA-03 and PRA-04 jointly.
- [ ] `future_blueprint_consumption_notes:` is `status: future_only`, declares no BP-* identifiers, and points to Build Package 08.
- [ ] `sealed_upstream_registries:` lists `prompts/prompt-registry.yaml`, `skills/skill-registry.yaml`, and `prototype-agents/prototype-agent-registry.yaml` with the policy that Build Package 07 must not modify any of them.
- [ ] `compatibility_notes:` documents the 28/38 vs 24/33 count arithmetic discrepancy.
- [ ] `compatibility_notes:` documents the existing upstream `{{catalog_root}}` reference at `prototype-agents/prototype-agent-registry.yaml` line 45 as `known_upstream_drift: true` with `package_07_action: documented only; no upstream edit.`.

## 8. Sealed Upstream Registries

- [ ] `prompts/prompt-registry.yaml` is unchanged from the Build Package 04 / Build Package 05 / Build Package 06 committed state.
- [ ] `skills/skill-registry.yaml` is unchanged from the Build Package 05 / Build Package 06 committed state.
- [ ] `prototype-agents/prototype-agent-registry.yaml` is unchanged from the Build Package 06 committed state.
- [ ] No file under `prompts/` is created or modified.
- [ ] No file under `skills/` is created or modified.
- [ ] No file under `prototype-agents/` is created or modified.
- [ ] No file under `.agents/` is created or modified.

## 9. Out-of-Scope Surfaces

- [ ] No file under `blueprints/` other than the Build Package 01 README placeholder exists.
- [ ] No file under `templates/` other than the Build Package 01 authoring-agent templates exists.
- [ ] No file under `samples/` other than the Build Package 01 README placeholder exists.
- [ ] No file under `runs/` other than the Build Package 01 README placeholder exists.
- [ ] No file under `diagrams/` other than the Build Package 01 README placeholder exists.
- [ ] No file under `docs/` other than the Build Package 01 README placeholder exists.
- [ ] No file under `release/` other than the Build Package 01 README placeholder exists.
- [ ] No DOCX/PDF/PPTX/ZIP artifact exists anywhere in the package.
- [ ] No file outside `config/` declares or modifies a schema.
- [ ] The old reference workspace at `D:/E-Way 2/aisraf-sas-prototype-skill-chain-pack-v0.01` is unchanged.

## 10. Tools Compatibility Patch

The Test-AisrafPackage.ps1 patch is limited to the five surgical changes approved for Build Package 07:

- [ ] (a) Header/synopsis updated from "Build Package 01-06" to "Build Package 01-07".
- [ ] (b) `catalogs/` removed from the README-only folder rule (Check 08).
- [ ] (c) Check `08e-catalogs-content-limits` added, enforcing the exact Package 07 catalog folder layout (root README + registry + 7 family folders, each with README + listed YAML files only).
- [ ] (d) Check 11 allowed-validation-file list extended with `package-07-catalogs-checklist.md`, `catalog-registry-checklist.md`, and `catalog-consumption-checklist.md`.
- [ ] (e) No alteration to Build Package 03 / 04 / 05 / 06 frozen acceptance evidence (`validation/package-03-tools-checklist.md`, `validation/package-04-prompts-checklist.md`, `validation/prompt-registry-checklist.md`, `validation/package-05-skills-checklist.md`, `validation/skill-registry-checklist.md`, `validation/package-06-agents-checklist.md`, `validation/agent-registry-checklist.md`, `validation/prompt-skill-agent-mapping-checklist.md`).
- [ ] Run `pwsh tools/Test-AisrafPackage.ps1` and confirm 0 FAIL.

## 11. Governance Updates

- [ ] `PACKAGE-MANIFEST.yaml` includes a `build_package_07_allowed_writes:` block matching the implementation, advances `current_build_package` to "07", advances `next_build_package` to "08", and flips `catalog_status` to `active`.
- [ ] `FOLDER-CONTRACTS.md` Root Area 09 status updated to active for Build Package 07 with the catalog inventory summary.
- [ ] `README.md` includes a Build Package 07 entry/pointer.
- [ ] `START-HERE.md` advises that Build Package 07 catalogs are now active and Build Package 08 is the next allowed package.
- [ ] `.github/copilot-instructions.md` includes a one-paragraph "Package 07 catalogs are read-only at runtime; never invent vocabulary" reminder.
- [ ] `validation/no-drift-rules.md` appended with Build Package 07 no-drift rules (catalogs YAML-only except READMEs; required catalog fields; sealed upstream registries; no blueprint IDs; no `{{catalog_root}}`; no runtime/cloud claims; surgical Test-AisrafPackage.ps1 patch only).

## 12. Next Allowed Build Package

- [ ] Next allowed Build Package: Build Package 08 — Blueprints.

## Sign-Off

- [ ] All sections above are checked.
- [ ] Test-AisrafPackage.ps1 passes with 0 FAIL.
- [ ] Human reviewer has inspected at least one catalog from each family and confirms entries are practical, unambiguous, and consistent with the Folder Contract.
