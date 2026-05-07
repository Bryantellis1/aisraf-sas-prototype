# Build Package 06 — Agents Acceptance Checklist

Package: AISRAF SAS Prototype v0.1.2

Build Package 06 — Prototype agents, PRA specs, and `.agent.md` adapter model.

This checklist is the founder-facing acceptance gate for Build Package 06. The next allowed Build Package is Build Package 07 — Catalogs.

## Surface Counts

- [ ] `prototype-agents/prototype-agent-registry.yaml` exists.
- [ ] `prototype-agents/prototype-agent-template.md` exists.
- [ ] `prototype-agents/README.md` exists and lists all 8 PRAs.
- [ ] Exactly 8 `prototype-agents/PRA-*.md` files exist:
  - [ ] `PRA-01-SAS-REVIEW-ORCHESTRATOR.md`
  - [ ] `PRA-02-INPUT-READER.md`
  - [ ] `PRA-03-DFD-EXTRACTOR.md`
  - [ ] `PRA-04-LEGEND-NORMALIZER.md`
  - [ ] `PRA-05-REVIEW-TABLE-BUILDER.md`
  - [ ] `PRA-06-BLUEPRINT-QUESTIONER.md`
  - [ ] `PRA-07-FINDING-RECOMMENDER.md`
  - [ ] `PRA-08-HANDOFF-QA-SCORER.md`
- [ ] `.agents/README.md` exists and lists all 7 adapters.
- [ ] Exactly 7 `.agents/aisraf-*.agent.md` files exist:
  - [ ] `aisraf-orchestrator.agent.md`
  - [ ] `aisraf-input-reader.agent.md`
  - [ ] `aisraf-dfd-extractor.agent.md`
  - [ ] `aisraf-review-table-builder.agent.md`
  - [ ] `aisraf-blueprint-questioner.agent.md`
  - [ ] `aisraf-finding-recommender.agent.md`
  - [ ] `aisraf-handoff-qa-scorer.agent.md`
- [ ] No `aisraf-legend-normalizer.agent.md` exists (PRA-04 has no dedicated adapter; founder decision Q1).

## PRA Spec Contract

For every PRA file:

- [ ] Carries the 13 required sections (Identity, Purpose, Owned Prompts, Owned Skills, Inputs, Outputs, Procedure, Human Gates, Stop Conditions, Unknown Handling, Evidence and Run-Log Guidance, Direct Adapter Test, Not in Scope).
- [ ] Names its `mapped_adapter` path (or for PRA-04, points to `.agents/aisraf-dfd-extractor.agent.md` and notes the founder Q1 consolidation).
- [ ] Owned prompts list every owned prompt by canonical `prompts/...` path; no prompt body is duplicated.
- [ ] Owned skills list every owned skill by canonical `skills/...` path; no skill body is duplicated.
- [ ] Outputs resolve under `{{output_root}}` only (with `{{output_root}}/dfd/...` permitted for PRA-03 DFD subskill outputs).
- [ ] Uses only the seven authoritative run-profile variables: `{{run_id}}`, `{{input_root}}`, `{{expected_root}}`, `{{output_root}}`, `{{mode}}`, `{{postback_execution_status}}`, `{{output_destination_mode}}`.
- [ ] Does not introduce non-schema variables such as `{{catalog_root}}`, `{{prompt_root}}`, `{{skill_root}}`, `{{template_root}}`, `{{diagram_root}}`, or `{{validation_root}}`.
- [ ] States explicitly: not a runtime agent, not a Google ADK agent, not an external system integration, writes only under `{{output_root}}`, no Jira/Confluence/MCP/Rovo/cloud/ADK/database/release execution claim.

## Adapter Contract

For every `.agent.md` file:

- [ ] YAML frontmatter contains `name`, `description`, `tools: [read, search, edit]`, `user-invocable: true`, and `handoffs`.
- [ ] No model is pinned in frontmatter or body.
- [ ] Only `read`, `search`, and `edit` tools are declared.
- [ ] Carries the 12 required sections (Adapter Identity, Display Name, Purpose, Canonical PRA Reference, Prompt References, Skill References, Run-Profile Variables Required, Allowed Writes, Prohibited Writes, Operator Test Prompt, Stop Conditions, Not in Scope).
- [ ] Adapter is a thin wrapper: it points to canonical PRA, prompt, and skill paths and does not duplicate the full body of any prompt card or skill contract.
- [ ] Allowed Writes resolve under `{{output_root}}` only (with `{{output_root}}/dfd/...` permitted for `aisraf-dfd-extractor.agent.md`).
- [ ] Prohibited Writes name every other folder explicitly.
- [ ] Operator Test Prompt names the canonical PRA, prompt, and skill paths and uses only the seven authoritative run-profile variables.
- [ ] Does not claim runtime, cloud, ADK, MCP, Jira, Confluence, Rovo, database, Terraform, release packaging, or diagram generation.

## Crosswalk

- [ ] `prototype-agents/prototype-agent-registry.yaml` declares `pra_count: 8`, `adapter_count: 7`, `prompt_count_mapped: 23`, `skill_count_mapped: 26`.
- [ ] Every Build Package 04 prompt card (23) appears in `prompt_skill_agent_crosswalk` exactly once on its owning PRA.
- [ ] Every Build Package 05 skill contract (26) appears in `prompt_skill_agent_crosswalk` exactly once on its owning PRA.
- [ ] PR-RS-00 (`prompts/rs/00-run-full-chain.prompt.md`) is mapped to PRA-01 with no skill (consistent with `skills/skill-registry.yaml#planned_future_skills` for `SK-CHAIN-WRAPPER`).
- [ ] Every adapter's `wraps_pras` list contains at least one PRA in `prototype_agents`.
- [ ] `aisraf-dfd-extractor.agent.md` lists both `PRA-03-DFD-EXTRACTOR` and `PRA-04-LEGEND-NORMALIZER` in `wraps_pras`.
- [ ] `placeholder_resolution_notes.placeholder_to_pra_map` resolves every `future_pra_owner` placeholder used in `prompts/prompt-registry.yaml` and `skills/skill-registry.yaml` to a concrete PRA.
- [ ] `planned_future_adk_alignment.status` is `future_only` and the six future-state flags (`runtime_deployed`, `adk_deployed`, `cloud_resources_created`, `database_jobs_created`, `mcp_execution_available`, `jira_confluence_execution_available`) are all `false`.

## Frozen Surfaces (Must Not Change)

- [ ] `prompts/prompt-registry.yaml` is not modified.
- [ ] `skills/skill-registry.yaml` is not modified.
- [ ] No file under `prompts/` is modified.
- [ ] No file under `skills/` is modified.
- [ ] No file under `{{expected_root}}` is modified.
- [ ] `validation/package-01-foundation-checklist.md` is not modified.
- [ ] `validation/package-02-config-checklist.md` is not modified.
- [ ] `validation/package-03-tools-checklist.md` is not modified.
- [ ] `validation/package-04-prompts-checklist.md` is not modified.
- [ ] `validation/prompt-registry-checklist.md` is not modified.
- [ ] `validation/package-05-skills-checklist.md` is not modified.
- [ ] `validation/skill-registry-checklist.md` is not modified.
- [ ] Old reference workspace at `D:/E-Way 2/aisraf-sas-prototype-skill-chain-pack-v0.01` is not modified.

## Surface Boundaries

- [ ] No files exist under `catalogs/` other than `README.md`.
- [ ] No files exist under `blueprints/` other than `README.md`.
- [ ] No files exist under `templates/` other than `README.md`.
- [ ] No files exist under `samples/` other than `README.md`.
- [ ] No `RUN-*` folders are committed under `runs/`.
- [ ] No files exist under `diagrams/` other than `README.md`.
- [ ] No files exist under `docs/` other than `README.md`.
- [ ] No files exist under `release/` other than `README.md`.
- [ ] No new tools added to `tools/` (only the surgical `Test-AisrafPackage.ps1` patch).
- [ ] No new schema files outside `config/`.
- [ ] No DOCX/PDF/PPTX/ZIP artefacts anywhere.
- [ ] No `.github/prompts/` wrappers added.

## Tooling

- [ ] `tools/Test-AisrafPackage.ps1` header/synopsis updated to "Build Package 01–06".
- [ ] `Test-AisrafPackage.ps1` Check 07 enforces exactly 7 approved `.agent.md` files under `.agents/` and FAILS on any other.
- [ ] `Test-AisrafPackage.ps1` adds a new check enforcing the `prototype-agents/` content surface (README.md, prototype-agent-registry.yaml, prototype-agent-template.md, and 8 `PRA-0[1-8]-*.md` files only).
- [ ] `Test-AisrafPackage.ps1` removes `prototype-agents/` and `.agents/` from the README-only folder rule.
- [ ] `Test-AisrafPackage.ps1` extends Check 11 allowed validation list with `package-06-agents-checklist.md`, `agent-registry-checklist.md`, and `prompt-skill-agent-mapping-checklist.md`.
- [ ] `Test-AisrafPackage.ps1` passes (`exit 0`, no FAIL rows) for the Build Package 01–06 surface.

## Governance Updates

- [ ] `PACKAGE-MANIFEST.yaml` records `current_build_package` as Build Package 06 with status `active`, and `next_build_package` as Build Package 07.
- [ ] `PACKAGE-MANIFEST.yaml` adds a `build_package_06_allowed_writes` block listing all 22 created files plus governance/tool updates plus the `prohibited` list.
- [ ] `FOLDER-CONTRACTS.md` records `prototype-agents/` and `.agents/` as active in Build Package 06.
- [ ] `README.md` Current State paragraph references Build Package 06 as the most recent active package.
- [ ] `START-HERE.md` references Build Package 06 as the most recent active package and points to the prototype-agents/ and .agents/ READMEs.
- [ ] `.github/copilot-instructions.md` Current State paragraph references Build Package 06; Artifact Boundaries section marks PRA and `.agent.md` adapter as active.
- [ ] `validation/no-drift-rules.md` adds Build Package 06 rules: PRA count = 8, adapter count = 7, no adapter duplicates prompt/skill bodies, no runtime/ADK/MCP/Jira/Confluence/cloud/database/release claims, no writes outside the Build Package 06 surface, prompt and skill registries remain frozen.

## Next Allowed Build Package

- [ ] Build Package 07 — Catalogs.
