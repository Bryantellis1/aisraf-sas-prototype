# Run Comparison And Scoring Checklist

Authored by: BUILD-AG-11-RUNS-R1.

Scope: defines the comparison and scoring procedure for governed runs in AISRAF SAS Prototype v0.1.2. Comparison is between actual run outputs under `output_root` and expected baselines under `expected_root`. Numeric accuracy scoring is owned by `prompts/rs/13-accuracy-score.prompt.md` / `skills/rs/SK-ACCURACY-SCORE.md` and is gated on `scoring_enabled: true`, `expected_baseline_required: true`, and a non-empty populated `expected_root`.

Build Package 11 establishes this procedure. It does not execute the chain.

## 1. Pre-Comparison Gate

Before any comparison runs, verify on the run profile:

- `scoring_enabled: true`
- `expected_baseline_required: true`
- `expected_root` is non-empty and resolves to an existing folder
- `expected_root` contains the expected baseline files for the named `sample_id`
- `sensitive_data_confirmed_redacted: true`

For RUN-001 the expected gate values are `expected_root: samples/sample-001-dfd-crop/expected`, `sample_id: sample-001-dfd-crop`, and `scoring_enabled: true`.

## 2. Read-Only Discipline

- Files under `expected_root` are **read-only** during comparison. The comparison procedure must not edit, append to, rename, delete, or move any file under `samples/<sample_id>/expected/`.
- Files under `samples/<sample_id>/inputs/` are **read-only** during comparison. The run uses `input_root` (`runs/<run_id>/inputs/`), which holds byte-copies of those inputs for self-containment.
- The run profile, run log, and run outputs live under `output_root` only. Comparison writes (the accuracy-score artefact) are produced by `skills/rs/SK-ACCURACY-SCORE.md` under `output_root` only.

## 3. Per-Output Comparison Mapping

Each actual output under `output_root` is compared against the matching expected baseline under `expected_root`:

### RS lane (17 pairs)

| actual output | expected baseline |
|---|---|
| `runs/<run_id>/01-input-inventory.md` | `samples/<sample_id>/expected/expected-01-input-inventory.md` |
| `runs/<run_id>/02-visible-dfd-objects.md` | `samples/<sample_id>/expected/expected-02-visible-dfd-objects.md` |
| `runs/<run_id>/03-legend-normalization.md` | `samples/<sample_id>/expected/expected-03-legend-normalization.md` |
| `runs/<run_id>/04-components.md` | `samples/<sample_id>/expected/expected-04-components.md` |
| `runs/<run_id>/05-flows.md` | `samples/<sample_id>/expected/expected-05-flows.md` |
| `runs/<run_id>/06-boundaries.md` | `samples/<sample_id>/expected/expected-06-boundaries.md` |
| `runs/<run_id>/07-security-stack-assessment.md` | `samples/<sample_id>/expected/expected-07-security-stack-assessment.md` |
| `runs/<run_id>/08-internal-review-table.md` | `samples/<sample_id>/expected/expected-08-internal-review-table.md` |
| `runs/<run_id>/09-missing-facts.md` | `samples/<sample_id>/expected/expected-09-missing-facts.md` |
| `runs/<run_id>/10-ai-action-level.md` | `samples/<sample_id>/expected/expected-10-ai-action-level.md` |
| `runs/<run_id>/11-blueprint-match.md` | `samples/<sample_id>/expected/expected-11-blueprint-match.md` |
| `runs/<run_id>/12-targeted-questions.md` | `samples/<sample_id>/expected/expected-12-targeted-questions.md` |
| `runs/<run_id>/13-findings.md` | `samples/<sample_id>/expected/expected-13-findings.md` |
| `runs/<run_id>/14-recommendations.md` | `samples/<sample_id>/expected/expected-14-recommendations.md` |
| `runs/<run_id>/15-handoff-pack.md` | `samples/<sample_id>/expected/expected-15-handoff-pack.md` |
| `runs/<run_id>/16-validation-notes.md` | `samples/<sample_id>/expected/expected-16-validation-notes.md` |
| `runs/<run_id>/17-accuracy-score.md` | `samples/<sample_id>/expected/expected-17-accuracy-score.md` |

### DFD lane (9 pairs)

| actual output | expected baseline |
|---|---|
| `runs/<run_id>/dfd/dfd-01-intake-quality-check.md` | `samples/<sample_id>/expected/expected-dfd-01-intake-quality-check.md` |
| `runs/<run_id>/dfd/dfd-02-boundary-catalog.md` | `samples/<sample_id>/expected/expected-dfd-02-boundary-catalog.md` |
| `runs/<run_id>/dfd/dfd-03-component-catalog.md` | `samples/<sample_id>/expected/expected-dfd-03-component-catalog.md` |
| `runs/<run_id>/dfd/dfd-04-flow-inventory.md` | `samples/<sample_id>/expected/expected-dfd-04-flow-inventory.md` |
| `runs/<run_id>/dfd/dfd-05-annotation-resolution.md` | `samples/<sample_id>/expected/expected-dfd-05-annotation-resolution.md` |
| `runs/<run_id>/dfd/dfd-06-boundary-crossings.md` | `samples/<sample_id>/expected/expected-dfd-06-boundary-crossings.md` |
| `runs/<run_id>/dfd/dfd-07-control-signals.md` | `samples/<sample_id>/expected/expected-dfd-07-control-signals.md` |
| `runs/<run_id>/dfd/dfd-08-confidence-score.md` | `samples/<sample_id>/expected/expected-dfd-08-confidence-score.md` |
| `runs/<run_id>/dfd/dfd-09-extraction-summary.md` | `samples/<sample_id>/expected/expected-dfd-09-extraction-summary.md` |

The run log entry (`runs/<run_id>/00-run-log.md`) has no expected baseline and is not scored against `expected_root`. It is a run artefact, not a chain output (Build Package 10 founder decision Q2). Build Package 12 may add governance checks for run-log shape.

## 4. Comparison Procedure

For each pair in §3:

1. **Existence check.** If the actual output is missing, the per-output verdict is `MISSING_OUTPUT`; the chain step that should produce it must be re-executed before scoring.
2. **Section coverage.** Confirm the actual output carries every required section listed in the matching `templates/output/output-NN-*-template.md#required_sections`. Missing sections degrade the per-output verdict.
3. **Catalog placeholder resolution.** All `<value-from-catalogs/...>` placeholders in the actual output must resolve to existing entries in `catalogs/catalog-registry.yaml#catalogs[]`. Unresolved placeholders degrade the per-output verdict.
4. **Blueprint identifier resolution.** All BP-* identifiers in the actual output must resolve to entries in `blueprints/blueprint-registry.yaml`. Unresolved identifiers degrade the per-output verdict.
5. **Run-profile placeholder resolution.** Only the seven approved run-profile placeholders may appear; other run-profile fields must be referenced descriptively as `[copy from runs/{{run_id}}/run-profile.yaml#field_name]`. Forbidden non-schema placeholders degrade the per-output verdict.
6. **Critical-miss screen.** Apply the critical-miss list from `samples/sample-001-dfd-crop/README.md` § 7 (and equivalent sections for future samples). Any critical miss in the actual output stops the run; the per-output verdict is `CRITICAL_MISS_FLAGGED`.
7. **Content alignment.** Compare structured fields against the expected baseline (component IDs, flow IDs, boundary crossings, blueprint dispositions, AAL value, finding categories, recommendation IDs, missing-fact IDs, validation-note IDs). Misalignment degrades the per-output verdict but does not necessarily fail the run unless a critical-miss line is crossed.
8. **Per-output verdict.** Record one of `PASS`, `PARTIAL`, `FAIL`, `MISSING_OUTPUT`, `CRITICAL_MISS_FLAGGED` per pair.

## 5. Run-Level Verdict

The run-level qualitative verdict is one of:

- `PASS_READY_FOR_REVIEW` — all 26 pairs PASS or PARTIAL with documented partials; no `CRITICAL_MISS_FLAGGED`. This is the verdict recorded in `samples/sample-001-dfd-crop/expected/expected-17-accuracy-score.md` (Build Package 10 founder decision Q5).
- `PARTIAL_NEEDS_REWORK` — one or more PARTIAL or FAIL pairs without a critical miss; reviewer to decide whether to re-run or accept partials.
- `FAIL_RUN_BLOCKED` — any `MISSING_OUTPUT` or `CRITICAL_MISS_FLAGGED` pair stops the run.

Numeric scoring activates only when `prompts/rs/13-accuracy-score.prompt.md` / `skills/rs/SK-ACCURACY-SCORE.md` runs successfully. The v0.01 reference score `151/160` is recorded as `legacy_reference_score` only and is not asserted as v0.1.2 truth (Build Package 10 founder decision Q5; `validation/no-drift-rules.md`). No baseline may lower an `expected_score_threshold` to force a pass.

## 6. Where Comparison Output Lands

- Per-step verdicts and observations: in the **Step Entries** section of `runs/<run_id>/00-run-log.md`, one row per scored step (per `templates/run/run-log-entry-row-template.md`).
- Run-level qualitative verdict: in `runs/<run_id>/17-accuracy-score.md`, mirroring `templates/output/output-17-accuracy-score-template.md`.
- Numeric score (when activated): inside `runs/<run_id>/17-accuracy-score.md` under the Verdict section, produced by `skills/rs/SK-ACCURACY-SCORE.md` only.

No comparison output may write outside `output_root`. No comparison output may modify `expected_root`.

## 7. Forbidden Comparison Behaviours

- Editing, appending to, renaming, or deleting any file under `expected_root`.
- Producing a numeric score outside `skills/rs/SK-ACCURACY-SCORE.md`.
- Lowering an `expected_score_threshold` to force a pass.
- Suppressing a `CRITICAL_MISS_FLAGGED` row to achieve a `PASS_READY_FOR_REVIEW` run-level verdict.
- Claiming Jira post-back / Confluence publication / Rovo / MCP execution as part of comparison without `postback_execution_status: executed_by_operator` and a matching post-back row in `00-run-log.md`.
- Inventing component / flow / boundary / blueprint / catalog identifiers in the actual output that do not exist in the upstream registries.
- Reading from the old reference workspace (`D:/E-Way 2/aisraf-sas-prototype-skill-chain-pack-v0.01`) during comparison.

## 8. Build Package 11 Posture

Build Package 11 records this comparison procedure as the run-evidence model. It does not execute comparison, does not score RUN-001, and does not produce `runs/RUN-001/17-accuracy-score.md`. Comparison runs only when the operator executes the Build Package 04 chain end-to-end against this fixture.
