# Build Package 12C — Solution Package Architecture

| Field | Value |
|---|---|
| Document name | AISRAF Solution Package Architecture |
| Work package | WP-12C-BA1 — Business Architecture Traceability Spine Alignment; WP-12C-CBG0 — Catalog / Blueprint Governance Alignment |
| Status | Strong pre-release prototype / local workbench package; alignment and knowledge-governance artifact, no execution claim |
| Audience | Founder, package maintainer, security architect, solution architect, governance reviewer, future plugin packager, future runtime adapter implementer, public technical reader |
| Purpose | Anchor the AISRAF solution as a canonical source package with platform-independent agents, skills, hooks, memory, and evaluation that later projects into installable plugins and hosted runtimes |
| Last accepted baseline | WP-12C-BA1_TRACEABILITY_SPINE_PASS_READY_FOR_CBG0; Test-AisrafPackage 83 PASS, 1 WARN, 0 FAIL; Test-AisrafBp12AReadiness 77 PASS, 0 FAIL; Test-AisrafRunProfile -ExecutionReady 12 PASS, 0 FAIL; bundle checksum validation passes |

## 1. Read Before Anything Else

- This document is descriptive, not executive. It does not start any work package, regenerate any output, or modify any sealed surface.
- Sealed surfaces (read-only for WP-12C-I): `prompts/`, `skills/`, `prototype-agents/`, `.agents/`, `.github/agents/`, `catalogs/`, `blueprints/`, `templates/`, `samples/`, `runs/RUN-001/`.
- Local-only: `.claude/` (git-excluded; the BP12A check `claude-excluded` enforces).
- Plugin packaging is packaged-not-installed at WP-12C-K closeout. Install testing remains deferred to WP-12C-L.
- WP-12C-L0 is next only after explicit approval; WP-13 remains blocked.

## 2. Concept

### 2.1 Solution Concept

**AISRAF Local Agentic Review Workbench** — a canonical, file-based solution package that lets a founder/operator run a security architecture and solution review (SAS review) over a Data Flow Diagram (DFD) input package, produce a governed review chain (17 RS outputs + 9 DFD outputs), and hand off a scored review pack — entirely from local artifacts, with no runtime, cloud, or external post-back execution claimed.

### 2.1a BA1 Stakeholder / Scenario

A security architect receives DFD/design-review material and needs a fast, evidence-bound, shift-left review workflow. AISRAF helps that architect and the supporting solution/governance reviewers move from stated design facts to targeted questions, findings, recommendations, a handoff pack, validation notes, and evidence without claiming facts or integrations that were not observed.

### 2.2 Future Surfaces (Defined Once, Projected Many)

The same canonical package is the source of truth for three downstream surfaces, in order:

1. **AISRAF Local Agentic Review Workbench** — current; founder/operator runs the chain locally with Copilot/Claude as the chat surface.
2. **AISRAF Installable Copilot Plugin** — packaged-not-installed after WP-12C-K; thin projection bundle of agents, skills, hooks, prompts, templates, catalogs, blueprints, and selected validators, wrapping the canonical package without rewriting it. Install validation remains deferred to WP-12C-L.
3. **AISRAF Microsoft Agent Framework / Azure AI Foundry Runtime** — later; hosted runtime adapter surface, again wrapping the canonical package.

The plugin is a projection. The hosted runtime is a projection. Neither becomes the source of truth.

## 3. Value Outcome

Faster, traceable, governed security-review outputs: questions, findings, recommendations, handoff pack, validation notes, and evidence. A SAS reviewer receives a governed, traceable, scored AISRAF review pack for a given DFD input package, with:

- Every finding traced to a canonical skill, prompt, and adapter.
- Every recommendation traced to an upstream finding and a blueprint match (or `match=unknown`).
- Every score traced to declared scoring conditions, never inflated.
- Zero invented inputs, zero invented controls, zero claimed external execution.
- All evidence reproducible from canonical assets and a versioned run profile.

## 4. Operating Law

```
Concept
  -> Stakeholder / Scenario
    -> Value Outcome
      -> Value Stream / Stage
        -> Capability
          -> ProcessFlowSpecification
            -> TaskFlowSpecification
              -> Agent Specification
                -> Skill Contract
                  -> Tool / Hook / Policy
                    -> Knowledge / Data Product Contract
                      -> Memory / State
                        -> Evaluation / Metrics
                          -> Evidence
                            -> Platform Projection
                              -> Plugin
                                -> Solution Package / Release
```

Rules applied here:

- No scenario without a named stakeholder and value outcome.
- No PFS or TFS as runtime truth; they are design-time specifications only.
- No agent without a capability.
- No skill without a reusable task contract.
- No hook without a lifecycle event and enforcement purpose.
- No tool, hook, or policy as a business spec; they are enforcement surfaces.
- No knowledge or data product without a governed home and ownership rule.
- No MCP tool or future adapter without owner, permission, and data classification.
- No memory without scope, retention, and privacy rule.
- No plugin without a canonical source package.
- No release without evidence.

### 4.1 BA1 Traceability Spine Table

| Spine Layer | AISRAF Meaning | Current File/Folder Home | Design-Time or Runtime | Owner Agent / Work Package | Release Evidence | Current Status / Gap |
|---|---|---|---|---|---|---|
| Concept | Local agentic security architecture review workbench for DFD/design-review packages | `PROTOTYPE-CHARTER.md`; this document | Design-time | WP-12C-BA1 / package maintainer | Architecture alignment document | Explicit; current package is a strong pre-release prototype / local workbench package |
| Stakeholder / Scenario | Security architect receives DFD/design-review material and needs a fast, evidence-bound, shift-left review workflow | This document; `package-12c-qa-agent-spec.md` audience model | Design-time | WP-12C-BA1 | This BA1 section | Explicit |
| Value Outcome | Faster, traceable, governed security-review outputs: questions, findings, recommendations, handoff pack, validation notes, and evidence | This document; output templates; expected baselines | Design-time outcome, runtime evidence when executed | PRA-01..08 chain | RUN evidence, validation notes, QA reports | Explicit |
| Value Stream / Stage | Intake design package -> extract DFD/design facts -> identify trust boundaries and data flows -> generate missing facts and targeted questions -> classify findings -> recommend controls -> build handoff pack -> validate and hand off | This document; `prompts/`; `templates/output/`; `validation/` | Design-time flow, runtime outputs when executed | PRA-01..08 | Run log, 17 RS outputs, 9 DFD outputs, validator transcripts | Explicit |
| Capability | `CAP-AISRAF-SECURITY-REVIEW-WORKBENCH`; package QA capability `CAP-AISRAF-PACKAGE-QA` is outside the review chain | This document; traceability register; QA spec | Design-time | WP-12C-I / WP-12C-QA0 / WP-12C-BA1 | Traceability register and QA spec | Explicit; QA remains package governance, not PRA-01..08 |
| ProcessFlowSpecification | `PFS-AISRAF-SAS-REVIEW-CHAIN`; package QA PFS is planned outside the chain | This document; traceability register; QA spec | Design-time only | WP-12C-I / WP-12C-QA0 | PFS rows and validator references | Explicit; no runtime process engine claimed |
| TaskFlowSpecification | TFS-00..06 map stages to agent-owned outputs; `TFS-QA0-PACKAGE-QA` is plan-only outside PRA-01..08 | This document; traceability register; QA spec | Design-time only | PRA-01..08 specs; QA0 spec | TFS table and per-agent rows | Explicit; RUN folders are not TFS specs |
| Agent Specification | PRA-01..08 are the AISRAF security-review chain; QA/editor/release agents are package-governance agents outside PRA-01..08 | `prototype-agents/`; `.agents/`; `.github/agents/`; validation QA specs | Design-time agent specs and projections | BP06, WP-12C-H/I/QA0 | Agent registry, projection checks, role smoke | Explicit |
| Skill Contract | Canonical reusable skill contracts remain under `skills/`; provider skills are projections only | `skills/`; `.github/skills/`; `.copilot-skills/` | Design-time contract, invoked during local workbench use | BP05 / WP-12C-H | Skill registry, provider discovery, role smoke | Explicit |
| Tool / Hook / Policy | Validators, hook scripts, provider hook config, and policies enforce boundaries; they are not business specifications | `tools/`; `tools/hooks/`; `.github/hooks/`; `validation/no-drift-rules.md` | Local enforcement and evaluation surface | Tool/hook owners / WP-12C | Validator outputs, hook checks, precommit checks | Explicit |
| Knowledge / Data Product Contract | Catalogs are controlled vocabulary; blueprints are reusable review patterns, not findings or templates; templates are output shape contracts; schemas, run profiles, and evidence are governed data contracts | `catalogs/`; `blueprints/`; `templates/`; `config/`; `runs/`; `validation/` | Primarily design-time; run/evidence artifacts are runtime state | BP07-BP12 / governance reviewers | Catalog/blueprint/template validators and run-profile checks | Explicit; no catalog or blueprint edit in BA1 |
| Memory / State | No agent-side memory; state lives in run-scoped files. `RUN-001` and `RUN-SMOKE-*` are runtime evidence/state only, not specifications | `runs/RUN-001/`; `runs/RUN-SMOKE-*`; operator chat session; `.claude/` local-only | Runtime evidence/state | Operators / BP11 / WP-12C-L gates | Run profile validator, git hygiene, known-warning register | Explicit; smoke folders remain excluded until L3 |
| Evaluation / Metrics | Validators, role smoke, hook checks, controlled-output smoke, QA report, and release blocker register | `tools/Test-Aisraf*.ps1`; `validation/*checklist.md`; QA report paths | Evaluation-time | Package QA / maintainers | PASS/WARN/FAIL counts, QA report, blocker register | Explicit |
| Evidence | RUN fixture evidence, validator transcripts, bundle checksum manifest, QA/manual test evidence, release-safety records | `runs/`; `validation/`; `plugins/aisraf-copilot-plugin/bundle-checksum-manifest.yaml`; future `release/` | Runtime/evidence | PRA owners, QA agent, release owner | 0 FAIL validators, checksum pass, blocker register | Explicit |
| Platform Projection | Copilot projections are current; Copilot plugin is the current packaged projection; future adapters remain deferred | `.agents/`; `.github/agents/`; `.github/skills/`; `.github/hooks/`; `.copilot-skills/`; `plugins/` | Projection surface | WP-12C-H/K | Projection matrix, checksum manifest, plugin tests | Explicit |
| Plugin | Installable/projection surface: package assets projected into `plugins/aisraf-copilot-plugin/` with manifest and checksum evidence | `plugins/aisraf-copilot-plugin/` | Projection/package surface, not canonical source | WP-12C-K | Bundle checksum validation; plugin test card | Current plugin package exists; install/smoke remains deferred to WP-12C-L |
| Solution Package / Release | Governed publication package with manifest, docs, QA, staging, and public-safety evidence | `release/`; future docs/release gates; manifest | Release-time governance | WP-12C-L3 / REL / future WP-14/WP-15 | QA report, blocker register, staging evidence, public-safety evidence | Deferred; no publication action in BA1 |

### 4.2 BA1 Boundary Confirmations

- PFS and TFS are design-time specifications only. They describe the intended review chain and do not prove that a runtime process engine exists.
- `RUN-001` and `RUN-SMOKE-*` folders are runtime evidence/state only. They are not PFS, TFS, agent, skill, catalog, blueprint, or template specifications.
- PRA-01..08 remain the AISRAF security-review chain. QA, editor, primer, release, and future package-governance agents remain outside PRA-01..08.
- Canonical skills remain under `skills/`. Provider skills under `.github/skills/` and `.copilot-skills/` remain projections that reference canonical skills.
- Tools, hooks, and policies are enforcement surfaces. They validate, block, report, or score; they do not define the business architecture.
- Catalogs are controlled vocabulary. Blueprints are reusable review patterns, not findings and not templates. Templates are output shape contracts.
- Catalogs, blueprints, templates, schemas, run profiles, run evidence, validation checklists, QA reports, blocker registers, and checksum manifests are governed knowledge/data product contracts.
- Evaluation includes package validators, BP12A readiness, RUN-001 readiness, role smoke, hook checks, controlled-output smoke, package QA report, and release blocker register.
- Platform projection includes the Copilot local/provider projections and the current Copilot plugin package. Jira, Confluence, Lucidchart, MCP, Claude runtime, Azure AI Foundry, Google ADK, Microsoft Agent Framework, database, Terraform, cloud runtime, and external post-back adapters remain deferred future adapters only.
- Plugin and release remain separate: plugin means installable/projection surface; release means a governed publication package with manifest, docs, QA, staging, and public-safety evidence.

## 5. Capability

| Field | Value |
|---|---|
| capability_id | `CAP-AISRAF-SECURITY-REVIEW-WORKBENCH` |
| capability_name | AISRAF Security & Solution Architecture Review Workbench |
| value_outcome | Governed, traceable, scored SAS review pack delivered from a DFD input package, with zero invented inputs and zero claimed external execution |
| primary_user | SAS reviewer (consumer of the pack); founder/operator (driver of the chain) |
| owning_package | `aisraf-sas-prototype-v0.1.2` |
| canonical_source_root | repository root of `AISRAF- SAS Prototype v0.1.2` |
| status | active |

Package/release QA is intentionally separate:

| Field | Value |
|---|---|
| capability_id | `CAP-AISRAF-PACKAGE-QA` |
| capability_name | AISRAF Package QA |
| value_outcome | Governed package-readiness verdict, gap register, release blocker register, and evidence capture for the package itself |
| chain_boundary | Outside PRA-01..08; does not generate review findings, recommendations, AAL classifications, or blueprint matches |
| source_document | `validation/package-12c-qa-agent-spec.md` |
| status | planned package-governance capability; not registered as a PRA |

## 6. ProcessFlowSpecification

| Field | Value |
|---|---|
| pfs_id | `PFS-AISRAF-SAS-REVIEW-CHAIN` |
| pfs_name | AISRAF SAS Review Chain |
| owning_capability | `CAP-AISRAF-SECURITY-REVIEW-WORKBENCH` |
| trigger | Operator selects an AISRAF agent in Copilot Chat / Claude / future runtime, supplies an `input_root`, and confirms a `run_profile` |
| outcome | Governed RUN folder containing 17 RS outputs + 9 DFD outputs + run-log + scoring band |
| sub_flows | 7 TaskFlowSpecifications, see §7 |
| stop_signal | Any sealed-surface change, any unauthorized write, any FAIL from `Test-AisrafPackage.ps1` or `Test-AisrafBp12AReadiness.ps1`, any external execution claim |

## 7. TaskFlowSpecifications

| TFS ID | Name | Owns Outputs Under `runs/{{run_id}}/` | Owning Agent |
|---|---|---|---|
| `TFS-00-ORCHESTRATE-REVIEW` | Orchestrate Review | `00-run-log.md` | AISRAF Orchestrator |
| `TFS-01-READ-INPUT-PACKAGE` | Read Input Package | `01-input-inventory.md` | AISRAF Input Reader |
| `TFS-02-EXTRACT-DFD-FACTS` | Extract DFD Facts | `02-visible-dfd-objects.md`, `03-legend-normalization.md`, `04-components.md`, `05-flows.md`, `dfd/01..09-*.md` | AISRAF DFD Extractor |
| `TFS-03-BUILD-REVIEW-TABLE` | Build Review Table | `06-boundaries.md`, `07-security-stack-assessment.md`, `08-internal-review-table.md` | AISRAF Review Table Builder |
| `TFS-04-GENERATE-BLUEPRINT-QUESTIONS` | Generate Blueprint Questions | `09-missing-facts.md`, `10-ai-action-level.md`, `11-blueprint-match.md`, `12-targeted-questions.md` | AISRAF Blueprint Questioner |
| `TFS-05-WRITE-FINDINGS-AND-RECOMMENDATIONS` | Write Findings and Recommendations | `13-findings.md`, `14-recommendations.md` | AISRAF Finding Recommender |
| `TFS-06-BUILD-HANDOFF-QA-AND-SCORE` | Build Handoff QA and Score | `15-handoff-pack.md`, `16-validation-notes.md`, `17-accuracy-score.md` | AISRAF Handoff QA Scorer |

Each TFS is owned by exactly one agent. Each output is owned by exactly one TFS. The Orchestrator does not write any output beyond the run-log; PRA-01 Stop Conditions enforce this.

## 8. Agent Map

| Agent | Canonical Adapter | Canonical PRA | Owns TFS |
|---|---|---|---|
| AISRAF Orchestrator | `.agents/aisraf-orchestrator.agent.md` | `prototype-agents/PRA-01-SAS-REVIEW-ORCHESTRATOR.md` | TFS-00 |
| AISRAF Input Reader | `.agents/aisraf-input-reader.agent.md` | `prototype-agents/PRA-02-INPUT-READER.md` | TFS-01 |
| AISRAF DFD Extractor | `.agents/aisraf-dfd-extractor.agent.md` | `prototype-agents/PRA-03-DFD-EXTRACTOR.md`, `PRA-04-LEGEND-NORMALIZER.md` | TFS-02 |
| AISRAF Review Table Builder | `.agents/aisraf-review-table-builder.agent.md` | `prototype-agents/PRA-05-REVIEW-TABLE-BUILDER.md` | TFS-03 |
| AISRAF Blueprint Questioner | `.agents/aisraf-blueprint-questioner.agent.md` | `prototype-agents/PRA-06-BLUEPRINT-QUESTIONER.md` | TFS-04 |
| AISRAF Finding Recommender | `.agents/aisraf-finding-recommender.agent.md` | `prototype-agents/PRA-07-FINDING-RECOMMENDER.md` | TFS-05 |
| AISRAF Handoff QA Scorer | `.agents/aisraf-handoff-qa-scorer.agent.md` | `prototype-agents/PRA-08-HANDOFF-QA-SCORER.md` | TFS-06 |

All agent specs are platform-independent. Provider projections under `.github/agents/` are byte-identical and remain projections.

## 9. Skill Map

Every agent reuses canonical skills under `skills/rs/` (17 contracts) and `skills/dfd/` (9 contracts). The provider Agent Skills packages under `.github/skills/<skill-id>/SKILL.md` and the local wrappers under `.copilot-skills/aisraf-*.skill.md` are thin Copilot-discoverable projections — they reference, never duplicate, canonical skill bodies.

| Wrapper Skill | Wraps PRA(s) | References Canonical Skills |
|---|---|---|
| `aisraf-orchestration` | PRA-01 | none (orchestration owns no skill body) |
| `aisraf-input-read` | PRA-02 | `skills/rs/SK-INPUT-PACKAGE-READ.md` |
| `aisraf-dfd-extraction` | PRA-03 + PRA-04 | `skills/rs/SK-DFD-VISUAL-READ.md`, `SK-LEGEND-NORMALIZE.md`, `SK-COMPONENT-EXTRACT.md`, `SK-FLOW-EXTRACT.md`, `SK-BOUNDARY-CROSSING-DETECT.md`, `skills/dfd/SK-DFD-0[1-9]-*.md` |
| `aisraf-review-table-build` | PRA-05 | `skills/rs/SK-BOUNDARY-CROSSING-DETECT.md`, `SK-SECURITY-STACK-ASSESS.md`, `SK-DATA-FLOW-TABLE-BUILD.md` |
| `aisraf-blueprint-questioning` | PRA-06 | `skills/rs/SK-MISSING-FACT-IDENTIFY.md`, `SK-AI-ACTION-LEVEL-CLASSIFY.md`, `SK-REVIEW-BLUEPRINT-MATCH.md`, `SK-TARGETED-QUESTION-GENERATE.md` |
| `aisraf-finding-recommendation` | PRA-07 | `skills/rs/SK-FINDING-CLASSIFY.md`, `SK-RECOMMENDATION-WRITE.md` |
| `aisraf-handoff-qa-score` | PRA-08 | `skills/rs/SK-HANDOFF-PACK-BUILD.md`, `SK-VALIDATION-NOTE-WRITE.md`, `SK-ACCURACY-SCORE.md` |

## 10. Tool / MCP Map

Today the canonical package uses local PowerShell tooling only:

| Tool | Purpose | Owner | Permission | Data Classification |
|---|---|---|---|---|
| `tools/Test-AisrafPackage.ps1` | Package surface validator | AISRAF maintainer | local read | repository-internal |
| `tools/Test-AisrafBp12AReadiness.ps1` | BP12A commit-readiness harness | AISRAF maintainer | local read + git read | repository-internal |
| `tools/Test-AisrafRunProfile.ps1` | Run-profile schema and execution-readiness validator | AISRAF maintainer | local read | repository-internal |
| `tools/New-AisrafRun.ps1` | Bootstrap a new governed RUN folder | AISRAF maintainer | local write to `runs/<id>/` | repository-internal |
| `tools/hooks/aisraf-allowed-path-prewrite-guard.ps1` | Block writes outside the allow-list | hook owner | local read; emits exit code | repository-internal |
| `tools/hooks/aisraf-focused-validator-postwrite.ps1` | Run focused validator after a permitted write | hook owner | local read; invokes validators | repository-internal |
| `tools/hooks/aisraf-session-stop-summary.ps1` | Emit a session summary to chat | hook owner | local read; stdout only | repository-internal |
| `tools/hooks/aisraf-precommit-full-validator.ps1` | Run BP12A readiness before commit | hook owner | local read | repository-internal |

No MCP server is shipped today. Future MCP exposure remains a deferred adapter decision and must declare owner, permission scope, and data classification before any implementation claim.

## 11. Hook / Policy Map

| Hook | Provider Event | Behavior | Falsifier |
|---|---|---|---|
| `aisraf-allowed-path-prewrite-guard` | PreToolUse / Prewrite | Block any write whose target path is not in `tools/hooks/hook-allow-list.yaml` | `Test-AisrafPackage.ps1` Check 08i + smoke test E2 in the quick manual test card |
| `aisraf-focused-validator-postwrite` | PostToolUse / Postwrite | Run the validator that owns the touched surface; FAIL is loud, PASS is silent | `Test-AisrafRunProfile.ps1` and `Test-AisrafPackage.ps1` exit codes |
| `aisraf-session-stop-summary` | Stop / session end | Emit a SUMMARY line to chat; never write a file | Quick test card row E4 |
| `aisraf-precommit-full-validator` | Local precommit (operator-installed) | Run `Test-AisrafBp12AReadiness.ps1`; FAIL aborts the commit | Quick test card row E5 |

Provider hook config: `.github/hooks/aisraf-guardrails.json` wires PreToolUse/PostToolUse/Stop to the three runtime hooks. Precommit remains an operator-local install (`.claude/`, git-excluded) by design.

## 11A. Knowledge / Data Product Contract Governance

This layer is the AISRAF knowledge/data product contract layer. It defines how governed vocabulary, reusable review patterns, output shapes, execution schemas, run profiles, evidence, and validation rules are owned, consumed, versioned, validated, and changed. It does not edit catalog or blueprint content.

| Contract Class | Definition | Governed Home | Owner / Lifecycle | Consumers | Validation Rule | Change Control |
|---|---|---|---|---|---|---|
| Catalogs | Controlled vocabulary and allowed-value contracts. Catalogs define values, evidence rules, proof-vs-signal discipline, and unknown handling; they do not compute severity, AI Action Level, score, recommendation, or blueprint match outcomes. | `catalogs/catalog-registry.yaml`; `catalogs/**/*.yaml` | Build Package 07 / governance reviewer. Current lifecycle state is `active`; future states or new values require a governed catalog update. | Prompts, skills, PRAs, adapters, blueprints, templates, validators, and reviewers. | `Test-AisrafPackage.ps1` catalog checks plus `validation/catalog-registry-checklist.md` and `validation/catalog-consumption-checklist.md`. Agents, prompts, skills, and projections must reference catalog IDs or paths and must not duplicate value sets inline. | Founder-approved work package only. Preserve `Unknown`, `Not Stated`, `Deferred`, or equivalent sentinels when source evidence is absent. |
| Blueprints | Reusable review patterns that combine catalog-governed evidence into recognizable review hypotheses. Blueprints are not findings, recommendations, output templates, owner-routing text, or implementation proof. | `blueprints/blueprint-registry.yaml`; `blueprints/blueprint-template.yaml`; `blueprints/**/*.yaml` | Build Package 08 / governance reviewer. Current lifecycle state is `active`; match-state model is registry-owned. | PRA-06, PRA-07, PRA-08, prompts, skills, adapters, templates, and validators. | `Test-AisrafPackage.ps1` blueprint checks plus `validation/blueprint-registry-checklist.md` and `validation/blueprint-catalog-consumption-checklist.md`. PRA-06 consumes blueprints by registry/template/path and does not invent blueprint states. | Founder-approved work package only. New blueprint states, new catalog dependencies, or blueprint content changes require future CBG1 or equivalent governed catalog/blueprint update. |
| Templates | Output shape contracts. Templates define required sections, placeholders, output boundaries, and prohibited content; they do not enumerate catalog values, decide blueprint match, compute AAL/severity/score, invent findings, or write recommendations by themselves. | `templates/template-registry.yaml`; `templates/**/*.md` | Build Package 09 / template owner. Current lifecycle state is `active`; shape changes require template governance. | Prompts, skills, PRAs, adapters, run operators, validators, Jira/Confluence draft formatters. | `Test-AisrafPackage.ps1` template checks plus `validation/template-registry-checklist.md` and `validation/template-consumption-checklist.md`. | Founder-approved work package only. Template changes may alter output shape, so validators and evidence expectations must be rechecked before release. |
| Schemas and run profiles | Type and execution contracts. `config/run-profile.schema.yaml` constrains run identity, output roots, execution posture, destination intent, post-back state, sensitive-data confirmation, scoring eligibility, and safe defaults. | `config/run-profile.schema.yaml`; `runs/{{run_id}}/run-profile.yaml` | Build Package 02 for schema; Build Package 11 and later run owner for run profiles. | Tools, hooks, agents, templates, validators, run operators, evidence reviewers. | `Test-AisrafRunProfile.ps1 -ExecutionReady`; BP12A readiness; schema parse and `additionalProperties: false`. | Schema changes require governed config ownership. Individual run-profile changes are run-scoped evidence changes and must not alter sealed `RUN-001` without an authorized gate. |
| Evidence and validation checklists | Proof contracts. Evidence proves what was read, written, validated, compared, or deferred. Validation checklists define falsifiable gate criteria and known-warning handling. | `validation/`; `runs/`; checksum manifests; test cards; QA reports | Build Package 12 / QA and release governance. Runtime evidence is run-owned; package evidence is validation-owned. | Package QA, maintainers, release owners, validators, plugin packagers, future auditors. | Existing validator ladder, readiness checks, checksum checks, manual test cards, gap/blocker registers. | Validation docs may be patched by authorized work packages. Evidence must remain reproducible from canonical assets and versioned run profiles. |

CBG0 confirmations:

- PRA-06 consumes blueprint files and `blueprints/blueprint-registry.yaml`; it does not invent blueprint states. Allowed match states remain the registry-defined `matched`, `candidate`, `no_match`, and `unknown`, with `match=unknown` preserved when evidence is insufficient.
- AI Action Level values must come from `catalogs/review/ai-action-level-catalog.yaml` through catalog governance and the owning skill/human review path. Inline AAL invention in agents, prompts, skills, templates, QA reports, samples, or run outputs is a governance gap.
- `Unknown`, `Not Stated`, `Deferred`, and equivalent absent-evidence values must be preserved. They are not cleaned up into optimistic values, omitted from output, or converted into implementation proof.
- Agents, prompts, skills, and provider projections must not duplicate catalog value sets. They may reference catalog IDs, catalog paths, and blueprint paths, but catalog entries remain catalog-owned.
- QA reports governance gaps only. QA does not edit catalogs, blueprints, templates, schemas, prompts, skills, agents, projections, hooks, plugin bundles, `RUN-001`, or `samples/`.
- Jira, Confluence, Lucidchart, MCP, Claude runtime, Azure AI Foundry, Google ADK, Microsoft Agent Framework, database, Terraform, cloud runtime, and external post-back remain deferred future adapters only. They do not own catalog values, blueprint states, schema fields, or evidence truth in this package.
- `AG-AISRAF-KNOWLEDGE-CURATOR-R1` is future-only. It is not active, registered, projected, or authorized in this package. It becomes relevant only if a future work package must change catalog values, blueprint states, template mappings, schema fields, lifecycle policy, or duplicated governed vocabulary across multiple surfaces.

### 11A.1 Governance Gap Register

| Gap ID | Severity | Area | Current Evidence | CBG0 Disposition | Future Trigger |
|---|---|---|---|---|---|
| CBG0-GAP-001 | info | Catalog inventory arithmetic history | `catalogs/catalog-registry.yaml` records the Package 07 count discrepancy as a compatibility note while implementing the explicit 24-catalog inventory. | Non-blocking; documented and governed by the current registry. No catalog edit in CBG0. | Future CBG1 if the founder chooses to expand or re-baseline the catalog inventory. |
| CBG0-GAP-002 | info | Blueprint-to-catalog consumer alignment | `blueprints/blueprint-registry.yaml` records compatibility notes for wider per-blueprint catalog dependencies than the upstream PR-RS-09 / SK-REVIEW-BLUEPRINT-MATCH placeholder list and PRA-06 catalog list. | Non-blocking; blueprint registry is authoritative for Package 08 blueprint consumption. No blueprint or upstream registry edit in CBG0. | Future CBG1 if the package owner wants upstream prompt/skill/PRA registry maps to mirror the blueprint registry union. |
| CBG0-GAP-003 | warning | Local smoke evidence staging | `runs/RUN-SMOKE-LOCAL-001/` exists as known local smoke evidence and must remain excluded from staging until L3. | Not a knowledge-model blocker; keep out of staging. | WP-12C-L3 staging decision. |

## 12. Memory / State Map

AISRAF deliberately uses **no agent-side memory** today. State lives entirely in:

`runs/RUN-001/` and `runs/RUN-SMOKE-*` are runtime evidence/state only. They are not business specs, PFS/TFS specs, canonical agent specs, skill contracts, catalogs, blueprints, or templates. `runs/RUN-SMOKE-*` folders are local smoke evidence and remain excluded from staging until the authorized L3 gate.

| State Layer | Scope | Retention | Privacy Rule |
|---|---|---|---|
| `runs/{{run_id}}/run-profile.yaml` | one run | persisted in repo or scratch run | repository-internal; never contains secrets |
| `runs/{{run_id}}/inputs/` | one run | persisted | review materials only; no PII required |
| `runs/{{run_id}}/00..17-*.md` and `dfd/01..09-*.md` | one run | persisted | governed evidence; sealed for `RUN-001` |
| `samples/sample-001-dfd-crop/expected/` | sealed baseline | persisted | governed baseline; refresh only via BP10A/BP12B |
| operator chat session | one chat | ephemeral | not written to disk by any AISRAF surface |
| `.claude/` local hooks/settings | local operator | persisted on operator machine | git-excluded; never staged |

No long-lived agent memory, no cross-run learning store, no telemetry beam-out.

## 13. Evaluation Map

Evaluation is layered. Each layer has an owning checklist and a falsifiable PASS criterion.

| Evaluation Layer | Owning Checklist / Tool | PASS Criterion |
|---|---|---|
| Package surface | `tools/Test-AisrafPackage.ps1` | 0 FAIL across all checks |
| Commit readiness | `tools/Test-AisrafBp12AReadiness.ps1` | 0 FAIL across all areas |
| Run profile | `tools/Test-AisrafRunProfile.ps1 -ExecutionReady` | 12 PASS, 0 FAIL |
| Discovery (Layer 1) | `validation/agent-skill-projection-checklist.md`, `hook-readiness-checklist.md` | 7 wrappers + 4 hooks visible |
| Role smoke (Layer 2) | `validation/role-smoke-test-checklist.md` | 7 PASS / 0 FAIL |
| Chat preview (Layer 3) | `validation/chat-preview-test-checklist.md` | 7 PASS / 0 FAIL |
| Sample input/output preview (Layer 3b) | `validation/package-12c-sample-input-output-test-card.md` | every row PASS |
| Controlled output (Layer 4, deferred) | `validation/package-12c-controlled-output-checklist.md` | 26 SHA-256 matches OR explicit founder-approved diff |
| Scoring / regression (Layer 5) | `validation/package-12c-regression-checklist.md` | 0 regression; baselines byte-stable |
| Operator-card usability (Layer 6) | `validation/package-12c-operator-card-usability-checklist.md` | founder verdict PASS |
| Package QA report | `validation/package-12c-qa-agent-spec.md` planned QA report contract | PASS/PARTIAL/FAIL verdict with validator counts and gap register |
| Release blocker register | QA report blocker register model | no blocker-severity item for the gate under review; known warnings named with owner and deadline |
| Plugin install (Layer 7, future) | `validation/package-12c-plugin-roadmap.md` (WP-12C-L) | install succeeds, post-install discovery + smoke + hook passes |
| Bring-your-own-DFD intake (Layer 8, deferred) | future BP12D or post-BP13 | governed `runs/RUN-XXX/` produced |

## 14. Evidence Map

| Evidence Class | Location | Owner | Falsifier |
|---|---|---|---|
| Sealed baseline outputs | `samples/sample-001-dfd-crop/expected/*.md` | sample maintainer | byte-stability check; BP10A approval gates |
| Governed run outputs | `runs/RUN-001/00..17-*.md`, `runs/RUN-001/dfd/01..09-*.md` | RUN-001 owner | byte-stability check; BP12B post-execution closure |
| Run profile | `runs/RUN-001/run-profile.yaml` | RUN-001 owner | `Test-AisrafRunProfile.ps1 -ExecutionReady` |
| Run log | `runs/RUN-001/00-run-log.md` | Orchestrator (PRA-01) | run-log checklist |
| Package validator transcripts | manual capture per test card | operator | exit code 0 + `0 FAIL` summary |
| Manual test evidence | `validation/package-12c-quick-manual-test-card.md` evidence worksheet, `package-12c-sample-input-output-test-card.md` evidence worksheet | operator/founder | per-row PASS/FAIL/PROVIDER LIMITATION marks |

## 15. Platform Projection Map

Canonical source of truth (do not project-out):

- `skill-registry.yaml`, `prompt-registry.yaml`, `prototype-agent-registry.yaml`
- `prompts/`, `skills/`, `prototype-agents/`, `templates/`, `catalogs/`, `blueprints/`
- `runs/RUN-001/run-profile.yaml`
- `validation/`, `tools/Test-*.ps1`, `tools/hooks/`

Provider projections (every file references canonical paths only; no canonical body is duplicated):

| Provider | Projection Surface | Status |
|---|---|---|
| GitHub Copilot (VS Code) — agents | `.github/agents/aisraf-*.agent.md` | present, 7 files, byte-identical to `.agents/` |
| GitHub Copilot — Agent Skills packages | `.github/skills/<skill-id>/SKILL.md` | present, 7 packages |
| GitHub Copilot — provider hook config | `.github/hooks/aisraf-guardrails.json` | present, 1 file, calls `tools/hooks/*.ps1` |
| Local operator skill wrappers | `.copilot-skills/aisraf-*.skill.md` + `.copilot-skills/aisraf-*.operator-card.md` + `.copilot-skills/README.md` | present, 7 + 7 + 1 files |
| Reusable hook implementation | `tools/hooks/aisraf-*.ps1` + `hook-allow-list.yaml` + `README.md` | present, 4 + 1 + 1 files |
| Claude (local) | `.claude/settings.json`, `.claude/hooks/` | git-excluded; not authored by AISRAF; operator-local only |
| Installable Copilot Plugin | packaged projection; install validation deferred | WP-12C-K package complete; bundle checksum validation passes; see `validation/package-12c-plugin-roadmap.md` |
| Future Jira / Confluence / Lucidchart adapters | not authored | deferred future adapters only; no integration claim |
| Future MCP / Claude runtime adapter | not authored | deferred future adapters only; no runtime claim |
| Future Microsoft Agent Framework runtime adapter | not authored | deferred future adapter only; strategy, no implementation |
| Future Azure AI Foundry deployment adapter | not authored | deferred future adapter only; strategy, no implementation |
| Future Google ADK adapter | not authored | deferred future adapter only; optional strategy, no implementation |
| Future database / Terraform / cloud runtime adapters | not authored | deferred future adapters only; no deployment claim |

## 16. Release Gate Summary

| Gate | Status | Owning Work Package |
|---|---|---|
| BP12B — post-execution governance closure | closed | WP-12B |
| WP-12C-D — adapter & provider discovery alignment | closed | WP-12C-D |
| WP-12C-E — interactive operator test harness (static) | closed; manual evidence pending | WP-12C-E |
| WP-12C-F — cross-provider runtime adapter strategy | strategy only; not implementing | WP-12C-F |
| WP-12C-H — Copilot skill format repair + Chat/CLI test harness | provider surfaces present; manual evidence pending | WP-12C-H |
| WP-12C-I — solution package architecture & agent specification alignment | this document set | WP-12C-I |
| WP-12C-J — sample preview & controlled scratch output validation | closed | WP-12C-J |
| WP-12C-K4 — plugin manifest schema, lint, and checksum validation | closed: `WP-12C-K4_PLUGIN_PACKAGE_VALIDATION_PASS_READY_FOR_INSTALL_TESTING` | WP-12C-K4 |
| WP-12C-K — Copilot plugin packaging | package complete: `WP-12C-K_PACKAGE_COMPLETE_READY_FOR_INSTALL_READINESS_PREFLIGHT` | WP-12C-K |
| WP-12C-L0 — install readiness preflight | next after explicit approval; no install or interactive smoke | WP-12C-L0 |
| WP-12C-L1/L2/L3 — install, post-install smoke, publication readiness | blocked | WP-12C-L |
| WP-13 — diagram & release view pack | blocked until WP-12C-L passes | WP-13 |

## 17. Reference Alignment

This document does not adopt any external standard wholesale. The references below are read for **discipline of shape**, not for runtime, certification, or execution claims. AISRAF remains a local, file-based, specification-driven solution package; no TM Forum, Microsoft Agent Framework, Azure AI Foundry, Google ADK, MCP server, runtime, cloud, or release post-back execution is claimed.

| Reference | Read As | Where Applied In This Document |
|---|---|---|
| IG1277 (Concept / Value / Capability discipline) | Concept → Value Outcome → Capability → Process → Agent → Skill → Evidence trace must be unbroken | §2 Concept, §3 Value Outcome, §5 Capability, §6 PFS, §7 TFS, §8 Agent Map, §9 Skill Map, §14 Evidence Map |
| TMF701 (Process Flow API — design-time vs runtime separation) | Design-time = `ProcessFlowSpecification` + `TaskFlowSpecification`; runtime = `ProcessFlow` + `TaskFlow`; AISRAF today exposes design-time only, with `runs/RUN-001/` and `runs/RUN-SMOKE-LOCAL-XXX/` standing in for the runtime side without claiming a runtime engine | §6 PFS, §7 TFS, §12 Memory / State Map (run-scoped files only), §17 Stop Conditions (no runtime/cloud claim) |
| IG1412 (AI Agent Specification Template — platform independence) | Agent specs must be reusable, testable, interoperable, and provider-neutral; one canonical adapter projects to many providers | §8 Agent Map, §9 Skill Map, §15 Platform Projection Map, and the companion `package-12c-agent-spec-template.md` |
| IG1251D (AN Agent Architecture concepts) | Reactive vs proactive behavior, memory scope, human-agent + agent-agent interaction, automation vs autonomy. AISRAF today is **reactive + assistive only**, with `chat-preview-only` and (after explicit founder approval) `controlled-write-on-approval`; no autonomous behavior is claimed and no agent-side memory is used | §11 Hook / Policy Map, §12 Memory / State Map, §13 Evaluation Map autonomy levels |
| GB1087 (Agentic Interaction Security method) | Choose security domain → identify agent types → define interactions → select risks → map controls → operationalize checklists → place controls → monitor. AISRAF applies this only to its **local workbench** domain; controls are file-system + hook + validator level, not network/identity/runtime | §10 Tool / MCP Map (no MCP shipped), §11 Hook / Policy Map (4 hooks with falsifiers), §13 Evaluation Map, §17 Stop Conditions |
| IG1500 (AN L4 Solution Package Template shape) | A solution package release artifact has scenario, objectives, AN L4 evolution + key features, architecture, interaction flow, lessons learned, and standard requirements. AISRAF today produces an alignment-grade architecture document, not a release pack; an IG1500-shaped release pack is deferred to WP-14 (see `package-12c-plugin-roadmap.md`) | §1 Read Before Anything Else (this document is alignment, not release), §16 Release Gate Summary (WP-14 deferred) |

Applied honestly: every reference is read for shape only. None of these references is claimed as compliance, certification, or runtime conformance.

## 18. Stop Conditions

- Any sealed surface change.
- Any provider projection that copies a canonical body instead of referencing a canonical path.
- Any plugin packaging attempt before WP-12C-K is open.
- Any external execution claim (runtime/cloud/MCP/ADK/Microsoft Agent Framework/Azure AI Foundry/Google ADK/Jira/Confluence/Rovo/database/Terraform/release post-back).
- Any FAIL from `Test-AisrafPackage.ps1`, `Test-AisrafBp12AReadiness.ps1`, or `Test-AisrafRunProfile.ps1 -ExecutionReady`.

## 19. Acceptance Verdict

`WP-12C-I_ARCHITECTURE_ANCHOR_PASS` when:

- This document plus the four sibling artifacts (`package-12c-agent-spec-template.md`, `package-12c-capability-agent-traceability-register.md`, `package-12c-platform-projection-matrix.md`, `package-12c-plugin-roadmap.md`) exist.
- The validator allow-list extension is the only `tools/` change.
- All three validators run with `0 FAIL`.
- Founder reviews and accepts the architecture without sealed-surface drift.
