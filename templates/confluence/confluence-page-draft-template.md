# Template: Confluence Page Draft Template

## 1. Template Metadata

| field | value |
|---|---|
| template_id | TPL-CONFLUENCE-PAGE-DRAFT |
| template_name | Confluence Page Draft Template |
| owning_build_package | Build Package 09 |
| status | active |
| purpose | Local Confluence-ready draft formatting for a SAS reader page. Formatting this file does not prove a Confluence publish happened. |
| intended_output | `{{output_root}}/confluence-page-draft.md` |
| consumers | Prompts: PR-RS-11. Skills: SK-HANDOFF-PACK-BUILD. PRAs: PRA-08-HANDOFF-QA-SCORER. Adapters: aisraf-handoff-qa-scorer. |
| inputs_expected | `runs/{{run_id}}/run-profile.yaml`; `{{output_root}}/06-boundaries.md`; `{{output_root}}/07-security-stack-assessment.md`; `{{output_root}}/08-internal-review-table.md`; `{{output_root}}/12-targeted-questions.md`; `{{output_root}}/13-findings.md`; `{{output_root}}/14-recommendations.md`; `{{output_root}}/15-handoff-pack.md`; `{{output_root}}/16-validation-notes.md`; `{{output_root}}/17-accuracy-score.md` |
| placeholders | `{{run_id}}`, `{{output_root}}`, `{{output_destination_mode}}`, `{{postback_execution_status}}`, `{{mode}}` |
| required_sections | Page Metadata; Review Summary; Verdict; Scope and Inputs; Flow and Boundary Summary; Findings and Recommendations; Targeted Questions; Separate Validation Ticket Notes; Local Artifact References; Confluence Publication Claim Block; No-Execution Disclaimer; Safety-Check Table |
| prohibited_content | external post-back claim without `executed_by_operator` evidence; content outside resolved `{{output_root}}`; secrets / PII / credentials; finding or recommendation prose invention |
| output_boundary | under_resolved_output_root_only |
| source_reference | aisraf-sas-prototype-skill-chain-pack-v0.01/templates/confluence-page-output-template.md (rebuilt for v0.1.2 schema) |
| version_notes | Rebuilt for v0.1.2; descriptive references to non-placeholder run-profile fields per founder Q2. |

## 2. Output Boundary

This template defines output shape only. It produces a local Markdown file under `{{output_root}}/confluence-page-draft.md` formatted in a Confluence-ready shape. Formatting this file is not a Confluence publish. Only an operator action recorded by `templates/run/postback-log-entry-row-template.md` plus `postback_execution_status: executed_by_operator` may claim Confluence publication.

## 3. Allowed Placeholders

Only the seven approved run-profile variables. Other run-profile fields are referenced descriptively as `[copy from runs/{{run_id}}/run-profile.yaml#field_name]`.

## 4. Page Metadata

```markdown
# AISRAF SAS Review — {{run_id}}

| field | value |
|---|---|
| page_title | AISRAF SAS Review — {{run_id}} |
| run_id | {{run_id}} |
| sample_id | [copy from runs/{{run_id}}/run-profile.yaml#sample_id] |
| mode | {{mode}} |
| output_root | {{output_root}} |
| output_destination_mode | {{output_destination_mode}} |
| postback_execution_status | {{postback_execution_status}} |
| source_ticket_url | [copy from runs/{{run_id}}/run-profile.yaml#source_ticket_url] |
| destination_confluence_url | [copy from runs/{{run_id}}/run-profile.yaml#destination_confluence_url] |
| confluence_connector_status | [copy from runs/{{run_id}}/run-profile.yaml#confluence_connector_status] |
| rovo_mcp_available | [copy from runs/{{run_id}}/run-profile.yaml#rovo_mcp_available] |
| mcp_execution_status | [copy from runs/{{run_id}}/run-profile.yaml#mcp_execution_status] |
| local_draft_path | {{output_root}}/confluence-page-draft.md |
```

## 5. Required Sections

1. **Review Summary** — copy the accepted summary from `{{output_root}}/15-handoff-pack.md`. State whether the run mode is folder-first or integration-assisted (from `{{mode}}`). Do not claim runtime deployment, cloud execution, Jira update, Confluence publish, or implementation proof.
2. **Verdict**

   | field | value |
   |---|---|
   | score_or_verdict | [copy the exact line from `{{output_root}}/17-accuracy-score.md` when scoring ran; otherwise "scoring not applicable for this run"] |
   | critical_miss_status | [copy from `{{output_root}}/17-accuracy-score.md` or run log] |
   | human_gate | [accepted / rejected / deferred — with reviewer name from runs/{{run_id}}/run-profile.yaml#reviewer_name] |
   | postback_status | {{postback_execution_status}} |

3. **Scope and Inputs** — summarize accepted inputs from `{{output_root}}/01-input-inventory.md`. If inputs were Jira-derived, state that they were staged under `{{input_root}}` before execution.
4. **Flow and Boundary Summary** — copy selected accepted rows from `{{output_root}}/06-boundaries.md`, `{{output_root}}/07-security-stack-assessment.md`, and `{{output_root}}/08-internal-review-table.md`.
5. **Findings and Recommendations** — copy accepted rows from `{{output_root}}/13-findings.md` and `{{output_root}}/14-recommendations.md`.
6. **Targeted Questions** — copy accepted rows from `{{output_root}}/12-targeted-questions.md`.
7. **Separate Validation Ticket Notes** — copy or reference accepted notes from `{{output_root}}/16-validation-notes.md`. Keep validation-ticket follow-up separate from design-review closeout.
8. **Local Artifact References**

   | artifact | purpose |
   |---|---|
   | `{{output_root}}/15-handoff-pack.md` | Design-review handoff package. |
   | `{{output_root}}/16-validation-notes.md` | Separate validation-ticket notes. |
   | `{{output_root}}/17-accuracy-score.md` | Score / verdict evidence for scored runs. |
   | `{{output_root}}/00-run-log.md` | Local run evidence; share only if explicitly approved. |

## 6. Confluence Publication Claim Block

Use exactly one status line. The claim must match `runs/{{run_id}}/run-profile.yaml#postback_execution_status`:

- `Confluence publication status: deferred — no Confluence page has been published.`
- `Confluence publication status: formatted_only — this is a local Confluence-ready draft under {{output_root}}; no Confluence page has been published.`
- `Confluence publication status: executed_by_operator — operator published or updated [copy from runs/{{run_id}}/run-profile.yaml#destination_confluence_url] and recorded evidence in {{output_root}}/00-run-log.md (post-back row per templates/run/postback-log-entry-row-template.md).`

## 7. No-Execution Disclaimer

This template formats a local Markdown file. It does not call a Confluence connector, MCP server, Rovo agent, or any cloud or runtime service. Selecting this template from the AISRAF Handoff QA Scorer adapter does not publish to Confluence. A Confluence publish may only be claimed when `postback_execution_status: executed_by_operator` AND a `templates/run/postback-log-entry-row-template.md` row carrying timestamp + destination URL is present in `{{output_root}}/00-run-log.md`.

## 8. Safety-Check Table

| check | result |
|---|---|
| No credentials, tokens, cookies, real PII, PAN, SSN, customer identifiers, or production endpoints included | [PASS/FAIL] |
| Draft content comes only from accepted outputs under `{{output_root}}` | [PASS/FAIL] |
| Handoff and validation-ticket sections remain separate | [PASS/FAIL] |
| No Confluence publish/update is claimed unless `postback_execution_status: executed_by_operator` and run-log evidence exist | [PASS/FAIL] |

## 9. Source Reference

`aisraf-sas-prototype-skill-chain-pack-v0.01/templates/confluence-page-output-template.md` (rebuilt for v0.1.2 schema).

## 10. Version Notes

Rebuilt for v0.1.2.
