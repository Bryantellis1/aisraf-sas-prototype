# Build Order

Package: AISRAF SAS Prototype v0.1.2

This file defines the governed Build Package sequence. Build Package numbers are implementation phases, not Root Area numbers or folder paths. Root Area numbering is defined in [FOLDER-CONTRACTS.md](FOLDER-CONTRACTS.md) and [PACKAGE-MANIFEST.yaml](PACKAGE-MANIFEST.yaml).

## Current WP-12C K/L Gate Overlay

This overlay governs the active plugin-gate path. It records WP-12C-K plugin packaging complete, WP-12C-L0..L2B controlled-output execution complete, WP-12C-QA1 release-readiness QA report closed with documentation-class warnings, and WP-12C-ED1 active. WP-12C-L3 staging / publication, WP-12C-REL0 release-manifest, WP-13 diagrams, and WP-ORCH (true AL3 orchestrated multi-agent runtime) remain blocked. Current autonomy level is AL2 controlled-output local workbench.

| Gate | Status | Next Action Constraint |
|---|---|---|
| WP-12C-H | BLACK / CLOSED | No action. |
| WP-12C-I | BLACK / CLOSED | No action. |
| WP-12C-J1 | BLACK / CLOSED | No action. |
| WP-12C-J2A | BLACK / CLOSED | No action. |
| WP-12C-J2B | BLACK / CLOSED | No action. |
| Full WP-12C-J | BLACK / CLOSED | No action. |
| WP-12C-K0/K1 | BLACK / CLOSED | No action. |
| WP-12C-K1A | BLACK / CLOSED | No action. |
| WP-12C-K1B-A | BLACK / CLOSED | No action. |
| WP-12C-K1B-B | BLACK / CLOSED | No action. |
| WP-12C-K2 | BLACK / CLOSED | No action. |
| WP-12C-K3 | BLACK / CLOSED | No action. |
| WP-12C-K3C | BLACK / CLOSED | Bundle checksum manifest complete and validated by Check 16b. |
| WP-12C-K4 | BLACK / CLOSED | Status `WP-12C-K4_PLUGIN_PACKAGE_VALIDATION_PASS_READY_FOR_INSTALL_TESTING`. |
| WP-12C-K | BLACK / CLOSED | Status `WP-12C-K_PACKAGE_COMPLETE_READY_FOR_INSTALL_READINESS_PREFLIGHT`. |
| WP-12C-L0 | BLACK / CLOSED | Install readiness preflight complete. |
| WP-12C-L1A | BLACK / CLOSED | Provider install surface patch (`plugin.json`) complete; Check 16c PASS. |
| WP-12C-L1 | BLACK / CLOSED | Local plugin install complete. |
| WP-12C-L2A | BLACK / CLOSED | Preview-only role smoke pass from clean smoke workspace. |
| WP-12C-L2A-UX | BLACK / CLOSED | Operator usability runbook patch complete. |
| WP-12C-L2B-PLAN | BLACK / CLOSED | Controlled-output smoke plan accepted under founder approval. |
| WP-12C-L2B-EXEC | BLACK / CLOSED | Controlled-output execution complete under `runs/RUN-SMOKE-PLUGIN-L2B-001/`; 0 FAIL across the four validators; 17 RS + 9 DFD outputs captured; no overclaim. |
| WP-12C-QA1 | BLACK / CLOSED | `WP-12C-QA1_PARTIAL_WITH_GAPS`; RB-001..RB-005 recorded in `validation/package-12c-release-blocker-register.md`. |
| WP-12C-ED1 | CURRENT | Repository editor readability and public-safety pass; closes RB-003 (manifest / charter / build-order alignment) and RB-004 (install-checklist frontmatter refresh); no docs/ promotion, no release artifact, no staging. |
| WP-12C-L3 | BLOCKED | Install evidence and Git staging / publication decision blocked until RB-001..RB-005 close. |
| WP-12C-REL0 | BLOCKED | Release manifest, license, notice, changelog, contribution; blocked until L3 publication readiness. |
| WP-13 | BLOCKED | Diagrams blocked until post-L3 release-gate authorization. |
| WP-14 | FUTURE | Solution package only after WP-13 evidence. |
| WP-15 | FUTURE | Future runtime projection strategy only; no runtime implementation. |
| WP-ORCH | FUTURE | True AL3 orchestrated multi-agent runtime — not in v0.1.2 scope. |

Required order through WP-12C: WP-12C-K1B-A -> WP-12C-K1B-B -> WP-12C-K2 -> WP-12C-K3 -> WP-12C-K3C -> WP-12C-K4 -> WP-12C-K closeout -> WP-12C-L0 -> WP-12C-L1A -> WP-12C-L1 -> WP-12C-L2A -> WP-12C-L2A-UX -> WP-12C-L2B-PLAN -> WP-12C-L2B-EXEC -> WP-12C-QA1 -> WP-12C-ED1 -> WP-12C-L3 -> WP-12C-REL0 -> WP-13 -> WP-14 -> WP-15.

WP-ORCH (true AL3 orchestrated multi-agent runtime) sits outside this ordered chain as a separately sponsored future work package; it is not a v0.1.2 release prerequisite.

Projection rule: plugin packaging is a projection layer governed by `tools/Test-AisrafPackage.ps1` Checks 16, 16a (no canonical body duplication), 16b (bundle checksum validation), and 16c (provider install manifest). Canonical authority remains in prompts, skills, PRAs, templates, catalogs, blueprints, samples, config, tools, validation, and governed provider projections.

## Build Package 01 — Foundation, root structure, charter, manifest, folder contracts, build order, and authoring-agent standard

Mission: create the clean governed shell future agents can trust.

Inputs: this Build Package 01 mission, the empty active workspace, and the old v0.01 reference package as read-only context.

Outputs: root files, folder README placeholders, authoring-agent templates, and Build Package 01 validation checklists.

Dependencies: none.

Validation gate: required root structure exists, manifest aligns, no unauthorized later-build artifacts exist, and Build Package 02 is clearly identified.

Prohibited actions: diagrams, prompts, skills, PRAs, adapters, catalogs, blueprints, samples, run outputs, executable scripts, schemas, release artifacts, runtime code, cloud resources, git staging, or commits.

Ready-for-next condition: Build Package 01 foundation validation passes or remaining issues are explicitly listed.

## Build Package 02 — Config and run-profile variable model

Mission: define the local-first variable model for `run_id`, `sample_id`, `input_root`, `output_root`, `expected_root`, and safe defaults.

Inputs: Build Package 01 charter, manifest, folder contracts, and old run-profile lessons.

Outputs: config files, run-profile model, variable examples, and config validation guidance.

Dependencies: Build Package 01.

Validation gate: variables are clear, safe defaults are explicit, no secrets are stored, and no execution is claimed.

Prohibited actions: tools, prompt cards, skill contracts, run outputs, diagrams, release artifacts, cloud/MCP proof.

Ready-for-next condition: Build Package 03 can build tools against a stable variable contract.

## Build Package 03 — Tools and setup/test/export scripts

Mission: add governed local helper tooling for setup and validation where authorized.

Inputs: Build Package 01 structure and Build Package 02 variable model.

Outputs: scripts, tool README updates, and tool validation evidence.

Dependencies: Build Packages 01 and 02.

Validation gate: tools write only to authorized paths, avoid secrets, and make no runtime/cloud/post-back claims.

Prohibited actions: prompts, skills, PRAs, catalogs, blueprints, samples, diagrams, release binaries, cloud resources.

Ready-for-next condition: Build Package 04 can rely on setup and validation helpers where needed.

## Build Package 04 — Prompts and prompt registry

Mission: create canonical prompt cards and their registry for local Copilot execution.

Inputs: Build Packages 01-03, variable model, folder contracts, and prompt lessons from the old package.

Outputs: prompt cards, prompt registry, and prompt validation checks.

Dependencies: Build Packages 01, 02, and 03.

Validation gate: prompts resolve variables, read from `input_root`, write only under `output_root`, stop on missing inputs, and do not duplicate skills or PRAs.

Prohibited actions: skills as executable tools, PRA specs, adapter files, catalogs, blueprints, samples, run outputs, diagrams, release artifacts.

Ready-for-next condition: Build Package 05 can map skill contracts to prompt behavior.

## Build Package 05 — Skills and skill registry

Mission: create reusable work contracts and the skill registry.

Inputs: Build Packages 01-04 and old skill lessons.

Outputs: skill contracts, skill registry, and skill validation checks.

Dependencies: Build Packages 01-04.

Validation gate: each skill has purpose, inputs, outputs, stop conditions, scoring relationship, expected behavior, and no executable implementation.

Prohibited actions: runtime tools, PRA specs, adapter wrappers, catalogs, blueprints, samples, run outputs, diagrams, release artifacts.

Ready-for-next condition: Build Package 06 can group skills and prompts into PRA responsibilities.

## Build Package 06 — Prototype agents, PRA specs, and .agent.md adapter model

Mission: define PRA specifications and local adapter rules without claiming deployed runtime agents.

Inputs: Build Packages 01-05 and old PRA/adapter lessons.

Outputs: PRA specs, PRA registry, `.agent.md` adapter model, and adapter validation guidance.

Dependencies: Build Packages 01-05.

Validation gate: PRAs are specifications, adapters are thin local wrappers, and canonical prompts/skills remain authoritative.

Prohibited actions: deployed agents, cloud/ADK runtime, autonomous post-back, catalogs, blueprints, samples, run outputs, diagrams, release artifacts.

Ready-for-next condition: Build Package 07 can supply controlled vocabulary for prompts, skills, and PRAs.

## Build Package 07 — Catalogs

Mission: create controlled vocabulary and classification sources.

Inputs: Build Packages 01-06 and old catalog lessons.

Outputs: catalog families, catalog index, and catalog validation checks.

Dependencies: Build Packages 01-06.

Validation gate: vocabulary is controlled, mapped, and prevents invented component, interaction, auth, data, boundary, and finding labels.

Prohibited actions: blueprints, templates, samples, run outputs, diagrams, release artifacts, runtime code, cloud claims.

Ready-for-next condition: Build Package 08 can build blueprint patterns using controlled vocabulary.

## Build Package 08 — Blueprints

Mission: create reusable review patterns for matching observed design shapes.

Inputs: Build Packages 01-07 and old blueprint lessons.

Outputs: blueprint files, blueprint index, and blueprint validation checks.

Dependencies: Build Packages 01-07.

Validation gate: blueprints use catalog terms, avoid implementation-proof claims, and define match limits.

Prohibited actions: templates, samples, run outputs, diagrams, release artifacts, runtime code, cloud claims.

Ready-for-next condition: Build Package 09 can create templates for outputs and review artifacts.

## Build Package 09 — Templates

Mission: define reusable shapes for outputs, run logs, drafts, recommendations, validation notes, and reports.

Inputs: Build Packages 01-08 and old template lessons.

Outputs: templates, template index, and template validation checks.

Dependencies: Build Packages 01-08.

Validation gate: templates preserve folder-first rules, evidence boundaries, and human review gates.

Prohibited actions: samples, run outputs, diagrams, release artifacts, executable code, cloud/MCP claims.

Ready-for-next condition: Build Package 10 can build samples and expected baselines against stable templates.

## Build Package 10 — Samples and expected baselines

Mission: add synthetic input samples and expected baselines for scoring.

Inputs: Build Packages 01-09 and old sample lessons.

Outputs: sample folders, synthetic inputs, expected baselines, sample index, and sample validation checks.

Dependencies: Build Packages 01-09.

Validation gate: samples contain no real sensitive payloads or secrets, expected baselines are stable, and rebaseline rules are explicit.

Prohibited actions: actual run outputs, diagrams, release artifacts, runtime code, cloud/MCP proof.

Ready-for-next condition: Build Package 11 can define execution evidence using sample and baseline contracts.

## Build Package 11 — Runs and execution evidence model

Mission: define self-contained run folders and evidence expectations.

Inputs: Build Packages 01-10 and old run lessons.

Outputs: run folder model, run profile placement, run log expectations, output rules, and scoring evidence model.

Dependencies: Build Packages 01-10.

Validation gate: all run writes stay inside `runs/<run_id>/`, logs record accepted steps, and scoring compares actual outputs to expected baselines only when present.

Prohibited actions: package source mutation during a run, diagrams, release artifacts, cloud/MCP proof without execution evidence.

Ready-for-next condition: Build Package 12 can validate packages, runs, prompts, skills, diagrams, and release gates.

## Build Package 12 — Validation

Mission: create full validation checklists and gates for package, prompt, skill, run, diagram, and release alignment.

Inputs: Build Packages 01-11 and old validation lessons.

Outputs: validation checklists, gates, scoring checks, and readiness reports.

Dependencies: Build Packages 01-11.

Validation gate: checks are objective, evidence-bound, and do not lower standards to pass.

Prohibited actions: diagrams, release binaries, runtime/cloud claims, hidden reports, unregistered validation outputs.

Ready-for-next condition: Build Package 13 can create diagrams under explicit diagram validation rules.

## Build Package 13 — Diagrams

Mission: create governed diagrams and accessibility/parity material.

Inputs: Build Packages 01-12 and old diagram lessons for naming and pitfalls.

Outputs: diagram sources, rendered assets, alt text, diagram index, and diagram validation evidence.

Dependencies: Build Packages 01-12 plus WP-12C-L plugin install validation evidence.

Validation gate: diagrams are readable, accurately scoped, parity is tracked, future-state views do not claim current implementation, and stale assets are not promoted.

Prohibited actions: release binaries, runtime/cloud proof, prompt/skill/PRA changes unless separately authorized.

Ready-for-next condition: WP-14 / Build Package 14 can reference approved diagrams in the governed solution package or practitioner documentation only after WP-13 evidence passes.

## Build Package 14 — Practitioner documentation, runbooks, and WP-14 solution package

Mission: create operator-facing documentation, practitioner guides, mappings, runbooks, and, when WP-14 is authorized, the descriptive solution package built from canonical assets and WP-12C-L/WP-13 evidence.

Inputs: Build Packages 01-13.

Outputs: docs, runbooks, mappings, guides, and documentation validation checks.

Dependencies: Build Packages 01-13 and the WP-12C-L/WP-13 evidence chain for any WP-14 solution package material.

Validation gate: docs match charter, manifest, folder contracts, build order, prompts, skills, PRAs, catalogs, blueprints, templates, samples, runs, validation, and diagrams.

Prohibited actions: release binaries, ZIPs, runtime/cloud claims, unsupported integration claims, TM Forum compliance/certification claims, or any canonical asset rewrite.

Ready-for-next condition: Build Package 15 / WP-15 can proceed only with stable documentation, approved solution-package evidence, and no unsupported implementation claim.

## Build Package 15 — Release packaging and WP-15 future runtime projection strategy

Mission: generate reader artifacts only when release packaging is authorized and, for WP-15, document future runtime projection strategy only. WP-15 does not implement runtime adapters, cloud deployment, MCP servers, databases, Terraform, or external post-back.

Inputs: Build Packages 01-14, WP-12C-L/WP-13/WP-14 evidence when applicable, and release readiness evidence.

Outputs: release notes, release manifest, generated DOCX/PDF/PPTX/ZIP artifacts if authorized, release validation evidence, and future runtime projection strategy documents if separately authorized.

Dependencies: Build Packages 01-14.

Validation gate: release outputs match source, diagrams are approved or waived, no runtime/cloud proof is implied, and controlled-release status is honest.

Prohibited actions: final QA seal without Build Package 16, unauthorized ZIP, release claims without evidence, cloud/MCP/ADK proof claims, runtime adapter scaffolding, cloud deployment artifacts, or autonomy-level promotion without a separate sponsoring work package.

Ready-for-next condition: Build Package 16 can perform final QA, seal, and export review.

## Build Package 16 — Final QA, seal, and export

Mission: perform final package QA, seal the package, and approve export status.

Inputs: Build Packages 01-15 and all validation evidence.

Outputs: final QA results, seal decision, final export status, and remaining blocker register.

Dependencies: Build Packages 01-15.

Validation gate: every build package gate passes or has an explicit blocker/waiver, release artifacts are authorized, and no unsupported claim remains.

Prohibited actions: retroactive hidden fixes, unrecorded waivers, unsupported runtime/cloud/MCP/ADK claims, git staging or commits unless separately requested.

Ready-for-next condition: package is ready for the stated distribution posture or blocked with exact issues.
