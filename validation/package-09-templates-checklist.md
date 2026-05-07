# Build Package 09 Templates — Acceptance Checklist

Owning Build Package: Build Package 09 — Templates.

This checklist captures the surface-level acceptance criteria for Build Package 09. Run it together with `validation/template-registry-checklist.md` and `validation/template-consumption-checklist.md`.

## 1. File Surface

- [ ] `templates/README.md` exists and overwrites the Build Package 01 placeholder.
- [ ] `templates/template-registry.yaml` exists with `owning_build_package: Build Package 09` and `status: active`.
- [ ] `templates/output/` exists with `README.md` plus exactly 27 `output-*-template.md` files.
- [ ] `templates/jira/` exists with `README.md` plus exactly 1 `jira-ticket-draft-template.md` file.
- [ ] `templates/confluence/` exists with `README.md` plus exactly 1 `confluence-page-draft-template.md` file.
- [ ] `templates/run/` exists with `README.md` plus exactly 2 row templates (`run-log-entry-row-template.md`, `postback-log-entry-row-template.md`).
- [ ] No nested folders inside any `templates/<family>/` folder.
- [ ] No file under `templates/` is anything other than Markdown or the single `template-registry.yaml`.
- [ ] `validation/package-09-templates-checklist.md`, `validation/template-registry-checklist.md`, and `validation/template-consumption-checklist.md` exist.

## 2. Counts (founder decision Q5)

- [ ] `template_count: 31`.
- [ ] `template_family_count: 4`.
- [ ] Output family: 27 templates (18 RS + 9 DFD).
- [ ] Jira family: 1 template.
- [ ] Confluence family: 1 template.
- [ ] Run family: 2 templates.
- [ ] Total files under `templates/` = 37 (31 templates + 1 registry + 5 READMEs).

## 3. Required Metadata Fields

For every template under `templates/`:

- [ ] `template_id`, `template_name`, `owning_build_package: Build Package 09`, `status`, `purpose`, `intended_output`, `consumers`, `inputs_expected`, `placeholders`, `required_sections`, `prohibited_content`, `output_boundary`, `source_reference`, `version_notes` all present.

## 4. Allowed Placeholders Only

For every template:

- [ ] Only the seven approved run-profile variables appear as `{{...}}` placeholders: `{{run_id}}`, `{{input_root}}`, `{{expected_root}}`, `{{output_root}}`, `{{mode}}`, `{{postback_execution_status}}`, `{{output_destination_mode}}`.
- [ ] No `{{catalog_root}}`, `{{prompt_root}}`, `{{skill_root}}`, `{{template_root}}`, `{{diagram_root}}`, or `{{validation_root}}` introduced.
- [ ] Other run-profile schema fields are referenced descriptively as `[copy from runs/{{run_id}}/run-profile.yaml#field_name]`.

## 5. No Catalog-Value Enumeration (founder decision Q3)

For every template:

- [ ] Controlled values from `catalogs/` are referenced via `<value-from-catalogs/...>` placeholder syntax.
- [ ] No template enumerates catalog entries inside its body.
- [ ] No template introduces a new controlled value not already present in `catalogs/catalog-registry.yaml`.

## 6. No Computation Inside Templates

For every template:

- [ ] No severity computation.
- [ ] No accuracy / qualitative score computation (only `SK-ACCURACY-SCORE` produces an accuracy score).
- [ ] No AI Action Level computation (only `SK-AI-ACTION-LEVEL-CLASSIFY` plus human review).
- [ ] No blueprint match decision (only `SK-REVIEW-BLUEPRINT-MATCH` plus human review).
- [ ] No finding fact invented inside the template.
- [ ] No recommendation prose invented inside the template.
- [ ] No owner routing prose.
- [ ] No implementation-proof claim.

## 7. Output Boundary

For every template:

- [ ] `output_boundary` resolves to under `{{output_root}}` only (or `{{output_root}}/dfd/` for DFD outputs, or append-only into `{{output_root}}/00-run-log.md` for run-family templates).
- [ ] No template instructs a write to `config/`, `prompts/`, `skills/`, `prototype-agents/`, `.agents/`, `catalogs/`, `blueprints/`, `templates/`, `samples/`, `diagrams/`, `docs/`, `release/`, `tools/`, `validation/`, or the old reference workspace.

## 8. Jira/Confluence Drafts

For `templates/jira/jira-ticket-draft-template.md` and `templates/confluence/confluence-page-draft-template.md`:

- [ ] Three-line post-back / publication claim block present (`deferred` / `formatted_only` / `executed_by_operator`).
- [ ] No-execution disclaimer present.
- [ ] Safety-check table present.
- [ ] Copy-from references resolve only to `{{output_root}}/...` artifacts.
- [ ] No external post-back claim is permitted unless `runs/{{run_id}}/run-profile.yaml#postback_execution_status` is `executed_by_operator` AND a `templates/run/postback-log-entry-row-template.md` row carrying timestamp + destination URL is present in `{{output_root}}/00-run-log.md`.

## 9. Run-Family Row Templates

For `templates/run/run-log-entry-row-template.md`:

- [ ] Row records timestamp, run_id, sample_id (descriptive), step_id, agent/prompt, skill, input_artifacts_read, output_artifacts_written, validation_result, critical_miss_status, unknowns_recorded, targeted_questions_created, recommendation_ids_created, validation_notes_created, human_gate_required, human_gate_disposition, callback_route, notes.
- [ ] No external post-back claim in this row template; that claim lives in the post-back row template only.

For `templates/run/postback-log-entry-row-template.md`:

- [ ] Required Evidence Rule section enumerates the six gating conditions.
- [ ] Use-Once Constraint section present.
- [ ] Row gated on `executed_by_operator` only.

## 10. Sealed Upstream Registries

- [ ] No file under `prompts/`, `skills/`, `prototype-agents/`, `.agents/`, `catalogs/`, or `blueprints/` is modified.
- [ ] `prompts/prompt-registry.yaml`, `skills/skill-registry.yaml`, `prototype-agents/prototype-agent-registry.yaml`, `catalogs/catalog-registry.yaml`, and `blueprints/blueprint-registry.yaml` are unchanged.

## 11. Out-of-Scope Boundaries

Confirmed not created or modified by Build Package 09:

- [ ] `samples/` (Build Package 10 owns).
- [ ] `runs/<run_id>/` (Build Package 11 owns).
- [ ] `diagrams/` (Build Package 13 owns).
- [ ] `docs/` (Build Package 14 owns).
- [ ] `release/` (Build Package 15 owns).
- [ ] No schema outside `config/`.
- [ ] No `tools/Export-AisrafRelease.ps1` or any new tool beyond the surgical `tools/Test-AisrafPackage.ps1` patch.
- [ ] No runtime code, cloud assets, ADK/Vertex/GCP code, MCP/Jira/Confluence/Rovo execution proof, database jobs, Terraform, release binaries.

## 12. Tooling

- [ ] `tools/Test-AisrafPackage.ps1` carries exactly the five surgical Package 09 changes (header, README-only-folder removal of `templates`, new Check `08g-templates-content-limits`, Check 11 allow-list extension with the three new checklists, all other checks preserved).
- [ ] `Test-AisrafPackage.ps1` exits 0 with no FAIL rows.

## 13. Frozen Prior-Package Validation Files

Confirmed not modified by Build Package 09:

- [ ] `validation/package-03-tools-checklist.md`
- [ ] `validation/package-04-prompts-checklist.md`
- [ ] `validation/prompt-registry-checklist.md`
- [ ] `validation/package-05-skills-checklist.md`
- [ ] `validation/skill-registry-checklist.md`
- [ ] `validation/package-06-agents-checklist.md`
- [ ] `validation/agent-registry-checklist.md`
- [ ] `validation/prompt-skill-agent-mapping-checklist.md`
- [ ] `validation/package-07-catalogs-checklist.md`
- [ ] `validation/catalog-registry-checklist.md`
- [ ] `validation/catalog-consumption-checklist.md`
- [ ] `validation/package-08-blueprints-checklist.md`
- [ ] `validation/blueprint-registry-checklist.md`
- [ ] `validation/blueprint-catalog-consumption-checklist.md`

## 14. Founder Decision Compliance

- [ ] Q1 — run-log split: `templates/output/output-00-run-log-template.md` defines the file shape; `templates/run/run-log-entry-row-template.md` and `templates/run/postback-log-entry-row-template.md` define row patterns.
- [ ] Q2 — connector field placeholders: every connector / non-placeholder run-profile field used inside a template appears as a descriptive `[copy from runs/{{run_id}}/run-profile.yaml#field_name]` reference (no `{{jira_connector_status}}` etc.). All connector fields are confirmed present in `config/run-profile.schema.yaml` (no schema invention).
- [ ] Q3 — controlled-vocabulary references use `<value-from-catalogs/...>` placeholder style; no enumeration inside templates.
- [ ] Q4 — output templates use the `output-NN-name-template.md` naming convention.
- [ ] Q5 — `template_count: 31`; `template_family_count: 4`; counts per family match (27 / 1 / 1 / 2).
- [ ] Q6 — `tools/Test-AisrafPackage.ps1` carries the 5-change surgical patch only.

## 15. Old Reference Workspace

- [ ] No write occurred to `D:/E-Way 2/aisraf-sas-prototype-skill-chain-pack-v0.01/`.
