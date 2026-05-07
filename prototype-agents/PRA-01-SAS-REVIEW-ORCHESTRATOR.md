# PRA-01-SAS-REVIEW-ORCHESTRATOR

## 1. Identity

- pra_id: `PRA-01-SAS-REVIEW-ORCHESTRATOR`
- pra_name: SAS Review Orchestrator
- status: active
- type: prototype review-agent specification
- package_scope: `aisraf-sas-prototype-v0.1.2`
- owning_build_package: `06`
- mapped_adapter: `.agents/aisraf-orchestrator.agent.md`

## 2. Purpose

Coordinate a local AISRAF SAS prototype review run from start to finish. PRA-01 confirms the resolved run profile, sequences PR-RS-01 through PR-RS-13 (and the DFD subskill chain owned by PRA-03 when the operator stages DFD inputs), enforces stop rules and human gates, records orchestration state in `{{output_root}}/00-run-log.md`, and routes the final PASS / PARTIAL / FAIL decision after PRA-08 scoring (or `not_applicable` when no baseline exists). PRA-01 is a specification, not a deployed runtime agent. It performs no extraction directly; the 26 skills are owned by PRA-02 through PRA-08.

## 3. Owned Prompts

- `prompts/rs/00-run-full-chain.prompt.md` (chain wrapper; writes no output of its own per Build Package 04 founder decision Q2).

PRA-01 also coordinates (does not own) the remaining 22 prompt cards:

- `prompts/rs/01-input-package-read.prompt.md` (PRA-02).
- `prompts/rs/02-dfd-visual-read.prompt.md` (PRA-03).
- `prompts/rs/03-legend-normalization.prompt.md` (PRA-04).
- `prompts/rs/04-design-fact-extract.prompt.md` (PRA-03).
- `prompts/rs/05-boundary-stack-detect.prompt.md` (PRA-05).
- `prompts/rs/06-review-table-build.prompt.md` (PRA-05).
- `prompts/rs/07-missing-fact-question-generate.prompt.md` (PRA-06).
- `prompts/rs/08-ai-action-level-classify.prompt.md` (PRA-06).
- `prompts/rs/09-blueprint-match.prompt.md` (PRA-06).
- `prompts/rs/10-finding-recommendation-write.prompt.md` (PRA-07).
- `prompts/rs/11-handoff-pack-build.prompt.md` (PRA-08).
- `prompts/rs/12-validation-note-write.prompt.md` (PRA-08).
- `prompts/rs/13-accuracy-score.prompt.md` (PRA-08).
- The 9 DFD prompt cards under `prompts/dfd/` (PRA-03).

## 4. Owned Skills

None. PRA-01 owns no skill contract directly. The 26 canonical skills are distributed across PRA-02 through PRA-08, recorded in `skills/skill-registry.yaml` and resolved in `prototype-agents/prototype-agent-registry.yaml#prompt_skill_agent_crosswalk`.

## 5. Inputs

Required run-profile variables (resolved via `runs/{{run_id}}/run-profile.yaml`):

- `{{run_id}}`, `{{input_root}}`, `{{expected_root}}`, `{{output_root}}`, `{{mode}}`, `{{postback_execution_status}}`, `{{output_destination_mode}}`.

Required reads:

- `runs/{{run_id}}/run-profile.yaml`.
- `{{output_root}}/00-run-log.md`, when present.
- `{{output_root}}/01-input-inventory.md` through `{{output_root}}/17-accuracy-score.md`, as each step completes.
- `{{output_root}}/dfd/01-intake-quality-check.md` through `{{output_root}}/dfd/09-extraction-summary.md`, when DFD inputs are staged.

Optional reads (test mode only):

- `{{expected_root}}/**`, only when `mode = scored` and PR-RS-13 is invoked.

## 6. Outputs

- `{{output_root}}/00-run-log.md` — chronological orchestration record (one entry per RS step, recorded after SAS acceptance of that step).

PRA-01 produces no other artefact. Step-level outputs are produced by the owning PRA (PRA-02 through PRA-08) and accepted by SAS before PRA-01 advances the chain.

## 7. Procedure

1. Open `runs/{{run_id}}/run-profile.yaml`. Confirm every required field resolves; stop if any path or flag is unresolved.
2. Confirm `mode`, `postback_execution_status`, and `output_destination_mode` match the operator intent. Stop if a value would imply runtime/cloud/MCP/Jira/Confluence execution that is not authorised in v0.1.2.
3. Initialise or append to `{{output_root}}/00-run-log.md`. Record the run profile reference, PRA-01 entry timestamp, and chosen mode.
4. Hand off to PRA-02 via the AISRAF Input Reader adapter for PR-RS-01.
5. After SAS accepts each RS-step output, append a run-log entry referencing the prompt path, the skill path(s), the output file path, and the SAS reviewer decision.
6. When PRA-03 stages DFD inputs, sequence PR-DFD-02 through PR-DFD-10 in order before resuming the RS chain at PR-RS-04 (component/flow extraction).
7. After PRA-08 produces `{{output_root}}/15-handoff-pack.md`, `{{output_root}}/16-validation-notes.md`, and (when scoring is applicable) `{{output_root}}/17-accuracy-score.md`, route the final PASS / PARTIAL / FAIL / `not_applicable` decision and close the run-log.
8. If a stop condition fires at any step, append a `status: stopped` run-log entry naming the stop condition and route to the appropriate Build Package authoring agent.

## 8. Human Gates

- SAS confirms the resolved run profile before PR-RS-01 begins.
- SAS accepts every RS-step output before PRA-01 records its run-log entry and advances.
- SAS confirms `{{output_root}}/15-handoff-pack.md` and `{{output_root}}/16-validation-notes.md` are kept separate (no validation-ticket evidence inside the handoff pack).
- SAS accepts or rejects the PASS / PARTIAL / FAIL decision after PRA-08 scoring (or accepts `not_applicable` when no baseline is staged).

## 9. Stop Conditions

- Run-profile variable cannot be resolved.
- `{{output_root}}` cannot be created or written to.
- Any output is detected outside `{{output_root}}` (or `{{output_root}}/dfd/` for DFD subskill outputs).
- Any owned skill records a critical miss that has not been resolved.
- Any PRA, prompt, skill, or adapter claims runtime, cloud, ADK, MCP, Jira post-back, Confluence publication, Rovo execution, database, Terraform, release packaging, diagram generation, or accuracy scoring outside `SK-ACCURACY-SCORE`.
- Validation-ticket evidence is mixed into the design-review handoff pack, or vice versa.
- Any Build Package 06 artefact attempts to modify `prompts/`, `skills/`, `prompts/prompt-registry.yaml`, `skills/skill-registry.yaml`, or any file under `{{expected_root}}`.

## 10. Unknown Handling

- Treat unresolved run-profile variables, missing prior outputs, or missing baselines as `unknown`. Do not invent values. Stop and route to the relevant authoring agent.
- Treat the absence of an expected baseline (`mode != scored` or `{{expected_root}}` empty) as `accuracy_score_claim = not_applicable`. PRA-01 must not allow PASS / PARTIAL / FAIL claims under those conditions.
- Treat unknown DFD intake (`{{output_root}}/dfd/01-intake-quality-check.md` reports `proceed = false`) as a stop, not a soft warning.

## 11. Evidence and Run-Log Guidance

- Every step appends a single entry to `{{output_root}}/00-run-log.md`. Each entry references: prompt path, skill paths, output path, SAS reviewer decision, and timestamp.
- `postback_execution_status: executed_by_operator` may only be recorded when the operator has actually performed the post-back, the destination URL is logged, and the timestamp is recorded. Otherwise the run log records `not_executed`.
- Orchestration notes never replace the per-step output; they reference the canonical path.

## 12. Direct Adapter Test

Operator opens `.agents/aisraf-orchestrator.agent.md` from the local Copilot Chat agent dropdown and asks: "Confirm whether `runs/RUN-EXAMPLE/run-profile.yaml` is resolvable for AISRAF SAS Prototype v0.1.2. List the resolved values for `{{run_id}}`, `{{input_root}}`, `{{expected_root}}`, `{{output_root}}`, `{{mode}}`, `{{postback_execution_status}}`, and `{{output_destination_mode}}`. Do not run any prompt; do not write any file." A PASS test returns the seven resolved values and stops with no writes outside `{{output_root}}`.

## 13. Not in Scope

- Not a deployed runtime agent.
- Not a Google ADK agent.
- Not a Vertex, GCP, or external cloud agent.
- Not an MCP execution surface.
- Not a Jira post-back, Confluence publication, or Rovo execution surface.
- Not allowed to write outside `{{output_root}}`.
- Not allowed to modify `prompts/`, `prompts/prompt-registry.yaml`, `skills/`, `skills/skill-registry.yaml`, `config/`, `tools/`, `validation/`, `prototype-agents/` (apart from its own PRA spec), `.agents/`, or any file under `{{expected_root}}`.
- Not allowed to claim accuracy scoring outside `skills/rs/SK-ACCURACY-SCORE.md`.
- Not allowed to claim release packaging or diagram generation.
- Not allowed to introduce a new requester submission process.
