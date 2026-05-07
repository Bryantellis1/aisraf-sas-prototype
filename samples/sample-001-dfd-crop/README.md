# sample-001-dfd-crop

Owning Build Package: Build Package 10 — Samples and expected baselines.

Sample class: **gold-standard scored sample** (`SAMPLE_CLASS_GOLD`).

> **Synthetic-data guarantee.** All inputs and expected baselines in this folder are synthetic. No real PII, PAN, SSN, PHI, customer identifiers, internal employee identifiers, secrets, credentials, or production endpoints appear here, and none must be added.

## 1. Practical Application Scenario

The sample is framed as a realistic, implementable internal application: an **AI SaaS Security Review Portal**.

A small internal security-review web application that:

- accepts architecture-review requests from authenticated reviewers,
- stores review request metadata in an internal database,
- calls an external AI Analysis Service for analysis assistance,
- retrieves policy/reference context from an internal store,
- captures reviewer-approved findings,
- and renders local Jira/Confluence drafts for the reviewer to copy (`formatted_only`).

This scenario exercises the full v0.1.2 prompt → skill → PRA → adapter → blueprint → catalog → template chain on a realistic AI integration design without claiming runtime, cloud, ADK, MCP, or external post-back execution.

## 2. DFD Surface Coverage

| count | element |
|---|---|
| 8 | components (within the 5–10 target band) |
| 8 | flows (within the 6–10 target band) |
| 4 | trust boundaries (BND-01 internet; BND-02 external SaaS; BND-03 application zone; BND-04 internal data zone) |
| 3 | data stores (CMP-04 Review Metadata DB; CMP-06 Policy Reference Store; CMP-07 Findings Store) |
| 1 | external system (CMP-05 AI Analysis Service via BND-02) |
| 1 | model/AI endpoint (CMP-05) |
| 1 | human actor (CMP-01 Reviewer Browser) |
| 1 | optional Jira/Confluence draft destination (CMP-08 — `formatted_only`) |
| 2 | unknown / ambiguous annotations (F4 / F5 `class unknown`) |
| 1 | proof-vs-signal test (`S1` diamond at CMP-03) |
| 7 | boundary crossings (BC-01..07 — see `expected/expected-06-boundaries.md`) |
| 1 | AuthN/AuthZ uncertainty (`SA1` AuthN visible at F4 with AZ scope unknown) |
| 1 | at-rest store with marker but no proof (CMP-04 `E1`) |
| 3 | confidence low/medium cases (F4, F5, RT-04 / RT-05) |

## 3. Annotation Model Coverage

The sample exercises the v0.1.2 annotation model on:

- **data class** — `C2`, `C4`, `C4P` (recorded under `DC-C5P` raw_pattern with a medium-confidence note in the legend normalization), and `DC-UNKNOWN` for F4 / F5;
- **authentication** — `IA1` (internal user) and `SA1` (service-to-service);
- **authorization** — `AZ-UNKNOWN` on F2, F4, F6, F7 to test the AuthN-not-AuthZ rule;
- **transport protection** — `T1` on F1 and `TP-UNKNOWN` on F4;
- **at-rest protection** — `E1` marker at CMP-04 with KMS scope unknown;
- **confidence** — high/medium/low rows across the chain;
- **proof-vs-signal** — `S1` diamond at CMP-03 recorded as signal (`SR-DIAMOND-NOT-APPROVED-STACK`); `E1` recorded as signal (`SR-MARKER-NOT-PROOF`); `T1` recorded as signal; gateway label recorded as signal (`SR-GATEWAY-NOT-ENFORCEMENT`);
- **boundary crossing** — internet exposure, model-endpoint crossing, data-store crossing, and tool-API surface crossing;
- **control / security-stack markers** — stack-diamond, gateway-or-policy-checkpoint, encryption-checkpoint via the at-rest marker.

## 4. Expected Design Shape

Internal Review Portal → external AI SaaS model call → human-approved local Jira/Confluence draft. No external post-back. Reviewer (HITL) approves before any external action.

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

`AAL-L3` with `CL-MEDIUM` confidence. Recorded in `expected/expected-10-ai-action-level.md`. Rationale: AI assists drafting; HITL gates external action; F4 payload class (MF-03) and AZ scope at CMP-05 (MF-04) are open.

## 7. Critical Misses This Sample Is Designed To Catch

- Asserting `security_stack_present: true` from `S1` alone (proof-vs-signal violation).
- Asserting at-rest encryption proof from the `E1` marker alone.
- Forcing F4 / F5 data class to `DC-C5` or `DC-C4` without supporting evidence (silent unknown).
- Missing the BND-02 internet boundary crossing (BC-02) or downgrading the `BP-AI-SAAS-INTEGRATION` match.
- Claiming external Jira post-back or Confluence publication from F8 (`formatted_only`).
- Producing a Jira/Confluence post-back claim without `postback_execution_status: executed_by_operator` and a matching post-back-row in `00-run-log.md`.
- Inventing an owner for REC-01 / REC-02 / REC-03 — owners remain `unknown` in this sample.
- Inventing a finding category outside `catalogs/review/finding-category-catalog.yaml`.
- Asserting `AAL-L4` without HITL approval evidence, or `AAL-L1` ignoring the F4 model call.
- Mixing implementation-validation evidence for CMP-04 / CMP-03 into the handoff pack rather than the validation notes.
- Producing a numeric accuracy score outside `skills/rs/SK-ACCURACY-SCORE.md`.

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

## 11. How To Run This Sample (deferred to Build Package 11)

Build Package 10 does not produce run outputs. Build Package 11 will:

1. Copy `config/run-profile.template.yaml` to `runs/RUN-001/run-profile.yaml`.
2. Set `run_id: RUN-001`, `sample_id: sample-001-dfd-crop`, `mode: folder_first_test`.
3. Resolve `{{input_root}}` → `samples/sample-001-dfd-crop/inputs`.
4. Resolve `{{expected_root}}` → `samples/sample-001-dfd-crop/expected`.
5. Resolve `{{output_root}}` → `runs/RUN-001`.
6. Execute the chain via the local Copilot prompt cards under `prompts/`.
7. Score actual outputs in `{{output_root}}` against expected baselines in `{{expected_root}}` via `prompts/rs/13-accuracy-score.prompt.md` / `skills/rs/SK-ACCURACY-SCORE.md`.

Build Package 10 does not run prompts, skills, PRAs, adapters, or scoring.

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

## 14. Source Reference

Built for AISRAF SAS Prototype v0.1.2 sample-001-dfd-crop (Build Package 10). Conceptually informed by the v0.01 sample-001-dfd-crop framing (gold-standard scored sample with 17 RS expected baselines); not bit-copied. The v0.1.2 sample is rebuilt for a new application scenario (AI SaaS Security Review Portal) and aligned to v0.1.2 catalogs, blueprints, and Package 09 templates. The v0.01 numeric score `151/160` is recorded as `legacy_reference_score` only in `expected/expected-17-accuracy-score.md` and is not asserted as v0.1.2 truth.
