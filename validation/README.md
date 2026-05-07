# validation/

Root Area: Root Area 16.

Owning Build Package: Build Package 12 — Validation, with Build Package 01 owning the initial foundation checks.

## Purpose

Package validation, no-drift, and readiness gate folder. The `validation/` folder is the canonical home of carried-forward blockers across the prototype build sequence. Every checklist is structured as: Identity → Scope → Inputs → Gates (numbered, objective, evidence-bound) → Acceptance Verdict → Stop Conditions → Tool References. Every gate names the artefact path and the falsifiable check.

## Blockers (Carried Forward)

> **`BP12-SAMPLE-DFD-BLOCKER`** — severity HARD, owner founder, blocks BP13 entry.
>
> The current canonical sample DFD (`samples/sample-001-dfd-crop/inputs/dfd-crop.png` and the byte-copy under `runs/RUN-001/inputs/dfd-crop.png`, plus the Mermaid source `dfd-crop.mmd`) mixes extraction IDs with visual architecture notation, uses BND-/CMP-/F-style labels as primary diagram language, has weak/incorrect boundary semantics, and does not consistently follow AISRAF flow-label grammar or data-store annotation rules. Build Package 12 records the defect as a hard, named, non-silent blocker. Build Package 12 does NOT modify the sample. Resolution is owned by founder via a future Package 10A / 11A corrective patch OR via sample-002 authorization.
>
> **Recorded in:**
> - [sample-input-readiness-checklist.md](sample-input-readiness-checklist.md) — gates 7, 8, 11, 12, 13, 14, 15, 16 FAIL with the blocker cited.
> - [expected-output-lint-checklist.md](expected-output-lint-checklist.md) — gates 18–22 PARTIAL_WITH_ISSUES with the blocker cited.
> - [diagram-readiness-pre-render-checklist.md](diagram-readiness-pre-render-checklist.md) — gate 0 NOT MET; every downstream gate BLOCKED. BP13 entry denied.
> - [no-drift-rules.md](no-drift-rules.md) — BP12 amendments naming the sample-DFD non-modification rule.
> - [package-12-validation-checklist.md](package-12-validation-checklist.md) — falsifiable cross-reference gate (§4) verifying the literal `BP12-SAMPLE-DFD-BLOCKER` appears in the seven required files.
> - [final-qa-checklist.md](final-qa-checklist.md) — closing-gate bullet citing the blocker.
> - [../PACKAGE-MANIFEST.yaml](../PACKAGE-MANIFEST.yaml) — `carried_forward_blockers` block.

## Validation Taxonomy (Run Order: 1 → 2 → 3 → 4 → 5 → 6 → 7 → 8)

Failure or BLOCKED at any gate stops the chain; downstream gates are not evaluated.

### 1. Package Gates — per-package contract conformance

- [package-01-foundation-checklist.md](package-01-foundation-checklist.md)
- [package-02-config-checklist.md](package-02-config-checklist.md)
- [package-03-tools-checklist.md](package-03-tools-checklist.md)
- [package-04-prompts-checklist.md](package-04-prompts-checklist.md)
- [package-05-skills-checklist.md](package-05-skills-checklist.md)
- [package-06-agents-checklist.md](package-06-agents-checklist.md)
- [package-07-catalogs-checklist.md](package-07-catalogs-checklist.md)
- [package-08-blueprints-checklist.md](package-08-blueprints-checklist.md)
- [package-09-templates-checklist.md](package-09-templates-checklist.md)
- [package-10-samples-checklist.md](package-10-samples-checklist.md)
- [package-11-runs-checklist.md](package-11-runs-checklist.md)
- [package-12-validation-checklist.md](package-12-validation-checklist.md)

Validator coverage: `tools/Test-AisrafPackage.ps1` enforces the surface (file allow-lists, folder layouts, Build Package 11 `runs/RUN-001/` shape, Build Package 12 `.gitkeep` allowance, Build Package 12 `validation/` allow-list).

### 2. Registry Gates — each registry internally consistent

- [prompt-registry-checklist.md](prompt-registry-checklist.md)
- [skill-registry-checklist.md](skill-registry-checklist.md)
- [agent-registry-checklist.md](agent-registry-checklist.md)
- [catalog-registry-checklist.md](catalog-registry-checklist.md)
- [blueprint-registry-checklist.md](blueprint-registry-checklist.md)
- [template-registry-checklist.md](template-registry-checklist.md)
- [sample-registry-checklist.md](sample-registry-checklist.md)

Validator coverage: human-review consistency gates; `tools/Test-AisrafPackage.ps1` enforces filename and count surface.

### 3. Chain Gates — chain executable, scoring well-defined, baselines do not normalize input defects

- [prompt-skill-pra-parity-checklist.md](prompt-skill-pra-parity-checklist.md)
- [prototype-execution-readiness-checklist.md](prototype-execution-readiness-checklist.md)
- [expected-output-lint-checklist.md](expected-output-lint-checklist.md)
- [scoring-rubric-checklist.md](scoring-rubric-checklist.md)
- [prompt-skill-agent-mapping-checklist.md](prompt-skill-agent-mapping-checklist.md)
- [catalog-consumption-checklist.md](catalog-consumption-checklist.md)
- [blueprint-catalog-consumption-checklist.md](blueprint-catalog-consumption-checklist.md)
- [template-consumption-checklist.md](template-consumption-checklist.md)

Validator coverage: human-review crosswalk and consumption gates; numeric scoring is owned by `skills/rs/SK-ACCURACY-SCORE.md` and activates only when the operator executes the chain.

### 4. Sample Gates — sample-001 inputs honest; 26 baselines well-formed

- [sample-input-readiness-checklist.md](sample-input-readiness-checklist.md) — **FAIL for sample-001 via `BP12-SAMPLE-DFD-BLOCKER`**.
- [sample-baseline-checklist.md](sample-baseline-checklist.md)

Validator coverage: surface (filename, count) via `tools/Test-AisrafPackage.ps1` Check `08h-samples-content-limits`; diagrammatic-quality and content lint via human review.

### 5. Run Gates — RUN-001 executable; future runs follow contract

- [run-folder-shape-checklist.md](run-folder-shape-checklist.md)
- [run-log-checklist.md](run-log-checklist.md)
- [run-comparison-checklist.md](run-comparison-checklist.md)
- [local-run-readiness-checklist.md](local-run-readiness-checklist.md)

Validator coverage: surface via `tools/Test-AisrafPackage.ps1` Check `08i-runs-content-limits` (BP11 + BP12 `.gitkeep` allowance) and Check 14 (RUN-001 governance vs other runs/RUN-* WARN); run-profile schema via `tools/Test-AisrafRunProfile.ps1`.

### 6. Cross-Cutting Hygiene — file-ref integrity; no drift; vocabulary discipline

- [package-lint-master-checklist.md](package-lint-master-checklist.md)
- [no-drift-rules.md](no-drift-rules.md)

Validator coverage: human-review roll-up gate; `tools/Test-AisrafPackage.ps1` enforces surface-level lint.

### 7. Forward Gates — BP13 pinned by blocker; BP14/BP15 entry conditions

- [diagram-readiness-pre-render-checklist.md](diagram-readiness-pre-render-checklist.md) — **BLOCKED by `BP12-SAMPLE-DFD-BLOCKER`**.
- [docs-readiness-pre-render-checklist.md](docs-readiness-pre-render-checklist.md) — sample-tied sections inherit the blocker.
- [release-readiness-checklist.md](release-readiness-checklist.md) — Build Package 15 placeholder; not in scope for BP12 framework deliverable.

Validator coverage: human-review pre-render gates; `tools/Test-AisrafPackage.ps1` Check `08-folder-readme-only-rule` enforces `diagrams/` and `docs/` as README-only.

### 8. Final QA — terse closing gate citing blocker

- [final-qa-checklist.md](final-qa-checklist.md)

Validator coverage: human-review closing gate; both validator scripts must be green.

## What Belongs Here

Build Package 01 includes the foundation checklist, no-drift rules, and release-readiness placeholder. Build Package 12 expands validation into full package, registry, chain, sample, run, cross-cutting, forward, and final-QA gates plus the carried-forward `BP12-SAMPLE-DFD-BLOCKER`.

## What Does Not Belong Here

Generated run outputs, release binaries, hidden reports, executable validators, lowered standards, diagrams, runtime proof, runbook prose, or operator-walkthrough narratives.

## Current Status

Active for Build Package 01–12 validation files. Build Package 12 is the most recent, pending human review before commit. Build Package 13 (Diagrams) is BLOCKED behind `BP12-SAMPLE-DFD-BLOCKER`.
