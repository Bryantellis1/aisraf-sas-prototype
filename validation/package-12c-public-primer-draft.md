# AISRAF — Governed AI-Assisted Security Architecture Review Framework

| Field | Value |
|---|---|
| Work package | WP-12C-PRIMER0 / WP-12C-ED1 - Public Repository Primer And Security Architect Journey Draft (ED1 readability pass applied) |
| Status | Pre-release public-reader draft; validation-owned; not promoted to docs or release |
| Audience | Security architect, solution architect, application/product team, engineering team, governance/reviewer, contributor/maintainer, public technical reader/evaluator |
| Boundary | Local-first, evidence-bound, governed, validation-backed, deferred adapters |
| Current maturity | Strong pre-release prototype / local workbench package, currently proving AL2 controlled-output behavior under L2B evidence; AL3 orchestrated multi-agent runtime is future WP-ORCH |
| Release posture | Not public-release-ready. L3 staging, REL0 release-manifest work, and WP-13 diagrams remain blocked. |

## 1. One-Paragraph Description

AISRAF is a local, governed AI-assisted security architecture review workbench for shift-left design review. It helps security architects turn DFD/design packages into structured review evidence, targeted questions, findings, recommendations, handoff material, validation notes, and scoring signals while preserving unknowns and avoiding unsupported integration claims.

## 2. What AISRAF Is

- A local agentic security architecture review workbench.
- An evidence-bound design review helper.
- A DFD/design-package analysis workflow.
- A governed package of agents, skills, prompts, catalogs, blueprints, templates, validators, hooks, and evidence.
- A plugin/projection-ready package, not yet a public release.

## 3. What AISRAF Is Not

- Not a production cloud service.
- Not an active Jira, Confluence, or Lucidchart integration.
- Not a live MCP runtime.
- Not a database-backed runtime.
- Not Terraform or cloud deployment.
- Not public-release ready yet.
- Not a replacement for security architect judgment.
- Not a tool that invents missing facts.

## 4. Who AISRAF Is For

- Security architects who need a faster, structured, evidence-bound review path.
- Solution architects who need design facts, boundaries, and unknowns made explicit.
- Application/product teams preparing for security design review.
- Engineering teams that need traceable security-review questions and recommendations.
- Governance/reviewers checking whether claims, findings, and handoff evidence are supported.
- Maintainers/contributors extending the governed package under work-package controls.
- Public technical evaluators who want to understand the local workbench before any public release.

## 5. Problem It Solves

Security design reviews often start late, after design decisions are already expensive to change. DFDs and design packages often lack consistent annotations for data class, flows, trust boundaries, identity signals, authorization, protection state, and evidence confidence. Missing facts become hard to track, findings and recommendations can drift away from their evidence, handoff artifacts are inconsistent, and AI-generated text needs strong guardrails so it does not create fake proof.

AISRAF addresses that problem by treating the review as a governed local chain: inventory inputs, preserve unknowns, extract visible facts, normalize DFD evidence, build review tables, generate targeted questions, classify findings, write recommendations, build handoff material, record validation notes, and calculate scoring signals only when scoring is eligible.

## 6. Core Value

- Shift-left security architecture review from DFD/design packages.
- Consistent review chain across the same input, output, and evidence model.
- Structured questions before design review, especially where facts are missing.
- Traceable findings and recommendations tied back to review evidence.
- Clear unknown preservation instead of optimistic assumptions.
- Reproducible validation evidence from local validators and run profiles.
- Local-only controlled execution before any external adapter is promoted.

## 7. Architecture Spine

The AISRAF architecture follows this full spine:

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

This matters because every public-reader claim must map to a governed layer. Design-time specifications are not runtime proof. Provider projections are not source of truth. A plugin is not a release. Release requires evidence.

## 8. Current Maturity

AISRAF is a strong pre-release prototype / local workbench package. It is local-first, evidence-bound, governed, and validation-backed. The current package proves that the canonical source package, provider projections, plugin package, validator ladder, and operator-preview path can be organized under a strict governance model.

Current proof is local and package-based:

- Canonical source surfaces exist for prompts, skills, prototype agents, catalogs, blueprints, templates, config, tools, validation, samples, and RUN-001.
- Provider projection surfaces exist for local/Copilot agents, provider Agent Skills, hooks, and operator cards.
- The plugin package exists as an installable/projection surface with bundle checksum evidence.
- L2B controlled-output execution under `runs/RUN-SMOKE-PLUGIN-L2B-001/` proves AL2 controlled-output behavior on the installed plugin path.
- WP-12C-QA1 release-readiness audit returned `WP-12C-QA1_PARTIAL_WITH_GAPS` with 0 FAIL across all four validators and 5 documentation-class warnings owned by ED1 / L3.
- The known smoke-folder warnings remain local staging hygiene, not package failures.

### 8.1 Autonomy posture (AL2 today, AL3 future)

| Level | Description | Current state |
|---|---|---|
| AL2 | Controlled-output local workbench: operator selects an AISRAF role, role writes governed outputs only inside an approved scratch run folder, hooks enforce path guards and run validators. | **Current.** Proven by L2B controlled-output execution. |
| AL3 | Orchestrated multi-agent runtime: the Orchestrator role formally delegates to specialist agents, each with its own state and hand-off contract, under runtime policy enforcement and runtime evidence emission. | **Future WP-ORCH.** Deferred. Not implemented in v0.1.2. |
| AL4 / AL5 | External tool/post-back execution and higher autonomy. | **Not claimed.** Out of scope. |

Current execution model in plain words: one selected AISRAF agent session (typically AISRAF Orchestrator) acts as a temporary orchestrator that walks the operator through the review chain sequentially. Specialist agents remain available as direct entrypoints for expert use. The plugin packages the orchestrator, specialists, skills, hooks, and validators together so the operator can install one thing.

### 8.2 AI component pattern

| Pattern | Meaning | Current state |
|---|---|---|
| AI **for** / **outside** component | AI assists the human reviewer from outside the system under review; outputs are operator-driven controlled-output writes. | **Current.** |
| AI **beside** / **on** component | AI sits alongside the component under review (e.g., orchestrator-coordinated specialist roles still chat-preview-only with controlled-write-on-approval). | **Emerging target.** |
| AI **inside** component | AI is embedded in the runtime of the component under review with its own runtime state, tools, memory, and policy enforcement. | **Not current.** Deferred to ORCH. |

## 9. Release Boundary

AISRAF is **not public-release-ready**. Public release requires additional gates before reader-facing docs, release metadata, diagrams, staging, or publication are promoted.

Gate status as recorded by `validation/package-12c-release-qa-report.md`:

| Gate | Status | What it requires |
|---|---|---|
| L2B controlled-output smoke plan | **COMPLETE** | Plan accepted; founder approval recorded. |
| L2B controlled-output execution | **COMPLETE** | Executed under `runs/RUN-SMOKE-PLUGIN-L2B-001/` with 0 FAIL and no overclaim. |
| WP-12C-QA1 release-readiness QA | **COMPLETE (PARTIAL_WITH_GAPS)** | 5 warnings recorded in `validation/package-12c-release-blocker-register.md`. |
| WP-12C-ED1 readability / public-safety | **CURRENT** | This pass. |
| WP-12C-L3 staging and publication decision | **BLOCKED** | Requires RB-001..RB-005 register closure. |
| WP-12C-REL0 release-manifest, license, notice | **BLOCKED** | Requires L3 publication readiness. |
| WP-13 diagrams and release visuals | **BLOCKED** | Requires post-L3 release-gate authorization. |
| WP-ORCH true orchestrated multi-agent runtime | **BLOCKED / FUTURE** | Out of v0.1.2 scope. |

Until those gates pass, the PRIMER0 / ED1 draft set remains validation-owned, not `docs/` content and not release material.

## 9A. Security Architect Journey

This is the primary AISRAF journey. A security architect receives a DFD/design package and uses AISRAF as a local review assistant.

1. **Receive design package.** A DFD/design-review package arrives (DFD image or Mermaid source, legend, design notes, intake ticket text, triage notes, transcript).
2. **Stage inputs locally.** Place the inputs under the approved local input root (sample fixture lives at `samples/sample-001-dfd-crop/inputs/`; the L2B scratch run at `runs/RUN-SMOKE-PLUGIN-L2B-001/inputs/`).
3. **Run local preview.** Open the installed plugin from the clean smoke workspace, start with `@aisraf-orchestrator`, and use preview-only role prompts to confirm what each role reads and writes before any file is created.
4. **Generate the review chain.** Under an approved controlled-output gate, the chain produces input inventory (`01`), visible DFD facts (`02`), legend normalization (`03`), components and flows (`04`–`05`), boundaries and security-stack assessment (`06`–`07`), an internal review table (`08`), missing facts (`09`), AI Action Level classification from the governed catalog (`10`), blueprint match (`11`), targeted questions (`12`), findings (`13`), recommendations (`14`), handoff pack (`15`), validation notes (`16`), and accuracy score where eligible (`17`).
5. **Review unknowns and evidence.** Each output preserves unknowns explicitly; findings trace to evidence; recommendations trace to findings and blueprint/question context. No fact is invented.
6. **No external post-back.** AISRAF does not post to Jira, Confluence, Lucidchart, MCP, cloud runtime, database, Terraform, or any external system. Handoff material stays local.

What this means in plain terms: the security architect gets a structured, evidence-bound review that is faster than starting from blank, but the human reviewer keeps every decision. AISRAF surfaces what is missing or unsupported and writes it down where it can be re-checked.

## 9B. Application / Solution Architect Journey

A second journey, before formal security design review. Application and solution architects use AISRAF locally to harden their own design package before security architecture engages.

1. **Self-check the DFD.** Run AISRAF locally against the team's draft DFD. Check that data classifications, source/destination, trust boundary crossings, authentication and authorization signals, encryption in transit and at rest, and confidence level are visible — or flagged as unknown.
2. **Identify missing facts.** AISRAF's missing-facts output names the design questions that security review will ask. The team can answer them before the meeting, not during it.
3. **Prepare a better review package.** Use the local outputs (review table, missing facts, targeted questions) to update the design package and the intake ticket text before submitting to security review.
4. **Decline external integrations.** Jira, Confluence, MCP, cloud runtime, and similar adapters are not required to use AISRAF this way. Everything stays local files.

What this means in plain terms: AISRAF acts as a shift-left lint pass over the design package. The application/solution architect arrives at security design review with the unknowns already named, the boundaries already drawn, and the controlled-vocabulary terms already used.

## 9C. Maintainer / Contributor Journey

A third journey, for maintainers who extend the governed package or prepare it for release.

1. **Run validators.** The validator ladder is `pwsh -NoProfile -File ./tools/Test-AisrafPackage.ps1`, `pwsh -NoProfile -File ./tools/Test-AisrafBp12AReadiness.ps1`, and `pwsh -NoProfile -File ./tools/Test-AisrafRunProfile.ps1 -RunProfilePath ./runs/RUN-001/run-profile.yaml -ExecutionReady`. All must return 0 FAIL.
2. **Verify plugin discovery.** Open the clean smoke workspace `D:/E-Way 2/AISRAF-PLUGIN-SMOKE-WORKSPACE`. Confirm the AISRAF plugin loads from the provider surface and that the 7 AISRAF agents are discoverable. Do not run installed-plugin smoke from the governed repo workspace.
3. **Check skill/agent/hook packaging.** The plugin bundle under `plugins/aisraf-copilot-plugin/bundle/` mirrors `.copilot-skills/`, `.agents/`, `.github/agents/`, `.github/skills/`, `.github/hooks/`. The bundle is byte-identical to canonical sources, validated by `bundle-checksum-manifest.yaml`.
4. **Manage smoke folders and staging exclusions.** `runs/RUN-SMOKE-LOCAL-*/` and `runs/RUN-SMOKE-PLUGIN-*/` are local smoke evidence. They are WARN-class on the package validator and must be removed (or relocated under a founder-approved smoke-evidence retention policy) before any L3 staging decision. Never `git add .`. Never stage `.claude/`.
5. **Prepare release gates.** The L3 gate is the first that may decide staging or publication. REL0 prepares release-manifest, license, notice, and changelog. WP-13 diagrams come after release-gate approval. None of those are open today.

What this means in plain terms: maintainers keep the validator ladder green, keep canonical surfaces unchanged unless a governed work package authorizes the edit, and keep smoke and local-only folders out of the staging set.

## 9D. Plugin User Experience

The AISRAF plugin packages the orchestrator, the seven specialist agents, the seven skill wrappers and operator cards, the four conservative hook scripts, and the validator references. How operators experience it:

| Surface | What the operator sees | Expected behaviour |
|---|---|---|
| Plugin agents | 7 AISRAF agents: `@aisraf-orchestrator`, `@aisraf-input-reader`, `@aisraf-dfd-extractor`, `@aisraf-review-table-builder`, `@aisraf-blueprint-questioner`, `@aisraf-finding-recommender`, `@aisraf-handoff-qa-scorer`. | Users start with `@aisraf-orchestrator`. The specialist agents remain available for expert use and direct delegation. |
| Plugin skills | 7 Agent Skills packages under `.github/skills/<name>/SKILL.md`, mirrored in the bundle. | Skills are packaged capabilities loaded by the agents unless the provider chooses to expose them standalone. If the Copilot Skills UI shows only built-ins, that is a provider-UI presentation choice, not a packaging gap — the AISRAF skills are still installed and reachable through the agents. |
| Plugin hooks | One provider hook config (`aisraf-guardrails.json`) declaring `PreToolUse`, `PostToolUse`, and `Stop` events that call the four `tools/hooks/*.ps1` scripts. | Hooks block writes outside approved scratch paths, run a focused validator after writes, and emit a session summary at end. |
| Clean smoke workspace | `D:/E-Way 2/AISRAF-PLUGIN-SMOKE-WORKSPACE` is intentionally empty until a user supplies a local input package or run folder. | An empty clean smoke workspace is expected and useful: it proves the installed plugin is loading from the plugin source or provider cache, not from workspace-local customization folders. |

The plugin is an installable projection of the canonical package; it is **not** a release. Release is a separate governed publication decision that runs through L3 → REL0.

## 10. Testing Path

Public-reader claims in this draft set should be checked against these validation-owned artifacts:

- `validation/package-12c-quick-manual-test-card.md`
- `validation/package-12c-manual-operator-test-guide.md`
- `validation/role-smoke-test-checklist.md`
- `validation/package-12c-controlled-output-checklist.md`
- `validation/package-12c-qa-agent-spec.md`
- `validation/package-12c-repository-editor-agent-spec.md`

The validator ladder remains:

```powershell
pwsh -NoProfile -File ./tools/Test-AisrafPackage.ps1
pwsh -NoProfile -File ./tools/Test-AisrafBp12AReadiness.ps1
pwsh -NoProfile -File ./tools/Test-AisrafRunProfile.ps1 -RunProfilePath ./runs/RUN-001/run-profile.yaml -ExecutionReady
```

## 11. Scope And Overclaim Guardrails

This draft must not claim readiness for production use, marketplace distribution, release approval, live external integrations, external post-back, cloud runtime, database runtime, Terraform deployment, live MCP runtime, Jira integration, Confluence integration, Lucidchart integration, Anthropic Claude runtime adapter, Azure AI Foundry, Google ADK, Microsoft Agent Framework, event bus, telemetry backend, or autonomous agents for production use. Deferred adapters may be named only as deferred, future, or not implemented.

This draft must not claim AL3 orchestrated multi-agent runtime, AL4 external tool/post-back execution, or AL5 higher autonomy. The current AL2 controlled-output behavior is the only autonomy level proven by v0.1.2.

This draft must not include secrets, customer data, private endpoints, personal paths, private links, or sales-heavy language. Public promotion must replace validation-only language with release-approved docs only after the docs/release gate opens.

## 12. Contributor-Safe Guidance

- Do not run `git add .`.
- Do not stage `.claude/`.
- Do not stage smoke folders.
- Do not edit canonical assets without work-package approval.
- Do not edit catalog, blueprint, template, prompt, skill, or PRA assets without the approved governance lane.
- Do not mutate `runs/RUN-001/` or `samples/`.
- Do not stage smoke evidence before L3.

## 13. Definition Of Done

PRIMER0 is done only when:

- Validators return 0 FAIL.
- Catalog/blueprint governance is documented as controlled vocabulary and review-pattern governance.
- Public docs are promoted later, not in PRIMER0.
- L2B smoke has passed before any controlled-output release claim.
- `runs/RUN-001/` remains unchanged.
- `samples/` remains unchanged.
- Canonical/projection surfaces remain unchanged.
- Smoke folders are not staged.
- `.claude/` is not staged.
- QA report exists before release-readiness claims.
- ED1 report exists before public readability claims.
- Release manifest, license, and notice are ready before public release.
