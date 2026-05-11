# Build Package 12C - Security Review Workflow Draft

| Field | Value |
|---|---|
| Work package | WP-12C-PRIMER0 / WP-12C-ED1 - Public Repository Primer And Security Architect Journey Draft (ED1 readability pass applied) |
| Status | Pre-release public-reader draft; validation-owned; not promoted to docs or release |
| Audience | Security architect, solution architect, application/product team, engineering team, governance/reviewer, contributor/maintainer, public technical reader/evaluator |
| Boundary | Local-first DFD/design-package workflow; no external post-back |
| Current autonomy | AL2 controlled-output local workbench; AL3 orchestrated multi-agent runtime is future WP-ORCH |
| Release posture | Not public-release-ready; L3, REL0, and WP-13 remain blocked |

## 1. Security Architect Scenario

A security architect receives a DFD/design-review package and needs a fast, evidence-bound, shift-left review workflow. AISRAF helps the architect inspect the local design package, preserve unknowns, generate targeted questions, structure the review table, draft findings and recommendations, and assemble handoff evidence without inventing missing facts or claiming external execution.

The architect starts with `@aisraf-orchestrator` from the installed plugin. The orchestrator coordinates the review chain by walking the operator through the specialist roles sequentially. The seven specialist agents (`@aisraf-input-reader`, `@aisraf-dfd-extractor`, `@aisraf-review-table-builder`, `@aisraf-blueprint-questioner`, `@aisraf-finding-recommender`, `@aisraf-handoff-qa-scorer`) remain available as direct entrypoints for expert use. There is no external post-back: all outputs are local Markdown under the approved run folder.

## 2. Inputs Expected

- DFD or diagram image/export.
- Legend.
- Design notes.
- Transcript or questionnaire.
- Jira/design-ticket text later, deferred.
- Run profile.
- Sample fixture for baseline proof.

Current inputs are local files. Future Jira ticket intake, Lucidchart direct read, Confluence publication, MCP runtime, cloud runtime, database-backed runtime, Terraform deployment, and external post-back are deferred adapter paths only.

## 3. Workflow Stages

1. Intake design package.
2. Inventory inputs.
3. Extract visible DFD objects.
4. Normalize legend.
5. Extract components.
6. Extract flows.
7. Identify boundaries.
8. Assess security stack.
9. Build internal review table.
10. Identify missing facts.
11. Classify AI Action Level only from governed catalog.
12. Match blueprint from governed blueprint registry.
13. Generate targeted questions.
14. Classify findings.
15. Write recommendations.
16. Build handoff pack.
17. Write validation notes.
18. Calculate accuracy score where eligible.

## 4. Output Family

Approved output family for the local review chain:

- `00-run-log.md`
- `01-input-inventory.md`
- `02-visible-dfd-objects.md`
- `03-legend-normalization.md`
- `04-components.md`
- `05-flows.md`
- `06-boundaries.md`
- `07-security-stack-assessment.md`
- `08-internal-review-table.md`
- `09-missing-facts.md`
- `10-ai-action-level.md`
- `11-blueprint-match.md`
- `12-targeted-questions.md`
- `13-findings.md`
- `14-recommendations.md`
- `15-handoff-pack.md`
- `16-validation-notes.md`
- `17-accuracy-score.md`
- `dfd/01..09 extraction chain`

During controlled smoke, outputs must stay inside the approved run folder. `RUN-001` is governed fixture evidence and must not be mutated by PRIMER0 or L2B smoke.

## 5. Evidence Rules

- Preserve `Unknown`, `Not Stated`, and `Deferred`.
- Do not invent controls.
- Do not infer implementation proof from diagram labels alone.
- Every finding must trace to evidence.
- Every recommendation must trace to finding and blueprint/question context.
- Every output must stay inside the approved run folder during controlled smoke.
- Catalog values must come from governed catalogs.
- Blueprint matching must use the governed blueprint registry.
- Scoring is eligible only when the run profile and baseline conditions support it.

## 6. Deferred Integration Story

- Jira ticket intake is future.
- Confluence post-back is future.
- Lucidchart adapter is future.
- MCP runtime is future.
- Cloud runtime is future.
- Database-backed runtime is future.
- Terraform deployment is future.
- External post-back is future.
- Azure AI Foundry, Google ADK, Microsoft Agent Framework, and Claude runtime adapter paths are future strategy surfaces only.

These items are not implemented in the current local workbench package and must not be described as live integrations.

## 7. Testing Path

Use these validation-owned references to test or review this workflow:

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

## 7A. Application / Solution Architect Use

A second, before-formal-review use of this workflow. Application and solution architects can run AISRAF locally against their own draft DFD before security architecture engages.

- Inputs: the team's draft DFD, design notes, intake ticket text.
- Output focus: missing-facts list, review-table draft, AAL classification, and targeted questions — used by the team to harden the design package before security review.
- Required adapters: none. Jira, Confluence, and MCP are not needed for this use.
- Outcome: arrive at security review with unknowns named, boundaries drawn, and controlled-vocabulary terms already used.

## 8. Scope And Overclaim Guardrails

This draft may describe the local AISRAF review workflow and future adapter story. It must not claim readiness for production use, release approval, live external integrations, external post-back, cloud runtime, live MCP, database runtime, Terraform deployment, or autonomous agents for production use.

This draft must not claim AL3 orchestrated multi-agent runtime, AL4 external tool/post-back execution, or AL5 higher autonomy. Current behavior is AL2 controlled-output local workbench only; AL3 belongs to future WP-ORCH.

The public form must contain no secrets, customer data, private endpoints, private links, personal paths, or sales-heavy framing.

## 9. Contributor-Safe Guidance

- No `git add .`.
- No `.claude/` staging.
- No smoke-folder staging.
- No edits to canonical assets without work-package approval.
- No catalog, blueprint, template, prompt, skill, or PRA edits without the approved governance lane.
- No `RUN-001` or sample mutation.
- No staged smoke evidence before L3.

## 10. Definition Of Done

This workflow draft is ready for later editor/QA review when:

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
