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

## Autonomy Terms In Plain English

- **AL means Autonomy Level:** how autonomous the user experience is.
- **AM means Autonomy Mode / release evidence lane:** how AISRAF proves that autonomy capability.
- **Mode 0:** preview/read-only; no writes.
- **Mode 1 / AL2:** everyday controlled-output local workbench.
- **Mode 2 / AM3 / AL3:** local orchestrated runtime evidence path.
- **Mode 3:** maintainer validation and release QA.
- **Mode 4 / AM4:** future external adapter/post-back execution.
- **AL5:** closed-loop autonomy; out of scope.

## Operator Quick Start

| Question | Answer |
|---|---|
| What do I load or install? | Load or open the AISRAF package/plugin folder from this workspace or the local provider surface that points at it. |
| What should I see in the provider surface? | AISRAF agents, provider Agent Skills, and the AISRAF hook configuration. Provider discovery exposes those surfaces through `.github/agents/`, `.github/skills/`, `.github/hooks/`, `.copilot-skills/`, and this package bundle. |
| Which agent do I start with? | Start with `@aisraf-orchestrator`; specialist agents remain available for direct expert use. |
| Where do I place DFD/design inputs? | Put local inputs under `runs/<run_id>/inputs/`. |
| What is `run-profile.yaml`? | `runs/<run_id>/run-profile.yaml` controls the run id, local input paths, local output destination, sensitive-data confirmation, scoring coupling, and deferred external integration posture. |
| What outputs do I get? | Local Markdown outputs: `00-run-log.md`, `01-input-inventory.md` through `17-accuracy-score.md`, plus DFD outputs under `dfd/01` through `dfd/09`. |
| Where are outputs written? | Only under the approved local `runs/<run_id>/` folder. |
| How do I run another DFD/review? | Create a separate `runs/<run_id>/` folder, put that review's inputs under `inputs/`, validate its run profile, and start again with `@aisraf-orchestrator`. |
| What is local-only? | Review inputs, generated Markdown outputs, smoke evidence folders, `.claude/`, and AM3 runtime evidence are local-only and must not be published as external execution proof. |
| What is future AM4? | Jira, Confluence, Lucidchart, MCP/Rovo, cloud, database, Terraform, event bus, telemetry, and external post-back execution are future adapter work and are not active in v0.1.2. |

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

## Current Boundaries

- AISRAF v0.1.2 proves AM3 / AL3 local orchestrated multi-agent runtime evidence as a bounded evidence path.
- The everyday user experience remains Mode 1 / AL2 controlled-output local workbench.
- AM3 evidence is local-only, human-gated, validator-backed, and evidence-bound.
- No marketplace publication is claimed.
- No production readiness is claimed.
- No AM4 adapter execution is active.
- No Jira, Confluence, Lucidchart, MCP/Rovo, cloud, database, Terraform, event bus, telemetry, or external post-back execution occurs in v0.1.2.
- AL5 closed-loop autonomy is out of scope.

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
