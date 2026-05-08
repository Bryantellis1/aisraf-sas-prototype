# Build Package 12 — Validation Acceptance Checklist

Authored by: BUILD-AG-12-VALIDATION-R1.

Scope: confirms the Build Package 12 surface for AISRAF SAS Prototype v0.1.2 — the validation framework standup. Build Package 12 stands up package, registry, chain, sample, run, cross-cutting, forward, and final-QA gates without lowering any standard, fabricating evidence, modifying any sealed BP01–BP11 surface, or producing any forward-package artefact (no diagrams, no runbooks, no release).

Build Package 12 also records and carries forward `BP12-SAMPLE-DFD-BLOCKER` as a hard, named, non-silent blocker on the canonical sample DFD (`samples/sample-001-dfd-crop/inputs/dfd-crop.png`/`.mmd` and the byte-copy under `runs/RUN-001/inputs/`). BP12 does not modify the sample DFD; only a founder-approved Package 10A / 11A corrective patch or a founder-approved sample-002 may.

> **`BP12-SAMPLE-DFD-BLOCKER: RESOLVED-BY-10A-AND-11A` (full resolution).** Build Package 10A reworked the canonical sample DFD into a realistic GCP-style architecture review diagram with the default 4-token flow-tuple standard and embedded LEGEND panel; Build Package 11A byte-refreshed `runs/RUN-001/inputs/` from the corrected sample (SHA-256 byte-equality verified across all 6 inputs). The falsifiable cross-reference gate continues to PASS — every cited file carries the upgraded `RESOLVED-BY-10A-AND-11A` annotation. See `validation/package-10a-corrective-patch-checklist.md` and `validation/package-11a-input-refresh-checklist.md` for the falsifiable evidence. BP13 (Diagrams) is now `next_allowed`.

## Identity

- Package: Build Package 12 — Validation.
- Owning agent: BUILD-AG-12-VALIDATION-R1.
- Sealed surfaces (read-only): `prompts/`, `skills/`, `prototype-agents/`, `.agents/`, `catalogs/`, `blueprints/`, `templates/`, `samples/`, `config/`, `runs/RUN-001/run-profile.yaml`, `runs/RUN-001/00-run-log.md`, `runs/RUN-001/inputs/`, `runs/RUN-001/README.md`, `tools/New-AisrafRun.ps1`, `tools/Test-AisrafRunProfile.ps1`, the old reference workspace, the `release/` folder.
- Carried-forward blocker: `BP12-SAMPLE-DFD-BLOCKER` (severity HARD, owner founder, pins BP13 entry).

## Inputs

- `PACKAGE-MANIFEST.yaml#build_package_12_allowed_writes`.
- The 10 new BP12 validation files (this file plus the 9 cross-cutting / sample / run / forward / closure gates).
- `validation/README.md` (rebuilt as taxonomy index).
- `validation/no-drift-rules.md` (BP12 amendments appended).
- `runs/RUN-001/dfd/.gitkeep` (fresh-clone reservation marker).
- Surgical patches in `tools/Test-AisrafPackage.ps1` (Check 08i `.gitkeep` allowance + Check 11 allow-list extension).

## Acceptance Verdict Legend

- **PASS** — gate evidence is present, objective, and confirms the contract.
- **PARTIAL_WITH_ISSUES** — gate evidence exists but a documented gap or carried-forward defect is present and named.
- **FAIL** — gate evidence is absent, contradicts the contract, or fabricates a clean PASS over a known defect.
- **BLOCKED** — a hard precondition (named blocker) is unresolved; downstream gates do not evaluate.

## 1. BP12 Surface Inventory

| # | Check | Expected | Status |
|---|---|---|---|
| 1 | `validation/package-12-validation-checklist.md` exists. | present | PASS |
| 2 | `validation/scoring-rubric-checklist.md` exists. | present | PASS |
| 3 | `validation/package-lint-master-checklist.md` exists. | present | PASS |
| 4 | `validation/expected-output-lint-checklist.md` exists. | present | PASS |
| 5 | `validation/prompt-skill-pra-parity-checklist.md` exists. | present | PASS |
| 6 | `validation/sample-input-readiness-checklist.md` exists. | present | PASS |
| 7 | `validation/local-run-readiness-checklist.md` exists. | present | PASS |
| 8 | `validation/prototype-execution-readiness-checklist.md` exists. | present | PASS |
| 9 | `validation/diagram-readiness-pre-render-checklist.md` exists. | present | PASS |
| 10 | `validation/docs-readiness-pre-render-checklist.md` exists. | present | PASS |
| 11 | `validation/final-qa-checklist.md` exists. | present | PASS |
| 12 | `validation/README.md` is rebuilt as a taxonomy index with a top-of-file BLOCKERS section naming `BP12-SAMPLE-DFD-BLOCKER`. | present, rebuilt | PASS |
| 13 | `validation/no-drift-rules.md` carries the BP12 numbered amendments. | present, appended | PASS |
| 14 | `runs/RUN-001/dfd/.gitkeep` exists. | present | PASS |

## 2. Tool Compatibility — Test-AisrafPackage.ps1 Surgical Patches

| # | Check | Expected | Status |
|---|---|---|---|
| 15 | Synopsis text reads "Build Package 01-12" (header line update). | match | PASS |
| 16 | Check `08i-runs-content-limits` permits `.gitkeep` inside `runs/RUN-001/dfd/` via `-and $c.Name -ne '.gitkeep'`. | match | PASS |
| 17 | Check `08i-runs-content-limits` PASS detail string mentions `.gitkeep` as a fresh-clone reservation marker. | match | PASS |
| 18 | Check `08i-runs-content-limits` FAIL detail string names `.gitkeep` as the only allowed non-DFD-output filename. | match | PASS |
| 19 | Check `11-validation-allowed` allow-list contains the 10 new BP12 filenames listed in §1 (rows 1–11 minus README and no-drift). | match | PASS |
| 20 | Check `11-validation-allowed` PASS detail string reads "Build Package 01-12". | match | PASS |
| 21 | No other check in `tools/Test-AisrafPackage.ps1` is modified by Build Package 12. | unchanged | PASS |
| 22 | `tools/New-AisrafRun.ps1` and `tools/Test-AisrafRunProfile.ps1` are not modified by Build Package 12. | unchanged | PASS |

## 3. Sealed Surfaces

| # | Check | Expected | Status |
|---|---|---|---|
| 23 | `prompts/`, `skills/`, `prototype-agents/`, `.agents/`, `catalogs/`, `blueprints/`, `templates/`, `config/` are not modified by Build Package 12. | unchanged | PASS |
| 24 | `samples/` is not modified by Build Package 12. The sample DFD (`samples/sample-001-dfd-crop/inputs/dfd-crop.png`/`.mmd`) is untouched. | unchanged | PASS |
| 25 | `runs/RUN-001/run-profile.yaml`, `runs/RUN-001/00-run-log.md`, `runs/RUN-001/README.md`, `runs/RUN-001/inputs/` are not modified by Build Package 12. | unchanged | PASS |
| 26 | The frozen BP01–BP11 validation checklists are not modified by Build Package 12 (only `validation/README.md` and `validation/no-drift-rules.md` are surgical Build Package 12 governance updates; the 29 pre-existing checklist files remain byte-stable). | unchanged | PASS |
| 27 | The old reference workspace `D:\E-Way 2\aisraf-sas-prototype-skill-chain-pack-v0.01` is not modified. | unchanged | PASS |

## 4. BP12-SAMPLE-DFD-BLOCKER — Cross-Reference Gate (Falsifiable)

The named blocker MUST appear as the literal string `BP12-SAMPLE-DFD-BLOCKER` in every file listed below. Any file in this list that omits the literal string FAILs Build Package 12.

| # | File | Required Literal | Status |
|---|---|---|---|
| 28 | `validation/sample-input-readiness-checklist.md` | `BP12-SAMPLE-DFD-BLOCKER` | PASS |
| 29 | `validation/expected-output-lint-checklist.md` | `BP12-SAMPLE-DFD-BLOCKER` | PASS |
| 30 | `validation/diagram-readiness-pre-render-checklist.md` | `BP12-SAMPLE-DFD-BLOCKER` | PASS |
| 31 | `validation/no-drift-rules.md` | `BP12-SAMPLE-DFD-BLOCKER` | PASS |
| 32 | `validation/package-12-validation-checklist.md` (this file) | `BP12-SAMPLE-DFD-BLOCKER` | PASS |
| 33 | `validation/final-qa-checklist.md` | `BP12-SAMPLE-DFD-BLOCKER` | PASS |
| 34 | `PACKAGE-MANIFEST.yaml` | `BP12-SAMPLE-DFD-BLOCKER` | PASS |

## 5. No Forbidden BP12 Outputs

| # | Check | Expected | Status |
|---|---|---|---|
| 35 | No diagram, image, or render is produced by Build Package 12 (`diagrams/` remains README-only). | absent | PASS |
| 36 | No runbook, practitioner guide, or `docs/` content is produced by Build Package 12 (`docs/` remains README-only). | absent | PASS |
| 37 | No release artefact, ZIP, DOCX, PDF, or PPTX is produced by Build Package 12 (`release/` remains README-only). | absent | PASS |
| 38 | No new sample, expected baseline, or sample-002 folder is created by Build Package 12. | absent | PASS |
| 39 | No prompt card, skill contract, PRA spec, `.agent.md` adapter, catalog, blueprint, or template is created by Build Package 12. | absent | PASS |
| 40 | No actual run output (RS or DFD chain output) is created by Build Package 12. | absent | PASS |
| 41 | No runtime / cloud / ADK / Vertex / GCP / MCP / Jira post-back / Confluence publication / Rovo / database / Terraform / `executed_by_operator` claim is recorded by any BP12 validation file. | absent | PASS |

## 6. Validator Posture

| # | Check | Expected | Status |
|---|---|---|---|
| 42 | `tools/Test-AisrafPackage.ps1` runs to 0 FAIL after Build Package 12. | 0 FAIL | PASS |
| 43 | `tools/Test-AisrafRunProfile.ps1 -RunProfilePath runs/RUN-001/run-profile.yaml -ExecutionReady` returns 12 PASS / 0 FAIL (unchanged). | 12 PASS / 0 FAIL | PASS |
| 44 | No pre-existing PASS row regresses to WARN/FAIL after Build Package 12 (PASS count rises only by additive BP12 evidence; no gate is lowered). | no regression | PASS |

## 7. Git Status Posture

| # | Check | Expected | Status |
|---|---|---|---|
| 45 | `git status` after Build Package 12 shows only the BP12 deltas: 10 new validation files, modified `validation/README.md` and `validation/no-drift-rules.md`, new `runs/RUN-001/dfd/.gitkeep`, modified `tools/Test-AisrafPackage.ps1`, modified `PACKAGE-MANIFEST.yaml`, modified `FOLDER-CONTRACTS.md`, modified `README.md`, modified `START-HERE.md`, modified `.github/copilot-instructions.md`, and `.claude/` untracked. | match | PASS |
| 46 | `.claude/` is not staged. | unstaged | PASS |
| 47 | No `git add` and no `git commit` executed by Build Package 12 implementation. | none | PASS |

## 8. Acceptance Verdict

Build Package 12 is **framework-ready, BP13-blocked** when every row above reads PASS. Sealing without resolving `BP12-SAMPLE-DFD-BLOCKER` is not "release-ready"; it is "framework-ready, BP13-blocked". Numeric scoring of run outputs against expected baselines remains owned by `prompts/rs/13-accuracy-score.prompt.md` / `skills/rs/SK-ACCURACY-SCORE.md` and activates only when the operator executes the chain — not in this package.

## Out-of-Scope For Build Package 12

- Modifying the sample DFD (`samples/sample-001-dfd-crop/inputs/dfd-crop.png`/`.mmd` and the byte-copies under `runs/RUN-001/inputs/`).
- Modifying any expected baseline under `samples/sample-001-dfd-crop/expected/`.
- Authoring sample-002 or any new sample.
- Producing diagrams (Build Package 13).
- Producing runbooks / practitioner guides (Build Package 14).
- Producing release artefacts (Build Package 15).
- Final QA seal (Build Package 16).
- Executing the Build Package 04–09 chain.
- Producing the 17 RS or 9 DFD chain outputs in `runs/RUN-001/`.
- Numeric accuracy scoring.
