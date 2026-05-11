# Build Package 12C — Platform Projection Matrix

| Field | Value |
|---|---|
| Document name | AISRAF Platform Projection Matrix |
| Work package | WP-12C-BA1 — Business Architecture Traceability Spine Alignment |
| Status | Strong pre-release prototype / local workbench package projection matrix; no execution claim |
| Audience | Founder, plugin packager, runtime adapter implementer, reviewer |
| Purpose | One row per canonical asset class, one column per provider/platform, with current status, drift risk, and required test evidence so projection drift is visible at a glance |
| Companion | `validation/package-12c-solution-package-architecture.md`, `validation/package-12c-agent-spec-template.md`, `validation/package-12c-capability-agent-traceability-register.md`, `validation/package-12c-plugin-roadmap.md` |

## 1. Read Before Anything Else

- This matrix is descriptive. It does not author or modify any provider projection.
- `Canonical asset` is the source of truth. Every projection cell must reference this canonical asset by path, not duplicate its body.
- Status legend:
  - `present-thin` — provider projection exists and references canonical paths only (no body duplication).
  - `present-byte-identical` — provider projection is a byte-identical copy of the canonical adapter (allowed only for `.github/agents/`).
  - `present-packaged` — packaged plugin projection exists with manifest/checksum evidence, but install validation is still deferred.
  - `local-only` — local-only projection; never staged.
  - `not-authored` — planned but not yet authored; current.
  - `n/a` — projection class does not apply to this row.
- Drift risk legend: `low` / `medium` / `high`. Higher risk requires earlier test evidence in the WP-12C-J / -K / -L ladder.

## 2. Provider Columns

| Provider Column | Surface Description | Authority |
|---|---|---|
| GitHub Copilot — Agents (VS Code) | `.github/agents/aisraf-*.agent.md` projection of `.agents/` | Visible in VS Code Copilot Chat agent dropdown |
| GitHub Copilot — Agent Skills | `.github/skills/<skill-id>/SKILL.md` provider Agent Skills package | Visible via `/` in Copilot Chat |
| GitHub Copilot — Hooks | `.github/hooks/*.json` provider hook config calling `tools/hooks/*.ps1` | PreToolUse / PostToolUse / Stop |
| GitHub Copilot — Local Operator Wrappers | `.copilot-skills/aisraf-*.skill.md` + operator cards | Local/operator projection; reference layer |
| Copilot CLI | Workspace-discovered agents/skills (provider-dependent) | Optional CLI surface |
| Claude (local) | `.claude/settings.json` + `.claude/hooks/` | Local-only; git-excluded |
| Microsoft Agent Framework | future MAF agent + tools deployment | Planned WP-12C-F strategy only |
| Azure AI Foundry | future Foundry agent + tool deployment | Planned WP-12C-F strategy only |
| Google ADK | future ADK adapter | Optional WP-12C-F strategy only |
| Installable Copilot Plugin | `plugins/aisraf-copilot-plugin/` packaged projection with manifest, bundle, test card, evidence checklist, and checksum manifest | Present packaged projection; install validation deferred to WP-12C-L |

## 2.1 BA1 Current Projection Status Overlay

| Projection Surface | BA1 Status | Boundary |
|---|---|---|
| `.agents/`, `.github/agents/`, `.github/skills/`, `.github/hooks/`, `.copilot-skills/` | current Copilot/local provider projections | reference canonical surfaces; do not become source of truth |
| `plugins/aisraf-copilot-plugin/` | `present-packaged`; bundle checksum validation passes | plugin is an installable/projection surface; install, post-install smoke, staging, and publication remain separate gates |
| Jira, Confluence, Lucidchart, MCP, Claude runtime, Azure AI Foundry, Google ADK, Microsoft Agent Framework, database, Terraform, cloud runtime, external post-back | `not-authored` | deferred future adapters only; no current integration or runtime claim |
| Release/publication package | deferred | release is governed publication with manifest, docs, QA, staging, and public-safety evidence; it is not the same thing as the plugin projection |

## 3. Matrix

| Canonical asset | GitHub Copilot Agents | GitHub Copilot Agent Skills | GitHub Copilot Hooks | GitHub Copilot Local Wrappers | Copilot CLI | Claude (local) | Microsoft Agent Framework | Azure AI Foundry | Google ADK | Installable Copilot Plugin | Current status | Drift risk | Test evidence required |
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
| `prototype-agents/PRA-01..08-*.md` (canonical PRAs) | n/a (PRAs are not adapters) | n/a (PRAs are not Agent Skills) | n/a | referenced by skill wrappers | n/a | n/a | future translation to MAF agent shape | future translation to Foundry agent shape | future translation to ADK | bundled in plugin package by checksum-governed projection (`present-packaged`) | sealed; canonical | low | byte-stability check; `Test-AisrafPackage.ps1` Check 06 PRAs present |
| `.agents/aisraf-*.agent.md` (canonical adapters, 7 files) | `.github/agents/aisraf-*.agent.md` (present-byte-identical, 7 files) | n/a | n/a | referenced by `.copilot-skills/aisraf-*.skill.md` | reads same canonical adapter when CLI workspace agents are enabled | n/a | future MAF adapter (not-authored) | future Foundry adapter (not-authored) | optional ADK adapter (not-authored) | bundled in plugin package (`present-packaged`) | present | low | `Test-AisrafPackage.ps1` Check 06 (`.agents/` content limits); Test 1 (Discovery) per `package-12c-quick-manual-test-card.md` |
| `prompts/rs/*.prompt.md` and `prompts/dfd/*.prompt.md` (canonical prompts) | referenced by adapter; not duplicated | referenced by SKILL.md by path | n/a | referenced by skill wrappers by path | referenced by canonical adapter | referenced by canonical adapter | future translation to MAF prompt resource | future translation to Foundry prompt resource | future translation to ADK prompt resource | bundled in plugin package (`present-packaged`) | sealed; canonical | low | `Test-AisrafPackage.ps1` Check 04 prompts present |
| `skills/rs/SK-*.md` (17 RS skills) and `skills/dfd/SK-DFD-0[1-9]-*.md` (9 DFD skills) | n/a | referenced by SKILL.md by path | n/a | referenced by skill wrappers by path | referenced by canonical adapter | referenced by canonical adapter | future translation to MAF tool description | future translation to Foundry tool description | future translation to ADK tool description | bundled in plugin package (`present-packaged`) | sealed; canonical | low | `Test-AisrafPackage.ps1` Check 05 skills present |
| `templates/output/output-00..17-*.md` and 9 DFD output templates (canonical templates) | referenced by adapter | referenced by SKILL.md by path | n/a | referenced by operator card | referenced by canonical adapter | referenced by canonical adapter | future translation to MAF schema/output spec | future translation to Foundry schema | future translation to ADK schema | bundled in plugin package (`present-packaged`) | sealed; canonical | low | `Test-AisrafPackage.ps1` Check 09 templates present |
| `catalogs/*` (24 controlled-vocabulary YAML catalogs) | referenced by adapter | referenced by SKILL.md by path | n/a | referenced by operator card | referenced by canonical adapter | referenced by canonical adapter | future translation to MAF tool inputs / enums | future translation to Foundry tool inputs / enums | future translation to ADK tool inputs / enums | bundled in plugin package (`present-packaged`) | sealed; canonical | low | `Test-AisrafPackage.ps1` Check 07 catalogs present |
| `blueprints/*` (9 blueprint YAML, 2 categories) | referenced by adapter | referenced by SKILL.md by path | n/a | referenced by operator card | referenced by canonical adapter | referenced by canonical adapter | future translation to MAF blueprint resource | future translation to Foundry blueprint resource | future translation to ADK blueprint resource | bundled in plugin package (`present-packaged`) | sealed; canonical | low | `Test-AisrafPackage.ps1` Check 08 blueprints present |
| `samples/sample-001-dfd-crop/` (sample input + expected baselines) | n/a (samples are not provider projections) | referenced by SKILL.md as read-only context | n/a | referenced by operator card as read-only context | referenced by adapter as read-only context | referenced by adapter as read-only context | future MAF integration test fixture | future Foundry integration test fixture | future ADK integration test fixture | not bundled in current plugin; canonical fixture remains source-side evidence | sealed; canonical | low | `Test-AisrafPackage.ps1` Check 10 samples; sample input/output preview test card |
| `runs/RUN-001/` (governed run fixture) | n/a | referenced by SKILL.md as read-only context | n/a | referenced by operator card as read-only context | referenced by adapter as read-only context | referenced by adapter as read-only context | future MAF run fixture | future Foundry run fixture | future ADK run fixture | not bundled in current plugin; runtime evidence/state remains source-side | sealed; BP12B post-execution evidence | low | `Test-AisrafRunProfile.ps1 -ExecutionReady` 12 PASS; `Test-AisrafBp12AReadiness.ps1` |
| `tools/Test-AisrafPackage.ps1`, `Test-AisrafBp12AReadiness.ps1`, `Test-AisrafRunProfile.ps1`, `New-AisrafRun.ps1` | n/a | n/a | invoked by `aisraf-precommit-full-validator.ps1` | n/a | invoked locally via PowerShell | invoked locally via PowerShell | future MAF CI step (not-authored) | future Foundry CI step (not-authored) | future ADK CI step (not-authored) | bundled in plugin package (`present-packaged`); no separate plugin validator is claimed | present | medium | hand-run validators per Section F of `package-12c-quick-manual-test-card.md` |
| `tools/hooks/aisraf-allowed-path-prewrite-guard.ps1` | n/a | n/a | called via `.github/hooks/aisraf-guardrails.json` PreToolUse | n/a | not yet wired | local-only `.claude/` hook config (not authored by AISRAF) | future MAF policy adapter | future Foundry policy adapter | future ADK policy adapter | bundled in plugin package (`present-packaged`) | present | medium | hook smoke test E1 + E2 in `package-12c-quick-manual-test-card.md` |
| `tools/hooks/aisraf-focused-validator-postwrite.ps1` | n/a | n/a | called via `.github/hooks/aisraf-guardrails.json` PostToolUse | n/a | not yet wired | local-only `.claude/` hook config (not authored by AISRAF) | future MAF post-tool adapter | future Foundry post-tool adapter | future ADK post-tool adapter | bundled in plugin package (`present-packaged`) | present | medium | hook smoke test E3 |
| `tools/hooks/aisraf-session-stop-summary.ps1` | n/a | n/a | called via `.github/hooks/aisraf-guardrails.json` Stop | n/a | not yet wired | local-only `.claude/` hook config (not authored by AISRAF) | future MAF stop adapter | future Foundry stop adapter | future ADK stop adapter | bundled in plugin package (`present-packaged`) | present | low | hook smoke test E4 |
| `tools/hooks/aisraf-precommit-full-validator.ps1` | n/a | n/a | local precommit (operator-installed via `.claude/`) | n/a | n/a | local-only `.claude/settings.json` (not authored by AISRAF) | n/a (CI handles equivalent) | n/a (CI handles equivalent) | n/a (CI handles equivalent) | bundled in plugin package (`present-packaged`) | present | low | hook smoke test E5 |
| `tools/hooks/hook-allow-list.yaml` | n/a | n/a | source for prewrite guard | n/a | n/a | n/a | future MAF policy resource | future Foundry policy resource | future ADK policy resource | bundled in plugin package (`present-packaged`) | present | medium | `Test-AisrafPackage.ps1` Check 12 hook-allow-list present |
| `skill-registry.yaml`, `prompt-registry.yaml`, `prototype-agent-registry.yaml` | n/a | n/a | n/a | n/a | n/a | n/a | future MAF registry resource | future Foundry registry resource | future ADK registry resource | bundled in plugin package with owning folders (`present-packaged`) | sealed; canonical | low | `Test-AisrafPackage.ps1` registry checks |
| `validation/*.md` (BP12C planning + implementation checklists) | n/a | n/a | n/a | n/a | n/a | n/a | n/a | n/a | n/a | not bundled as a validation folder in current plugin; plugin root carries its own test card and evidence checklist | present | low | `Test-AisrafPackage.ps1` Check 11 validation/ allow-list |

## 4. Drift Hot Spots

| Asset | Why It Is A Drift Hot Spot | Mitigation |
|---|---|---|
| `.github/agents/*.agent.md` | byte-identity with `.agents/` is asserted; either side editing breaks parity | `Test-AisrafPackage.ps1` Check 06 enforces presence; future check should enforce byte-identity (post-WP-12C-K) |
| `.github/skills/*/SKILL.md` | provider may rev SKILL.md frontmatter spec; canonical references could rot | re-test SKILL.md presence + frontmatter shape per WP-12C-J discovery row |
| `.github/hooks/aisraf-guardrails.json` | embedded PowerShell command strings are hard to diff | keep hook scripts in `tools/hooks/`; provider config remains thin caller only |
| `tools/hooks/hook-allow-list.yaml` | new outputs require allow-list extension or hooks block writes silently | `Test-AisrafPackage.ps1` should fail any new `runs/{{run_id}}/<file>` not in the allow-list once Mode B is approved |
| Future plugin manifest | bundling canonical assets risks silent drift from canonical SoT | plugin packager copies by reference (post-build script), never by hand-edit; validator runs over the bundled copy |
| Future MAF / Foundry / ADK adapters | each runtime has its own agent shape; translation could embed canonical bodies | adapter authors must reference, not duplicate; `WP-12C-F` strategy doc names the rule |

## 5. Stop Conditions For Any Provider Projection

- A projection that copies a canonical body instead of referencing it.
- A projection that introduces an external execution claim not present in the canonical adapter.
- A projection that writes a file outside the controlled-output allow-list.
- A projection that overrides `unknown` handling.
- A projection that bundles a canonical asset by hand-edit instead of by build script.
- A projection introduced before its sponsoring work package is open (e.g., a plugin manifest authored before WP-12C-K).

## 6. Acceptance Verdict

`WP-12C-I_PROJECTION_MATRIX_PASS` when:

- Every canonical asset row is filled with a defensible value per provider column.
- Drift hot spots are named with mitigations.
- All three validators run with `0 FAIL`.
