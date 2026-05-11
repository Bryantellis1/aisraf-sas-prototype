# AISRAF Roadmap

| Field | Value |
|---|---|
| Document | docs/ROADMAP.md |
| Source draft | validation/package-12c-roadmap-draft.md |
| Promoted by | WP-12C-REL0-B — Public Release Docs |
| Release | AISRAF v0.1.2 |
| Current autonomy | AL2 (controlled-output local workbench) |
| Future autonomy | AL3 orchestrated multi-agent runtime is future WP-ORCH; AL4 external adapter / post-back is future adapter work; AL5 closed-loop autonomy is out of scope |

## 1. v0.1.2 (Current Release): AL2 Controlled-Output Local Workbench

AISRAF v0.1.2 ships:

- The canonical source package: prompts, skills, prototype agents, catalogs, blueprints, templates, config, tools, validation, samples, and the governed `runs/RUN-001/` fixture.
- Provider projection surfaces: `.agents/`, `.github/agents/`, `.github/skills/`, `.github/hooks/`, `.copilot-skills/`.
- The plugin scaffold `plugins/aisraf-copilot-plugin/` with `bundle/`, `bundle-checksum-manifest.yaml`, `plugin.json`, and `plugin.yaml`.
- The four conservative hook scripts and the provider hook config wiring them to PreToolUse, PostToolUse, and Stop events.
- The validator ladder: `Test-AisrafPackage.ps1`, `Test-AisrafBp12AReadiness.ps1`, `Test-AisrafRunProfile.ps1`.
- The public docs package: this document plus AISRAF-PRIMER, OPERATOR-QUICKSTART, SECURITY-REVIEW-WORKFLOW, ARCHITECTURE-OVERVIEW; and root release artifacts `RELEASE-MANIFEST.yaml`, `CHANGELOG.md`, `SECURITY.md`, `CONTRIBUTING.md`, `LICENSE`, `NOTICE.md`.

What the current release proves: AL2 controlled-output local workbench behavior on the installed plugin path under `runs/RUN-SMOKE-PLUGIN-L2B-001/`, with 0 FAIL across all four validators and no overclaim of external execution.

What the current release does **not** claim: AL3 orchestrated multi-agent runtime, AL4 external adapter / post-back execution, AL5 closed-loop autonomy, marketplace publication, production operation, or any live external integration.

## 2. WP-13: Release Visuals

WP-13 covers release diagrams and release visuals (architecture diagrams, workflow diagrams, plugin install diagrams, evidence diagrams). WP-13 has not started in v0.1.2; `diagrams/` and `release/` remain README-only folders reserved for their owning build packages.

WP-13 begins only after the docs/release boundary opens and the L3 staging gate authorizes publication preparation.

## 3. WP-ORCH0..ORCH5: Future AL3 Orchestrated Multi-Agent Runtime

The future `WP-ORCH0` through `WP-ORCH5` work-package series will move AISRAF from AL2 controlled-output local workbench to AL3 orchestrated multi-agent runtime. The expected scope:

- **WP-ORCH0** — Orchestration design and architecture spec (delegation contracts, agent-side state and memory contracts, runtime policy enforcement model, runtime evidence emission model). No runtime implementation.
- **WP-ORCH1** — Orchestration runtime skeleton: orchestrator-to-specialist delegation primitive, agent-side state container, hand-off contract enforcement, runtime evidence emission stub. Local-only.
- **WP-ORCH2** — Specialist agent runtime adapters under the new delegation primitive. Each PRA gets a runtime-callable adapter. Path-guard, validator, and sensitive-data screen remain enforced. Local-only.
- **WP-ORCH3** — Runtime policy engine: capability gates, run-profile enforcement, scoring eligibility coupling at runtime. Local-only.
- **WP-ORCH4** — Runtime evidence emission: structured run-log events, decision trace, hand-off audit trail. Local-only.
- **WP-ORCH5** — Runtime QA, regression harness, and orchestration smoke evidence. Local-only.

WP-ORCH is **not in v0.1.2 scope**. AL3 is future-only.

## 4. AL4 Adapter Future (Deferred)

AL4 covers external adapter / post-back execution. The following are deferred adapter targets and are not implemented in v0.1.2:

- **Jira ticket intake** — read intake tickets from Jira instead of local Markdown.
- **Confluence post-back** — publish handoff packs to Confluence.
- **Lucidchart adapter** — read DFD source directly from Lucidchart.
- **MCP runtime** — integrate AISRAF agents into an MCP server / client topology.
- **Anthropic Claude runtime adapter** — first-party Claude runtime path (separate from current local-projection use).
- **Azure AI Foundry** — runtime adapter for Foundry-hosted agents.
- **Google ADK** — runtime adapter for the Google Agent Development Kit.
- **Microsoft Agent Framework (MAF)** — runtime adapter for MAF-hosted agents.
- **Database-backed runtime** — durable storage for run state, evidence, and audit trail.
- **Terraform / cloud deployment** — infrastructure-as-code for any cloud runtime path.
- **Cloud runtime** — managed-service execution path.
- **Event bus** — async coordination between specialist agents and external systems.
- **Telemetry backend** — runtime metrics, tracing, and observability.
- **External post-back execution** — generic post-back pipeline for external systems.

Each AL4 adapter is its own future work package. None are in v0.1.2 scope. Each will require its own QA, public-safety, and release-gate evidence before publication.

## 5. AL5: Out Of Scope

AL5 closed-loop autonomy (autonomous decision and action without operator-in-the-loop) is **not in current scope** for AISRAF. There is no AL5 work package on the roadmap.

## 6. Release Gates In Order

```text
v0.1.2 (current, AL2)
  → WP-13 release visuals
  → WP-ORCH0 design
  → WP-ORCH1..ORCH5 runtime
  → AL4 adapter work packages (one per adapter)
  → (AL5 is not on the roadmap)
```

Each gate requires the previous gate's evidence to be closed. Skipping gates is not authorized.

## 7. Validator Ladder

```powershell
pwsh -NoProfile -File ./tools/Test-AisrafPackage.ps1
pwsh -NoProfile -File ./tools/Test-AisrafBp12AReadiness.ps1
pwsh -NoProfile -File ./tools/Test-AisrafRunProfile.ps1 -RunProfilePath ./runs/RUN-001/run-profile.yaml -ExecutionReady
```
