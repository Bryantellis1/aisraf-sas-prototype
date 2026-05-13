---
plugin_id: aisraf-copilot-plugin
plugin_name: AISRAF SAS Copilot Plugin
plugin_version: 0.0.0-local-package
work_package: WP-12C-REL0-RELEASE-DECISION-REMEDIATION
lifecycle_status: local_provider_projection_package
provider: GitHub Copilot
package_type: local_package_surface
canonical_source_of_truth: outside_this_folder
external_execution: disabled
postback_execution_status: deferred
output_destination_mode: local_only
runtime_claims: none
---

# AISRAF SAS Copilot Plugin

AISRAF v0.1.2 includes a local plugin/package surface under `plugins/aisraf-copilot-plugin/`. The package is a projection of the governed AISRAF source surfaces, not a new source of truth and not a marketplace publication claim.

## Product Operating Model (Plain English)

Public users do **not** "run AM3." Public users run an **AISRAF Local Orchestrated Review** (Flow 1) and AISRAF captures **observability evidence** (Flow 2) alongside the run. The seven product flows are documented in [`docs/PRODUCT-FLOW-ROADMAP.md`](../../docs/PRODUCT-FLOW-ROADMAP.md):

1. Local Orchestrated Review (current).
2. Run Observability (current; emitted today through a local runtime evidence harness — the target product experience is for the orchestrator to auto-emit during Flow 1).
3. Release QA Flow (maintainer-only; current).
4. Connected Review Flow (planned for v0.2.0).
5. Threat Intelligence Enrichment (planned for v0.2.1).
6. Mermaid Diagram Generation (planned).
7. Plugin Install UX (planned for v0.1.3 onward).

Closed-loop autonomy is **out of scope**. `AM3` / `AL3` and `Mode N` remain as **internal architecture/evidence vocabulary** in contracts, runtime files, and validation artifacts.

## Operator Quick Start

| Question | Answer |
|---|---|
| What do I load or install? | Load or open the AISRAF package/plugin folder from this workspace or the local provider surface that points at it. (v0.1.2 is delivered as a repo-local evaluation package; the clean plugin install/load UX is planned for v0.1.3 onward — see [`docs/PLUGIN-INSTALL-UX-PLAN.md`](../../docs/PLUGIN-INSTALL-UX-PLAN.md).) |
| What should I see in the provider surface? | AISRAF agents, provider Agent Skills, and the AISRAF hook configuration. Provider discovery exposes those surfaces through `.github/agents/`, `.github/skills/`, `.github/hooks/`, `.copilot-skills/`, and this package bundle. |
| Which agent do I start with? | Start with `@aisraf-orchestrator`; specialist agents remain available for direct expert use. |
| Where do I place DFD/design inputs? | Put local inputs under `runs/<run_id>/inputs/`. |
| What is `run-profile.yaml`? | `runs/<run_id>/run-profile.yaml` controls the run id, local input paths, local output destination, sensitive-data confirmation, scoring coupling, and deferred external integration posture. |
| What outputs do I get? | Local Markdown outputs: `00-run-log.md`, `01-input-inventory.md` through `17-accuracy-score.md`, plus DFD outputs under `dfd/01` through `dfd/09`. Observability evidence (run-state, event log, handoff records, human gate records, validation summary) is captured alongside under the same run folder when the local runtime evidence harness is invoked. |
| Where are outputs written? | Only under the approved local `runs/<run_id>/` folder. |
| How do I run another DFD/review? | Create a separate `runs/<run_id>/` folder, put that review's inputs under `inputs/`, validate its run profile, and start again with `@aisraf-orchestrator`. |
| What is local-only? | Review inputs, generated Markdown outputs, smoke evidence folders, `.claude/`, and run observability evidence are local-only and must not be published as external execution proof. |
| What is future Connected Review Flow? | Connected Review Flow (Flow 4, planned for v0.2.0) covers Jira, Confluence, Lucidchart, MCP/Rovo, cloud, database, Terraform, event bus, telemetry, and external post-back execution. These are **not active in v0.1.2**. See [`docs/CONNECTED-REVIEW-FLOW-PLAN.md`](../../docs/CONNECTED-REVIEW-FLOW-PLAN.md). |
| What is future Threat Intelligence Enrichment? | Threat Intelligence Enrichment (Flow 5, planned for v0.2.1) is the `SKL-THREAT-INTEL-CURRENT-CONTEXT` skill over NVD CVE API, CISA KEV, vendor advisories, and official product documentation/security pages. **Not active in v0.1.2.** See [`docs/THREAT-INTELLIGENCE-ENRICHMENT-PLAN.md`](../../docs/THREAT-INTELLIGENCE-ENRICHMENT-PLAN.md). |
| What is future Mermaid Diagram Generation? | Mermaid Diagram Generation (Flow 6, planned) generates a corrected Mermaid DFD from extracted facts as a review aid. Original input diagram stays separate. **Not active in v0.1.2.** |

## Package Surface

`plugin.json` points only to bundled local/provider surfaces:

- `bundle/.github/agents/`
- `bundle/.github/skills/`
- `bundle/.github/hooks/aisraf-guardrails.json`

`plugin.yaml` keeps external execution disabled, keeps post-back deferred, and records the package as local-output only. The bundle and `bundle-checksum-manifest.yaml` are governed projection outputs built from canonical/provider sources and validated by the package validator.

## Source Of Truth

Canonical AISRAF review logic remains outside this plugin folder:

- `prompts/`
- `skills/`
- `prototype-agents/`
- `.agents/`
- `templates/`
- `catalogs/`
- `blueprints/`
- `config/`
- `tools/`
- `validation/`
- `samples/`
- `runs/RUN-001/`

Provider and local projection surfaces also remain governed outside this README:

- `.github/agents/`
- `.github/skills/`
- `.github/hooks/`
- `.copilot-skills/`
- `plugins/aisraf-copilot-plugin/bundle/`

No file inside this plugin folder overrides canonical prompts, skills, prototype-agent specifications, catalogs, blueprints, templates, run-profile rules, validators, or fixture content.

## What This Plugin Package Is Today (v0.1.2)

- A **repo-local public evaluation package**. The plugin folder ships inside the public GitHub repository; it is **not** an installable artifact from a marketplace.
- A **bundled projection of the canonical provider surfaces** for agents, skills, and hooks. The bundle is governed and built from canonical sources by `tools/Build-AisrafCopilotPluginBundle.ps1`.
- **Not marketplace-published.** AISRAF v0.1.2 is not listed in any IDE marketplace, GitHub Marketplace, Visual Studio Marketplace, or Copilot extension marketplace.
- **Not a one-click install.** Discovery happens by opening the repository folder in VS Code and letting the local provider surface (VS Code Local plugin list, GitHub Copilot agent dropdown, or Copilot CLI) read the AISRAF surfaces from the repo tree.
- **Not external execution.** External adapter execution, post-back, online threat-intel calls, Mermaid generation, and closed-loop autonomy are **not** implemented in v0.1.2.

## What The Evaluator Sees

When the AISRAF v0.1.2 repository is open in VS Code (with GitHub Copilot enabled) and the provider surface has loaded, the evaluator should see:

- **`@aisraf-orchestrator`** in the Copilot agent picker. This is the **main entrypoint** and recommended first contact.
- Six **specialist agents** as helper roles: `@aisraf-input-reader`, `@aisraf-dfd-extractor`, `@aisraf-review-table-builder`, `@aisraf-blueprint-questioner`, `@aisraf-finding-recommender`, `@aisraf-handoff-qa-scorer`. These are routed to by the orchestrator or invoked directly only for targeted single-step expert use.
- The **AISRAF provider Agent Skills packages** under `.github/skills/<name>/SKILL.md`, loaded through the agents.
- The **AISRAF hook configuration** (`.github/hooks/aisraf-guardrails.json`) declaring `PreToolUse`, `PostToolUse`, and `Stop` events.
- The **plugin bundle** under `plugins/aisraf-copilot-plugin/bundle/` and the governed `bundle-checksum-manifest.yaml`, which the package validator verifies against canonical surfaces.

Outputs from any review session land only as **local Markdown** under the operator's `runs/<run_id>/` folder. The plugin makes **no network call** and performs **no external post-back** in v0.1.2.

## Future Plugin UX (Planned, Not Active Today)

The clean plugin install/load UX is governed by [`../../docs/PLUGIN-INSTALL-UX-PLAN.md`](../../docs/PLUGIN-INSTALL-UX-PLAN.md). The planned milestones are:

1. **Local package load/discovery from a clean workspace (v0.1.3).** An evaluator opens a clean (non-AISRAF) workspace, and AISRAF agents/skills/hooks appear in the provider picker without copying the whole repository tree into the user's project.
2. **Clean packaged plugin install (v0.1.3 / v0.1.4).** Install AISRAF from a packaged plugin artifact (VS Code extension package, GitHub Copilot plugin package, or Copilot CLI plugin) rather than from a repository clone. Bundle parity is validated by the package validator.
3. **Marketplace or private-distribution evaluation (v0.1.4 / v0.2.0).** A later, separately-gated decision. v0.1.2 is **not** marketplace-published and public language remains "evaluation-only" until the marketplace gate explicitly opens.
4. **Connected Review Flow adapter enablement (v0.2.0).** Jira intake, Confluence publication, Lucid/Lucidchart source ingestion, Rovo/MCP mediation, operator-approved post-back. Governed by [`../../docs/CONNECTED-REVIEW-FLOW-PLAN.md`](../../docs/CONNECTED-REVIEW-FLOW-PLAN.md). Requires the packaged plugin install path to be in place first.

Each milestone is gated; AISRAF will not claim a milestone is complete until its install gate has passed.

## Current Boundaries

- AISRAF v0.1.2 supports Local Orchestrated Review (Flow 1) with Run Observability (Flow 2) captured through a local runtime evidence harness.
- The everyday user experience is Local Orchestrated Review under `@aisraf-orchestrator`.
- Run Observability evidence is local-only, human-gated, validator-backed, and evidence-bound.
- No marketplace publication is claimed.
- No production readiness is claimed.
- No Connected Review Flow (Flow 4) adapter execution is active. Jira, Confluence, Lucidchart, MCP/Rovo, cloud, database, Terraform, event bus, telemetry, and external post-back execution are planned for v0.2.0 and are not active in v0.1.2.
- No Threat Intelligence Enrichment (Flow 5) is active. `SKL-THREAT-INTEL-CURRENT-CONTEXT` is planned for v0.2.1 and is not active in v0.1.2.
- No Mermaid Diagram Generation (Flow 6) is active. It is planned and not active in v0.1.2.
- No direct PNG/PDF image-to-DFD extraction is claimed. The governed sample DFD source-of-truth is the Mermaid file under `samples/sample-001-dfd-crop/inputs/dfd-crop.mmd`.
- Closed-loop autonomy is out of scope.

## Validation

Run the governed validator ladder from the repository root:

```powershell
pwsh -NoProfile -File ./tools/Test-AisrafPackage.ps1
pwsh -NoProfile -File ./tools/Test-AisrafBp12AReadiness.ps1
pwsh -NoProfile -File ./tools/Test-AisrafRunProfile.ps1 -RunProfilePath ./runs/RUN-001/run-profile.yaml -ExecutionReady
```

The AM3 evidence validators are:

```powershell
pwsh -NoProfile -File ./tools/Test-AisrafAm3Runtime.ps1 -ContractsOnly
pwsh -NoProfile -File ./tools/Test-AisrafAm3Runtime.ps1 -RunProfilePath ./runs/RUN-SMOKE-AM3-001/run-profile.yaml
```

## License And Notice

`LICENSE` and `NOTICE.md` define AISRAF v0.1.2 as a public source-available evaluation-only proof-of-concept. Not open source. Not production software. Not marketplace-published. The license permits evaluation, review, demonstration, and proof-of-concept testing only, and does not grant production use, commercial use, redistribution, hosted service offering, or marketplace publication rights without separate written permission.
