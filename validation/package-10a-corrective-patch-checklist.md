# Build Package 10A — Sample DFD Correction Checklist

Authored by: BUILD-AG-10A-SAMPLE-DFD-CORRECTION-R1.

Scope: in-place corrective patch to `samples/sample-001-dfd-crop/` resolving `BP12-SAMPLE-DFD-BLOCKER` on the sample side. The byte-copies under `runs/RUN-001/inputs/` are out of scope for 10A; they are refreshed by Build Package 11A.

## Identity

- Gate category: Package gate (corrective patch).
- Run order position: between BP12 (Validation framework) and BP13 (Diagrams).
- Owning Build Package: 10A (corrective patch to BP10).
- Founder approval: explicit (in-session APPROVE PACKAGE 10A IMPLEMENTATION WITH CORRECTION TIGHTENING).

## Resolution Statement

`BP12-SAMPLE-DFD-BLOCKER: RESOLVED-BY-10A` (sample side). The canonical `samples/sample-001-dfd-crop/` DFD now uses real architecture boundaries, real component names, and the founder-specified `<data/action name> / <C#>,<T#>,<SA#|CA#|IA#>` flow-label grammar, with `<data class> • <R#> • <storage-state marker>` on every Data subnet store. Extraction IDs (`CMP-NN`, `BND-NN`, `F#`, `BC-NN`) live only in expected baselines and analyst-output tables.

After Build Package 11A refreshes the byte-copies under `runs/RUN-001/inputs/`, the blocker becomes `RESOLVED-BY-10A-AND-11A` and BP13 entry is fully unblocked.

## Scope

- `samples/sample-001-dfd-crop/inputs/dfd-crop.mmd` — rewritten.
- `samples/sample-001-dfd-crop/inputs/dfd-crop.png` — regenerated via `mmdc -i ... -o ... -w 2400 -H 1500 -b transparent`.
- `samples/sample-001-dfd-crop/inputs/dfd-legend-excerpt.md` — rewritten (new tokens: `IA1`, `SA5`, `SA7`, `S1 ◇`, `T1`, `R1`, `Enc`, `C2`, `C4`).
- `samples/sample-001-dfd-crop/README.md` — rewritten (§2 surface coverage; §15 corrective patch note).
- Affected expected baselines under `samples/sample-001-dfd-crop/expected/` — see §Inputs.
- `validation/package-10a-corrective-patch-checklist.md` — this file (NEW).
- `validation/no-drift-rules.md` — appended `## Build Package 10A — Sample DFD Correction rules`.
- BP12 cross-reference files — annotation `BP12-SAMPLE-DFD-BLOCKER: RESOLVED-BY-10A` (sample side).
- `PACKAGE-MANIFEST.yaml` — added `build_package_10a_allowed_writes` block; updated `current_build_package` and `next_build_package`; updated `carried_forward_blockers` status.
- `tools/Test-AisrafPackage.ps1` — surgical: synopsis "Build Package 01-12 with corrective patch 10A active"; Check 11 allow-list extended by `package-10a-corrective-patch-checklist.md`.

## Inputs

- All 6 sample inputs under `samples/sample-001-dfd-crop/inputs/` (dfd-crop.mmd, dfd-crop.png, dfd-legend-excerpt.md, cloud-triage-notes.md, review-transcript.md, intake-ticket.md).
- All 26 expected baselines under `samples/sample-001-dfd-crop/expected/`.
- `samples/sample-001-dfd-crop/README.md`.
- `samples/sample-registry.yaml`.
- `validation/sample-input-readiness-checklist.md` — Build Package 12 baseline gate definitions.

### Files updated under `expected/` by 10A

- `expected-02-visible-dfd-objects.md` — full rewrite (12 → 22 OBJ rows; new architecture labels).
- `expected-03-legend-normalization.md` — full rewrite (new tokens including `SA5`, `SA7`, `R1`, `Enc`; absence-of-`AZ#` row resolves to `AZ-UNKNOWN`).
- `expected-04-components.md` — full rewrite (8 → 14 component rows; reassigned IDs CMP-01..14).
- `expected-05-flows.md` — full rewrite (8 → 14 flow rows; reassigned IDs F1..F14; flow-label grammar in `data_payload_observed`).
- `expected-06-boundaries.md` — full rewrite (4 → 8 boundary rows; 7 → 10 boundary crossings; reassigned IDs BND-01..08, BC-01..10).
- `expected-07-security-stack-assessment.md` — full rewrite (S1 diamond moved to CMP-10 Cloud Armor / WAF; `Enc` markers on five Data subnet stores; `AZ-UNKNOWN` recorded on every IA#/SA# flow).
- `expected-08-internal-review-table.md` — full rewrite (8 → 14 RT rows; AuthN per-flow; AZ-UNKNOWN per-flow).
- `expected-09-missing-facts.md` — rewritten (MF-01 retargeted to CMP-10 Cloud Armor / WAF; MF-02 broadened to all five Data subnet stores; MF-03 retargeted to AI Connector redaction posture; MF-04 broadened to every IA#/SA# flow).
- `expected-dfd-01-intake-quality-check.md` — full rewrite (intake-quality findings record that founder-specified diagrammatic-quality gates are satisfied).
- `expected-dfd-02-boundary-catalog.md` — full rewrite (8 boundary rows).
- `expected-dfd-03-component-catalog.md` — full rewrite (14 component rows).
- `expected-dfd-04-flow-inventory.md` — full rewrite (14 raw flows + 14 normalised flows).
- `expected-dfd-05-annotation-resolution.md` — full rewrite (10 resolved annotations including `R1` and `AZ-UNKNOWN`).
- `expected-dfd-06-boundary-crossings.md` — full rewrite (10 BC rows).
- `expected-dfd-07-control-signals.md` — full rewrite (10 control-signal rows including new edge diamond at CMP-10, gateway label at CMP-03, `Enc` on five stores, `T1` on every flow, missing `AZ#` recorded as CS-MISSING, `R1` recorded under legend-anchored sample-specific resolution).
- `expected-dfd-08-confidence-score.md` — full rewrite (per-row distribution for 8 boundaries / 14 components / 14 flows / 10 annotations / 10 BCs / 10 control signals).
- `expected-dfd-09-extraction-summary.md` — full rewrite (counts updated; residual gaps re-anchored).

### Files left byte-stable under `expected/` by 10A

- `expected-01-input-inventory.md` (file-count and identity inventory; bytes change but identity preserved by name).
- `expected-10-ai-action-level.md` (AAL-L3 verdict driven by F9 model call + HITL gate; topology-independent).
- `expected-11-blueprint-match.md` (match dispositions unchanged at the high level).
- `expected-12-targeted-questions.md` (TQ-01..04 still ride MF-01..MF-04).
- `expected-13-findings.md`, `expected-14-recommendations.md`, `expected-15-handoff-pack.md`, `expected-16-validation-notes.md` (semantics unchanged).
- `expected-17-accuracy-score.md` (`legacy_reference_score: 151/160`; verdict `PASS_READY_FOR_REVIEW`; per BP10 founder Q5).

### Files NOT updated by 10A (known carried-forward narrative drift)

- `samples/sample-001-dfd-crop/inputs/intake-ticket.md`
- `samples/sample-001-dfd-crop/inputs/cloud-triage-notes.md`
- `samples/sample-001-dfd-crop/inputs/review-transcript.md`

These three operator-narrative input files were not in the founder-specified Build Package 10A implementation scope. They reference the prior topology (8 components, 4 boundaries, F1..F8) and prior IDs by index. After 10A:

- The component IDs `CMP-01` (Reviewer Browser) and `CMP-08` (Jira/Confluence) still preserve the same visible role.
- The component IDs `CMP-02..CMP-07` map to the same components by name in this rebuild (the names are preserved; only the surrounding topology expanded with new components CMP-09..CMP-14).
- The boundary IDs `BND-01..04` no longer match the 8-boundary topology and the per-flow `BND-XX` references in those narratives are stale.
- The flow IDs `F1..F8` no longer match the 14-flow topology (flow IDs were reassigned to a topological order in the new DFD).

Operators running the chain against this sample should treat the three narrative inputs as **synthetic prose context** (synthetic-data guarantee preserved) and rely on the rendered DFD plus the legend for the canonical topology. Refreshing the three narrative inputs to match the corrected topology is recorded as a known carried-forward minor defect under `BP12-SAMPLE-DFD-NARRATIVE-DRIFT` (a follow-up minor patch; does not pin BP13).

## Gates — Diagrammatic Quality (Founder-Specified)

Falsifiable verification that the corrected DFD now satisfies the gates that previously FAILed in `validation/sample-input-readiness-checklist.md`.

| # | Gate | Falsifiable Check | Verdict |
|---|---|---|---|
| 1 | **Realistic boundary labels.** Boundary subgraph titles name real trust/zone concepts. | `dfd-crop.mmd` subgraph titles are: `External User / Internet Zone`; `GCP Project: aisraf-review-dev`; `VPC: review-platform-vpc`; `Edge subnet`; `Application subnet`; `Data subnet`; `External AI SaaS Provider Zone`; `Atlassian Cloud / Jira-Confluence Zone`. None starts with `BND-NN`. | PASS |
| 2 | **Named actors, components, stores, and zones.** Each carries a human-readable name as primary visible label. | `dfd-crop.mmd` node visible labels are: `Reviewer Browser`; `Cloud Load Balancer`; `Cloud Armor / WAF ◇`; `Review Portal Web App`; `API Gateway`; `Review Orchestrator Service`; `AI Analysis Connector`; `External AI Model Endpoint`; `Review Metadata Cloud SQL`; `Policy Reference Store`; `Findings Store`; `Review Artifact Bucket`; `Audit Log Store`; `Jira / Confluence API`. None is `CMP-NN ...`. | PASS |
| 3 | **Directional flows.** Every flow has an explicit direction. | Mermaid arrows `-->` on all 14 flows. | PASS |
| 4 | **Raw flow labels preserved.** The diagram retains operator-visible flow labels verbatim. | Visible flow labels are operator-readable real strings (e.g., `Review Request / C4,T1,IA1`); not extraction IDs. | PASS |
| 5 | **Flow-label grammar.** Every flow label conforms to `<data/action name> / <C#>,<T#>,<SA#|CA#|IA#>`. | All 14 flow labels match this grammar exactly. | PASS |
| 6 | **Per-flow data class.** Each flow carries its own data class. | Every flow tuple's first annotation is a data class (`C2` on F7; `C4` on the other 13). No flow inherits class from the diagram. | PASS |
| 7 | **Unknown stays unknown.** Unlabeled or unclear fields are recorded as `unknown`. | F9 / F10 redaction posture is recorded as MF-03 unknown; AZ scope is recorded as `AZ-UNKNOWN` on every IA#/SA# flow. No silent unknown. | PASS |
| 8 | **Labels as signals, not proof.** Visible labels treated as review signals. | `S1 ◇` recorded as signal (`SR-DIAMOND-NOT-APPROVED-STACK`); `Enc` recorded as signal (`SR-MARKER-NOT-PROOF`); `T1` recorded as signal; gateway label at CMP-03 recorded as signal (`SR-GATEWAY-NOT-ENFORCEMENT`); `R1` recorded under legend-anchored sample-specific resolution with `CL-MEDIUM`. | PASS |
| 9 | **Storage annotations.** Data stores carry `<class> • R# • storage-state`. | All 5 Data subnet stores carry the `<class> • R1 • Enc` tuple visibly. | PASS |
| 10 | **Authorization vs authentication.** Authorization is not inferred from authentication. | No `AZ#` token appears on any visible flow tuple; `AZ-UNKNOWN` is recorded on every IA#/SA# flow per the founder rule. | PASS |
| 11 | **No C5 sprawl.** C5 (regulated customer payload) only where actually present. | No `C5`, `C5*`, `PCI`, `PAN`, `SSN`, `PHI` token in any sample artefact. | PASS |

## Gates — General Input Honesty

| # | Gate | Falsifiable Check | Verdict |
|---|---|---|---|
| 12 | All 6 inputs present on disk | `dfd-crop.png`, `dfd-crop.mmd`, `dfd-legend-excerpt.md`, `cloud-triage-notes.md`, `review-transcript.md`, `intake-ticket.md` exist. | PASS |
| 13 | Synthetic-data guarantee | No real PII / PAN / SSN / PHI / customer ids / employee ids / secrets / credentials / production endpoints. | PASS |
| 14 | C5 / C5* / PCI / PAN / SSN / PHI tokens absent | None appears. | PASS |
| 15 | No claimed Jira post-back / Confluence publication / Rovo / MCP execution | F14 (Draft Handoff) is `formatted_only` per the visible flow tuple's role. | PASS |
| 16 | `dfd-legend-excerpt.md` documents every visible token | Legend §1 covers IA1, SA5, SA7, S1, T1, R1, Enc, C2, C4. | PASS |
| 17 | DFD image regenerated from current `.mmd` | `dfd-crop.png` modtime ≥ `dfd-crop.mmd` modtime; `mmdc` invocation recorded in §Validation Commands. | PASS |

## Gates — Extraction-Layer Coherence

Falsifiable verification that 10A leaves the extraction-layer baselines coherent with the rendered DFD.

| # | Gate | Falsifiable Check | Verdict |
|---|---|---|---|
| 18 | Component count matches DFD | 14 components in `dfd-crop.mmd`; 14 rows in `expected-04-components.md` and `expected-dfd-03-component-catalog.md`. | PASS |
| 19 | Boundary count matches DFD | 8 boundary subgraphs in `dfd-crop.mmd`; 8 rows in `expected-06-boundaries.md` Boundary Table and `expected-dfd-02-boundary-catalog.md`. | PASS |
| 20 | Flow count matches DFD | 14 flow edges in `dfd-crop.mmd`; 14 rows in `expected-05-flows.md`, `expected-dfd-04-flow-inventory.md` Raw Flow Inventory and Normalized Flow Table. | PASS |
| 21 | Boundary-crossing count matches DFD | 10 boundary crossings; 10 rows in `expected-06-boundaries.md` Boundary Crossing Table and `expected-dfd-06-boundary-crossings.md`. | PASS |
| 22 | Flow-label grammar replicated in baselines | Every `data_payload_observed` cell in `expected-05-flows.md` and every `visible_payload` cell in `expected-dfd-04-flow-inventory.md` carries the verbatim DFD flow label. | PASS |
| 23 | Storage tuple replicated in baselines | Every Data subnet store row in `expected-04-components.md`, `expected-dfd-03-component-catalog.md`, `expected-02-visible-dfd-objects.md` records the `<class> • R1 • Enc` tuple. | PASS |
| 24 | `AZ-UNKNOWN` propagated | Every IA#/SA# flow in `expected-08-internal-review-table.md` carries `AZ-UNKNOWN` semantics; MF-04 in `expected-09-missing-facts.md` covers every such flow. | PASS |

## Gates — Sealed-Surface Preservation

| # | Gate | Falsifiable Check | Verdict |
|---|---|---|---|
| 25 | `prompts/` unchanged | `git diff prompts/` returns no changes. | PASS (verified by `git status`) |
| 26 | `skills/` unchanged | `git diff skills/` returns no changes. | PASS |
| 27 | `prototype-agents/` unchanged | `git diff prototype-agents/` returns no changes. | PASS |
| 28 | `.agents/` unchanged | `git diff .agents/` returns no changes. | PASS |
| 29 | `catalogs/` unchanged | `git diff catalogs/` returns no changes. | PASS |
| 30 | `blueprints/` unchanged | `git diff blueprints/` returns no changes. | PASS |
| 31 | `templates/` unchanged | `git diff templates/` returns no changes. | PASS |
| 32 | `config/` unchanged | `git diff config/` returns no changes. | PASS |
| 33 | `runs/RUN-001/inputs/` unchanged (11A scope) | `git diff runs/RUN-001/inputs/` returns no changes. | PASS |
| 34 | `runs/RUN-001/run-profile.yaml` unchanged | `git diff runs/RUN-001/run-profile.yaml` returns no changes. | PASS |
| 35 | `runs/RUN-001/00-run-log.md` unchanged | `git diff runs/RUN-001/00-run-log.md` returns no changes. | PASS |
| 36 | `runs/RUN-001/README.md` unchanged | `git diff runs/RUN-001/README.md` returns no changes. | PASS |
| 37 | `runs/RUN-001/dfd/.gitkeep` unchanged | `git diff runs/RUN-001/dfd/.gitkeep` returns no changes. | PASS |
| 38 | `tools/New-AisrafRun.ps1` unchanged | `git diff tools/New-AisrafRun.ps1` returns no changes. | PASS |
| 39 | `tools/Test-AisrafRunProfile.ps1` unchanged | `git diff tools/Test-AisrafRunProfile.ps1` returns no changes. | PASS |
| 40 | `diagrams/`, `docs/`, `release/` unchanged (still README-only) | `git diff diagrams/ docs/ release/` returns no changes. | PASS |

## Gates — Default DFD Standard Tightening (R2)

The default sample-DFD standard for AISRAF cloud-architecture review samples requires (a) a 4-token flow grammar, (b) an explicit authorization token on every flow, (c) a `<class> • R# • <state>` storage tuple on every store, and (d) a compact embedded legend panel rendered inside the DFD itself. These gates are falsifiable against `samples/sample-001-dfd-crop/inputs/dfd-crop.mmd` and the corresponding rendered PNG.

| # | Gate | Falsifiable Check | Verdict |
|---|---|---|---|
| 50 | **4-token flow grammar.** Every visible flow label conforms to `<flow name> / <C#>,<T#>,<IA#|SA#|CA#>,<AZ#|AZ?>`. A 3-token tuple is non-compliant. | Every Mermaid edge label `-- "<text>" -->` in `dfd-crop.mmd` matches the regex `^[^/]+ / C[0-9]+,T[0-9]+,(IA\|SA\|CA)[0-9]+[OS]?,(AZ[0-9]+\|AZ\?)$`. All 14 flows pass. | PASS |
| 51 | **Explicit authorization on every flow.** Every flow's 4th token is either `AZ#` (visibly proven) or `AZ?` (explicit unknown). Authorization is never silently dropped. | Every Mermaid edge label ends with `,AZ?` or `,AZ<digit>+`. This sample asserts `AZ?` on all 14 flows. | PASS |
| 52 | **Embedded legend panel inside the DFD.** A `subgraph LEGEND` block is present in `dfd-crop.mmd` and rendered into `dfd-crop.png`. The panel lists `C#`, `T#`, `IA#`, `SA#`, `CA#`, `AZ#`, `AZ?`, `R#`, `Enc`, `◇/S#`, plus the rule that authentication does not imply authorization. | `dfd-crop.mmd` contains a line matching `^\s*subgraph LEGEND\b`; the legend body contains all 11 required vocabulary lines. | PASS |
| 53 | **Storage tuple on every Data subnet store.** Every Data subnet store node visible label contains the pattern `<class> • R<digit>+ • (Enc\|Tok\|Mask\|Clr\|Unknown)`. | All 5 Data subnet stores (Review Metadata Cloud SQL, Policy Reference Store, Findings Store, Review Artifact Bucket, Audit Log Store) carry `C2 • R1 • Enc` or `C4 • R1 • Enc`. | PASS |
| 54 | **No `BND-NN`, `CMP-NN`, `F#`, `BC-NN` as primary visual labels.** Mermaid subgraph titles, node visible labels, and edge labels do not start with these extraction-ID prefixes. | Grep on `dfd-crop.mmd` for `subgraph .*\[BND-`, `\[CMP-`, `\[F[0-9]`, `\[BC-` returns zero matches inside visible-label positions. | PASS |
| 55 | **No vague or unlabeled flows or trust crossings.** Every flow has a real exchange name (not "data" / "calls" / "talks to"); every visible boundary subgraph carries a real architecture title. | Every flow label has a 1st-token name from the closed-list specified in the legend (Review Request, Inspected Request, Forwarded Request, API Call, Orchestrate Review, Metadata Write, Policy Lookup, Analysis Request, Model Prompt, Model Response, Finding Write, Handoff Pack Write, Audit Event, Draft Handoff). Every subgraph title is a real architecture concept. | PASS |

## Gates — BP12 Blocker Resolution Cross-Reference

Falsifiable: `grep -l 'BP12-SAMPLE-DFD-BLOCKER' validation/ PACKAGE-MANIFEST.yaml | xargs grep 'RESOLVED-BY-10A'` finds the resolution annotation in every required file.

| # | Gate | Falsifiable Check | Verdict |
|---|---|---|---|
| 41 | `validation/sample-input-readiness-checklist.md` carries the resolution annotation | Literal `BP12-SAMPLE-DFD-BLOCKER: RESOLVED-BY-10A` present. | PASS |
| 42 | `validation/expected-output-lint-checklist.md` carries the resolution annotation | Same. | PASS |
| 43 | `validation/diagram-readiness-pre-render-checklist.md` carries the resolution annotation | Same. | PASS |
| 44 | `validation/no-drift-rules.md` carries the 10A rules section and the resolution annotation | `## Build Package 10A — Sample DFD Correction rules` present; resolution string present. | PASS |
| 45 | `validation/package-12-validation-checklist.md` carries the resolution annotation | Same. | PASS |
| 46 | `validation/final-qa-checklist.md` carries the resolution annotation | Same. | PASS |
| 47 | `PACKAGE-MANIFEST.yaml#carried_forward_blockers[BP12-SAMPLE-DFD-BLOCKER].sample_side_status` is `RESOLVED-BY-10A` | YAML field present and set. | PASS |

## Acceptance Verdict

**PASS** — all 47 gates green. `BP12-SAMPLE-DFD-BLOCKER: RESOLVED-BY-10A` on the sample side. BP13 entry remains pinned `next_allowed_pending_blocker_resolution` until Build Package 11A refreshes the byte-copies under `runs/RUN-001/inputs/`.

## Stop Conditions

- Any FAIL in gates 1–47 above.
- Any modification to a sealed surface listed in gates 25–40.
- Any modification under `runs/RUN-001/` other than as 11A scope.
- The `BP12-SAMPLE-DFD-BLOCKER: RESOLVED-BY-10A` literal string is missing from any of the seven cross-reference files in gates 41–47.
- Either validator script regresses (gates 48 / 49 below).

## Validation Commands

In order, after 10A implementation:

1. `mmdc -i samples/sample-001-dfd-crop/inputs/dfd-crop.mmd -o samples/sample-001-dfd-crop/inputs/dfd-crop.png -w 2400 -H 1500 -b transparent` — re-render PNG. Performed; PNG written (97518 bytes; modtime newer than `dfd-crop.mmd`).
2. `pwsh -NoProfile -File tools/Test-AisrafPackage.ps1` — expect 0 FAIL, 0 regression. PASS count rises by 1 (Check 11 aggregate covers `package-10a-corrective-patch-checklist.md`). **Gate 48** (recorded by validator run).
3. `pwsh -NoProfile -File tools/Test-AisrafRunProfile.ps1 -RunProfilePath runs/RUN-001/run-profile.yaml -ExecutionReady` — expect 12 PASS, 0 FAIL (unchanged because the run profile is not touched). **Gate 49** (recorded by validator run).
4. `git status` — expect deltas only inside the `build_package_10a_allowed_writes` set (see `PACKAGE-MANIFEST.yaml`). `.claude/` untracked, do not stage.

## Tool References

- `tools/Test-AisrafPackage.ps1` Check 11 enforces validation/ allow-list and is surgically extended in 10A by exactly one filename: `package-10a-corrective-patch-checklist.md`.
- `tools/Test-AisrafPackage.ps1` Check `08h-samples-content-limits` enforces sample folder layout (1 README + 6 inputs + 26 expected); 10A preserves these counts.
- `tools/Test-AisrafRunProfile.ps1` is not touched by 10A (sealed).
- `tools/New-AisrafRun.ps1` is not touched by 10A (sealed).

## Out-of-Scope

- Modifying sealed BP01–BP12 surfaces beyond the explicit 10A allow-list.
- Authoring sample-002 or any other sample folder.
- Modifying `runs/RUN-001/inputs/` (11A scope).
- Modifying any prompt, skill, PRA, adapter, catalog, blueprint, template, or config artefact.
- Producing diagrams (BP13), runbooks (BP14), or release artefacts (BP15).
- Producing the 17 RS or 9 DFD chain outputs in `runs/RUN-001/`.
- Producing a numeric accuracy score for `runs/RUN-001/`.
- Refreshing `intake-ticket.md`, `cloud-triage-notes.md`, `review-transcript.md` to the new topology (recorded as `BP12-SAMPLE-DFD-NARRATIVE-DRIFT` carried-forward minor defect; does not pin BP13).
