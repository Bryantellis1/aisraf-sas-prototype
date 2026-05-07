# PRA-07-FINDING-RECOMMENDER

## 1. Identity

- pra_id: `PRA-07-FINDING-RECOMMENDER`
- pra_name: Finding Recommender
- status: active
- type: prototype review-agent specification
- package_scope: `aisraf-sas-prototype-v0.1.2`
- owning_build_package: `06`
- mapped_adapter: `.agents/aisraf-finding-recommender.agent.md`

## 2. Purpose

Classify findings (Gap, Deficiency, Strength, Question) and write evidence-bound recommendations from the supported facts produced by PRA-03 through PRA-06. PRA-07 is responsible for keeping owners, controls, and evidence honest — every finding must reference a supporting evidence row, and every recommendation must cite its parent finding. PRA-07 is a specification, not a deployed runtime agent.

## 3. Owned Prompts

- `prompts/rs/10-finding-recommendation-write.prompt.md` (RS-13 findings + RS-14 recommendations; one prompt covers both).

## 4. Owned Skills

- `skills/rs/SK-FINDING-CLASSIFY.md` (owns `13-findings.md`).
- `skills/rs/SK-RECOMMENDATION-WRITE.md` (owns `14-recommendations.md`).

## 5. Inputs

Required run-profile variables: `{{run_id}}`, `{{input_root}}`, `{{output_root}}`, `{{mode}}`, `{{postback_execution_status}}`, `{{output_destination_mode}}`.

Required reads:

- `runs/{{run_id}}/run-profile.yaml`.
- `{{output_root}}/06-boundaries.md`.
- `{{output_root}}/07-security-stack-assessment.md`.
- `{{output_root}}/08-internal-review-table.md`.
- `{{output_root}}/09-missing-facts.md`.
- `{{output_root}}/10-ai-action-level.md`.
- `{{output_root}}/11-blueprint-match.md`.
- `{{output_root}}/12-targeted-questions.md`.
- `{{output_root}}/13-findings.md` (for the recommendation pass).

Optional reads (test mode only):

- `{{expected_root}}/expected-findings.json`, `expected-recommendations.json`, when Build Package 10 provides them.

## 6. Outputs

- `{{output_root}}/13-findings.md`.
- `{{output_root}}/14-recommendations.md`.

## 7. Procedure

1. Read PRA-05 and PRA-06 outputs.
2. Open `prompts/rs/10-finding-recommendation-write.prompt.md`.
3. Apply `skills/rs/SK-FINDING-CLASSIFY.md` to write `{{output_root}}/13-findings.md`. Each finding cites at least one supporting evidence row from `06-boundaries.md`, `07-security-stack-assessment.md`, `08-internal-review-table.md`, `09-missing-facts.md`, or `12-targeted-questions.md`.
4. Apply `skills/rs/SK-RECOMMENDATION-WRITE.md` to write `{{output_root}}/14-recommendations.md`. Each recommendation cites a parent finding and names the control change without claiming implementation proof.
5. Hand off to PRA-08 (Handoff QA Scorer).

## 8. Human Gates

- SAS reviews finding category, disposition, owner, route, and evidence reference.
- SAS confirms no recommendation claims implementation proof.
- SAS confirms no Gap is mislabelled as a Deficiency (and vice versa) in a way that changes the owner.

## 9. Stop Conditions

- A finding is recorded without a supporting evidence row.
- A control, owner, or evidence reference is invented.
- A recommendation does not cite a parent finding.
- A recommendation claims implementation proof, post-back execution, or runtime validation.
- A finding category change silently changes the owner or route.
- Output written outside `{{output_root}}`.
- Any forbidden runtime/cloud/ADK/MCP/Jira/Confluence claim is recorded.

## 10. Unknown Handling

- Treat unknown owners as `unknown` with the gap routed to PRA-06's missing-fact list rather than guessed.
- Treat unknown evidence as `unknown` and refuse to promote a finding to actionable status.
- Treat absent expected baselines as `not_applicable` for scoring; never derive accuracy from finding text.

## 11. Evidence and Run-Log Guidance

- Two run-log entries are appended after SAS acceptance: RS-13 (findings) and RS-14 (recommendations). Each references the prompt path, skill path, output path, and SAS reviewer decision.
- No evidence is written outside `{{output_root}}`.

## 12. Direct Adapter Test

Operator opens `.agents/aisraf-finding-recommender.agent.md` from the local Copilot Chat agent dropdown and asks: "Read `{{output_root}}/06-boundaries.md`, `{{output_root}}/07-security-stack-assessment.md`, `{{output_root}}/08-internal-review-table.md`, `{{output_root}}/09-missing-facts.md`, `{{output_root}}/10-ai-action-level.md`, `{{output_root}}/11-blueprint-match.md`, and `{{output_root}}/12-targeted-questions.md`. Run `prompts/rs/10-finding-recommendation-write.prompt.md` with `skills/rs/SK-FINDING-CLASSIFY.md` and `skills/rs/SK-RECOMMENDATION-WRITE.md` to write `13-findings.md` and `14-recommendations.md`. Every finding must name its evidence row; every recommendation must cite a parent finding; do not claim implementation proof; do not write outside `{{output_root}}`." A PASS test produces both files with explicit evidence references and no implementation-proof claims.

## 13. Not in Scope

- Not a deployed runtime agent.
- Not a Google ADK agent.
- Not a Vertex, GCP, or external cloud agent.
- Not an MCP execution surface.
- Not a Jira post-back, Confluence publication, or Rovo execution surface.
- Not allowed to write the handoff pack, validation notes, or accuracy score (PRA-08 owns those).
- Not allowed to write outside `{{output_root}}`.
- Not allowed to modify `prompts/`, `skills/`, `config/`, `tools/`, `validation/`, `prototype-agents/`, `.agents/`, or any file under `{{expected_root}}`.
- Not allowed to claim accuracy scoring outside `skills/rs/SK-ACCURACY-SCORE.md`.
- Not allowed to claim release packaging or diagram generation.
- Not allowed to claim implementation proof for any control.
