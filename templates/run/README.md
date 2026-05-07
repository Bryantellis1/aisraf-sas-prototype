# templates/run/

Owning Build Package: Build Package 09 — Templates.

## Purpose

Run-support row templates that get appended into `{{output_root}}/00-run-log.md`. These are row patterns, not file shapes. The run-log file shape lives in [`templates/output/output-00-run-log-template.md`](../output/output-00-run-log-template.md) (founder decision Q1 of Build Package 09).

## Inventory

2 templates:

- `run-log-entry-row-template.md` — per-step row appended into the run log by every PRA after each prompt/skill execution.
- `postback-log-entry-row-template.md` — append-only row that proves a human operator posted SAS output to Jira, published to Confluence, or both. Allowed only when `postback_execution_status: executed_by_operator`.

## Boundary

Both templates:

- Append rows under `{{output_root}}/00-run-log.md` only. They do not write to any other file.
- Use only the seven approved run-profile placeholders. Other schema fields are referenced descriptively as `[copy from runs/{{run_id}}/run-profile.yaml#field_name]`.
- Never claim severity / score / AI Action Level / blueprint match.
- Never include credentials, tokens, real PII, PAN, SSN, customer identifiers, or production endpoints.

## When to Append

- `run-log-entry-row-template.md` — once per executed prompt/skill/PRA step. Skipped steps record a row with `validation_result: SKIPPED` and the reason.
- `postback-log-entry-row-template.md` — once per actual operator post-back action (Jira comment, Jira attachment, Confluence publish, Confluence update). Disallowed when `postback_execution_status` is `deferred`, `formatted_only`, or `not_attempted`.
