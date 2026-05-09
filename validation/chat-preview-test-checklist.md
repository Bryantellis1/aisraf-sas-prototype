# Chat Preview Test Checklist (BP12C)

Authored by: BP12C-OPERATOR-EXPERIENCE-PLAN-R1.

Status: **PLANNING_ONLY**. This checklist defines the gates each wrapper must pass when the operator runs a **read-only chat preview** against the RUN-001 inputs. It does not author the wrappers.

## Purpose

Confirm each wrapper, given the RUN-001 inputs, **previews canonical output shape in chat** without writing files. This is the layer between role smoke (no input) and controlled output generation (real writes).

## Test Procedure (per wrapper)

1. Operator opens the wrapper with `runs/RUN-001/inputs/` declared as the input set.
2. Operator instructs `preview only — write nothing`.
3. Wrapper produces a chat-only response showing the shape, structure, and required sections of each output path it would write.
4. Operator captures the chat response.
5. Operator runs `pwsh -NoProfile -File tools/Test-AisrafBp12AReadiness.ps1` and confirms no governed surface changed.

## Gates — Per-Wrapper Chat Preview (P1–P7)

For each wrapper, all 6 sub-gates a–f must pass.

### P1 — `aisraf-orchestration`

| Sub-gate | Falsifiable Check |
|---|---|
| a — Output shape matches canonical template | Preview structure of `runs/{{run_id}}/00-run-log.md` matches `templates/output/output-00-run-log-template.md` section-for-section. |
| b — No file written | `runs/RUN-001/00-run-log.md` byte-stable before and after preview. |
| c — Catalog references via placeholder only | Preview uses `<value-from-catalogs/...>` placeholders, not enumerated catalog values. |
| d — Unknown carry-through visible | Preview demonstrates `unknown` propagation (e.g., `IA?`, `AZ?`) where canonical inputs do not pin a value. |
| e — Stop conditions cited | Preview text references the wrapper's stop conditions list. |
| f — No execution claim | `Test-PositiveExecutionClaim` returns `$null`. |

### P2 — `aisraf-input-read`

Sub-gates a–f against:
- Template: `templates/output/output-01-input-inventory-template.md`.
- Output path: `runs/{{run_id}}/01-input-inventory.md`.
- Inputs: 6 files under `runs/RUN-001/inputs/`.
- Byte-stability target: `runs/RUN-001/01-input-inventory.md`.

### P3 — `aisraf-dfd-extraction`

Sub-gates a–f against:
- Templates: `templates/output/output-02-..-06-*-template.md` (5 RS) plus `templates/output/output-dfd-01-..-09-*-template.md` (9 DFD).
- Output paths: `runs/{{run_id}}/02-..-06-*.md` and `runs/{{run_id}}/dfd/01-..-09-*.md`.
- Inputs: `runs/RUN-001/inputs/dfd-crop.mmd`, `dfd-crop.png`, `dfd-legend-excerpt.md`.
- Byte-stability targets: the 5 root and 9 dfd/ outputs in RUN-001.
- Extra sub-gate g — DFD subchain ordering: Preview demonstrates the 9-step DFD subchain in canonical order (intake-quality-check → boundary-catalog → component-catalog → flow-inventory → annotation-resolution → boundary-crossings → control-signals → confidence-score → extraction-summary).

### P4 — `aisraf-review-table-build`

Sub-gates a–f against:
- Templates: `templates/output/output-07-security-stack-assessment-template.md`, `output-08-internal-review-table-template.md`, `output-09-missing-facts-template.md`.
- Output paths: `runs/{{run_id}}/07-..-09-*.md`.
- Byte-stability targets: same 3 files in RUN-001.

### P5 — `aisraf-blueprint-questioning`

Sub-gates a–f against:
- Templates: `templates/output/output-10-ai-action-level-template.md`, `output-11-blueprint-match-template.md`, `output-12-targeted-questions-template.md`.
- Output paths: `runs/{{run_id}}/10-..-12-*.md`.
- Byte-stability targets: same 3 files in RUN-001.
- Extra sub-gate h — Blueprint match states demonstrated as placeholders only (`<value-from-blueprints/blueprint-registry.yaml>`); no enumeration of `matched / candidate / no_match / unknown` outside a reference path.

### P6 — `aisraf-finding-recommendation`

Sub-gates a–f against:
- Templates: `templates/output/output-13-findings-template.md`, `output-14-recommendations-template.md`.
- Output paths: `runs/{{run_id}}/13-..-14-*.md`.
- Byte-stability targets: same 2 files in RUN-001.

### P7 — `aisraf-handoff-qa-score`

Sub-gates a–f against:
- Templates: `templates/output/output-15-handoff-pack-template.md`, `output-16-validation-notes-template.md`, `output-17-accuracy-score-template.md`.
- Output paths: `runs/{{run_id}}/15-..-17-*.md`.
- Byte-stability targets: same 3 files in RUN-001.
- Extra sub-gate i — Numeric score withheld: Preview shows shape `<numeric_score_pending_chain_execution>` placeholder, not a number.

## Gates — Cross-Wrapper Invariants (X1–X4)

| # | Gate | Falsifiable Check |
|---|---|---|
| X1 | No file write during preview | After the full 7-wrapper preview, all 26 governed RUN-001 outputs (17 RS at root + 9 DFD under `dfd/`) are SHA-256-equal to their BP12B post-execution bytes. |
| X2 | No execution claim during preview | `Test-PositiveExecutionClaim` returns `$null` for every captured preview response. |
| X3 | Unauthorized RUN-001 outputs unchanged | `Get-UnauthorizedRunOutputs` returns the same set before and after the full preview. |
| X4 | Validators clean after preview | `Test-AisrafPackage.ps1`, `Test-AisrafBp12AReadiness.ps1`, `Test-AisrafRunProfile.ps1 -ExecutionReady` all return 0 FAIL after the full preview. |

## Acceptance Verdict (BP12C-Implementation step)

**PASS** when: P1–P7 all green (each with sub-gates a–f and any extras) AND X1–X4 green.

## Stop Conditions

- Any wrapper writing a file during chat preview.
- Any wrapper enumerating catalog / AAL / blueprint-match / accuracy values inline (placeholders required).
- Any wrapper claiming execution.
- Any of the 26 governed RUN-001 outputs SHA-256-changing during preview.
- Either core validator regressing.
