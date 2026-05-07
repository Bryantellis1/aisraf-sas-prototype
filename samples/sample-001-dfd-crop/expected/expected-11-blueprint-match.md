---
expected_baseline_id: EXP-RS-11-BLUEPRINT-MATCH
sample_id: sample-001-dfd-crop
mirrors_template: templates/output/output-11-blueprint-match-template.md
prompt: prompts/rs/09-blueprint-match.prompt.md
skill: skills/rs/SK-REVIEW-BLUEPRINT-MATCH.md
owning_pra: PRA-06-BLUEPRINT-QUESTIONER
adapter: .agents/aisraf-blueprint-questioner.agent.md
target_run_output: "{{output_root}}/11-blueprint-match.md"
expected_outcome: PASS_READY_FOR_REVIEW
scoring_basis: template-aligned qualitative baseline; numeric scoring deferred to Build Package 11 run execution
package_version: v0.1.2
---

# Blueprint Match — sample-001-dfd-crop

| field | value |
|---|---|
| run_id | `{{run_id}}` |
| sample_id | sample-001-dfd-crop |
| mode | `{{mode}}` |
| output_root | `{{output_root}}` |
| step | RS-09 |
| prompt | prompts/rs/09-blueprint-match.prompt.md |
| skill | skills/rs/SK-REVIEW-BLUEPRINT-MATCH.md |
| owning_pra | PRA-06-BLUEPRINT-QUESTIONER |
| match_state_model | matched / candidate / no_match / unknown (from blueprints/blueprint-registry.yaml#blueprint_match_states) |

## Candidate Blueprint

The sample produces four blueprint dispositions. The primary `candidate_blueprint_id` is recorded first.

| field | value |
|---|---|
| candidate_blueprint_id | `<value-from-blueprints/blueprint-registry.yaml#blueprint_id>`: `BP-AI-SAAS-INTEGRATION` |
| category | `cloud-patterns` |
| confidence | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` |

Additional dispositions:

| candidate_blueprint_id | category | confidence |
|---|---|---|
| `BP-MODEL-ENDPOINT-CALL` | platform-independent | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-MEDIUM>` |
| `BP-HITL-APPROVAL` | platform-independent | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` |
| `BP-API-WRITEBACK` | platform-independent | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-MEDIUM>` |

## Match State

| blueprint_id | match_state | reviewer | timestamp |
|---|---|---|---|
| BP-AI-SAAS-INTEGRATION | `matched` | `[copy from runs/{{run_id}}/run-profile.yaml#reviewer_name]` | [ISO 8601 UTC timestamp recorded at run time] |
| BP-MODEL-ENDPOINT-CALL | `candidate` | `[copy from runs/{{run_id}}/run-profile.yaml#reviewer_name]` | [ISO 8601 UTC timestamp recorded at run time] |
| BP-HITL-APPROVAL | `matched` | `[copy from runs/{{run_id}}/run-profile.yaml#reviewer_name]` | [ISO 8601 UTC timestamp recorded at run time] |
| BP-API-WRITEBACK | `candidate` | `[copy from runs/{{run_id}}/run-profile.yaml#reviewer_name]` | [ISO 8601 UTC timestamp recorded at run time] |

## Supporting Catalog Evidence

| condition_id | catalog_id_referenced | catalog_value_observed | status_for_match |
|---|---|---|---|
| BP-AI-SAAS-INTEGRATION-MATCH-* | `interaction-type-catalog` | `IT-MODEL-CALL` (F4) | met |
| BP-AI-SAAS-INTEGRATION-MATCH-* | `boundary-crossing-rule-catalog` | `BC-MODEL-ENDPOINT-CROSSING`; `BC-INTERNET-EXPOSURE` (BC-02) | met |
| BP-AI-SAAS-INTEGRATION-MATCH-* | `trust-zone-catalog` | `TZ-THIRD-PARTY-SERVICE` (BND-02 outside) | met |
| BP-MODEL-ENDPOINT-CALL-MATCH-01 | `interaction-type-catalog` | `IT-MODEL-CALL` (F4) | met (but provider is external SaaS — see no-match-02 below) |
| BP-MODEL-ENDPOINT-CALL-NO-MATCH-02 | `boundary-crossing-rule-catalog` | `BC-MODEL-ENDPOINT-CROSSING` to external SaaS | unmet for primary; downgrades to `candidate` |
| BP-HITL-APPROVAL-MATCH-* | `interaction-type-catalog` | `IT-HITL-APPROVAL` evidence in `cloud-triage-notes.md` § 3, `review-transcript.md` § 7 | met |
| BP-API-WRITEBACK-CANDIDATE-* | `interaction-type-catalog` | `IT-TOOL-CALL` (F8 to CMP-08, `formatted_only`) | unknown — no executed write-back |

## Material Missing Facts

Cross-references to `09-missing-facts.md`:

- MF-01 → BP-MODEL-ENDPOINT-CALL#BP-MODEL-ENDPOINT-CALL-MMF-04 (control-gate scoping at the gateway).
- MF-03 → BP-MODEL-ENDPOINT-CALL#BP-MODEL-ENDPOINT-CALL-MMF-03 and BP-AI-SAAS-INTEGRATION#BP-AI-SAAS-INTEGRATION-MMF-02.
- MF-04 → BP-AI-SAAS-INTEGRATION#BP-AI-SAAS-INTEGRATION-MMF-03 and BP-MODEL-ENDPOINT-CALL#BP-MODEL-ENDPOINT-CALL-MMF-01.
- MF-02 → BP-API-WRITEBACK#BP-API-WRITEBACK-MMF-03.

## Human Review Gate Status

`<value-from-catalogs/review/review-status-catalog.yaml#RS-AWAITING-HUMAN-REVIEW>`

## Stop Conditions Recorded

None at this step. No new BP-* identifiers introduced. No new controlled values introduced. No approval claim from blueprint match.
