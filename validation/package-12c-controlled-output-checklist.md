# Build Package 12C Controlled Output Checklist

Authored by: BP12C-IMPLEMENTATION-AGENT-R1.

Status: **IMPLEMENTATION_GATE**. This checklist defines the controlled file-output gate for BP12C. It does not authorize silent generation, external execution, or modification of sealed evidence.

## Purpose

Prove that BP12C wrappers can write only governed AISRAF run outputs when the run profile and hook allow-list permit the target path.

## Preconditions

| # | Gate | Expected | Status |
|---|---|---|---|
| C0.1 | `runs/{{run_id}}/run-profile.yaml` passes `tools/Test-AisrafRunProfile.ps1 -ExecutionReady`. | 12 PASS / 0 FAIL | REQUIRED |
| C0.2 | `tools/hooks/aisraf-allowed-path-prewrite-guard.ps1` returns PASS for every declared wrapper output path. | PASS | REQUIRED |
| C0.3 | The operator confirms the target run is not sealed evidence unless the founder has approved a controlled rerun. | confirmed | REQUIRED |
| C0.4 | `.claude/` remains local-only and is not staged. | 0 tracked / 0 staged | REQUIRED |

## Gates

| # | Gate | Falsifiable Check | Status |
|---|---|---|---|
| C1 | Orchestration output constrained | Only `runs/{{run_id}}/00-run-log.md` may be written by `aisraf-orchestration`. | REQUIRED |
| C2 | Input-read output constrained | Only `runs/{{run_id}}/01-input-inventory.md` may be written by `aisraf-input-read`. | REQUIRED |
| C3 | DFD outputs constrained | Only `02-05` root outputs and `dfd/01-09` DFD outputs may be written by `aisraf-dfd-extraction`. | REQUIRED |
| C4 | Review-table outputs constrained | Only `runs/{{run_id}}/06-boundaries.md` through `08-internal-review-table.md` may be written by `aisraf-review-table-build`. | REQUIRED |
| C5 | Blueprint-questioning outputs constrained | Only `runs/{{run_id}}/09-missing-facts.md` through `12-targeted-questions.md` may be written by `aisraf-blueprint-questioning`. | REQUIRED |
| C6 | Finding outputs constrained | Only `runs/{{run_id}}/13-findings.md` and `14-recommendations.md` may be written by `aisraf-finding-recommendation`. | REQUIRED |
| C7 | Handoff and scoring outputs constrained | Only `runs/{{run_id}}/15-handoff-pack.md` through `17-accuracy-score.md` may be written by `aisraf-handoff-qa-score`. | REQUIRED |
| C8 | Postwrite validator fires | `tools/hooks/aisraf-focused-validator-postwrite.ps1` returns PASS for each written output. | REQUIRED |
| C9 | No sealed source drift | `git diff` shows no changes under canonical sealed source or fixture surfaces. | REQUIRED |
| C10 | No external execution claim | `tools/Test-AisrafBp12AReadiness.ps1` returns 0 FAIL after the controlled test. | REQUIRED |

## Acceptance Verdict

**PASS** when C0.1-C10 all pass and the controlled run targets a founder-approved writable run folder.

## Stop Conditions

- The target run is sealed evidence and no founder-approved rerun is recorded.
- The prewrite guard refuses any declared output path.
- A wrapper proposes a write outside its declared output set.
- A hook or wrapper claims runtime, cloud, ADK, MCP, Jira, Confluence, Rovo, database, Terraform, release, diagram, or external post-back execution.
- Any core validator returns FAIL.
