---
expected_baseline_id: EXP-DFD-07-CONTROL-SIGNALS
sample_id: sample-001-dfd-crop
mirrors_template: templates/output/output-dfd-07-control-signals-template.md
prompt: prompts/dfd/08-control-signal-detect.prompt.md
skill: skills/dfd/SK-DFD-07-CONTROL-SIGNAL-DETECT.md
owning_pra: PRA-03-DFD-EXTRACTOR
adapter: .agents/aisraf-dfd-extractor.agent.md
target_run_output: "{{output_root}}/dfd/07-control-signals.md"
expected_outcome: PASS_READY_FOR_REVIEW
scoring_basis: template-aligned qualitative baseline; numeric scoring deferred to Build Package 11 run execution
package_version: v0.1.2
---

# DFD Control Signals — sample-001-dfd-crop

| field | value |
|---|---|
| run_id | `{{run_id}}` |
| sample_id | sample-001-dfd-crop |
| mode | `{{mode}}` |
| output_root | `{{output_root}}` |
| dfd_step | DFD-07 |
| prompt | prompts/dfd/08-control-signal-detect.prompt.md |
| skill | skills/dfd/SK-DFD-07-CONTROL-SIGNAL-DETECT.md |
| owning_pra | PRA-03-DFD-EXTRACTOR |
| global_rule | catalogs/security-stacks/proof-vs-signal-rule-catalog.yaml |

## Control Signal Rows

| signal_id | component_or_flow_referenced | signal_kind | signal_value | proof_or_signal | source_location | confidence | notes |
|---|---|---|---|---|---|---|---|
| CS-01 | CMP-10 Cloud Armor / WAF | `<value-from-catalogs/security-stacks/security-stack-marker-catalog.yaml#SSM-STACK-DIAMOND>` | `S1` | `<value-from-catalogs/security-stacks/control-signal-catalog.yaml#CS-VISIBLE>` (signal — `catalogs/security-stacks/proof-vs-signal-rule-catalog.yaml#SR-DIAMOND-NOT-APPROVED-STACK`) | `dfd-crop.png` Cloud Armor / WAF diamond | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Edge security-stack diamond. Drives MF-01. |
| CS-02 | CMP-03 API Gateway | `<value-from-catalogs/security-stacks/security-stack-marker-catalog.yaml#SSM-GATEWAY-OR-POLICY-CHECKPOINT>` | gateway label | `<value-from-catalogs/security-stacks/control-signal-catalog.yaml#CS-VISIBLE>` (signal — `catalogs/security-stacks/proof-vs-signal-rule-catalog.yaml#SR-GATEWAY-NOT-ENFORCEMENT`) | `dfd-crop.png` API Gateway | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Checkpoint signal only; enforcement is unknown. |
| CS-03 | CMP-04 Review Metadata Cloud SQL | `<value-from-catalogs/security-stacks/control-signal-catalog.yaml#CS-VISIBLE>` | `Enc` (at-rest marker on `C4 • R1 • Enc` tuple) | signal (`catalogs/security-stacks/proof-vs-signal-rule-catalog.yaml#SR-MARKER-NOT-PROOF`) | `dfd-crop.png` Review Metadata Cloud SQL store label | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | At-rest marker; KMS / scope unknown — drives MF-02. |
| CS-04 | CMP-06 Policy Reference Store | `<value-from-catalogs/security-stacks/control-signal-catalog.yaml#CS-VISIBLE>` | `Enc` (at-rest marker on `C2 • R1 • Enc` tuple) | signal (`catalogs/security-stacks/proof-vs-signal-rule-catalog.yaml#SR-MARKER-NOT-PROOF`) | `dfd-crop.png` Policy Reference Store store label | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | At-rest marker only. |
| CS-05 | CMP-07 Findings Store | `<value-from-catalogs/security-stacks/control-signal-catalog.yaml#CS-VISIBLE>` | `Enc` (at-rest marker on `C4 • R1 • Enc` tuple) | signal (`catalogs/security-stacks/proof-vs-signal-rule-catalog.yaml#SR-MARKER-NOT-PROOF`) | `dfd-crop.png` Findings Store store label | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | At-rest marker only. |
| CS-06 | CMP-13 Review Artifact Bucket | `<value-from-catalogs/security-stacks/control-signal-catalog.yaml#CS-VISIBLE>` | `Enc` (at-rest marker on `C4 • R1 • Enc` tuple) | signal (`catalogs/security-stacks/proof-vs-signal-rule-catalog.yaml#SR-MARKER-NOT-PROOF`) | `dfd-crop.png` Review Artifact Bucket store label | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | At-rest marker only. |
| CS-07 | CMP-14 Audit Log Store | `<value-from-catalogs/security-stacks/control-signal-catalog.yaml#CS-VISIBLE>` | `Enc` (at-rest marker on `C4 • R1 • Enc` tuple) | signal (`catalogs/security-stacks/proof-vs-signal-rule-catalog.yaml#SR-MARKER-NOT-PROOF`) | `dfd-crop.png` Audit Log Store store label | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | At-rest marker only. |
| CS-08 | every flow F1..F14 | `<value-from-catalogs/security-stacks/control-signal-catalog.yaml#CS-VISIBLE>` | `T1` (transit marker) | signal (`catalogs/security-stacks/proof-vs-signal-rule-catalog.yaml#SR-MARKER-NOT-PROOF`) | `dfd-crop.png` every visible flow tuple | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Transit marker visible on every flow. |
| CS-09 | every flow F1..F14 (every flow carrying `IA#` or `SA#`) | `<value-from-catalogs/security-stacks/control-signal-catalog.yaml#CS-VISIBLE>` | `AZ?` (explicit authorization-unknown sentinel) | signal (`catalogs/security-stacks/proof-vs-signal-rule-catalog.yaml#SR-AUTHN-NOT-AUTHZ`; `catalogs/identity-access/authorization-catalog.yaml#AZ-UNKNOWN`) | `dfd-crop.png` every visible flow tuple's 4th position; embedded LEGEND panel | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Explicit authorization-unknown sentinel; required by the 4-token flow-grammar standard. Authorization is never silently dropped; authentication never implies authorization. Drives MF-04. |
| CS-10 | CMP-04 / CMP-06 / CMP-07 / CMP-13 / CMP-14 | `<value-from-catalogs/security-stacks/control-signal-catalog.yaml#CS-VISIBLE>` | `R1` (replication marker on each Data subnet store tuple) | signal (legend-anchored; sample-specific raw token recorded with `CL-MEDIUM` per dfd-legend-excerpt.md §3) | `dfd-crop.png` every Data subnet store label | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-MEDIUM>` | Single-region / regional managed-resource marker; not cross-region replication proof. |

## Unknowns

| unknown_id | concern | catalog_reference_checked |
|---|---|---|
| UCS-01 | Approved-stack scope at CMP-10 Cloud Armor / WAF | `catalogs/security-stacks/security-stack-marker-catalog.yaml`; `catalogs/security-stacks/proof-vs-signal-rule-catalog.yaml#SR-DIAMOND-NOT-APPROVED-STACK` |
| UCS-02 | KMS / key rotation / scope on the five Data subnet stores | `catalogs/data-protection/at-rest-protection-catalog.yaml` |
| UCS-03 | AZ scope at CMP-05 External AI Model Endpoint and on every internal `SA5` hop | `catalogs/identity-access/authorization-catalog.yaml` |

## Stop Conditions Recorded

None at this step. No marker is asserted as proof.
