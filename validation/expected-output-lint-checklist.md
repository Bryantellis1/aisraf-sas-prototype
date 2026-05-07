# Expected Output Lint Checklist

Authored by: BUILD-AG-12-VALIDATION-R1.

Scope: validates the 26 expected baselines under `samples/sample-001-dfd-crop/expected/` for filename pattern, presence, template mirroring, fact-grounding, controlled-vocabulary fidelity, unknown-handling discipline, and the new `BP12-SAMPLE-DFD-BLOCKER` defect-non-normalization gate.

This checklist does not modify any expected baseline. Where a baseline is found to silently "clean up" the defective input DFD, the row is FAILed and the FAIL is attributed to `BP12-SAMPLE-DFD-BLOCKER`. Cleanup of these baselines is **not** authorized in Build Package 12 — the carried-forward defect persists until a founder-approved Package 10A / 11A correction lands.

## Identity

- Gate category: Chain gate.
- Run order position: 3 (Chain gates).
- Owning agent (sealed): BP10 / BP10A.
- BP12 verdict authority: read-only lint of sealed expected baselines.

## Carried-Forward Blocker

`BP12-SAMPLE-DFD-BLOCKER` (severity HARD, owner founder) is cited in this checklist's gate set. The current sample DFD input mixes extraction IDs with visual architecture notation, uses BND-/CMP-/F-style labels as primary diagram language, has weak/incorrect boundary semantics, and does not consistently follow AISRAF flow-label grammar or data-store annotation rules. Expected baselines that normalize this defect into a "clean" output silently misrepresent the input quality and FAIL gate set §6 below.

## Scope

- 17 RS expected baselines: `expected-01-input-inventory.md` through `expected-17-accuracy-score.md`.
- 9 DFD expected baselines: `expected-dfd-01-intake-quality-check.md` through `expected-dfd-09-extraction-summary.md`.
- The 26 baselines collectively form the `expected_root` for `runs/RUN-001/` numeric-scoring activation.

## Inputs

- `samples/sample-001-dfd-crop/expected/expected-*.md` (26 files).
- `templates/output/output-*-template.md` (mirror targets per BP09 founder decision Q5).
- `samples/sample-001-dfd-crop/inputs/dfd-crop.png` and `dfd-crop.mmd` (the defective input DFD; read-only).
- `samples/sample-registry.yaml` (BP10 sample registry).
- `templates/template-registry.yaml` (BP09 template registry).

## Gates

### 1. Filename and presence

| # | Gate | Falsifiable Check | Verdict |
|---|---|---|---|
| 1 | RS baseline filename pattern | Every RS file matches `^expected-(0[1-9]\|1[0-7])-[a-z0-9-]+\.md$`. | PASS |
| 2 | DFD baseline filename pattern | Every DFD file matches `^expected-dfd-0[1-9]-[a-z0-9-]+\.md$`. | PASS |
| 3 | All 26 baselines present on disk | The 26 expected-* files exist under `samples/sample-001-dfd-crop/expected/`. | PASS |
| 4 | No extra files in `expected/` | The folder contains exactly 26 Markdown files (no `.json`, no `expected-00-run-log.md`, no extras). | PASS |

### 2. Template mirroring

| # | Gate | Falsifiable Check | Verdict |
|---|---|---|---|
| 5 | Each baseline declares `mirrors_template` | Every baseline carries YAML front matter naming a `templates/output/output-*-template.md` mirror target. | PASS |
| 6 | Mirror target resolves on disk | Each declared mirror template exists under `templates/output/`. | PASS |
| 7 | Required sections present | Each baseline body contains the `required_sections` from its mirror template (per BP10 contract). | PASS |
| 8 | YAML front matter completeness | Each baseline declares `mirrors_template`, `prompt`, `skill`, `owning_pra`, `adapter`, and `target_run_output` in YAML front matter. | PASS |

### 3. Fact-grounding

| # | Gate | Falsifiable Check | Verdict |
|---|---|---|---|
| 9 | No fabricated facts | Every fact recorded in a baseline body resolves to a sample input (`samples/sample-001-dfd-crop/inputs/*`) or is explicitly marked `unknown`. | PASS |
| 10 | No real PII / PAN / SSN / PHI | No baseline contains real PII, PAN, SSN, PHI, customer identifiers, internal employee identifiers, secrets, credentials, or production endpoints. | PASS |
| 11 | No vendor commercial product names asserted as mandatory | No baseline asserts a vendor commercial product name as a mandatory dependency. | PASS |

### 4. C1–C5 data-class semantics

| # | Gate | Falsifiable Check | Verdict |
|---|---|---|---|
| 12 | C1–C5 / C5P used per `catalogs/data-protection/data-class-catalog.yaml` | Every data-class token in a baseline body resolves to an entry in the data-class catalog (including the `C4P` raw_pattern resolution under `DC-C5P` recorded in `expected-03-legend-normalization.md`). | PASS |
| 13 | No C5 sprawl | C5 is not applied to flows or stores that the reviewed system does not actually carry. C5 / C5* / PCI / PAN / SSN / PHI tokens are out of scope for `sample-001-dfd-crop` and do not appear in baseline bodies. | PASS |
| 14 | Per-flow data class | Each flow in `expected-05-flows.md` and `expected-dfd-04-flow-inventory.md` carries its own data-class field; no flow inherits data class from the whole diagram. | PASS |

### 5. Unknown-handling discipline

| # | Gate | Falsifiable Check | Verdict |
|---|---|---|---|
| 15 | Unlabeled fields stay `unknown` | When the input DFD does not visibly label a field (e.g., authorization mechanism, storage state, at-rest encryption), the baseline records `unknown` and does not infer or invent. | PASS |
| 16 | Authorization vs authentication | Authorization is recorded independently of authentication; neither is inferred from the other; both default to `unknown` when the input does not mark them. | PASS |
| 17 | Labels-as-signals discipline | Baselines treat input labels as review signals, not implementation proof; absence of a control marker does not assert absence of the control. | PASS |

### 6. BP12-SAMPLE-DFD-BLOCKER — defect non-normalization gate

The current input DFD (`samples/sample-001-dfd-crop/inputs/dfd-crop.png` / `.mmd`) carries founder-identified defects: BND-/CMP-/F-style extraction IDs as primary diagram language, weak/incorrect boundary semantics, missing flow-label grammar (no `<data object> / <annotation tuple>` form), and incomplete storage annotations. Expected baselines must NOT normalize these defects into a clean output. They must either (a) record the same defect with `unknown` markers and a confidence downgrade, or (b) be flagged as drift here.

| # | Gate | Falsifiable Check | Verdict |
|---|---|---|---|
| 18 | Boundary-label fidelity | Where the input DFD uses `BND-01`, `BND-02`, `BND-03`, `BND-04` style extraction IDs as primary diagram language, the corresponding expected baselines either preserve that string AND record a defect note OR mark the corresponding boundary-label fact as `unknown`. Baselines that silently substitute clean trust-zone names (e.g., "Internet edge", "VPC private subnet") without traceable evidence in the input FAIL this gate and the FAIL is attributed to `BP12-SAMPLE-DFD-BLOCKER`. | PARTIAL_WITH_ISSUES |
| 19 | Component-label fidelity | Where the input DFD uses `CMP-01`..`CMP-08` style extraction IDs as primary component identifiers, the corresponding expected baselines preserve that string and do not silently rename. | PARTIAL_WITH_ISSUES |
| 20 | Flow-label grammar | Where the input DFD uses `F1`..`F8` style flow IDs without the `<data object or action> / <annotation tuple>` grammar, the corresponding expected baselines do not invent a clean grammar; missing grammar is recorded as `unknown` for the affected fields. | PARTIAL_WITH_ISSUES |
| 21 | Storage annotation honesty | Where the input DFD does not visibly mark at-rest encryption / KMS-managed / plaintext / storage state for a data store, the corresponding expected baselines record `unknown`; baselines that assert encryption or plaintext without input evidence FAIL this gate. | PARTIAL_WITH_ISSUES |
| 22 | Confidence downgrade where appropriate | Baselines that depend on the defective input DFD carry an explicit confidence-downgrade note tied to `BP12-SAMPLE-DFD-BLOCKER`, OR they preserve the raw input strings verbatim. Baselines that assert high confidence on top of a defective input FAIL this gate. | PARTIAL_WITH_ISSUES |

**Verdict for §6 under current state:** `PARTIAL_WITH_ISSUES` (BP12 records — does not correct — the carried-forward defect). The 26 baselines were authored under Build Package 10 against the same defective input. Any per-row FAIL surfaced here is attributed to `BP12-SAMPLE-DFD-BLOCKER` and resolved by founder-approved Package 10A / 11A correction. Build Package 12 does not modify the 26 baselines.

### 7. No execution / no scoring proof

| # | Gate | Falsifiable Check | Verdict |
|---|---|---|---|
| 23 | No `executed_by_operator` claim | No baseline records an `executed_by_operator` post-back or publication claim. | PASS |
| 24 | No numeric accuracy score inside baseline body | No baseline body computes a numeric accuracy score; numeric scoring is owned by `skills/rs/SK-ACCURACY-SCORE.md` only. `expected-17-accuracy-score.md` carries the qualitative verdict `PASS_READY_FOR_REVIEW` (BP10 founder decision Q5). | PASS |
| 25 | No severity / AI Action Level / blueprint-match computation in body | Selection lives in the named skill plus human review; baselines record outcomes only. | PASS |
| 26 | No new BP-* identifiers | No baseline introduces a new blueprint identifier outside `blueprints/blueprint-registry.yaml`. | PASS |
| 27 | No new catalog values | No baseline introduces a new controlled value outside `catalogs/catalog-registry.yaml`. | PASS |

## Acceptance Verdict

- **PASS** is unreachable for sample-001 baselines while the carried-forward defect persists.
- **PARTIAL_WITH_ISSUES** (current verdict) — gates 1–17 and 23–27 PASS; gates 18–22 register PARTIAL_WITH_ISSUES per `BP12-SAMPLE-DFD-BLOCKER`. Build Package 12 records the gap, does not silence it, and does not fix the baselines.
- **FAIL** when any baseline is modified by Build Package 12 to "clean up" the input defect, or when a gate other than 18–22 fails.

## Stop Conditions

- Any expected baseline is modified by Build Package 12.
- Any gate other than §6 (18–22) FAILs.
- The carried-forward defect is silently normalized away.

## Tool References

- `tools/Test-AisrafPackage.ps1` Check `08h-samples-content-limits` enforces the surface (26 Markdown files, no extras).
- This checklist is the human-review content lint; no automated content-lint script is introduced by Build Package 12.

## Out-of-Scope

- Modifying any baseline.
- Authoring sample-002.
- Producing a numeric score for `runs/RUN-001/` (chain not executed).
