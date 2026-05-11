# AISRAF Lifecycle Hooks

Build Package 12C adds repo-portable hook scripts for conservative operator guardrails.

Hooks block, validate, or summarize. They do not generate review content, mutate governed surfaces, stage files, commit files, or perform external integrations.

## Hook Index

| Hook | Event | Behavior |
|---|---|---|
| `aisraf-allowed-path-prewrite-guard.ps1` | Prewrite | Blocks target paths outside the BP12C allow-list. |
| `aisraf-focused-validator-postwrite.ps1` | Postwrite | Runs the validator route for the touched surface. |
| `aisraf-session-stop-summary.ps1` | Session stop | Prints a chat-oriented summary to stdout only. |
| `aisraf-precommit-full-validator.ps1` | Precommit | Runs `tools/Test-AisrafBp12AReadiness.ps1` and returns its exit code. |

## Single Source Of Truth

`hook-allow-list.yaml` owns allowed write patterns and postwrite validator routes. Hook scripts read that file and fail closed if it is missing, unreadable, or does not define a route.

## Boundaries

- Hook scripts do not write files.
- Hook scripts do not stage or commit files.
- Hook scripts do not call Jira, Confluence, Rovo, MCP, ADK, cloud, database, Terraform, release, or diagram services.
- `.claude/` wiring is local-only and must not be staged.

## Example Calls

```powershell
pwsh -NoProfile -File tools/hooks/aisraf-allowed-path-prewrite-guard.ps1 -TargetPath runs/RUN-001/01-input-inventory.md
pwsh -NoProfile -File tools/hooks/aisraf-focused-validator-postwrite.ps1 -TargetPath runs/RUN-001/01-input-inventory.md
pwsh -NoProfile -File tools/hooks/aisraf-session-stop-summary.ps1 -WrapperId aisraf-input-read -InputsRead runs/RUN-001/inputs -OutputsWritten runs/RUN-001/01-input-inventory.md -ValidatorsInvoked tools/Test-AisrafPackage.ps1
pwsh -NoProfile -File tools/hooks/aisraf-precommit-full-validator.ps1
```
