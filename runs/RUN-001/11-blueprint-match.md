# Blueprint Match — RUN-001
| field | value |
|---|---|
| run_id | `RUN-001` |
| sample_id | sample-001-dfd-crop |
| mode | `folder_first_test` |
| output_root | `runs/RUN-001` |
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
| BP-AI-SAAS-INTEGRATION | `matched` | `SAS reviewer` | 2026-05-08T23:57:48Z |
| BP-MODEL-ENDPOINT-CALL | `candidate` | `SAS reviewer` | 2026-05-08T23:57:48Z |
| BP-HITL-APPROVAL | `matched` | `SAS reviewer` | 2026-05-08T23:57:48Z |
| BP-API-WRITEBACK | `candidate` | `SAS reviewer` | 2026-05-08T23:57:48Z |

## Supporting Catalog Evidence

| condition_id | catalog_id_referenced | catalog_value_observed | status_for_match |
|---|---|---|---|
| BP-AI-SAAS-INTEGRATION-MATCH-* | `interaction-type-catalog` | `IT-MODEL-CALL` (F9) | met |
| BP-AI-SAAS-INTEGRATION-MATCH-* | `boundary-crossing-rule-catalog` | `BC-MODEL-ENDPOINT-CROSSING`; `BC-INTERNET-EXPOSURE` (BC-05 outbound / BC-06 inbound) | met |
| BP-AI-SAAS-INTEGRATION-MATCH-* | `trust-zone-catalog` | `TZ-THIRD-PARTY-SERVICE` (BND-07 External AI SaaS Provider Zone) | met |
| BP-MODEL-ENDPOINT-CALL-MATCH-01 | `interaction-type-catalog` | `IT-MODEL-CALL` (F9) | met (but provider is external SaaS — see no-match-02 below) |
| BP-MODEL-ENDPOINT-CALL-NO-MATCH-02 | `boundary-crossing-rule-catalog` | `BC-MODEL-ENDPOINT-CROSSING` to external SaaS | unmet for primary; downgrades to `candidate` |
| BP-HITL-APPROVAL-MATCH-* | `interaction-type-catalog` | `IT-HITL-APPROVAL` evidence in `cloud-triage-notes.md` § 3, `review-transcript.md` § 7 | met |
| BP-API-WRITEBACK-CANDIDATE-* | `interaction-type-catalog` | `IT-TOOL-CALL` (F14 to CMP-08, `formatted_only`) | unknown — no executed write-back |

## Material Missing Facts

Cross-references to `09-missing-facts.md`:

- MF-01 → BP-MODEL-ENDPOINT-CALL#BP-MODEL-ENDPOINT-CALL-MMF-04 (control-gate scoping at CMP-10 Cloud Armor / WAF).
- MF-03 → BP-MODEL-ENDPOINT-CALL#BP-MODEL-ENDPOINT-CALL-MMF-03 and BP-AI-SAAS-INTEGRATION#BP-AI-SAAS-INTEGRATION-MMF-02.
- MF-04 → BP-AI-SAAS-INTEGRATION#BP-AI-SAAS-INTEGRATION-MMF-03 and BP-MODEL-ENDPOINT-CALL#BP-MODEL-ENDPOINT-CALL-MMF-01.
- MF-02 → BP-API-WRITEBACK#BP-API-WRITEBACK-MMF-03.

## Human Review Gate Status

`<value-from-catalogs/review/review-status-catalog.yaml#RS-AWAITING-HUMAN-REVIEW>`

## Stop Conditions Recorded

None at this step. No new BP-* identifiers introduced. No new controlled values introduced. No approval claim from blueprint match.

