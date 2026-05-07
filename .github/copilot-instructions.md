# Copilot Instructions For AISRAF SAS Prototype v0.1.2

This workspace is the clean rebuild root for **AISRAF SAS Prototype v0.1.2**. Confirm the workspace root is `D:/E-Way 2/AISRAF- SAS Prototype v0.1.2` before reading or writing package artifacts.

## Package Boundary

- The old package at `D:/E-Way 2/aisraf-sas-prototype-skill-chain-pack-v0.01` is read-only reference material.
- Do not modify the old package.
- Do not copy old generated outputs, stale release artifacts, failed diagrams, run proof, or temporary reports into this workspace.
- Use [PACKAGE-MANIFEST.yaml](../PACKAGE-MANIFEST.yaml), [FOLDER-CONTRACTS.md](../FOLDER-CONTRACTS.md), and [BUILD-ORDER.md](../BUILD-ORDER.md) as the current source of Build Package, Root Area, and filesystem structure truth.

## Current State

Build Packages 01–12 are active. Build Package 12 added the validation framework: 10 new validation files (`validation/package-12-validation-checklist.md`, `validation/scoring-rubric-checklist.md`, `validation/package-lint-master-checklist.md`, `validation/expected-output-lint-checklist.md`, `validation/prompt-skill-pra-parity-checklist.md`, `validation/sample-input-readiness-checklist.md`, `validation/local-run-readiness-checklist.md`, `validation/prototype-execution-readiness-checklist.md`, `validation/diagram-readiness-pre-render-checklist.md`, `validation/docs-readiness-pre-render-checklist.md`, `validation/final-qa-checklist.md`) plus the rebuilt `validation/README.md` taxonomy index with a top-of-file BLOCKERS section, plus 14 numbered amendments appended to `validation/no-drift-rules.md`, plus `runs/RUN-001/dfd/.gitkeep` as a fresh-clone reservation marker, plus 3 surgical patches to `tools/Test-AisrafPackage.ps1` (synopsis "Build Package 01-12"; Check 08i `.gitkeep` allowance in `runs/RUN-001/dfd/`; Check 11 allow-list extended). Build Package 12 also records `BP12-SAMPLE-DFD-BLOCKER` (severity HARD, owner founder) as a hard, named, non-silent carried-forward blocker on the canonical sample DFD (`samples/sample-001-dfd-crop/inputs/dfd-crop.png`/`.mmd` and the byte-copies under `runs/RUN-001/inputs/`); the blocker is cross-referenced in 6 validation files plus `PACKAGE-MANIFEST.yaml` and pins Build Package 13 entry. Build Package 12 did NOT modify any sealed Build Package 01–11 surface, did NOT modify the sample DFD or its byte-copy, did NOT modify any expected baseline under `samples/sample-001-dfd-crop/expected/`, did NOT create any diagram / runbook / release artefact / runtime / cloud / MCP proof, did NOT create the 17 RS or 9 DFD chain outputs in `runs/RUN-001/`, did NOT produce a numeric accuracy score, and did NOT author sample-002. Build Package 11 added the run-evidence model and the first canonical governed run fixture `runs/RUN-001/` for `sample-001-dfd-crop` plus four governance checklists (`validation/package-11-runs-checklist.md`, `validation/run-folder-shape-checklist.md`, `validation/run-log-checklist.md`, `validation/run-comparison-checklist.md`). RUN-001 carries `runs/RUN-001/README.md`, `runs/RUN-001/run-profile.yaml` (Build Package 02 schema-compliant; `mode: folder_first_test`, `output_destination_mode: local_only`, `postback_execution_status: deferred`, `sensitive_data_confirmed_redacted: true`, `expected_baseline_required: true`, `scoring_enabled: true`), `runs/RUN-001/00-run-log.md` (Build Package 09 file-shape compliant per `templates/output/output-00-run-log-template.md`; Step Entries / Post-Back Evidence / Stop Conditions Recorded sections empty), 6 byte-copies of the sample-001 inputs under `runs/RUN-001/inputs/`, and the empty governed `runs/RUN-001/dfd/` folder (now carrying `.gitkeep`). The 17 RS chain outputs (`runs/RUN-001/01-input-inventory.md` through `17-accuracy-score.md`) and the 9 DFD outputs (`runs/RUN-001/dfd/dfd-01-intake-quality-check.md` through `dfd-09-extraction-summary.md`) are reserved future paths produced when the operator executes the Build Package 04–09 chain. Numeric accuracy scoring is owned by `prompts/rs/13-accuracy-score.prompt.md` / `skills/rs/SK-ACCURACY-SCORE.md` and activates only when the operator executes the chain. The known mismatch between `tools/New-AisrafRun.ps1`'s legacy 00-run-log header and the Package 09 file shape is recorded as a future Build Package 03 increment compatibility note in `validation/run-log-checklist.md`. The next allowed Build Package is Build Package 13 — Diagrams, but Build Package 13 is **BLOCKED** until `BP12-SAMPLE-DFD-BLOCKER` is resolved via founder-approved Package 10A / 11A correction OR sample-002 with a clean DFD is authorized.

## Foundation Rules

- Keep work inside the active workspace unless an instruction explicitly says to read the old reference package.
- Prefer editing existing Build Package 01 files over creating new files.
- Create only files authorized by the current Build Package contract.
- Do not create unlisted root files or folders.
- Use “Build Package” for the 01-16 implementation sequence.
- Use “Root Area” for package-tree and folder diagram numbering.
- Use the exact lowercase filesystem folder names listed in [FOLDER-CONTRACTS.md](../FOLDER-CONTRACTS.md).
- Do not create diagrams before Build Package 13.
- Do not create run outputs other than the governed Build Package 11 fixture `runs/RUN-001/`. Do not create the 17 RS chain outputs or the 9 DFD outputs inside Build Package 11 — those are reserved future paths produced when the operator executes the Build Package 04–09 chain.
- Do not create release DOCX/PDF/PPTX/ZIP artifacts before Build Package 15.
- Do not claim final QA, seal, or export before Build Package 16.

## Artifact Boundaries

- Prompt: reusable instruction file for Copilot or an agent, active in Build Package 04 (`prompts/prompt-registry.yaml`, `prompts/rs/*.prompt.md`, `prompts/dfd/*.prompt.md`).
- Skill: reusable work contract, not an executable tool, active in Build Package 05 (`skills/skill-registry.yaml`, `skills/rs/SK-*.md`, `skills/dfd/SK-DFD-0[1-9]-*.md`).
- PRA: Prototype Review Agent specification, not a deployed runtime agent, active in Build Package 06 (`prototype-agents/prototype-agent-registry.yaml`, 8 `prototype-agents/PRA-0[1-8]-*.md` files, `prototype-agents/prototype-agent-template.md`).
- `.agent.md` adapter: local VS Code/GitHub Copilot thin wrapper around canonical PRA/prompt/skill artifacts, active in Build Package 06 (7 `.agents/aisraf-*.agent.md` files; PRA-04 has no dedicated adapter and is wrapped jointly by `.agents/aisraf-dfd-extractor.agent.md`).
- Catalog: controlled vocabulary source, active in Build Package 07 (`catalogs/catalog-registry.yaml`, plus 24 YAML catalogs across `catalogs/components/`, `catalogs/interactions/`, `catalogs/boundaries/`, `catalogs/identity-access/`, `catalogs/data-protection/`, `catalogs/security-stacks/`, `catalogs/review/`).
- Blueprint: reusable review pattern, active in Build Package 08 (`blueprints/blueprint-registry.yaml`, `blueprints/blueprint-template.yaml`, 8 `blueprints/platform-independent/BP-*.yaml` files, and 1 `blueprints/cloud-patterns/BP-AI-SAAS-INTEGRATION.yaml` file). Match states are fixed at four values (`matched`, `candidate`, `no_match`, `unknown`).
- Template: reusable output shape, active in Build Package 09 (`templates/template-registry.yaml`, plus 27 file-shape templates under `templates/output/`, 1 Jira draft under `templates/jira/`, 1 Confluence draft under `templates/confluence/`, and 2 row patterns under `templates/run/`). Templates define output shape only; they do not execute the review and do not compute severity, score, AI Action Level, blueprint match, finding facts, or recommendation prose. Catalog values are referenced via `<value-from-catalogs/...>` placeholders — never enumerated inside templates.
- Sample: synthetic test fixture, active in Build Package 10 (`samples/sample-registry.yaml`, plus `samples/sample-001-dfd-crop/` with 6 inputs and 26 Markdown expected baselines mirroring Package 09 templates). Samples are test fixtures, not runs. They do not produce live run outputs, are not runtime evidence, are not release artefacts, and are not external Jira / Confluence / MCP proof. Expected baselines are Markdown-only (founder decision Q1) with optional YAML front matter for traceability/scoring metadata. `expected-00-run-log.md` is not created (founder decision Q2). Samples 002–008 are registry-only `planned_or_deferred_samples` entries with no folders or files (founder decision Q8). Numeric scoring is qualitative until Build Package 11.
- Run: self-contained execution evidence folder, active in Build Package 11 (`runs/<run_id>/` with `README.md`, `run-profile.yaml`, `00-run-log.md`, `inputs/` byte-copies, and `dfd/` reserved). The first canonical governed fixture is `runs/RUN-001/` for `sample-001-dfd-crop`. Build Package 11 establishes the run-evidence model only; it does not execute the chain. The 17 RS chain outputs at the run-folder root and 9 DFD outputs under `dfd/` are reserved future paths produced when the operator executes the Build Package 04–09 chain. Run logs follow the Build Package 09 file shape (`templates/output/output-00-run-log-template.md`) with row patterns from `templates/run/`. Post-back rows are admissible only when `postback_execution_status: executed_by_operator` plus `output_destination_mode: external_postback_executed` plus a destination URL is set. Other `runs/RUN-*` folders are smoke runs and must be removed before commit.
- Validation: evidence-bound checks and gates, expanded in Build Package 12.
- Release: generated reader artifacts only, deferred to Build Package 15.

## Evidence And Claims

Do not claim tests, external post-back, live Copilot adapter execution, cloud runtime, MCP execution, ADK execution, Vertex/GCP execution, Jira/Confluence/Rovo execution, database execution, Terraform execution, release packaging, diagram generation, or final QA unless the correct package authorizes the action and evidence exists in the governed location. Build Package 06 PRA specs and `.agent.md` adapters are local-only specifications and wrappers; selecting an adapter from the Copilot Chat dropdown is not equivalent to runtime execution.

## Build Package 12 Hard Pins

- Do not modify the sample DFD (`samples/sample-001-dfd-crop/inputs/dfd-crop.png`, `samples/sample-001-dfd-crop/inputs/dfd-crop.mmd`, `runs/RUN-001/inputs/dfd-crop.png`, `runs/RUN-001/inputs/dfd-crop.mmd`); only a founder-approved Package 10A / 11A corrective patch or a founder-approved sample-002 may.
- Do not modify any expected baseline under `samples/sample-001-dfd-crop/expected/` to "clean up" the input defect.
- Do not author diagrams (Build Package 13 is BLOCKED until `BP12-SAMPLE-DFD-BLOCKER` is resolved).
- Do not author runbooks, practitioner guides, or `docs/` content beyond the `docs/README.md` placeholder.
- Treat `BP12-SAMPLE-DFD-BLOCKER` as a hard pin: any work that would silently validate the canonical sample DFD as canonical, or that would propagate the defect into a downstream sealed surface, is prohibited.

## Stop Conditions

Stop and report the issue before writing if a requested change would create a prohibited artifact, write outside the allowed package surfaces, modify the old reference workspace, introduce secrets, or claim functionality that has not been implemented by the proper package.
