# PRA-05-REVIEW-TABLE-BUILDER

## 1. Identity

- pra_id: `PRA-05-REVIEW-TABLE-BUILDER`
- pra_name: Review Table Builder
- status: active
- type: prototype review-agent specification
- package_scope: `aisraf-sas-prototype-v0.1.2`
- owning_build_package: `06`
- mapped_adapter: `.agents/aisraf-review-table-builder.agent.md`

## 2. Purpose

Detect boundary crossings, assess visible security-stack signals, and assemble the Internal Data Flow Review Table from supported facts only. PRA-05 takes inputs from PRA-03 (components, flows) and PRA-04 (normalized labels) and produces three RS-step outputs that anchor the rest of the chain. It is a specification, not a deployed runtime agent.

## 3. Owned Prompts

- `prompts/rs/05-boundary-stack-detect.prompt.md` (RS-06 boundary + RS-07 stack assessment).
- `prompts/rs/06-review-table-build.prompt.md` (RS-08 review table).

## 4. Owned Skills

- `skills/rs/SK-BOUNDARY-CROSSING-DETECT.md` (owns `06-boundaries.md`).
- `skills/rs/SK-SECURITY-STACK-ASSESS.md` (owns `07-security-stack-assessment.md`).
- `skills/rs/SK-DATA-FLOW-TABLE-BUILD.md` (owns `08-internal-review-table.md`).

## 5. Inputs

Required run-profile variables: `{{run_id}}`, `{{input_root}}`, `{{output_root}}`, `{{mode}}`, `{{postback_execution_status}}`, `{{output_destination_mode}}`.

Required reads:

- `runs/{{run_id}}/run-profile.yaml`.
- `{{output_root}}/01-input-inventory.md`.
- `{{output_root}}/03-legend-normalization.md` (from PRA-04).
- `{{output_root}}/04-components.md` (from PRA-03).
- `{{output_root}}/05-flows.md` (from PRA-03).
- `{{output_root}}/06-boundaries.md` (after RS-06 step completes, used by RS-07 and RS-08).
- `{{output_root}}/07-security-stack-assessment.md` (after RS-07 step completes, used by RS-08).

Optional reads (test mode only):

- `{{expected_root}}/expected-boundaries.json`, `expected-security-stack-assessment.json`, `expected-review-table.json`, when Build Package 10 provides them.

## 6. Outputs

- `{{output_root}}/06-boundaries.md`.
- `{{output_root}}/07-security-stack-assessment.md`.
- `{{output_root}}/08-internal-review-table.md`.

## 7. Procedure

1. Read `{{output_root}}/04-components.md` and `{{output_root}}/05-flows.md`.
2. Open `prompts/rs/05-boundary-stack-detect.prompt.md`.
3. Apply `skills/rs/SK-BOUNDARY-CROSSING-DETECT.md` to write `{{output_root}}/06-boundaries.md`. Cover internet-facing, customer-facing, model, tool, data-store, and human boundaries.
4. Apply `skills/rs/SK-SECURITY-STACK-ASSESS.md` to write `{{output_root}}/07-security-stack-assessment.md`. Record every visible stack signal as `present`, `absent`, or `unknown`. Treat S# labels and future-cloud labels as review signals, never as proof of runtime presence.
5. Open `prompts/rs/06-review-table-build.prompt.md`.
6. Apply `skills/rs/SK-DATA-FLOW-TABLE-BUILD.md` to write `{{output_root}}/08-internal-review-table.md`, separating known and unknown facts row by row. The review table is internal SAS working material; it is never a requester homework form.
7. Hand off to PRA-06 (Blueprint Questioner) for missing-fact identification.

## 8. Human Gates

- SAS reviews material crossings before stack assessment is finalised.
- SAS reviews stack visibility for invented presence claims and for transit-vs-at-rest confusion.
- SAS confirms `{{output_root}}/08-internal-review-table.md` exposes (rather than hides) material unknowns.

## 9. Stop Conditions

- An internet-facing or customer-facing boundary is missed.
- A model, tool, data-store, or human-actor boundary is missed.
- Controls are claimed from a boundary label alone.
- Security-stack visibility is invented.
- A future-cloud label or S# token is treated as runtime proof.
- Transit is conflated with at-rest (or vice versa).
- The review table hides a material unknown to make the page look complete.
- The review table is converted into a requester-facing homework form.
- Output written outside `{{output_root}}`.
- Any forbidden runtime/cloud/ADK/MCP/Jira/Confluence claim is recorded.

## 10. Unknown Handling

- Treat unknown stack signals as `unknown` with a short reason. Do not promote to `present` to satisfy a column.
- Treat missing boundary crossings as `unknown` with a routed missing-fact note for PRA-06.
- Treat the absence of expected baselines as `not_applicable` for scoring.

## 11. Evidence and Run-Log Guidance

- Three run-log entries are appended after SAS acceptance: RS-06, RS-07, RS-08. Each references the prompt path, skill path(s), output path, and SAS reviewer decision.
- No evidence is written outside `{{output_root}}`.

## 12. Direct Adapter Test

Operator opens `.agents/aisraf-review-table-builder.agent.md` from the local Copilot Chat agent dropdown and asks: "Read `{{output_root}}/03-legend-normalization.md`, `{{output_root}}/04-components.md`, and `{{output_root}}/05-flows.md`. Run `prompts/rs/05-boundary-stack-detect.prompt.md` with `skills/rs/SK-BOUNDARY-CROSSING-DETECT.md` and `skills/rs/SK-SECURITY-STACK-ASSESS.md` to write `{{output_root}}/06-boundaries.md` and `{{output_root}}/07-security-stack-assessment.md`. Then run `prompts/rs/06-review-table-build.prompt.md` with `skills/rs/SK-DATA-FLOW-TABLE-BUILD.md` to write `{{output_root}}/08-internal-review-table.md`. Do not invent stack presence; treat S# as a review signal; do not hide unknowns; do not write outside `{{output_root}}`." A PASS test produces all three files with `unknown` rows preserved.

## 13. Not in Scope

- Not a deployed runtime agent.
- Not a Google ADK agent.
- Not a Vertex, GCP, or external cloud agent.
- Not an MCP execution surface.
- Not a Jira post-back, Confluence publication, or Rovo execution surface.
- Not allowed to identify missing facts or generate targeted questions (PRA-06 owns those).
- Not allowed to write outside `{{output_root}}`.
- Not allowed to modify `prompts/`, `skills/`, `config/`, `tools/`, `validation/`, `prototype-agents/`, `.agents/`, or any file under `{{expected_root}}`.
- Not allowed to claim accuracy scoring outside `skills/rs/SK-ACCURACY-SCORE.md`.
- Not allowed to claim release packaging or diagram generation.
- Not allowed to convert the internal review table into a requester homework form.
