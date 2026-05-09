# Hook Readiness Checklist (BP12C)

Authored by: BP12C-OPERATOR-EXPERIENCE-PLAN-R1.

Status: **PLANNING_ONLY**. This checklist defines the gates the 4 lifecycle hooks must pass when BP12C-Implementation lands. It does not author the hooks.

## Purpose

Define the falsifiable gates for the 4 conservative lifecycle hooks. Hooks **block, validate, or summarize** — they never generate content silently and they never claim execution.

## Hook Set Under Test

| # | Hook ID | Event | Behavior |
|---|---|---|---|
| 1 | `aisraf-allowed-path-prewrite-guard` | Prewrite | Block writes outside the active build-package allow-list. |
| 2 | `aisraf-focused-validator-postwrite` | Postwrite | Run the narrow validator that owns the touched surface. |
| 3 | `aisraf-session-stop-summary` | Session stop | Emit a chat-only summary; no file writes. |
| 4 | `aisraf-precommit-full-validator` | Precommit | Run BP12A readiness harness; abort commit on FAIL. |

## Gates — Discovery / Registration (D1–D4)

| # | Gate | Falsifiable Check |
|---|---|---|
| D1 | Prewrite guard registered | Hook fires on every wrapper write attempt; test by issuing a wrapper write to a forbidden path (e.g., `prompts/`) and confirming the write is refused before any file mutation. |
| D2 | Postwrite validator registered | Hook fires on every wrapper write success; test by writing `runs/{{run_id}}/run-profile.yaml` (where authorized) and confirming `Test-AisrafRunProfile.ps1` is invoked exactly once. |
| D3 | Session-stop summary registered | Hook fires on session/agent stop; test by completing a smoke run and confirming the chat surface receives a structured summary. |
| D4 | Precommit full validator registered | Hook fires on `git commit`; test with a clean working tree and a dirty tree; the dirty tree containing a forbidden path must abort the commit. |

## Gates — Block / Validate / Summarize Behavior (B1–B4)

| # | Gate | Falsifiable Check |
|---|---|---|
| B1 | Prewrite guard blocks, never authors | The hook returns FAIL or PASS; it never authors, mutates, or stages. Falsifiable by reading the hook script — must contain no write/append/redirect to any file under `prompts/`, `skills/`, `prototype-agents/`, `catalogs/`, `blueprints/`, `templates/`, `samples/`, `config/`, `.agents/`, `.github/`, or `runs/`. |
| B2 | Postwrite validator validates, never authors | The hook invokes a validator script with a constrained argument set; no file authoring. Same grep gate as B1. |
| B3 | Session-stop summary emits chat-only | The hook prints to stdout / chat surface only; no `Out-File`, `Set-Content`, `Write-File`, or shell redirect (`>`, `>>`) inside the script. |
| B4 | Precommit full validator runs the BP12A harness verbatim | The hook executes `pwsh -NoProfile -File tools/Test-AisrafBp12AReadiness.ps1` with no extra flags and reads its exit code. No alternative validator path is hardcoded. |

## Gates — Allow-List Coverage (A1–A4)

| # | Gate | Falsifiable Check |
|---|---|---|
| A1 | Prewrite allow-list pulled from authoritative source | The hook reads the active build-package allow-list from a single source of truth (e.g., `validation/no-drift-rules.md` or a YAML next to the hook). The list is not hand-maintained inside the hook script body. |
| A2 | Postwrite validator routing covers every wrapper write target | For each declared wrapper output path, the hook routes to the correct narrow validator (run-profile / package / future-narrow-DFD checks). Falsifiable by enumerating every wrapper §Allowed Writes path and confirming each routes to a defined validator. |
| A3 | Session-stop summary covers every wrapper invocation | The summary emits one row per wrapper that ran in the session (wrapper id, inputs read, outputs written, validator outcomes, stop conditions hit). |
| A4 | Precommit hook covers every governed surface | BP12A readiness harness already covers all governed surfaces; the hook adds nothing on top — gate A4 is a tautology against the harness, asserted by SHA-256 of the invoked validator path. |

## Gates — No Silent Generation (G1–G4)

| # | Gate | Falsifiable Check |
|---|---|---|
| G1–G4 | None of the 4 hooks generates content silently | For each hook script, grep returns no `Add-Content`, `Set-Content`, `Out-File`, `New-Item -ItemType File`, `Write-File`, `>>`, `>`, `tee`, `Copy-Item -Destination`, or `Move-Item -Destination` line targeting any path under the governed surfaces. The only allowed file-system mutation by any hook is the postwrite validator's transient log under `tools/hooks/.cache/` (if needed and founder-approved); that path is OUTSIDE the governed surfaces and not staged. |

## Gates — No Execution Claim (N1–N4)

| # | Gate | Falsifiable Check |
|---|---|---|
| N1–N4 | Per-hook `Test-PositiveExecutionClaim` returns `$null` | The 13 BP12A regexes fail to match any hook script text. Hooks must not advertise runtime / cloud / ADK / MCP / Jira / Confluence / Rovo / database / Terraform / external post-back / AAL-L4 autonomy. |

## Gates — Sealed-Surface Preservation (P1–P3)

| # | Gate | Falsifiable Check |
|---|---|---|
| P1 | Hooks do not write into sealed surfaces | After a full smoke session and one precommit invocation, `git diff` shows no changes under `prompts/`, `skills/`, `prototype-agents/`, `catalogs/`, `blueprints/`, `templates/`, `samples/`, `config/`, `.agents/`, `.github/`, `runs/RUN-001/inputs/`, `runs/RUN-001/run-profile.yaml`. |
| P2 | Hooks do not modify validators | `tools/Test-AisrafPackage.ps1`, `tools/Test-AisrafRunProfile.ps1`, `tools/Test-AisrafBp12AReadiness.ps1` are byte-stable across hook executions. |
| P3 | `.claude/` git-exclusion preserved | `git ls-files .claude/` returns 0 rows; `git diff --cached .claude/` returns 0 rows. BP12A check `claude-excluded` stays PASS. |

## Gates — Validator Regression (V1)

| # | Gate | Falsifiable Check |
|---|---|---|
| V1 | All three validators 0 FAIL after BP12C-Implementation | `Test-AisrafPackage.ps1`, `Test-AisrafBp12AReadiness.ps1`, `Test-AisrafRunProfile.ps1 -ExecutionReady` all return 0 FAIL. |

## Acceptance Verdict (BP12C-Implementation step)

**PASS** when: D1–D4, B1–B4, A1–A4, G1–G4, N1–N4, P1–P3, V1 all green.

## Stop Conditions

- Any hook generating content silently into a governed surface.
- Any hook claiming execution it did not perform.
- Any hook hard-coding the allow-list inside its script body (must read from a single source of truth).
- Any hook bypassing or muting `Test-AisrafBp12AReadiness.ps1`.
- Either core validator regressing as a side effect of hook installation.
