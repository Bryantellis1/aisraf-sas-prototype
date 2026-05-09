# AI Action Level — RUN-001
| field | value |
|---|---|
| run_id | `RUN-001` |
| sample_id | sample-001-dfd-crop |
| mode | `folder_first_test` |
| output_root | `runs/RUN-001` |
| step | RS-08 |
| prompt | prompts/rs/08-ai-action-level-classify.prompt.md |
| skill | skills/rs/SK-AI-ACTION-LEVEL-CLASSIFY.md |
| owning_pra | PRA-06-BLUEPRINT-QUESTIONER |

## Selected AI Action Level

| field | value |
|---|---|
| selected_level | `<value-from-catalogs/review/ai-action-level-catalog.yaml#AAL-L3>` |
| confidence | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-MEDIUM>` |
| selected_at | 2026-05-08T23:57:48Z |

## Supporting Evidence

- `04-components.md#CMP-05` — External AI Model Endpoint participates in the F9 / F10 model prompt / response exchange.
- `05-flows.md#F9` — `IT-MODEL-CALL` interaction with `SA7` service authentication; cross-internet to external SaaS.
- `05-flows.md#F10` — inbound model response from the external SaaS endpoint; redaction / response-content posture drives MF-03.
- `05-flows.md#F14` — Jira/Confluence draft handoff is `formatted_only`; no `executed_by_operator` claim.
- `08-internal-review-table.md#RT-09`, `#RT-10`, `#RT-14` — model prompt / response rows and formatted-only tool-call row are present in the chain.
- `cloud-triage-notes.md` § 3 — HITL reviewer approval gates external action; AI assists drafting.
- `review-transcript.md` § 7 — confirmation that AAL-L3 is the agreed disposition.

## Unknowns

- MF-03 (`09-missing-facts.md`) — data-class / redaction posture on F9 / F10; affects whether AAL needs to be revisited if C5 / C5* tokens were present (they are not in this sample).
- MF-04 (`09-missing-facts.md`) — AZ scope at CMP-05 and on every IA# / SA#-bearing flow remains unknown unless visibly proven; affects whether the post-model action is bounded.

## Human Review Gate Status

`<value-from-catalogs/review/review-status-catalog.yaml#RS-AWAITING-HUMAN-REVIEW>`

## Stop Conditions Recorded

None at this step. The AI Action Level is recorded with medium confidence reflecting open MF-03 / MF-04.

