# Build Package 12C - Roadmap Draft

| Field | Value |
|---|---|
| Work package | WP-12C-PRIMER0 / WP-12C-ED1 - Public Repository Primer And Security Architect Journey Draft (ED1 readability pass applied) |
| Status | Pre-release public-reader draft; validation-owned; not promoted to docs or release |
| Audience | Security architect, solution architect, application/product team, engineering team, governance/reviewer, contributor/maintainer, public technical reader/evaluator |
| Boundary | Roadmap only; no execution, staging, publication, docs promotion, release artifact, or diagram creation |
| Current autonomy | AL2 controlled-output local workbench; AL3 orchestrated multi-agent runtime is future WP-ORCH |
| Release posture | Not public-release-ready; L3, REL0, and WP-13 remain blocked |

## 1. Current

AISRAF is a strong pre-release prototype / local workbench package operating at autonomy level AL2. It is local-first, evidence-bound, governed, validation-backed, and plugin/projection-ready. It is not a public release and does not claim AL3+ behavior, live external integrations, cloud runtime, database runtime, Terraform deployment, MCP runtime, marketplace publication, or external post-back execution.

The plugin packages the AISRAF Orchestrator, the six specialist agents, the seven skill wrappers and operator cards, the seven provider Agent Skills packages, and the provider hook config as one installable projection.

## 2. Done: L2B-PLAN

L2B-PLAN defined the controlled-output smoke plan before execution. It named the scratch run, output set, prewrite guard sequence, focused validator sequence, expected validator ladder, stop conditions, and exact approval needed before any write. L2B-PLAN was accepted under founder approval.

## 3. Done: L2B-EXEC

L2B-EXEC executed under `runs/RUN-SMOKE-PLUGIN-L2B-001/` after founder approval. It wrote only approved local outputs (17 RS root outputs plus 9 DFD outputs). `RUN-001`, `samples/`, canonical surfaces, provider projections, and plugin bundle content remained unchanged.

The successful L2B-EXEC proved AL2 controlled-output local behavior on the installed plugin path. It did not prove readiness for production use or live integration.

## 4. Done: QA1

QA1 (`AG-AISRAF-PACKAGE-QA-VALIDATOR-R1`) produced `validation/package-12c-release-qa-report.md` and `validation/package-12c-release-blocker-register.md`. Final status: `WP-12C-QA1_PARTIAL_WITH_GAPS`. Validators: 0 FAIL across all four. Five documentation-class warnings recorded (RB-001 / RB-002 smoke folders, RB-003 manifest/charter/build-order lag, RB-004 install-checklist frontmatter lag, RB-005 validator allow-list micro-patch).

## 5. Current: ED1

ED1 (`AG-AISRAF-REPOSITORY-EDITOR-R1`) performs the readability and public-safety pass over this authorized PRIMER0 / ED1 draft set. ED1 also corrects the stale plugin/L2B authority wording named in RB-003 across `PACKAGE-MANIFEST.yaml`, `PROTOTYPE-CHARTER.md`, and `BUILD-ORDER.md`, and refreshes the install/publication checklist frontmatter named in RB-004.

ED1 does not alter canonical review behavior. ED1 does not promote docs into `docs/`, does not create release artifacts, does not stage files, and does not run L3 / REL0 / WP-13 / WP-ORCH implementation.

## 6. Next: L3

L3 is the first gate that may decide staging or publication posture. It must close RB-001..RB-005, resolve smoke-folder staging hygiene, keep `.claude/` out of staging, use explicit path lists, and avoid `git add .`.

L3 remains BLOCKED until the QA1 blocker register closes.

## 7. Then: REL0

REL0 prepares release-manifest, license, notice, changelog, and security/contribution posture as authorized by the release gate. REL0 must keep public release claims tied to evidence and must not promote deferred adapters as implemented.

REL0 remains BLOCKED until L3 publication readiness is granted.

## 8. Then: WP-13 Diagrams/Release Visuals

WP-13 diagrams and release visuals remain later-gated. No diagrams are created in ED1. Diagrams may begin only after L3 publication readiness and the docs/release boundary open.

WP-13 remains BLOCKED until post-L3.

## 9. Future: WP-ORCH (AL3 Orchestrated Multi-Agent Runtime)

WP-ORCH is the future work package that would move AISRAF from AL2 controlled-output local workbench to AL3 orchestrated multi-agent runtime. It would introduce:

- True runtime delegation from the Orchestrator to specialist agents.
- Agent-side state and memory contracts.
- Agent-owned tools beyond the four conservative hook scripts.
- Runtime policy enforcement and runtime evidence emission.
- Runtime validation paths.

WP-ORCH is **not in v0.1.2 scope**. No AL3 / AL4 / AL5 behavior is claimed by the current package.

## 10. Future Adapters

Future governed adapter or strategy lanes (deferred, not implemented in v0.1.2):

- Jira ticket intake.
- Confluence post-back.
- Lucidchart direct adapter.
- MCP runtime.
- Cloud runtime.
- Anthropic Claude runtime adapter.
- Azure AI Foundry.
- Google ADK.
- Microsoft Agent Framework.
- Database-backed runtime.
- Terraform / cloud deployment.
- Event bus.
- Telemetry backend.
- External post-back execution.

Every item above is future/deferred/not implemented in the current package.

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

This roadmap must not claim readiness for production use, release approval, marketplace distribution, live external integrations, external post-back, cloud runtime, live MCP, database runtime, Terraform deployment, or autonomous agents for production use. Future items are future-only.

This roadmap must not claim AL3 orchestrated multi-agent runtime, AL4 external tool/post-back execution, or AL5 higher autonomy as current. AL3 belongs to future WP-ORCH; v0.1.2 ships AL2 controlled-output local workbench only.

The public form must contain no secrets, customer data, private endpoints, private links, personal paths, or sales-heavy framing.

## 12. Contributor-Safe Guidance

- No `git add .`.
- No `.claude/` staging.
- No smoke-folder staging.
- No edits to canonical assets without work-package approval.
- No catalog, blueprint, template, prompt, skill, or PRA edits without the approved governance lane.
- No `RUN-001` or sample mutation.
- No staged smoke evidence before L3.

## 13. Definition Of Done

This roadmap draft is ready for later editor/QA review when:

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
