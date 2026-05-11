---
prompt_id: PR-RS-00
prompt_name: RS Full Chain Wrapper
owning_build_package: Build Package 04
prompt_family: rs
status: planned
future_skill_id: SK-CHAIN-WRAPPER (planned; defined in Build Package 05)
future_pra_owner: PRA-RS-REVIEW (planned; defined in Build Package 06)
review_step: RS-CHAIN
---

# RS Full Chain Wrapper

## 1. Identity

- prompt_id: `PR-RS-00`
- prompt_name: RS Full Chain Wrapper
- owning_build_package: Build Package 04 — Prompts and prompt registry.
- prompt_family: `rs`
- status: `planned`
- future_skill_id: `SK-CHAIN-WRAPPER` (planned; defined in Build Package 05).
- future_pra_owner: `PRA-RS-REVIEW` (planned; defined in Build Package 06).
- review_step: `RS-CHAIN`

## 2. Purpose

Enumerate the RS prompt chain order so an operator can open the per-step cards in sequence inside VS Code Copilot Chat. This card writes nothing on its own. It is a wrapper, not an executor: it does not orchestrate skills, PRAs, adapters, scoring, or any external service. Status `planned` means the wrapper is registered for Build Package 04 documentation purposes but no automation is performed; future Build Packages may add an executable wrapper only when their contracts authorize it.

## 3. Run Profile Inputs

Resolve every value from `runs/{{run_id}}/run-profile.yaml`. The seven required v0.1.2 run-profile variables are:

- `{{run_id}}` — unique run identifier (e.g., `RUN-LOCAL-20260506`).
- `{{input_root}}` — package-relative folder containing staged inputs.
- `{{expected_root}}` — package-relative folder containing expected baselines, may be empty when `expected_baseline_required: false`.
- `{{output_root}}` — package-relative folder under `runs/{{run_id}}/` where every per-step card writes its output.
- `{{mode}}` — operator run mode: `folder_first_test`, `folder_first_review`, `integration_assisted_intake`, `integration_assisted_postback`, `dry_run_revalidation`, or `live_reviewer_run`.
- `{{postback_execution_status}}` — `deferred`, `formatted_only`, `executed_by_operator`, or `not_attempted`.
- `{{output_destination_mode}}` — `local_only`, `jira_draft`, `confluence_draft`, `jira_and_confluence_draft`, or `external_postback_executed`.

Do not hardcode any value. Do not invent fields outside `config/run-profile.schema.yaml`.

## 4. Required Read Paths

Required reads:

- `runs/{{run_id}}/run-profile.yaml`
- `config/run-profile.schema.yaml`
- `config/run-profile.validation-rules.md`
- `config/path-resolution-rules.md`
- `config/sensitive-data-rules.md`
- `prompts/prompt-registry.yaml`

Per-step prompt cards opened in this order:

1. [01-input-package-read.prompt.md](01-input-package-read.prompt.md)
2. [02-dfd-visual-read.prompt.md](02-dfd-visual-read.prompt.md)
3. [03-legend-normalization.prompt.md](03-legend-normalization.prompt.md)
4. [04-design-fact-extract.prompt.md](04-design-fact-extract.prompt.md)
5. [05-boundary-stack-detect.prompt.md](05-boundary-stack-detect.prompt.md)
6. [06-review-table-build.prompt.md](06-review-table-build.prompt.md)
7. [07-missing-fact-question-generate.prompt.md](07-missing-fact-question-generate.prompt.md)
8. [08-ai-action-level-classify.prompt.md](08-ai-action-level-classify.prompt.md)
9. [09-blueprint-match.prompt.md](09-blueprint-match.prompt.md)
10. [10-finding-recommendation-write.prompt.md](10-finding-recommendation-write.prompt.md)
11. [11-handoff-pack-build.prompt.md](11-handoff-pack-build.prompt.md)
12. [12-validation-note-write.prompt.md](12-validation-note-write.prompt.md)
13. [13-accuracy-score.prompt.md](13-accuracy-score.prompt.md) — only when `scoring_enabled: true`, `expected_baseline_required: true`, and `{{expected_root}}` is non-empty and populated.

Future-package references (not required to run this wrapper; do not stop on absence):

- `skills/SK-*` (Build Package 05).
- `prototype-agents/PRA-*` (Build Package 06).
- `.agents/*.agent.md` (Build Package 06).

## 5. Required Output

This wrapper writes no output. Each per-step card writes its own artifact under `{{output_root}}` per its own Section 5. No write path under any name resolves through this wrapper.

## 6. Instructions

1. Confirm the active workspace root is `D:/E-Way 2/AISRAF- SAS Prototype v0.1.2`.
2. Resolve every variable in Section 3 from `runs/{{run_id}}/run-profile.yaml`.
3. Confirm `sensitive_data_confirmed_redacted: true` in the run profile. If `false`, stop and ask the operator to confirm and redact before any per-step card runs.
4. Open per-step cards in the Section 4 order. Do not skip a card. Do not run a later card before its prior outputs exist under `{{output_root}}`.
5. After each accepted per-step card, the operator appends one entry to `{{output_root}}/00-run-log.md` per that card's Section 9.
6. If the chain cannot complete because of missing inputs, missing prior outputs, or unresolvable run-profile values, stop, record what is missing in `{{output_root}}/00-run-log.md`, and resume only after the operator addresses the gap.

## 7. Stop Conditions

Stop before opening per-step cards if any of the following holds:

- `runs/{{run_id}}/run-profile.yaml` is missing or unreadable.
- Any required run-profile variable from Section 3 is unset, empty, or unresolvable.
- `sensitive_data_confirmed_redacted` is `false`.
- `{{output_root}}` does not match the schema pattern `^runs/RUN-[A-Z0-9][A-Z0-9-]*(/.*)?$` or does not match the resolved `{{run_id}}`.
- A read or write would resolve outside the active workspace or into the old reference workspace.
- A sensitive-data substring per `config/sensitive-data-rules.md` is detected in any read value.
- The operator requests skill execution, PRA execution, adapter execution, Jira post-back, Confluence publication, Rovo execution, MCP execution, runtime/cloud/database execution, scoring outside the conditional 13-accuracy-score path, diagram generation, or release export through this wrapper.

## 8. Unknown Handling

This wrapper records nothing of its own. Per-step cards manage their own unknown handling. If the chain cannot proceed past a per-step card, mark the step as `not_run` in the operator's notes; do not invent results from a skipped step.

## 9. Evidence / Run-Log Guidance

- The wrapper itself never appends a run-log entry. Only the per-step cards do, and only after human acceptance.
- Do not record this wrapper as having executed or orchestrated any step.
- Do not claim Jira post-back, Confluence publication, MCP execution, Rovo execution, or runtime execution from this wrapper.

## 10. Direct Prompt Test

Operator test sequence:

```
# 1. Create a folder-first test run.
tools/New-AisrafRun.ps1 -RunId RUN-LOCAL-WRAP-TEST -SampleId sample-001-dfd-crop -Mode folder_first_test

# 2. Set sensitive_data_confirmed_redacted: true after confirming inputs are clean,
#    then validate the profile.
tools/Test-AisrafRunProfile.ps1 -RunProfilePath runs/RUN-LOCAL-WRAP-TEST/run-profile.yaml -ExecutionReady
```

- Open this card in VS Code Copilot Chat. Do not edit the prompt body. Substitute or confirm only the variables in Section 3.
- Expected local artifact from the wrapper itself: none.
- PASS = wrapper acknowledges the chain order, opens per-step cards in sequence, writes nothing of its own, and records each per-step card's run-log entry only after human acceptance.

## 11. Not In Scope

- No skill execution. Skill contracts are deferred to Build Package 05.
- No PRA execution. PRA specifications are deferred to Build Package 06.
- No `.agent.md` adapter execution. Adapters are deferred to Build Package 06.
- No Jira post-back, Confluence publication, Rovo execution, or MCP execution.
- No accuracy scoring (handled only by [13-accuracy-score.prompt.md](13-accuracy-score.prompt.md) and only when its conditions hold).
- No diagram generation, runbook generation, or release/export.
- No runtime, cloud, or database execution.
- No automation, orchestration, or full-chain claim. This wrapper is documentation only in Build Package 04.
