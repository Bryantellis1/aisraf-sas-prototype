# Template: Run Log Output File Shape

## 1. Template Metadata

| field | value |
|---|---|
| template_id | TPL-OUT-00-RUN-LOG |
| template_name | Run Log Output File Shape |
| owning_build_package | Build Package 09 |
| status | active |
| purpose | Define the file-level shape of `{{output_root}}/00-run-log.md` (header, append-only step entries, post-back evidence section). Per-row patterns live in `templates/run/run-log-entry-row-template.md` and `templates/run/postback-log-entry-row-template.md` (founder decision Q1). |
| intended_output | `{{output_root}}/00-run-log.md` |
| consumers | PRAs: PRA-01-SAS-REVIEW-ORCHESTRATOR. Adapters: aisraf-orchestrator. Every PRA appends per-step rows. |
| inputs_expected | (none — the run log is append-only and produced incrementally as the chain runs.) |
| placeholders | `{{run_id}}`, `{{output_root}}`, `{{mode}}`, `{{postback_execution_status}}`, `{{output_destination_mode}}` |
| required_sections | File Header; Run Identity; Step Entries; Post-Back Evidence; Stop Conditions Recorded |
| prohibited_content | severity / score / AI Action Level / blueprint-match computation; finding prose; recommendation prose; external post-back claim without `executed_by_operator` evidence |
| output_boundary | under_resolved_output_root_only (single canonical path: `{{output_root}}/00-run-log.md`) |
| source_reference | aisraf-sas-prototype-skill-chain-pack-v0.01/templates/run-log-entry-template.md (conceptual reuse only; file shape and row pattern were conflated in v0.01 and are split here per founder Q1) |
| version_notes | New for Build Package 09. |

## 2. Output Boundary

This template defines output shape only. It does not execute the review, compute severity, score, AI Action Level, or blueprint match, invent finding facts or recommendation prose, claim Jira / Confluence / Rovo / MCP / runtime / cloud / ADK / database / Terraform execution, or override catalogs or blueprints.

## 3. Allowed Placeholders

Only the seven approved run-profile variables: `{{run_id}}`, `{{input_root}}`, `{{expected_root}}`, `{{output_root}}`, `{{mode}}`, `{{postback_execution_status}}`, `{{output_destination_mode}}`. Other run-profile fields are referenced descriptively as `[copy from runs/{{run_id}}/run-profile.yaml#field_name]`. No `{{catalog_root}}`, `{{prompt_root}}`, `{{skill_root}}`, `{{template_root}}`, `{{diagram_root}}`, or `{{validation_root}}`.

## 4. File Header

```markdown
# Run Log — {{run_id}}

| field | value |
|---|---|
| run_id | {{run_id}} |
| sample_id | [copy from runs/{{run_id}}/run-profile.yaml#sample_id] |
| mode | {{mode}} |
| output_root | {{output_root}} |
| output_destination_mode | {{output_destination_mode}} |
| postback_execution_status | {{postback_execution_status}} |
| operator_name | [copy from runs/{{run_id}}/run-profile.yaml#operator_name] |
| reviewer_name | [copy from runs/{{run_id}}/run-profile.yaml#reviewer_name] |
| created_at | [copy from runs/{{run_id}}/run-profile.yaml#created_at] |
```

## 5. Required Sections

Output the file with these sections in this order:

1. **File Header** (the table above)
2. **Run Identity** — short narrative naming the active prompts/skills/PRAs the operator will execute.
3. **Step Entries** — append-only log. Each entry follows `templates/run/run-log-entry-row-template.md`. One entry per executed prompt/skill/PRA step, written in chronological order.
4. **Post-Back Evidence** — append-only log. Each row follows `templates/run/postback-log-entry-row-template.md`. Allowed only when `{{postback_execution_status}}` is `executed_by_operator` (per `config/run-profile.schema.yaml`).
5. **Stop Conditions Recorded** — every stop condition triggered during the run, with timestamp and step.

## 6. Append Rules

- The run log is append-only. Existing rows are not edited.
- One row per step. Multi-output steps (e.g., PR-RS-04 writes both `04-components.md` and `05-flows.md`) record both artifacts in the same row's `output_artifacts_written` field.
- A step entry is required for every prompt/skill/PRA execution. Skipped steps record a row with `validation_result: SKIPPED` and the reason.
- Critical-miss flagged entries stop the run. The post-condition row records the stop, the impacted artifacts, and any unknowns held open.

## 7. Prohibited Content

- Severity, score, AI Action Level, or blueprint-match computation inside the run log.
- Finding prose, recommendation prose, validation-ticket prose, or owner routing prose. Those belong to their respective output files.
- Any `Jira post-back: executed_by_operator` claim unless `runs/{{run_id}}/run-profile.yaml#postback_execution_status` is `executed_by_operator` AND a `templates/run/postback-log-entry-row-template.md` row carrying timestamp + destination URL is present.
- Credentials, tokens, real PII, PAN, SSN, customer identifiers, or production endpoints in any field.

## 8. Source Reference

`aisraf-sas-prototype-skill-chain-pack-v0.01/templates/run-log-entry-template.md` — conceptual reuse only. v0.01 conflated file shape with row pattern; the v0.1.2 split (file → output/, row → run/) is founder decision Q1.

## 9. Version Notes

New for Build Package 09. Build Package 11 will exercise this template against a real run when run outputs are first produced.
