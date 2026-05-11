---
plugin_id: aisraf-copilot-plugin
plugin_name: AISRAF SAS Copilot Plugin (Scaffold)
plugin_version: 0.0.0-scaffold
work_package: WP-12C-K2
lifecycle_status: scaffold_only
provider: GitHub Copilot
package_type: scaffold
canonical_source_of_truth: outside_this_folder
external_execution: disabled
postback_execution_status: deferred
output_destination_mode: local_only
runtime_claims: none
---

# AISRAF SAS Copilot Plugin — Scaffold (WP-12C-K2)

## 0. Operator Quick Start (WP-12C-K2A)

> Read this card first. Everything below this section is canonical detail.

| Question | Answer (today) |
|---|---|
| What is this folder? | A **scaffold** for a future GitHub Copilot plugin. Five files, no subfolders, no canonical bodies. |
| What is it not? | It is **not** the source of truth, **not** an installable bundle, **not** a runtime. |
| What gate are we in? | **WP-12C-K2** (scaffold-only) — close pending the WP-12C-K2A UX / operability audit. |
| What runs next? | **K3** — projection assembly plan + bundling plan (blocked until K2A passes). |
| What is blocked? | K3, K4, WP-12C-L (install + smoke), WP-13 (diagrams + release), WP-15 (future runtime adapters). |
| What does PASS mean here? | The five scaffold files exist; no plugin subfolders; validators 0 FAIL; canonical / sealed surfaces byte-stable; nothing staged; `.claude/` not tracked. |
| When do I stop and escalate? | If any falsifier in §11 fires: a canonical body is copied in, a plugin subfolder appears, an external execution claim shows up, or anyone tries to install before WP-12C-L. See §8. |
| What do I run today? | The three governed validators in §7. No install. No bundle build. No diagrams. No release. |
| Where is the source of truth? | Outside this folder — `prompts/`, `skills/`, `prototype-agents/`, `.agents/`, `templates/`, `catalogs/`, `blueprints/`, `samples/`, `runs/RUN-001/`, `tools/`, `.github/agents/`, `.github/skills/`, `.github/hooks/`, `.copilot-skills/`, `validation/`. |

If any answer above does not match what you see on disk, **stop and escalate to the founder**.

## 1. Read This First

This folder is a **projection package scaffold** for a future GitHub Copilot
plugin of the AISRAF SAS Prototype v0.1.2 canonical solution package.

**The canonical source of truth for AISRAF remains outside this plugin.** The
canonical surfaces are:

- `prompts/` — RS and DFD prompt cards
- `skills/` — RS and DFD skill contracts
- `prototype-agents/` — Prototype Reference Agents (PRAs) and the prototype
  agent registry
- `.agents/` — Canonical adapter specifications
- `templates/` — Controlled output templates
- `catalogs/` — Controlled vocabulary catalogs
- `blueprints/` — Controlled design blueprints
- `samples/` — Sample inputs and expected baselines
- `runs/RUN-001/` — Read-only RUN-001 fixture
- `tools/` — PowerShell validators
- `tools/hooks/` — Reusable hook scripts and `hook-allow-list.yaml`
- `.github/agents/` — Provider agent projection (byte-identical to `.agents/`)
- `.github/skills/` — Provider Agent Skills packages
- `.github/hooks/` — Provider hook configuration
- `.copilot-skills/` — Local skill wrappers and operator cards
- `validation/` — Test cards, checklists, and roadmap

No file inside `plugins/aisraf-copilot-plugin/` overrides any canonical
surface. No file inside this scaffold duplicates a canonical body.

## 2. What WP-12C-K2 Creates

WP-12C-K2 creates **scaffold files only** under
`plugins/aisraf-copilot-plugin/`. Specifically, this gate creates:

- `README.md` — this file (projection charter, mandatory statements,
  pointers to canonical sources, and what is in / out of scope today).
- `PLUGIN-PACKAGING-PLAN.md` — source-of-truth map, projection-by-reference
  approach, K2 inclusions, K2 exclusions, K3 / K4 / WP-12C-L placeholders,
  and explicit deferral of any future Claude adapter to WP-15.
- `PLUGIN-TEST-CARD.md` — future test steps only (existence checks,
  manifest parse check, no-bundle confirmation, validator confirmation,
  install-test deferral, no-execution-claim confirmation).
- `EVIDENCE-CHECKLIST.md` — files created, validators run, Git hygiene,
  `.claude` not staged, RUN-001 / samples unchanged, sealed surfaces
  unchanged, K3 blocked until K2 passes.
- `plugin.yaml` — minimal, non-executing manifest declaring scaffold-only
  lifecycle, deferred install validation, disabled external execution,
  and pointers to canonical source paths (no canonical bodies copied).

## 3. What WP-12C-K2 Does Not Create

WP-12C-K2 deliberately creates **no projection assembly**. Specifically:

- No `agents/` subfolder.
- No `skills/` subfolder.
- No `hooks/` subfolder.
- No `prompts/` subfolder.
- No `templates/` subfolder.
- No `catalogs/` subfolder.
- No `blueprints/` subfolder.
- No `tools/` subfolder.
- No `mcp/` subfolder.
- No `registries/` subfolder.
- No `validation/` subfolder.
- No `evidence/` subfolder.
- No `bundle-checksum-manifest.yaml`.
- No `plugins/README.md` at the `plugins/` root (top-of-`plugins/` README
  is excluded by the validator's `Check 16-plugin-content-limits`).

## 4. Roadmap Position

This plugin folder is the accepted WP-12C-K package surface defined in
`validation/package-12c-plugin-roadmap.md`:

| Gate | Goal | Current Status |
|---|---|---|
| WP-12C-K0 / K1 | Packaging contract & allow-list spec | BLACK / CLOSED |
| WP-12C-K1B-A | Root authority / folder-contract patch | BLACK / CLOSED |
| WP-12C-K1B-B | Validator allow-list patch for plugin scaffold | BLACK / CLOSED |
| WP-12C-K2 | Minimal scaffold — this folder, 5 files only | BLACK / CLOSED |
| WP-12C-K3 | Projection assembly plan + bundling plan | BLACK / CLOSED |
| WP-12C-K4 | Manifest schema + plugin lint + checksum validation | BLACK / CLOSED — `WP-12C-K4_PLUGIN_PACKAGE_VALIDATION_PASS_READY_FOR_INSTALL_TESTING` |
| WP-12C-K | Copilot plugin packaging package | PACKAGE COMPLETE — `WP-12C-K_PACKAGE_COMPLETE_READY_FOR_INSTALL_READINESS_PREFLIGHT` |
| WP-12C-L0 | Install readiness preflight | NEXT only after explicit approval; no install or interactive smoke yet |
| WP-12C-L1 | Plugin install validation | BLOCKED |
| WP-12C-L2 | Post-install discovery / role smoke | BLOCKED |
| WP-12C-L3 | Publication readiness | BLOCKED |
| WP-13 | Diagram & release view pack | No (blocked until WP-12C-L passes) |
| WP-14 | IG1500-style solution-package release pack | FUTURE |
| WP-15 | Future runtime projection strategy (Claude / MAF / Foundry / ADK) | FUTURE |

## 4a. Role Journey Map (WP-12C-K2A)

The plugin is a projection package. Different users interact with it at different layers. This map names the seven roles so the K2 scaffold can be read in role context, and so K3 / K4 / WP-12C-L can later validate that each role's experience is intact.

| User / role | What they need | Plugin experience (today's scaffold) | Their canonical surface |
|---|---|---|---|
| Founder / package owner | Gate status, drift control, next approval | "Where are we? What is blocked? What can proceed?" — answered by §0 Operator Quick Start, §4 Roadmap Position, §6 Operator Posture | `PACKAGE-MANIFEST.yaml`, `BUILD-ORDER.md`, `validation/package-12c-plugin-roadmap.md` |
| Security reviewer | Run AISRAF review safely | "Start with input read, then DFD extraction, then review table." — provider Agent Skills today; future plugin will project the same chain | `.github/skills/aisraf-input-read/`, `.github/skills/aisraf-dfd-extraction/`, `.github/skills/aisraf-review-table-build/` |
| Solution / security architect | Validate design facts and recommendations | "Trace DFD → review table → findings → handoff pack." — read `runs/RUN-001/` outputs and the canonical PRAs | `prototype-agents/PRA-*.md`, `runs/RUN-001/`, `validation/package-12c-capability-agent-traceability-register.md` |
| Operator / tester | Smoke test roles and hooks | "Run test card, validators, Git hygiene." — see `PLUGIN-TEST-CARD.md` (today: future-step deferred); validators in §7 | `validation/role-smoke-test-checklist.md`, `validation/chat-preview-test-checklist.md`, `validation/hook-readiness-checklist.md`, `tools/Test-*.ps1` |
| Plugin maintainer | Package / update the plugin safely | "Use K3 / K4 projection map and checksum manifest." — see `PLUGIN-PACKAGING-PLAN.md` §3, §6, §7 | `validation/package-12c-plugin-roadmap.md`, `PLUGIN-PACKAGING-PLAN.md`, future K3 build script |
| Agent / skill author | Update a role without breaking the package | "Change canonical PRA / skill / prompt / template, regenerate provider projection, validate." — see `PLUGIN-PACKAGING-PLAN.md` §3a Role Update Procedure | `prototype-agents/`, `.agents/`, `prompts/`, `skills/`, `templates/`, `.github/agents/`, `.github/skills/`, `.copilot-skills/` |
| Future adapter owner (Claude / MAF / Foundry / ADK) | Add a new runtime adapter later | "Do not edit the Copilot package; use WP-15 projection rules." — see `plugin.yaml` `future_runtime_projection`, `validation/package-12c-platform-projection-matrix.md` | future `validation/package-12c-runtime-projection-strategy-*.md` (WP-15) |

Each row is a falsifiable contract: if a future change to the plugin breaks any role's stated experience, the change is rejected, regardless of how the validators score.

## 4b. Layered Projection Model

The K2 scaffold preserves a strict five-layer projection model. The plugin must never become the source of truth.

```
Canonical source           prompts/, skills/, prototype-agents/, .agents/,
   |                       templates/, catalogs/, blueprints/, samples/,
   |                       tools/, tools/hooks/, runs/RUN-001/
   v
Provider projection        .github/agents/, .github/skills/,
   |                       .github/hooks/, .copilot-skills/
   v
Plugin package projection  plugins/aisraf-copilot-plugin/  (K3 / K4 only;
   |                       byte-identical bundle of canonical + provider
   |                       surfaces, never hand-edited)
   v
Install validation         WP-12C-L install + post-install transcripts
   |                       (clean operator environment; no claim before this)
   v
Release evidence           WP-13 diagrams + WP-14 IG1500-style release pack;
                           WP-15 future runtime projection (strategy only)
```

Falsifier: if any plugin file under `plugins/aisraf-copilot-plugin/` overrides, mutates, or duplicates a canonical surface body, the model is broken and the gate fails.

## 5. Mandatory Statements

The following statements apply to every file in this scaffold:

1. **AISRAF Copilot plugin scaffold is a projection package.** It is not the
   source of truth. The canonical solution package is the source of truth.
2. **Canonical source of truth remains outside the plugin.** No canonical
   body is duplicated inside `plugins/aisraf-copilot-plugin/` at this gate.
3. **K2 creates scaffold only.** No projection bundling occurs in this gate.
4. **K3 will define projection assembly.** A future K3 brief will author the
   bundling plan and the canonical-by-reference rules used at install time.
5. **K4 will validate package completeness.** A future K4 brief will author
   the plugin manifest schema validator and the no-canonical-body-duplication
   lint.
6. **WP-12C-L will test plugin install and smoke behavior.** Plugin install
   is deferred until K3 / K4 close. No install attempt has been made.
7. **No external runtime, Jira, Confluence, MCP, ADK, Azure Foundry, Claude,
   database, Terraform, or post-back execution is claimed.** Today's posture
   is `chat-preview-only` plus `controlled-write-on-approval` per
   `validation/package-12c-solution-package-architecture.md` §11.

## 6. Operator Posture (Today)

| Aspect | Posture | Falsifier |
|---|---|---|
| Source of truth | Canonical surfaces outside this folder | Any plugin file containing a canonical body string of length 200+ chars |
| Plugin lifecycle | `scaffold_only` | Any plugin subfolder created in K2 |
| Install validation | Deferred to WP-12C-L | Any install transcript or post-install evidence captured at K2 |
| External execution | Disabled | Any plugin file claiming runtime, cloud, MCP, ADK, Foundry, Claude, Jira, Confluence, database, Terraform, or post-back execution |
| Output destination | Local only | Any plugin file claiming `external_postback_executed` or equivalent |
| Memory / state | Run-scoped files only | Any persistent agent-side memory introduced |
| Diagrams | Sealed (blocked until WP-12C-L) | Any diagram authored under `diagrams/` from this plugin |
| Releases | Sealed (blocked until WP-12C-L) | Any release artifact authored under `release/` from this plugin |

## 7. How This Scaffold Is Validated

This scaffold is validated by three governed PowerShell validators in `tools/`:

- `tools/Test-AisrafPackage.ps1`
- `tools/Test-AisrafBp12AReadiness.ps1`
- `tools/Test-AisrafRunProfile.ps1 -ExecutionReady`

`Check 16-plugin-content-limits` in `Test-AisrafPackage.ps1` enforces that
`plugins/aisraf-copilot-plugin/` contains exactly the five scaffold files
listed in Section 2 and **no subfolders**. Any subfolder (e.g., `agents/`,
`skills/`, `hooks/`, `prompts/`, `tools/`, `mcp/`) FAILs Check 16 today.

The BP12A readiness validator's tracked-drift allow-list permits exactly
the five scaffold paths under `plugins/aisraf-copilot-plugin/` listed in
`$wp12cApprovedPluginScaffoldDrift`. Any other path under `plugins/` FAILs
the `tracked-drift` check.

## 8. Stop Conditions

Stop if any of the following becomes true while reading this README:

- A canonical body has been copied into a plugin file.
- A plugin subfolder has been created in K2.
- A plugin file claims external execution.
- An install attempt has been made before WP-12C-L opens.
- `runs/RUN-001/` or `samples/` has been modified by plugin authoring.
- A sealed canonical or projection surface has been modified by plugin
  authoring.
- `diagrams/` or `release/` has been touched by plugin authoring.
- A future Claude adapter has been authored ahead of WP-15.

If any stop condition fires, halt scaffold authoring and escalate to the
founder before any further plugin work proceeds.

## 9. WP-12C-K2A — UX / Operability Audit Anchors

WP-12C-K2A is a UX / operability audit pass over the K2 scaffold. It does
**not** open K3, does **not** assemble bundles, and does **not** install or
test the plugin. It only confirms that the K2 scaffold is practical,
modular, scalable, role-aware, and ready for K3 projection planning.

K2A audit anchors in this README:

- §0 — Operator Quick Start (new operator can read at a glance)
- §4a — Role Journey Map (seven roles named with canonical surfaces)
- §4b — Layered Projection Model (five-layer source-of-truth chain)
- §6 — Operator Posture (today's posture + falsifiers)
- §8 — Stop Conditions (escalation triggers)

Companion K2A anchors in the other scaffold files:

- `PLUGIN-PACKAGING-PLAN.md` §3a — Role Update / Extension Procedure
- `PLUGIN-TEST-CARD.md` §3.1 — Future Interactive Smoke Script
- `EVIDENCE-CHECKLIST.md` §2.6 — K2A UX / operability evidence rows
- `plugin.yaml` `audit_k2a:` block

K2A passes when every anchor above is present, every validator returns 0
FAIL, and the Git-hygiene checks confirm that no canonical, sealed, or
provider-projection surface was modified.
