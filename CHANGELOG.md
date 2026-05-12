# Changelog

All notable changes to AISRAF are recorded here.

This changelog follows the spirit of Keep a Changelog and uses [SemVer](https://semver.org/) for the package version. The release is governed: every entry must trace to a work package, and every claim must be supported by evidence under `validation/` or by a validator script under `tools/`.

## [v0.1.2] — 2026-05-11

AISRAF v0.1.2 proves AM3 / AL3 local orchestrated multi-agent runtime evidence. The accepted evidence is local-only, human-gated, validator-backed, and evidence-bound. The day-to-day operator experience remains a local controlled-output workbench; this release does not claim AM4 external adapter execution, AL5 closed-loop autonomy, production operation, external post-back, marketplace publication, or push/publish approval.

Release journey modes are explicit in v0.1.2: Mode 0 read/preview with no writes; Mode 1 AL2 controlled-output workbench as the normal practitioner workflow; Mode 2 AM3 / AL3 local orchestrated runtime evidence as the release-visible local runtime journey/proof path; Mode 3 maintainer validation and release QA; and Mode 4 AM4 external adapter / post-back execution as future only. AL5 closed-loop autonomy remains out of scope.

### Added

- **Build Package 12C plugin package.** Plugin scaffold under `plugins/aisraf-copilot-plugin/` with `bundle/`, `bundle-checksum-manifest.yaml`, `plugin.json`, `plugin.yaml`, `README.md`, `PLUGIN-PACKAGING-PLAN.md`, `PLUGIN-TEST-CARD.md`, and `EVIDENCE-CHECKLIST.md`. Bundle is a by-reference projection of canonical surfaces, validated by SHA-256 source/target hash equality across every bundled file.
- **Agent and skill projections.** Provider projection surfaces under `.agents/` (7 canonical adapters), `.github/agents/` (7 byte-identical Copilot discovery projections), `.github/skills/<name>/SKILL.md` (7 provider Agent Skills packages), `.copilot-skills/` (7 thin skill wrappers + 7 operator cards + README).
- **Hook / validator guardrails.** `tools/hooks/` carries 4 conservative hook scripts (`aisraf-allowed-path-prewrite-guard.ps1`, `aisraf-focused-validator-postwrite.ps1`, `aisraf-session-stop-summary.ps1`, `aisraf-precommit-full-validator.ps1`) plus `README.md` and `hook-allow-list.yaml`. Provider hook config at `.github/hooks/aisraf-guardrails.json` wires PreToolUse, PostToolUse, and Stop events to the first three.
- **AM3 / AL3 local runtime evidence.** `runs/RUN-SMOKE-AM3-001/runtime/` proves the bounded local orchestrated multi-agent evidence path. AISRAF Orchestrator owns run-state and event log; specialist handoffs are represented by AM3-01 through AM3-06 request/response pairs; human gates remain required. The smoke folder is local-only and excluded from staging and publication.
- **Controlled-output smoke evidence.** L2B controlled-output execution under `runs/RUN-SMOKE-PLUGIN-L2B-001/` proved AL2 controlled-output behavior on the installed plugin path. The smoke run is local-only and excluded from staging.
- **Public release docs package.** `docs/AISRAF-PRIMER.md`, `docs/OPERATOR-QUICKSTART.md`, `docs/SECURITY-REVIEW-WORKFLOW.md`, `docs/ARCHITECTURE-OVERVIEW.md`, `docs/ROADMAP.md`. Root release artifacts: `RELEASE-MANIFEST.yaml`, `CHANGELOG.md`, `SECURITY.md`, `CONTRIBUTING.md`, `LICENSE`, `NOTICE.md`.
- **Validator coverage.** `Test-AisrafPackage.ps1` extended (Checks 08, 08a, 08a1, 08a2, 16, 16a, 16b, 16c) for the BP12C surface. `Test-AisrafBp12AReadiness.ps1` validates BP12A readiness. `Test-AisrafRunProfile.ps1` validates run-profile schema, scoring eligibility, and sensitive-data screen. `Test-AisrafAm3Runtime.ps1` validates AM3 contracts and local runtime evidence. The REL0 final QA ladder returns 0 FAIL; package-validator WARN rows are limited to local-only smoke folders.

### Changed

- **`docs/` allow-list.** `Test-AisrafPackage.ps1` Check 08-folder-content-limits now permits the 5 BP12C-REL0-B release docs files plus README.md in `docs/`. The remaining `docs/` surface remains reserved for Build Package 14.
- **Plugin bundle and checksum manifest.** Rebuilt by `tools/Build-AisrafCopilotPluginBundle.ps1 -Clean` after the validator update so source/target SHA-256 alignment is preserved across all 199 bundled files.

### Not changed (carry-over)

- Canonical source surfaces: `prompts/`, `skills/`, `prototype-agents/`, `catalogs/`, `blueprints/`, `templates/`, `config/`, `samples/`, and `runs/RUN-001/` are unchanged in this release.
- Provider projections (`.agents/`, `.github/agents/`, `.github/skills/`, `.github/hooks/`, `.copilot-skills/`) are unchanged in this release.

### Deferred (not in v0.1.2)

- Full specialist-generated review output execution beyond the accepted AM3 evidence path.
- AM4 external adapter / post-back execution (Jira, Confluence, Lucidchart, MCP, Anthropic Claude runtime adapter, Azure AI Foundry, Google ADK, Microsoft Agent Framework, database, Terraform, cloud runtime, event bus, telemetry backend).
- AL5 closed-loop autonomy (out of scope).
- Release visuals (future WP-13).
- Release automation (future).
- Marketplace publication (future).

### Security and external execution posture

- No external execution claim. The plugin does not contact Jira, Confluence, Lucidchart, MCP servers, cloud runtimes, databases, Terraform, event buses, or telemetry backends.
- All inputs and outputs are local Markdown / YAML / image files under approved run folders.
- Run-profile validator enforces `external_execution: false` for v0.1.2.
- Sensitive-data screen runs against run-profile string fields. Operator must affirm sensitive-data redaction.
- No production operation, external post-back, marketplace publication, push approval, or publish approval is granted by this release.

### Known warnings

- `runs/RUN-SMOKE-LOCAL-001/`, `runs/RUN-SMOKE-PLUGIN-L2B-001/`, and `runs/RUN-SMOKE-AM3-001/` are local-only smoke folders, ignored from staging, untracked, and unstaged. They surface as Check 14-runs-readme-only WARN rows on `Test-AisrafPackage.ps1`. All three are intentional and tracked in `RELEASE-MANIFEST.yaml` under `known_warnings`.
