---
plugin_id: aisraf-copilot-plugin
work_package: WP-12C-K4
lifecycle_status: packaged_not_installed
evidence_status: plugin_package_validation_defined
external_execution: disabled
postback_execution_status: deferred
output_destination_mode: local_only
runtime_claims: none
---

# AISRAF Copilot Plugin — Evidence Checklist (WP-12C-K4 Package Validation)

## 1. Purpose

This checklist defines the evidence rows that must hold true at WP-12C-K2
close, the K2A UX / operability audit, the K3 projection assembly gates,
and the current K4 plugin package validation gate. This checklist does not
author install evidence, post-install transcripts, diagrams, publication
evidence, or release artifacts.

## 2. K2 Required Evidence (Today)

### 2.1 Files Created

| # | File | Required At K2 | Status |
|---|---|---|---|
| K2-F1 | `plugins/aisraf-copilot-plugin/README.md` | Yes | TO BE VERIFIED AT K2 CLOSE |
| K2-F2 | `plugins/aisraf-copilot-plugin/PLUGIN-PACKAGING-PLAN.md` | Yes | TO BE VERIFIED AT K2 CLOSE |
| K2-F3 | `plugins/aisraf-copilot-plugin/PLUGIN-TEST-CARD.md` | Yes | TO BE VERIFIED AT K2 CLOSE |
| K2-F4 | `plugins/aisraf-copilot-plugin/EVIDENCE-CHECKLIST.md` | Yes (this file) | TO BE VERIFIED AT K2 CLOSE |
| K2-F5 | `plugins/aisraf-copilot-plugin/plugin.yaml` | Yes | TO BE VERIFIED AT K2 CLOSE |

### 2.2 Files Forbidden At K2

| # | Forbidden Path | Reason |
|---|---|---|
| K2-X1 | `plugins/README.md` | `Check 16-plugin-content-limits` forbids files at the `plugins/` root other than the `aisraf-copilot-plugin/` subfolder. |
| K2-X2 | `plugins/aisraf-copilot-plugin/agents/` | Projection assembly is K3 / K4 work. |
| K2-X3 | `plugins/aisraf-copilot-plugin/skills/` | Projection assembly is K3 / K4 work. |
| K2-X4 | `plugins/aisraf-copilot-plugin/hooks/` | Projection assembly is K3 / K4 work. |
| K2-X5 | `plugins/aisraf-copilot-plugin/prompts/` | Projection assembly is K3 / K4 work. |
| K2-X6 | `plugins/aisraf-copilot-plugin/tools/` | Projection assembly is K3 / K4 work. |
| K2-X7 | `plugins/aisraf-copilot-plugin/templates/` | Projection assembly is K3 / K4 work. |
| K2-X8 | `plugins/aisraf-copilot-plugin/catalogs/` | Projection assembly is K3 / K4 work. |
| K2-X9 | `plugins/aisraf-copilot-plugin/blueprints/` | Projection assembly is K3 / K4 work. |
| K2-X10 | `plugins/aisraf-copilot-plugin/registries/` | Projection assembly is K3 / K4 work. |
| K2-X11 | `plugins/aisraf-copilot-plugin/validation/` | Projection assembly is K3 / K4 work. |
| K2-X12 | `plugins/aisraf-copilot-plugin/evidence/` | Install evidence is captured under WP-12C-L. |
| K2-X13 | `plugins/aisraf-copilot-plugin/mcp/` | No MCP tool authored at any K gate today. |
| K2-X14 | Any `bundle-checksum-manifest.yaml` | K3 / K4 artifact, not K2. |
| K2-X15 | Any copied canonical body | Forbidden at K2; bundling is K3 build-script output. |

### 2.3 Validators Run At K2 Close

| # | Validator | Expected Result | Status |
|---|---|---|---|
| K2-V1 | `pwsh -NoProfile -File ./tools/Test-AisrafPackage.ps1` | 0 FAIL | TO BE VERIFIED AT K2 CLOSE |
| K2-V2 | `pwsh -NoProfile -File ./tools/Test-AisrafBp12AReadiness.ps1` | 0 FAIL | TO BE VERIFIED AT K2 CLOSE |
| K2-V3 | `pwsh -NoProfile -File ./tools/Test-AisrafRunProfile.ps1 -RunProfilePath ./runs/RUN-001/run-profile.yaml -ExecutionReady` | 12 PASS, 0 FAIL | TO BE VERIFIED AT K2 CLOSE |

### 2.4 Git Hygiene At K2 Close

| # | Check | Expected | Status |
|---|---|---|---|
| K2-G1 | `git status --short` shows the 5 K2 scaffold files as untracked or modified, no other unexpected paths. | Clean of unexpected paths. | TO BE VERIFIED AT K2 CLOSE |
| K2-G2 | `git diff --staged --name-only` shows nothing staged. | Empty output. | TO BE VERIFIED AT K2 CLOSE |
| K2-G3 | `.claude/` is not tracked. | `git ls-files -- .claude` empty. | TO BE VERIFIED AT K2 CLOSE |
| K2-G4 | `.claude/` is not staged. | `git diff --cached --name-only -- .claude` empty. | TO BE VERIFIED AT K2 CLOSE |
| K2-G5 | `runs/RUN-001/` is byte-stable. | `git diff -- runs/RUN-001/` empty. | TO BE VERIFIED AT K2 CLOSE |
| K2-G6 | `samples/` is byte-stable. | `git diff -- samples/` empty. | TO BE VERIFIED AT K2 CLOSE |
| K2-G7 | Sealed canonical surfaces are byte-stable: `prompts/`, `skills/`, `prototype-agents/`, `templates/`, `catalogs/`, `blueprints/`, `config/`, `.agents/`. | `git diff -- prompts/ skills/ prototype-agents/ templates/ catalogs/ blueprints/ config/ .agents/` empty. | TO BE VERIFIED AT K2 CLOSE |
| K2-G8 | Provider projection surfaces are byte-stable: `.github/agents/`, `.github/skills/`, `.github/hooks/`, `.copilot-skills/`. | `git diff -- .github/agents/ .github/skills/ .github/hooks/ .copilot-skills/` empty. | TO BE VERIFIED AT K2 CLOSE |
| K2-G9 | No `git add .`, `git add -A`, or `git commit` action is taken in K2 by the scaffold author. | Author confirms in K2 final report. | TO BE VERIFIED AT K2 CLOSE |

### 2.5 K2A UX / Operability Evidence (WP-12C-K2A)

These rows are added by the WP-12C-K2A audit. They do **not** open K3,
do **not** assemble bundles, and do **not** install or test the plugin.
They confirm that the K2 scaffold is practical, modular, scalable,
role-aware, and ready for K3 projection planning.

| # | UX / Operability Row | Required At K2A | Status |
|---|---|---|---|
| K2A-U1 | `README.md` §0 Operator Quick Start present and answers: what this folder is, what it is not, what gate, what to run next, what is blocked, what PASS means, when to stop and escalate. | Yes | TO BE VERIFIED AT K2A CLOSE |
| K2A-U2 | `README.md` §4a Role Journey Map present and names all seven roles: founder / package owner, security reviewer, solution / security architect, operator / tester, plugin maintainer, agent / skill author, future adapter owner. | Yes | TO BE VERIFIED AT K2A CLOSE |
| K2A-U3 | `README.md` §4b Layered Projection Model present and shows the five-layer chain (canonical → provider projection → plugin package projection → install validation → release evidence). | Yes | TO BE VERIFIED AT K2A CLOSE |
| K2A-U4 | `PLUGIN-PACKAGING-PLAN.md` §3a Role Update / Extension Procedure present and lists: update canonical, regenerate provider projection, update plugin projection map at K3 / K4, rerun validators, never hand-copy canonical bodies. | Yes | TO BE VERIFIED AT K2A CLOSE |
| K2A-U5 | `PLUGIN-TEST-CARD.md` §3.0 Future Interactive Smoke Script present and covers role smoke, chat preview, hook smoke, controlled output, and negative posture rows. Every row is `DEFERRED — to WP-12C-L`. | Yes | TO BE VERIFIED AT K2A CLOSE |
| K2A-U6 | `plugin.yaml` `audit_k2a:` block present and references K2A audit anchors. | Yes | TO BE VERIFIED AT K2A CLOSE |
| K2A-U7 | Future adapter boundary (Claude / MAF / Foundry / ADK) remains deferred to WP-15 in every K2 file. | Yes | TO BE VERIFIED AT K2A CLOSE |
| K2A-U8 | All three validators run with 0 FAIL after K2A patches. | Yes | TO BE VERIFIED AT K2A CLOSE |
| K2A-U9 | Git hygiene clean: only the five K2 scaffold files modified; no canonical / sealed / provider-projection surface modified; nothing staged; `.claude/` not tracked. | Yes | TO BE VERIFIED AT K2A CLOSE |
| K2A-U10 | No plugin subfolder created. | Yes | TO BE VERIFIED AT K2A CLOSE |
| K2A-U11 | No canonical body copied into a plugin file (≥ 200-char body literal forbidden). | Yes | TO BE VERIFIED AT K2A CLOSE |
| K2A-U12 | K3 remains blocked until K2A passes; WP-12C-L remains blocked until K3 / K4 pass; WP-13 remains blocked until WP-12C-L passes. | Yes | TO BE VERIFIED AT K2A CLOSE |

### 2.5A K3A Projection Assembly Contract Evidence (WP-12C-K3A)

These rows are added by WP-12C-K3A. They define the assembly contract and
validator plan only. They do not open K3B, create the bundle target, author
the build script, patch validators, install the plugin, or execute smoke.

| # | K3A Evidence Row | Required At K3A | Status |
|---|---|---|---|
| K3A-E1 | `PLUGIN-PACKAGING-PLAN.md` names the K3 projection assembly inventory: `.github/agents/`, `.github/skills/`, `.github/hooks/`, `.copilot-skills/`, `.agents/`, `prompts/`, `skills/`, `prototype-agents/`, `templates/`, `catalogs/`, `blueprints/`, `tools/hooks/`, and selected validators. | Yes | TO BE VERIFIED AT K3A CLOSE |
| K3A-E2 | Proposed bundle target is `plugins/aisraf-copilot-plugin/bundle/`; the folder does not exist and remains blocked until K3B validator coverage exists. | Yes | TO BE VERIFIED AT K3A CLOSE |
| K3A-E3 | Bundle-by-reference rules require build-script copy, source path, target path, source SHA-256, target SHA-256, checksum manifest, and fail-closed drift behavior. | Yes | TO BE VERIFIED AT K3A CLOSE |
| K3A-E4 | Proposed build script is named `tools/Build-AisrafCopilotPluginBundle.ps1`; it is proposed only and not created in K3A. | Yes | TO BE VERIFIED AT K3A CLOSE |
| K3A-E5 | K3B validator requirements are explicit: extend `Check 16-plugin-content-limits`, extend BP12A tracked-drift for exact future paths, add no-canonical-body-duplication lint, add bundle checksum validation, and keep K2 five-file scaffold validation active. | Yes | TO BE VERIFIED AT K3A CLOSE |
| K3A-E6 | UX preservation is explicit: Operator Quick Start, Role Journey Map, Interactive Smoke Script, Role Update / Extension Procedure, and Future adapter boundary must survive K3. | Yes | TO BE VERIFIED AT K3A CLOSE |
| K3A-E7 | Future adapter boundary is explicit: Copilot remains current package target; Claude / MAF / Foundry / ADK remain WP-15 strategy only; no Claude adapter file is authored in K3. | Yes | TO BE VERIFIED AT K3A CLOSE |
| K3A-E8 | Install and smoke-test boundary is explicit: no install, post-install discovery, role smoke, controlled output, hook smoke, publication, or release validation occurs in K3. | Yes | TO BE VERIFIED AT K3A CLOSE |
| K3A-E9 | No plugin subfolder, bundle folder, build script, bundle manifest, provider projection edit, validator edit, `RUN-001` edit, sample edit, diagram, release artifact, install attempt, or Git staging occurs in K3A. | Yes | TO BE VERIFIED AT K3A CLOSE |
| K3A-E10 | All three governed validators run after K3A edits with 0 FAIL, with the known local smoke-folder warning remaining the only WARN if present. | Yes | TO BE VERIFIED AT K3A CLOSE |
| K3A-E11 | Git hygiene confirms `.claude` remains untracked and unstaged; no canonical / sealed / provider-projection surface is modified. | Yes | TO BE VERIFIED AT K3A CLOSE |

### 2.5B K3A Closeout Note (WP-12C-K3A-FIX)

- K3A contract was completed.
- K3B is next.
- K3C remains blocked.
- No bundle folder was created.
- No build script was created.
- No bundle checksum manifest was created.
- No validators were patched in K3A.
- Validators passed with 0 FAIL.
- The smoke-folder WARN remains known and non-blocking.
- WP-12C-L and WP-13 remain blocked.

### 2.5C K3B Validator Patch Scope Confirmation

K3B may prepare only these exact future paths:

- `tools/Build-AisrafCopilotPluginBundle.ps1`
- `plugins/aisraf-copilot-plugin/bundle/`
- `plugins/aisraf-copilot-plugin/bundle-checksum-manifest.yaml`

K3B must not authorize broad `plugins/**` drift or content allowances.

### 2.5D K3B Validator Patch Note (WP-12C-K3B)

- K3B patched validators only.
- K3C is still blocked until validator results pass.
- No bundle folder was created in K3B.
- No build script was created in K3B.
- No bundle checksum manifest was created in K3B.
- WP-12C-L and WP-13 remain blocked.

### 2.5E K3C-FIX Validator Coverage Note (WP-12C-K3C-FIX)

- K3C build artifacts exist.
- K3C was blocked because Check 07 was not bundle-aware.
- K3C-FIX patched validator coverage only.
- Approved bundle projections under `plugins/aisraf-copilot-plugin/bundle/`
  are recognized without broad `plugins/**` authorization.
- K4 remains blocked until validators pass and K3C is accepted.
- WP-12C-L and WP-13 remain blocked.

### 2.5F K4 Package Validation Evidence (WP-12C-K4)

These rows are added by WP-12C-K4. They validate the plugin manifest,
bundle checksum manifest, hash integrity, package lint, documentation
posture, and Git hygiene before install testing is allowed. They do not
install the plugin, execute role smoke, start WP-12C-L, start WP-13,
generate diagrams, create release artifacts, publish to Git, or stage
`.claude/`.

| # | K4 Evidence Row | Required At K4 | Status |
|---|---|---|---|
| K4-E1 | `plugin.yaml` contains K4-required manifest fields: `plugin_id`, `plugin_name`, `version`, `provider`, `package_type`, `lifecycle_status`, `canonical_source_references`, `bundle_target`, `checksum_manifest`, `install_validation`, `external_execution`, `runtime_claims`, and `future_runtime_projection`. | Yes | PASS — VERIFIED AT K4 CLOSE |
| K4-E2 | `bundle-checksum-manifest.yaml` contains required manifest fields: `plugin_id`, `work_package`, `bundle_target`, `manifest_path`, `entry_count`, `hash_algorithm`, and `entries`. | Yes | PASS — VERIFIED AT K4 CLOSE |
| K4-E3 | Every checksum manifest entry contains `source_path`, `target_path`, `source_sha256`, and `target_sha256`. | Yes | PASS — VERIFIED AT K4 CLOSE |
| K4-E4 | Every manifest source exists, every manifest target exists, every recorded SHA-256 matches the current file, and every source / target pair matches. | Yes | PASS — VERIFIED AT K4 CLOSE |
| K4-E5 | No file under `plugins/aisraf-copilot-plugin/bundle/` exists without a checksum manifest entry. | Yes | PASS — VERIFIED AT K4 CLOSE |
| K4-E6 | Bundle sources stay in the K3C approved source list and bundle targets stay under `plugins/aisraf-copilot-plugin/bundle/`. | Yes | PASS — VERIFIED AT K4 CLOSE |
| K4-E7 | Excluded surfaces are absent from the bundle: samples, runs, smoke runs, diagrams, docs, release files, `.git`, `.claude`, and plugin self-copy. | Yes | PASS — VERIFIED AT K4 CLOSE |
| K4-E8 | No plugin-level external execution claim exists in plugin package metadata or bundle metadata. | Yes | PASS — VERIFIED AT K4 CLOSE |
| K4-E9 | Documentation posture remains clear: plugin value, later user interaction, local-only inputs / outputs, roles, projection of agents / skills / hooks, deferred MCP / Jira / Confluence / Lucidchart integrations, and deferred Claude / Foundry / ADK / MAF strategy. | Yes | PASS — VERIFIED AT K4 CLOSE |
| K4-E10 | The three governed validators run with 0 FAIL after K4 edits. | Yes | PASS — VERIFIED AT K4 CLOSE |
| K4-E11 | Git hygiene confirms nothing staged, `.claude/` untracked and unstaged, `RUN-001` unchanged, samples unchanged, and canonical / provider projection surfaces unchanged. | Yes | PASS — VERIFIED AT K4 CLOSE |
| K4-E12 | WP-12C-L remains blocked until K4 is accepted; WP-13 remains blocked. | Yes | PASS — VERIFIED AT K4 CLOSE |

### 2.5G K4 Closeout Note (WP-12C-K4)

- K4 package validation completed without install testing.
- Plugin manifest schema validation passed.
- Bundle checksum manifest schema validation passed with 199 entries.
- Hash integrity passed for all source / target pairs.
- Bundle completeness passed: no unmanifested bundle files, no source outside
  the K3C approved source list, no target outside the bundle, and no excluded
  surfaces inside the bundle.
- No plugin-level external execution claim was found in plugin metadata or
  bundle checksum metadata.
- UX / documentation posture remains local-only, role-aware,
  projection-by-reference, and deferred for future integrations.
- The three governed validators passed with 0 FAIL.
- Git hygiene passed: nothing staged, `.claude/` untracked and unstaged,
  `RUN-001` unchanged, samples unchanged, and sealed canonical / provider
  projection surfaces unchanged.
- Final status:
  `WP-12C-K4_PLUGIN_PACKAGE_VALIDATION_PASS_READY_FOR_INSTALL_TESTING`.
- Parent WP-12C-K status accepted as:
  `WP-12C-K_PACKAGE_COMPLETE_READY_FOR_INSTALL_READINESS_PREFLIGHT`.
- WP-12C-L0 is next only after explicit approval; WP-12C-L1, WP-12C-L2,
  WP-12C-L3, and WP-13 remain blocked.

### 2.5H L1A Provider Install Surface Patch Note (WP-12C-L1A)

- L1A created provider-required `plugin.json`.
- `plugin.json` points to bundled agents, bundled skills, and bundled hook config.
- No MCP/external execution/post-back runtime was enabled.
- True L1 install remains blocked until L1A is accepted.

### 2.6 Stop-Condition Posture At K2 Close

| # | Stop Condition | Status |
|---|---|---|
| K2-S1 | No canonical body has been copied into a plugin file. | TO BE VERIFIED AT K2 CLOSE |
| K2-S2 | No plugin subfolder created. | TO BE VERIFIED AT K2 CLOSE |
| K2-S3 | No plugin file claims external execution. | TO BE VERIFIED AT K2 CLOSE |
| K2-S4 | No install attempt has been made. | TO BE VERIFIED AT K2 CLOSE |
| K2-S5 | `runs/RUN-001/` unchanged. | TO BE VERIFIED AT K2 CLOSE |
| K2-S6 | `samples/` unchanged. | TO BE VERIFIED AT K2 CLOSE |
| K2-S7 | Sealed canonical and projection surfaces unchanged. | TO BE VERIFIED AT K2 CLOSE |
| K2-S8 | `diagrams/` and `release/` not touched. | TO BE VERIFIED AT K2 CLOSE |
| K2-S9 | No Claude adapter authored ahead of WP-15. | TO BE VERIFIED AT K2 CLOSE |

## 3. Gate Blocking Posture

| Gate | Current Status | Unblocking Condition |
|---|---|---|
| WP-12C-K2A | BLACK / CLOSED | Accepted status `WP-12C-K2A_UX_OPERABILITY_PASS_READY_FOR_K3` |
| WP-12C-K3A | BLACK / CLOSED | Contract documented in the existing scaffold files + validators 0 FAIL + no bundle / subfolder / validator edit |
| WP-12C-K3B | BLACK / CLOSED | Validator patches pass with 0 FAIL and explicitly allow exact build-script / bundle-manifest / bundle-target paths |
| WP-12C-K3C | BLACK / CLOSED | Status `WP-12C-K3C_BUNDLE_ASSEMBLY_PASS_READY_FOR_K4` |
| WP-12C-K4 | BLACK / CLOSED | Status `WP-12C-K4_PLUGIN_PACKAGE_VALIDATION_PASS_READY_FOR_INSTALL_TESTING` |
| WP-12C-K | PACKAGE COMPLETE / READY FOR INSTALL READINESS PREFLIGHT | Status `WP-12C-K_PACKAGE_COMPLETE_READY_FOR_INSTALL_READINESS_PREFLIGHT` |
| WP-12C-L0 | NEXT | Explicit approval required before terminal / hook hygiene preflight; no install or interactive smoke |
| WP-12C-L1 | BLOCKED | Blocked until WP-12C-L0 closes |
| WP-12C-L2 | BLOCKED | Blocked until WP-12C-L1 closes |
| WP-12C-L3 | BLOCKED | Blocked until WP-12C-L2 closes |
| WP-13 | **BLOCKED until WP-12C-L PASSes** | WP-12C-L install + post-install transcripts captured |
| WP-14 | FUTURE | WP-13 close + founder approval |
| WP-15 | FUTURE | WP-14 close + founder approval; WP-15 is strategy-only |

## 4. Deferred Evidence (Not Captured In K2)

### 4.1 K3A Evidence (Current Contract Gate)

- Projection assembly contract documented in `PLUGIN-PACKAGING-PLAN.md`.
- Proposed bundle target recorded as
  `plugins/aisraf-copilot-plugin/bundle/`, not created.
- Proposed build script recorded as
  `tools/Build-AisrafCopilotPluginBundle.ps1`, not created.
- K3B validator patch requirements documented.
- K3C bundle assembly remains blocked until K3B passes.

### 4.1B K3B Evidence (Future Validator Patch Gate)

- `tools/Test-AisrafPackage.ps1` extends `Check 16-plugin-content-limits`
  to allow the controlled K3 bundle target while preserving the K2 five-file
  scaffold rule.
- `tools/Test-AisrafBp12AReadiness.ps1` extends tracked-drift allow-list for
  exact future build-script and bundle-manifest paths.
- Future no-canonical-body-duplication lint is specified or authored per the
  approved K3B brief.
- Future bundle checksum validator is specified or authored per the approved
  K3B brief.

### 4.1C K3C Evidence (Future Assembly Gate)

- Build script authored under `tools/` only after K3B passes.
- Bundle target subfolder created only after K3B passes.
- `bundle-checksum-manifest.yaml` produced by the build script.
- Zero canonical-body duplication confirmed.

### 4.2 K4 Evidence (Current Validation Gate)

- Plugin manifest schema validation is captured by K4 closeout checks.
- Plugin package lint is captured by K4 closeout checks.
- Bundle checksum and source / target SHA-256 validation are covered by
  `tools/Test-AisrafPackage.ps1` Check 16b plus K4 closeout checks.
- K4 does not install the plugin and does not execute interactive smoke.

### 4.3 WP-12C-L Evidence (Future)

- `validation/package-12c-plugin-install-and-publication-checklist.md`
  authored.
- Install transcript (clean operator environment).
- Post-install discovery transcript.
- Post-install role smoke transcript.
- Post-install chat preview transcript.
- Post-install hook smoke transcript.
- Post-install validator transcripts (all 0 FAIL).
- Canonical surfaces byte-stable inside and outside the install target.
- Git-publication checklist completed (when, where, what, who).
- Verdict `WP-12C-L_PLUGIN_INSTALL_AND_PUBLICATION_READY` recorded.

## 5. Cross-References

- `validation/package-12c-plugin-roadmap.md` — Roadmap and packaging
  contract (canonical authority for K0 through WP-15).
- `validation/package-12c-solution-package-architecture.md` — Authority
  chain, posture statements, MCP rules.
- `tools/Test-AisrafPackage.ps1` — Package validator
  (`Check 16-plugin-content-limits`).
- `tools/Test-AisrafBp12AReadiness.ps1` — Readiness validator
  (`tracked-drift` and `sealed-surface-drift`).
- `tools/Test-AisrafRunProfile.ps1` — Run profile validator.
- `PACKAGE-MANIFEST.yaml` — Build-package state and gate posture.
- `BUILD-ORDER.md` — Build-package ordering.
- `FOLDER-CONTRACTS.md` — Folder-contract authority.

## 6. Stop Conditions

Halt and escalate if any of the following becomes true at any time during
or after K2 close:

- Any K2-F* file is missing.
- Any K2-X* forbidden path appears.
- Any K2-V* validator returns a non-zero FAIL count.
- Any K2-G* git-hygiene row reports unexpected output.
- Any K2-S* stop-condition row fails.
- A future gate proceeds before its blocking condition above clears.
