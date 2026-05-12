# AISRAF Roadmap

| Field | Value |
|---|---|
| Document | docs/ROADMAP.md |
| Source draft | validation/package-12c-roadmap-draft.md |
| Promoted by | WP-12C-REL0-B — Public Release Docs |
| Re-positioned by | WP-12C-AM3-PLAN — AM3 (AL3 local orchestrated multi-agent runtime) is now an in-release lane before final v0.1.2 publish |
| Runtime evidence | WP-12C-AM3-QA accepted the bounded AM3 / AL3 local runtime evidence path under `runs/RUN-SMOKE-AM3-001/runtime/` |
| Release | AISRAF v0.1.2 |
| Current claim | AISRAF v0.1.2 proves AM3 / AL3 local orchestrated multi-agent runtime evidence |
| Claim limiter | Evidence-path claim only; not full specialist-generated review output execution, production readiness, publication, or AM4 integration |
| Deferred autonomy | AM4 external adapter / post-back execution remains future adapter work; AL5 closed-loop autonomy remains out of scope |

## 1. v0.1.2 Current Claim: AM3 / AL3 Local Runtime Evidence

AISRAF v0.1.2 ships:

- The canonical source package: prompts, skills, prototype agents, catalogs, blueprints, templates, config, tools, validation, samples, and the governed `runs/RUN-001/` fixture.
- Provider projection surfaces: `.agents/`, `.github/agents/`, `.github/skills/`, `.github/hooks/`, `.copilot-skills/`.
- The plugin scaffold `plugins/aisraf-copilot-plugin/` with `bundle/`, `bundle-checksum-manifest.yaml`, `plugin.json`, and `plugin.yaml`.
- The four conservative hook scripts and the provider hook config wiring them to PreToolUse, PostToolUse, and Stop events.
- The validator ladder: `Test-AisrafPackage.ps1`, `Test-AisrafBp12AReadiness.ps1`, `Test-AisrafRunProfile.ps1`.
- The public docs package: this document plus AISRAF-PRIMER, OPERATOR-QUICKSTART, SECURITY-REVIEW-WORKFLOW, ARCHITECTURE-OVERVIEW; and root release artifacts `RELEASE-MANIFEST.yaml`, `CHANGELOG.md`, `SECURITY.md`, `CONTRIBUTING.md`, `LICENSE`, `NOTICE.md`.

What the current release proves: AL2 controlled-output local workbench behavior on the installed plugin path under `runs/RUN-SMOKE-PLUGIN-L2B-001/`, with 0 FAIL across all four validators and no overclaim of external execution.

What the current AM3 gate proves: AISRAF v0.1.2 proves AM3 / AL3 local orchestrated multi-agent runtime evidence. AM3 evidence is local-only, human-gated, validator-backed, and evidence-bound. AISRAF Orchestrator owns run-state and event log. Specialist handoffs are represented by AM3-01 through AM3-06 request/response pairs. Human gates remain required.

What the current release does **not** claim: full specialist-generated review output execution, AM4 external adapter / post-back execution, AL5 closed-loop autonomy, marketplace publication, production operation, or any live external integration.

> **AM3 lane accepted local runtime evidence.** AM3 makes no network call, executes no Jira / Confluence / Lucidchart / MCP / cloud / database / Terraform / event bus / telemetry action, and does not introduce closed-loop autonomy. AM3 lane scope, DoD, tests, risks, runtime, and QA are governed by `validation/package-12c-am3-runtime-plan.md`, `validation/package-12c-am3-definition-of-done.md`, `validation/package-12c-am3-test-plan.md`, `validation/package-12c-am3-risk-register.md`, `validation/package-12c-am3-smoke-retry-evidence-report.md`, and `validation/package-12c-am3-qa-report.md`. AM4 external adapter execution remains future.

## 2. WP-12C-AM3 Lane (Accepted Local Evidence Path)

The WP-12C-AM3 lane delivered the local evidence path for AM3 / AL3 as the closing release lane for v0.1.2 before final publication can be considered. The lane is gated:

- **WP-12C-AM3-PLAN** — scope, architecture, DoD, test plan, risk register (predecessor gate; planning only; no runtime code).
- **WP-12C-AM3-CONTRACTS** — authors the four AM3 contract / schema files under `config/` (`am3.orchestrator-contract.v0_1_2.yaml`, `am3.handoff-contract.v0_1_2.yaml`, `am3.run-state.schema.v0_1_2.yaml`, `am3.event.schema.v0_1_2.yaml`) and the human-gate contract embedded in the orchestrator contract (closed predecessor gate; contract layer only).
- **WP-12C-AM3-RUNTIME** — authors `tools/Invoke-AisrafAm3LocalRun.ps1` (local-only AM3 runner) and `tools/Test-AisrafAm3Runtime.ps1` (AM3 validator route), with runtime scaffold writes restricted to a selected non-RUN-001 `output_root/runtime/`. Local-only. No network call.
- **WP-12C-AM3-EVIDENCE / SMOKE RETRY** — executes the founder-approved AM3 smoke run and captures evidence under local-only `runs/RUN-SMOKE-AM3-001/runtime/`.
- **WP-12C-AM3-QA** — accepts only the bounded AM3 / AL3 local orchestrated multi-agent runtime evidence claim and rejects any full-output, production, publication, or AM4 claim.
- **WP-12C-AM3-RELEASE-CLAIM-ALIGNMENT** — active language alignment gate for public docs and manifests. No staging, push, publish, runtime edits, or AM4 work.

Each AM3 gate requires the previous gate's evidence and passes the validator ladder with 0 FAIL.

## 3. WP-13: Release Visuals

WP-13 covers release diagrams and release visuals (architecture diagrams, workflow diagrams, plugin install diagrams, evidence diagrams). WP-13 has not started in v0.1.2; `diagrams/` and `release/` remain README-only folders reserved for their owning build packages.

WP-13 begins only after the docs/release boundary opens and a later gate authorizes publication preparation. WP-13 remains blocked after AM3 release-claim alignment.

## 4. Historical Orchestration Planning Names

Earlier orchestration planning names are superseded for the v0.1.2 cycle by the WP-12C-AM3 lane. The active release claim is no longer "AL3 later"; the accepted claim is the bounded AM3 / AL3 local orchestrated multi-agent runtime evidence path described above.

Those historical names do not authorize new runtime behavior, staging, publication, or AM4 adapter work. The only current AM3 claim is the local-only, human-gated, validator-backed, evidence-bound path accepted by WP-12C-AM3-QA.

## 5. AL4 Adapter Future (Deferred)

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

Each AM4 adapter is its own future work package. None are in v0.1.2 scope. Each will require its own QA, public-safety, and release-gate evidence before publication. The accepted AM3 evidence path does not introduce AM4 capability.

## 6. AL5: Out Of Scope

AL5 closed-loop autonomy (autonomous decision and action without operator-in-the-loop) is **not in current scope** for AISRAF. There is no AL5 work package on the roadmap. AM3 preserves the existing human gates and does not relax them.

## 7. Release Gates In Order

```text
v0.1.2 (AM3 / AL3 local runtime evidence accepted; not published)
  → WP-12C-AM3-PLAN          (closed — scope, architecture, DoD, tests, risks)
  → WP-12C-AM3-CONTRACTS     (closed — AM3 contracts + schemas under config/)
  → WP-12C-AM3-RUNTIME       (closed — AM3 local runner + AM3 validator)
  → WP-12C-AM3-EVIDENCE      (closed — local smoke evidence captured)
  → WP-12C-AM3-QA            (closed — bounded evidence claim accepted)
  → WP-12C-AM3-RELEASE-CLAIM-ALIGNMENT (active — public language alignment)
  → WP-12C-AM3-STAGE-COMMIT  (blocked pending this gate and human approval)
  → REL0-FINAL-QA            (blocked)
  → WP-13 release visuals    (still blocked by REL0 closure and BP12-SAMPLE-DFD blocker)
  → AL4 adapter work packages (one per adapter; future)
  → (AL5 is not on the roadmap)
```

Each gate requires the previous gate's evidence to be closed. Skipping gates is not authorized.

## 8. Validator Ladder

```powershell
pwsh -NoProfile -File ./tools/Test-AisrafPackage.ps1
pwsh -NoProfile -File ./tools/Test-AisrafBp12AReadiness.ps1
pwsh -NoProfile -File ./tools/Test-AisrafRunProfile.ps1 -RunProfilePath ./runs/RUN-001/run-profile.yaml -ExecutionReady
```
