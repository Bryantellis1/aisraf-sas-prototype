# Template: Jira Ticket Draft Template

## 1. Template Metadata

| field | value |
|---|---|
| template_id | TPL-JIRA-TICKET-DRAFT |
| template_name | Jira Ticket Draft Template |
| owning_build_package | Build Package 09 |
| status | active |
| purpose | Local Jira-ready draft formatting for a SAS handoff comment and optional attachment list. Formatting this file does not prove a Jira write happened. |
| intended_output | `{{output_root}}/jira-ticket-draft.md` |
| consumers | Prompts: PR-RS-11. Skills: SK-HANDOFF-PACK-BUILD. PRAs: PRA-08-HANDOFF-QA-SCORER. Adapters: aisraf-handoff-qa-scorer. |
| inputs_expected | `runs/{{run_id}}/run-profile.yaml`; `{{output_root}}/12-targeted-questions.md`; `{{output_root}}/13-findings.md`; `{{output_root}}/14-recommendations.md`; `{{output_root}}/15-handoff-pack.md`; `{{output_root}}/16-validation-notes.md`; `{{output_root}}/17-accuracy-score.md` |
| placeholders | `{{run_id}}`, `{{output_root}}`, `{{output_destination_mode}}`, `{{postback_execution_status}}`, `{{mode}}` |
| required_sections | Header; Jira Comment Body; Attachments Proposed; Jira Post-Back Claim Block; No-Execution Disclaimer; Safety-Check Table |
| prohibited_content | external post-back claim without `executed_by_operator` evidence; content outside resolved `{{output_root}}`; secrets / PII / credentials; finding or recommendation prose invention |
| output_boundary | under_resolved_output_root_only |
| source_reference | aisraf-sas-prototype-skill-chain-pack-v0.01/templates/jira-ticket-output-template.md (rebuilt for v0.1.2 schema) |
| version_notes | Rebuilt for v0.1.2; descriptive references to non-placeholder run-profile fields per founder Q2. |

## 2. Output Boundary

This template defines output shape only. It produces a local Markdown file under `{{output_root}}/jira-ticket-draft.md` formatted in a Jira-ready shape. Formatting this file is not a Jira write. Only an operator action recorded by `templates/run/postback-log-entry-row-template.md` plus `postback_execution_status: executed_by_operator` may claim Jira post-back.

## 3. Allowed Placeholders

Only the seven approved run-profile variables. Other run-profile fields are referenced descriptively as `[copy from runs/{{run_id}}/run-profile.yaml#field_name]`.

## 4. Header

```markdown
# Jira Ticket Draft — {{run_id}}

| field | value |
|---|---|
| run_id | {{run_id}} |
| sample_id | [copy from runs/{{run_id}}/run-profile.yaml#sample_id] |
| mode | {{mode}} |
| output_root | {{output_root}} |
| output_destination_mode | {{output_destination_mode}} |
| postback_execution_status | {{postback_execution_status}} |
| source_ticket_url | [copy from runs/{{run_id}}/run-profile.yaml#source_ticket_url] |
| destination_ticket_url | [copy from runs/{{run_id}}/run-profile.yaml#destination_ticket_url] |
| jira_connector_status | [copy from runs/{{run_id}}/run-profile.yaml#jira_connector_status] |
| rovo_mcp_available | [copy from runs/{{run_id}}/run-profile.yaml#rovo_mcp_available] |
| mcp_execution_status | [copy from runs/{{run_id}}/run-profile.yaml#mcp_execution_status] |
| local_draft_path | {{output_root}}/jira-ticket-draft.md |
```

## 5. Jira Comment Body

```markdown
### AISRAF SAS Review Summary

- Run: {{run_id}}
- Source: [copy from runs/{{run_id}}/run-profile.yaml#source_ticket_url]
- Destination: [copy from runs/{{run_id}}/run-profile.yaml#destination_ticket_url]
- Local output root: {{output_root}}
- Verdict: [copy the exact verdict line from {{output_root}}/17-accuracy-score.md when scoring ran; otherwise "scoring not applicable for this run"]

### Design Review Closeout

[Copy the accepted design-review summary from {{output_root}}/15-handoff-pack.md. Do not include validation-ticket follow-up that belongs in 16-validation-notes.md.]

### Targeted Questions

[Copy accepted targeted questions from {{output_root}}/12-targeted-questions.md. Each must remain tied to its source missing-fact id.]

### Findings

[Copy accepted findings from {{output_root}}/13-findings.md. Include only supported facts.]

### Recommendations

[Copy accepted recommendations from {{output_root}}/14-recommendations.md. Do not invent controls, owners, or evidence.]

### Separate Validation Ticket Notes

[Copy or reference accepted validation notes from {{output_root}}/16-validation-notes.md. Keep validation-ticket follow-up separate from design-review closeout.]
```

## 6. Attachments Proposed

| artifact | attach? | reason |
|---|---|---|
| `{{output_root}}/15-handoff-pack.md` | [yes/no] | Design-review handoff package. |
| `{{output_root}}/16-validation-notes.md` | [yes/no] | Separate validation-ticket notes. |
| `{{output_root}}/17-accuracy-score.md` | [yes/no] | Score / verdict evidence for scored runs. |
| [other selected output under `{{output_root}}`] | [yes/no] | [reason] |

## 7. Jira Post-Back Claim Block

Use exactly one status line. The claim must match `runs/{{run_id}}/run-profile.yaml#postback_execution_status`:

- `Jira post-back status: deferred — no Jira write has happened.`
- `Jira post-back status: formatted_only — this is a local Jira-ready draft under {{output_root}}; no Jira write has happened.`
- `Jira post-back status: executed_by_operator — operator posted this content to [copy from runs/{{run_id}}/run-profile.yaml#destination_ticket_url] and recorded evidence in {{output_root}}/00-run-log.md (post-back row per templates/run/postback-log-entry-row-template.md).`

## 8. No-Execution Disclaimer

This template formats a local Markdown file. It does not call a Jira connector, MCP server, Rovo agent, or any cloud or runtime service. Selecting this template from the AISRAF Handoff QA Scorer adapter does not write to Jira. A Jira write may only be claimed when `postback_execution_status: executed_by_operator` AND a `templates/run/postback-log-entry-row-template.md` row carrying timestamp + destination URL is present in `{{output_root}}/00-run-log.md`.

## 9. Safety-Check Table

| check | result |
|---|---|
| No credentials, tokens, cookies, real PII, PAN, SSN, customer identifiers, or production endpoints included | [PASS/FAIL] |
| Draft content comes only from accepted outputs under `{{output_root}}` | [PASS/FAIL] |
| Handoff and validation-ticket sections remain separate | [PASS/FAIL] |
| No Jira write, ticket closure, comment, or attachment upload is claimed unless `postback_execution_status: executed_by_operator` and run-log evidence exist | [PASS/FAIL] |

## 10. Source Reference

`aisraf-sas-prototype-skill-chain-pack-v0.01/templates/jira-ticket-output-template.md` (rebuilt for v0.1.2 schema; descriptive field references replace v0.01 `{{jira_connector_status}}` etc.).

## 11. Version Notes

Rebuilt for v0.1.2. Founder decisions Q2 (descriptive references to non-placeholder schema fields), Q3 (no controlled-value enumeration), and the Build Package 09 design rules apply.
