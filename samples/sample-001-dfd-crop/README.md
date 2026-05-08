# sample-001-dfd-crop

Owning Build Package: Build Package 10 — Samples and expected baselines (corrected by Build Package 10A).

Sample class: **gold-standard scored sample** (`SAMPLE_CLASS_GOLD`).

> **Synthetic-data guarantee.** All inputs and expected baselines in this folder are synthetic. No real PII, PAN, SSN, PHI, customer identifiers, internal employee identifiers, secrets, credentials, or production endpoints appear here, and none must be added.

> **Build Package 10A note.** This sample's DFD has been reworked into a realistic GCP-style architecture review diagram and adopts the **default 4-token flow-tuple standard** for AISRAF cloud-architecture review samples. Real architecture boundaries, real component names, the founder-specified `<flow name> / <C#>,<T#>,<IA#|SA#|CA#>,<AZ#|AZ?>` flow-label grammar, the `<class> • <R#> • <Enc|Tok|Mask|Clr|Unknown>` data-store grammar, and a compact embedded legend panel (`subgraph LEGEND`) inside the rendered DFD replace the prior `BND-* / CMP-* / F#`-as-primary-visual-language pattern. Extraction IDs (`CMP-NN`, `BND-NN`, `F#`, `BC-NN`) live only in the analyst-extraction layer (the expected baselines and any operator-produced extraction outputs). The corrective patch resolves `BP12-SAMPLE-DFD-BLOCKER` on the sample side; the byte-copy under `runs/RUN-001/inputs/` is refreshed by Build Package 11A.

> **Default DFD standard (sample-001-dfd-crop is the canonical golden sample).** Every visible flow on the rendered DFD carries 4 comma-separated tokens: data class, transport protection, authentication, and authorization (or explicit `AZ?` unknown). Authentication never implies authorization. Every visible data store carries 3 `•`-separated tokens: data class, residency/replication marker, at-rest state. Component-level security-stack markers (e.g., `S1 ◇`) are signals, not proof. A compact legend panel is rendered as part of the DFD itself. This standard is the canonical default for any future cloud-architecture-review sample DFD authored under v0.1.2.

## 1. Practical Application Scenario

The sample is framed as a realistic, implementable internal application: an **AI SaaS Security Review Portal** deployed in a GCP project, exercised end-to-end at design-review time.

A small internal security-review web application that:

- accepts architecture-review requests from authenticated reviewers via the GCP edge (Cloud Load Balancer + Cloud Armor / WAF),
- forwards requests through an Application subnet stack (Review Portal Web App → API Gateway → Review Orchestrator Service),
- stores review request metadata in a managed Cloud SQL store inside the Data subnet,
- looks up policy reference context from an internal Policy Reference Store,
- calls an external AI Analysis SaaS via a dedicated AI Analysis Connector for analysis assistance,
- captures reviewer-approved findings in a Findings Store,
- writes handoff packs to a Review Artifact Bucket and audit events to an Audit Log Store,
- and renders local Jira / Confluence drafts (formatted_only) for the reviewer to copy into Atlassian Cloud — without claiming external post-back.

This scenario exercises the full v0.1.2 prompt → skill → PRA → adapter → blueprint → catalog → template chain on a realistic AI integration design without claiming runtime, cloud, ADK, MCP, or external post-back execution.

## 2. DFD Surface Coverage

| count | element |
|---|---|
| 14 | components (BP10 5–10 target band intentionally exceeded by Build Package 10A to model a realistic GCP edge-app-data-egress topology) |
| 14 | flows |
| 8 | trust / functional boundaries (External User / Internet Zone; GCP Project: aisraf-review-dev; VPC: review-platform-vpc; Edge subnet; Application subnet; Data subnet; External AI SaaS Provider Zone; Atlassian Cloud / Jira-Confluence Zone) |
| 5 | data stores in the Data subnet (Review Metadata Cloud SQL; Policy Reference Store; Findings Store; Review Artifact Bucket; Audit Log Store) |
| 1 | external AI SaaS endpoint (External AI Model Endpoint via the External AI SaaS Provider Zone) |
| 1 | model / AI endpoint (External AI Model Endpoint) |
| 1 | human actor (Reviewer Browser) |
| 1 | external Jira / Confluence destination (Jira / Confluence API — `formatted_only`, no external post-back) |
| 1 | edge security-stack diamond (`S1 ◇` at Cloud Armor / WAF) |
| 1 | proof-vs-signal test (`S1 ◇`) |
| 10 | boundary crossings (BC-01..10 — see `expected/expected-06-boundaries.md` and `expected/expected-dfd-06-boundary-crossings.md`) |
| 14 | flows carrying an explicit `AZ?` 4th-token (authorization-unknown sentinel; resolves to `<value-from-catalogs/identity-access/authorization-catalog.yaml#AZ-UNKNOWN>` per the founder rule that authentication never implies authorization) |
| 1 | embedded `subgraph LEGEND` panel rendered inside the DFD itself (operator-facing); supporting documentation lives in `inputs/dfd-legend-excerpt.md` |
| 5 | at-rest stores carrying `<class> • R1 • Enc` storage tuple (KMS / key rotation / scope unknown) |
| 1 | cross-internet model-call leg (F9 / F10) where data-class scope is recorded as `unknown` until MF-03 resolves only if the operator's design narrative confirms the request body content; otherwise C4 stands per the visible label |

## 3. Annotation Model Coverage

The sample exercises the v0.1.2 annotation model on:

- **data class** — `C2` (policy reference), `C4` (review request, review IP, finding records, handoff pack, audit event); F9 / F10 visible label asserts `C4` (model prompt and response carry C4 review-IP), with material-fact tracking on whether the AI Connector redacts before transmission;
- **authentication** — `IA1` (internal-reviewer SSO on F1 / F2 / F3), `SA5` (internal service-to-service on F4..F8, F11..F14), `SA7` (cross-internet service-to-service to external AI SaaS on F9 / F10);
- **authorization** — every visible flow tuple's 4th token is `AZ?` (explicit authorization-unknown sentinel); resolves to `AZ-UNKNOWN`. No `AZ#` is invented from authentication. Future sample DFDs that visibly prove authorization on a flow would carry `AZ#` (numbered subtype optional) resolving to `AZ-PRESENT`;
- **transport protection** — `T1` on every visible flow tuple;
- **at-rest protection** — `<class> • R1 • Enc` storage tuple on all 5 Data subnet stores; KMS / key rotation / scope unknown (drives MF-02);
- **confidence** — high / medium / low rows across the chain;
- **proof-vs-signal** — `S1 ◇` at Cloud Armor / WAF recorded as signal (`SR-DIAMOND-NOT-APPROVED-STACK`); `Enc` recorded as signal (`SR-MARKER-NOT-PROOF`); `T1` recorded as signal; gateway label at API Gateway recorded as signal (`SR-GATEWAY-NOT-ENFORCEMENT`);
- **boundary crossing** — internet exposure (BC-01), edge-to-application (BC-02), application-to-data (BC-03 / BC-04 / BC-07 / BC-08 / BC-09), application-to-external-SaaS (BC-05 outbound, BC-06 inbound), application-to-Atlassian (BC-10);
- **control / security-stack markers** — Cloud Armor / WAF stack diamond, API Gateway gateway label (signal only), per-store at-rest marker.

## 4. Expected Design Shape

External reviewer → GCP edge (Cloud LB + Cloud Armor / WAF) → Review Portal Web App → API Gateway → Review Orchestrator Service. Orchestrator fans out to: Cloud SQL (metadata), Policy Reference Store (read), AI Analysis Connector (which makes the cross-internet model call to the External AI SaaS), Findings Store, Review Artifact Bucket, Audit Log Store, and the Jira / Confluence API (formatted_only handoff). No external post-back. Reviewer (HITL) approves before any external action.

## 5. Expected Review Blueprint Disposition

Match-state model: `matched / candidate / no_match / unknown` (`blueprints/blueprint-registry.yaml#blueprint_match_states`).

| blueprint | disposition |
|---|---|
| `BP-AI-SAAS-INTEGRATION` (cloud-patterns) | `matched` (primary) |
| `BP-MODEL-ENDPOINT-CALL` (platform-independent) | `candidate` (provider is external SaaS) |
| `BP-HITL-APPROVAL` (platform-independent) | `matched` |
| `BP-API-WRITEBACK` (platform-independent) | `candidate` (`formatted_only`; not executed) |

Recorded in `expected/expected-11-blueprint-match.md`.

## 6. Expected AI Action Level

`AAL-L3` with `CL-MEDIUM` confidence. Recorded in `expected/expected-10-ai-action-level.md`. Rationale: AI assists drafting; HITL gates external action; F9 / F10 model-call legs carry C4 review-IP across the internet (operator must confirm whether the AI Analysis Connector redacts before transmission — drives MF-03), and authorization scope at the External AI Model Endpoint is unknown (drives MF-04).

## 7. Critical Misses This Sample Is Designed To Catch

- Asserting `security_stack_present: true` from the `S1 ◇` diamond at Cloud Armor / WAF alone (proof-vs-signal violation).
- Asserting at-rest encryption proof from the `Enc` marker alone on any Data subnet store.
- Inferring authorization from `IA#`/`SA#` markers (silently dropping `AZ-UNKNOWN`).
- Forcing F9 / F10 data class to `DC-UNKNOWN` when the visible label asserts `C4` — the operator must instead record an MF on whether the AI Connector redacts.
- Missing the External AI SaaS boundary crossing (BC-05 outbound, BC-06 inbound).
- Claiming external Jira post-back or Confluence publication from F14 (`formatted_only`).
- Producing a Jira / Confluence post-back claim without `postback_execution_status: executed_by_operator` and a matching post-back-row in `00-run-log.md`.
- Inventing an owner for REC-01 / REC-02 / REC-03 — owners remain `unknown` in this sample.
- Inventing a finding category outside `catalogs/review/finding-category-catalog.yaml`.
- Asserting `AAL-L4` without HITL approval evidence, or `AAL-L1` ignoring the F9 model call.
- Mixing implementation-validation evidence (KMS scope, IAM bindings, Terraform, deployed firewall rules) for any GCP component into the handoff pack rather than the validation notes.
- Producing a numeric accuracy score outside `skills/rs/SK-ACCURACY-SCORE.md`.
- Treating the `R1` replication marker as cross-region replication proof.

## 8. Inputs (6)

| input | path | role |
|---|---|---|
| DFD image | `inputs/dfd-crop.png` | Visible DFD; regenerated from `dfd-crop.mmd` via `mmdc`. |
| DFD source | `inputs/dfd-crop.mmd` | Mermaid source for reproducibility; not a separate review input. |
| Legend | `inputs/dfd-legend-excerpt.md` | Tokens visible on the DFD with normalization paths. |
| Triage notes | `inputs/cloud-triage-notes.md` | Component, AI-Action-Level, boundary, and uncertainty narrative. |
| Transcript | `inputs/review-transcript.md` | Synthetic review-call transcript with role labels only. |
| Intake ticket | `inputs/intake-ticket.md` | Synthetic intake ticket; scope and pass criteria. |

## 9. Expected Baselines (26)

17 RS baselines plus 9 DFD subskill baselines. Each baseline mirrors a Package 09 template `required_sections` exactly and carries optional YAML front matter for traceability and scoring metadata only (no JSON expected baselines exist in Package 10).

| # | RS baseline | mirrors template |
|---|---|---|
| 1 | `expected/expected-01-input-inventory.md` | `templates/output/output-01-input-inventory-template.md` |
| 2 | `expected/expected-02-visible-dfd-objects.md` | `templates/output/output-02-visible-dfd-objects-template.md` |
| 3 | `expected/expected-03-legend-normalization.md` | `templates/output/output-03-legend-normalization-template.md` |
| 4 | `expected/expected-04-components.md` | `templates/output/output-04-components-template.md` |
| 5 | `expected/expected-05-flows.md` | `templates/output/output-05-flows-template.md` |
| 6 | `expected/expected-06-boundaries.md` | `templates/output/output-06-boundaries-template.md` |
| 7 | `expected/expected-07-security-stack-assessment.md` | `templates/output/output-07-security-stack-assessment-template.md` |
| 8 | `expected/expected-08-internal-review-table.md` | `templates/output/output-08-internal-review-table-template.md` |
| 9 | `expected/expected-09-missing-facts.md` | `templates/output/output-09-missing-facts-template.md` |
| 10 | `expected/expected-10-ai-action-level.md` | `templates/output/output-10-ai-action-level-template.md` |
| 11 | `expected/expected-11-blueprint-match.md` | `templates/output/output-11-blueprint-match-template.md` |
| 12 | `expected/expected-12-targeted-questions.md` | `templates/output/output-12-targeted-questions-template.md` |
| 13 | `expected/expected-13-findings.md` | `templates/output/output-13-findings-template.md` |
| 14 | `expected/expected-14-recommendations.md` | `templates/output/output-14-recommendations-template.md` |
| 15 | `expected/expected-15-handoff-pack.md` | `templates/output/output-15-handoff-pack-template.md` |
| 16 | `expected/expected-16-validation-notes.md` | `templates/output/output-16-validation-notes-template.md` |
| 17 | `expected/expected-17-accuracy-score.md` | `templates/output/output-17-accuracy-score-template.md` |

| # | DFD baseline | mirrors template |
|---|---|---|
| 1 | `expected/expected-dfd-01-intake-quality-check.md` | `templates/output/output-dfd-01-intake-quality-check-template.md` |
| 2 | `expected/expected-dfd-02-boundary-catalog.md` | `templates/output/output-dfd-02-boundary-catalog-template.md` |
| 3 | `expected/expected-dfd-03-component-catalog.md` | `templates/output/output-dfd-03-component-catalog-template.md` |
| 4 | `expected/expected-dfd-04-flow-inventory.md` | `templates/output/output-dfd-04-flow-inventory-template.md` |
| 5 | `expected/expected-dfd-05-annotation-resolution.md` | `templates/output/output-dfd-05-annotation-resolution-template.md` |
| 6 | `expected/expected-dfd-06-boundary-crossings.md` | `templates/output/output-dfd-06-boundary-crossings-template.md` |
| 7 | `expected/expected-dfd-07-control-signals.md` | `templates/output/output-dfd-07-control-signals-template.md` |
| 8 | `expected/expected-dfd-08-confidence-score.md` | `templates/output/output-dfd-08-confidence-score-template.md` |
| 9 | `expected/expected-dfd-09-extraction-summary.md` | `templates/output/output-dfd-09-extraction-summary-template.md` |

`expected-00-run-log.md` is intentionally **not** included. Run logs are run artefacts and remain deferred to Build Package 11.

## 10. Coverage Of Package 04–09 Chain

| layer | what this sample covers |
|---|---|
| Prompts (Package 04) | RS chain `01..13` and DFD chain `02..10` (23 of 23 prompt cards exercised) |
| Skills (Package 05) | 17 RS skills (`SK-INPUT-PACKAGE-READ`..`SK-ACCURACY-SCORE`) + 9 DFD subskills (`SK-DFD-01..09`) |
| Prototype agents (Package 06) | PRA-02 through PRA-08 (PRA-01 orchestrator is exercised at the prompt level) |
| Adapters (Package 06) | `aisraf-input-reader`, `aisraf-dfd-extractor`, `aisraf-review-table-builder`, `aisraf-blueprint-questioner`, `aisraf-finding-recommender`, `aisraf-handoff-qa-scorer` |
| Catalogs (Package 07) | All 7 families referenced; controlled values used by `<value-from-catalogs/...>` placeholders only |
| Blueprints (Package 08) | BP-AI-SAAS-INTEGRATION, BP-MODEL-ENDPOINT-CALL, BP-HITL-APPROVAL, BP-API-WRITEBACK referenced (4 of 9) |
| Templates (Package 09) | 26 of the 27 output templates exercised; the run-log template is referenced only as future run support |

## 11. How To Run This Sample (deferred to Build Package 11 / 11A)

Build Package 10 / 10A do not produce run outputs. Build Package 11 establishes the governed run fixture; Build Package 11A refreshes the byte-copies under `runs/RUN-001/inputs/` to mirror this corrected sample. The chain itself remains operator-driven:

1. Copy `config/run-profile.template.yaml` to `runs/RUN-001/run-profile.yaml`.
2. Set `run_id: RUN-001`, `sample_id: sample-001-dfd-crop`, `mode: folder_first_test`.
3. Resolve `{{input_root}}` → `runs/RUN-001/inputs` (post-11A byte-copies of this sample's inputs).
4. Resolve `{{expected_root}}` → `samples/sample-001-dfd-crop/expected`.
5. Resolve `{{output_root}}` → `runs/RUN-001`.
6. Execute the chain via the local Copilot prompt cards under `prompts/`.
7. Score actual outputs in `{{output_root}}` against expected baselines in `{{expected_root}}` via `prompts/rs/13-accuracy-score.prompt.md` / `skills/rs/SK-ACCURACY-SCORE.md`.

Build Package 10 / 10A do not run prompts, skills, PRAs, adapters, or scoring.

## 12. Scored vs Exploratory Status

`gold-standard scored sample` — scored when `scoring_enabled: true`, `expected_baseline_required: true`, and `{{expected_root}}` is non-empty (which it is for this sample).

## 13. What This Sample Does Not Prove

- Runtime, cloud, ADK, Vertex/GCP, MCP, Jira post-back, Confluence publication, Rovo execution, database jobs, Terraform.
- Implementation evidence at any component (routes to `expected/expected-16-validation-notes.md`).
- C5 / C5* / PCI / PAN / SSN / PHI handling — not in scope.
- Diagram rendering beyond the local Mermaid PNG used as the sample image.
- Practitioner / runbook prose — Build Package 14 territory.
- Release packaging / ZIP — Build Package 15 territory.
- Numeric accuracy scoring threshold lock — deferred to Build Package 11 when the v0.1.2 scoring rubric runs against this baseline.
- `R1` does not prove cross-region replication, multi-region failover, regional residency configuration, or backup posture.
- The `GCP Project: aisraf-review-dev`, `VPC: review-platform-vpc`, and Edge / Application / Data subnet labels are review-time architecture context. They do not prove deployed runtime, configured firewall rules, IAM bindings, service-account safety, or encryption configuration.

## 14. Source Reference

Built for AISRAF SAS Prototype v0.1.2 sample-001-dfd-crop (Build Package 10, corrected by Build Package 10A). Conceptually informed by the v0.01 sample-001-dfd-crop framing (gold-standard scored sample with 17 RS expected baselines); not bit-copied. The v0.1.2 sample is rebuilt for a new application scenario (AI SaaS Security Review Portal on GCP) and aligned to v0.1.2 catalogs, blueprints, and Package 09 templates. The v0.01 numeric score `151/160` is recorded as `legacy_reference_score` only in `expected/expected-17-accuracy-score.md` and is not asserted as v0.1.2 truth.

## 15. Build Package 10A Corrective Patch — `BP12-SAMPLE-DFD-BLOCKER` Resolution

Build Package 10A reworks the canonical DFD into a realistic GCP-style architecture review diagram. Drivers, scope, and outcome:

- **Driver.** `BP12-SAMPLE-DFD-BLOCKER` (recorded in `validation/sample-input-readiness-checklist.md`, `validation/expected-output-lint-checklist.md`, `validation/diagram-readiness-pre-render-checklist.md`, `validation/no-drift-rules.md`, `validation/package-12-validation-checklist.md`, `validation/final-qa-checklist.md`, `PACKAGE-MANIFEST.yaml`) flagged the prior DFD as unacceptable: extraction IDs (BND-*, CMP-*, F#) used as primary visual labels; flow labels did not follow `<data/action name> / <C#>,<T#>,<auth>` grammar; storage annotations lacked storage-state markers; authorization was conflated with authentication.
- **Scope of patch.** New `dfd-crop.mmd` (real architecture); regenerated `dfd-crop.png` via `mmdc`; rewritten `dfd-legend-excerpt.md` (new tokens including `SA5`, `SA7`, `R1`, `Enc`, `S1 ◇`); this README rewritten; affected expected baselines under `expected/` updated where they enumerate or quote visible diagram labels (the topology change expanded the component count from 8 to 14, the boundary count from 4 to 8, the flow count from 8 to 14, and the boundary-crossing count from 7 to 10). RS baselines whose semantics do not depend on visible labels (input inventory, AI action level, blueprint match, targeted questions, findings, recommendations, handoff pack, validation notes, accuracy score) remain unchanged in semantics; per-row IDs may have been touched only where the row references a flow / component / boundary ID.
- **Out of scope of 10A.** `prompts/`, `skills/`, `prototype-agents/`, `.agents/`, `catalogs/`, `blueprints/`, `templates/`, `config/`, `tools/New-AisrafRun.ps1`, `tools/Test-AisrafRunProfile.ps1`, `runs/RUN-001/inputs/`, `runs/RUN-001/run-profile.yaml`, `runs/RUN-001/00-run-log.md`, `runs/RUN-001/README.md`, `diagrams/`, `docs/`, `release/`. Build Package 11A refreshes `runs/RUN-001/inputs/`.
- **Resolution status.** `BP12-SAMPLE-DFD-BLOCKER: RESOLVED-BY-10A` on the sample side; `RESOLVED-BY-10A-AND-11A` after the byte-copies under `runs/RUN-001/inputs/` are refreshed. BP13 entry remains pinned `next_allowed_pending_blocker_resolution` until 11A completes.
- **Validation evidence.** `validation/package-10a-corrective-patch-checklist.md` records the falsifiable gates that prove the DFD now satisfies the founder-specified diagrammatic-quality rules in `validation/sample-input-readiness-checklist.md` gates 7, 8, 11, 12, 13, 14, 15, 16.
