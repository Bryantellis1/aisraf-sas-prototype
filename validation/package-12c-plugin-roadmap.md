# Build Package 12C — Plugin Roadmap (WP-12C-I → WP-12C-J → WP-12C-K → WP-12C-L → WP-13)

| Field | Value |
|---|---|
| Document name | AISRAF Plugin Roadmap |
| Work package | WP-12C-I — Solution Package Architecture & Agent Specification Alignment |
| Status | DRAFT — roadmap; no plugin authored or packaged by this document |
| Audience | Founder, plugin packager, plugin install tester, runtime adapter implementer, reviewer |
| Purpose | Define the work-package ladder from the current state to a fully validated, installable Copilot plugin and a published Git release, with each gate's inputs, outputs, evidence, and exit criteria |
| Companion | `validation/package-12c-solution-package-architecture.md`, `validation/package-12c-agent-spec-template.md`, `validation/package-12c-capability-agent-traceability-register.md`, `validation/package-12c-platform-projection-matrix.md` |

## 1. Read Before Anything Else

- This roadmap **does not author** the plugin manifest, plugin install bundle, or plugin install validator. It defines the path; it does not walk it.
- **The plugin is a projection, not the source of truth.** Canonical authority remains in registries, PRAs, prompts, skills, templates, catalogs, blueprints, run profiles, validation, and `tools/Test-*.ps1`.
- **No plugin without a canonical source package.** A plugin that does not bundle by reference (post-build script) and instead duplicates canonical bodies is rejected.
- **No plugin release without evidence.** Plugin install + post-install discovery + smoke + hook + validator must all PASS, captured per the install test card to be authored in WP-12C-L.
- **Plugin packaging starts only after sample preview and controlled scratch-output tests pass** (WP-12C-J exit).
- **Git publication starts only after plugin install tests pass** (WP-12C-L exit).

## 2. Roadmap Ladder

```
WP-12C-I  -> WP-12C-J  -> WP-12C-K  -> WP-12C-L  -> WP-13       -> WP-14            -> WP-15
(this)       sample +     plugin       plugin        diagram &      IG1500-style       future runtime
             scratch      packaging    install +     release        solution           projection
             output                    release       view pack      package release    strategy only
                                       validation                   pack                (no runtime
                                                                                         authored)
```

Each ladder step lists: goal, inputs, outputs, files allowed, files forbidden, tests required, evidence required, exit criteria, next gate.

## 3. WP-12C-I — Solution Package Architecture & Agent Specification Alignment (this work package)

| Field | Value |
|---|---|
| Goal | Anchor AISRAF as a canonical solution package with platform-independent agents, skills, hooks, memory, evaluation, evidence, and platform projection rules; provide an agent-spec template and a capability-to-agent traceability register; provide a platform projection matrix; provide this plugin roadmap |
| Inputs (read-only) | Operator-experience plan; proposed file tree; quick + sample input/output + manual operator test cards; registries; PRAs; canonical adapters; provider projections; hooks; validators |
| Outputs (new files in `validation/`) | `package-12c-solution-package-architecture.md`, `package-12c-agent-spec-template.md`, `package-12c-capability-agent-traceability-register.md`, `package-12c-platform-projection-matrix.md`, `package-12c-plugin-roadmap.md` |
| Files allowed (write) | the 5 new `validation/*.md` files above; surgical update to `tools/Test-AisrafPackage.ps1` allow-list; surgical update to `tools/Test-AisrafBp12AReadiness.ps1` only if drift list extension is required |
| Files forbidden | `prompts/`, `skills/`, `prototype-agents/`, `.agents/`, `.github/agents/`, `catalogs/`, `blueprints/`, `templates/`, `samples/`, `runs/RUN-001/`, `.claude/`, BP13 assets, plugin manifest, plugin scaffolding, MAF/Foundry/ADK adapter scaffolding |
| Tests required | `Test-AisrafPackage.ps1` 0 FAIL; `Test-AisrafBp12AReadiness.ps1` 0 FAIL; `Test-AisrafRunProfile.ps1 -ExecutionReady` 12 PASS, 0 FAIL |
| Evidence required | the 5 alignment files exist; validator output captured |
| Exit criteria | `WP-12C-I_READY_FOR_SAMPLE_PREVIEW_TESTING` |
| Next gate | WP-12C-J |

## 4. WP-12C-J — Sample Preview & Controlled Scratch Output Validation

| Field | Value |
|---|---|
| Goal | Capture per-row PASS / FAIL evidence for the sample input/output preview test card and (after explicit founder approval) the controlled scratch-output checklist over `runs/RUN-SMOKE-LOCAL-XXX/` |
| Inputs (read-only) | `package-12c-sample-input-output-test-card.md`, `package-12c-quick-manual-test-card.md`, `package-12c-controlled-output-checklist.md`, sample-001 inputs/expected, RUN-001 inputs and run-profile (read-only), all 7 agents and 7 skill packages, the 4 hooks |
| Outputs | per-row evidence captures (chat transcripts, `git status --short` snapshots) inside the test card evidence worksheets; if Mode B is approved, governed scratch run folder under `runs/RUN-SMOKE-LOCAL-XXX/` |
| Files allowed (write) | evidence-worksheet edits in the existing test cards; if Mode B approved, only `runs/RUN-SMOKE-LOCAL-XXX/...` paths matching `tools/hooks/hook-allow-list.yaml` |
| Files forbidden | any sealed surface; any file in `runs/RUN-001/`; any new validation/*.md beyond the existing controlled-output / regression / operator-card-usability checklists; any plugin manifest |
| Tests required | sample input preview (7 PASS); sample output shape (7 PASS); validators 0 FAIL; if Mode B approved, controlled-output checklist; regression checklist; operator-card usability checklist |
| Evidence required | every row in the sample input/output test card marked PASS or PROVIDER LIMITATION; `runs/RUN-001/` byte-stable before, during, and after every test; if Mode B approved, scratch-run output set + validator transcripts |
| Exit criteria | `WP-12C-J_SAMPLE_PREVIEW_AND_CONTROLLED_OUTPUT_PASS` |
| Next gate | Closed: WP-12C-K; current next gate is WP-12C-L0 |

## 5. WP-12C-K — Copilot Plugin Packaging

| Field | Value |
|---|---|
| Goal | Author the plugin manifest, build a thin install bundle that references canonical assets, validate package lint/checksums, and provide a plugin README + plugin test card |
| Inputs (read-only) | every canonical asset; every provider projection; the 5 WP-12C-I alignment artifacts; the WP-12C-J evidence; the 4 hooks |
| Outputs | plugin manifest, packaged projection bundle under `plugins/aisraf-copilot-plugin/bundle/`, checksum manifest, plugin README, packaging plan, evidence checklist, and plugin test card |
| Files allowed (write) | the new plugin scaffolding folder and its contents; surgical updates to `tools/Test-AisrafPackage.ps1` and `tools/Test-AisrafBp12AReadiness.ps1` to bring the plugin scaffolding under their allow-lists |
| Files forbidden | rewriting any canonical asset; copying a canonical body into a plugin file (the plugin must reference canonical paths or include them via build script, not by hand-edit); modifying `runs/RUN-001/`; modifying sealed BP12B evidence; authoring MAF/Foundry/ADK adapters (those are WP-12C-F and later) |
| Tests required | plugin manifest schema validation; bundle checksum manifest validation; hash integrity; bundle completeness; no-external-execution lint; UX/documentation posture; package validator + BP12A readiness + RUN-001 readiness all 0 FAIL |
| Evidence required | plugin manifest validates; checksum manifest has 199 complete entries; all source/target SHA-256 pairs match; no unmanifested bundle files exist; canonical/provider surfaces, `runs/RUN-001/`, and `samples/` are byte-stable; nothing staged |
| Exit criteria | `WP-12C-K_PACKAGE_COMPLETE_READY_FOR_INSTALL_READINESS_PREFLIGHT` |
| Next gate | WP-12C-L0 |

Accepted closeout statuses:

- WP-12C-K4: `WP-12C-K4_PLUGIN_PACKAGE_VALIDATION_PASS_READY_FOR_INSTALL_TESTING`
- WP-12C-K: `WP-12C-K_PACKAGE_COMPLETE_READY_FOR_INSTALL_READINESS_PREFLIGHT`

WP-12C-L0 is next only after explicit approval. WP-12C-L1, WP-12C-L2,
WP-12C-L3, and WP-13 remain blocked.

## 6. WP-12C-L — Plugin Install & Release Validation

| Field | Value |
|---|---|
| Goal | Install the packaged plugin into a clean operator environment; run discovery, role smoke, chat preview, sample input/output preview, hook smoke, and validator ladder against the *installed* plugin; capture install evidence and Git publication readiness |
| Inputs (read-only) | the WP-12C-K plugin bundle; the WP-12C-I alignment artifacts; the WP-12C-J test cards; the canonical assets |
| Outputs | install transcript; post-install discovery + smoke + chat preview + hook smoke + validator transcripts; Git publication checklist (to be authored under `validation/` with name `package-12c-plugin-install-and-publication-checklist.md` or similar) |
| Files allowed (write) | the new install + publication checklist file in `validation/`; surgical updates to `tools/Test-AisrafPackage.ps1` allow-list to register the new file |
| Files forbidden | any canonical surface; any RUN-001 file; any plugin manifest edit (the plugin under test is frozen for this work package); any Git publication action before the install + smoke evidence is captured |
| Tests required | plugin install succeeds in a clean environment; post-install Layers 1-3 (discovery, role smoke, chat preview) PASS; post-install hook smoke PASS; post-install validators 0 FAIL; canonical assets byte-stable inside and outside the install target |
| Evidence required | full install + post-install transcripts; Git publication checklist completed (when, where, what, who) |
| Exit criteria | `WP-12C-L_PLUGIN_INSTALL_AND_PUBLICATION_READY` |
| Next gate | WP-13 (founder may also elect to publish to Git here) |

Current subgate posture after WP-12C-K acceptance: WP-12C-L0 is next for
terminal / hook hygiene preflight only after explicit approval. WP-12C-L1,
WP-12C-L2, and WP-12C-L3 remain blocked; no install, smoke, publication, or
external post-back action has occurred.

## 7. WP-13 — Diagram & Release View Pack

| Field | Value |
|---|---|
| Goal | Generate the framework / package diagrams and the release view pack from the canonical surface and the WP-12C-L evidence |
| Inputs (read-only) | canonical assets; WP-12C-I-L evidence; `validation/diagram-readiness-pre-render-checklist.md`; `validation/release-readiness-checklist.md` |
| Outputs | diagrams under `diagrams/`; release view pack under `release/`; updated `PACKAGE-MANIFEST.yaml` advancing current_build_package |
| Files allowed (write) | files inside `diagrams/` and `release/` per their existing folder contracts; `PACKAGE-MANIFEST.yaml` (founder action) |
| Files forbidden | any canonical asset rewrite; any RUN-001 file; any plugin manifest edit |
| Tests required | diagram readiness checklist PASS; release readiness checklist PASS; validators 0 FAIL |
| Evidence required | diagrams produced; release view pack produced; founder acceptance recorded |
| Exit criteria | `WP-13_DIAGRAM_AND_RELEASE_VIEW_PACK_PASS` |
| Next gate | WP-14 / WP-15 per `PACKAGE-MANIFEST.yaml` |

## 7a. WP-14 — IG1500-style Solution Package Release Pack

| Field | Value |
|---|---|
| Goal | Author an IG1500-shaped solution package release pack for AISRAF using the canonical surface, the WP-12C-I alignment artifacts, the WP-12C-J / -K / -L evidence, and the WP-13 diagrams. The release pack is **descriptive**, not prescriptive; it does not author or rebuild any canonical asset, and it does not claim TM Forum compliance, certification, or runtime conformance |
| Inputs (read-only) | every canonical asset; the 5 WP-12C-I alignment artifacts; the WP-12C-J test card evidence; the WP-12C-K plugin manifest; the WP-12C-L install + post-install transcripts; the WP-13 diagrams and release view pack |
| Outputs | one or more `release/AISRAF-Solution-Package-Release-Pack-vX.Y.Z/` markdown files shaped to IG1500 sections: scenario, objectives, AN L4 evolution and key features, architecture (drawn from the architecture document), interaction flow (drawn from the agent / skill / hook maps), lessons learned, standard requirements; plus a release-pack manifest summarizing artifact paths |
| Files allowed (write) | the new release-pack folder under `release/`; surgical updates to `tools/Test-AisrafPackage.ps1` and `tools/Test-AisrafBp12AReadiness.ps1` allow-lists to register the new release-pack files |
| Files forbidden | rewriting any canonical asset; copying a canonical body into a release-pack file (the release pack must reference, not duplicate); modifying `runs/RUN-001/`; modifying sealed BP12B evidence; authoring MAF / Foundry / ADK / MCP runtime adapters; claiming TM Forum compliance / certification / runtime conformance |
| Tests required | release readiness checklist PASS; package validator + BP12A readiness 0 FAIL; canonical surface byte-stable inside and outside the release-pack folder; every IG1500 section in the release pack references at least one canonical artifact path |
| Evidence required | release-pack folder exists with all IG1500 sections filled in; release-pack manifest validates against its own schema (to be authored); founder acceptance recorded |
| Exit criteria | `WP-14_SOLUTION_PACKAGE_RELEASE_PACK_PASS` |
| Next gate | WP-15 |

## 7b. WP-15 — Future Runtime Projection (Strategy Only)

| Field | Value |
|---|---|
| Goal | Document, but do not implement, the future runtime projection of AISRAF onto Microsoft Agent Framework, Azure AI Foundry, and (optionally) Google ADK. The strategy applies IG1251D agent-architecture concepts (reactive vs proactive behavior, memory scope, human-agent and agent-agent interaction, automation vs autonomy) and GB1087 agentic-interaction-security concepts (security domain, agent types, interactions, risks, controls, monitoring) **descriptively**. No runtime adapter, no MCP server, and no cloud deployment is authored |
| Inputs (read-only) | every canonical asset; the WP-12C-I alignment artifacts; the WP-12C-J / -K / -L evidence; the WP-13 diagrams; the WP-14 release pack |
| Outputs | one or more `validation/package-12c-runtime-projection-strategy-*.md` files describing per-runtime translation rules, autonomy slider commitments (current = `chat-preview-only` + `controlled-write-on-approval`; future runtime introduces `governed-execution` only with explicit founder approval and a separate work package), security-domain selection per GB1087 §3.1, agent-type identification per GB1087 §3.2, interaction-type definition per GB1087 §3.3, risks per GB1087 §3.4, controls per GB1087 §3.5, and monitoring per GB1087 §3.7 — all described as **future**, none implemented |
| Files allowed (write) | the new strategy file(s) under `validation/`; surgical updates to `tools/Test-AisrafPackage.ps1` allow-list to register them |
| Files forbidden | any runtime adapter scaffolding (Microsoft Agent Framework, Azure AI Foundry, Google ADK, MCP server); any cloud deployment artifact; any change to canonical surface; any change to RUN-001; any change to plugin scaffolding; any claim that the runtime projection is implemented; any agent-side memory introduction; any autonomy-level promotion to `governed-execution` without a separate sponsoring work package |
| Tests required | package validator + BP12A readiness 0 FAIL; canonical surface byte-stable; every strategy claim is falsifiable (no aspirational language without a falsifier or explicit `not-authored` / `not-implemented` marker) |
| Evidence required | strategy file(s) exist; every runtime row references the canonical adapter, not a duplicated body; founder acceptance recorded that this is strategy only |
| Exit criteria | `WP-15_RUNTIME_PROJECTION_STRATEGY_PASS` |
| Next gate | per `PACKAGE-MANIFEST.yaml`; runtime *implementation* is a separate post-WP-15 work package (e.g., a future `WP-12C-F-Implementation` or its successor), gated by explicit founder approval and a fresh capability declaration |

## 8. Plugin Source-of-Truth Rules

| Rule | Falsifier |
|---|---|
| The plugin is a projection, not the source of truth. | A plugin file containing a canonical body block byte-for-byte. |
| No plugin without a canonical source package. | A plugin manifest authored before the canonical PRA / adapter / prompt / skill / template exists. |
| No plugin release without evidence. | A `git push` of plugin scaffolding without the WP-12C-L install + smoke + validator transcripts. |
| Plugin packaging starts only after WP-12C-J. | A plugin/ scaffold folder appearing before the sample input/output test card has 7 PASS rows. |
| Git publication starts only after WP-12C-L. | A Git tag / release pushed before the install + post-install validator evidence is captured. |
| Plugin must bundle by reference (build script), not hand-edit. | A canonical body literal copied into the plugin file. |

## 9. Future Plugin Shape (Defined, Not Authored)

When WP-12C-K opens, the install bundle is expected to contain:

| Bundle Folder / File | Source | Contains |
|---|---|---|
| `plugin/manifest.yaml` (or provider-mandated name) | new authoring | plugin id, version, capability id, owning_capability, agent ids, skill ids, hook ids, prompt ids, MCP tool refs, install commands, validator command |
| `plugin/agents/` | bundled-by-reference from `.agents/` | 7 agent specs |
| `plugin/skills/` | bundled-by-reference from `.github/skills/` and `.copilot-skills/` | 7 provider skill packages + 7 operator wrappers |
| `plugin/prompts/` | bundled-by-reference from `prompts/` | RS + DFD prompt families |
| `plugin/skills-canonical/` | bundled-by-reference from `skills/` | 17 RS skills + 9 DFD skills |
| `plugin/templates/` | bundled-by-reference from `templates/` | 31 controlled templates |
| `plugin/catalogs/` | bundled-by-reference from `catalogs/` | 24 controlled-vocabulary YAML catalogs |
| `plugin/blueprints/` | bundled-by-reference from `blueprints/` | 9 controlled blueprints |
| `plugin/mcp/` | new authoring (only if a new MCP server is shipped; default: empty) | per-MCP server config with owner + permission + data classification |
| `plugin/hooks/` | bundled-by-reference from `tools/hooks/` and `.github/hooks/aisraf-guardrails.json` | 4 hook scripts + provider hook config + hook allow-list |
| `plugin/tools/` | bundled-by-reference from `tools/` | 4 PowerShell validators + `New-AisrafRun.ps1` |
| `plugin/registries/` | bundled-by-reference from `skill-registry.yaml`, `prompt-registry.yaml`, `prototype-agent-registry.yaml` | 3 registries |
| `plugin/validation/` | bundled-by-reference from `validation/` (test cards + checklists) | evidence templates only |
| `plugin/README.md` | new authoring | install + smoke + uninstall + evidence pointers |
| `plugin/PLUGIN-TEST-CARD.md` | new authoring | layered tests for an installed plugin |
| `plugin/EVIDENCE-CHECKLIST.md` | new authoring | what evidence must exist before the plugin may be released |

## 10. Stop Conditions For The Roadmap

- Authoring `plugin/` scaffolding before WP-12C-J exits with PASS.
- Authoring a Git release / tag / `gh release create` before WP-12C-L exits with PASS.
- Bundling a canonical body by hand-edit instead of by reference.
- Adding an MCP tool to the plugin without owner, permission scope, and data classification.
- Adding a hook to the plugin without an event, behavior, and falsifier.
- Adding a memory / state surface that exceeds `run-scoped-files`.
- Claiming an external execution from any plugin file.
- Modifying any canonical surface during plugin packaging.

## 11. Acceptance Verdict

`WP-12C-I_PLUGIN_ROADMAP_PASS` when:

- This roadmap exists with all seven work-package rows filled in (WP-12C-I, WP-12C-J, WP-12C-K, WP-12C-L, WP-13, WP-14, WP-15).
- Plugin source-of-truth rules and stop conditions are present.
- Future plugin shape is defined without any plugin file authored.
- WP-14 (IG1500-style release pack) and WP-15 (future runtime projection) are defined as descriptive strategy gates, not implementation gates.
- All three validators run with `0 FAIL`.

## 12. WP-12C-K0/K1 — Packaging Contract & Allow-list Update Specification (Authored 2026-05-10)

### 12.1 Status At Authoring

| Field | Value |
|---|---|
| Authoring date | 2026-05-10 |
| Trigger | WP-12C-J full-Mode-B closure (`WP-12C-J2_FULL_CONTROLLED_OUTPUT_PASS_READY_FOR_PLUGIN_PACKAGING`) |
| Validator state at authoring | `Test-AisrafPackage` 79 PASS / 1 WARN (smoke-folder hygiene) / 0 FAIL; `Test-AisrafBp12AReadiness` 77 PASS / 0 FAIL; `Test-AisrafRunProfile -ExecutionReady` (RUN-001) 12 PASS / 0 FAIL |
| Smoke-folder hygiene | `runs/RUN-SMOKE-LOCAL-001/` retained on disk for further smoke runs; protected from accidental staging via operator-local `.git/info/exclude` line `runs/RUN-SMOKE-LOCAL-*/` (file is not committed and never will be — `.git/info/exclude` is per-clone) |
| K0/K1 outcome | **`WP-12C-K1_PLUGIN_CONTRACT_READY_ALLOWLIST_UPDATE_REQUIRED`** — `plugins/` is not on the package validator allow-list; no scaffold authored in this gate |

### 12.2 Plugin Target Path

The target plugin package path is now **`plugins/aisraf-copilot-plugin/`** (plural `plugins/` root with one scoped subfolder per provider plugin). This supersedes the singular `plugin/` working name used in §9 of this roadmap; §9 remains for archival reference. Future provider-specific plugins (e.g., a future Microsoft Agent Framework or Azure AI Foundry adapter) would each occupy a sibling folder under `plugins/`, never the canonical surface.

### 12.3 Why `plugins/` Cannot Be Scaffolded Today — Validator Findings

| Finding | Validator | Where | Impact |
|---|---|---|---|
| F1 | `tools/Test-AisrafPackage.ps1` | Check 02 line 142 — required root folders enumerate `.github`, `.agents`, `.copilot-skills`, `config`, `tools`, `prompts`, `skills`, `prototype-agents`, `catalogs`, `blueprints`, `templates`, `samples`, `runs`, `diagrams`, `docs`, `validation`, `release`, `authoring-agents`. **`plugins/` is absent.** | Check 02 only FAILs on missing required folders, so an additional `plugins/` on disk would not directly FAIL Check 02; however there is also **no positive validation coverage** of plugin contents. |
| F2 | `tools/Test-AisrafPackage.ps1` | No `Check-08x-plugins-content-limits` block exists. | The package validator currently provides no per-file inspection for `plugins/aisraf-copilot-plugin/` — manifest schema, README presence, projection-by-reference rule, no-canonical-body-duplication rule are all uncovered. |
| F3 | `tools/Test-AisrafBp12AReadiness.ps1` | `tracked-drift` check (line 441–447) restricts tracked diff to `$allowedTrackedDrift`. **No `plugins/...` path is allowed.** | Any `git add plugins/<file>` would FAIL `01-git-workspace tracked-drift`. |
| F4 | `tools/Test-AisrafBp12AReadiness.ps1` | `sealed-surface-drift` check (line 742) lists sealed prefixes `'prompts/', 'skills/', 'prototype-agents/', 'catalogs/', 'blueprints/', 'templates/', 'config/', 'samples/', 'runs/', '.agents/'`. **`plugins/` is NOT in sealed-prefixes.** | Adding `plugins/` would not trigger sealed-surface-drift FAIL — only tracked-drift FAIL via F3. |
| F5 | `tools/Test-AisrafPackage.ps1` | Check 11 line 1229 — `validation/` allowed-files list. **`package-12c-plugin-packaging-plan.md` is NOT on the list.** | Authoring a new `validation/package-12c-plugin-packaging-plan.md` file would FAIL Check 11. The K0/K1 contract is therefore captured here in `package-12c-plugin-roadmap.md` (already on Check 11 list and on `bp12cApprovedAdapterAlignmentDrift`). |

### 12.4 Exact Allow-list Updates Required Before WP-12C-K Scaffolding

Two surgical edits to validator scripts are required before any plugin file can be created or staged. **Both edits are in scope for WP-12C-K (per §5 of this roadmap, which already permits "surgical updates to `tools/Test-AisrafPackage.ps1` and `tools/Test-AisrafBp12AReadiness.ps1` to bring the plugin scaffolding under their allow-lists"). Do not perform these edits in K0/K1.** Specify them so the WP-12C-K2 author (scaffold step) can apply them precisely.

#### 12.4.1 `tools/Test-AisrafPackage.ps1`

| # | Edit | Line (today) | Change |
|---|---|---|---|
| P1 | Check 02 — required root folders | 142 | Append `'plugins'` to `$rootFolders`. Required, not optional, once the plugin gate opens. |
| P2 | New Check 08k — `plugins/` content limits | new block after Check 08j | Add a per-folder allow-list block (analog of Check 08i for `runs/RUN-001/`). Allowed under `plugins/`: `README.md`, exactly one provider-scoped subfolder `aisraf-copilot-plugin/`. Allowed under `plugins/aisraf-copilot-plugin/`: `README.md`, `PLUGIN-PACKAGING-PLAN.md`, `PLUGIN-TEST-CARD.md`, `EVIDENCE-CHECKLIST.md`, `plugin.yaml` (or provider-mandated manifest name), and the bundled-by-reference subfolders `agents/`, `skills/`, `hooks/`, `prompts/`, `templates/`, `catalogs/`, `blueprints/`, `validation/`, `evidence/`, `tools/`, `registries/`. FAIL on any other file or subfolder. |
| P3 | Check 11 — validation/ allow-list | 1229 | No change needed for K0/K1 (this addendum lives inside `package-12c-plugin-roadmap.md` which is already allowed). For K2/K3, optional addition of `package-12c-plugin-install-and-publication-checklist.md` becomes the WP-12C-L change, not a K change. |

#### 12.4.2 `tools/Test-AisrafBp12AReadiness.ps1`

| # | Edit | Line (today) | Change |
|---|---|---|---|
| B1 | New `$bp12cApprovedPluginScaffoldingDrift` array | new constant near line 425 | Enumerate the exact plugin scaffolding paths permitted under `plugins/aisraf-copilot-plugin/` (manifest, README, packaging plan, test card, evidence checklist). Bundled-by-reference subfolders' contents must remain non-tracked or be allowed only as evidence-checklist references. |
| B2 | `$allowedTrackedDrift` aggregation | line 441 | Append `+ $bp12cApprovedPluginScaffoldingDrift`. |
| B3 | Optional new sealed-surface check for plugins | new block | NOT recommended — `plugins/` should remain a *projection* surface, not a sealed surface. Sealing it would prevent operator-local plugin install testing. Leave `plugins/` outside `$sealedPrefixes`. |

#### 12.4.3 No Other Validator Edits

- `tools/Test-AisrafRunProfile.ps1` — no change. The plugin scaffold does not introduce a run profile.
- `tools/hooks/hook-allow-list.yaml` — no change for K0/K1 or K2 scaffold. The 27 governed run output paths already cover all canonical runtime writes; the plugin install path under `plugins/` does not add chain output paths. If WP-12C-L install validation later adds an installed-plugin run target, that becomes a separate L-scope hook-allow-list amendment, not a K amendment.

### 12.5 Source-to-Plugin Projection Map

The plugin **bundles by reference** (build-script copy from canonical paths into the plugin folder). It never duplicates a canonical body inline.

| Plugin Path (proposed) | Source Surface | Source Type | Bundling Rule |
|---|---|---|---|
| `plugins/aisraf-copilot-plugin/README.md` | new authoring | new | Authored at WP-12C-K2 scaffold; references all canonical paths by string, copies no canonical body. |
| `plugins/aisraf-copilot-plugin/PLUGIN-PACKAGING-PLAN.md` | new authoring | new | Authored at WP-12C-K2; describes install/uninstall, evidence pointers, projection rules. |
| `plugins/aisraf-copilot-plugin/plugin.yaml` (or provider-mandated name) | new authoring | new | Plugin manifest with `plugin_id`, `version`, `capability_id`, `process_flow_id`, `task_flow_ids`, `agent_ids`, `skill_ids`, `hook_ids`, `prompt_ids`, `template_ids`, `catalog_ids`, `blueprint_ids`, `mcp_tool_refs` (today: empty), `install_command`, `uninstall_command`, `validator_command`. |
| `plugins/aisraf-copilot-plugin/agents/` | `.github/agents/` (provider projection) | provider projection | Build-script copy of the 7 byte-identical projections. Canonical adapters under `.agents/` remain the source of truth. |
| `plugins/aisraf-copilot-plugin/skills/` | `.github/skills/` + `.copilot-skills/` (provider projection + local wrapper) | provider projection + local wrapper | 7 provider Agent Skill packages + 7 local wrappers + 7 operator cards + 1 README. |
| `plugins/aisraf-copilot-plugin/hooks/` | `tools/hooks/` + `.github/hooks/aisraf-guardrails.json` (reusable impl + provider config) | reusable hook impl + provider config | 4 hook scripts + `hook-allow-list.yaml` + README + provider hook config. |
| `plugins/aisraf-copilot-plugin/prompts/` | `prompts/rs/`, `prompts/dfd/` (canonical) | canonical-by-reference | Build-script copy (with checksum manifest in `evidence/`) of the 23 prompt cards. |
| `plugins/aisraf-copilot-plugin/skills-canonical/` | `skills/rs/`, `skills/dfd/` (canonical) | canonical-by-reference | Build-script copy of 17 RS + 9 DFD skill contracts. |
| `plugins/aisraf-copilot-plugin/templates/` | `templates/output/`, `templates/run/`, etc. (canonical) | canonical-by-reference | Build-script copy of 31 controlled templates. |
| `plugins/aisraf-copilot-plugin/catalogs/` | `catalogs/` (canonical) | canonical-by-reference | Build-script copy of 24 controlled-vocabulary YAML catalogs + family READMEs + registry. |
| `plugins/aisraf-copilot-plugin/blueprints/` | `blueprints/` (canonical) | canonical-by-reference | Build-script copy of 9 controlled blueprints + registry + template. |
| `plugins/aisraf-copilot-plugin/registries/` | `prompt-registry.yaml`, `skill-registry.yaml`, `prototype-agent-registry.yaml` (canonical) | canonical-by-reference | Build-script copy of 3 registries. |
| `plugins/aisraf-copilot-plugin/tools/` | `tools/Test-AisrafPackage.ps1`, `tools/Test-AisrafBp12AReadiness.ps1`, `tools/Test-AisrafRunProfile.ps1`, `tools/New-AisrafRun.ps1` (canonical) | canonical-by-reference | Build-script copy of 4 PowerShell tools. |
| `plugins/aisraf-copilot-plugin/validation/` | `validation/` (canonical, test cards + checklists only) | canonical-by-reference | Build-script copy of test card stubs + this roadmap. **Evidence rows blank** — to be filled at WP-12C-L install. |
| `plugins/aisraf-copilot-plugin/evidence/` | new authoring (per-install scaffolding) | install-time evidence | Empty at K2 scaffold. Filled at WP-12C-L with install transcript, post-install discovery / smoke / chat-preview / hook-smoke / validator transcripts, plus a `bundle-checksum-manifest.yaml` matching every bundled-by-reference path to its source SHA-256. |
| `plugins/aisraf-copilot-plugin/PLUGIN-TEST-CARD.md` | new authoring | new | Layered tests for an installed plugin (discovery, role smoke, chat preview, sample I/O preview, controlled output, regression) — adapted from the WP-12C-J test cards but anchored at the installed paths. |
| `plugins/aisraf-copilot-plugin/EVIDENCE-CHECKLIST.md` | new authoring | new | Required evidence before any release / Git-publication action. |

### 12.6 Plugin README Mandatory Statements

Per the brief, the plugin README must state:

1. **Canonical package remains the source of truth.** The plugin is a projection of the AISRAF SAS Prototype v0.1.2 canonical package; no plugin file overrides any canonical surface.
2. **Plugin package is a projection.** All non-new files are bundled by reference at build time; the build script and `evidence/bundle-checksum-manifest.yaml` falsify any drift.
3. **Install validation is deferred to WP-12C-L.** No install validation has been performed at WP-12C-K closure.
4. **No runtime / cloud / MCP / Jira / Confluence execution is enabled.** Today's plugin is `chat-preview-only` plus `controlled-write-on-approval` per `package-12c-solution-package-architecture.md` §11. No external post-back is possible from any plugin file.
5. **Diagrams remain blocked until WP-12C-L passes.** `diagrams/` is sealed at this gate.
6. **`runs/RUN-001/` is read-only inside the installed plugin.** Operator-driven smoke runs go to `runs/RUN-SMOKE-LOCAL-XXX/` (governed by the same hook allow-list).

### 12.7 K0/K1 Evidence (This Section)

| Evidence | Status |
|---|---|
| Source canonical package | `D:/E-Way 2/AISRAF- SAS Prototype v0.1.2/` — byte-stable. |
| Provider projections to be bundled | `.github/agents/` (7), `.github/skills/` (7 packages), `.github/hooks/` (1), `.copilot-skills/` (7 + 7 + 1) — byte-stable since J1 baseline. |
| Hooks to be bundled | `tools/hooks/aisraf-allowed-path-prewrite-guard.ps1`, `aisraf-focused-validator-postwrite.ps1`, `aisraf-session-stop-summary.ps1`, `aisraf-precommit-full-validator.ps1`, plus `hook-allow-list.yaml` and `README.md` — byte-stable. |
| Install test posture | Deferred to WP-12C-L. No install action attempted in K0/K1 or planned for K2 scaffold. |
| Canonical-logic-duplication check | None today. K2 scaffold authoring rule: any plugin file matching a canonical body byte-for-byte (substring of length ≥ 200 chars) FAILs review. |
| External execution claim check | None today. K2 scaffold authoring rule: every plugin file must carry, in its frontmatter or first section, the BP06 no-fake-proof prohibition or a falsifiable equivalent (e.g., `output_destination_mode: local_only`, `postback_execution_status: deferred`). |
| MCP write-back enabled | No. Today's plugin shape includes no MCP tool. If WP-12C-K2 introduces an MCP tool, owner + permission scope + data classification are mandatory per `package-12c-solution-package-architecture.md` §10. |
| Diagrams generated | No. `diagrams/` sealed. |
| Release artifacts created | No. `release/` sealed. |

### 12.8 K0/K1 Stop Conditions

This addendum stops here. The next allowed step is **WP-12C-K2 (scaffold)**, which is gated on:

1. Founder approval of this K0/K1 addendum.
2. Founder approval of the validator allow-list updates §12.4.1 (P1, P2) and §12.4.2 (B1, B2).
3. A separate WP-12C-K2 brief authorizing scaffold authoring under `plugins/aisraf-copilot-plugin/`.

Until those three conditions hold:
- No `plugins/` folder is created.
- No allow-list edit is made.
- No plugin file is authored.
- WP-12C-L plugin install validation does not start.
- WP-13 diagram & release view pack remains blocked.

### 12.9 K1B-A Authority Patch Note (Authored 2026-05-10)

WP-12C-K1B-A patches root authority and folder-contract alignment only. It records the accepted K1 plugin-gate direction in `PACKAGE-MANIFEST.yaml`, `PROTOTYPE-CHARTER.md`, `FOLDER-CONTRACTS.md`, `BUILD-ORDER.md`, this roadmap, and `validation/package-12c-proposed-file-tree.md` without creating `plugins/`, without packaging a plugin, and without editing validator allow-lists. WP-12C-K1B-B remains the next required validator allow-list patch before any K2 scaffold can proceed.
