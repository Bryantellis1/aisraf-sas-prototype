# Prototype Charter

Package: AISRAF SAS Prototype v0.1.2

Status: Active local-first governance charter through WP-12C-ED1 readability and public-safety pass (BP12C trajectory: K1B-A/K1B-B/K2/K3/K3C/K4/K complete; L0/L1A/L1/L2A/L2A-UX/L2B-PLAN/L2B-EXEC complete; QA1 closed with `WP-12C-QA1_PARTIAL_WITH_GAPS`; ED1 active; L3, REL0, WP-13, and WP-ORCH remain blocked).

## Mission

Create a governed local-first security advisory review prototype that lets AISRAF Security Advisory Services test review methods in VS Code and GitHub Copilot using local folders, governed instruction artifacts, structured inputs, structured outputs, and validation gates.

The current operating law is:

```text
Capability -> Value Outcome -> ProcessFlowSpecification -> TaskFlowSpecification -> Agent -> Skill -> Tool / Hook / Policy -> Memory / State -> Evaluation -> Evidence -> Platform Projection -> Plugin / Release
```

## Vision

AISRAF SAS practitioners should be able to stage normal security-review materials locally, run governed review instructions, produce consistent advisory outputs, and hand off results without inventing facts or claiming runtime automation that does not exist.

## Problem Being Solved

Security design reviews often suffer from inconsistent inputs, unclear DFD facts, missing trust-boundary detail, repeated questions, inconsistent finding language, weak handoff records, and blurred separation between design-review closeout and implementation proof. This prototype creates a controlled package path for testing a better review method before promoting anything to integrations or runtime systems.

## Value-First Story

A practitioner can place a DFD and supporting notes in a run input folder, use prompt/skill/adapter instructions to read only from that local input root, write outputs only under the run output root, compare against expected baselines when available, and produce a clearer handoff pack for human review. Optional Jira, Confluence, MCP, GCP, and ADK layers remain later layers and require their own evidence.

## Scope

The prototype remains a local-first governed workbench. Build Package 01 established the package shell; later governed packages added run profiles, tools, prompts, skills, PRAs, catalogs, blueprints, templates, samples, runs, validation, provider projections, hooks, and WP-12C plugin-gate planning. Current WP-12C-K1B-A scope is limited to root authority and folder-contract alignment before validator allow-list edits or plugin scaffold creation.

## Out Of Scope

Build Package 01 does not create prompts, skills, PRA specs, `.agent.md` adapters, catalogs, blueprints, run-profile schemas, samples, expected baselines, run outputs, diagrams, DOCX/PDF/PPTX/ZIP artifacts, executable scripts, runtime code, cloud resources, MCP integrations, ADK artifacts, or final QA seals.

## Local-First Principle

The prototype starts with local files and local evidence. Inputs are staged in local folders. Outputs stay in local run folders. External systems are optional later layers and do not become proof unless a human executes the action and records evidence.

## Folder-First Principle

The package treats folders as contracts. `input_root`, `output_root`, `expected_root`, and run-profile variables define where work is read, written, and scored. Source folders, provider projections, smoke evidence, future plugin packaging, diagrams, documentation, and release outputs each have separate authority boundaries.

## Provider Projection Principle

Canonical source remains in prompts, skills, PRAs, templates, catalogs, blueprints, samples, config, tools, and validation. Provider-facing files under `.github/agents/`, `.github/skills/`, `.github/hooks/`, and `.copilot-skills/` are projections or operator wrappers. They make canonical behavior easier to discover in VS Code / GitHub Copilot, but they do not become the source of truth and they do not authorize runtime, cloud, MCP, Jira, Confluence, Rovo, database, Terraform, or external post-back claims.

`.claude/` is an operator-local projection/configuration surface only. It is not a package surface and must not be staged.

## Plugin Gate Principle

Plugin packaging is projection-only. The plugin lives at `plugins/aisraf-copilot-plugin/` and is **governed and validator-gated** by `tools/Test-AisrafPackage.ps1` Checks 16, 16a (no canonical body duplication), 16b (bundle checksum validation), and 16c (provider install manifest). The plugin bundle under `plugins/aisraf-copilot-plugin/bundle/` mirrors canonical material byte-identically; the bundle never becomes the source of truth and never duplicates canonical bodies as a new authority source.

The completed gate order is: WP-12C-K1B-A authority patch (closed), WP-12C-K1B-B validator allow-list patch (closed), WP-12C-K2 plugin scaffold (closed), WP-12C-K3 projection assembly (closed), WP-12C-K3C bundle checksum manifest (closed), WP-12C-K4 plugin lint and checksum validation (closed), WP-12C-K closeout (closed), WP-12C-L0 install readiness preflight (closed), WP-12C-L1A provider install surface patch (closed), WP-12C-L1 local plugin install (closed), WP-12C-L2A preview-only role smoke (closed), WP-12C-L2A-UX operator usability patch (closed), WP-12C-L2B-PLAN controlled-output smoke plan (closed), WP-12C-L2B-EXEC controlled-output execution (closed under `runs/RUN-SMOKE-PLUGIN-L2B-001/`), and WP-12C-QA1 release-readiness QA report (closed with `WP-12C-QA1_PARTIAL_WITH_GAPS`).

The current gate is WP-12C-ED1 (repository editor readability and public-safety pass, including RB-003 / RB-004 corrections). WP-12C-L3 staging / publication decision is BLOCKED until the QA1 blocker register (RB-001..RB-005) closes. WP-12C-REL0 release-manifest work is BLOCKED until L3 publication readiness is granted. WP-13 diagrams are BLOCKED until post-L3. WP-ORCH (true AL3 orchestrated multi-agent runtime) is FUTURE and not in v0.1.2 scope — the current autonomy level is AL2 controlled-output local workbench.

## Root Area Principle

Root Area numbers identify the visible package-tree rows used in folder contracts, documentation, and future diagrams. Root Area 01 is Root & Top-Level Files; Root Areas 02-19 map to the 18 active package root folders. Future `plugins/` is not an active Root Area until the validator allow-list gate admits it. Root Area numbers are not Build Package numbers.

## Prompt + Specification + Validation Principle

Every future build agent must receive a complete triad:

- Prompt / Mission: who the agent is, what value it creates, what it may touch, and what it must not touch.
- Specification / Build Contract: exact files, folders, fields, naming, dependencies, allowed writes, prohibited writes, and source references.
- Validation / Acceptance Gate: checklist, stop conditions, critical misses, evidence required, pass/partial/fail rules, and final response format.

This triad prevents vague instructions and stops drift.

## Build Package Sequence Principle

The package is built in order from Build Package 01 through Build Package 16. Later Build Package content must not be created early. A Build Package may reserve structure for later use, but it must not claim later functionality as implemented.

## Old Reference Package Policy

The old v0.01 package is read-only reference material. It may inform terminology, boundaries, and lessons learned. It must not be modified, treated as current truth, or copied wholesale into the clean v0.1.2 rebuild.

## No-Drift Principle

No Build Package may create unlisted files, hidden reports, uncontrolled vocabulary, release artifacts before Build Package 15, diagrams before Build Package 13, run outputs before Build Package 11, or runtime/cloud claims without proof and authorization.

## Evidence Principle

Claims require evidence. A local file is evidence only for the action it records. Jira/Confluence/MCP post-back, live Copilot adapter selection, cloud runtime, ADK execution, release packaging, and final QA must not be claimed without the correct Build Package authorization and recorded evidence.

## Release Principle

Release artifacts are generated reader artifacts only. DOCX, PDF, PPTX, and ZIP outputs belong to Build Package 15 release packaging and Build Package 16 final QA/export. Build Package 01 creates no release artifacts.

## Diagram Principle

Diagrams belong to Build Package 13. Build Package 01 may create the `diagrams/` README only. It must not create diagram source, PNG, SVG, PDF, alt-text, diagram index, or rendered diagram files.

## Runtime / Cloud Principle

This prototype is not runtime proof. GCP, ADK, cloud deployment, databases, Terraform, autonomous orchestration, and production integrations are future promotion targets and must not be represented as implemented by Build Package 01.
