# AISRAF Security Review Workflow

| Field | Value |
|---|---|
| Document | docs/SECURITY-REVIEW-WORKFLOW.md |
| Source draft | validation/package-12c-security-review-workflow-draft.md |
| Promoted by | WP-12C-REL0-B — Public Release Docs |
| Release | AISRAF v0.1.2 |
| Current claim | AM3 / AL3 local orchestrated multi-agent runtime evidence is proven |
| External execution | not claimed; outputs are local Markdown only |

## 1. Two Entry Points

AISRAF v0.1.2 supports two entry points into the same governed review chain:

- **Pre-design-review (shift-left).** An application or solution architect runs AISRAF locally against their own draft DFD/design package before security architecture engages. Goal: arrive at security review with unknowns named, boundaries drawn, and controlled-vocabulary terms already used.
- **Post-design-review (security architect).** A security architect receives a DFD/design-review package and uses AISRAF to inspect it locally, preserve unknowns, generate targeted questions, structure the review table, draft findings and recommendations, and assemble handoff evidence.

Both entry points use the same chain, the same inputs shape, and the same output set. The differences are who runs it and what they do with the outputs.

AM3 evidence is local-only, human-gated, validator-backed, and evidence-bound. AISRAF Orchestrator owns run-state and event log, and specialist handoffs are represented by AM3-01 through AM3-06 request/response pairs. That evidence path does not prove full specialist-generated review output execution, production readiness, publication, or AM4 integration.

Release journey modes in this workflow:

| Mode | Workflow meaning |
|---|---|
| Mode 0 - read/preview, no writes | Inspect the input package, selected role, expected output contract, and evidence requirements before any file is changed. |
| Mode 1 - AL2 controlled-output workbench | Normal practitioner journey for security architects and application architects. The chain writes local Markdown only under an approved run folder. |
| Mode 2 - AM3 / AL3 local orchestrated runtime evidence | Release-visible local runtime journey/proof path. AM3 records orchestrator-owned run-state, event log, specialist handoffs, and human gates as local evidence. |
| Mode 3 - maintainer validation and release QA | Maintainer journey for proving package shape, validator results, release metadata, and blocker closure. |
| Mode 4 - AM4 external adapter / post-back execution | Future only. Jira, Confluence, Lucidchart, MCP, cloud, database, Terraform, event bus, telemetry, and post-back are deferred adapters. |

AL5 closed-loop autonomy is not part of the workflow.

## 2. Inputs Expected

The chain reads local files only:

- DFD or diagram image / source (`*.png`, `*.mmd`, etc.).
- Legend (`*-legend-excerpt.md`).
- Design notes / triage notes (`*.md`).
- Review transcript or questionnaire (`*.md`).
- Intake ticket text (`*.md`).
- Run profile (`runs/<run_id>/run-profile.yaml`).
- Sample fixture (`samples/sample-001-dfd-crop/`) for baseline proof.

Reference shape: `samples/sample-001-dfd-crop/inputs/` holds 6 files used by the canonical fixture and by the L2B controlled-output smoke run.

Future Jira ticket intake, Lucidchart direct read, Confluence publication, MCP runtime, cloud runtime, database-backed runtime, Terraform deployment, and external post-back are deferred adapter paths only. They are not active in v0.1.2.

## 3. Workflow Stages

The review chain runs sequentially under `@aisraf-orchestrator`, with specialist agents available as direct entrypoints for expert use:

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
11. Classify AI Action Level only from the governed catalog.
12. Match blueprint from the governed blueprint registry.
13. Generate targeted questions.
14. Classify findings.
15. Write recommendations.
16. Build handoff pack.
17. Write validation notes.
18. Calculate accuracy score where eligible.

## 4. Outputs

Approved output set under `runs/<run_id>/`:

| File | Stage |
|---|---|
| `00-run-log.md` | Run-log evidence ledger |
| `01-input-inventory.md` | Inventory of staged local inputs |
| `02-visible-dfd-objects.md` | Visible DFD facts |
| `03-legend-normalization.md` | Legend normalization |
| `04-components.md` | Components |
| `05-flows.md` | Flows |
| `06-boundaries.md` | Boundaries |
| `07-security-stack-assessment.md` | Security-stack assessment |
| `08-internal-review-table.md` | Internal review table |
| `09-missing-facts.md` | Missing facts and unknowns |
| `10-ai-action-level.md` | AI Action Level (governed catalog) |
| `11-blueprint-match.md` | Blueprint match (governed registry) |
| `12-targeted-questions.md` | Targeted questions |
| `13-findings.md` | Findings |
| `14-recommendations.md` | Recommendations |
| `15-handoff-pack.md` | Handoff pack (local Markdown) |
| `16-validation-notes.md` | Validation notes |
| `17-accuracy-score.md` | Accuracy score (only when scoring is eligible) |

The 9 DFD subchain outputs live under `runs/<run_id>/dfd/`:

| File | Stage |
|---|---|
| `dfd/01-intake-quality-check.md` | Intake quality check |
| `dfd/02-boundary-catalog.md` | Boundary catalog |
| `dfd/03-component-catalog.md` | Component catalog |
| `dfd/04-flow-inventory.md` | Flow inventory |
| `dfd/05-annotation-resolution.md` | Annotation resolution |
| `dfd/06-boundary-crossings.md` | Boundary crossings |
| `dfd/07-control-signals.md` | Control signals |
| `dfd/08-confidence-score.md` | Confidence score |
| `dfd/09-extraction-summary.md` | Extraction summary |

Optional Jira/Confluence draft files (`jira-ticket-draft.md`, `confluence-page-draft.md`) may be produced as local Markdown drafts only. They are not posted to any external system in v0.1.2.

`runs/RUN-001/` is the governed canonical fixture. It must not be mutated by a review run. Stage your work in a different `runs/<run_id>/` folder.

## 5. Evidence Rules

The chain enforces these rules at every stage:

- Preserve `Unknown`, `Not Stated`, and `Deferred` explicitly. Never treat absence of evidence as evidence of absence.
- Do not invent controls, owners, implementation proof, or post-back actions.
- Do not infer implementation proof from diagram labels alone. A label says what the architect drew, not what the system enforces.
- Every finding must trace to evidence already extracted earlier in the chain.
- Every recommendation must trace to a finding and to blueprint/question context.
- Every output must stay inside the approved run folder during a controlled-output run.
- Catalog values must come from governed catalogs in `catalogs/` (24 controlled-vocabulary YAML catalogs across 7 families).
- Blueprint matching must use the governed blueprint registry in `blueprints/` (9 controlled blueprints across 2 categories).
- Scoring is eligible only when the run profile and baseline conditions support it.

## 6. Citation And No-Fake-Proof Posture

Every claim in the outputs must cite the input it came from (file name, section, line range, or visible-DFD object identifier). Where evidence is missing, the output records `Unknown` or `Not Stated` and adds the question to `09-missing-facts.md` and `12-targeted-questions.md` rather than guessing a value.

The chain does not synthesize "likely" controls, "probably" implemented protections, or "expected" identity flows. If a control is not visible in the input package, the chain says so.

## 7. Deferred Integration Story

The following are **future adapter work** and are not active in v0.1.2:

- Jira ticket intake.
- Confluence post-back.
- Lucidchart direct adapter.
- MCP runtime.
- Anthropic Claude runtime adapter.
- Azure AI Foundry runtime adapter.
- Google ADK adapter.
- Microsoft Agent Framework adapter.
- Database-backed runtime.
- Terraform / cloud deployment.
- Cloud runtime.
- Event bus.
- Telemetry backend.
- External post-back execution.

These items may be discussed in design notes only as future / deferred / not implemented. They are not live in the current package.

## 8. Validator Ladder

```powershell
pwsh -NoProfile -File ./tools/Test-AisrafPackage.ps1
pwsh -NoProfile -File ./tools/Test-AisrafBp12AReadiness.ps1
pwsh -NoProfile -File ./tools/Test-AisrafRunProfile.ps1 -RunProfilePath ./runs/RUN-001/run-profile.yaml -ExecutionReady
```

All three must return 0 FAIL before any review is reported as complete.
