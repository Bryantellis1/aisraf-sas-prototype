# Folder Contracts

Package: AISRAF SAS Prototype v0.1.2

This file defines Root Area ownership and filesystem boundaries. Root Area numbers are visible package-tree rows for documentation and future diagrams. Build Package numbers are implementation phases. Actual filesystem paths use the lowercase folder names shown here.

## Global Contract

- The package root contains only the allowed root files and allowed root folders listed in [PACKAGE-MANIFEST.yaml](PACKAGE-MANIFEST.yaml).
- Build Package numbers must not be used as Root Area numbers.
- Root Area 01 is Root & Top-Level Files; Root Areas 02-19 map to 18 active package root folders plus this top-level-file area.
- Package source folders are not run-output folders.
- Projection folders are not source-of-truth folders. Canonical source remains in prompts, skills, PRAs, templates, catalogs, blueprints, samples, config, tools, and validation.
- Future run outputs must write only under the resolved `output_root` inside `runs/<run_id>/`.
- Future inputs must be read from the resolved `input_root`.
- Future scored baselines must be read from the resolved `expected_root`.
- `runs/RUN-SMOKE-LOCAL-*` folders are local smoke evidence only and are not release fixtures unless separately approved.
- `plugins/` is a future gated projection packaging surface and is blocked until validator allow-list updates pass.
- `diagrams/` and `release/` are blocked/readme-only at WP-12C-K1B-A.
- No folder may claim runtime, cloud, MCP, ADK, database, Terraform, autonomous post-back, implementation proof, release readiness, or ZIP readiness unless the correct Build Package authorizes it and evidence exists.

## Root Area 01 — Root & Top-Level Files

Path: `.`

Owning Build Package: Build Package 01.

Purpose: front-door governance for the package.

Who uses it: all future build agents, validators, maintainers, and operators.

Allowed file types: Markdown and YAML only in Build Package 01.

Belongs here: README, start guide, manifest, charter, folder contracts, and build order.

Does not belong here: generated reports, run outputs, diagrams, release binaries, scripts, schemas, prompts, skills, adapters, catalogs, blueprints, samples, or runtime code.

Populated by: Build Package 01.

Build Package 01 status: active.

## Root Area 02 — `.github/`

Path: `.github/`

Owning Build Package: Build Package 01 for workspace instructions.

Purpose: workspace-level Copilot guidance and provider projection surface for package contributors and local operators.

Who uses it: GitHub Copilot, package authors, local operators, provider-projection validators, and hook testers working in VS Code.

Allowed file types: `copilot-instructions.md`; projected `.agent.md` files under `.github/agents/`; Agent Skill package `SKILL.md` files under `.github/skills/<skill-id>/`; provider hook JSON under `.github/hooks/`.

Belongs here: concise always-on workspace instructions, Copilot agent projections, Copilot Agent Skill packages, and Copilot hook configuration that points back to canonical or reusable package surfaces.

Does not belong here: canonical prompt bodies, canonical skill contracts, canonical PRA specs, run outputs, release artifacts, secrets, executable hook implementations, runtime/cloud/ADK/MCP/Jira/Confluence/Rovo code, or plugin package files.

Populated by: Build Package 01 for instructions; WP-12C provider-projection gates for `.github/agents/`, `.github/skills/`, and `.github/hooks/`; later changes only by authorized Build Packages.

Current status: active provider projection surface. `.github/agents/`, `.github/skills/`, and `.github/hooks/` are projections, not canonical source.

## Root Area 03 — `.agents/`

Path: `.agents/`

Owning Build Package: Build Package 06.

Purpose: canonical local VS Code/GitHub Copilot adapter surface. Each `.agent.md` file is a thin wrapper that points to canonical PRA, prompt, and skill artefacts and appears in the local Copilot Chat agent dropdown when this workspace is open.

Who uses it: PRA/adapter authors and local operators.

Allowed file types: Markdown README and Markdown `.agent.md` adapter files only. Layout: `.agents/README.md` plus exactly seven `.agents/aisraf-*.agent.md` files (orchestrator, input-reader, dfd-extractor, review-table-builder, blueprint-questioner, finding-recommender, handoff-qa-scorer).

Belongs here: thin adapter wrappers with YAML frontmatter (`name`, `description`, `tools: [read, search, edit]`, `user-invocable: true`, `handoffs`) pointing to canonical PRA, prompt, and skill paths. Each adapter declares Allowed Writes under `{{output_root}}` only and Prohibited Writes covering every other folder.

Does not belong here: canonical PRA specs (those live under `prototype-agents/`), prompt bodies, skill contracts, runtime/cloud/ADK agents, MCP/Jira/Confluence/Rovo post-back claims, model pins, terminal/web/cloud/database tool declarations, or duplicated prompt or skill bodies.

Populated by: Build Package 06.

Build Package 06 status: active. 7 canonical `.agent.md` adapters plus the README are present.

## Root Area 04 — `config/`

Path: `config/`

Owning Build Package: Build Package 02.

Purpose: future run-profile variable model and configuration registries.

Who uses it: config authors, prompt authors, validators, and operators.

Allowed file types: Markdown README in Build Package 01; later YAML/JSON configuration only when authorized.

Belongs here: variable definitions, safe defaults, config registries, and examples added by Build Package 02.

Does not belong here: secrets, environment-specific credentials, scripts, databases, generated reports, or runtime config claims.

Populated by: Build Package 02.

Build Package 01 status: reserved with README only.

## Root Area 05 — `tools/`

Path: `tools/`

Owning Build Package: Build Package 03.

Purpose: local helper scripts for setup, validation, testing, hook guardrails, or export steps when authorized.

Who uses it: package maintainers and operators.

Allowed file types: Markdown README in Build Package 01; scripts only when Build Package 03 authorizes them.

Belongs here: governed local utilities that prepare folders or validate artifacts; reusable hook scripts under `tools/hooks/` including block-only prewrite guard, focused validator postwrite, session-stop summary, precommit validator, hook allow-list YAML, and hook README.

Does not belong here: skills, prompt cards, PRAs, cloud deployment code, MCP connectors, secrets, runtime services, provider hook config JSON (that lives under `.github/hooks/`), or plugin package files.

Populated by: Build Package 03 for core tools; WP-12C provider-projection gates for `tools/hooks/`.

Current status: active for local validators and reusable hook implementation. Hook scripts validate or block; they do not author review content.

## Root Area 06 — `prompts/`

Path: `prompts/`

Owning Build Package: Build Package 04.

Purpose: future canonical prompt cards.

Who uses it: local Copilot operators, prompt authors, validators, and PRA authors.

Allowed file types: Markdown README in Build Package 01; later `*.prompt.md` cards and registries when Build Package 04 authorizes them.

Belongs here: reusable instruction files that use resolved variables such as `input_root`, `output_root`, `expected_root`, `run_id`, and `sample_id`.

Does not belong here: skills, PRA specs, adapters, catalogs, generated outputs, scripts, or runtime code.

Populated by: Build Package 04.

Build Package 01 status: reserved with README only.

## Root Area 07 — `skills/`

Path: `skills/`

Owning Build Package: Build Package 05.

Purpose: canonical reusable skill contracts wrapping the Build Package 04 prompt cards. Each skill contract is a 14-section governed work contract with explicit identity, purpose, inputs, outputs, procedure, stop conditions, unknown handling, confidence handling, critical misses, human review gate, validation/scoring relationship, direct skill test, and out-of-scope claims.

Who uses it: skill authors, prompt authors, PRA authors (Build Package 06), validators, SAS reviewers, and local operators troubleshooting the output contract for a review step.

Allowed file types: Markdown skill contracts and YAML registry only. Layout: `skills/README.md`, `skills/skill-registry.yaml`, `skills/rs/README.md`, `skills/dfd/README.md`, 17 `skills/rs/SK-*.md` files, and 9 `skills/dfd/SK-DFD-0[1-9]-*.md` files.

Belongs here: identity, purpose, inputs, outputs, procedure, stop conditions, unknown handling, confidence handling, critical misses, human review gate, validation/scoring relationship, direct skill test, and out-of-scope claims for each reusable work contract.

Does not belong here: executable tools, scripts, prompt bodies, PRA specs, `.agent.md` adapters, runtime services, generated outputs, catalogs, blueprints, templates beyond authoring-agent templates, samples, runs, diagrams, docs/runbooks, release artifacts, schemas outside `config/`.

Populated by: Build Package 05.

Build Package 05 status: active. 26 canonical skill contracts (17 RS + 9 DFD) plus the registry and three READMEs are present.

## Root Area 08 — `prototype-agents/`

Path: `prototype-agents/`

Owning Build Package: Build Package 06.

Purpose: canonical Prototype Review Agent (PRA) specifications. Each PRA spec is a 13-section governed document (Identity, Purpose, Owned Prompts, Owned Skills, Inputs, Outputs, Procedure, Human Gates, Stop Conditions, Unknown Handling, Evidence and Run-Log Guidance, Direct Adapter Test, Not in Scope) that groups Build Package 04 prompts and Build Package 05 skills into a role-oriented review responsibility.

Who uses it: PRA authors, prompt authors, skill authors, adapter authors, validators, SAS reviewers, and local operators.

Allowed file types: Markdown PRA specs and a single YAML registry only. Layout: `prototype-agents/README.md`, `prototype-agents/prototype-agent-registry.yaml`, `prototype-agents/prototype-agent-template.md`, and 8 `prototype-agents/PRA-0[1-8]-*.md` files.

Belongs here: identity, purpose, owned prompts, owned skills, inputs, outputs, procedure, human gates, stop conditions, unknown handling, evidence guidance, direct adapter test, and out-of-scope claims for each PRA. The registry indexes the 8 PRAs, the 7 adapters, the prompt-skill-agent crosswalk, and a future-only ADK alignment block.

Does not belong here: deployed runtime agents, `.agent.md` adapter wrappers (those live under `.agents/`), cloud/ADK/Vertex/GCP integration code, MCP/Jira/Confluence/Rovo execution code, generated outputs, catalogs, blueprints, templates beyond authoring-agent templates, samples, runs, diagrams, docs/runbooks, release artefacts, schemas outside `config/`.

Populated by: Build Package 06.

Build Package 06 status: active. 8 canonical PRA specs plus the registry, template, and README are present.

## Root Area 09 — `catalogs/`

Path: `catalogs/`

Owning Build Package: Build Package 07.

Purpose: controlled vocabulary and classification source for prompts, skills, PRAs, `.agent.md` adapters, future blueprints, future templates, future samples, and validation. Catalogs are not executable tools, runtime services, blueprints, prompts, skills, agent logic, or runbooks.

Who uses it: catalog authors, skill authors, prompt authors, PRA authors, adapter authors, validators, SAS reviewers, and operators checking why a controlled value normalized a certain way.

Allowed file types: YAML catalogs and Markdown READMEs only. Layout: `catalogs/README.md`, `catalogs/catalog-registry.yaml`, plus 7 family folders (`components/`, `interactions/`, `boundaries/`, `identity-access/`, `data-protection/`, `security-stacks/`, `review/`) each with a `README.md` and the listed YAML catalog files. Total: 24 controlled-vocabulary YAML catalogs, 1 catalog registry, 8 READMEs (33 files).

Belongs here: closed-list controlled vocabulary covering component types and roles, interaction types, flow directions, boundary types and crossings, trust zones, authentication marker families and authorization values, identity evidence rules, data class and protection markers, transport and at-rest protection, confidence levels (cross-cutting), security-stack markers, control signals, the global proof-vs-signal rule catalog, finding categories, severity, recommendation types, AI Action Levels (definitions only), and review status.

Does not belong here: invented one-off vocabulary, runtime code, schemas, release artifacts, prompt bodies, skill contracts, PRA specs, `.agent.md` adapters, blueprint identifiers (`BP-*`), recommendation prose, handoff text, template language, scripted remediation language, or severity/scoring/AI Action Level computation.

Populated by: Build Package 07.

Build Package 07 status: active. 24 controlled-vocabulary YAML catalogs across 7 families plus the catalog registry and 8 READMEs are present. Two catalogs are cross-cutting: `catalogs/security-stacks/proof-vs-signal-rule-catalog.yaml` (`global_rule: true`) and `catalogs/data-protection/confidence-level-catalog.yaml` (`cross_cutting_catalog: true`, `primary_family: data-protection`).

## Root Area 10 — `blueprints/`

Path: `blueprints/`

Owning Build Package: Build Package 08.

Purpose: reusable review-pattern source. Each controlled blueprint is a YAML document that turns Build Package 07 catalog vocabulary into a recognizable design pattern, scopes catalog evidence required for a match, and surfaces the material missing facts that block matching. Blueprints are not catalogs, not prompt cards, not skill contracts, not PRA specs, not `.agent.md` adapters, not templates, not samples, and not run outputs. Match states are fixed at four values (`matched`, `candidate`, `no_match`, `unknown`).

Who uses it: blueprint authors, SAS reviewers, prompt authors (Build Package 04), skill authors (Build Package 05), PRA authors (Build Package 06), `.agent.md` adapter authors (Build Package 06), and validators.

Allowed file types: YAML blueprint files and Markdown READMEs only. Layout: `blueprints/README.md`, `blueprints/blueprint-registry.yaml`, `blueprints/blueprint-template.yaml`, `blueprints/platform-independent/README.md`, `blueprints/cloud-patterns/README.md`, plus 8 `blueprints/platform-independent/BP-*.yaml` files and 1 `blueprints/cloud-patterns/BP-AI-SAAS-INTEGRATION.yaml` file. Total: 9 controlled blueprints, 1 blueprint registry, 1 blueprint template, 3 READMEs (14 files).

Belongs here: closed YAML blueprints whose match conditions reference Package 07 catalog values only, with the 19 required fields plus the three policy blocks (`match_evidence_policy`, `catalog_value_policy`, `output_boundary`) plus the `runtime_and_external_execution` block (six false flags).

Does not belong here: invented one-off vocabulary, new catalog identifiers, new controlled values, recommendation prose, handoff text, validation-ticket text, owner routing prose, severity / score / AI Action Level computation, implementation proof claims, runtime/cloud/ADK/Vertex/GCP/MCP/Jira/Confluence/Rovo/database/Terraform claims, runtime code, schemas, release artifacts, prompt bodies, skill contracts, PRA specs, `.agent.md` adapters, templates beyond authoring-agent templates, samples, runs, diagrams, or docs/runbooks.

Populated by: Build Package 08.

Build Package 08 status: active. 9 controlled YAML blueprints (8 platform-independent + 1 cloud-pattern) plus the blueprint registry, the blueprint template, and 3 READMEs are present. Founder decision Q4 seals the upstream Build Package 04, 05, 06, and 07 registries; Build Package 08 records its blueprint→catalog, blueprint→skill, blueprint→PRA, blueprint→adapter, and blueprint→prompt consumer maps in `blueprints/blueprint-registry.yaml` only.

## Root Area 11 — `templates/`

Path: `templates/`

Owning Build Package: Build Package 09.

Purpose: reusable output-shape source. Templates define the shape of run outputs, run-log rows, Jira-ready local drafts, and Confluence-ready local drafts. Templates are not catalogs, not prompt cards, not skill contracts, not PRA specs, not `.agent.md` adapters, not blueprints, not samples, and not run outputs.

Who uses it: prompt authors (Build Package 04), skill authors (Build Package 05), PRA authors (Build Package 06), `.agent.md` adapter authors (Build Package 06), catalog authors (Build Package 07), blueprint authors (Build Package 08), run operators, validators, and release authors.

Allowed file types: Markdown templates and one YAML registry only. Layout: `templates/README.md`, `templates/template-registry.yaml`, `templates/output/README.md` plus 27 `output-*-template.md` files (18 RS + 9 DFD), `templates/jira/README.md` plus 1 `jira-ticket-draft-template.md`, `templates/confluence/README.md` plus 1 `confluence-page-draft-template.md`, `templates/run/README.md` plus 2 row templates (`run-log-entry-row-template.md`, `postback-log-entry-row-template.md`). Total: 31 templates, 1 template registry, 5 READMEs (root + 4 family) = 37 files.

Belongs here: file-shape templates for canonical run-output paths under `{{output_root}}` and `{{output_root}}/dfd/`; Jira-ready and Confluence-ready local draft templates; per-step and post-back run-log row patterns; the template registry that maps every template to its consumers (prompts, skills, PRAs, adapters, blueprints, catalogs).

Does not belong here: invented one-off vocabulary, new catalog identifiers, new controlled values, recommendation prose, finding prose, validation-ticket prose, owner routing prose, severity / score / AI Action Level computation, blueprint match decisions, implementation proof claims, external post-back claims without `executed_by_operator` evidence, runtime/cloud/ADK/Vertex/GCP/MCP/Jira/Confluence/Rovo/database/Terraform claims, runtime code, schemas outside `config/`, release artifacts, prompt bodies, skill contracts, PRA specs, `.agent.md` adapters, samples, runs, diagrams, docs/runbooks, or any non-Markdown/non-YAML file.

Populated by: Build Package 09.

Build Package 09 status: active. 31 templates plus the template registry, 5 READMEs (root + 4 family) are present. Founder decision Q4 seals the upstream Build Package 04, 05, 06, 07, and 08 registries; Build Package 09 records its template→prompt, template→skill, template→PRA, template→adapter, template→blueprint, and template→catalog consumer maps in `templates/template-registry.yaml` only.

## Root Area 12 — `samples/`

Path: `samples/`

Owning Build Package: Build Package 10.

Purpose: synthetic samples and expected baselines for the Build Package 04–09 chain.

Who uses it: sample designers, prompt/skill testers, validators, and operators.

Allowed file types: Markdown for sample READMEs, expected baselines, and sample input narratives; PNG for the sample DFD image; Mermaid `.mmd` for the DFD source companion; YAML for `samples/sample-registry.yaml` only.

Belongs here: `samples/README.md`, `samples/sample-registry.yaml`, `samples/sample-001-dfd-crop/README.md`, six synthetic inputs under `samples/sample-001-dfd-crop/inputs/`, and 26 Markdown expected baselines under `samples/sample-001-dfd-crop/expected/` (17 RS + 9 DFD; mirroring Package 09 templates `output-NN-*` and `output-dfd-NN-*`). Optional YAML front matter is allowed inside expected baselines for traceability and scoring metadata only (founder decision Q1). Samples 002–008 are recorded as `planned_or_deferred_samples` entries inside `samples/sample-registry.yaml` only — no folders or files (founder decision Q8).

Does not belong here: real PII, PAN, SSN, PHI, customer identifiers, internal employee identifiers, secrets, credentials, production endpoints, vendor commercial product names asserted as mandatory, run outputs (those belong under `runs/<run_id>/`), release artifacts, diagrams package assets, JSON expected baselines (founder decision Q1: Markdown-only), `expected-00-run-log.md` inside any sample folder (founder decision Q2: run logs are run artefacts deferred to Build Package 11), folders or files for `sample-002` through `sample-008` (founder decision Q8), Jira post-back / Confluence publication / Rovo / MCP / runtime / cloud / ADK / Vertex / GCP / database / Terraform execution claims, severity / finding-category / AI Action Level / blueprint-match / accuracy-score computation inside expected-baseline bodies, or new BP-* identifiers / controlled values introduced inside any sample artefact.

Populated by: Build Package 10.

Build Package 10 status: active. 1 sample (`sample-001-dfd-crop`, gold-standard scored sample — AI SaaS Security Review Portal scenario) plus the sample registry; 7 samples (002–008) recorded as planned/deferred in the registry only. 36 files under `samples/` (1 root README, 1 sample-registry.yaml, 1 sample-001 README, 6 inputs, 26 expected baselines, plus the implicit folder layout). Founder decision Q4 seals the upstream Build Package 04, 05, 06, 07, 08, 09 registries; Build Package 10 records its sample-to-prompt, sample-to-skill, sample-to-PRA, sample-to-adapter, sample-to-blueprint, and sample-to-catalog consumer maps in `samples/sample-registry.yaml` only.

## Root Area 13 — `runs/`

Path: `runs/`

Owning Build Package: Build Package 11.

Purpose: self-contained execution evidence folders. Each `runs/<run_id>/` folder carries a Build Package 02 schema-compliant `run-profile.yaml`, a Build Package 09 file-shape compliant `00-run-log.md`, byte-copies of staged inputs under `inputs/`, reserved paths for the 17 RS chain outputs (top level) and 9 DFD subskill outputs (under `dfd/`), and any operator-driven post-back artefacts.

Who uses it: operators, validators, scorers, and reviewers.

Allowed file types: Markdown READMEs, Markdown chain outputs, Markdown run-log, YAML run-profile, byte-copy inputs (PNG, Mermaid `.mmd`, Markdown). Layout: `runs/README.md`, plus governed `runs/<run_id>/` folders. The first canonical governed fixture is `runs/RUN-001/` for `sample-001-dfd-crop`; it contains `README.md`, `run-profile.yaml`, `00-run-log.md`, `inputs/` (6 byte-copies of `samples/sample-001-dfd-crop/inputs/`), and an empty governed `dfd/` folder. The 17 RS outputs (`01-input-inventory.md` … `17-accuracy-score.md`) and 9 DFD outputs (`dfd/dfd-01-intake-quality-check.md` … `dfd/dfd-09-extraction-summary.md`) are reserved future paths produced when the operator executes the Build Package 04–09 chain — Build Package 11 does NOT create them.

Belongs here: governed run folders following the canonical shape pinned in `validation/run-folder-shape-checklist.md`. Run logs follow `validation/run-log-checklist.md` (file shape from `templates/output/output-00-run-log-template.md`; row patterns from `templates/run/`). Comparison/scoring procedure is recorded in `validation/run-comparison-checklist.md`. Other `runs/RUN-*` folders are smoke runs from `tools/New-AisrafRun.ps1`. `runs/RUN-SMOKE-LOCAL-*` folders are local smoke evidence, locally excluded from normal staging, and are not release fixtures unless separately approved.

Does not belong here: source artifacts, expected baselines (those live under `samples/<sample_id>/expected/` and are read-only at run time), hidden reports, secrets, credentials, real PII / PAN / SSN / PHI / production endpoints, diagrams, release exports, package source files, JSON expected baselines (founder decision Q1 of Build Package 10: Markdown-only), executable scripts, schemas outside `config/`, modifications to files under `samples/<sample_id>/` from a run, or any `executed_by_operator` claim without `postback_execution_status: executed_by_operator` plus a matching `templates/run/postback-log-entry-row-template.md` row in `00-run-log.md`. Top-level `runs/` accepts only `README.md`. Any `runs/<run_id>/` accepts only `README.md`, `run-profile.yaml`, `00-run-log.md`, `inputs/`, `dfd/`, the 17 RS chain-output Markdown files, and the optional Jira/Confluence post-back drafts.

Populated by: Build Package 11.

Build Package 11 status: active. `runs/RUN-001/` is present as the first canonical governed run fixture with `README.md`, `run-profile.yaml`, `00-run-log.md`, 6 byte-copied inputs under `inputs/`, and an empty governed `dfd/` folder. Build Package 11 does not execute the chain; the 26 future-output paths are reserved. Founder decision Q4 seals the upstream Build Package 04, 05, 06, 07, 08, 09, 10 registries plus `config/` and `tools/New-AisrafRun.ps1` / `tools/Test-AisrafRunProfile.ps1`; Build Package 11 records its run-folder shape, run-log shape, and comparison/scoring procedure only in the four Package 11 validation checklists.

## Root Area 14 — `diagrams/`

Path: `diagrams/`

Owning Build Package: Build Package 13.

Purpose: future diagram source, render, and accessibility lanes.

Who uses it: diagram authors, documentation authors, validators, and release authors.

Allowed file types: Markdown README only at WP-12C-K1B-A; later source/render/alt-text artifacts only when WP-13 authorizes them after plugin install reality.

Belongs here: governed diagram material only after the diagram Build Package begins and the WP-12C-L install validation gate has passed.

Does not belong here: diagram source, PNG, SVG, PDF, alt-text, diagram index, release exports, or runtime proof at WP-12C-K1B-A.

Populated by: Build Package 13.

Current status: blocked/readme-only. WP-13 remains blocked.

## Root Area 15 — `docs/`

Path: `docs/`

Owning Build Package: Build Package 14.

Purpose: future practitioner documentation and runbooks.

Who uses it: operators, practitioners, maintainers, validators, and release authors.

Allowed file types: Markdown README in Build Package 01; later Markdown documentation when Build Package 14 authorizes it.

Belongs here: practitioner guide, runbooks, process notes, mappings, and source-reference notes.

Does not belong here: release binaries, runtime code, generated outputs, prompts, skills, adapters, or hidden control files.

Populated by: Build Package 14, with limited earlier references only when authorized by owning Build Packages.

Build Package 01 status: reserved with README only.

## Root Area 16 — `validation/`

Path: `validation/`

Owning Build Package: Build Package 12.

Purpose: package checklists, gates, validation rules, and the canonical home of carried-forward blockers across the prototype build sequence.

Who uses it: validators, package maintainers, future build agents, and release owners.

Allowed file types: Markdown validation documents only. The single index file `validation/README.md` is the taxonomy index with a top-of-file BLOCKERS section; `validation/no-drift-rules.md` carries the cross-package no-drift contract (Build Package 01 baseline plus Build Package 12 amendments). All other files are governed checklists for one specific gate (per package, per registry, per chain stage, per sample, per run, per cross-cutting concern, per forward-looking pre-render gate, or per final-QA closure).

Allowed file list: governed by `tools/Test-AisrafPackage.ps1` Check 11 and amended only by authorized package gates. The list began with Build Package 01-12 validation files and has been extended by later governed 10A/11A/WP-12C evidence and roadmap files.
- `README.md` (validation taxonomy index; rebuilt by Build Package 12)
- `no-drift-rules.md` (Build Package 01 baseline; Build Package 12 amendments appended)
- `release-readiness-checklist.md` (Build Package 15 placeholder; not in scope for Build Package 12 framework deliverable)
- 11 package gates: `package-01-foundation-checklist.md` through `package-12-validation-checklist.md`
- 7 registry gates: `prompt-registry-checklist.md`, `skill-registry-checklist.md`, `agent-registry-checklist.md`, `catalog-registry-checklist.md`, `blueprint-registry-checklist.md`, `template-registry-checklist.md`, `sample-registry-checklist.md`
- 7 chain gates: `prompt-skill-agent-mapping-checklist.md`, `catalog-consumption-checklist.md`, `blueprint-catalog-consumption-checklist.md`, `template-consumption-checklist.md`, `prompt-skill-pra-parity-checklist.md`, `prototype-execution-readiness-checklist.md`, `expected-output-lint-checklist.md`, `scoring-rubric-checklist.md`
- 1 sample gate: `sample-input-readiness-checklist.md`, `sample-baseline-checklist.md`
- 4 run gates: `run-folder-shape-checklist.md`, `run-log-checklist.md`, `run-comparison-checklist.md`, `local-run-readiness-checklist.md`
- 1 cross-cutting hygiene roll-up: `package-lint-master-checklist.md`
- 2 forward gates: `diagram-readiness-pre-render-checklist.md`, `docs-readiness-pre-render-checklist.md`
- 1 final QA: `final-qa-checklist.md`

Belongs here: Build Package 01 foundation checklist, Build Package 01 no-drift rules, Build Package 02–11 per-package and per-registry checklists, Build Package 12 framework gates (10 new files plus the rebuilt `README.md` and amended `no-drift-rules.md`), and the carried-forward `BP12-SAMPLE-DFD-BLOCKER` cross-references.

Does not belong here: generated run outputs, hidden reports, release binaries, runtime validators, lowered standards, runbook prose, operator-walkthrough narratives, scripted remediation language, sample DFD redraws, or any executable validator code (validators live under `tools/`, not `validation/`).

Populated by: Build Package 01 for foundation checks; Build Package 02-11 for per-package and per-registry checklists; Build Package 12 for the full validation framework; 10A/11A for corrective evidence; WP-12C for operator-experience, projection, hook, sample-preview, controlled-output, and plugin-roadmap governance files when validator allow-lists authorize them.

Carried-forward blockers note: The `validation/` folder is the canonical home of carried-forward blockers across the prototype build sequence. `BP12-SAMPLE-DFD-BLOCKER` (severity HARD, owner founder) is recorded in 6 validation files (`sample-input-readiness-checklist.md`, `expected-output-lint-checklist.md`, `diagram-readiness-pre-render-checklist.md`, `no-drift-rules.md`, `package-12-validation-checklist.md`, `final-qa-checklist.md`) plus `PACKAGE-MANIFEST.yaml`. The blocker pins Build Package 13 entry until a founder-approved Package 10A / 11A correction lands or sample-002 with a clean DFD is authorized.

Current status: active validation authority. K1B-A may update existing WP-12C roadmap/proposed-tree authority notes only; K1B-B is required for validator allow-list changes.

## Root Area 17 — `release/`

Path: `release/`

Owning Build Package: Build Package 15.

Purpose: future generated reader artifacts and release metadata.

Who uses it: release authors, final QA, package maintainers, and approvers.

Allowed file types: Markdown README only at WP-12C-K1B-A; later release notes/manifests and generated artifacts only when the governed release or solution-package gate authorizes them.

Belongs here: release packaging outputs only after the release or solution-package Build Package begins and required upstream evidence exists.

Does not belong here: DOCX/PDF/PPTX/ZIP at WP-12C-K1B-A, run outputs, prompts, skills, diagrams, runtime code, cloud resources, plugin install bundles, or Git publication evidence.

Populated by: Build Package 15, finalized by Build Package 16.

Current status: blocked/readme-only. Release output remains unauthorized.

## Root Area 18 — `authoring-agents/`

Path: `authoring-agents/`

Owning Build Package: Build Package 01.

Purpose: instruction standards and templates for future package build agents.

Who uses it: future build agents, validators, package maintainers, and reviewers.

Allowed file types: Markdown instruction templates and checklists.

Belongs here: the Prompt + Specification + Validation triad template, package build-agent template, validation template, and acceptance checklist.

Does not belong here: runtime agents, PRA specs, `.agent.md` adapters, prompt cards, skills, generated outputs, or release artifacts.

Populated by: Build Package 01.

Build Package 01 status: active.

## Root Area 19 — `.copilot-skills/`

Path: `.copilot-skills/`

Owning Build Package: WP-12C-H / WP-12C-I projection governance.

Purpose: Copilot wrapper and operator-card projection surface for the seven AISRAF operator roles.

Who uses it: local operators, provider-projection validators, package maintainers, and Copilot users comparing wrapper behavior to canonical `.agents/`, PRAs, prompts, and skills.

Allowed file types: Markdown README, seven `aisraf-*.skill.md` wrapper cards, and seven `aisraf-*.operator-card.md` operator cards.

Belongs here: thin local/operator wrappers and operator cards that reference canonical `.agents/`, `prototype-agents/`, `prompts/`, and `skills/` paths without copying canonical bodies.

Does not belong here: canonical skill contracts, canonical prompts, PRA specs, runtime code, external post-back proof, generated outputs, plugin bundle files, or release artifacts.

Populated by: WP-12C provider-projection gates.

Current status: active projection surface. It is not the provider Agent Skill package format; Copilot-discoverable Agent Skill packages live under `.github/skills/`.

## Future Gated Surface — `plugins/`

Path: `plugins/`

Owning Build Package: future WP-12C-K2/K3 after WP-12C-K1B-B validator allow-list patch passes.

Purpose: future projection packaging surface for provider-scoped install bundles, starting with `plugins/aisraf-copilot-plugin/`.

Who uses it: future plugin packagers, plugin install testers, validators, and release approvers after the gate opens.

Allowed file types: none at WP-12C-K1B-A because the folder must not exist yet. Future allowed files must be defined by validator allow-list updates before scaffold creation.

Belongs here: future plugin README, manifest, test card, evidence checklist, packaging plan, and bundled-by-reference projection folders only after K1B-B/K2 authorization.

Does not belong here: canonical source bodies, hand-copied prompt/skill/PRA/template/catalog/blueprint content, runtime/cloud/MCP/Jira/Confluence/Rovo proof, diagrams, release artifacts, or install evidence before WP-12C-L.

Current status: blocked. `plugins/` remains a future gated surface, not current scaffold.
