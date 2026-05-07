# Scoring Rubric Checklist

Authored by: BUILD-AG-12-VALIDATION-R1.

Scope: confirms the internal consistency of the 160-point AISRAF accuracy scoring model used by `skills/rs/SK-ACCURACY-SCORE.md` and surfaced via `prompts/rs/13-accuracy-score.prompt.md`. This checklist does not invent point allocations, does not modify the skill or prompt registries, and does not produce a numeric score.

The 160-point band model and the named critical-miss list are sourced from existing sealed surfaces:

- `skills/skill-registry.yaml#critical_miss_refs` and the per-skill contracts under `skills/rs/SK-*.md`.
- `samples/sample-registry.yaml#critical_miss_categories` and the gold-standard sample reference under `samples/sample-001-dfd-crop/expected/expected-17-accuracy-score.md`.

## Identity

- Gate category: Cross-cutting framework / chain gate.
- Run order position: 3 (Chain gates).
- Owning skill (sealed): `skills/rs/SK-ACCURACY-SCORE.md`.
- Owning prompt (sealed): `prompts/rs/13-accuracy-score.prompt.md`.
- Activation: only when `runs/<run_id>/run-profile.yaml#scoring_enabled: true` and `expected_baseline_required: true` and `expected_root` is non-empty and populated.

## Scope

- Confirms the band thresholds (PASS ≥ 135, PARTIAL_WITH_ISSUES 110–134, FAIL < 110) are referenced consistently across the sealed sources.
- Confirms per-skill point allocation references resolve to existing skill identifiers and existing sample-registry critical-miss categories.
- Confirms the named critical-miss list is internally consistent (each entry resolves to a skill and a sample category).
- Confirms no BP12 file invents a point allocation, lowers a band threshold, or fabricates a numeric score.

## Inputs

- `skills/skill-registry.yaml`.
- `skills/rs/SK-ACCURACY-SCORE.md`.
- `samples/sample-registry.yaml`.
- `samples/sample-001-dfd-crop/expected/expected-17-accuracy-score.md`.
- `prompts/rs/13-accuracy-score.prompt.md`.

## Gates

| # | Gate | Falsifiable Check | Verdict |
|---|---|---|---|
| 1 | Band thresholds defined | `skills/rs/SK-ACCURACY-SCORE.md` contains the literals `PASS >= 135`, `PARTIAL_WITH_ISSUES 110-134` (or equivalent unambiguous phrasing), and `FAIL < 110`. | PASS |
| 2 | Total points fixed at 160 | `skills/rs/SK-ACCURACY-SCORE.md` records a total of 160 points; `samples/sample-001-dfd-crop/expected/expected-17-accuracy-score.md` references the same total. | PASS |
| 3 | Critical-miss refs resolve | Every entry in `skills/skill-registry.yaml#critical_miss_refs` (where present) resolves to an existing `skills/rs/SK-*.md` or `skills/dfd/SK-DFD-*.md` contract. | PASS |
| 4 | Sample critical-miss categories resolve | Every entry in `samples/sample-registry.yaml#critical_miss_categories` (where present) resolves to a category referenced in `samples/sample-001-dfd-crop/expected/expected-17-accuracy-score.md`. | PASS |
| 5 | Per-skill allocation source-of-truth named | The point allocation per skill is sourced from sealed registries / contracts; this BP12 checklist does not record numeric per-skill allocations. If allocations are not enumerated in registries, the gap is recorded as PARTIAL_WITH_ISSUES with `skills/rs/SK-ACCURACY-SCORE.md` named as source-of-truth owner. | PASS |
| 6 | Qualitative verdict pinned for sample-001 | `samples/sample-001-dfd-crop/expected/expected-17-accuracy-score.md` carries `PASS_READY_FOR_REVIEW` (founder decision Q5 of Build Package 10). The v0.01 reference 151/160 is recorded as `legacy_reference_score` only and is not asserted as v0.1.2 truth. | PASS |
| 7 | No score lowering | No file under `samples/`, `runs/RUN-001/`, or `validation/` lowers `expected_score_threshold` to force a pass. | PASS |
| 8 | No BP12 fabrication | No file produced by Build Package 12 records a numeric accuracy score, a per-skill point allocation, or a band threshold that contradicts the sealed sources. | PASS |
| 9 | Activation gate | Numeric scoring activates only when `scoring_enabled: true`, `expected_baseline_required: true`, and `expected_root` is non-empty / populated; otherwise the prompt is skipped (this is a read-only consistency check on `prompts/rs/13-accuracy-score.prompt.md`). | PASS |
| 10 | Scoring writes only under output_root | `skills/rs/SK-ACCURACY-SCORE.md` and `prompts/rs/13-accuracy-score.prompt.md` declare write paths only under `{{output_root}}`; no scoring artefact may edit baselines under `{{expected_root}}`. | PASS |

## Acceptance Verdict

- **PASS** when every gate above reads PASS.
- **PARTIAL_WITH_ISSUES** when gate 5 records that registry fields are insufficient for full per-skill allocation enumeration; this is acceptable provided the gap is named and the source-of-truth owner is identified, and no other gate fails.
- **FAIL** when any gate other than 5 reads FAIL, or when any BP12 file lowers a threshold or fabricates a score.

## Stop Conditions

- A BP12 checklist invents a per-skill point allocation that contradicts sealed sources.
- A BP12 checklist lowers PASS / PARTIAL_WITH_ISSUES / FAIL band thresholds.
- A BP12 checklist records a numeric score for `runs/RUN-001/` (no chain executed; no numeric score exists).

## Tool References

- `tools/Test-AisrafPackage.ps1` — does not compute scoring; this gate is read-only verification.
- `tools/Test-AisrafRunProfile.ps1` — confirms `scoring_enabled` and `expected_baseline_required` posture in `runs/RUN-001/run-profile.yaml`.

## Out-of-Scope

- Producing a numeric accuracy score for `runs/RUN-001/` (chain not executed).
- Modifying any sealed registry, skill contract, prompt card, or expected baseline.
- Inventing new critical-miss categories, point allocations, or band thresholds.
