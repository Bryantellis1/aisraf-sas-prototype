# templates/jira/

Owning Build Package: Build Package 09 — Templates.

## Purpose

Local Jira-ready draft formatting templates. Each template here defines the structure of a Markdown file under `{{output_root}}/` that an operator can copy into a Jira comment or attachment when the run profile permits it. Formatting one of these files **does not** prove that a Jira write happened.

## Inventory

1 template:

- `jira-ticket-draft-template.md` — local Jira draft template; consumed by SK-HANDOFF-PACK-BUILD / PRA-08-HANDOFF-QA-SCORER / aisraf-handoff-qa-scorer.

## Boundary

The Jira draft template:

- Writes only under `{{output_root}}` (typical artifact: `{{output_root}}/jira-ticket-draft.md`).
- Uses only the seven approved run-profile placeholders. Other schema fields (`sample_id`, `source_ticket_url`, `destination_ticket_url`, `jira_connector_status`, `rovo_mcp_available`, `mcp_execution_status`) are referenced descriptively as `[copy from runs/{{run_id}}/run-profile.yaml#field_name]`.
- Includes the three-line post-back claim block (`deferred` / `formatted_only` / `executed_by_operator`) and a no-execution disclaimer.
- Includes a safety-check table (no credentials, tokens, real PII, PAN, SSN, customer identifiers, or production endpoints).
- References only accepted outputs under `{{output_root}}`. It does not invent finding or recommendation prose.

## Post-Back Evidence Rule

A Jira post-back may be claimed (`postback_execution_status: executed_by_operator`) only when:

- `runs/{{run_id}}/run-profile.yaml#postback_execution_status` is `executed_by_operator`, AND
- `runs/{{run_id}}/run-profile.yaml#output_destination_mode` is `external_postback_executed`, AND
- A row matching `templates/run/postback-log-entry-row-template.md` is appended to `{{output_root}}/00-run-log.md` with timestamp, operator, destination URL, and action_performed.

Otherwise the draft remains `deferred` or `formatted_only` and no Jira write may be claimed.
