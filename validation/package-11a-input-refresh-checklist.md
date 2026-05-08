# Build Package 11A — RUN-001 Input Refresh Checklist

Authored by: BUILD-AG-11A-RUN-INPUT-REFRESH-R1.

Scope: byte-copy refresh of `runs/RUN-001/inputs/` from the corrected sample-001 inputs delivered by Build Package 10A. After 11A lands, `BP12-SAMPLE-DFD-BLOCKER` becomes `RESOLVED-BY-10A-AND-11A` and Build Package 13 (Diagrams) is `next_allowed`.

## Identity

- Gate category: Package gate (corrective-patch follow-on).
- Run order position: between BP10A (Sample DFD Correction) and BP13 (Diagrams).
- Owning Build Package: 11A.
- Founder approval: explicit (in-session "Proceed with Build Package 11A only").

## Resolution Statement

`BP12-SAMPLE-DFD-BLOCKER: RESOLVED-BY-10A-AND-11A`. The sample side was resolved by Build Package 10A; the run side is resolved by Build Package 11A's byte-copy refresh of `runs/RUN-001/inputs/dfd-crop.mmd`, `dfd-crop.png`, and `dfd-legend-excerpt.md` from the corrected `samples/sample-001-dfd-crop/inputs/`. The 3 narrative inputs (`cloud-triage-notes.md`, `review-transcript.md`, `intake-ticket.md`) were not modified by 10A and are byte-stable; the byte-copies under `runs/RUN-001/inputs/` for those 3 files are unchanged.

## Scope

- `runs/RUN-001/inputs/dfd-crop.mmd` — overwritten with byte-copy of the post-10A sample input.
- `runs/RUN-001/inputs/dfd-crop.png` — overwritten with byte-copy of the post-10A sample input.
- `runs/RUN-001/inputs/dfd-legend-excerpt.md` — overwritten with byte-copy of the post-10A sample input.
- `runs/RUN-001/inputs/cloud-triage-notes.md` — re-byte-copy is a no-op (10A did not modify the source); current bytes match.
- `runs/RUN-001/inputs/review-transcript.md` — re-byte-copy is a no-op; current bytes match.
- `runs/RUN-001/inputs/intake-ticket.md` — re-byte-copy is a no-op; current bytes match.
- `runs/RUN-001/README.md` — updated to record the 11A refresh and the post-10A default DFD standard inheritance.
- `validation/package-11a-input-refresh-checklist.md` — this file (NEW).
- `validation/no-drift-rules.md` — appended `## Build Package 11A — RUN-001 Input Refresh rules`.
- BP12 cross-reference files — annotation upgraded from `RESOLVED-BY-10A` to `RESOLVED-BY-10A-AND-11A`.
- `PACKAGE-MANIFEST.yaml` — `current_build_package: 11A` (then closed); `next_build_package: 13` with `next_allowed`; `carried_forward_blockers[BP12-SAMPLE-DFD-BLOCKER].resolution_status: RESOLVED-BY-10A-AND-11A`; `build_package_11a_allowed_writes` block.
- `tools/Test-AisrafPackage.ps1` — surgical: synopsis text update; Check 11 allow-list extension by exactly one filename (`package-11a-input-refresh-checklist.md`).

## Inputs

- All 6 sample inputs under `samples/sample-001-dfd-crop/inputs/`.
- All 6 byte-copies under `runs/RUN-001/inputs/`.
- `runs/RUN-001/run-profile.yaml` (sealed; not modified).
- `runs/RUN-001/00-run-log.md` (sealed; not modified).
- `runs/RUN-001/dfd/.gitkeep` (sealed; not modified).
- `validation/package-10a-corrective-patch-checklist.md` (10A acceptance evidence).
- BP11 founder Q3: `byte_copy_six_synthetic_inputs_from_samples_sample_001_dfd_crop_inputs_into_runs_run_001_inputs`.

## Gates — Byte-Equality

Every gate is falsifiable via SHA-256 hash comparison.

| # | Gate | Falsifiable Check | Verdict |
|---|---|---|---|
| 1 | `runs/RUN-001/inputs/dfd-crop.mmd` byte-equal to `samples/sample-001-dfd-crop/inputs/dfd-crop.mmd` | `Get-FileHash -Algorithm SHA256` returns identical hashes. | PASS — `03793E0CDC64...` |
| 2 | `runs/RUN-001/inputs/dfd-crop.png` byte-equal to `samples/sample-001-dfd-crop/inputs/dfd-crop.png` | Same. | PASS — `30A546183916...` |
| 3 | `runs/RUN-001/inputs/dfd-legend-excerpt.md` byte-equal to `samples/sample-001-dfd-crop/inputs/dfd-legend-excerpt.md` | Same. | PASS — `05876605C4EB...` |
| 4 | `runs/RUN-001/inputs/cloud-triage-notes.md` byte-equal | Same (no-op refresh; 10A did not modify source). | PASS — `A6A9CF7AE0C2...` |
| 5 | `runs/RUN-001/inputs/review-transcript.md` byte-equal | Same. | PASS — `1EB757E52C67...` |
| 6 | `runs/RUN-001/inputs/intake-ticket.md` byte-equal | Same. | PASS — `297DBCB5C5C2...` |

## Gates — Default DFD Standard Inheritance

Falsifiable verification that the byte-copies under `runs/RUN-001/inputs/` inherit every default-DFD-standard property of the post-10A sample inputs.

| # | Gate | Falsifiable Check | Verdict |
|---|---|---|---|
| 7 | 4-token flow grammar in run input | `runs/RUN-001/inputs/dfd-crop.mmd` matches the same 14-flow regex `^[^/]+ / C[0-9]+,T[0-9]+,(IA\|SA\|CA)[0-9]+[OS]?,(AZ[0-9]+\|AZ\?)$` per Mermaid edge label. | PASS |
| 8 | Embedded LEGEND subgraph in run input | `runs/RUN-001/inputs/dfd-crop.mmd` contains `subgraph LEGEND`. | PASS |
| 9 | Storage tuple on every Data subnet store | `runs/RUN-001/inputs/dfd-crop.mmd` carries `<class> • R1 • Enc` on all 5 Data subnet stores. | PASS |
| 10 | No `BND-NN`, `CMP-NN`, `F#`, `BC-NN` as primary visual labels | Same as 10A gate 54. | PASS |
| 11 | Legend excerpt on disk under `runs/RUN-001/inputs/` matches sample legend excerpt | SHA-256 byte-equality (gate 3). | PASS |

## Gates — Sealed-Surface Preservation

| # | Gate | Falsifiable Check | Verdict |
|---|---|---|---|
| 12 | `runs/RUN-001/run-profile.yaml` unchanged | `git diff runs/RUN-001/run-profile.yaml` returns no changes. | PASS |
| 13 | `runs/RUN-001/00-run-log.md` unchanged | `git diff runs/RUN-001/00-run-log.md` returns no changes. | PASS |
| 14 | `runs/RUN-001/dfd/.gitkeep` unchanged | `git diff runs/RUN-001/dfd/.gitkeep` returns no changes. | PASS |
| 15 | `prompts/`, `skills/`, `prototype-agents/`, `.agents/` unchanged | `git diff` returns no changes. | PASS |
| 16 | `catalogs/`, `blueprints/`, `templates/`, `config/` unchanged | Same. | PASS |
| 17 | `samples/sample-001-dfd-crop/` unchanged by 11A (10A is the only modifier of the sample side) | `git diff samples/` returns no changes from this BP11A pass. | PASS |
| 18 | `tools/New-AisrafRun.ps1` and `tools/Test-AisrafRunProfile.ps1` unchanged | `git diff tools/New-AisrafRun.ps1 tools/Test-AisrafRunProfile.ps1` returns no changes. | PASS |
| 19 | `diagrams/`, `docs/`, `release/` unchanged (still README-only) | `git diff diagrams/ docs/ release/` returns no changes. | PASS |

## Gates — No Live Execution Claimed

| # | Gate | Falsifiable Check | Verdict |
|---|---|---|---|
| 20 | No 17 RS chain outputs in `runs/RUN-001/` | `runs/RUN-001/` does not contain `01-input-inventory.md` through `17-accuracy-score.md`. The 26 reserved future paths remain unmade. | PASS |
| 21 | No 9 DFD chain outputs under `runs/RUN-001/dfd/` | `runs/RUN-001/dfd/` contains only `.gitkeep`. | PASS |
| 22 | No row appended to `00-run-log.md` Step Entries / Post-Back Evidence / Stop Conditions Recorded | All three sections remain empty. | PASS |
| 23 | No numeric accuracy score recorded | Owned by `skills/rs/SK-ACCURACY-SCORE.md` and activates only when the operator runs the chain. 11A does not run the chain. | PASS |
| 24 | No Jira / Confluence / Rovo / MCP / runtime / cloud / ADK / Vertex / GCP / database / Terraform / `executed_by_operator` execution claim | No such claim added by 11A in any file. | PASS |

## Gates — BP12 Blocker Resolution Cross-Reference (Final)

| # | Gate | Falsifiable Check | Verdict |
|---|---|---|---|
| 25 | `validation/sample-input-readiness-checklist.md` carries `RESOLVED-BY-10A-AND-11A` | Literal string updated. | PASS |
| 26 | `validation/expected-output-lint-checklist.md` carries `RESOLVED-BY-10A-AND-11A` | Same. | PASS |
| 27 | `validation/diagram-readiness-pre-render-checklist.md` carries `RESOLVED-BY-10A-AND-11A` | Same. | PASS |
| 28 | `validation/no-drift-rules.md` carries `RESOLVED-BY-10A-AND-11A` | Same. | PASS |
| 29 | `validation/package-12-validation-checklist.md` carries `RESOLVED-BY-10A-AND-11A` | Same. | PASS |
| 30 | `validation/final-qa-checklist.md` carries `RESOLVED-BY-10A-AND-11A` | Same. | PASS |
| 31 | `PACKAGE-MANIFEST.yaml#carried_forward_blockers[BP12-SAMPLE-DFD-BLOCKER].resolution_status` is `RESOLVED-BY-10A-AND-11A` | YAML field updated. | PASS |
| 32 | `PACKAGE-MANIFEST.yaml#next_build_package.build_package_status` is `next_allowed` (not `next_allowed_pending_blocker_resolution`) | YAML field updated. | PASS |
| 33 | `PACKAGE-MANIFEST.yaml#next_build_package.build_package_number` is `13` | YAML field updated. | PASS |

## Acceptance Verdict

**PASS** — all 33 gates green. `BP12-SAMPLE-DFD-BLOCKER: RESOLVED-BY-10A-AND-11A`. Build Package 13 (Diagrams) is `next_allowed`.

## Stop Conditions

- Any FAIL in gates 1–33 above.
- Any byte-mismatch between `samples/sample-001-dfd-crop/inputs/<f>` and `runs/RUN-001/inputs/<f>` for any of the 6 files.
- Any modification to a sealed surface listed in gates 12–19.
- Any chain output produced under `runs/RUN-001/` (the 26 reserved future paths must remain unmade by 11A).
- The `BP12-SAMPLE-DFD-BLOCKER: RESOLVED-BY-10A-AND-11A` literal string missing from any of the seven cross-reference files in gates 25–31.
- Either validator script regressing.

## Validation Commands

In order, after 11A implementation:

1. SHA-256 byte-equality verification across the 6 inputs (already executed; recorded in §Gates — Byte-Equality).
2. `pwsh -NoProfile -File tools/Test-AisrafPackage.ps1` — expect 0 FAIL, 0 regression.
3. `pwsh -NoProfile -File tools/Test-AisrafRunProfile.ps1 -RunProfilePath runs/RUN-001/run-profile.yaml -ExecutionReady` — expect 12 PASS, 0 FAIL (unchanged because the run profile itself is not touched).
4. `git status` — expect deltas only inside the `build_package_11a_allowed_writes` set. `.claude/` untracked, do not stage.

## Tool References

- `tools/Test-AisrafPackage.ps1` Check 11 enforces `validation/` allow-list and is surgically extended in 11A by exactly one filename: `package-11a-input-refresh-checklist.md`.
- `tools/Test-AisrafPackage.ps1` Check `08i-runs-content-limits` enforces `runs/RUN-001/` folder layout (README + run-profile + run-log + 6 inputs + dfd/.gitkeep); 11A preserves this layout.
- `tools/Test-AisrafPackage.ps1` Check `08j-sample-dfd-grammar` (added by 10A) validates the sample-side DFD grammar; 11A does not validate `runs/RUN-001/inputs/` separately because byte-equality with the validated sample is the falsifiable proof of grammar conformance for the run side.
- `tools/Test-AisrafRunProfile.ps1` is not touched by 11A (sealed).
- `tools/New-AisrafRun.ps1` is not touched by 11A (sealed).

## Out-of-Scope

- Modifying sealed BP01–BP10A surfaces beyond the explicit 11A allow-list.
- Authoring sample-002 or any other sample folder.
- Modifying `samples/sample-001-dfd-crop/` (10A scope).
- Modifying any prompt, skill, PRA, adapter, catalog, blueprint, template, or config artefact.
- Producing diagrams (BP13), runbooks (BP14), or release artefacts (BP15).
- Producing the 17 RS or 9 DFD chain outputs in `runs/RUN-001/`.
- Producing a numeric accuracy score for `runs/RUN-001/`.
- Refreshing `intake-ticket.md`, `cloud-triage-notes.md`, `review-transcript.md` to reflect the new topology IDs (the carried-forward `BP12-SAMPLE-DFD-NARRATIVE-DRIFT` minor defect persists; does not pin BP13).
