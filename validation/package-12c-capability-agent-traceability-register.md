# Build Package 12C — Capability-to-Agent Traceability Register

| Field | Value |
|---|---|
| Document name | AISRAF Capability-to-Agent Traceability Register |
| Work package | WP-12C-I — Solution Package Architecture & Agent Specification Alignment; WP-12C-CBG0 — Catalog / Blueprint Governance Alignment |
| Status | DRAFT — alignment and knowledge-governance register, no execution claim |
| Audience | Founder, package maintainer, plugin packager, future runtime adapter implementer, reviewer |
| Purpose | Provide a single row-per-agent map from Capability through Value, Process Flow, Task Flow, Skill, Hook, Memory, Evaluation, Evidence, and Platform Projection so any drift is one diff away from being visible |
| Companion | `validation/package-12c-solution-package-architecture.md`, `validation/package-12c-agent-spec-template.md`, `validation/package-12c-platform-projection-matrix.md`, `validation/package-12c-plugin-roadmap.md` |

## 1. Read Before Anything Else

- This register is descriptive. It does not modify any canonical PRA, prompt, skill, template, catalog, sample, or run output.
- Sealed surfaces remain sealed: `prompts/`, `skills/`, `prototype-agents/`, `.agents/`, `.github/agents/`, `catalogs/`, `blueprints/`, `templates/`, `samples/`, `runs/RUN-001/`.
- `match=unknown` and the unknown handling values (`IA?`, `SA?`, `CA?`, `AZ?`, `R?`, `L?`) are preserved.
- All paths in this register are factual; they reference files that exist today in the repository.

## 2. Capability Header

| Field | Value |
|---|---|
| capability_id | `CAP-AISRAF-SECURITY-REVIEW-WORKBENCH` |
| capability_name | AISRAF Security & Solution Architecture Review Workbench |
| value_outcome | Governed, traceable, scored SAS review pack delivered from a DFD input package, with zero invented inputs and zero claimed external execution |
| owning_pfs | `PFS-AISRAF-SAS-REVIEW-CHAIN` |
| primary_user | SAS reviewer (consumer); founder/operator (driver) |
| canonical_source_root | repository root of `AISRAF- SAS Prototype v0.1.2` |

## 3. Per-Agent Traceability Rows

Reading order: each row anchors one agent and threads it through the operating law. Where multiple values apply, comma-separated list inside the cell.

### 3.1 AISRAF Orchestrator (TFS-00)

| Layer | Value |
|---|---|
| Capability | `CAP-AISRAF-SECURITY-REVIEW-WORKBENCH` |
| Value outcome | Run-log + handoff confirmation that the chain ran, in order, with declared stop conditions |
| PFS | `PFS-AISRAF-SAS-REVIEW-CHAIN` |
| TFS | `TFS-00-ORCHESTRATE-REVIEW` |
| Agent | AISRAF Orchestrator |
| Canonical PRA | `prototype-agents/PRA-01-SAS-REVIEW-ORCHESTRATOR.md` |
| Canonical adapter | `.agents/aisraf-orchestrator.agent.md` |
| Canonical prompts | `prompts/rs/00-run-full-chain.prompt.md` |
| Canonical skills | none (orchestration owns no skill body) |
| Canonical templates | `templates/output/output-00-run-log-template.md` |
| Hooks | `aisraf-allowed-path-prewrite-guard`, `aisraf-focused-validator-postwrite`, `aisraf-session-stop-summary`, `aisraf-precommit-full-validator` |
| Memory / state | `runs/{{run_id}}/run-profile.yaml`, `runs/{{run_id}}/00-run-log.md` (run-scoped files; no agent-side memory) |
| Evaluation | discovery, role smoke (B1), chat preview (P1), validators (Test-AisrafPackage / Test-AisrafBp12AReadiness / Test-AisrafRunProfile -ExecutionReady) |
| Evidence | `validation/package-12c-quick-manual-test-card.md` row B1; `validation/package-12c-sample-input-output-test-card.md` rows A1 + B1; `runs/RUN-001/00-run-log.md` (sealed BP12B) |
| Platform projections | `.agents/aisraf-orchestrator.agent.md`, `.github/agents/aisraf-orchestrator.agent.md`, `.github/skills/aisraf-orchestration/SKILL.md`, `.copilot-skills/aisraf-orchestration.skill.md`, `.copilot-skills/aisraf-orchestration.operator-card.md` |

### 3.2 AISRAF Input Reader (TFS-01)

| Layer | Value |
|---|---|
| Capability | `CAP-AISRAF-SECURITY-REVIEW-WORKBENCH` |
| Value outcome | Honest input inventory (`received` / `missing` / `empty`) of staged review materials, with no invented inputs |
| PFS | `PFS-AISRAF-SAS-REVIEW-CHAIN` |
| TFS | `TFS-01-READ-INPUT-PACKAGE` |
| Agent | AISRAF Input Reader |
| Canonical PRA | `prototype-agents/PRA-02-INPUT-READER.md` |
| Canonical adapter | `.agents/aisraf-input-reader.agent.md` |
| Canonical prompts | `prompts/rs/01-input-package-read.prompt.md` |
| Canonical skills | `skills/rs/SK-INPUT-PACKAGE-READ.md` |
| Canonical templates | `templates/output/output-01-input-inventory-template.md` |
| Hooks | same hook set as §3.1 |
| Memory / state | `runs/{{run_id}}/inputs/`, `runs/{{run_id}}/01-input-inventory.md` (run-scoped files) |
| Evaluation | discovery, role smoke (B2), chat preview (P2), sample input/output preview (A2 + B2) |
| Evidence | `validation/package-12c-quick-manual-test-card.md` row B2; `validation/package-12c-sample-input-output-test-card.md` rows A2 + B2; `runs/RUN-001/01-input-inventory.md` (sealed BP12B) |
| Platform projections | `.agents/aisraf-input-reader.agent.md`, `.github/agents/aisraf-input-reader.agent.md`, `.github/skills/aisraf-input-read/SKILL.md`, `.copilot-skills/aisraf-input-read.skill.md`, `.copilot-skills/aisraf-input-read.operator-card.md` |

### 3.3 AISRAF DFD Extractor (TFS-02)

| Layer | Value |
|---|---|
| Capability | `CAP-AISRAF-SECURITY-REVIEW-WORKBENCH` |
| Value outcome | Visible DFD objects, normalized legend, components, flows, and 9 DFD subskill outputs, with `unknown` preserved |
| PFS | `PFS-AISRAF-SAS-REVIEW-CHAIN` |
| TFS | `TFS-02-EXTRACT-DFD-FACTS` |
| Agent | AISRAF DFD Extractor |
| Canonical PRA | `prototype-agents/PRA-03-DFD-EXTRACTOR.md`, `prototype-agents/PRA-04-LEGEND-NORMALIZER.md` |
| Canonical adapter | `.agents/aisraf-dfd-extractor.agent.md` |
| Canonical prompts | `prompts/rs/02-dfd-visual-read.prompt.md`, `prompts/rs/03-legend-normalization.prompt.md`, `prompts/rs/04-design-fact-extract.prompt.md`, `prompts/rs/05-boundary-stack-detect.prompt.md`, `prompts/dfd/02-dfd-intake-quality-check.prompt.md` through `prompts/dfd/10-dfd-extraction-summarize.prompt.md` |
| Canonical skills | `skills/rs/SK-DFD-VISUAL-READ.md`, `SK-LEGEND-NORMALIZE.md`, `SK-COMPONENT-EXTRACT.md`, `SK-FLOW-EXTRACT.md`, `SK-BOUNDARY-CROSSING-DETECT.md`, `skills/dfd/SK-DFD-0[1-9]-*.md` |
| Canonical templates | `templates/output/output-02-visible-dfd-objects-template.md` through `output-05-flows-template.md`; the 9 DFD output templates |
| Hooks | same hook set as §3.1 |
| Memory / state | `runs/{{run_id}}/02..05-*.md`, `runs/{{run_id}}/dfd/01..09-*.md` (run-scoped files) |
| Evaluation | discovery, role smoke (B3), chat preview (P3), sample input/output preview (A3 + B3) |
| Evidence | `validation/package-12c-quick-manual-test-card.md` row B3; `validation/package-12c-sample-input-output-test-card.md` rows A3 + B3; `runs/RUN-001/02..05-*.md` and `runs/RUN-001/dfd/01..09-*.md` (sealed BP12B) |
| Platform projections | `.agents/aisraf-dfd-extractor.agent.md`, `.github/agents/aisraf-dfd-extractor.agent.md`, `.github/skills/aisraf-dfd-extraction/SKILL.md`, `.copilot-skills/aisraf-dfd-extraction.skill.md`, `.copilot-skills/aisraf-dfd-extraction.operator-card.md` |

### 3.4 AISRAF Review Table Builder (TFS-03)

| Layer | Value |
|---|---|
| Capability | `CAP-AISRAF-SECURITY-REVIEW-WORKBENCH` |
| Value outcome | Boundaries, security stack assessment, and internal review table, with no asserted controls absent evidence |
| PFS | `PFS-AISRAF-SAS-REVIEW-CHAIN` |
| TFS | `TFS-03-BUILD-REVIEW-TABLE` |
| Agent | AISRAF Review Table Builder |
| Canonical PRA | `prototype-agents/PRA-05-REVIEW-TABLE-BUILDER.md` |
| Canonical adapter | `.agents/aisraf-review-table-builder.agent.md` |
| Canonical prompts | `prompts/rs/05-boundary-stack-detect.prompt.md`, `prompts/rs/06-review-table-build.prompt.md` |
| Canonical skills | `skills/rs/SK-BOUNDARY-CROSSING-DETECT.md`, `SK-SECURITY-STACK-ASSESS.md`, `SK-DATA-FLOW-TABLE-BUILD.md` |
| Canonical templates | `templates/output/output-06-boundaries-template.md`, `output-07-security-stack-assessment-template.md`, `output-08-internal-review-table-template.md` |
| Hooks | same hook set as §3.1 |
| Memory / state | `runs/{{run_id}}/06-boundaries.md`, `07-security-stack-assessment.md`, `08-internal-review-table.md` (run-scoped files) |
| Evaluation | discovery, role smoke (B4), chat preview (P4), sample input/output preview (A4 + B4) |
| Evidence | `validation/package-12c-quick-manual-test-card.md` row B4; `validation/package-12c-sample-input-output-test-card.md` rows A4 + B4; `runs/RUN-001/06-08-*.md` (sealed BP12B) |
| Platform projections | `.agents/aisraf-review-table-builder.agent.md`, `.github/agents/aisraf-review-table-builder.agent.md`, `.github/skills/aisraf-review-table-build/SKILL.md`, `.copilot-skills/aisraf-review-table-build.skill.md`, `.copilot-skills/aisraf-review-table-build.operator-card.md` |

### 3.5 AISRAF Blueprint Questioner (TFS-04)

| Layer | Value |
|---|---|
| Capability | `CAP-AISRAF-SECURITY-REVIEW-WORKBENCH` |
| Value outcome | Missing facts list, AI Action Level classification, blueprint match (or `match=unknown`), and targeted operator questions |
| PFS | `PFS-AISRAF-SAS-REVIEW-CHAIN` |
| TFS | `TFS-04-GENERATE-BLUEPRINT-QUESTIONS` |
| Agent | AISRAF Blueprint Questioner |
| Canonical PRA | `prototype-agents/PRA-06-BLUEPRINT-QUESTIONER.md` |
| Canonical adapter | `.agents/aisraf-blueprint-questioner.agent.md` |
| Canonical prompts | `prompts/rs/07-missing-fact-question-generate.prompt.md`, `prompts/rs/08-ai-action-level-classify.prompt.md`, `prompts/rs/09-blueprint-match.prompt.md` |
| Canonical skills | `skills/rs/SK-MISSING-FACT-IDENTIFY.md`, `SK-AI-ACTION-LEVEL-CLASSIFY.md`, `SK-REVIEW-BLUEPRINT-MATCH.md`, `SK-TARGETED-QUESTION-GENERATE.md` |
| Canonical templates | `templates/output/output-09-missing-facts-template.md` through `output-12-targeted-questions-template.md` |
| Knowledge / data product contracts | Catalogs from `catalogs/catalog-registry.yaml`; AI Action Level values from `catalogs/review/ai-action-level-catalog.yaml`; blueprints from `blueprints/blueprint-registry.yaml` and `blueprints/**/*.yaml`; output shapes from `templates/output/output-09-missing-facts-template.md` through `output-12-targeted-questions-template.md` |
| Governance boundary | PRA-06 consumes blueprints as reusable review patterns and does not invent blueprint states. Blueprint match states remain registry-owned (`matched`, `candidate`, `no_match`, `unknown`); `match=unknown`, `Unknown`, `Not Stated`, and `Deferred` evidence states are preserved when evidence is insufficient. |
| Hooks | same hook set as §3.1 |
| Memory / state | `runs/{{run_id}}/09-missing-facts.md`, `10-ai-action-level.md`, `11-blueprint-match.md`, `12-targeted-questions.md` (run-scoped files) |
| Evaluation | discovery, role smoke (B5), chat preview (P5), sample input/output preview (A5 + B5) |
| Evidence | `validation/package-12c-quick-manual-test-card.md` row B5; `validation/package-12c-sample-input-output-test-card.md` rows A5 + B5; `runs/RUN-001/09-12-*.md` (sealed BP12B) |
| Platform projections | `.agents/aisraf-blueprint-questioner.agent.md`, `.github/agents/aisraf-blueprint-questioner.agent.md`, `.github/skills/aisraf-blueprint-questioning/SKILL.md`, `.copilot-skills/aisraf-blueprint-questioning.skill.md`, `.copilot-skills/aisraf-blueprint-questioning.operator-card.md` |

### 3.6 AISRAF Finding Recommender (TFS-05)

| Layer | Value |
|---|---|
| Capability | `CAP-AISRAF-SECURITY-REVIEW-WORKBENCH` |
| Value outcome | Findings classified and recommendations written with parent-finding traceability and no invented owner/control evidence |
| PFS | `PFS-AISRAF-SAS-REVIEW-CHAIN` |
| TFS | `TFS-05-WRITE-FINDINGS-AND-RECOMMENDATIONS` |
| Agent | AISRAF Finding Recommender |
| Canonical PRA | `prototype-agents/PRA-07-FINDING-RECOMMENDER.md` |
| Canonical adapter | `.agents/aisraf-finding-recommender.agent.md` |
| Canonical prompts | `prompts/rs/10-finding-recommendation-write.prompt.md` |
| Canonical skills | `skills/rs/SK-FINDING-CLASSIFY.md`, `SK-RECOMMENDATION-WRITE.md` |
| Canonical templates | `templates/output/output-13-findings-template.md`, `output-14-recommendations-template.md` |
| Hooks | same hook set as §3.1 |
| Memory / state | `runs/{{run_id}}/13-findings.md`, `14-recommendations.md` (run-scoped files) |
| Evaluation | discovery, role smoke (B6), chat preview (P6), sample input/output preview (A6 + B6) |
| Evidence | `validation/package-12c-quick-manual-test-card.md` row B6; `validation/package-12c-sample-input-output-test-card.md` rows A6 + B6; `runs/RUN-001/13-14-*.md` (sealed BP12B) |
| Platform projections | `.agents/aisraf-finding-recommender.agent.md`, `.github/agents/aisraf-finding-recommender.agent.md`, `.github/skills/aisraf-finding-recommendation/SKILL.md`, `.copilot-skills/aisraf-finding-recommendation.skill.md`, `.copilot-skills/aisraf-finding-recommendation.operator-card.md` |

### 3.7 AISRAF Handoff QA Scorer (TFS-06)

| Layer | Value |
|---|---|
| Capability | `CAP-AISRAF-SECURITY-REVIEW-WORKBENCH` |
| Value outcome | Handoff pack, validation notes, accuracy score band — score never claimed without declared scoring conditions |
| PFS | `PFS-AISRAF-SAS-REVIEW-CHAIN` |
| TFS | `TFS-06-BUILD-HANDOFF-QA-AND-SCORE` |
| Agent | AISRAF Handoff QA Scorer |
| Canonical PRA | `prototype-agents/PRA-08-HANDOFF-QA-SCORER.md` |
| Canonical adapter | `.agents/aisraf-handoff-qa-scorer.agent.md` |
| Canonical prompts | `prompts/rs/11-handoff-pack-build.prompt.md`, `prompts/rs/12-validation-note-write.prompt.md`, `prompts/rs/13-accuracy-score.prompt.md` |
| Canonical skills | `skills/rs/SK-HANDOFF-PACK-BUILD.md`, `SK-VALIDATION-NOTE-WRITE.md`, `SK-ACCURACY-SCORE.md` |
| Canonical templates | `templates/output/output-15-handoff-pack-template.md` through `output-17-accuracy-score-template.md` |
| Hooks | same hook set as §3.1 |
| Memory / state | `runs/{{run_id}}/15-handoff-pack.md`, `16-validation-notes.md`, `17-accuracy-score.md` (run-scoped files) |
| Evaluation | discovery, role smoke (B7), chat preview (P7), sample input/output preview (A7 + B7), scoring/regression layer |
| Evidence | `validation/package-12c-quick-manual-test-card.md` row B7; `validation/package-12c-sample-input-output-test-card.md` rows A7 + B7; `runs/RUN-001/15-17-*.md` (sealed BP12B); `samples/sample-001-dfd-crop/expected/expected-17-accuracy-score.md` |
| Platform projections | `.agents/aisraf-handoff-qa-scorer.agent.md`, `.github/agents/aisraf-handoff-qa-scorer.agent.md`, `.github/skills/aisraf-handoff-qa-score/SKILL.md`, `.copilot-skills/aisraf-handoff-qa-score.skill.md`, `.copilot-skills/aisraf-handoff-qa-score.operator-card.md` |

## 4. Cross-Cutting Layer Summaries

### 4.1 Hook Coverage

| Hook | Applies To | Provider Surface |
|---|---|---|
| `aisraf-allowed-path-prewrite-guard` | every agent that may write under `runs/{{run_id}}/` | `.github/hooks/aisraf-guardrails.json` PreToolUse + `tools/hooks/aisraf-allowed-path-prewrite-guard.ps1` |
| `aisraf-focused-validator-postwrite` | every agent that wrote a file in the last step | `.github/hooks/aisraf-guardrails.json` PostToolUse + `tools/hooks/aisraf-focused-validator-postwrite.ps1` |
| `aisraf-session-stop-summary` | every agent at session/agent stop | `.github/hooks/aisraf-guardrails.json` Stop + `tools/hooks/aisraf-session-stop-summary.ps1` |
| `aisraf-precommit-full-validator` | every agent before `git commit` | operator-local `.claude/` install + `tools/hooks/aisraf-precommit-full-validator.ps1` |

### 4.2 Memory / State Scope

All seven agents use `run-scoped-files` only. There is no agent-side memory, no cross-run persistence, no telemetry beam-out. State is replayable from the canonical assets and `runs/{{run_id}}/`.

### 4.3 Evaluation Coverage

| Layer | Status |
|---|---|
| Discovery | structurally pass; manual evidence pending in `agent-skill-projection-checklist.md`, `hook-readiness-checklist.md` |
| Role smoke | structurally pass; manual evidence pending in `role-smoke-test-checklist.md` |
| Chat preview | structurally pass; manual evidence pending in `chat-preview-test-checklist.md` |
| Sample input/output preview | next; covered by `package-12c-sample-input-output-test-card.md` |
| Controlled output | deferred; covered by `package-12c-controlled-output-checklist.md` |
| Scoring / regression | covered by `package-12c-regression-checklist.md`; depends on baseline byte-stability |
| Operator-card usability | covered by `package-12c-operator-card-usability-checklist.md` |
| Plugin install | future; covered by `package-12c-plugin-roadmap.md` WP-12C-L |
| Bring-your-own-DFD intake | deferred to BP12D / post-BP13 |

### 4.4 Drift Detection (no register row may show)

- An agent with no canonical PRA.
- An agent with no canonical adapter under `.agents/`.
- A controlled output that is not in `tools/hooks/hook-allow-list.yaml`.
- A provider projection that copies a canonical body instead of referencing it.
- An evidence row that points to a path that does not exist.
- An evaluation row that references a checklist that does not exist.
- A catalog-controlled value set duplicated inside an agent, prompt, skill, provider projection, or QA report instead of referenced by catalog ID/path.
- A PRA-06, prompt, skill, template, or QA row that invents AI Action Level values or blueprint match states inline.
- A row that converts `Unknown`, `Not Stated`, `Deferred`, or `match=unknown` into an optimistic value without evidence.

### 4.5 Knowledge / Data Product Contract Summary

| Contract Layer | Traceability Rule | Consumer Boundary | Evidence / Validation |
|---|---|---|---|
| Catalogs | Controlled vocabulary and allowed-value contracts. The catalog registry owns the value sets and evidence rules. | Agents, prompts, skills, templates, blueprints, and projections reference catalog IDs or paths; they do not duplicate catalog entries. | Catalog registry checks, catalog-consumption checklist, package validator catalog checks. |
| Blueprints | Reusable review patterns, not findings, recommendations, owner routes, or templates. The blueprint registry owns the match-state model. | PRA-06 consumes blueprints for missing facts, AAL context, blueprint match, and targeted questions; PRA-07/PRA-08 consume downstream results. | Blueprint registry checks, blueprint-catalog-consumption checklist, traceability rows for PRA-06..08. |
| Templates | Output shape contracts. Templates record sections, placeholders, output boundaries, and prohibited content. | Templates may name catalog and blueprint paths but must not enumerate controlled values or decide match/AAL/severity/score. | Template registry checks, template-consumption checklist, output completeness checks. |
| Schemas / run profiles | Type and execution contracts for run identity, output root, safe defaults, destination intent, sensitive-data confirmation, and scoring eligibility. | Tools, hooks, templates, and agents read the run profile; future adapters must respect the schema instead of inventing fields. | `Test-AisrafRunProfile.ps1 -ExecutionReady`, BP12A readiness, schema parse checks. |
| Evidence / validation | Proof contracts that show what was read, written, validated, deferred, or blocked. | QA and release governance report evidence and gaps; they do not edit source catalogs or blueprints. | Validator transcripts, QA reports, gap/blocker registers, checksum evidence, run-profile validation. |

Future WP-12C-CBG1 or `AG-AISRAF-KNOWLEDGE-CURATOR-R1` is needed only when the package must change catalog values, blueprint states, blueprint-to-catalog mappings, template-to-catalog mappings, schema fields, lifecycle policy, or duplicated governed vocabulary across multiple surfaces. `AG-AISRAF-KNOWLEDGE-CURATOR-R1` is future-only in this package: it is not registered, projected, active, or authorized to run reviews.

## 5. Stop Conditions For This Register

- Any row that introduces an agent not currently registered in `prototype-agent-registry.yaml`.
- Any row that names a canonical path that does not exist in the repository.
- Any row that claims runtime / cloud / MCP / ADK / Microsoft Agent Framework / Azure AI Foundry / Google ADK / Jira / Confluence / Rovo / database / Terraform / release execution.
- Any row that fills `unknown` with a guess.

## 6. Acceptance Verdict

`WP-12C-I_TRACEABILITY_REGISTER_PASS` when:

- All seven per-agent rows are present and reference paths that exist.
- The hook coverage, memory/state, evaluation, and drift-detection sub-summaries are present.
- All three validators run with `0 FAIL`.
