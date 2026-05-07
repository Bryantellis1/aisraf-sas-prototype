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
| CS-01 | CMP-03 Review API Gateway | `<value-from-catalogs/security-stacks/security-stack-marker-catalog.yaml#SSM-STACK-DIAMOND>` | `S1` | `<value-from-catalogs/security-stacks/control-signal-catalog.yaml#CS-VISIBLE>` (signal — `catalogs/security-stacks/proof-vs-signal-rule-catalog.yaml#SR-DIAMOND-NOT-APPROVED-STACK`) | `dfd-crop.png` CMP-03 | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Drives MF-01. |
| CS-02 | CMP-03 Review API Gateway | `<value-from-catalogs/security-stacks/security-stack-marker-catalog.yaml#SSM-GATEWAY-OR-POLICY-CHECKPOINT>` | gateway label | `<value-from-catalogs/security-stacks/control-signal-catalog.yaml#CS-VISIBLE>` (signal — `catalogs/security-stacks/proof-vs-signal-rule-catalog.yaml#SR-GATEWAY-NOT-ENFORCEMENT`) | `dfd-crop.png` CMP-03 | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Checkpoint signal only. |
| CS-03 | CMP-04 Review Metadata DB | `<value-from-catalogs/security-stacks/control-signal-catalog.yaml#CS-VISIBLE>` | `E1` (at-rest marker) | signal (`catalogs/security-stacks/proof-vs-signal-rule-catalog.yaml#SR-MARKER-NOT-PROOF`) | `dfd-crop.png` CMP-04 | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Drives MF-02. |
| CS-04 | F1 | `<value-from-catalogs/security-stacks/control-signal-catalog.yaml#CS-VISIBLE>` | `T1` (transit marker) | signal (`catalogs/security-stacks/proof-vs-signal-rule-catalog.yaml#SR-MARKER-NOT-PROOF`) | `dfd-crop.png` F1 | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Transit marker only. |
| CS-05 | F4 | `<value-from-catalogs/security-stacks/control-signal-catalog.yaml#CS-MISSING>` | (no transit marker visible) | signal (`catalogs/security-stacks/proof-vs-signal-rule-catalog.yaml#SR-MARKER-NOT-PROOF`) | `dfd-crop.png` F4 | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-MEDIUM>` | Recorded as missing transit marker; not asserted as plain text. |

## Unknowns

| unknown_id | concern | catalog_reference_checked |
|---|---|---|
| UCS-01 | F4 transit encryption | `catalogs/data-protection/transport-protection-catalog.yaml` |
| UCS-02 | Approved-stack scope at CMP-03 | `catalogs/security-stacks/security-stack-marker-catalog.yaml`; `catalogs/security-stacks/proof-vs-signal-rule-catalog.yaml#SR-DIAMOND-NOT-APPROVED-STACK` |

## Stop Conditions Recorded

None at this step. No marker is asserted as proof.
