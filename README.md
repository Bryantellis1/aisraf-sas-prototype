# AISRAF SAS Prototype v0.1.2

AISRAF SAS means AISRAF Security Advisory Services. This package is a local-first security advisory review prototype for testing how VS Code, GitHub Copilot, prompt cards, skill contracts, PRA specifications, local adapter wrappers, catalogs, blueprints, templates, samples, run profiles, validation checks, diagrams, and practitioner documentation work together.

## v0.1.2 Release — Read First

AISRAF v0.1.2 proves AM3 / AL3 local orchestrated multi-agent runtime evidence. AM3 evidence is local-only, human-gated, validator-backed, and evidence-bound. This is an evidence-path claim, not a claim of full specialist-generated review output execution, production readiness, publication, or AM4 integration.

Gate state: AM3 stage commit is closed at `34c1d55ce79e6bb0f9f274bef335af42600ef3f7`. REL0 final QA ran and found remediation blockers. The current gate is **WP-12C-REL0-FINAL-QA-REMEDIATION**; next is REL0 final QA rerun / release decision. WP-13, AM4, push, and publish remain blocked until the REL0 release decision closes.

The day-to-day security architect and application architect experience remains a local controlled-output workbench under VS Code + GitHub Copilot. AISRAF runs against governed prompt cards, skill contracts, prototype-agent specifications, catalogs, blueprints, templates, samples, and run profiles. It does not execute external adapters and does not post back to Jira, Confluence, Lucidchart, Rovo, MCP, Azure AI Foundry, Google ADK, Microsoft Agent Framework, databases, Terraform, cloud runtimes, event buses, or telemetry systems.

Public reader entrypoints (read these first):

- [docs/AISRAF-PRIMER.md](docs/AISRAF-PRIMER.md) — evaluator primer; what AISRAF is, what it is not, autonomy posture (AL2 workbench experience; AM3 / AL3 local runtime evidence proven; AM4 deferred; AL5 out of scope).
- [docs/OPERATOR-QUICKSTART.md](docs/OPERATOR-QUICKSTART.md) — operator quickstart for local controlled-output review.
- [docs/SECURITY-REVIEW-WORKFLOW.md](docs/SECURITY-REVIEW-WORKFLOW.md) — security architect's end-to-end review workflow.
- [docs/ARCHITECTURE-OVERVIEW.md](docs/ARCHITECTURE-OVERVIEW.md) — maintainer architecture overview.
- [docs/ROADMAP.md](docs/ROADMAP.md) — release roadmap (v0.1.2 AM3 evidence claim; WP-13 release visuals blocked; AM4 adapters future).
- [RELEASE-MANIFEST.yaml](RELEASE-MANIFEST.yaml) — machine-readable release manifest.
- [CHANGELOG.md](CHANGELOG.md) — release changelog.

Release journey modes and autonomy posture:

| Mode | v0.1.2 status |
|---|---|
| Mode 0 - read/preview, no writes | Current preview path. The operator may inspect roles, prompts, run profiles, planned outputs, manifests, and evidence without changing files. |
| Mode 1 - AL2 controlled-output workbench | Current everyday practitioner UX for security architects and application architects. Outputs are governed local Markdown files under an approved run folder. |
| Mode 2 - AM3 / AL3 local orchestrated runtime evidence | Current release-visible local runtime journey/proof path. AISRAF Orchestrator owns run-state and event log; AM3-01 through AM3-06 specialist handoffs and human gates are represented under local-only smoke evidence. |
| Mode 3 - maintainer validation and release QA | Current maintainer path for validators, bundle checksum checks, manifests, blocker registers, and QA reports. It does not generate practitioner review outputs. |
| Mode 4 - AM4 external adapter / post-back execution | Future only. Jira, Confluence, Lucidchart, Rovo, MCP, cloud, database, Terraform, event bus, telemetry, and external post-back execution are not implemented in v0.1.2. |

AL5 closed-loop autonomy is out of scope for v0.1.2 and the v0.1.x line.

Current autonomy posture details:

- **AL2 — controlled-output local workbench (current user experience).** Practitioner-driven prompt/skill execution in VS Code; outputs are governed Markdown under `runs/{run_id}/`.
- **AM3 / AL3 — local orchestrated multi-agent runtime evidence (proven evidence path).** AISRAF Orchestrator owns run-state and event log. Specialist handoffs are represented by AM3-01 through AM3-06 request/response pairs. Human gates remain required. The accepted smoke evidence is under local-only `runs/RUN-SMOKE-AM3-001/runtime/` and must not be staged or published in this gate.
- **AM4 / AL4 — external adapter / post-back execution (Jira, Confluence, Lucidchart, Rovo, MCP, Foundry, ADK, MAF, database, Terraform, cloud, event bus, telemetry).** Future adapter work. Not current release behavior.
- **AL5 — closed-loop autonomy.** Out of scope for v0.1.2 and the v0.1.x line.

The next governed Build Package, **Build Package 13 — Diagrams (release visuals)**, is **BLOCKED** until WP-12C-REL0 closes (founder-authorized public release gate) and the carried-forward `BP12-SAMPLE-DFD-BLOCKER` is resolved per [validation/diagram-readiness-pre-render-checklist.md](validation/diagram-readiness-pre-render-checklist.md).

## Purpose

The prototype lets a practitioner test security-review methods locally before any runtime, cloud, MCP, or release layer is claimed. A user stages a DFD and supporting notes in a local run folder, uses governed instructions to read from `input_root`, writes structured outputs only under `output_root`, and compares against `expected_root` when baselines exist.

## Practical Value

The package is designed to test prompts, skills, adapters, DFD extraction, structured review outputs, validation, and handoff patterns locally. Later packages will add the artifacts needed to produce input inventories, visible objects, components, flows, boundaries, review tables, missing facts, AI Action Level, blueprint matches, questions, findings, recommendations, handoff packs, validation notes, and accuracy scores.

## Contributor / Governance Reading

The sections below describe the internal governed build sequence (Build Packages 01–12 plus the BP12C operator-experience and packaging increments). They are kept for contributors and governance reviewers; public readers should start from the docs/ entrypoints above.

## Current State

Build Packages 01–12 are governed and validator-green. BP12C operator-experience and plugin-packaging increments through WP-12C-REL0-B are committed. WP-12C-AM3-QA accepted only the bounded local runtime evidence claim, and the AM3 stage commit is closed at `34c1d55ce79e6bb0f9f274bef335af42600ef3f7`. REL0 final QA ran and returned `WP-12C-REL0_FINAL_QA_BLOCKED_WITH_REASON`; the active gate is **WP-12C-REL0-FINAL-QA-REMEDIATION**. Next is REL0 final QA rerun / release decision. WP-13 release visuals, WP-13-dependent publication preparation, AM4 adapter work, push, and publish remain blocked / future until REL0 release decision closes.

- **Build Package 01** — Foundation, root structure, charter, manifest, folder contracts, build order, and authoring-agent instruction standard.
- **Build Package 02** — Config and run-profile variable model (`config/`).
- **Build Package 03** — Tools and setup/test/export scripts (`tools/`).
- **Build Package 04** — Prompts and prompt registry (`prompts/`): 23 canonical prompt cards (14 RS, 9 DFD) plus [prompts/prompt-registry.yaml](prompts/prompt-registry.yaml).
- **Build Package 05** — Skills and skill registry (`skills/`): 26 canonical skill contracts (17 RS, 9 DFD) plus [skills/skill-registry.yaml](skills/skill-registry.yaml). Each skill contract wraps one Build Package 04 prompt card with a 14-section reusable work contract.
- **Build Package 06** — Prototype agents, PRA specs, and `.agent.md` adapter model (`prototype-agents/`, `.agents/`): 8 canonical Prototype Review Agent specs (PRA-01..PRA-08) plus [prototype-agents/prototype-agent-registry.yaml](prototype-agents/prototype-agent-registry.yaml), and 7 thin local `.agent.md` adapter wrappers under [.agents/](.agents/) (orchestrator, input-reader, dfd-extractor, review-table-builder, blueprint-questioner, finding-recommender, handoff-qa-scorer). PRA-04-LEGEND-NORMALIZER has no dedicated adapter; it is wrapped jointly with PRA-03 by [.agents/aisraf-dfd-extractor.agent.md](.agents/aisraf-dfd-extractor.agent.md). PRAs and adapters are specifications/wrappers, not deployed runtime agents.
- **Build Package 07** — Catalogs (`catalogs/`): 24 controlled-vocabulary YAML catalogs across 7 families (components, interactions, boundaries, identity-access, data-protection, security-stacks, review) plus [catalogs/catalog-registry.yaml](catalogs/catalog-registry.yaml) and 8 READMEs. Two catalogs are cross-cutting: [catalogs/security-stacks/proof-vs-signal-rule-catalog.yaml](catalogs/security-stacks/proof-vs-signal-rule-catalog.yaml) (`global_rule: true`) and [catalogs/data-protection/confidence-level-catalog.yaml](catalogs/data-protection/confidence-level-catalog.yaml) (`cross_cutting_catalog: true`). Catalogs are read-only at runtime; they are not executable tools, runtime services, blueprints, prompts, skills, agent logic, or runbooks. Build Package 07 did not modify any prompt, skill, prototype-agent, or adapter registry.
- **Build Package 08** — Blueprints (`blueprints/`): 9 controlled YAML blueprints split across two category folders (8 under [blueprints/platform-independent/](blueprints/platform-independent/) and 1 under [blueprints/cloud-patterns/](blueprints/cloud-patterns/)) plus [blueprints/blueprint-registry.yaml](blueprints/blueprint-registry.yaml), [blueprints/blueprint-template.yaml](blueprints/blueprint-template.yaml), and 3 READMEs (14 files total). Match states are fixed at four values: `matched`, `candidate`, `no_match`, `unknown`. Each blueprint references Build Package 07 catalog identifiers only; no new catalog values are introduced. Blueprints scope catalog evidence and surface material missing facts; selection of severity, AI Action Level, finding categories, recommendation types, and final disposition is owned by the consuming Build Package 05 skills and human review. Build Package 08 did not modify any prompt, skill, prototype-agent, adapter, or catalog registry.
- **Build Package 09** — Templates (`templates/`): 31 reusable Markdown output-shape templates across 4 family folders (27 under [templates/output/](templates/output/), 1 under [templates/jira/](templates/jira/), 1 under [templates/confluence/](templates/confluence/), 2 under [templates/run/](templates/run/)) plus [templates/template-registry.yaml](templates/template-registry.yaml) and 5 READMEs (37 files total). Templates define output shape only; they do not execute the review, do not compute severity / score / AI Action Level / blueprint match, do not invent finding facts or recommendation prose, and do not claim Jira / Confluence / Rovo / MCP / runtime / cloud / ADK / database / Terraform execution. Templates use only the seven approved run-profile placeholder variables; other run-profile fields are referenced descriptively as `[copy from runs/{{run_id}}/run-profile.yaml#field_name]`. Catalog values are referenced via `<value-from-catalogs/...>` placeholder syntax (no enumeration inside template bodies; founder decision Q3). Build Package 09 did not modify any prompt, skill, prototype-agent, adapter, catalog, or blueprint registry; template→prompt, template→skill, template→PRA, template→adapter, template→blueprint, and template→catalog consumer maps are recorded only in [templates/template-registry.yaml](templates/template-registry.yaml) and the validation checklists.
- **Build Package 10** — Samples and expected baselines (`samples/`): 1 active sample (`sample-001-dfd-crop` — AI SaaS Security Review Portal scenario) plus [samples/sample-registry.yaml](samples/sample-registry.yaml). Sample-001 carries 6 synthetic inputs (`inputs/dfd-crop.png`, `inputs/dfd-crop.mmd`, `inputs/dfd-legend-excerpt.md`, `inputs/cloud-triage-notes.md`, `inputs/review-transcript.md`, `inputs/intake-ticket.md`) and 26 Markdown expected baselines (17 RS mirroring `templates/output/output-01..17-*-template.md` and 9 DFD mirroring `templates/output/output-dfd-01..09-*-template.md`). `expected-00-run-log.md` is intentionally not created (founder decision Q2: run logs are run artefacts deferred to Build Package 11). Samples 002–008 are recorded as `planned_or_deferred_samples` entries inside [samples/sample-registry.yaml](samples/sample-registry.yaml) only — no folders or files (founder decision Q8). Samples are test fixtures: synthetic only, no real PII / PAN / SSN / PHI / secrets / credentials / production endpoints; no Jira post-back / Confluence publication / Rovo / MCP / runtime / cloud / ADK / Vertex / GCP / database / Terraform execution claims; no severity / finding-category / AI Action Level / blueprint-match / accuracy-score computation inside expected-baseline bodies; no new BP-* identifiers or controlled values introduced. Numeric scoring is qualitative (`PASS_READY_FOR_REVIEW`) until Build Package 11 run execution validates numeric scoring (founder decision Q5; the v0.01 reference 151/160 is recorded as `legacy_reference_score` only). Build Package 10 did not modify any prompt, skill, prototype-agent, adapter, catalog, blueprint, template, or config registry.
- **Build Package 12** — Validation framework (`validation/`): 10 new validation files standing up the full validation taxonomy (package, registry, chain, sample, run, cross-cutting, forward, final-QA gates) — [validation/package-12-validation-checklist.md](validation/package-12-validation-checklist.md), [validation/scoring-rubric-checklist.md](validation/scoring-rubric-checklist.md), [validation/package-lint-master-checklist.md](validation/package-lint-master-checklist.md), [validation/expected-output-lint-checklist.md](validation/expected-output-lint-checklist.md), [validation/prompt-skill-pra-parity-checklist.md](validation/prompt-skill-pra-parity-checklist.md), [validation/sample-input-readiness-checklist.md](validation/sample-input-readiness-checklist.md), [validation/local-run-readiness-checklist.md](validation/local-run-readiness-checklist.md), [validation/prototype-execution-readiness-checklist.md](validation/prototype-execution-readiness-checklist.md), [validation/diagram-readiness-pre-render-checklist.md](validation/diagram-readiness-pre-render-checklist.md), [validation/docs-readiness-pre-render-checklist.md](validation/docs-readiness-pre-render-checklist.md), [validation/final-qa-checklist.md](validation/final-qa-checklist.md). [validation/README.md](validation/README.md) is rebuilt as the validation taxonomy index with a top-of-file BLOCKERS section. [validation/no-drift-rules.md](validation/no-drift-rules.md) carries 14 numbered Build Package 12 amendments. `runs/RUN-001/dfd/.gitkeep` is added as a fresh-clone reservation marker (the only file permitted in that empty governed folder until DFD outputs exist). `tools/Test-AisrafPackage.ps1` carries 3 surgical patches (synopsis update, Check 08i `.gitkeep` allowance, Check 11 allow-list extension). **`BP12-SAMPLE-DFD-BLOCKER`** is recorded as a hard, named, non-silent carried-forward blocker on the canonical sample DFD (`samples/sample-001-dfd-crop/inputs/dfd-crop.png`/`.mmd` and the byte-copies under `runs/RUN-001/inputs/`); it is cross-referenced in 6 validation files plus `PACKAGE-MANIFEST.yaml` and pins Build Package 13 entry until a founder-approved Package 10A / 11A correction lands OR sample-002 with a clean DFD is authorized — see [validation/sample-input-readiness-checklist.md](validation/sample-input-readiness-checklist.md). Build Package 12 did not modify any sealed Build Package 01–11 surface, did not modify the sample DFD or its byte-copy, did not modify any expected baseline, did not create any diagram / runbook / release artefact / runtime / cloud / MCP proof, and did not author sample-002.
- **Build Package 11** — Runs and execution evidence model (`runs/`): 1 first canonical governed run fixture (`runs/RUN-001/` for `sample-001-dfd-crop`) plus 4 governance checklists (`validation/package-11-runs-checklist.md`, `validation/run-folder-shape-checklist.md`, `validation/run-log-checklist.md`, `validation/run-comparison-checklist.md`). RUN-001 carries [runs/RUN-001/run-profile.yaml](runs/RUN-001/run-profile.yaml) (Build Package 02 schema-compliant; `mode: folder_first_test`, `output_destination_mode: local_only`, `postback_execution_status: deferred`, `sensitive_data_confirmed_redacted: true`, `expected_baseline_required: true`, `scoring_enabled: true`), [runs/RUN-001/00-run-log.md](runs/RUN-001/00-run-log.md) (Build Package 09 file-shape compliant per `templates/output/output-00-run-log-template.md`; Step Entries / Post-Back Evidence / Stop Conditions Recorded sections empty), [runs/RUN-001/README.md](runs/RUN-001/README.md), 6 byte-copies of the sample-001 inputs under `runs/RUN-001/inputs/`, and an empty governed `runs/RUN-001/dfd/` folder. The 17 RS chain outputs at `runs/RUN-001/01-input-inventory.md` … `17-accuracy-score.md` and the 9 DFD subskill outputs at `runs/RUN-001/dfd/dfd-01-intake-quality-check.md` … `dfd-09-extraction-summary.md` are reserved future paths produced when the operator executes the Build Package 04–09 chain — Build Package 11 does NOT create them and does NOT execute the chain. Numeric accuracy scoring is owned by `prompts/rs/13-accuracy-score.prompt.md` / `skills/rs/SK-ACCURACY-SCORE.md` and activates only when the operator executes the chain. Build Package 11 did not modify any prompt, skill, prototype-agent, adapter, catalog, blueprint, template, sample, or config registry, and did not modify `tools/New-AisrafRun.ps1` or `tools/Test-AisrafRunProfile.ps1`. Other `runs/RUN-*` folders are smoke runs from `tools/New-AisrafRun.ps1` and must be removed before human git stage; `tools/Test-AisrafPackage.ps1` records each non-RUN-001 folder as WARN. The known mismatch between `tools/New-AisrafRun.ps1`'s legacy 00-run-log header and the Package 09 file shape is recorded as a future Build Package 03 increment compatibility note in `validation/run-log-checklist.md`.

These twelve packages do not execute the Build Package 04–09 chain, do not produce the 26 reserved chain outputs in any run folder, do not create diagrams, docs/runbooks, DOCX/PDF/PPTX/ZIP artifacts, runtime code, schemas outside `config/`, cloud resources, MCP proof, or ADK proof.

Build Package numbers define the implementation sequence. Root Area numbers define visible package-tree rows and folder ownership. Root Area 01 is Root & Top-Level Files, followed by the 17 actual root folders.

## Reference Policy

The old package at `D:/E-Way 2/aisraf-sas-prototype-skill-chain-pack-v0.01` is reference-only. It may be read for intent, naming, lessons learned, and useful patterns. It must not be modified, and stale release artifacts, low-quality diagrams, failed outputs, run proof, and temporary reports must not be copied into this clean rebuild.

## Where To Start

### Public readers

1. Read [docs/AISRAF-PRIMER.md](docs/AISRAF-PRIMER.md) for what AISRAF is and what it is not.
2. Operators: read [docs/OPERATOR-QUICKSTART.md](docs/OPERATOR-QUICKSTART.md).
3. Security architects: read [docs/SECURITY-REVIEW-WORKFLOW.md](docs/SECURITY-REVIEW-WORKFLOW.md).
4. Maintainers: read [docs/ARCHITECTURE-OVERVIEW.md](docs/ARCHITECTURE-OVERVIEW.md) and [RELEASE-MANIFEST.yaml](RELEASE-MANIFEST.yaml).
5. Roadmap reviewers: read [docs/ROADMAP.md](docs/ROADMAP.md).

### Contributors and governance reviewers

1. Read [START-HERE.md](START-HERE.md).
2. Read [PROTOTYPE-CHARTER.md](PROTOTYPE-CHARTER.md).
3. Read [BUILD-ORDER.md](BUILD-ORDER.md).
4. Use [FOLDER-CONTRACTS.md](FOLDER-CONTRACTS.md) before writing anything in a later package.
5. Read [validation/README.md](validation/README.md) for the full validation taxonomy and the BLOCKERS section naming `BP12-SAMPLE-DFD-BLOCKER`.

## Build Order

The governed build sequence is recorded in [BUILD-ORDER.md](BUILD-ORDER.md).

## Next Build Package

The immediate governed gate is **WP-12C-REL0-FINAL-QA-REMEDIATION**. If remediation passes, the next gate is REL0 final QA rerun / release decision. WP-13 release visuals, WP-13-dependent publication preparation, AM4 adapter work, push, and publish remain blocked until REL0 release decision closes. WP-13 also remains subject to `BP12-SAMPLE-DFD-BLOCKER` resolution per [validation/diagram-readiness-pre-render-checklist.md](validation/diagram-readiness-pre-render-checklist.md).

Out-of-scope-for-this-release governed work, retained here so a contributor cannot mistake it for current release behavior:

- **Full specialist-generated review output execution** — not proven by the AM3 evidence path.
- **AM4 adapter work** — Jira, Confluence, Lucidchart, Rovo, MCP, Foundry, ADK, MAF, database, Terraform, cloud, event bus, telemetry, post-back execution. Future. Not current release behavior.

## Not Yet Created

- No release visuals yet (WP-13).
- AM3 / AL3 local orchestrated multi-agent runtime evidence is proven only as a local evidence path under `runs/RUN-SMOKE-AM3-001/runtime/`; it is not staged or published in this gate.
- No external adapters yet (future AM4 / AL4; not current release).
- No chain execution against `runs/RUN-001/` yet (the run fixture is governed; the 26 reserved chain outputs activate only when the operator executes the Package 04–09 chain).
- No numeric accuracy score against `runs/RUN-001/` yet.
- No AM4 adapter execution, cloud runtime, MCP, Jira / Confluence / Lucidchart / Rovo post-back, Foundry, ADK, MAF, database, Terraform, event-bus, telemetry, push, publish, or production-operation proof.
