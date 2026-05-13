# WP-12C-REL0-PRODUCT-FLOW-ADAPTER-ROADMAP-REBASE Report

Package: AISRAF SAS Prototype v0.1.2
Gate: `WP-12C-REL0-PRODUCT-FLOW-ADAPTER-ROADMAP-REBASE`
Posture: Public source-available evaluation-only proof-of-concept. Not open source. Not production software. Not marketplace-published. No current Connected Review Flow (Flow 4 / internal AM4) execution. No current Threat Intelligence Enrichment (Flow 5) execution. Closed-loop autonomy is out of scope.

## 1. Founder Decision Recorded

Stop using `Mode 0/1/2/3/4` as the public UX model. Most of those entries are not real user-facing application modes — they are internal architecture/evidence vocabulary, maintainer-only release plumbing, or future feature lanes that were mislabeled as switchable application states.

The new product operating model is six named flows:

1. **Local Orchestrated Review** — normal user flow.
2. **Run Observability / Runtime Evidence** — captured alongside Local Orchestrated Review.
3. **Release QA Flow** — maintainer-only.
4. **Connected Review Flow** — planned (v0.2.0).
5. **Threat Intelligence Enrichment** — planned (v0.2.1).
6. **Plugin Install UX** — repo-local today; clean install/load UX later.

Closed-loop autonomy is out of scope. The `AM` / `AL` / `Mode N` vocabulary stays as internal architecture/evidence vocabulary in contracts, runtime files, and validation artifacts.

Current release rule: do **not** implement Jira, Confluence, Lucid, Rovo/MCP, online threat intelligence, cloud runtime, database runtime, Terraform, event bus, telemetry backend, or marketplace publication inside the v0.1.2 release-hardening branch unless a separate feature gate is opened.

Version strategy: v0.1.2 (evaluation baseline) → v0.1.3 (UX cleanup, cross-shell, plugin install/load) → v0.2.0 (Connected Review Flow) → v0.2.1 (Threat Intelligence Enrichment) → v0.3.0 (runtime/observability backend). AL5 remains out of scope.

## 2. Repo Documentation Created

| Path | Status |
|---|---|
| `docs/PRODUCT-FLOW-ROADMAP.md` | CREATED — operating model, six flows, mapping table from old `Mode N` vocabulary, release lane summary. |
| `docs/CONNECTED-REVIEW-FLOW-PLAN.md` | CREATED — planned Flow 4. Adapters: Jira intake; Jira design-review issue creation/update with the fixed 19-field model; Confluence handoff page; Lucid/Lucidchart source ingestion; Rovo/MCP; manual/local fallback. Output model and hard postback evidence rule recorded. |
| `docs/THREAT-INTELLIGENCE-ENRICHMENT-PLAN.md` | CREATED — planned Flow 5. New skill `SKL-THREAT-INTEL-CURRENT-CONTEXT` with allowed sources (NVD CVE API, CISA KEV, vendor security advisories, official product documentation/security pages; optional later: GitHub Security Advisories / OSV), 11 inputs, 7 outputs, and 9 hard rules including no-automatic-findings, version-aware CVE matching, source/date/confidence requirement, and human approval before promotion. |
| `docs/PLUGIN-INSTALL-UX-PLAN.md` | CREATED — current v0.1.2 truth (repo-local; not marketplace-published; not one-click) and seven install gates (local repo install, clean workspace install, packaged plugin install, marketplace / private distribution evaluation, upgrade/uninstall path, settings/variables path, run workspace path selection). |
| `docs/BRANCH-RELEASE-STRATEGY.md` | CREATED — branch roles (`master`, optional `release/v0.1.2`, `docs/product-flow-ux`, `docs/plugin-install-ux`, `fix/cross-shell-command-ux`, `feature/connected-jira-intake`, `feature/connected-confluence-output`, `feature/connected-lucid-source`, `feature/connected-rovo-mcp`, `feature/threat-intel-current-context`, `feature/runtime-observability-store`); tag names (`v0.1.2-eval`, `v0.1.3-ux`, `v0.2.0-connected-review`, `v0.2.1-threat-intel`); branch rules (small branches, validator-green before merge, no binaries, no public/open-source wording, no connected-adapter claim until tested). |

## 3. Repo Documentation Updated

| Path | Edit | Reason |
|---|---|---|
| `README.md` | Added the product flow entry-point link, added the "Product Operating Model (Plain English)" table (6 flows), kept the `AM`/`AL`/`Mode N` vocabulary in an explicit "Internal Autonomy Vocabulary (For Contributors Only)" section, replaced the public `Mode N` journey table with a flow-status table, and added explicit references to the new docs. Replaced the residual `user runs AM3` framing with "user runs AISRAF Local Orchestrated Review." | Required by the new operating model. |
| `START-HERE.md` | Same kind of update as README.md plus an explicit pointer in the "Roadmap reader" entry to the new docs. | Required by the new operating model. |
| `docs/ROADMAP.md` | Added the public-language note, replaced the `Mode N` table with the flow-status table, added the successor release-lane summary, and renamed section 5 from "AL4 Adapter Future" to "Connected Review Flow (Flow 4 / internal AL4) — Planned" with the new doc reference. Section 6 retitled to "Closed-Loop Autonomy (Internal AL5): Out Of Scope". | Required by the new operating model. |
| `docs/OPERATOR-QUICKSTART.md` | Replaced the `Mode N` table with the flow-status table, retitled the visual map to "Local Orchestrated Review Visual Map", updated the license-posture paragraph to use the flow vocabulary, and updated the "What Not To Do" section to use the flow vocabulary. | Required by the new operating model. |
| `docs/SECURITY-REVIEW-WORKFLOW.md` | Replaced the `Mode N` table with the flow-status table, retitled the "Deferred Integration Story" section to "Connected Review Flow And Threat Intelligence Enrichment (Planned)" and added the planned `SKL-THREAT-INTEL-CURRENT-CONTEXT` reference. | Required by the new operating model. |
| `docs/ARCHITECTURE-OVERVIEW.md` | Replaced the `Mode N` table with the flow-status table, retitled section 6 to "Local Orchestrated Review Vs Run Observability Evidence", updated section 10 to "Planned Adapter And Skill Map" with explicit references to the Connected Review Flow plan and Threat Intelligence Enrichment plan. | Required by the new operating model. |
| `tools/Test-AisrafPackage.ps1` | Added 5 new docs to the docs/ allow-list (`PRODUCT-FLOW-ROADMAP.md`, `CONNECTED-REVIEW-FLOW-PLAN.md`, `THREAT-INTELLIGENCE-ENRICHMENT-PLAN.md`, `PLUGIN-INSTALL-UX-PLAN.md`, `BRANCH-RELEASE-STRATEGY.md`). Added this report to the validation/ allow-list. Updated the docs-content-limits PASS/FAIL detail strings from "6 approved release docs files" to "11 approved release docs files" and named the WP-12C-REL0-PRODUCT-FLOW-ADAPTER-ROADMAP-REBASE gate as the authority. | Validator must accept the new docs and this report. |
| `plugins/aisraf-copilot-plugin/bundle/tools/Test-AisrafPackage.ps1` | Refreshed via `tools/Build-AisrafCopilotPluginBundle.ps1 -Clean` so the bundle copy matches the canonical tool. | Required by Check 16b plugin bundle checksum validation. |
| `plugins/aisraf-copilot-plugin/bundle-checksum-manifest.yaml` | Regenerated by the bundle build script (201 entries, all source/target SHA-256 match). | Required by Check 16b. |

No source-content surface was modified. `prompts/`, `skills/`, `prototype-agents/`, `.agents/`, `.github/agents/`, `.github/skills/`, `.github/hooks/`, `.copilot-skills/`, `templates/`, `catalogs/`, `blueprints/`, `config/`, `samples/`, `runs/`, `LICENSE`, `NOTICE.md`, `plugin.json`, `plugin.yaml` are unchanged.

## 4. Posture Verification

| Posture rule | Status |
|---|---|
| No "open source" claim in new docs | PASS — every match is a NEGATIVE assertion ("not open source") or refers to the OSV "Open Source Vulnerabilities" database name (a planned future source in `THREAT-INTELLIGENCE-ENRICHMENT-PLAN.md` section 4). |
| No "production-ready" / "production software" claim | PASS — every match is "not production software" or "production-grade execution" used inside a negation ("does not prove production-grade execution"). |
| No "marketplace-published" claim | PASS — every match is a NEGATIVE assertion ("not marketplace-published") or part of the install-gate plan that explicitly tags marketplace evaluation as planned-only. |
| No current Jira/Confluence/Lucid/Rovo/MCP execution claim | PASS — `CONNECTED-REVIEW-FLOW-PLAN.md` is explicitly tagged "Planning only. No Jira, Confluence, Lucid, Rovo, MCP ... is wired up in the current release-hardening branch." `OPERATOR-QUICKSTART.md`, `SECURITY-REVIEW-WORKFLOW.md`, and `AISRAF-PRIMER.md` matches are all "no live X" or "do not claim live X". |
| No current online threat-intelligence execution claim | PASS — `THREAT-INTELLIGENCE-ENRICHMENT-PLAN.md` is explicitly tagged "Planning only. No online threat-intelligence execution is wired up in the current release-hardening branch." |
| No claim that Connected Review Flow adapters are implemented | PASS — every adapter is tagged "planned" or "not implemented in v0.1.2". |
| No AL5 / closed-loop autonomy claim | PASS — every match is "out of scope". |
| No live post-back claim | PASS — hard rule recorded in `CONNECTED-REVIEW-FLOW-PLAN.md` section 5 (destination URL, operator approval, `postback_execution_status = executed_by_operator`, run-log entry, adapter response metadata without secrets). |
| Public-language rebase recorded | PASS — `Mode N` is retired from public docs and the `AM` / `AL` / `Mode N` vocabulary is preserved as "internal architecture/evidence vocabulary" only. Mapping table provided in `PRODUCT-FLOW-ROADMAP.md` section 10. |

## 5. Validator Results

All five governed validators were re-run after the docs/, README, START-HERE, validator, and bundle updates.

| Validator | Command | Result |
|---|---|---|
| Package | `pwsh -NoProfile -File ./tools/Test-AisrafPackage.ps1` | **83 PASS, 3 WARN, 0 FAIL** (WARN rows are the accepted `runs/RUN-SMOKE-AM3-001/`, `runs/RUN-SMOKE-LOCAL-001/`, `runs/RUN-SMOKE-PLUGIN-L2B-001/` smoke-folder exceptions). |
| BP12A readiness | `pwsh -NoProfile -File ./tools/Test-AisrafBp12AReadiness.ps1` | **77 PASS, 0 FAIL** — status `BP12A_AUTOMATED_TEST_HARNESS_PASS`. |
| RUN-001 profile | `pwsh -NoProfile -File ./tools/Test-AisrafRunProfile.ps1 -RunProfilePath ./runs/RUN-001/run-profile.yaml -ExecutionReady` | **12 PASS, 0 FAIL** (level=ExecutionReady). |
| AM3 ContractsOnly | `pwsh -NoProfile -File ./tools/Test-AisrafAm3Runtime.ps1 -ContractsOnly` | **4 PASS, 0 FAIL**. |
| AM3 runtime | `pwsh -NoProfile -File ./tools/Test-AisrafAm3Runtime.ps1 -RunProfilePath ./runs/RUN-SMOKE-AM3-001/run-profile.yaml` | **23 PASS, 0 FAIL**. |

Package Check 16b (plugin bundle checksum validation) is GREEN: source/target SHA-256 match for all 201 bundled files after the `-Clean` rebuild.

## 6. Git Hygiene

| Check | Result |
|---|---|
| `git status --short` | 10 modified files (`README.md`, `RELEASE-MANIFEST.yaml`, `START-HERE.md`, `docs/ARCHITECTURE-OVERVIEW.md`, `docs/OPERATOR-QUICKSTART.md`, `docs/ROADMAP.md`, `docs/SECURITY-REVIEW-WORKFLOW.md`, `plugins/aisraf-copilot-plugin/bundle-checksum-manifest.yaml`, `plugins/aisraf-copilot-plugin/bundle/tools/Test-AisrafPackage.ps1`, `tools/Test-AisrafPackage.ps1`) and 7 untracked files (`docs/BRANCH-RELEASE-STRATEGY.md`, `docs/CONNECTED-REVIEW-FLOW-PLAN.md`, `docs/PLUGIN-INSTALL-UX-PLAN.md`, `docs/PRODUCT-FLOW-ROADMAP.md`, `docs/PROMPTS-SKILLS-AGENTS-TESTING-GUIDE.md`, `docs/THREAT-INTELLIGENCE-ENRICHMENT-PLAN.md`, `validation/package-12c-rel0-github-prerelease-stakeholder-asset-pack-report.md`). No staged files. The two untracked items that pre-date this gate (`docs/PROMPTS-SKILLS-AGENTS-TESTING-GUIDE.md` and `validation/package-12c-rel0-github-prerelease-stakeholder-asset-pack-report.md`) are inherited from the prior WP-12C-REL0-GITHUB-PRERELEASE-STAKEHOLDER-ASSET-PACK gate; this gate does not stage them and does not commit them. |
| `git diff --staged --name-only` | empty (no staged changes). |
| `git ls-files -- "*.docx" "*.pdf" "*.pptx" "*.zip"` | empty (no tracked binaries). |
| `git diff --name-only runs/RUN-001/` | empty (governed fixture untouched). |
| `git diff --name-only samples/` | empty (samples untouched). |
| `git diff --name-only prompts/ skills/ prototype-agents/ templates/ catalogs/ blueprints/ config/ .agents/ .github/agents/ .github/skills/ .github/hooks/ .copilot-skills/` | empty (source-content and provider-projection surfaces untouched). |
| `git diff --name-only LICENSE NOTICE.md` | empty (legal posture documents untouched). |
| `git diff --name-only plugins/aisraf-copilot-plugin/plugin.json plugins/aisraf-copilot-plugin/plugin.yaml` | empty (plugin metadata untouched). |

Per gate rules nothing was staged, committed, amended, rebased, force-pushed, tagged, or pushed in this gate. No GitHub Release was created.

## 7. Required Validation Replay

```text
pwsh -NoProfile -File ./tools/Test-AisrafPackage.ps1                            → 83 PASS, 3 WARN, 0 FAIL
pwsh -NoProfile -File ./tools/Test-AisrafBp12AReadiness.ps1                     → 77 PASS, 0 FAIL  (BP12A_AUTOMATED_TEST_HARNESS_PASS)
pwsh -NoProfile -File ./tools/Test-AisrafRunProfile.ps1 ... -ExecutionReady     → 12 PASS, 0 FAIL  (level=ExecutionReady)
pwsh -NoProfile -File ./tools/Test-AisrafAm3Runtime.ps1 -ContractsOnly          →  4 PASS, 0 FAIL
pwsh -NoProfile -File ./tools/Test-AisrafAm3Runtime.ps1 -RunProfilePath runs/RUN-SMOKE-AM3-001/run-profile.yaml → 23 PASS, 0 FAIL
```

## 8. Final Status

| Field | Value |
|---|---|
| work_package_status | `WP12C_REL0_PRODUCT_FLOW_ADAPTER_ROADMAP_REBASE_PASS_READY_FOR_OPERATING_FLOW_UX` |
| docs_created | `docs/PRODUCT-FLOW-ROADMAP.md`, `docs/CONNECTED-REVIEW-FLOW-PLAN.md`, `docs/THREAT-INTELLIGENCE-ENRICHMENT-PLAN.md`, `docs/PLUGIN-INSTALL-UX-PLAN.md`, `docs/BRANCH-RELEASE-STRATEGY.md`, `validation/package-12c-rel0-product-flow-adapter-roadmap-rebase-report.md` |
| docs_updated | `README.md`, `START-HERE.md`, `docs/ROADMAP.md`, `docs/OPERATOR-QUICKSTART.md`, `docs/SECURITY-REVIEW-WORKFLOW.md`, `docs/ARCHITECTURE-OVERVIEW.md`, `tools/Test-AisrafPackage.ps1`, `plugins/aisraf-copilot-plugin/bundle/tools/Test-AisrafPackage.ps1`, `plugins/aisraf-copilot-plugin/bundle-checksum-manifest.yaml` |
| product_flow_status | REBASED — 6-flow operating model published; `Mode N` retired from public docs; `AM`/`AL` vocabulary preserved as internal vocabulary; closed-loop autonomy out of scope. |
| observability_status | PRESENT AS FLOW 2 — captured alongside Local Orchestrated Review; no separate public mode promoted; internal vocabulary AM3/AL3 retained for contracts and validation. |
| plugin_install_ux_status | PLAN ONLY — repo-local evaluation today; seven install gates documented; target experience defined; no install change shipped in this gate. |
| connected_review_flow_status | PLAN ONLY — three use cases, six adapter areas, fixed 19-field Jira model, output model, and hard postback evidence rule documented; nothing implemented. |
| jira_confluence_status | PLAN ONLY — Jira intake, Jira design-review issue creation/update, Confluence handoff page creation/update documented as planned; not implemented; manual/local fallback retained as canonical path. |
| lucid_source_status | PLAN ONLY — Lucid/Lucidchart source ingestion documented as planned; not implemented; conversion-to-local rule recorded. |
| rovo_mcp_status | PLAN ONLY — Atlassian Rovo and Model Context Protocol path documented as planned; not implemented. |
| threat_intel_skill_status | PLAN ONLY — `SKL-THREAT-INTEL-CURRENT-CONTEXT` defined with NVD CVE API, CISA KEV, vendor advisories, official product documentation/security pages; nine hard rules including no-automatic-findings and human approval before promotion; not implemented. |
| branch_release_strategy_status | PUBLISHED — `master`, optional `release/v0.1.2`, `docs/product-flow-ux`, `docs/plugin-install-ux`, `fix/cross-shell-command-ux`, `feature/connected-*` (4), `feature/threat-intel-current-context`, `feature/runtime-observability-store`; tags `v0.1.2-eval`, `v0.1.3-ux`, `v0.2.0-connected-review`, `v0.2.1-threat-intel`, `v0.3.0-runtime-observability`. |
| validator_results | Package 83/3/0; BP12A 77/0; RUN-001 ExecutionReady 12/0; AM3 ContractsOnly 4/0; AM3 smoke 23/0. |
| overclaim_scan_status | PASS — no open-source claim, no production claim, no marketplace-published claim, no current Jira/Confluence/Lucid/Rovo/MCP execution claim, no current online threat-intel execution claim, no claim that connected adapters are implemented, no AL5 claim, no live post-back claim. |
| git_hygiene_results | PASS — nothing staged; no tracked binaries; `runs/RUN-001/`, `samples/`, `prompts/`, `skills/`, `prototype-agents/`, `templates/`, `catalogs/`, `blueprints/`, `config/`, `.agents/`, `.github/agents/`, `.github/skills/`, `.github/hooks/`, `.copilot-skills/`, `LICENSE`, `NOTICE.md`, `plugin.json`, `plugin.yaml` untouched. |
| remaining_blockers | None for this gate. The next gate (`WP-12C-REL0-OPERATING-FLOW-OBSERVABILITY-UX-REBASE`) is responsible for shipping the operating-flow / observability UX into the practitioner-facing surfaces. |
| may_OPERATING_FLOW_UX_REBASE_PROCEED | YES |
| may_CROSS_SHELL_COMMAND_UX_PROCEED | YES (after `WP-12C-REL0-OPERATING-FLOW-OBSERVABILITY-UX-REBASE`) |
| may_PLUGIN_INSTALL_UX_PROCEED | YES (after `WP-12C-REL0-CROSS-SHELL-COMMAND-UX`) |
| may_CONNECTED_REVIEW_ADAPTER_PLAN_PROCEED | YES (planning gate only; adapter implementation remains blocked behind explicit feature gates per `docs/BRANCH-RELEASE-STRATEGY.md`) |
| may_THREAT_INTEL_SKILL_PLAN_PROCEED | YES (planning gate only; skill authoring remains blocked behind an explicit governed skill update per `docs/THREAT-INTELLIGENCE-ENRICHMENT-PLAN.md`) |
| may_STAKEHOLDER_ASSET_REFRESH_PROCEED | YES (after `WP-12C-PLUGIN-INSTALL-UX-PACKAGING`, `WP-12C-CONNECTED-REVIEW-ADAPTER-PLAN`, and `WP-12C-THREAT-INTEL-CURRENT-CONTEXT-SKILL-PLAN` close) |
| may_PUSH_PREP_PROCEED | NO — push prep requires `WP-12C-REL0-FINAL-PUSH-PREP`; this gate is planning only and does not authorize push, tag, or GitHub Release. |
| exact_next_gate | `WP-12C-REL0-OPERATING-FLOW-OBSERVABILITY-UX-REBASE` |

## 9. Stop Conditions

- No push, no tag, no GitHub Release in this gate.
- No adapter implementation in this gate.
- No runtime code edit in this gate.
- No AM3 contract edit in this gate.
- No edits to `runs/RUN-001/`, `samples/`, `prompts/`, `skills/`, `prototype-agents/`, `templates/`, `catalogs/`, `blueprints/`, `config/`, `plugin.json`, or `plugin.yaml` in this gate.
- No DOCX/PDF/PPTX/ZIP binaries committed.
- No staging, committing, amending, rebasing, force-pushing, or tagging in this gate.
