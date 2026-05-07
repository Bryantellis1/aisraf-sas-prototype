# Run Log — RUN-001

| field | value |
|---|---|
| run_id | RUN-001 |
| sample_id | sample-001-dfd-crop |
| mode | folder_first_test |
| output_root | runs/RUN-001 |
| output_destination_mode | local_only |
| postback_execution_status | deferred |
| operator_name | SAS reviewer |
| reviewer_name | SAS reviewer |
| created_at | 2026-05-07T00:00:00Z |

## Run Identity

This run log mirrors `templates/output/output-00-run-log-template.md` (Build Package 09 file shape; founder decision Q1). Per-step rows must follow `templates/run/run-log-entry-row-template.md`. Post-back evidence rows must follow `templates/run/postback-log-entry-row-template.md` and are admissible only when `runs/RUN-001/run-profile.yaml#postback_execution_status` is `executed_by_operator` AND `output_destination_mode` is `external_postback_executed` AND a destination URL is present.

The active prompts the operator will invoke when the chain runs are:

- Build Package 04 prompt cards under `prompts/rs/` (PR-RS-01..13) and `prompts/dfd/` (PR-DFD-02..10).
- Build Package 05 skills under `skills/rs/` (17 RS, `SK-INPUT-PACKAGE-READ` .. `SK-ACCURACY-SCORE`) and `skills/dfd/` (9 DFD, `SK-DFD-01-INTAKE-QUALITY-CHECK` .. `SK-DFD-09-EXTRACTION-SUMMARIZE`).
- Build Package 06 PRAs `PRA-01-SAS-REVIEW-ORCHESTRATOR` .. `PRA-08-HANDOFF-QA-SCORER` and adapters under `.agents/` (orchestrator, input-reader, dfd-extractor, review-table-builder, blueprint-questioner, finding-recommender, handoff-qa-scorer).
- Build Package 09 templates under `templates/output/` and `templates/run/`.

Build Package 11 records this run-evidence model. It does not execute the chain. The Step Entries section below is intentionally empty until the operator runs prompts/skills/PRAs against the staged inputs at `runs/RUN-001/inputs/` and writes outputs under `runs/RUN-001/`.

## Step Entries

(none — Build Package 11 establishes the fixture only; no prompt, skill, PRA, or adapter has executed against this run.)

When the operator executes a step, append one Markdown row per step using `templates/run/run-log-entry-row-template.md`. One row per executed prompt/skill/PRA step. Skipped steps record a row with `validation_result: SKIPPED` and the reason. Critical-miss-flagged entries stop the run.

## Post-Back Evidence

(none — `postback_execution_status: deferred` in `run-profile.yaml`; no external write is claimed.)

A row appended here is permitted only when ALL of the following hold (per `templates/run/postback-log-entry-row-template.md` § 5):

1. `runs/RUN-001/run-profile.yaml#postback_execution_status` is `executed_by_operator`.
2. `runs/RUN-001/run-profile.yaml#output_destination_mode` is `external_postback_executed`.
3. At least one of `destination_ticket_url` or `destination_confluence_url` is non-empty.
4. The operator actually performed the external action.
5. The local artefact posted or published was produced under `runs/RUN-001/`.
6. The row records timestamp, destination reference, artefact reference, operator confirmation, human-gate disposition, and the sensitive-data check.

If any item is missing, keep the run at `deferred` or `formatted_only` and do not append the row.

## Stop Conditions Recorded

(none — no chain execution has begun.)

When the chain executes, every triggered stop condition records a row here with timestamp, the step that triggered it, the impacted artefacts, and any unknowns held open. Critical-miss flags stop the run; suppressing a critical miss to achieve a PASS verdict is forbidden.

## Append Rules

- This run log is append-only. Existing rows must not be edited.
- One row per step. Multi-output steps (for example `prompts/rs/04-design-fact-extract.prompt.md` writes both `04-components.md` and `05-flows.md`) record both artefacts in the same row's `output_artifacts_written` field.
- A step entry is required for every prompt/skill/PRA execution. Skipped steps record a row with `validation_result: SKIPPED` and the reason.
- No `Jira post-back: executed_by_operator` claim may appear in a step row. Use the Post-Back Evidence row pattern.
- Credentials, tokens, real PII, PAN, SSN, customer identifiers, and production endpoints must not appear in any field.
