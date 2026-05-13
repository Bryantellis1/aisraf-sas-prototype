# WP-12C-REL0-OPERATING-FLOW-OBSERVABILITY-UX-REBASE Report

Package: AISRAF SAS Prototype v0.1.2
Gate: `WP-12C-REL0-OPERATING-FLOW-OBSERVABILITY-UX-REBASE`
Posture: Public source-available evaluation-only proof-of-concept. Not open source. Not production software. Not marketplace-published. No current Connected Review Flow (Flow 4) execution. No current Threat Intelligence Enrichment (Flow 5) execution. No current Mermaid Diagram Generation (Flow 6) feature. Closed-loop autonomy is out of scope.

## 1. Founder Decision Recorded

Clean up the public operating-flow UX. The public flows are seven:

1. **Local Orchestrated Review** — normal user flow.
2. **Run Observability** — captured alongside Local Orchestrated Review.
3. **Release QA Flow** — maintainer-only.
4. **Connected Review Flow** — planned (v0.2.0).
5. **Threat Intelligence Enrichment** — planned (v0.2.1).
6. **Mermaid Diagram Generation** — planned. Produces a corrected Mermaid DFD from extracted facts as a review aid; original input diagram stays separate. **New flow inserted by this gate.**
7. **Plugin Install UX** — planned (v0.1.3 onward). **Renumbered from Flow 6 to Flow 7** to make room for Mermaid Diagram Generation.

Closed-loop autonomy is out of scope. `AM` / `AL` / `Mode N` remains as internal architecture/evidence vocabulary only.

Core product language anchored in this gate:

- Public users do **not** "run AM3."
- Public users run an **AISRAF Local Orchestrated Review**.
- AISRAF captures observability evidence (run-state, event log, handoff records, human gate records, validator results).
- AM3 / AL3 remains internal architecture/evidence vocabulary only.
- Release QA is a maintainer flow, not a user mode.
- Connected Review Flow, Threat Intelligence Enrichment, and Mermaid Diagram Generation are planned future flows, not current v0.1.2 behavior.

## 2. Repo Documentation Updated

| Path | Edit | Reason |
|---|---|---|
| `README.md` | Replaced the 6-flow operating-model table with the 7-flow table (Mermaid Diagram Generation inserted as Flow 6; Plugin Install UX renumbered to Flow 7). Added the "How Users Run AISRAF (Plain English)" section with the three user-journey paragraphs (application architect / solution architect — pre-review; security architect — review; maintainer / release path). Added the Run Observability target artifact set (`00-run-log.md`, `runtime/run-state.yaml`, `runtime/events.ndjson`, handoff records, human gate records, validation result summary). Added cross-shell command stubs (PowerShell 7 `pwsh`, Windows PowerShell `powershell.exe`, Git Bash invoking `powershell.exe`) with an explicit "not yet validated by an automated gate" disclaimer. Demoted the AISRAF-PRIMER pointer with a vocabulary-vintage note. | Required by the new operating model and the cross-shell preparation requirement. |
| `START-HERE.md` | Same flow-table refresh, plus the three-persona user-journey recap and the explicit "Public users do not 'run AM3'" line. | Required by the new operating model. |
| `docs/PRODUCT-FLOW-ROADMAP.md` | Promoted the operating model from six flows to seven; inserted Flow 6 Mermaid Diagram Generation (audience, current status, planned scope, hard rule); renumbered Flow 7 Plugin Install UX; rewrote Flow 1 with the application architect / solution architect pre-review journey and the security architect review journey; rewrote Flow 2 with the target observability artifact set and the v0.1.2 reality (local runtime evidence harness today; auto-emit during Flow 1 is the target product experience); rewrote Flow 3 with the maintainer / release path; renumbered Closed-Loop Autonomy section to 10; renumbered Old-Mode-Vocabulary section to 11; expanded Release Lane Summary to 12 with v0.2.2 (tentative) Mermaid lane and v0.3.0 auto-emit row. | Required by the founder decision. |
| `docs/OPERATOR-QUICKSTART.md` | Replaced the 6-flow operator-facing table with the 7-flow table. Added section 1a (Two User Journeys In Plain English) covering the application architect / solution architect pre-review journey and the security architect review journey, plus the explicit "Public users do not 'run AM3'" line. Added the Target Observability Artifact Set Per Run subsection. Added section 11 (Cross-Shell Command Snippets) with PowerShell 7, Windows PowerShell, and Git Bash invocations and a clear "not yet validated" disclaimer. | Required by the operating model and the cross-shell preparation requirement. |
| `docs/SECURITY-REVIEW-WORKFLOW.md` | Replaced the 6-flow workflow-meaning table with the 7-flow table. Added the Run Observability target evidence set and the local-runtime-evidence-harness reality. Added section 1a (Plain-English Journey Recap) covering the application architect / solution architect pre-review path and the security architect review path. Replaced section 7 ("Connected Review Flow And Threat Intelligence Enrichment") with section 7 ("Planned Future Features (Not Active In v0.1.2)") and added subsections 7.1 Connected Review Flow (with Jira issue field list and Confluence page section list and the post-back rule), 7.2 Threat Intelligence Enrichment, and 7.3 Mermaid Diagram Generation. | Required by the operating model, the Jira/Confluence template-planning requirement, and the future-feature-alignment requirement. |
| `docs/ARCHITECTURE-OVERVIEW.md` | Replaced the 6-flow architectural-boundary table with the 7-flow table. Added the Run Observability target evidence set. Renamed section 10 from "Planned Adapter And Skill Map" to "Planned Adapter, Skill, And Diagram Map" and added the Mermaid Diagram Generation subsection. Added section 11.1 (Cross-Shell Command Posture) with the cross-shell posture disclaimer. | Required by the operating model and the cross-shell preparation requirement. |
| `docs/ROADMAP.md` | Replaced the 6-flow release-state table with the 7-flow table. Updated Successor Release Lanes to add v0.2.2 (tentative) Mermaid lane and to reword v0.3.0 around auto-emit of run-state and event log into Flow 1. Added the cross-shell posture note to the validator ladder section. | Required by the operating model. |
| `docs/PROMPTS-SKILLS-AGENTS-TESTING-GUIDE.md` | Rewrote the posture callout to refer to Local Orchestrated Review (Flow 1) and Run Observability (Flow 2) as the current public flows, preserving the `Mode N` vocabulary used elsewhere as internal architecture/evidence vocabulary only. Replaced section 10 ("What Mode 1, Mode 2, Mode 3, Mode 4 Mean") with "Public Operating Flows And Their Internal `Mode N` Names" using the full 7-flow table with the internal-vocabulary mapping column. Updated the bullet list near the top to record the three planned-not-implemented features. Refreshed the closing posture to name Connected Review Flow (v0.2.0), Threat Intelligence Enrichment (v0.2.1), and Mermaid Diagram Generation as the planned future flows. | Required by the operating model. |
| `docs/CONNECTED-REVIEW-FLOW-PLAN.md` | Added a "Planned Confluence page sections" subsection (executive summary, design context, diagram/input inventory, extracted architecture facts, DFD annotations, missing facts, threat intelligence summary, targeted questions, findings, recommendations, handoff actions, validation summary, evidence/citation ledger). | Required by the Jira/Confluence template-planning requirement. |
| `docs/PLUGIN-INSTALL-UX-PLAN.md` | Updated the References block to record that the Plugin Install UX flow was renumbered from Flow 6 to Flow 7 by this gate, which inserted Mermaid Diagram Generation as the new Flow 6. | Required by the flow renumbering. |
| `docs/BRANCH-RELEASE-STRATEGY.md` | Added `feature/mermaid-diagram-generation` to the branch list and `v0.2.2-mermaid-generation` (tentative) to the tag list and to the release-lane summary table. | Required by the future-feature-alignment requirement. |
| `plugins/aisraf-copilot-plugin/README.md` | Replaced the legacy "Autonomy Terms In Plain English" block with the new "Product Operating Model (Plain English)" block listing the seven flows and the internal-vocabulary disclaimer. Refreshed the Operator Quick Start Q&A rows to use Local Orchestrated Review / Run Observability vocabulary, point at the new planning docs, and explicitly call out Mermaid Diagram Generation (Flow 6), Connected Review Flow (Flow 4, v0.2.0), and Threat Intelligence Enrichment (Flow 5, v0.2.1) as planned not implemented. Rewrote Current Boundaries with the same flow vocabulary. | Required by the operating model and the plugin-README inspect/update requirement. |
| `tools/Test-AisrafPackage.ps1` | Added `package-12c-rel0-operating-flow-observability-ux-rebase-report.md` to the validation/ allow-list. No other validator changes. | Validator must accept this report. |
| `plugins/aisraf-copilot-plugin/bundle/tools/Test-AisrafPackage.ps1` | Refreshed via `tools/Build-AisrafCopilotPluginBundle.ps1 -Clean` so the bundle copy matches the canonical tool. | Required by Check 16b plugin bundle checksum validation. |
| `plugins/aisraf-copilot-plugin/bundle-checksum-manifest.yaml` | Regenerated by the bundle build script (201 entries, all source/target SHA-256 match). | Required by Check 16b. |

No source-content surface was modified. `prompts/`, `skills/`, `prototype-agents/`, `.agents/`, `.github/agents/`, `.github/skills/`, `.github/hooks/`, `.copilot-skills/`, `templates/`, `catalogs/`, `blueprints/`, `config/`, `samples/`, `runs/`, `LICENSE`, `NOTICE.md`, `plugin.json`, and `plugin.yaml` are unchanged. AM3 contracts, AM3 runtime, AM3 smoke evidence, and `runs/RUN-001/` are unchanged. No runtime code was edited.

## 3. Posture Verification

| Posture rule | Status |
|---|---|
| No "open source" claim | PASS — every match is a NEGATIVE assertion ("not open source") or refers to the OSV "Open Source Vulnerabilities" database name (a planned future source in `docs/THREAT-INTELLIGENCE-ENRICHMENT-PLAN.md` section 4). |
| No "production-ready" / "production software" claim | PASS — every match is "not production software" or "does not prove production-grade execution". |
| No "marketplace-published" claim | PASS — every match is a NEGATIVE assertion ("not marketplace-published"). |
| No current Jira/Confluence/Lucid/Rovo/MCP execution claim | PASS — every match is a planned-only tag or an explicit "no live X" / "do not claim live X". |
| No current online threat-intelligence execution claim | PASS — `docs/THREAT-INTELLIGENCE-ENRICHMENT-PLAN.md` is explicitly tagged "Planning only. No online threat-intelligence execution is wired up in the current release-hardening branch." Every other match is a planned-only tag. |
| No current Mermaid generation feature claim | PASS — every Mermaid Diagram Generation match is tagged "planned" / "not implemented in v0.1.2" / "Flow 6 (planned)" / "would generate". No doc claims an active feature. |
| No current external post-back claim | PASS — hard post-back rule recorded in `docs/CONNECTED-REVIEW-FLOW-PLAN.md` section 5 and recapped in `docs/SECURITY-REVIEW-WORKFLOW.md` section 7.1. |
| No AL5 / closed-loop autonomy claim | PASS — every match is "out of scope". |
| No live adapter claim | PASS — every adapter is tagged "planned" or "not implemented in v0.1.2". |
| No "user runs AM3" instruction in public guidance | PASS — the only match is the explicit negative-instruction line in `docs/PRODUCT-FLOW-ROADMAP.md` section 3 telling readers **not** to use that phrasing. README, START-HERE, OPERATOR-QUICKSTART, SECURITY-REVIEW-WORKFLOW, ARCHITECTURE-OVERVIEW, and the plugin README all anchor on "user runs AISRAF Local Orchestrated Review" / "AISRAF captures observability evidence". |

## 4. Validator Results

All five governed validators were re-run after the doc updates and the bundle refresh.

| Validator | Command | Result |
|---|---|---|
| Package | `pwsh -NoProfile -File ./tools/Test-AisrafPackage.ps1` | **83 PASS, 3 WARN, 0 FAIL** (WARN rows are the accepted `runs/RUN-SMOKE-AM3-001/`, `runs/RUN-SMOKE-LOCAL-001/`, `runs/RUN-SMOKE-PLUGIN-L2B-001/` smoke-folder exceptions). |
| BP12A readiness | `pwsh -NoProfile -File ./tools/Test-AisrafBp12AReadiness.ps1` | **77 PASS, 0 FAIL** — status `BP12A_AUTOMATED_TEST_HARNESS_PASS`. |
| RUN-001 profile | `pwsh -NoProfile -File ./tools/Test-AisrafRunProfile.ps1 -RunProfilePath ./runs/RUN-001/run-profile.yaml -ExecutionReady` | **12 PASS, 0 FAIL** (level=ExecutionReady). |
| AM3 ContractsOnly | `pwsh -NoProfile -File ./tools/Test-AisrafAm3Runtime.ps1 -ContractsOnly` | **4 PASS, 0 FAIL**. |
| AM3 runtime | `pwsh -NoProfile -File ./tools/Test-AisrafAm3Runtime.ps1 -RunProfilePath ./runs/RUN-SMOKE-AM3-001/run-profile.yaml` | **23 PASS, 0 FAIL**. |

Package Check 16b (plugin bundle checksum validation) is GREEN: source/target SHA-256 match for all 201 bundled files after the `-Clean` rebuild.

## 5. Git Hygiene

| Check | Result |
|---|---|
| `git status --short` | 11 modified files (`README.md`, `RELEASE-MANIFEST.yaml`, `START-HERE.md`, `docs/ARCHITECTURE-OVERVIEW.md`, `docs/OPERATOR-QUICKSTART.md`, `docs/ROADMAP.md`, `docs/SECURITY-REVIEW-WORKFLOW.md`, `plugins/aisraf-copilot-plugin/README.md`, `plugins/aisraf-copilot-plugin/bundle-checksum-manifest.yaml`, `plugins/aisraf-copilot-plugin/bundle/tools/Test-AisrafPackage.ps1`, `tools/Test-AisrafPackage.ps1`) and 8 untracked files (`docs/BRANCH-RELEASE-STRATEGY.md`, `docs/CONNECTED-REVIEW-FLOW-PLAN.md`, `docs/PLUGIN-INSTALL-UX-PLAN.md`, `docs/PRODUCT-FLOW-ROADMAP.md`, `docs/PROMPTS-SKILLS-AGENTS-TESTING-GUIDE.md`, `docs/THREAT-INTELLIGENCE-ENRICHMENT-PLAN.md`, `validation/package-12c-rel0-github-prerelease-stakeholder-asset-pack-report.md`, `validation/package-12c-rel0-product-flow-adapter-roadmap-rebase-report.md`). The new validation report for this gate is also present at `validation/package-12c-rel0-operating-flow-observability-ux-rebase-report.md`. No staged files. The untracked items inherited from the prior two gates are not staged or committed by this gate. |
| `git diff --staged --name-only` | empty (no staged changes). |
| `git ls-files -- "*.docx" "*.pdf" "*.pptx" "*.zip"` | empty (no tracked binaries). |
| `git diff -- runs/RUN-001/` | empty (governed fixture untouched). |
| `git diff -- samples/` | empty (samples untouched). |
| `git diff -- prompts/ skills/ prototype-agents/ templates/ catalogs/ blueprints/ config/ .agents/ .github/agents/ .github/skills/ .github/hooks/ .copilot-skills/` | empty (source-content and provider-projection surfaces untouched). |

Per gate rules nothing was staged, committed, amended, rebased, force-pushed, tagged, or pushed in this gate. No GitHub Release was created. No adapter or runtime code was implemented.

## 6. Required Validation Replay

```text
pwsh -NoProfile -File ./tools/Test-AisrafPackage.ps1                            → 83 PASS, 3 WARN, 0 FAIL
pwsh -NoProfile -File ./tools/Test-AisrafBp12AReadiness.ps1                     → 77 PASS, 0 FAIL  (BP12A_AUTOMATED_TEST_HARNESS_PASS)
pwsh -NoProfile -File ./tools/Test-AisrafRunProfile.ps1 ... -ExecutionReady     → 12 PASS, 0 FAIL  (level=ExecutionReady)
pwsh -NoProfile -File ./tools/Test-AisrafAm3Runtime.ps1 -ContractsOnly          →  4 PASS, 0 FAIL
pwsh -NoProfile -File ./tools/Test-AisrafAm3Runtime.ps1 -RunProfilePath runs/RUN-SMOKE-AM3-001/run-profile.yaml → 23 PASS, 0 FAIL
```

## 7. Final Status

| Field | Value |
|---|---|
| work_package_status | `WP12C_REL0_OPERATING_FLOW_OBSERVABILITY_UX_REBASE_PASS_READY_FOR_CROSS_SHELL_COMMAND_UX` |
| docs_updated | `README.md`, `START-HERE.md`, `docs/PRODUCT-FLOW-ROADMAP.md`, `docs/OPERATOR-QUICKSTART.md`, `docs/SECURITY-REVIEW-WORKFLOW.md`, `docs/ARCHITECTURE-OVERVIEW.md`, `docs/ROADMAP.md`, `docs/PROMPTS-SKILLS-AGENTS-TESTING-GUIDE.md`, `docs/CONNECTED-REVIEW-FLOW-PLAN.md`, `docs/PLUGIN-INSTALL-UX-PLAN.md`, `docs/BRANCH-RELEASE-STRATEGY.md`, `plugins/aisraf-copilot-plugin/README.md`, `tools/Test-AisrafPackage.ps1`, `plugins/aisraf-copilot-plugin/bundle/tools/Test-AisrafPackage.ps1`, `plugins/aisraf-copilot-plugin/bundle-checksum-manifest.yaml`, plus this report. |
| local_orchestrated_review_status | REBASED — public flow vocabulary is anchored across README, START-HERE, OPERATOR-QUICKSTART, SECURITY-REVIEW-WORKFLOW, ARCHITECTURE-OVERVIEW, ROADMAP, PRODUCT-FLOW-ROADMAP, PROMPTS-SKILLS-AGENTS-TESTING-GUIDE, and the plugin README. Three plain-English user-journey paragraphs (application architect / solution architect pre-review, security architect review, maintainer / release) are recorded in README, START-HERE, OPERATOR-QUICKSTART, SECURITY-REVIEW-WORKFLOW, and PRODUCT-FLOW-ROADMAP. |
| run_observability_status | CLARIFIED — target evidence set per run (`00-run-log.md`, `runtime/run-state.yaml` or equivalent, `runtime/events.ndjson` or equivalent, handoff records, human gate records, validation result summary) is documented in README, START-HERE, OPERATOR-QUICKSTART, SECURITY-REVIEW-WORKFLOW, ARCHITECTURE-OVERVIEW, ROADMAP, PRODUCT-FLOW-ROADMAP, and the plugin README. The v0.1.2 reality is recorded plainly: "v0.1.2 includes a local runtime evidence harness; the target product experience is for the orchestrator to auto-emit during Flow 1." Auto-emit during Flow 1 is sized for the v0.3.0 lane. |
| release_qa_flow_status | CLARIFIED — maintainer-only path. Plain-English maintainer / release steps documented (validators → manifests → bundle checksum → blocker reports → no-binaries / no-secrets / no-overclaim → release posture confirmation). |
| connected_review_flow_status | PLAN ONLY (v0.2.0) — three use cases, six adapter areas, 19-field Jira model, Confluence page section list (executive summary → evidence/citation ledger), and hard post-back rule are all documented. Nothing implemented. |
| threat_intel_enrichment_status | PLAN ONLY (v0.2.1) — `SKL-THREAT-INTEL-CURRENT-CONTEXT` over NVD CVE API, CISA KEV, vendor advisories, official product documentation/security pages; OSV / GitHub Security Advisories optional later. Hard rules (no automatic findings; version/context confirmation; source + retrieval date + confidence on every fact; no private data sent externally; human approval before promotion). Nothing implemented. |
| mermaid_generation_status | PLAN ONLY — Flow 6 inserted as a new public flow. Hard rules recorded (generated diagram is a review aid, never ground truth; original input diagram and generated diagram stay at separate paths; Mermaid syntax and DFD annotation rules validated before exposure; human approval before treating the generated diagram as part of the review record). Nothing implemented. |
| plugin_install_ux_status | PLAN ONLY — Flow 7 (renumbered from Flow 6). Current truth (repo-local evaluation package; not marketplace-published; not one-click install) and seven install gates documented in `docs/PLUGIN-INSTALL-UX-PLAN.md`. Plugin README rewritten to use Local Orchestrated Review / Run Observability vocabulary and explicit "planned not implemented" tags for Flows 4, 5, and 6. |
| jira_confluence_template_status | DOCUMENTED — Jira design-review issue field model (19 fields) and Confluence page section list (13 sections) are recorded in `docs/CONNECTED-REVIEW-FLOW-PLAN.md` and recapped in `docs/SECURITY-REVIEW-WORKFLOW.md` section 7.1. Post-back rule (destination URL + operator approval + `postback_execution_status` + run-log entry + adapter response metadata without secrets) recorded as a hard rule. |
| lucid_source_status | PLAN ONLY — Lucid/Lucidchart source ingestion documented as planned, with the convert-to-local rule recorded in `docs/CONNECTED-REVIEW-FLOW-PLAN.md` section 3.4. |
| rovo_mcp_status | PLAN ONLY — Atlassian Rovo and Model Context Protocol path documented as an implementation detail of Flow 4 (`docs/CONNECTED-REVIEW-FLOW-PLAN.md` section 3.5); not implemented. |
| powershell_command_status | CROSS-SHELL STUBS LANDED — PowerShell 7 (`pwsh`) blocks remain the validator-tested baseline. Windows PowerShell (`powershell.exe`) and Git Bash invoking `powershell.exe` snippets are recorded in README and OPERATOR-QUICKSTART with an explicit "cross-shell parity is planned; not yet validated by an automated gate" disclaimer. ARCHITECTURE-OVERVIEW and ROADMAP carry the same cross-shell posture note. The cross-shell parity gate (`WP-12C-REL0-CROSS-SHELL-COMMAND-UX`) is the next gate. |
| validator_results | Package 83/3/0; BP12A 77/0; RUN-001 ExecutionReady 12/0; AM3 ContractsOnly 4/0; AM3 smoke 23/0. |
| overclaim_scan_status | PASS — no open-source claim, no production claim, no marketplace-published claim, no current Jira/Confluence/Lucid/Rovo/MCP execution claim, no current online threat-intelligence execution claim, no current Mermaid generation feature claim, no current external post-back claim, no AL5 / closed-loop autonomy claim, no live adapter claim, no "user runs AM3" instruction in public guidance. |
| git_hygiene_results | PASS — nothing staged; no tracked DOCX/PDF/PPTX/ZIP binaries; `runs/RUN-001/`, `samples/`, `prompts/`, `skills/`, `prototype-agents/`, `templates/`, `catalogs/`, `blueprints/`, `config/`, `.agents/`, `.github/agents/`, `.github/skills/`, `.github/hooks/`, `.copilot-skills/`, `LICENSE`, `NOTICE.md`, `plugin.json`, `plugin.yaml` all untouched. |
| remaining_blockers | None for this gate. The next gate (`WP-12C-REL0-CROSS-SHELL-COMMAND-UX`) is responsible for validating PowerShell 7 / Windows PowerShell / Git Bash command parity for the validator ladder and the runner scripts. |
| may_CROSS_SHELL_COMMAND_UX_PROCEED | YES |
| may_PLUGIN_INSTALL_UX_PROCEED | YES (after `WP-12C-REL0-CROSS-SHELL-COMMAND-UX`) |
| may_CONNECTED_REVIEW_ADAPTER_PLAN_PROCEED | YES (planning gate already passed in `WP-12C-REL0-PRODUCT-FLOW-ADAPTER-ROADMAP-REBASE`; adapter implementation remains blocked behind explicit feature gates) |
| may_THREAT_INTEL_SKILL_PLAN_PROCEED | YES (planning gate already passed; skill authoring remains blocked behind an explicit governed skill update) |
| may_MERMAID_GENERATION_PLAN_PROCEED | YES (planning lane is documented across the seven-flow operating model; feature authoring remains blocked behind an explicit governed work package and its own feature branch / tag per `docs/BRANCH-RELEASE-STRATEGY.md`) |
| may_STAKEHOLDER_ASSET_REFRESH_PROCEED | YES (after `WP-12C-REL0-CROSS-SHELL-COMMAND-UX` and `WP-12C-PLUGIN-INSTALL-UX-PACKAGING` close) |
| may_PUSH_PREP_PROCEED | NO — push prep requires `WP-12C-REL0-FINAL-PUSH-PREP`; this gate is UX/docs only and does not authorize push, tag, or GitHub Release. |
| exact_next_gate | `WP-12C-REL0-CROSS-SHELL-COMMAND-UX` |

## 8. Stop Conditions

- No push, no tag, no GitHub Release in this gate.
- No adapter implementation in this gate. No Jira, Confluence, Lucid, Rovo/MCP, CVE lookup, online research lookup, Mermaid generation, cloud runtime, database runtime, telemetry backend, or post-back execution code was written.
- No runtime code edit in this gate.
- No AM3 contract edit in this gate.
- No edits to `runs/RUN-001/`, `samples/`, `prompts/`, `skills/`, `prototype-agents/`, `templates/`, `catalogs/`, `blueprints/`, `config/`, `plugin.json`, or `plugin.yaml`.
- No edits to provider projection surfaces (`.agents/`, `.github/agents/`, `.github/skills/`, `.github/hooks/`, `.copilot-skills/`).
- No DOCX/PDF/PPTX/ZIP binaries committed.
- No staging, committing, amending, rebasing, force-pushing, or tagging in this gate.
