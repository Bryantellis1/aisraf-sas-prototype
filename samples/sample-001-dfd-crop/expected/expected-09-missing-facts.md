---
expected_baseline_id: EXP-RS-09-MISSING-FACTS
sample_id: sample-001-dfd-crop
mirrors_template: templates/output/output-09-missing-facts-template.md
prompt: prompts/rs/07-missing-fact-question-generate.prompt.md
skill: skills/rs/SK-MISSING-FACT-IDENTIFY.md
owning_pra: PRA-06-BLUEPRINT-QUESTIONER
adapter: .agents/aisraf-blueprint-questioner.agent.md
target_run_output: "{{output_root}}/09-missing-facts.md"
expected_outcome: PASS_READY_FOR_REVIEW
scoring_basis: template-aligned qualitative baseline; numeric scoring deferred to Build Package 11 run execution
package_version: v0.1.2
---

# Missing Material Facts — sample-001-dfd-crop

| field | value |
|---|---|
| run_id | `{{run_id}}` |
| sample_id | sample-001-dfd-crop |
| mode | `{{mode}}` |
| output_root | `{{output_root}}` |
| step | RS-07 |
| prompt | prompts/rs/07-missing-fact-question-generate.prompt.md |
| skill | skills/rs/SK-MISSING-FACT-IDENTIFY.md |
| owning_pra | PRA-06-BLUEPRINT-QUESTIONER |

## Missing Material Fact Rows

| gap_id | concern | catalog_reference_for_required_value | blueprint_material_missing_fact_referenced | source_artifacts_searched | confidence | notes |
|---|---|---|---|---|---|---|
| MF-01 | Approved-stack inventory at CMP-10 Cloud Armor / WAF (`S1 ◇` is signal, not proof). | `catalogs/security-stacks/security-stack-marker-catalog.yaml`; `catalogs/security-stacks/proof-vs-signal-rule-catalog.yaml#SR-DIAMOND-NOT-APPROVED-STACK` | BP-MODEL-ENDPOINT-CALL#BP-MODEL-ENDPOINT-CALL-MMF-04 (control-gate scoping); cross-references the proof-vs-signal global rule | `dfd-crop.png`; `dfd-legend-excerpt.md`; `cloud-triage-notes.md`; `review-transcript.md` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Edge security-stack diamond at the GCP edge; drives BP-AI-SAAS-INTEGRATION control-gate scoping. |
| MF-02 | At-rest encryption proof on CMP-04 / CMP-06 / CMP-07 / CMP-13 / CMP-14 (KMS, key rotation, scope). The visible `Enc` marker is signal only. | `catalogs/data-protection/at-rest-protection-catalog.yaml`; `catalogs/security-stacks/proof-vs-signal-rule-catalog.yaml#SR-MARKER-NOT-PROOF` | BP-API-WRITEBACK#BP-API-WRITEBACK-MMF-03 | `dfd-crop.png` Data subnet store labels; `cloud-triage-notes.md`; `review-transcript.md` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | All five Data subnet stores carry `Enc`; KMS / key-rotation / scope unknown — routes to a separate validation ticket. |
| MF-03 | F9 / F10 redaction posture at CMP-12 AI Analysis Connector. The visible flow tuple asserts `C4` on the model-call request body and response, but whether the connector redacts before transmission is unknown. | `catalogs/data-protection/data-class-catalog.yaml` | BP-MODEL-ENDPOINT-CALL#BP-MODEL-ENDPOINT-CALL-MMF-03; BP-AI-SAAS-INTEGRATION#BP-AI-SAAS-INTEGRATION-MMF-02 | `dfd-crop.png` F9 / F10; `cloud-triage-notes.md`; `review-transcript.md` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Material because external SaaS receives possibly C4 review IP; redaction posture is not visibly recorded. |
| MF-04 | Authorization scope on every `IA#`/`SA#`-bearing flow. No `AZ#` token appears on any visible flow tuple per the founder rule that authentication never implies authorization. | `catalogs/identity-access/authorization-catalog.yaml`; `catalogs/security-stacks/proof-vs-signal-rule-catalog.yaml#SR-AUTHN-NOT-AUTHZ` | BP-AI-SAAS-INTEGRATION#BP-AI-SAAS-INTEGRATION-MMF-03; BP-MODEL-ENDPOINT-CALL#BP-MODEL-ENDPOINT-CALL-MMF-01 | `dfd-crop.png` every flow tuple; `cloud-triage-notes.md`; `review-transcript.md` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | AuthN visible on every flow (`IA1`, `SA5`, `SA7`); AZ scope is separately required and recorded as `AZ-UNKNOWN` until evidence arrives. |

## Cross-Reference to Blueprint material_missing_facts

| blueprint_id | material_missing_fact_referenced | exists_in_blueprint_registry |
|---|---|---|
| BP-MODEL-ENDPOINT-CALL | BP-MODEL-ENDPOINT-CALL-MMF-01 | yes |
| BP-MODEL-ENDPOINT-CALL | BP-MODEL-ENDPOINT-CALL-MMF-03 | yes |
| BP-MODEL-ENDPOINT-CALL | BP-MODEL-ENDPOINT-CALL-MMF-04 | yes |
| BP-AI-SAAS-INTEGRATION | BP-AI-SAAS-INTEGRATION-MMF-02 | yes |
| BP-AI-SAAS-INTEGRATION | BP-AI-SAAS-INTEGRATION-MMF-03 | yes |
| BP-API-WRITEBACK | BP-API-WRITEBACK-MMF-03 | yes |

## Stop Conditions Recorded

None at this step. No silent unknowns. No invented BP-* identifiers. No invented material_missing_fact entries.
