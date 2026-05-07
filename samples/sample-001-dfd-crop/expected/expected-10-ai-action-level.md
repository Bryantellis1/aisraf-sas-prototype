---
expected_baseline_id: EXP-RS-10-AI-ACTION-LEVEL
sample_id: sample-001-dfd-crop
mirrors_template: templates/output/output-10-ai-action-level-template.md
prompt: prompts/rs/08-ai-action-level-classify.prompt.md
skill: skills/rs/SK-AI-ACTION-LEVEL-CLASSIFY.md
owning_pra: PRA-06-BLUEPRINT-QUESTIONER
adapter: .agents/aisraf-blueprint-questioner.agent.md
target_run_output: "{{output_root}}/10-ai-action-level.md"
expected_outcome: PASS_READY_FOR_REVIEW
scoring_basis: template-aligned qualitative baseline; numeric scoring deferred to Build Package 11 run execution
package_version: v0.1.2
---

# AI Action Level — sample-001-dfd-crop

| field | value |
|---|---|
| run_id | `{{run_id}}` |
| sample_id | sample-001-dfd-crop |
| mode | `{{mode}}` |
| output_root | `{{output_root}}` |
| step | RS-08 |
| prompt | prompts/rs/08-ai-action-level-classify.prompt.md |
| skill | skills/rs/SK-AI-ACTION-LEVEL-CLASSIFY.md |
| owning_pra | PRA-06-BLUEPRINT-QUESTIONER |

## Selected AI Action Level

| field | value |
|---|---|
| selected_level | `<value-from-catalogs/review/ai-action-level-catalog.yaml#AAL-L3>` |
| confidence | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-MEDIUM>` |
| selected_at | [ISO 8601 UTC timestamp recorded at run time] |

## Supporting Evidence

- `04-components.md#CMP-05` — external AI Analysis Service participates in F4 model call.
- `05-flows.md#F4` — `IT-MODEL-CALL` interaction with `SA1` service authentication; cross-internet to external SaaS.
- `05-flows.md#F8` — Jira/Confluence draft handoff is `formatted_only`; no `executed_by_operator` claim.
- `08-internal-review-table.md#RT-04`, `#RT-08` — model-call row and tool-call row both present in the chain.
- `cloud-triage-notes.md` § 3 — HITL reviewer approval gates external action; AI assists drafting.
- `review-transcript.md` § 7 — confirmation that AAL-L3 is the agreed disposition.

## Unknowns

- MF-03 (`09-missing-facts.md`) — data-class scope on F4 request body; affects whether AAL needs to be revisited if C5 / C5* tokens were present (they are not in this sample).
- MF-04 (`09-missing-facts.md`) — AZ scope at CMP-05; affects whether the post-model action is bounded.

## Human Review Gate Status

`<value-from-catalogs/review/review-status-catalog.yaml#RS-AWAITING-HUMAN-REVIEW>`

## Stop Conditions Recorded

None at this step. The AI Action Level is recorded with medium confidence reflecting open MF-03 / MF-04.
