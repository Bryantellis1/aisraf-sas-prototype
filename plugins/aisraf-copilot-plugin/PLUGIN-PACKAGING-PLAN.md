---
plugin_id: aisraf-copilot-plugin
work_package: WP-12C-K4
lifecycle_status: packaged_not_installed
contract_status: plugin_package_validation_defined
external_execution: disabled
postback_execution_status: deferred
output_destination_mode: local_only
runtime_claims: none
---

# AISRAF Copilot Plugin — Packaging Plan (WP-12C-K4 Package Validation)

## 1. Purpose

This document describes how the AISRAF Copilot plugin is assembled through
projection-by-reference and how K4 validates the packaged projection before
install testing. WP-12C-K2 authored the scaffold, WP-12C-K3A defined the
projection assembly contract, WP-12C-K3C assembled the bundle, and K4
validates manifest schema, lint, and checksum integrity only. Nothing is
installed, smoke-tested, staged, published, diagrammed, or released by K4.

## 2. Source-Of-Truth Map

The canonical solution package is the source of truth. Every plugin
projection is sourced from one of the canonical paths below. The plugin
must reference these paths at install time; it must not duplicate their
bodies inside `plugins/aisraf-copilot-plugin/`.

| Canonical Surface | Source Path (relative to repo root) | Asset Class |
|---|---|---|
| Prompt cards | `prompts/rs/`, `prompts/dfd/` | RS + DFD prompt families |
| Skill contracts | `skills/rs/`, `skills/dfd/` | 17 RS + 9 DFD skill contracts |
| Prototype Reference Agents | `prototype-agents/PRA-*.md` | 8 PRAs + registry |
| Prototype agent registry | `prototype-agents/prototype-agent-registry.yaml` | Crosswalk |
| Skill registry | `skills/skill-registry.yaml` | Skill index |
| Prompt registry | `prompts/prompt-registry.yaml` | Prompt index |
| Templates | `templates/output/`, `templates/run/`, `templates/template-registry.yaml` | Controlled output / run templates |
| Catalogs | `catalogs/` | Controlled vocabulary catalogs |
| Blueprints | `blueprints/` | Controlled design blueprints |
| Sample fixtures | `samples/sample-001-dfd-crop/inputs/`, `samples/sample-001-dfd-crop/expected/` | Read-only sample inputs and expected baselines |
| Run fixture | `runs/RUN-001/` | Read-only RUN-001 fixture |
| Canonical adapters | `.agents/*.agent.md` | 7 governed adapter specs |
| Provider agent projection | `.github/agents/*.agent.md` | 7 byte-identical provider projections |
| Provider Agent Skills | `.github/skills/<name>/SKILL.md` | 7 provider Agent Skill packages |
| Local skill wrappers | `.copilot-skills/*.skill.md`, `.copilot-skills/*.operator-card.md`, `.copilot-skills/README.md` | 7 wrappers + 7 cards + README |
| Provider hook config | `.github/hooks/aisraf-guardrails.json` | Provider lifecycle config |
| Reusable hook scripts | `tools/hooks/*.ps1`, `tools/hooks/hook-allow-list.yaml`, `tools/hooks/README.md` | 4 PowerShell hook scripts + allow-list + README |
| Validators | `tools/Test-AisrafPackage.ps1`, `tools/Test-AisrafBp12AReadiness.ps1`, `tools/Test-AisrafRunProfile.ps1`, `tools/New-AisrafRun.ps1` | Governed PowerShell validators |
| Validation artifacts | `validation/*.md` | Test cards, checklists, roadmaps |
| Solution-package architecture | `validation/package-12c-solution-package-architecture.md` | Authority chain + posture |
| Plugin roadmap | `validation/package-12c-plugin-roadmap.md` | Roadmap and packaging contract |

The plugin manifest (`plugin.yaml`) lists these source paths by string only.
It does **not** copy their bodies.

## 3. Projection-By-Reference Approach

The plugin projection rules are:

1. **Build-script copy after K3B, never hand-edit.** K3A defines the
   bundling contract. K3B must patch validators before any bundle folder or
   build script is created. K3C is the first gate that may create the build
   script and bundle output. No body is to be re-typed, paraphrased, or
   otherwise duplicated by hand.
2. **Checksum manifest at K3C / K4.** A `bundle-checksum-manifest.yaml`
   shall pair every bundled-by-reference source path and target path to
   SHA-256 evidence. Drift between source and bundle is a falsifier.
3. **Provider projection bundles, not new authoring.** The 7 provider agent
   projections under `.github/agents/` and the 7 provider Agent Skills
   packages under `.github/skills/` are to be bundled as-is. No provider
   adapter body is to be hand-edited inside the plugin.
4. **Hooks bundled by reference.** The 4 PowerShell hook scripts under
   `tools/hooks/` plus the provider hook config under `.github/hooks/`
   shall be bundled by reference. No hook body is to be re-typed.
5. **No MCP tool today.** The plugin includes no MCP tool. If a future
   work package introduces an MCP tool, it must declare owner, permission
   scope, data classification, and a falsifier per
   `validation/package-12c-solution-package-architecture.md` §10.
6. **No memory / state surface beyond run-scoped files.** All state is
   written to `runs/{{run_id}}/` per the canonical hook allow-list.
7. **No external execution.** The plugin manifest declares
   `external_execution: disabled` and every plugin file carries a
   no-external-execution falsifier.

## 3a. Role Update / Extension Procedure (WP-12C-K2A)

The plugin is a projection. A role (an AISRAF agent / skill / hook /
prompt / template) is **never updated by editing a plugin file**. The
canonical surface is updated; the provider projection is regenerated; the
plugin projection map is updated at K3 / K4; validators are rerun. This
section names the canonical procedure so future maintainers do not patch
the plugin in a way that breaks projection-by-reference.

### 3a.1 Sequence

1. **Update the canonical authority.**
   - PRA body: edit `prototype-agents/PRA-XX-*.md` (the canonical
     specification of the role).
   - Canonical adapter: edit `.agents/aisraf-*.agent.md` (capability
     adapter for that PRA).
   - Canonical prompt(s): edit the relevant `prompts/rs/*.prompt.md` or
     `prompts/dfd/*.prompt.md`.
   - Canonical skill(s): edit `skills/rs/SK-*.md` or
     `skills/dfd/SK-DFD-*.md` only if the role logic owns a skill.
   - Canonical template(s): edit `templates/output/*.md` if the role's
     controlled output shape changes.
   - Catalog(s) / blueprint(s): edit `catalogs/*` or `blueprints/*` only
     if a controlled vocabulary or design fact set changes.
   - Registries: update `prototype-agents/prototype-agent-registry.yaml`,
     `prompts/prompt-registry.yaml`, `skills/skill-registry.yaml`, or
     `templates/template-registry.yaml` to reflect the change.
2. **Regenerate the provider projection.**
   - Provider agent projection: regenerate `.github/agents/aisraf-*.agent.md`
     (byte-identical to `.agents/`).
   - Provider Agent Skills package: regenerate `.github/skills/<id>/SKILL.md`.
   - Local skill wrapper / operator card: regenerate
     `.copilot-skills/aisraf-*.skill.md` and the matching operator card.
   - Provider hook config: only update `.github/hooks/aisraf-guardrails.json`
     if the role introduces a new event or behavior.
3. **Update the plugin projection map (K3 / K4 only).**
   - At K3, update the plugin projection assembly plan (`plugin.yaml`
     full field set + bundle target subfolder) so the new / updated role
     is referenced by id, not duplicated by body.
   - At K4, update the `bundle-checksum-manifest.yaml` so the SHA-256
     pair includes the new / updated canonical body.
   - Never hand-edit `plugins/aisraf-copilot-plugin/` files to embed
     canonical content.
4. **Rerun the validators.**
   - `pwsh -NoProfile -File ./tools/Test-AisrafPackage.ps1` — 0 FAIL.
   - `pwsh -NoProfile -File ./tools/Test-AisrafBp12AReadiness.ps1` — 0 FAIL.
   - `pwsh -NoProfile -File ./tools/Test-AisrafRunProfile.ps1 -RunProfilePath ./runs/RUN-001/run-profile.yaml -ExecutionReady` — 12 PASS, 0 FAIL.
   - At K4, rerun the plugin manifest schema validator and the plugin
     lint authored at K4.
5. **Recapture role evidence at WP-12C-L.**
   - Re-run role smoke per `validation/role-smoke-test-checklist.md`.
   - Re-run chat preview per `validation/chat-preview-test-checklist.md`.
   - Re-run hook smoke per `validation/hook-readiness-checklist.md`.
   - Re-run controlled output per
     `validation/package-12c-controlled-output-checklist.md`.
6. **Never hand-copy canonical bodies into plugin files.**
   - Forbidden at every gate (K2, K2A, K3, K4, WP-12C-L, WP-13, WP-14, WP-15).
   - Falsifier: any plugin file containing a canonical body string of
     length ≥ 200 chars.

### 3a.2 Adding A New Role

If a new role is introduced:

1. Author a new canonical PRA under `prototype-agents/`.
2. Author a new canonical adapter under `.agents/`.
3. Author the role's prompts / skills / templates as needed.
4. Update all four registries.
5. Regenerate provider projections (`.github/agents/`, `.github/skills/`,
   `.copilot-skills/`).
6. Add a new row to
   `validation/package-12c-capability-agent-traceability-register.md` so
   the new role threads through the operating law.
7. Add the new role to the plugin projection map at K3 (not before).
8. Validate per §3a.1 step 4 and §3a.1 step 5.

### 3a.3 Forbidden Maintenance Shortcuts

| Shortcut | Why It Is Forbidden |
|---|---|
| Editing a plugin file to change role behavior. | Plugin is a projection; canonical authority is the only place behavior is defined. |
| Copying a PRA / adapter / prompt / skill body into a plugin file. | Falsifier — duplicates source of truth and creates drift. |
| Adding a role to the plugin without a canonical PRA. | Falsifier — there is no source of truth to project from. |
| Skipping the provider projection step. | Provider chat dropdown / `/` skill discovery would diverge from the plugin bundle. |
| Skipping the registry update. | Validators rely on registry presence; bundle would be incomplete. |
| Running install before WP-12C-L opens. | Falsifier — install is the explicit scope of WP-12C-L. |

## 4. What WP-12C-K2 Includes

| Path | Type | Authored By |
|---|---|---|
| `plugins/aisraf-copilot-plugin/README.md` | new | WP-12C-K2 |
| `plugins/aisraf-copilot-plugin/PLUGIN-PACKAGING-PLAN.md` | new (this file) | WP-12C-K2 |
| `plugins/aisraf-copilot-plugin/PLUGIN-TEST-CARD.md` | new | WP-12C-K2 |
| `plugins/aisraf-copilot-plugin/EVIDENCE-CHECKLIST.md` | new | WP-12C-K2 |
| `plugins/aisraf-copilot-plugin/plugin.yaml` | new (minimal, non-executing manifest) | WP-12C-K2 |

Total: **5 files, 0 subfolders, 0 canonical bodies**.

## 5. What WP-12C-K2 Excludes

| Excluded Path | Reason |
|---|---|
| `plugins/README.md` | Forbidden at the `plugins/` root by `Check 16-plugin-content-limits` (only the `aisraf-copilot-plugin/` subfolder is permitted). |
| `plugins/aisraf-copilot-plugin/agents/` | Projection assembly is K3 / K4 work, not K2. |
| `plugins/aisraf-copilot-plugin/skills/` | Projection assembly is K3 / K4 work. |
| `plugins/aisraf-copilot-plugin/hooks/` | Projection assembly is K3 / K4 work. |
| `plugins/aisraf-copilot-plugin/prompts/` | Projection assembly is K3 / K4 work. |
| `plugins/aisraf-copilot-plugin/tools/` | Projection assembly is K3 / K4 work. |
| `plugins/aisraf-copilot-plugin/templates/` | Projection assembly is K3 / K4 work. |
| `plugins/aisraf-copilot-plugin/catalogs/` | Projection assembly is K3 / K4 work. |
| `plugins/aisraf-copilot-plugin/blueprints/` | Projection assembly is K3 / K4 work. |
| `plugins/aisraf-copilot-plugin/registries/` | Projection assembly is K3 / K4 work. |
| `plugins/aisraf-copilot-plugin/validation/` | Projection assembly is K3 / K4 work. |
| `plugins/aisraf-copilot-plugin/evidence/` | Install evidence is captured under WP-12C-L, not K2. |
| `plugins/aisraf-copilot-plugin/mcp/` | No MCP tool is authored at any K gate today. |
| Bundle manifests | `bundle-checksum-manifest.yaml` is K3 / K4 work. |
| Copied canonical files | Forbidden in K2; will be K3 build-script output. |
| Modified provider projection files | Forbidden in K2 — projections remain byte-stable. |
| Modified validators | Forbidden in K2 — K1B-B already opened the allow-list. |
| Modified root authority files | Forbidden in K2 — K1B-A already patched authority. |
| Modified `runs/RUN-001/` | Forbidden — RUN-001 is read-only at this gate. |
| Modified `samples/` | Forbidden — samples are sealed. |
| Modified `prompts/`, `skills/`, `prototype-agents/`, `templates/`, `catalogs/`, `blueprints/`, `config/` | Forbidden — canonical surfaces are sealed. |

## 6. WP-12C-K3A Projection Assembly Contract / Validator Plan

K3A defines the contract only. It does not create a bundle, does not create
plugin subfolders, does not author a build script, does not modify
validators, does not install the plugin, and does not execute role smoke.

### 6.1 Bundle Target Decision

The proposed bundle target path is:

`plugins/aisraf-copilot-plugin/bundle/`

This folder does not exist yet and must not be created in K3A. It remains
blocked until K3B extends validator coverage. K3C may create it only after
the K3B validator patch passes with 0 FAIL.

### 6.2 K3 Projection Assembly Inventory

K3 will eventually bundle the following surfaces by reference into the
proposed `bundle/` target. Targets preserve source-root path shape so drift
checks can compare source and target paths directly.

| Bundle Target Under `plugins/aisraf-copilot-plugin/bundle/` | Source Surface | Projection Rule |
|---|---|---|
| `.github/agents/` | `.github/agents/` | Copy provider agent projections as-is; do not edit provider bodies inside the plugin. |
| `.github/skills/` | `.github/skills/` | Copy provider Agent Skill packages as-is; each package remains a projection of canonical PRA / prompt / skill paths. |
| `.github/hooks/` | `.github/hooks/` | Copy provider hook config as-is; hook logic remains in `tools/hooks/`. |
| `.copilot-skills/` | `.copilot-skills/` | Copy local skill wrappers and operator cards as-is; wrappers stay thin and path-referential. |
| `.agents/` | `.agents/` | Copy canonical adapter specs as source evidence for provider parity; no runtime adapter is authored. |
| `prompts/` | `prompts/` | Copy RS and DFD prompt cards by build script with SHA-256 evidence. |
| `skills/` | `skills/` | Copy RS and DFD canonical skill contracts by build script with SHA-256 evidence. |
| `prototype-agents/` | `prototype-agents/` | Copy PRA specs and registry by build script with SHA-256 evidence. |
| `templates/` | `templates/` | Copy output, run, Jira, and Confluence templates by build script with SHA-256 evidence. |
| `catalogs/` | `catalogs/` | Copy catalog registries and catalog families by build script with SHA-256 evidence. |
| `blueprints/` | `blueprints/` | Copy blueprint registry, template, and blueprint families by build script with SHA-256 evidence. |
| `tools/hooks/` | `tools/hooks/` | Copy reusable hook scripts, hook allow-list, and hook README by build script with SHA-256 evidence. |
| `tools/Test-AisrafPackage.ps1` | `tools/Test-AisrafPackage.ps1` | Copy selected package validator by build script with SHA-256 evidence. |
| `tools/Test-AisrafBp12AReadiness.ps1` | `tools/Test-AisrafBp12AReadiness.ps1` | Copy selected readiness validator by build script with SHA-256 evidence. |
| `tools/Test-AisrafRunProfile.ps1` | `tools/Test-AisrafRunProfile.ps1` | Copy selected run-profile validator by build script with SHA-256 evidence. |

K3A does not add `samples/` or `runs/RUN-001/` to the bundle target. Those
surfaces remain canonical source-of-truth references in the scaffold and
must stay byte-stable unless a later approved brief explicitly changes the
bundle contract and validator allow-lists.

### 6.3 Bundle-By-Reference Rules

1. No hand-copying canonical bodies into plugin files.
2. A future build script performs every source-to-bundle copy.
3. Every copied file receives source path, target path, source SHA-256, and
   target SHA-256 evidence.
4. `bundle-checksum-manifest.yaml` records every source / target hash pair.
5. Source-to-bundle drift is a validator failure.
6. Missing sources, unauthorized targets, copied forbidden paths, or hash
   mismatches fail closed.
7. The plugin remains a projection package. The canonical source of truth
   remains outside `plugins/aisraf-copilot-plugin/`.

### 6.4 Build Script Proposal

The proposed future build script is:

`tools/Build-AisrafCopilotPluginBundle.ps1`

K3A does not create this script. When authorized after K3B, the script
shall:

1. Read a source-to-bundle projection map.
2. Copy only allow-listed source files into
   `plugins/aisraf-copilot-plugin/bundle/`.
3. Calculate SHA-256 for every source and target file.
4. Emit `bundle-checksum-manifest.yaml` in the controlled bundle evidence
   location selected by the K3B validator patch.
5. Fail closed on missing sources, unauthorized targets, hash mismatches,
   copied forbidden paths, or attempts to include sealed fixture paths not
   authorized by the bundle contract.

### 6.5 K3B Validator Extension Plan

K3B must patch validator coverage before K3C creates any bundle folder or
build script.

Required K3B changes:

1. Extend `tools/Test-AisrafPackage.ps1` `Check 16-plugin-content-limits`
   so it keeps the K2 five-file scaffold validation active while allowing
   the controlled `plugins/aisraf-copilot-plugin/bundle/` target only after
   K3B.
2. Extend `tools/Test-AisrafBp12AReadiness.ps1` tracked-drift allow-list to
   cover the future build script and bundle checksum manifest only after
   K3B authorizes their exact paths.
3. Add a future no-canonical-body-duplication lint that rejects canonical
   body substrings copied into plugin files or bundle metadata.
4. Add a future bundle checksum validator that compares every source
   SHA-256 and target SHA-256 in `bundle-checksum-manifest.yaml`.
5. Keep K2 scaffold validation active: the existing five root scaffold files
   remain the only direct files under `plugins/aisraf-copilot-plugin/` unless
   the K3B validator patch explicitly permits another direct file.

K3A does not modify validators. K3C remains blocked until K3B validator
patches pass.

### 6.6 User Experience Preservation

K3 must preserve the K2A operator experience:

- Operator Quick Start.
- Role Journey Map.
- Interactive Smoke Script.
- Role Update / Extension Procedure.
- Future adapter boundary.

Any K3B or K3C patch that weakens those anchors fails K3 even if the
mechanical validators pass.

### 6.7 Future Adapter Boundary

GitHub Copilot remains the current package target. Claude, Microsoft Agent
Framework, Azure AI Foundry, and Google ADK remain WP-15 strategy-only
subjects. No Claude adapter, MAF adapter, Foundry adapter, ADK adapter,
runtime adapter, MCP server, cloud deployment, or external post-back surface
is authored in K3.

### 6.8 Install And Smoke-Test Boundary

K3 does not install the plugin. K3 does not perform post-install discovery,
role smoke execution, controlled output execution, hook smoke, publication,
or release validation. All install and interactive smoke work remains
blocked until WP-12C-L opens after K3 / K4 pass.

## 7. K4 Validation Scope (Current Gate)

K4 validates the package definition and the bundle output produced by K3C.
K4 does **not** install the plugin, does **not** execute interactive smoke,
does **not** publish to Git, does **not** generate diagrams, and does
**not** create release artifacts.

K4 validation covers:

1. `plugin.yaml` manifest schema presence for `plugin_id`, `plugin_name`,
   `version`, `provider`, `package_type`, `lifecycle_status`,
   `canonical_source_references`, `bundle_target`, `checksum_manifest`,
   `install_validation`, `external_execution`, `runtime_claims`, and
   `future_runtime_projection`.
2. `bundle-checksum-manifest.yaml` schema presence for `plugin_id`,
   `work_package`, `bundle_target`, `manifest_path`, `entry_count`,
   `hash_algorithm`, and `entries`; every entry must include `source_path`,
   `target_path`, `source_sha256`, and `target_sha256`.
3. SHA-256 integrity for every manifest row: source exists, target exists,
   recorded source hash matches, recorded target hash matches, and source
   / target hashes match each other.
4. Bundle completeness: no unmanifested bundle files, no source outside the
   approved K3C source list, no target outside
   `plugins/aisraf-copilot-plugin/bundle/`, and no excluded surfaces inside
   the bundle.
5. No-external-execution lint over plugin package metadata and top-level
   plugin files; the bundle may preserve canonical controlled vocabularies,
   but it must not introduce a plugin-level execution claim.
6. Documentation posture: the package remains local-only, role-aware,
   projection-by-reference, and deferred for MCP / Jira / Confluence /
   Lucidchart / Claude / Foundry / ADK / MAF integration.

Existing governed coverage is reused where it already exists:

- `tools/Test-AisrafPackage.ps1` Check 16 validates the plugin content
  boundary and Check 16b validates bundle checksum integrity and
  unmanifested bundle files.
- `tools/Test-AisrafBp12AReadiness.ps1` validates tracked drift and sealed
  surface stability.
- `tools/Test-AisrafRunProfile.ps1 -ExecutionReady` validates RUN-001
  execution readiness without modifying RUN-001.

No standalone root-level K4 validator file is authored unless the existing
`tools/` allow-list is reopened by an approved validator patch. That keeps
the current package validators green while K4 performs the required
read-only validation. K4 validates; WP-12C-L installs and smoke-tests only
after K4 is accepted.

### 7.1 K4 Closeout Result

K4 completed as package validation only. Plugin manifest schema validation,
bundle checksum manifest schema validation, 199-entry hash integrity,
bundle completeness, no-external-execution lint, UX / documentation posture,
the governed validator ladder, and Git hygiene all passed. No plugin install,
interactive smoke, external execution, diagram generation, release artifact,
Git publication, or staging action occurred.

Final status:
`WP-12C-K4_PLUGIN_PACKAGE_VALIDATION_PASS_READY_FOR_INSTALL_TESTING`.
Parent WP-12C-K status:
`WP-12C-K_PACKAGE_COMPLETE_READY_FOR_INSTALL_READINESS_PREFLIGHT`.
WP-12C-L0 is next only after explicit approval; WP-12C-L1, WP-12C-L2,
WP-12C-L3, and WP-13 remain blocked.

## 8. WP-12C-L Install Validation Plan (Placeholder — Not Authored Here)

WP-12C-L will, in a separate brief, author:

1. The install + post-install evidence checklist under
   `validation/package-12c-plugin-install-and-publication-checklist.md`.
2. Install transcripts (clean operator environment, install command,
   discovery output, role smoke output, chat preview output, hook smoke
   output, validator output).
3. The Git-publication checklist (when, where, what, who).
4. The post-install verdict
   `WP-12C-L_PLUGIN_INSTALL_AND_PUBLICATION_READY`.

No install attempt occurs before WP-12C-L opens.

## 9. Future Claude Adapter — Deferred To WP-15

A future Anthropic Claude runtime adapter (Claude Agent SDK / Claude Code
plugin / Claude API tool-use) is **explicitly deferred to WP-15**. WP-15 is
documented in `validation/package-12c-plugin-roadmap.md` §7b as a
**strategy-only** gate. It does not author or implement any runtime
adapter. It documents per-runtime translation rules for Microsoft Agent
Framework, Azure AI Foundry, Google ADK, and Anthropic Claude as
descriptive future projections.

This K2 scaffold authors **no Claude adapter file**. The plugin under
`plugins/aisraf-copilot-plugin/` is a GitHub Copilot projection only.

## 10. Source-Of-Truth Rules (Restated For Falsifiability)

| Rule | Falsifier |
|---|---|
| The plugin is a projection, not the source of truth. | A plugin file containing a canonical body block byte-for-byte (substring length ≥ 200 chars). |
| K2 creates scaffold only. | A plugin subfolder created during K2. |
| Bundling is by reference, not by hand-edit. | A canonical body literal copied into a plugin file. |
| Install validation is deferred to WP-12C-L. | An install transcript or post-install evidence captured before WP-12C-L opens. |
| External execution is disabled. | A plugin file claiming runtime, cloud, MCP, ADK, Foundry, Claude, Jira, Confluence, database, Terraform, or post-back execution. |
| Memory is run-scoped only. | Any persistent agent-side memory introduced by the plugin. |

## 11. Stop Conditions

Halt scaffold authoring and escalate to the founder if any of the
following becomes true:

- A canonical body has been copied into a plugin file.
- A plugin subfolder has been created in K2.
- A plugin file claims external execution.
- An install attempt has been made before WP-12C-L opens.
- `runs/RUN-001/` or `samples/` has been modified by plugin authoring.
- A sealed canonical or projection surface has been modified by plugin
  authoring.
- `diagrams/` or `release/` has been touched by plugin authoring.
- A Claude adapter has been authored ahead of WP-15.
