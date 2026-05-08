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

The DFD chain extracted **8 boundaries** (plus the embedded `LEGEND` subgraph), **14 components**, **14 flows**, **10 resolved annotations**, **10 boundary crossings**, and **10 control-signal rows** from `samples/sample-001-dfd-crop/inputs/dfd-crop.png` and the supporting legend / triage / transcript / intake files. Every visible flow tuple conforms to the 4-token grammar `<flow name> / <C#>,<T#>,<IA#|SA#|CA#>,<AZ#|AZ?>`. Every Data subnet store carries the 3-token storage tuple `<class> • <R#> • <Enc|Tok|Mask|Clr|Unknown>`. Overall extraction confidence is high on visible structure (boundaries, components, internal flows, internal annotations, transit / at-rest markers, the security-stack diamond at Cloud Armor / WAF, the explicit `AZ?` authorization-unknown sentinel on every flow) and medium on (a) the cross-internet model-call leg (F9 / F10) where the redaction posture of the AI Analysis Connector drives MF-03; (b) the Atlassian formatted_only handoff (BC-10); and (c) the sample-specific `R1` replication-region marker. No marker is asserted as proof. The `S1`, `Enc`, and `R1` markers are recorded as signals only per the global proof-vs-signal rule. Authorization is explicitly recorded as `AZ?` (resolves to `AZ-UNKNOWN`) on every visible flow per the founder rule that authentication never implies authorization.

## Residual Gaps

- F9 / F10 redaction posture — does the AI Analysis Connector redact `C4` review-IP before transmission to the External AI Model Endpoint? Drives MF-03 (`09-missing-facts.md`).
- AZ scope on every `IA#`/`SA#`-bearing flow — `AZ-UNKNOWN` until MF-04 resolves.
- Approved-stack scope at CMP-10 Cloud Armor / WAF — open until MF-01 resolves.
- KMS / key rotation / scope on the five Data subnet stores (CMP-04, CMP-06, CMP-07, CMP-13, CMP-14) — open until MF-02 resolves.
- `R1` replication-region marker — sample-specific raw token; cross-region replication, multi-region failover, and regional residency configuration are not asserted.

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
