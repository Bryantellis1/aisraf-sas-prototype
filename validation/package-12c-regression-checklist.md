# Build Package 12C Regression Checklist

Authored by: BP12C-IMPLEMENTATION-AGENT-R1.

Status: **IMPLEMENTATION_GATE**. This checklist defines the regression gates for BP12C wrapper and hook installation.

## Purpose

Confirm BP12C operator-experience files do not disturb sealed canonical content, RUN-001 evidence, package validators, or no-drift posture.

## Gates

| # | Gate | Falsifiable Check | Status |
|---|---|---|---|
| R1 | Package validator clean | `pwsh -NoProfile -File tools/Test-AisrafPackage.ps1` returns 0 FAIL. | REQUIRED |
| R2 | BP12A readiness clean | `pwsh -NoProfile -File tools/Test-AisrafBp12AReadiness.ps1` returns 0 FAIL. | REQUIRED |
| R3 | RUN-001 profile clean | `pwsh -NoProfile -File tools/Test-AisrafRunProfile.ps1 -RunProfilePath runs/RUN-001/run-profile.yaml -ExecutionReady` returns 12 PASS / 0 FAIL. | REQUIRED |
| R4 | Canonical source stable | `git diff -- prompts/ skills/ prototype-agents/ .agents/ catalogs/ blueprints/ templates/ config/` returns no files. | REQUIRED |
| R5 | Samples stable | `git diff -- samples/` returns no files. | REQUIRED |
| R6 | RUN-001 stable | `git diff -- runs/RUN-001/` returns no files unless a founder-approved controlled rerun is recorded. | REQUIRED |
| R7 | `.github/agents/` not committed by BP12C | `git diff -- .github/agents/` and `git diff --cached -- .github/agents/` return no files. | REQUIRED |
| R8 | `.claude/` remains local-only | `git ls-files .claude/` and `git diff --cached -- .claude/` return no files. | REQUIRED |
| R9 | Hooks remain read-only | Static grep of `tools/hooks/*.ps1` finds no governed-surface file-write command. | REQUIRED |
| R10 | Skill wrappers remain thin | Static grep confirms wrappers reference canonical paths and do not inline prompt, skill, PRA, template, catalog, scoring, or blueprint logic. | REQUIRED |

## Acceptance Verdict

**PASS** when R1-R10 all pass.

## Stop Conditions

- Any sealed canonical source file changes.
- Any RUN-001 evidence file changes without founder-approved controlled rerun authorization.
- Any BP12C wrapper or hook claims unsupported execution.
- Any validator returns FAIL.
