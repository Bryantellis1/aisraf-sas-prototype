# AISRAF Primer

| Field | Value |
|---|---|
| Document | docs/AISRAF-PRIMER.md |
| Source draft | validation/package-12c-public-primer-draft.md |
| Promoted by | WP-12C-REL0-B — Public Release Docs |
| Release | AISRAF v0.1.2 |
| Release status | pre-release; staging and publication still gated |
| Current autonomy | AL2 (controlled-output local workbench) |
| Future autonomy | AL3 orchestrated multi-agent runtime is future WP-ORCH; AL4 external tool/post-back execution is future adapter work; AL5 closed-loop autonomy is out of scope |

## 1. What AISRAF Is

AISRAF (AI-assisted Security Architecture Review Framework) is a local, governed AI-assisted security architecture review workbench for shift-left design review. It helps a security architect turn a DFD/design package into structured review evidence, targeted questions, findings, recommendations, handoff material, validation notes, and scoring signals while preserving unknowns and avoiding unsupported integration claims.

AISRAF is:

- A local agentic security architecture review workbench.
- An evidence-bound design review helper.
- A DFD/design-package analysis workflow.
- A governed package of agents, skills, prompts, catalogs, blueprints, templates, validators, hooks, and evidence.
- A plugin/projection-ready package, currently shipping AL2 controlled-output behavior.

## 2. What AISRAF Is Not

AISRAF is not:

- A production cloud service.
- A live Jira, Confluence, Lucidchart, or MCP integration.
- A database-backed runtime.
- A Terraform or cloud-deployment runtime.
- A replacement for security architect judgment.
- A tool that invents missing facts.
- A general-purpose marketplace plugin in v0.1.2.

## 3. Local-First, Evidence-Bound, Controlled-Output Posture

The v0.1.2 release ships AISRAF as a local-first workbench with three reinforcing constraints:

- **Local-first.** All inputs and outputs are local Markdown files under an approved run folder. No external system is contacted. No credentials are required.
- **Evidence-bound.** Every output preserves unknowns, deferred states, and missing facts explicitly. Findings trace to evidence. Recommendations trace to findings and to blueprint/question context. No fact is invented.
- **Controlled-output.** The 7 AISRAF agents may write only to approved scratch run folders. Hooks enforce path guards before each write and run focused validators after each write. Canonical surfaces (`prompts/`, `skills/`, `prototype-agents/`, `catalogs/`, `blueprints/`, `templates/`, `config/`, `samples/`, `runs/RUN-001/`) and provider projections are never mutated by a review run.

## 4. Autonomy Levels

| Level | Description | v0.1.2 state |
|---|---|---|
| AL2 | Controlled-output local workbench: operator selects an AISRAF role, role writes governed outputs only inside an approved scratch run folder, hooks enforce path guards and run validators. | **Current.** Proven by L2B controlled-output execution under `runs/RUN-SMOKE-PLUGIN-L2B-001/`. |
| AL3 | Orchestrated multi-agent runtime: the Orchestrator role formally delegates to specialist agents under runtime policy enforcement and runtime evidence emission. | **Future WP-ORCH.** Not implemented. |
| AL4 | External tool/post-back execution (Jira, Confluence, Lucidchart, MCP, cloud, database, Terraform). | **Future adapter work.** Not implemented. |
| AL5 | Closed-loop autonomy. | **Out of scope.** |

Plain words: today, one selected AISRAF agent session (typically `@aisraf-orchestrator`) acts as a temporary orchestrator that walks the operator through the review chain sequentially. Specialist agents remain available as direct entrypoints for expert use. The plugin packages the orchestrator, specialists, skills, hooks, and validator references together so the operator can install one thing.

## 5. AI Component Pattern

| Pattern | Meaning | v0.1.2 state |
|---|---|---|
| AI **for** / **outside** component | AI assists the human reviewer from outside the system under review; outputs are operator-driven controlled-output writes. | **Current.** |
| AI **beside** / **on** component | AI sits alongside the component under review (orchestrator-coordinated specialist roles, still chat-preview-only with controlled-write-on-approval). | **Near-term target.** |
| AI **inside** component | AI embedded in component runtime with its own state, tools, memory, and policy enforcement. | **Not current.** Deferred to ORCH. |

## 6. Who AISRAF Is For

- Security architects who need a faster, structured, evidence-bound review path.
- Solution and application architects who want a shift-left lint pass over their design package before formal security review.
- Engineering teams that need traceable security-review questions and recommendations.
- Governance reviewers checking whether claims, findings, and handoff evidence are supported.
- Maintainers and contributors extending the governed package under work-package controls.
- Public technical evaluators who want to understand the local workbench before any public release.

## 7. Architecture Spine

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

This matters because every public-reader claim must map to a governed layer. Design-time specifications are not runtime proof. Provider projections are not source of truth. A plugin is not a release.

## 8. Release Boundary

AISRAF v0.1.2 is a public-safe, local-first, evidence-bound, AL2 controlled-output local workbench. Public release artifacts (this document, `RELEASE-MANIFEST.yaml`, `CHANGELOG.md`, `SECURITY.md`, `CONTRIBUTING.md`, `LICENSE`, `NOTICE.md`, and the four companion docs) describe the AL2 surface only.

What is **not** part of v0.1.2:

- AL3 orchestrated multi-agent runtime (future WP-ORCH).
- AL4 external adapter / post-back execution (Jira, Confluence, Lucidchart, MCP, Foundry, ADK, MAF, database, Terraform, cloud runtime, event bus, telemetry backend).
- AL5 closed-loop autonomy.
- Release visuals (future WP-13).

## 9. How To Read The Companion Docs

- [docs/OPERATOR-QUICKSTART.md](OPERATOR-QUICKSTART.md) — install/discovery expectation, clean smoke workspace vs governed prototype repo, run-profile variables, security architect and app architect usage paths.
- [docs/SECURITY-REVIEW-WORKFLOW.md](SECURITY-REVIEW-WORKFLOW.md) — pre-design and post-design workflows, inputs, the 17 RS + 9 DFD outputs, evidence rules, no-fake-proof posture.
- [docs/ARCHITECTURE-OVERVIEW.md](ARCHITECTURE-OVERVIEW.md) — canonical source surfaces, provider projections, plugin bundle, and the current role-sequenced workbench vs future orchestrated runtime.
- [docs/ROADMAP.md](ROADMAP.md) — v0.1.2 AL2 release, WP-13 release visuals, WP-ORCH0..ORCH5 future AL3 path, AL4 adapter futures, AL5 out of scope.
