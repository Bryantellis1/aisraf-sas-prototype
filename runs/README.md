# runs/

Root Area: Root Area 13.

Owning Build Package: Build Package 11 — Runs and execution evidence model.

## Purpose

Self-contained execution evidence folders. Each `runs/<run_id>/` folder carries a Build Package 02 schema-compliant `run-profile.yaml`, a Build Package 09 file-shape compliant `00-run-log.md`, byte-copies of the staged inputs under `inputs/`, and reserved paths for the 17 RS outputs (top level) and 9 DFD subskill outputs (under `dfd/`).

Build Package 11 establishes this run-evidence model and produces the first canonical governed fixture, [RUN-001/](RUN-001/), against `sample-001-dfd-crop`. Build Package 11 does **not** execute the Build Package 04–09 chain.

## What Belongs Here

- `runs/README.md` — this file.
- `runs/RUN-001/` — first canonical governed run fixture (Build Package 11). Contains:
  - `runs/RUN-001/README.md` — run scope, posture, and reserved future outputs.
  - `runs/RUN-001/run-profile.yaml` — Build Package 02 schema-compliant.
  - `runs/RUN-001/00-run-log.md` — Build Package 09 file-shape compliant; rows empty until the chain runs.
  - `runs/RUN-001/inputs/` — 6 byte-copies of `samples/sample-001-dfd-crop/inputs/`.
  - `runs/RUN-001/dfd/` — empty governed folder reserved for the 9 DFD subskill outputs.

When the operator executes the chain, the 17 RS outputs (`01-input-inventory.md` … `17-accuracy-score.md`) land at the top level of `runs/RUN-001/` and the 9 DFD outputs (`dfd-01-intake-quality-check.md` … `dfd-09-extraction-summary.md`) land under `runs/RUN-001/dfd/`. Build Package 11 reserves the paths only; it does not produce any of the 26 outputs.

The canonical run-folder shape is pinned in [validation/run-folder-shape-checklist.md](../validation/run-folder-shape-checklist.md). The run-log shape is pinned in [validation/run-log-checklist.md](../validation/run-log-checklist.md). The comparison/scoring procedure is pinned in [validation/run-comparison-checklist.md](../validation/run-comparison-checklist.md).

Other `runs/RUN-*` folders produced by `tools/New-AisrafRun.ps1` for smoke testing must be removed before human git stage (per `validation/no-drift-rules.md` and Build Package 03 cleanup rule). `tools/Test-AisrafPackage.ps1` records each non-RUN-001 folder as WARN.

## What Does Not Belong Here

- Source artifacts, expected baselines (those live under `samples/<sample_id>/expected/` and are read-only at run time), hidden reports, secrets, credentials, real PII / PAN / SSN / PHI / production endpoints, diagrams, release exports, package source files, or any file claiming runtime / cloud / ADK / MCP / Jira post-back / Confluence publication / Rovo / database / Terraform execution unless `postback_execution_status: executed_by_operator` plus a matching `templates/run/postback-log-entry-row-template.md` row in `00-run-log.md` exists.
- Top-level files at `runs/` other than `README.md`.
- Subfolders under any `runs/<run_id>/` other than `inputs/` and `dfd/`.
- Files under any `runs/<run_id>/` other than the run-folder canonical files (README.md, run-profile.yaml, 00-run-log.md), the 17 RS outputs at top level, and any operator-driven post-back artefact (`jira-ticket-draft.md`, `confluence-page-draft.md`).
- Any modification to files under `samples/<sample_id>/` from a run.
- Any write to the old reference workspace (`D:/E-Way 2/aisraf-sas-prototype-skill-chain-pack-v0.01`).

## When Populated

Build Package 11. Active.

## Current Status

Active. RUN-001 is the first canonical governed run fixture. Other `runs/RUN-*` folders are smoke runs and remain uncommitted.
