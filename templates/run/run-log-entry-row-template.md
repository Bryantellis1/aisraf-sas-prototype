# Template: Run Log Entry Row Template

## 1. Template Metadata

| field | value |
|---|---|
| template_id | TPL-RUN-LOG-ENTRY-ROW |
| template_name | Run Log Entry Row Template |
| owning_build_package | Build Package 09 |
| status | active |
| purpose | Per-step append row appended into `{{output_root}}/00-run-log.md` by every PRA after each prompt/skill execution. The run-log file shape lives in `templates/output/output-00-run-log-template.md`. |
| intended_output | append row into `{{output_root}}/00-run-log.md` Step Entries section |
| consumers | All 23 prompts (PR-RS-01..13 and PR-DFD-02..10), all 26 skills, all 8 PRAs (PRA-01..08), all 7 adapters (aisraf-orchestrator, aisraf-input-reader, aisraf-dfd-extractor, aisraf-review-table-builder, aisraf-blueprint-questioner, aisraf-finding-recommender, aisraf-handoff-qa-scorer). |
| inputs_expected | (none — the row is produced as a step completes) |
| placeholders | `{{run_id}}`, `{{output_root}}`, `{{mode}}`, `{{output_destination_mode}}`, `{{postback_execution_status}}` |
| required_sections | Row Fields; Usage Notes |
| prohibited_content | external post-back claim without `executed_by_operator` evidence (use the post-back row instead); finding or recommendation prose; secrets / PII / credentials |
| output_boundary | append-only under `{{output_root}}/00-run-log.md` only |
| source_reference | aisraf-sas-prototype-skill-chain-pack-v0.01/templates/run-log-entry-template.md (row pattern reused; file shape moved to `templates/output/output-00-run-log-template.md` per founder Q1) |
| version_notes | Rebuilt for v0.1.2 with Q1 split. |

## 2. Output Boundary

This template defines a single append row. It is consumed by every PRA after each prompt/skill execution. The row records what the step did, what it read, what it wrote, and any unknowns / critical misses / human-gate state. It does not invent findings or recommendations.

## 3. Allowed Placeholders

Only the seven approved run-profile variables. Other run-profile fields are referenced descriptively as `[copy from runs/{{run_id}}/run-profile.yaml#field_name]`.

## 4. Row Template

Append one of the following Markdown blocks per executed step:

```markdown
### Step Entry — {{run_id}} — RS-NN or DFD-NN

| field | value |
|---|---|
| timestamp | [ISO 8601 UTC, e.g. 2026-05-07T14:23:00Z] |
| run_id | {{run_id}} |
| sample_id | [copy from runs/{{run_id}}/run-profile.yaml#sample_id] |
| step_id | [RS-01 .. RS-13 or DFD-01 .. DFD-09] |
| agent_or_prompt | [PRA-NN-NAME and prompts/<family>/<NN-name>.prompt.md] |
| skill_or_blueprint | [skills/<family>/SK-*.md or BP-* if blueprint matched in this step] |
| input_artifacts_read | [list of artifact paths read as input] |
| output_artifacts_written | [list of artifact paths produced; multi-output steps list both] |
| validation_result | PASS / PARTIAL / FAIL / SKIPPED / PENDING |
| critical_miss_status | NONE / FLAGGED — if FLAGGED, describe |
| unknowns_recorded | [count and brief description; record 0 if none] |
| targeted_questions_created | [count and Q-* IDs; record 0 if none] |
| recommendation_ids_created | [list of R-* IDs; or NONE] |
| validation_notes_created | [list of VN-* IDs; or NONE] |
| human_gate_required | YES / NO |
| human_gate_disposition | [accepted / rejected / deferred / pending] |
| callback_route | [next step or PRA to invoke; or NONE if chain complete] |
| notes | [free text for operator observations; no secrets, tokens, or real PII] |
```

## 5. Usage Notes

- One row per executed prompt/skill/PRA step. Multi-output steps record all `output_artifacts_written` in a single row.
- Skipped steps record a row with `validation_result: SKIPPED` and the reason in `notes`.
- `critical_miss_status: FLAGGED` stops the run. Do not suppress a critical miss to achieve a PASS verdict.
- `unknowns_recorded` and `targeted_questions_created` are required. Record `0` when none apply; do not leave blank.
- No `Jira post-back: executed_by_operator` claim may appear in this row. Use `templates/run/postback-log-entry-row-template.md` for post-back evidence.
- Do not include credentials, tokens, real PII, PAN, SSN, customer identifiers, or production endpoints in any field.

## 6. Source Reference

`aisraf-sas-prototype-skill-chain-pack-v0.01/templates/run-log-entry-template.md` (row pattern reused; file shape moved per founder Q1).

## 7. Version Notes

Rebuilt for v0.1.2.
