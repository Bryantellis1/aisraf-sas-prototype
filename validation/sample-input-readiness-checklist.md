# Sample Input Readiness Checklist

Authored by: BUILD-AG-12-VALIDATION-R1.

Scope: per-sample readiness gate over `samples/sample-001-dfd-crop/`. Confirms that the sample's input set is honest, that the canonical DFD meets diagrammatic-quality gates, and that an operator running the BP04–BP09 chain against this sample will not silently consume a defective input as if it were canonical.

This checklist does not modify any sample artefact. The current sample-001 DFD FAILs the diagrammatic-quality gates; the FAIL is attributed to `BP12-SAMPLE-DFD-BLOCKER` (severity HARD, owner founder). BP12 records the FAIL line-by-line; only a founder-approved Package 10A / 11A corrective patch or a founder-approved sample-002 may correct it.

> **`BP12-SAMPLE-DFD-BLOCKER: RESOLVED-BY-10A` (sample side).** Build Package 10A reworked the canonical DFD into a realistic GCP-style architecture review diagram. The diagrammatic-quality gates 7, 8, 11, 12, 13, 14, 15, 16 below now PASS against the corrected `samples/sample-001-dfd-crop/inputs/dfd-crop.mmd` and `dfd-crop.png`. See `validation/package-10a-corrective-patch-checklist.md` for the falsifiable evidence. Build Package 11A refreshes the byte-copies under `runs/RUN-001/inputs/` to complete resolution; until 11A lands, BP13 entry remains pinned `next_allowed_pending_blocker_resolution`. The verdict text below is preserved as the BP12 historical record.

## Identity

- Gate category: Sample gate.
- Run order position: 4 (Sample gates).
- Sample under review: `sample-001-dfd-crop` (AI SaaS Security Review Portal scenario).
- Sealed sources: `samples/sample-001-dfd-crop/inputs/*` and the byte-copies under `runs/RUN-001/inputs/*`.

## Carried-Forward Blocker

`BP12-SAMPLE-DFD-BLOCKER` — defect statement (verbatim from founder review, recorded for the record):

> The current DFD is not acceptable as the canonical AISRAF sample DFD because it mixes extraction IDs with visual architecture notation, uses artificial BND-/CMP-/F-style labels as primary diagram language, has weak/incorrect boundary semantics, and does not consistently follow AISRAF flow-label grammar or data-store annotation rules.

## Scope

- The 6 input files under `samples/sample-001-dfd-crop/inputs/`:
  - `dfd-crop.png` (rendered DFD; **defective per founder review**).
  - `dfd-crop.mmd` (Mermaid source for the rendered DFD; **inherits the defect**).
  - `dfd-legend-excerpt.md` (legend annotations).
  - `cloud-triage-notes.md` (analyst notes).
  - `review-transcript.md` (review session transcript).
  - `intake-ticket.md` (intake ticket text).
- The byte-copies under `runs/RUN-001/inputs/` (read-only; inherit the same defect by construction).

## Inputs

- `samples/sample-001-dfd-crop/inputs/*`.
- `samples/sample-001-dfd-crop/README.md`.
- `samples/sample-registry.yaml`.

## Gates — General Input Honesty

| # | Gate | Falsifiable Check | Verdict |
|---|---|---|---|
| 1 | All 6 inputs present on disk | `dfd-crop.png`, `dfd-crop.mmd`, `dfd-legend-excerpt.md`, `cloud-triage-notes.md`, `review-transcript.md`, `intake-ticket.md` exist. | PASS |
| 2 | Synthetic-data guarantee | No real PII, PAN, SSN, PHI, customer identifiers, internal employee identifiers, secrets, credentials, or production endpoints appear in any input. | PASS |
| 3 | C5 / C5* / PCI / PAN / SSN / PHI tokens absent | These tokens are explicitly out of scope for `sample-001-dfd-crop`; none appears in the inputs. | PASS |
| 4 | No claimed Jira post-back / Confluence publication / Rovo / MCP execution in inputs | The Jira/Confluence formatter at CMP-08 / F8 is `formatted_only`. | PASS |
| 5 | `dfd-legend-excerpt.md` documents the legend used by the DFD | The legend file is present and is the source for legend normalization. | PASS |
| 6 | `intake-ticket.md`, `review-transcript.md`, `cloud-triage-notes.md` are non-empty and synthetic | All three inputs carry synthetic content sufficient to exercise the chain. | PASS |

## Gates — Diagrammatic Quality (Founder-Specified)

| # | Gate | Falsifiable Check | Verdict |
|---|---|---|---|
| 7 | **Realistic boundary labels.** Boundary labels name real trust/zone concepts (e.g., "Internet edge", "VPC private subnet", "Contoso AD tenant"), not extraction IDs (e.g., `BND-001`) used as primary diagram language. | The DFD source uses `BND-01`, `BND-02`, `BND-03`, `BND-04` extraction IDs as primary boundary labels. | FAIL — `BP12-SAMPLE-DFD-BLOCKER` |
| 8 | **Named actors, components, stores, and zones.** Each actor/component/store/zone carries a human-readable name, not an extraction-ID-as-name. | The DFD source uses `CMP-01`..`CMP-08` extraction IDs as primary component names alongside readable suffixes. | FAIL — `BP12-SAMPLE-DFD-BLOCKER` |
| 9 | **Directional flows.** Every flow has an explicit direction (arrowhead or named source→target). | The Mermaid source uses directional arrows (`-->`); this gate passes structurally. | PASS |
| 10 | **Raw flow labels preserved.** The diagram retains operator-visible flow labels verbatim before any parsing/normalization step. | Operator-visible flow labels are present in the rendered diagram. | PASS |
| 11 | **Flow-label grammar.** Every flow label conforms to `<data object or action> / <annotation tuple>` (e.g., `customer payload / [PII, C4, in-flight, TLS-terminated]`). | Flow labels in the DFD source use `F1`..`F8` IDs followed by short prose, not the `<data object or action> / <annotation tuple>` grammar. | FAIL — `BP12-SAMPLE-DFD-BLOCKER` |
| 12 | **Per-flow data class.** Each flow carries its own data class; data class is never inherited from the whole diagram. | Some flows carry a data class token; others do not. Where a data class is missing, the input does not record `unknown` consistently. | FAIL — `BP12-SAMPLE-DFD-BLOCKER` |
| 13 | **Unknown stays unknown.** Unlabeled or unclear fields are recorded as `unknown`, never inferred or invented. | The input does not consistently mark unlabeled fields as `unknown`; this lays the trap that downstream baselines fall into. | FAIL — `BP12-SAMPLE-DFD-BLOCKER` |
| 14 | **Labels as signals, not proof.** Visible labels are treated as review signals, not implementation proof; absence of a control marker does not prove absence of the control. | The DFD is consumed downstream as if labels were proof; this gate is a process gate and is FAILed by the same defect chain. | FAIL — `BP12-SAMPLE-DFD-BLOCKER` |
| 15 | **Storage annotations.** Data stores carry a data class + at-rest marker + storage state (e.g., "encrypted-at-rest, KMS-managed", "plaintext-at-rest, none") where visible. | Stores in the DFD carry partial markers (`C4P · E1 marker`, `C2`, `C4`) without consistent at-rest / storage state semantics. | FAIL — `BP12-SAMPLE-DFD-BLOCKER` |
| 16 | **Authorization vs authentication.** Authorization is not inferred from authentication; both are recorded independently or as `unknown`. | The DFD source does not distinguish authorization from authentication; both default to ambiguous markers. | FAIL — `BP12-SAMPLE-DFD-BLOCKER` |
| 17 | **No C5 sprawl.** C5 (regulated customer payload) is applied only to flows/stores where the reviewed system actually carries regulated customer payloads; default to lower classes when in doubt. | The DFD does not apply C5 sprawl (C5 / C5* / PCI / PAN / SSN / PHI tokens are absent per gate 3); this gate passes. | PASS |

## Verdict for sample-001 under these gates

`FAIL` with `BP12-SAMPLE-DFD-BLOCKER` cited. Gates 7, 8, 11, 12, 13, 14, 15, 16 FAIL because the input DFD does not meet the founder-specified diagrammatic-quality gates. Build Package 12 does not modify the sample to make it pass.

## Operator Posture While Blocker Persists

- An operator running the BP04–BP09 chain against `runs/RUN-001/` will produce outputs that mirror the input defect.
- Confidence on chain outputs will be downgraded; multiple fields will read `unknown`.
- The chain will execute, but its outputs are NOT a canonical reference run for AISRAF SAS Prototype v0.1.2.
- A canonical reference run requires resolution of `BP12-SAMPLE-DFD-BLOCKER` via founder-approved Package 10A / 11A correction OR sample-002 with a clean DFD.

## Acceptance Verdict

- **PASS** is unreachable for sample-001 while `BP12-SAMPLE-DFD-BLOCKER` persists.
- **FAIL** (current verdict) — gates 7, 8, 11, 12, 13, 14, 15, 16 FAIL per founder review. The FAIL is intentional, named, and attributed to `BP12-SAMPLE-DFD-BLOCKER` (see `validation/README.md` BLOCKERS section for the full chain of cross-references).
- **BLOCKED** is not used for this checklist; the checklist itself executes and FAILs honestly. The downstream pre-render gate (`validation/diagram-readiness-pre-render-checklist.md`) is BLOCKED.

## Stop Conditions

- Any input under `samples/sample-001-dfd-crop/inputs/` is modified by Build Package 12.
- The blocker citation is dropped from this file.
- A baseline is silently authored to "clean up" the FAIL.

## Tool References

- `tools/Test-AisrafPackage.ps1` Check `08h-samples-content-limits` enforces input file count and naming; it does NOT enforce diagrammatic-quality gates.
- This checklist is the human-review diagrammatic-quality gate.

## Out-of-Scope

- Modifying the sample DFD source or render.
- Authoring sample-002.
- Modifying any expected baseline.
