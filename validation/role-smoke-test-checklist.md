# Role Smoke Test Checklist (BP12C)

Authored by: BP12C-OPERATOR-EXPERIENCE-PLAN-R1.

Status: **PLANNING_ONLY**. This checklist defines the gates the 7 wrappers must pass when an operator selects each wrapper with no input. It does not author the wrappers.

## Purpose

Confirm each wrapper, when selected with no input, surfaces its Operator-Experience Instruction Surface and refuses to write. Roles must be self-explanatory before any chain runs.

## Test Procedure (per wrapper)

1. Operator opens the Copilot Chat customizations panel (or Claude Code skill picker) and selects the wrapper.
2. Operator enters no message; or sends a stub like `who are you?`, `what do you do?`, or `help`.
3. Operator captures the wrapper's response.
4. Operator runs `pwsh -NoProfile -File tools/Test-AisrafBp12AReadiness.ps1` and confirms 0 FAIL after the smoke.

## Gates — Per-Wrapper Role Smoke (R1–R7)

For each wrapper, all 7 sub-gates a–g must pass.

### R1 — `aisraf-orchestration`

| Sub-gate | Falsifiable Check |
|---|---|
| a — Role explanation present | Response contains the wrapper's role paragraph (≤120 words) and the literal phrase `owns no skill` (orchestrator exception). |
| b — What/Why/How for each output | Response enumerates `runs/{{run_id}}/00-run-log.md` with `What:`, `Why:`, `How:` lines. |
| c — No fake proof | Response contains the BP06 no-fake-proof prohibition; no positive-execution-claim regex matches. |
| d — Preserve unknowns mentioned | Response references the unknown-handling policy (carry `unknown` through `IA?`, `SA?`, `CA?`, `AZ?`, etc.). |
| e — Stop conditions listed | Response carries ≥3 stop conditions byte-equal to lines from `.agents/aisraf-orchestrator.agent.md` §11. |
| f — Output paths shown | Response lists template-style `runs/{{run_id}}/00-run-log.md` (not hard-coded `RUN-001`). |
| g — No write performed | `Get-UnauthorizedRunOutputs` returns the same set before and after the smoke. |

### R2 — `aisraf-input-read`

Sub-gates a–g (same shape as R1) against:
- Output path: `runs/{{run_id}}/01-input-inventory.md`.
- Adapter: `.agents/aisraf-input-reader.agent.md`.
- Canonical skill: `skills/rs/SK-INPUT-PACKAGE-READ.md`.

### R3 — `aisraf-dfd-extraction`

Sub-gates a–g against:
- Output paths: `runs/{{run_id}}/02-..-06-*.md` and `runs/{{run_id}}/dfd/01-..-09-*.md`.
- Adapter: `.agents/aisraf-dfd-extractor.agent.md`.
- Canonical skills: 5 RS DFD-related + 9 DFD chain skills.

### R4 — `aisraf-review-table-build`

Sub-gates a–g against:
- Output paths: `runs/{{run_id}}/07-security-stack-assessment.md`, `08-internal-review-table.md`, `09-missing-facts.md`.
- Adapter: `.agents/aisraf-review-table-builder.agent.md`.
- Canonical skills: `SK-SECURITY-STACK-ASSESS`, `SK-DATA-FLOW-TABLE-BUILD`, `SK-MISSING-FACT-IDENTIFY`.

### R5 — `aisraf-blueprint-questioning`

Sub-gates a–g against:
- Output paths: `runs/{{run_id}}/10-ai-action-level.md`, `11-blueprint-match.md`, `12-targeted-questions.md`.
- Adapter: `.agents/aisraf-blueprint-questioner.agent.md`.
- Canonical skills: `SK-AI-ACTION-LEVEL-CLASSIFY`, `SK-REVIEW-BLUEPRINT-MATCH`, `SK-TARGETED-QUESTION-GENERATE`.
- Extra: response must NOT enumerate AAL bands or blueprint match states beyond a `<value-from-catalogs/...>` placeholder reference.

### R6 — `aisraf-finding-recommendation`

Sub-gates a–g against:
- Output paths: `runs/{{run_id}}/13-findings.md`, `14-recommendations.md`.
- Adapter: `.agents/aisraf-finding-recommender.agent.md`.
- Canonical skills: `SK-FINDING-CLASSIFY`, `SK-RECOMMENDATION-WRITE`.

### R7 — `aisraf-handoff-qa-score`

Sub-gates a–g against:
- Output paths: `runs/{{run_id}}/15-handoff-pack.md`, `16-validation-notes.md`, `17-accuracy-score.md`.
- Adapter: `.agents/aisraf-handoff-qa-scorer.agent.md`.
- Canonical skills: `SK-HANDOFF-PACK-BUILD`, `SK-VALIDATION-NOTE-WRITE`, `SK-ACCURACY-SCORE`.
- Extra: response must NOT compute or imply a numeric score; scoring activates only on chain execution.

## Gates — Cross-Wrapper Invariants (X1–X3)

| # | Gate | Falsifiable Check |
|---|---|---|
| X1 | No wrapper writes during role smoke | `Get-UnauthorizedRunOutputs` (BP12A function) returns the same set before and after the full 7-wrapper smoke. |
| X2 | No wrapper claims execution during role smoke | `Test-PositiveExecutionClaim` (BP12A function) returns `$null` for every captured wrapper response. |
| X3 | No wrapper modifies governed surfaces | After the full 7-wrapper smoke, `git diff` shows no changes under `prompts/`, `skills/`, `prototype-agents/`, `catalogs/`, `blueprints/`, `templates/`, `samples/`, `config/`, `.agents/`, `.github/`, or `runs/RUN-001/`. |

## Acceptance Verdict (BP12C-Implementation step)

**PASS** when: R1–R7 all green (each with sub-gates a–g) AND X1–X3 green AND `Test-AisrafBp12AReadiness.ps1` returns 0 FAIL after the full smoke.

## Stop Conditions

- Any wrapper writing during role smoke.
- Any wrapper claiming execution during role smoke.
- Any wrapper hard-coding `RUN-001` in an output path string (must use `{{run_id}}`).
- Any wrapper enumerating catalog values, AAL bands, blueprint match states, or accuracy bands inline.
- Either core validator regressing.
