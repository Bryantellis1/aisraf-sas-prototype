---
expected_baseline_id: EXP-DFD-09-EXTRACTION-SUMMARY
sample_id: sample-001-dfd-crop
mirrors_template: templates/output/output-dfd-09-extraction-summary-template.md
prompt: prompts/dfd/10-dfd-extraction-summarize.prompt.md
skill: skills/dfd/SK-DFD-09-EXTRACTION-SUMMARIZE.md
owning_pra: PRA-03-DFD-EXTRACTOR
adapter: .agents/aisraf-dfd-extractor.agent.md
target_run_output: "{{output_root}}/dfd/09-extraction-summary.md"
expected_outcome: PASS_READY_FOR_REVIEW
scoring_basis: template-aligned qualitative baseline; numeric scoring deferred to Build Package 11 run execution
package_version: v0.1.2
---

# DFD Extraction Summary — sample-001-dfd-crop

| field | value |
|---|---|
| run_id | `{{run_id}}` |
| sample_id | sample-001-dfd-crop |
| mode | `{{mode}}` |
| output_root | `{{output_root}}` |
| dfd_step | DFD-09 |
| prompt | prompts/dfd/10-dfd-extraction-summarize.prompt.md |
| skill | skills/dfd/SK-DFD-09-EXTRACTION-SUMMARIZE.md |
| owning_pra | PRA-03-DFD-EXTRACTOR |
| disclaimer | DFD extraction summary; not an accuracy score. |

## Extraction State Summary

The DFD chain extracted **4 boundaries**, **8 components**, **8 flows**, **10 resolved annotations**, **7 boundary crossings**, and **5 control-signal rows** from `samples/sample-001-dfd-crop/inputs/dfd-crop.png` and the supporting legend / triage / transcript / intake files. Overall extraction confidence is high on visible structure (boundaries, components, internal flows, internal annotations) and medium-to-low on the cross-internet model-call leg (F4 / F5) where data-class scope and authorization scope are honestly `unknown`. No marker is asserted as proof. The `S1` and `E1` markers are recorded as signals only per the global proof-vs-signal rule.

## Residual Gaps

- F4 request payload data class — `DC-UNKNOWN` until MF-03 resolves (`09-missing-facts.md`).
- F5 response payload data class — same as MF-03.
- F4 transit encryption — recorded as `TP-UNKNOWN` / `CS-MISSING`.
- AZ scope at CMP-05 — `AZ-UNKNOWN` until MF-04 resolves.
- Approved-stack scope at CMP-03 — open until MF-01 resolves.
- KMS / key rotation / scope on CMP-04 — open until MF-02 resolves.

## Cross-Reference to RS Outputs

The DFD-side outputs feed the RS-side outputs as follows:

- `dfd/02-boundary-catalog.md` → `06-boundaries.md` (Boundary Table).
- `dfd/03-component-catalog.md` → `04-components.md`.
- `dfd/04-flow-inventory.md` → `05-flows.md`.
- `dfd/05-annotation-resolution.md` → `03-legend-normalization.md`; `08-internal-review-table.md` data-class column.
- `dfd/06-boundary-crossings.md` → `06-boundaries.md` Boundary Crossing Table; `08-internal-review-table.md` `crossing_id_referenced` column.
- `dfd/07-control-signals.md` → `07-security-stack-assessment.md`.

## Stop Conditions Recorded

None at this step. No accuracy score is asserted; the qualitative score lives only in `17-accuracy-score.md` and only when `SK-ACCURACY-SCORE` runs under the configured run profile.
