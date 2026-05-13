# AISRAF Plugin Install UX Plan

| Field | Value |
|---|---|
| Document | docs/PLUGIN-INSTALL-UX-PLAN.md |
| Authority | WP-12C-REL0-PRODUCT-FLOW-ADAPTER-ROADMAP-REBASE |
| Current release | v0.1.2 — repo-local public evaluation package. Not marketplace-published. Not one-click install. |
| First UX target release | v0.1.3 — UX cleanup, cross-shell commands, plugin install/load UX. |
| Posture | Public source-available evaluation-only proof-of-concept. Not open source. Not production software. Not marketplace-published. |
| Out of scope | AL5 closed-loop autonomy. |

## 1. Purpose

This plan separates the **packaging flow** from the user review flow. Earlier docs implied the install path was already a clean, one-click experience. It is not. v0.1.2 is delivered as a repo-local evaluation package and the install is manual. This document defines the current truth and the target experience, and lists the install gates between them.

## 2. Current v0.1.2 Truth

- **Repo-local public evaluation package.** AISRAF ships as a public GitHub repository. The user clones or downloads the repository.
- **Not marketplace-published.** AISRAF is not in any IDE marketplace. There is no Marketplace "Install" button.
- **Not one-click install.** The install requires the user to open the repository folder in VS Code and let the local provider surface (VS Code Local plugin list, GitHub Copilot agent dropdown, or Copilot CLI) discover the AISRAF surfaces.
- **Provider surfaces included in repo.** `.agents/`, `.github/agents/`, `.github/skills/`, `.github/hooks/`, `.copilot-skills/`, and `plugins/aisraf-copilot-plugin/` are all part of the repository tree.

## 3. Target Install Experience (planned)

The user-facing install experience AISRAF is moving toward:

1. The user downloads a release package (or clones the public repo at the release tag).
2. The user opens a clean workspace.
3. The user installs/loads the AISRAF plugin/provider package (mechanism depends on provider: VS Code extension, GitHub Copilot plugin, Copilot CLI, etc.).
4. The provider surface lists `@aisraf-orchestrator` and the six specialist agents.
5. The user runs a "new review" command.
6. AISRAF creates a run folder under `runs/<run_id>/` automatically.
7. The user drops inputs (DFD, legend, design notes, intake ticket, transcript) into `runs/<run_id>/inputs/`.
8. The orchestrator guides the user through the review chain.
9. AISRAF captures observability evidence alongside the run outputs (run log, event log, handoff records, human gate records, validation results).
10. A validation command (`pwsh -NoProfile -File ./tools/Test-AisrafRunProfile.ps1 -RunProfilePath ./runs/<run_id>/run-profile.yaml -ExecutionReady`) confirms the result.

## 4. Install Gates

Each install gate is a separate, validator-backed step. AISRAF must pass earlier gates before claiming the next.

### 4.1 Local repo install (current)

- **What.** Clone or download the public GitHub repository; open the folder in VS Code; the local provider surface picks up the AISRAF agents, skills, and hooks.
- **Status.** Current v0.1.2 install path. Validator ladder green.
- **Proof.** `tools/Test-AisrafPackage.ps1` is green on a fresh clone.

### 4.2 Clean workspace install (v0.1.3)

- **What.** A user opens a clean (non-AISRAF) workspace and installs AISRAF as an additional surface, without copying the whole repository tree into their project.
- **Status.** Planned. Requires the packaged plugin install path below.
- **Proof gate.** Maintainer smoke workspace under a separate folder shows the plugin/provider surface and `@aisraf-orchestrator` appearing in the agent picker without workspace-local customization folders.

### 4.3 Packaged plugin install (v0.1.3 / v0.1.4)

- **What.** A user installs AISRAF from a packaged plugin artifact (VS Code extension package, GitHub Copilot plugin package, Copilot CLI plugin) rather than from a repository clone.
- **Status.** Planned. Requires bundle parity validation and a release pipeline that produces the plugin artifact.
- **Proof gate.** The packaged plugin's bundle matches the canonical surfaces by SHA-256 checksum (`Test-AisrafPackage.ps1` Check 16, 16a, 16b, 16c) and `@aisraf-orchestrator` appears in the agent picker.

### 4.4 Marketplace / private distribution evaluation (v0.1.4 / v0.2.0)

- **What.** AISRAF is evaluated for distribution through a marketplace or a private distribution channel.
- **Status.** Planned evaluation only. v0.1.2 is **not** marketplace-published. Public language must remain "evaluation-only" until the marketplace gate explicitly opens.
- **Proof gate.** A separate governed work package authorizes marketplace/private-distribution submission. License posture and notice posture are re-reviewed before submission.

### 4.5 Upgrade / uninstall path

- **What.** A user upgrades AISRAF from one release to the next, or removes AISRAF cleanly.
- **Status.** Planned. Upgrade must not silently mutate `runs/RUN-001/`, `samples/`, prompts/, skills/, prototype-agents/, templates/, catalogs/, blueprints/, config/, or `LICENSE`/`NOTICE.md`.
- **Proof gate.** Upgrade run leaves the canonical surfaces untouched and the validator ladder green.

### 4.6 Settings / variables path

- **What.** A user configures AISRAF settings (run-profile defaults, run-folder root, optional connected adapter targets later, optional threat-intel cache window later) without editing canonical files.
- **Status.** Planned. Settings live outside the canonical surface; defaults remain in `config/`.
- **Proof gate.** Configuration changes are recorded in `runs/<run_id>/00-run-log.md` for any run-affecting setting; no setting changes a governed file.

### 4.7 Run workspace path selection

- **What.** A user selects which folder under `runs/` (or a configured run root) holds their personal run folders.
- **Status.** Planned. Required so that AISRAF can be used inside a project repository without polluting the project tree.
- **Proof gate.** A run started from the new command lands in the chosen path and the run-profile validator passes.

## 4a. Plugin Install UX Milestones (Current vs Target)

The table below summarizes the install UX milestones from current v0.1.2 reality through the v0.2.x adapter horizon. Each row references the install gate in section 4.

| Milestone | Release | Status | Install gate(s) |
|---|---|---|---|
| **Repo-local evaluation.** Clone or download the public GitHub repository; open the folder in VS Code; local provider surface (`.agents/`, `.github/agents/`, `.github/skills/`, `.github/hooks/`, `.copilot-skills/`, `plugins/aisraf-copilot-plugin/`) is discovered from the repository tree. | v0.1.2 (current) | **Current.** Validator ladder green on a fresh clone. | 4.1 |
| **Local package load/discovery from a clean workspace.** A user opens a clean (non-AISRAF) workspace and AISRAF surfaces (orchestrator agent, specialist agents, provider Agent Skills, hook config) appear in the provider picker without copying the whole repository tree into the user's project. | v0.1.3 | **Planned.** Requires the maintainer smoke-workspace proof. | 4.2 |
| **Clean packaged plugin install.** A user installs AISRAF from a packaged plugin artifact (VS Code extension package, GitHub Copilot plugin package, Copilot CLI plugin) rather than from a repository clone. | v0.1.3 / v0.1.4 | **Planned.** Requires bundle parity validation and a release pipeline that produces the plugin artifact. | 4.3 |
| **Marketplace / private distribution evaluation.** AISRAF is evaluated for distribution through a marketplace or a private distribution channel. | v0.1.4 / v0.2.0 | **Planned evaluation only.** v0.1.2 is **not marketplace-published**; public language must remain "evaluation-only" until the marketplace gate explicitly opens. | 4.4 |
| **Connected adapter enablement (Connected Review Flow, Flow 4).** Jira intake, Confluence output, Lucid/Lucidchart source ingestion, Rovo/MCP, post-back controls. | v0.2.0 | **Planned.** Governed by [`docs/CONNECTED-REVIEW-FLOW-PLAN.md`](CONNECTED-REVIEW-FLOW-PLAN.md). Connected adapters are a **later gate** after the packaged plugin install path lands. | 4.3 + Connected Review Flow gate |

Until each milestone passes its install gate, the public documentation must continue to describe the **prior** milestone as the current install path. No milestone is implied to be complete simply because its successor is planned.

## 5. What Plugin Install UX Does Not Cover

The Plugin Install UX scope is the packaging-and-load surface. The following items are **out of scope** for this plan and have their own governing documents:

- AL5 closed-loop autonomy. Out of scope for the AISRAF roadmap.
- Connected Review Flow adapter implementation (Jira, Confluence, Lucidchart, Rovo, MCP, Foundry, ADK, MAF, database, Terraform, cloud, event bus, telemetry, post-back execution). Governed by [`docs/CONNECTED-REVIEW-FLOW-PLAN.md`](CONNECTED-REVIEW-FLOW-PLAN.md). Planned for v0.2.0.
- Threat Intelligence Enrichment implementation. Governed by [`docs/THREAT-INTELLIGENCE-ENRICHMENT-PLAN.md`](THREAT-INTELLIGENCE-ENRICHMENT-PLAN.md). Planned for v0.2.1.
- Mermaid Diagram Generation. Flow 6. Planned. Not in scope for this plan.
- Cloud runtime, database runtime, Terraform, event bus, telemetry backend, or marketplace publication inside the v0.1.2 release-hardening branch.

### 5a. Explicit Non-Claims

This plan does **not** claim any of the following for v0.1.2:

- **Marketplace install is current.** It is not. v0.1.2 is **not marketplace-published** and the install is manual.
- **Direct PNG/PDF image-to-DFD reading is implemented.** It is not. The governed DFD source-of-truth is the Mermaid file under `samples/sample-001-dfd-crop/inputs/dfd-crop.mmd`; PNG companions exist for human reading only.
- **Live Lucid/Lucidchart JSON ingestion is implemented.** It is not. Lucid source ingestion is part of Connected Review Flow (Flow 4, v0.2.0).
- **Live Jira intake, Confluence publication, Rovo, or MCP execution is implemented.** It is not. These are part of Connected Review Flow (Flow 4, v0.2.0).
- **Online threat-intelligence execution is implemented.** It is not. `SKL-THREAT-INTEL-CURRENT-CONTEXT` is part of Flow 5 (v0.2.1).
- **External post-back is performed.** No. AISRAF v0.1.2 writes only local Markdown under `runs/<run_id>/`.
- **Production readiness or hosted-service operation.** No. v0.1.2 is evaluation-only.
- **Closed-loop autonomy.** No. AL5 is out of scope.
- **Public users "run AM3."** No. Public users run AISRAF Local Orchestrated Review (Flow 1). `AM3` / `AL3` remain internal architecture/evidence vocabulary.

If any one of the items above becomes implemented in a later release, this plan must be updated together with the implementing work package, and the corresponding public claim must move from "planned" to "current" only after its install gate has passed.

## 6. References

- `docs/PRODUCT-FLOW-ROADMAP.md` — Flow 7 summary (Plugin Install UX). The flow was renumbered from Flow 6 to Flow 7 by `WP-12C-REL0-OPERATING-FLOW-OBSERVABILITY-UX-REBASE`, which inserted Mermaid Diagram Generation as the new Flow 6.
- `docs/BRANCH-RELEASE-STRATEGY.md` — branch and tag names for the install UX gates.
- `docs/OPERATOR-QUICKSTART.md` — operator quickstart for the current install path.
- `plugins/aisraf-copilot-plugin/PLUGIN-PACKAGING-PLAN.md` — packaging artifact plan for the current plugin scaffold.
- `validation/package-12c-rel0-product-flow-adapter-roadmap-rebase-report.md` — gate report that authorized this plan.
