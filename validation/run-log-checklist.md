# Run Log Checklist

Authored by: BUILD-AG-11-RUNS-R1.

Scope: pins the canonical shape, append rules, and post-back gating for `runs/<run_id>/00-run-log.md` in AISRAF SAS Prototype v0.1.2. The file shape comes from `templates/output/output-00-run-log-template.md` (Build Package 09 founder decision Q1); the per-step row pattern comes from `templates/run/run-log-entry-row-template.md`; the post-back row pattern comes from `templates/run/postback-log-entry-row-template.md`.

## 1. Required Sections

The run log must contain these sections in this order (matching `templates/output/output-00-run-log-template.md` § 5):

1. **File Header** — the run identity table (`run_id`, `sample_id`, `mode`, `output_root`, `output_destination_mode`, `postback_execution_status`, `operator_name`, `reviewer_name`, `created_at`).
2. **Run Identity** — short narrative naming the active prompts/skills/PRAs the operator will execute.
3. **Step Entries** — append-only log of executed prompt/skill/PRA steps. Empty until the chain runs. Each entry follows `templates/run/run-log-entry-row-template.md`.
4. **Post-Back Evidence** — append-only log of operator-executed external actions. Allowed only when `postback_execution_status: executed_by_operator` plus a destination URL is present. Each row follows `templates/run/postback-log-entry-row-template.md`.
5. **Stop Conditions Recorded** — every stop condition triggered during the run, with timestamp and step.

A run log may also include an **Append Rules** section documenting the rules in §3.

## 2. Allowed Placeholders

Only the seven approved run-profile variables: `{{run_id}}`, `{{input_root}}`, `{{expected_root}}`, `{{output_root}}`, `{{mode}}`, `{{postback_execution_status}}`, `{{output_destination_mode}}`. Other run-profile fields are referenced descriptively as `[copy from runs/{{run_id}}/run-profile.yaml#field_name]`. Non-schema variables (`{{catalog_root}}`, `{{prompt_root}}`, `{{skill_root}}`, `{{template_root}}`, `{{diagram_root}}`, `{{validation_root}}`) are forbidden.

## 3. Append Rules

- The run log is **append-only**. Existing rows are not edited.
- One row per step. Multi-output steps record both artefacts in the same row's `output_artifacts_written` field.
- A step entry is required for every prompt/skill/PRA execution. Skipped steps record a row with `validation_result: SKIPPED` and the reason.
- Critical-miss-flagged entries stop the run. The post-condition row records the stop, the impacted artefacts, and any unknowns held open. Suppressing a critical miss to achieve a PASS verdict is forbidden.
- Step rows live in **Step Entries**; post-back rows live in **Post-Back Evidence**. Mixing the two row patterns into the same section is forbidden.

## 4. Post-Back Row Gating

A row in **Post-Back Evidence** is admissible only when ALL of the following hold (per `templates/run/postback-log-entry-row-template.md` § 5):

1. `runs/<run_id>/run-profile.yaml#postback_execution_status` is `executed_by_operator`.
2. `runs/<run_id>/run-profile.yaml#output_destination_mode` is `external_postback_executed`.
3. At least one of `destination_ticket_url` or `destination_confluence_url` is non-empty (per `config/run-profile.schema.yaml` allOf rules).
4. The operator actually performed the external action.
5. The local artefact posted or published was produced under `output_root`.
6. The row records timestamp, destination reference, artefact reference, operator confirmation, human-gate disposition, and a sensitive-data check.

If any item is missing, keep the run at `deferred` or `formatted_only` and **do not** append a Post-Back Evidence row. No artifact, prompt, skill, PRA, runbook, scoring report, manifest entry, evidence record, diagram, or message may claim Jira post-back, Confluence publication, MCP execution, or connector use unless the rule above is satisfied (per `validation/no-drift-rules.md`).

## 5. Prohibited Content

- Severity, score, AI Action Level, or blueprint-match computation inside the run log.
- Finding prose, recommendation prose, validation-ticket prose, or owner routing prose. Those belong to their respective output files.
- Any `Jira post-back: executed_by_operator` claim unless §4 is satisfied AND the matching post-back row is appended.
- Credentials, tokens, real PII, PAN, SSN, customer identifiers, or production endpoints in any field.
- Any reference to non-schema variables (see §2).

## 6. RUN-001 Initial State (Build Package 11)

Build Package 11 establishes the model only. The RUN-001 run log starts:

- **Step Entries** — empty (no prompt/skill/PRA execution claimed).
- **Post-Back Evidence** — empty (`postback_execution_status: deferred`).
- **Stop Conditions Recorded** — empty (no chain execution).

The first step row appears when the operator executes `prompts/rs/01-input-package-read.prompt.md` (or any other Package 04 prompt). The first post-back row appears only after a real operator post-back action with the run profile flipped per §4.

## 7. Compatibility Note — `tools/New-AisrafRun.ps1`

The current `tools/New-AisrafRun.ps1` emits a legacy `00-run-log.md` header that predates Build Package 09 founder decision Q1 (file shape vs row pattern split). It writes a "Setup posture" + ledger table format that does not match `templates/output/output-00-run-log-template.md`'s required sections.

Build Package 11 RUN-001 was therefore built **by hand**, with the run log written directly per the Package 09 file shape. `tools/New-AisrafRun.ps1` is sealed under the Build Package 03 contract; this mismatch is recorded as a known compatibility note awaiting a future governed Build Package 03 increment to align the tool's emission to the Package 09 file shape.

Operators using `tools/New-AisrafRun.ps1` for smoke runs should overwrite the emitted `00-run-log.md` with a Package 09-compliant version before any chain execution writes step rows.

## 8. Acceptance

This checklist passes when:

- `runs/<run_id>/00-run-log.md` carries the five required sections in §1.
- Section bodies follow §3 (append-only, one row per step) and §4 (post-back gating).
- §5 prohibitions hold.
- Only the seven approved placeholders appear; other run-profile fields are referenced descriptively.

For RUN-001 specifically, `tools/Test-AisrafPackage.ps1` Check `08i-runs-content-limits` enforces the file's presence and shape; the body-content rules above are operator-and-reviewer-verified during run execution.
