# Folder Contracts

Package: AISRAF SAS Prototype v0.1.2

This file defines Root Area ownership and filesystem boundaries. Root Area numbers are visible package-tree rows for documentation and future diagrams. Build Package numbers are implementation phases. Actual filesystem paths use the lowercase folder names shown here.

## Global Contract

- The package root contains only the allowed root files and allowed root folders listed in [PACKAGE-MANIFEST.yaml](PACKAGE-MANIFEST.yaml).
- Build Package numbers must not be used as Root Area numbers.
- Root Area 01 is Root & Top-Level Files; the workspace has 17 root folders plus this top-level-file area.
- Package source folders are not run-output folders.
- Future run outputs must write only under the resolved `output_root` inside `runs/<run_id>/`.
- Future inputs must be read from the resolved `input_root`.
- Future scored baselines must be read from the resolved `expected_root`.
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

Purpose: workspace-level Copilot guidance for package contributors.

Who uses it: GitHub Copilot and package authors working in VS Code.

Allowed file types: `copilot-instructions.md` in Build Package 01.

Belongs here: concise always-on workspace instructions.

Does not belong here: prompt wrappers, `.agent.md` adapters, skills, run outputs, release artifacts, or executable hooks.

Populated by: Build Package 01 for instructions; later changes only by authorized Build Packages.

Build Package 01 status: active for `copilot-instructions.md` only.

## Root Area 03 — `.agents/`

Path: `.agents/`

Owning Build Package: Build Package 06.

Purpose: reserved local adapter surface for future VS Code/GitHub Copilot agent wrappers.

Who uses it: future PRA/adapter authors and local operators.

Allowed file types: Markdown README in Build Package 01; future `.agent.md` files only if Build Package 06 authorizes them.

Belongs here: adapter guidance and future thin wrappers that point to canonical PRA, prompt, and skill artifacts.

Does not belong here: canonical PRA specs, prompt bodies, skill contracts, runtime agents, cloud agents, or post-back claims.

Populated by: Build Package 06 after Build Package 01 reserves the folder.

Build Package 01 status: reserved with README only.

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

Purpose: future local helper scripts for setup, validation, testing, or export steps.

Who uses it: package maintainers and operators.

Allowed file types: Markdown README in Build Package 01; scripts only when Build Package 03 authorizes them.

Belongs here: governed local utilities that prepare folders or validate artifacts.

Does not belong here: skills, prompt cards, PRAs, cloud deployment code, MCP connectors, secrets, or runtime services.

Populated by: Build Package 03.

Build Package 01 status: reserved with README only.

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

Purpose: future PRA specifications.

Who uses it: PRA authors, prompt authors, skill authors, validators, and operators.

Allowed file types: Markdown README in Build Package 01; later Markdown/YAML PRA specs and registry when Build Package 06 authorizes them.

Belongs here: Prototype Review Agent specifications that group skills and prompt cards into role-oriented responsibilities.

Does not belong here: deployed agents, `.agent.md` adapter wrappers, runtime code, cloud code, or post-back claims.

Populated by: Build Package 06.

Build Package 01 status: reserved with README only.

## Root Area 09 — `catalogs/`

Path: `catalogs/`

Owning Build Package: Build Package 07.

Purpose: future controlled vocabulary and classification sources.

Who uses it: catalog authors, skill authors, prompt authors, PRA authors, and validators.

Allowed file types: Markdown README in Build Package 01; later Markdown/YAML catalog content when Build Package 07 authorizes it.

Belongs here: controlled component types, interaction types, auth labels, data classes, boundary types, finding categories, and related vocabularies.

Does not belong here: invented one-off vocabulary, outputs, runtime code, schemas, or release artifacts.

Populated by: Build Package 07.

Build Package 01 status: reserved with README only.

## Root Area 10 — `blueprints/`

Path: `blueprints/`

Owning Build Package: Build Package 08.

Purpose: future reusable review patterns.

Who uses it: blueprint authors, SAS reviewers, prompt authors, PRA authors, and validators.

Allowed file types: Markdown README in Build Package 01; later Markdown/YAML blueprint content when Build Package 08 authorizes it.

Belongs here: patterns that help match observed design shapes to known architectural/security review patterns.

Does not belong here: implementation proof, findings, recommendations, catalogs, runtime code, or generated outputs.

Populated by: Build Package 08.

Build Package 01 status: reserved with README only.

## Root Area 11 — `templates/`

Path: `templates/`

Owning Build Package: Build Package 09.

Purpose: future reusable output shapes.

Who uses it: prompt authors, skill authors, run operators, validators, and release authors.

Allowed file types: Markdown README in Build Package 01; later Markdown/YAML templates when Build Package 09 authorizes them.

Belongs here: expected structures for outputs, run logs, tickets, Confluence drafts, recommendations, validation notes, and reports.

Does not belong here: sample outputs, live run artifacts, release binaries, scripts, or schemas unless a later Build Package authorizes them.

Populated by: Build Package 09.

Build Package 01 status: reserved with README only.

## Root Area 12 — `samples/`

Path: `samples/`

Owning Build Package: Build Package 10.

Purpose: future synthetic samples and expected baselines.

Who uses it: sample designers, prompt/skill testers, validators, and operators.

Allowed file types: Markdown README in Build Package 01; later synthetic inputs and expected baselines when Build Package 10 authorizes them.

Belongs here: synthetic input packs and expected outputs used for scoring.

Does not belong here: real PII, PAN, SSN, credentials, production endpoints, run outputs, release artifacts, or unsupported rebaselines.

Populated by: Build Package 10.

Build Package 01 status: reserved with README only.

## Root Area 13 — `runs/`

Path: `runs/`

Owning Build Package: Build Package 11.

Purpose: future self-contained execution evidence folders.

Who uses it: operators, validators, scorers, and reviewers.

Allowed file types: Markdown README in Build Package 01; later per-run Markdown/YAML/JSON outputs when Build Package 11 authorizes them.

Belongs here: `runs/<run_id>/` folders containing a run profile, staged inputs, outputs, run log, and scoring evidence when implemented.

Does not belong here: source artifacts, expected baselines, hidden reports, secrets, or release exports.

Populated by: Build Package 11.

Build Package 01 status: reserved with README only.

## Root Area 14 — `diagrams/`

Path: `diagrams/`

Owning Build Package: Build Package 13.

Purpose: future diagram source, render, and accessibility lanes.

Who uses it: diagram authors, documentation authors, validators, and release authors.

Allowed file types: Markdown README in Build Package 01; later source/render/alt-text artifacts when Build Package 13 authorizes them.

Belongs here: governed diagram material only after the diagram Build Package begins.

Does not belong here: Build Package 01 diagram source, PNG, SVG, PDF, alt-text, diagram index, release exports, or runtime proof.

Populated by: Build Package 13.

Build Package 01 status: reserved with README only.

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

Purpose: package checklists, gates, and validation rules.

Who uses it: validators, package maintainers, future build agents, and release owners.

Allowed file types: Markdown validation documents in Build Package 01; later validation artifacts when Build Package 12 authorizes them.

Belongs here: Build Package 01 foundation checklist, no-drift rules, and release-readiness placeholder in this package.

Does not belong here: generated run outputs, hidden reports, release binaries, runtime validators, or lowered standards.

Populated by: Build Package 01 for foundation checks; Build Package 12 for full validation model.

Build Package 01 status: active for Build Package 01 checklists only.

## Root Area 17 — `release/`

Path: `release/`

Owning Build Package: Build Package 15.

Purpose: future generated reader artifacts and release metadata.

Who uses it: release authors, final QA, package maintainers, and approvers.

Allowed file types: Markdown README in Build Package 01; later release notes/manifests and generated artifacts when Build Package 15 authorizes them.

Belongs here: release packaging outputs only after the release Build Package begins.

Does not belong here: DOCX/PDF/PPTX/ZIP in Build Package 01, run outputs, prompts, skills, diagrams, runtime code, or cloud resources.

Populated by: Build Package 15, finalized by Build Package 16.

Build Package 01 status: reserved with README only.

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
