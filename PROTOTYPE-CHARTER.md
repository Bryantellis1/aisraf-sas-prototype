# Prototype Charter

Package: AISRAF SAS Prototype v0.1.2

Status: Build Package 01 foundation charter.

## Mission

Create a governed local-first security advisory review prototype that lets AISRAF Security Advisory Services test review methods in VS Code and GitHub Copilot using local folders, governed instruction artifacts, structured inputs, structured outputs, and validation gates.

## Vision

AISRAF SAS practitioners should be able to stage normal security-review materials locally, run governed review instructions, produce consistent advisory outputs, and hand off results without inventing facts or claiming runtime automation that does not exist.

## Problem Being Solved

Security design reviews often suffer from inconsistent inputs, unclear DFD facts, missing trust-boundary detail, repeated questions, inconsistent finding language, weak handoff records, and blurred separation between design-review closeout and implementation proof. This prototype creates a controlled package path for testing a better review method before promoting anything to integrations or runtime systems.

## Value-First Story

A practitioner can place a DFD and supporting notes in a run input folder, use prompt/skill/adapter instructions to read only from that local input root, write outputs only under the run output root, compare against expected baselines when available, and produce a clearer handoff pack for human review. Optional Jira, Confluence, MCP, GCP, and ADK layers remain later layers and require their own evidence.

## Scope

Build Package 01 establishes the package shell: root README, start guide, manifest, charter, folder contracts, build order, Root Area README placeholders, authoring-agent instruction standard, and Build Package 01 validation checklists.

## Out Of Scope

Build Package 01 does not create prompts, skills, PRA specs, `.agent.md` adapters, catalogs, blueprints, run-profile schemas, samples, expected baselines, run outputs, diagrams, DOCX/PDF/PPTX/ZIP artifacts, executable scripts, runtime code, cloud resources, MCP integrations, ADK artifacts, or final QA seals.

## Local-First Principle

The prototype starts with local files and local evidence. Inputs are staged in local folders. Outputs stay in local run folders. External systems are optional later layers and do not become proof unless a human executes the action and records evidence.

## Folder-First Principle

The package treats folders as contracts. `input_root`, `output_root`, `expected_root`, and later run-profile variables define where work is read, written, and scored. Build Package 01 reserves those folders and documents the rules; later Build Packages implement the detailed model.

## Root Area Principle

Root Area numbers identify the visible package-tree rows used in folder contracts, documentation, and future diagrams. Root Area 01 is Root & Top-Level Files; Root Areas 02-18 map to the 17 actual root folders. Root Area numbers are not Build Package numbers.

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
