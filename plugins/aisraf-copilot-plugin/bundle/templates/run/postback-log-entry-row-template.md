# Template: Post-Back Log Entry Row Template

## 1. Template Metadata

| field | value |
|---|---|
| template_id | TPL-RUN-POSTBACK-LOG-ENTRY-ROW |
| template_name | Post-Back Log Entry Row Template |
| owning_build_package | Build Package 09 |
| status | active |
| purpose | Append-only row that proves a human operator posted SAS output to Jira, published to Confluence, or both. Allowed only when `postback_execution_status: executed_by_operator` AND a destination URL is present. |
| intended_output | append row into `{{output_root}}/00-run-log.md` Post-Back Evidence section |
| consumers | PRAs: PRA-08-HANDOFF-QA-SCORER. Adapters: aisraf-handoff-qa-scorer. |
| inputs_expected | (none — the row is produced after an actual operator post-back action) |
| placeholders | `{{run_id}}`, `{{output_root}}`, `{{output_destination_mode}}`, `{{postback_execution_status}}` |
| required_sections | Row Fields; Required Evidence Rule; Use-Once Constraint |
| prohibited_content | append when `postback_execution_status` is `deferred`, `formatted_only`, or `not_attempted`; secrets / PII / credentials; finding or recommendation prose |
| output_boundary | append-only under `{{output_root}}/00-run-log.md` Post-Back Evidence section, only when `postback_execution_status: executed_by_operator` |
| source_reference | aisraf-sas-prototype-skill-chain-pack-v0.01/templates/postback-log-entry-template.md (rebuilt for v0.1.2 schema) |
| version_notes | Rebuilt for v0.1.2. |

## 2. Output Boundary

This template defines a single append row that records an operator-executed external action (Jira comment / attachment, Confluence publish / update, or both). The row is the only authoritative evidence that an external write happened. Without this row plus matching run-profile state, no artifact may claim Jira post-back or Confluence publication.

## 3. Allowed Placeholders

Only the seven approved run-profile variables. Other run-profile fields are referenced descriptively as `[copy from runs/{{run_id}}/run-profile.yaml#field_name]`.

## 4. Row Template

Append one of the following Markdown blocks per actual post-back action:

```markdown
### Post-Back Evidence — {{run_id}}

| field | value |
|---|---|
| timestamp | [ISO 8601 UTC] |
| run_id | {{run_id}} |
| sample_id | [copy from runs/{{run_id}}/run-profile.yaml#sample_id] |
| operator_name | [copy from runs/{{run_id}}/run-profile.yaml#operator_name] |
| reviewer_name | [copy from runs/{{run_id}}/run-profile.yaml#reviewer_name] |
| output_destination_mode | {{output_destination_mode}} |
| postback_execution_status | executed_by_operator |
| jira_connector_status | [copy from runs/{{run_id}}/run-profile.yaml#jira_connector_status] |
| confluence_connector_status | [copy from runs/{{run_id}}/run-profile.yaml#confluence_connector_status] |
| rovo_mcp_available | [copy from runs/{{run_id}}/run-profile.yaml#rovo_mcp_available] |
| mcp_execution_status | [copy from runs/{{run_id}}/run-profile.yaml#mcp_execution_status] |
| destination_ticket_url | [copy from runs/{{run_id}}/run-profile.yaml#destination_ticket_url] |
| destination_confluence_url | [copy from runs/{{run_id}}/run-profile.yaml#destination_confluence_url] |
| local_postback_artifact | [e.g. {{output_root}}/jira-ticket-draft.md, {{output_root}}/confluence-page-draft.md, or {{output_root}}/15-handoff-pack.md] |
| external_destination_reference | [Jira comment URL/ID, attachment reference, Confluence page URL, or operator-recorded destination ID] |
| action_performed | [posted_jira_comment / uploaded_jira_attachment / published_confluence_page / updated_confluence_page / jira_and_confluence] |
| executed_by_operator_confirmation | [operator confirms the external action was performed] |
| human_gate_disposition | [accepted / rejected / deferred] |
| evidence_location | [path or reference where proof is recorded; usually this run-log row plus the destination URL] |
| sensitive_data_check | PASS / FAIL — no credentials, tokens, real PII, PAN, SSN, customer identifiers, or production endpoints |
| notes | [free text; include connector evidence only if verified] |
```

## 5. Required Evidence Rule

This row is valid only when ALL of the following hold:

1. `runs/{{run_id}}/run-profile.yaml#postback_execution_status` is `executed_by_operator`.
2. `runs/{{run_id}}/run-profile.yaml#output_destination_mode` is `external_postback_executed`.
3. At least one of `destination_ticket_url` or `destination_confluence_url` is non-empty (per `config/run-profile.schema.yaml` allOf rules).
4. The operator actually performed the external action.
5. The local artifact posted or published was produced under `{{output_root}}`.
6. The row records timestamp, destination reference, artifact reference, operator confirmation, human-gate disposition, and the sensitive-data check.

If any item is missing, keep the run at `deferred` or `formatted_only` and **do not** append this row.

## 6. Use-Once Constraint

One row per actual post-back action. Multiple actions in a single run produce multiple rows (one per action). Re-using a single row to claim multiple actions is forbidden.

## 7. Source Reference

`aisraf-sas-prototype-skill-chain-pack-v0.01/templates/postback-log-entry-template.md` (rebuilt for v0.1.2 schema).

## 8. Version Notes

Rebuilt for v0.1.2.
