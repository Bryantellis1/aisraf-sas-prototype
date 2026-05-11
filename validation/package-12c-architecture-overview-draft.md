# Build Package 12C - Architecture Overview Draft

| Field | Value |
|---|---|
| Work package | WP-12C-PRIMER0 / WP-12C-ED1 - Public Repository Primer And Security Architect Journey Draft (ED1 readability pass applied) |
| Status | Pre-release public-reader draft; validation-owned; not promoted to docs or release |
| Audience | Security architect, solution architect, application/product team, engineering team, governance/reviewer, contributor/maintainer, public technical reader/evaluator |
| Boundary | Canonical source package, projection surfaces, deferred adapters, release separation |
| Current autonomy | AL2 controlled-output local workbench; AL3 orchestrated multi-agent runtime is future WP-ORCH |
| Release posture | Not public-release-ready; L3, REL0, and WP-13 remain blocked |

## 1. Architecture Summary

AISRAF is a governed local AI-assisted security architecture review workbench. It keeps canonical review logic in package source folders, projects thin provider-facing surfaces for operator use, validates boundaries through local tools and hooks, and treats plugin packaging as a projection layer rather than source of truth.

The current package is a strong pre-release prototype / local workbench package. It is evidence-bound and validation-backed, but it is not a public release, not a production cloud service, and not a live external-integration runtime.

### 1.1 Autonomy levels and AI component pattern

| Autonomy level | Description | v0.1.2 state |
|---|---|---|
| AL2 | Controlled-output local workbench: operator selects a role, role writes governed outputs only inside an approved scratch run folder, hooks enforce path guards and validators. | **Current.** Proven by L2B controlled-output execution under `runs/RUN-SMOKE-PLUGIN-L2B-001/`. |
| AL3 | Orchestrated multi-agent runtime: Orchestrator delegates to specialist agents under runtime policy enforcement and runtime evidence emission. | **Future WP-ORCH.** Deferred. |
| AL4 / AL5 | External tool/post-back execution and higher autonomy. | **Not claimed.** Out of scope. |

| AI component pattern | Meaning | v0.1.2 state |
|---|---|---|
| AI **for** / **outside** component | AI assists the human reviewer from outside the system under review. | **Current.** |
| AI **beside** / **on** component | AI sits alongside the component, orchestrator-coordinated, still chat-preview-only with controlled-write-on-approval. | **Emerging target.** |
| AI **inside** component | AI embedded in component runtime with its own state, tools, memory, and policy enforcement. | **Not current.** Deferred to ORCH. |

Current execution model: one selected AISRAF agent session (typically `@aisraf-orchestrator`) acts as a temporary orchestrator coordinating sequential specialist work. The plugin packages the orchestrator, specialists, skills, hooks, and validator references as one installable projection.

## 2. Concept-To-Release Spine

```text
Concept
  → Stakeholder / Scenario
  → Value Outcome
  → Value Stream / Stage
  → Capability
  → ProcessFlowSpecification
  → TaskFlowSpecification
  → Agent Specification
  → Skill Contract
  → Tool / Hook / Policy
  → Knowledge / Data Product Contract
  → Memory / State
  → Evaluation / Metrics
  → Evidence
  → Platform Projection
  → Plugin
  → Solution Package / Release
```

The spine keeps AISRAF honest. A process or task spec is design-time, not runtime proof. A plugin is a projection surface, not a release. A release requires QA, public-safety evidence, staging, docs, manifest, license, notice, and release approval.

## 3. Canonical Source Package

Canonical source package surfaces:

- `prompts/`
- `skills/`
- `prototype-agents/`
- `catalogs/`
- `blueprints/`
- `templates/`
- `config/`
- `tools/`
- `validation/`
- `samples/`
- `runs/RUN-001/`

Canonical source remains in these folders. Provider projections and plugin bundles must reference or checksum-copy canonical material without becoming source of truth.

## 4. Projection Surfaces

Projection surfaces:

- `.agents/`
- `.github/agents/`
- `.github/skills/`
- `.github/hooks/`
- `.copilot-skills/`
- `plugins/aisraf-copilot-plugin/`

Projection surfaces make AISRAF usable in local/provider workflows. They do not authorize runtime, cloud, database, Terraform, MCP, Jira, Confluence, Lucidchart, or external post-back claims.

## 5. Plugin Vs Release

- **Plugin** = installable/projection surface that bundles the orchestrator, the seven specialist agents, the seven skill wrappers and operator cards, the seven provider Agent Skills packages, and the provider hook config. It mirrors canonical material by reference and checksum, not by re-authoring authority.
- **Release** = governed publication package with manifest, license, notice, changelog, docs, QA, staging, public-safety evidence, and an explicit release-gate authorization. A release is created by REL0 and approved by L3, not by packaging the plugin.

The plugin package can prove provider projection and checksum alignment (validated by `Test-AisrafPackage.ps1` Check 16, 16a, 16b, and 16c). It does not, by itself, prove release approval, production operation, marketplace publication, or external integrations.

Plugin install discovery and packaging were proven at L2A (preview-only role smoke from the isolated smoke workspace) and L2B (controlled-output execution under `runs/RUN-SMOKE-PLUGIN-L2B-001/`). L3 staging and REL0 release-manifest work are both blocked until the QA1 blocker register closes.

## 6. Design-Time Vs Runtime

- PFS/TFS are design-time specs.
- `RUN-001` and `RUN-SMOKE-*` are runtime evidence/state.
- QA/editor/release agents are package-governance agents, not PRA review agents.

PRA-01 through PRA-08 define the AISRAF security-review chain. QA, editor, primer, release, and future governance agents inspect or document the package; they do not run the security-review chain or produce findings, recommendations, AI Action Level classifications, blueprint matches, or scores.

## 7. Knowledge/Data Product Layer

- Catalogs = controlled vocabulary.
- Blueprints = review patterns.
- Templates = output contracts.
- Schemas/run profiles = execution contracts.
- Validation/evidence = proof contracts.

Unknowns, missing facts, deferred states, and insufficient evidence must remain visible. Catalogs do not compute severity, AI Action Level, scoring, blueprint match, or recommendations. Blueprints are reusable patterns, not findings. Templates define output shape, not proof.

## 8. Evaluation

Evaluation layers include:

- Package validator.
- BP12A readiness.
- RUN-001 execution-ready validation.
- Role smoke.
- Controlled-output smoke.
- QA report.
- Release blocker register.

Current accepted baseline for PRIMER0 starts from 0 FAIL validator posture and a known smoke-folder WARN that must remain excluded from staging until L3.

## 9. Deferred Adapter Map

Deferred adapters and surfaces, not implemented in the current package:

- Jira ticket intake.
- Confluence post-back.
- Lucidchart direct adapter.
- MCP runtime.
- Claude runtime adapter.
- Azure AI Foundry runtime adapter.
- Google ADK adapter.
- Microsoft Agent Framework adapter.
- Database-backed runtime.
- Terraform/cloud deployment.
- Cloud runtime.
- External post-back execution.
- Release automation.

These may be discussed only as future/deferred/not implemented. They are not live, production, marketplace, or public-release capabilities.

## 10. Testing Path

Use these validation-owned references:

- `validation/package-12c-quick-manual-test-card.md`
- `validation/package-12c-manual-operator-test-guide.md`
- `validation/role-smoke-test-checklist.md`
- `validation/package-12c-controlled-output-checklist.md`
- `validation/package-12c-qa-agent-spec.md`
- `validation/package-12c-repository-editor-agent-spec.md`

Required validator ladder:

```powershell
pwsh -NoProfile -File ./tools/Test-AisrafPackage.ps1
pwsh -NoProfile -File ./tools/Test-AisrafBp12AReadiness.ps1
pwsh -NoProfile -File ./tools/Test-AisrafRunProfile.ps1 -RunProfilePath ./runs/RUN-001/run-profile.yaml -ExecutionReady
```

## 11. Scope And Overclaim Guardrails

This overview must not claim readiness for production use, release approval, marketplace distribution, live Jira, Confluence, Lucidchart, MCP, cloud, database, Terraform, Claude runtime adapter, Azure AI Foundry, Google ADK, Microsoft Agent Framework, event bus, telemetry backend, or external post-back integration. It must not imply that provider projections or plugin packaging are runtime proof.

This overview must not claim AL3 orchestrated multi-agent runtime, AL4 external tool/post-back execution, or AL5 higher autonomy. AL3 is future WP-ORCH; v0.1.2 proves only AL2 controlled-output local workbench behavior.

The public form must not include secrets, customer data, private endpoints, private links, personal paths, or sales-heavy framing.

## 12. Contributor-Safe Guidance

- No `git add .`.
- No `.claude/` staging.
- No smoke-folder staging.
- No edits to canonical assets without work-package approval.
- No catalog, blueprint, template, prompt, skill, or PRA edits without the approved governance lane.
- No `RUN-001` or sample mutation.
- No staged smoke evidence before L3.

## 13. Definition Of Done

This architecture overview draft is ready for later editor/QA review when:

- Validators return 0 FAIL.
- Catalog/blueprint governance is documented.
- Public docs are promoted later under the docs/release gate.
- L2B smoke passed before any controlled-output claim.
- `RUN-001` remains unchanged.
- `samples/` remains unchanged.
- Canonical/projection surfaces remain unchanged.
- Smoke folders are not staged.
- `.claude/` is not staged.
- QA report exists.
- ED1 report exists.
- Release manifest, license, and notice are ready before public release.
