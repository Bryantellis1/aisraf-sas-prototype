# PRA-08-HANDOFF-QA-SCORER

## 1. Identity

- pra_id: `PRA-08-HANDOFF-QA-SCORER`
- pra_name: Handoff QA Scorer
- status: active
- type: prototype review-agent specification
- package_scope: `aisraf-sas-prototype-v0.1.2`
- owning_build_package: `06`
- mapped_adapter: `.agents/aisraf-handoff-qa-scorer.agent.md`

## 2. Purpose

Assemble the Design Review Handoff Pack from supported review outputs, write Separate Validation Ticket notes, and (when expected baselines exist and `mode = scored`) compute the accuracy score. PRA-08 closes the run. It enforces the design-review vs. validation-ticket separation and is the only PRA that may produce an accuracy score (via `skills/rs/SK-ACCURACY-SCORE.md`). PRA-08 is a specification, not a deployed runtime agent.

## 3. Owned Prompts

- `prompts/rs/11-handoff-pack-build.prompt.md` (RS-15).
- `prompts/rs/12-validation-note-write.prompt.md` (RS-16).
- `prompts/rs/13-accuracy-score.prompt.md` (RS-17; conditional on `mode = scored`, `expected_baseline_required = true`, and a non-empty populated `{{expected_root}}`).

## 4. Owned Skills

- `skills/rs/SK-HANDOFF-PACK-BUILD.md` (owns `15-handoff-pack.md`).
- `skills/rs/SK-VALIDATION-NOTE-WRITE.md` (owns `16-validation-notes.md`).
- `skills/rs/SK-ACCURACY-SCORE.md` (owns `17-accuracy-score.md`; sole accuracy-scoring authority).

## 5. Inputs

Required run-profile variables: `{{run_id}}`, `{{input_root}}`, `{{expected_root}}`, `{{output_root}}`, `{{mode}}`, `{{postback_execution_status}}`, `{{output_destination_mode}}`.

Required reads:

- `runs/{{run_id}}/run-profile.yaml`.
- `{{output_root}}/01-input-inventory.md` through `{{output_root}}/14-recommendations.md` for the handoff pack.
- `{{output_root}}/15-handoff-pack.md` for the validation-note pass.
- `{{output_root}}/01-input-inventory.md` through `{{output_root}}/16-validation-notes.md` for scoring.

Optional reads (test mode only):

- `{{expected_root}}/expected-input-inventory.json` through `{{expected_root}}/expected-accuracy-score.json` (Build Package 10 will provide these), used only when `mode = scored`, `expected_baseline_required = true`, and `{{expected_root}}` is non-empty.

## 6. Outputs

- `{{output_root}}/15-handoff-pack.md`.
- `{{output_root}}/16-validation-notes.md`.
- `{{output_root}}/17-accuracy-score.md` (only when scoring conditions are met; otherwise records `accuracy_score_claim: not_applicable` and stops cleanly).

## 7. Procedure

1. Open `prompts/rs/11-handoff-pack-build.prompt.md`.
2. Apply `skills/rs/SK-HANDOFF-PACK-BUILD.md` to write `{{output_root}}/15-handoff-pack.md`. Pull only design-review material; do not pull Separate Validation Ticket evidence into the handoff pack.
3. Open `prompts/rs/12-validation-note-write.prompt.md`.
4. Apply `skills/rs/SK-VALIDATION-NOTE-WRITE.md` to write `{{output_root}}/16-validation-notes.md`. Validation notes are kept separate from the handoff pack and never merged.
5. Open `prompts/rs/13-accuracy-score.prompt.md`. If `mode != scored`, or `expected_baseline_required = false`, or `{{expected_root}}` is empty, write `{{output_root}}/17-accuracy-score.md` with `accuracy_score_claim: not_applicable` and stop the score step.
6. Otherwise apply `skills/rs/SK-ACCURACY-SCORE.md` to compare actual outputs to `{{expected_root}}` baselines and write `{{output_root}}/17-accuracy-score.md`. Run the critical-miss scan; refuse to inflate the score by hiding unknowns; never edit baselines under `{{expected_root}}`.
7. Hand control back to PRA-01 with a final PASS / PARTIAL / FAIL / `not_applicable` decision.

## 8. Human Gates

- SAS confirms `{{output_root}}/15-handoff-pack.md` contains design-review material only and routes correctly.
- SAS confirms `{{output_root}}/16-validation-notes.md` is kept separate and contains validation-ticket evidence only.
- SAS reviews critical-miss list before accepting any PASS / PARTIAL / FAIL result.
- SAS accepts or rejects `{{output_root}}/17-accuracy-score.md` (or accepts `not_applicable` when no baseline exists).

## 9. Stop Conditions

- Validation-ticket evidence is found inside the handoff pack (or vice versa).
- An accuracy claim is made when `mode != scored`, `expected_baseline_required = false`, or `{{expected_root}}` is empty.
- A score is inflated by hiding unknowns or by ignoring a critical miss.
- A baseline file under `{{expected_root}}` is modified by this PRA.
- An accuracy claim is made by any skill other than `SK-ACCURACY-SCORE`.
- Output written outside `{{output_root}}`.
- Any forbidden runtime/cloud/ADK/MCP/Jira/Confluence claim is recorded.

## 10. Unknown Handling

- Treat absent baselines as `accuracy_score_claim: not_applicable`. Do not synthesise a score.
- Treat unknown finding owners or evidence references in the handoff pack as `unknown` and route the gap to a Separate Validation Ticket note rather than fabricating proof.
- Treat unknown post-back execution status as `not_executed`; PRA-08 never claims `executed_by_operator` without recorded timestamp, destination URL, and operator action in `00-run-log.md`.

## 11. Evidence and Run-Log Guidance

- Three run-log entries are appended after SAS acceptance: RS-15 (handoff pack), RS-16 (validation notes), and RS-17 (accuracy score or `not_applicable`). Each references the prompt path, skill path, output path, and SAS reviewer decision.
- The final run-log entry records the PASS / PARTIAL / FAIL / `not_applicable` decision, the critical-miss list, and the routing destination.
- No evidence is written outside `{{output_root}}`.

## 12. Direct Adapter Test

Operator opens `.agents/aisraf-handoff-qa-scorer.agent.md` from the local Copilot Chat agent dropdown and asks: "Read `{{output_root}}/01-input-inventory.md` through `{{output_root}}/14-recommendations.md`. Run `prompts/rs/11-handoff-pack-build.prompt.md` with `skills/rs/SK-HANDOFF-PACK-BUILD.md` to write `{{output_root}}/15-handoff-pack.md`. Run `prompts/rs/12-validation-note-write.prompt.md` with `skills/rs/SK-VALIDATION-NOTE-WRITE.md` to write `{{output_root}}/16-validation-notes.md`. Then run `prompts/rs/13-accuracy-score.prompt.md` with `skills/rs/SK-ACCURACY-SCORE.md`; if `mode != scored` or `{{expected_root}}` is empty, write `{{output_root}}/17-accuracy-score.md` with `accuracy_score_claim: not_applicable` and stop. Do not mix validation-ticket evidence into the handoff pack; do not edit baselines; do not write outside `{{output_root}}`." A PASS test produces all three files with the design-review and validation-ticket lanes kept separate and the scoring lane gated correctly.

## 13. Not in Scope

- Not a deployed runtime agent.
- Not a Google ADK agent.
- Not a Vertex, GCP, or external cloud agent.
- Not an MCP execution surface.
- Not a Jira post-back, Confluence publication, or Rovo execution surface.
- Not allowed to re-run earlier review steps (PRA-02 through PRA-07 own those).
- Not allowed to write outside `{{output_root}}`.
- Not allowed to modify `prompts/`, `skills/`, `config/`, `tools/`, `validation/`, `prototype-agents/`, `.agents/`, or any baseline under `{{expected_root}}`.
- Not allowed to claim release packaging or diagram generation.
- Not allowed to claim post-back execution without a corresponding `00-run-log.md` entry recording timestamp, destination URL, and operator action.
- Not allowed to inflate the score by hiding unknowns or ignoring critical misses.
