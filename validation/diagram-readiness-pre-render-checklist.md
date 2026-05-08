# Diagram Readiness Pre-Render Checklist

Authored by: BUILD-AG-12-VALIDATION-R1.

Scope: Build Package 13 entry gate. Confirms — under a hard precondition — that catalogs carry visual-semantics vocabulary, blueprint registry has interaction types, sample expected outputs define DFD output shape, and `runs/RUN-001/dfd/` is the canonical sink. This checklist is **pre-render only**: Build Package 12 forbids creating any diagram, image, or render.

> **Top-of-file hard precondition.** BP13 is **BLOCKED** until `BP12-SAMPLE-DFD-BLOCKER` is resolved via founder-approved Package 10A / 11A correction OR sample-002 with a clean DFD is authorized. If the precondition is not met, **every downstream gate in this file evaluates to `BLOCKED`** (not PASS, not FAIL) and BP13 cannot enter.

> **`BP12-SAMPLE-DFD-BLOCKER: RESOLVED-BY-10A` (sample side).** Build Package 10A reworked `samples/sample-001-dfd-crop/inputs/dfd-crop.mmd` and `dfd-crop.png` into a realistic GCP-style architecture review DFD that satisfies the founder-specified diagrammatic-quality gates. The precondition gate below (§Precondition Gate (Hard), gate 0) becomes **MET** after Build Package 11A refreshes the byte-copies under `runs/RUN-001/inputs/`. Until 11A lands, the precondition reads `MET-ON-SAMPLE-SIDE` and downstream gates remain `BLOCKED-PENDING-11A`. After 11A lands, downstream gates re-evaluate against the catalog / blueprint / template / sample inventory. See `validation/package-10a-corrective-patch-checklist.md` for the 10A falsifiable evidence.

## Identity

- Gate category: Forward gate.
- Run order position: 7 (Forward gates).
- BP13 entry condition: this checklist evaluates to PASS, which requires `BP12-SAMPLE-DFD-BLOCKER` to be resolved first.

## Carried-Forward Blocker

`BP12-SAMPLE-DFD-BLOCKER` (severity HARD, owner founder) — current sample DFD inputs are not acceptable as the canonical AISRAF sample DFD. Building diagrams (BP13) on top of a defective canonical sample would propagate the defect into the v0.1.2 diagrams set. The blocker pins BP13 entry until correction lands.

## Precondition Gate (Hard)

| # | Gate | Falsifiable Check | Verdict |
|---|---|---|---|
| 0 | `BP12-SAMPLE-DFD-BLOCKER` resolved | Founder-approved Package 10A / 11A correction lands AND `validation/sample-input-readiness-checklist.md` reads PASS for sample-001, OR sample-002 with a clean DFD is authorized AND the canonical sample for BP13 is shifted to sample-002. | **NOT MET — BLOCKED** |

**While the precondition is NOT MET, every downstream gate below evaluates to `BLOCKED`. BP13 cannot enter. This is a fail-closed pre-render gate.**

## Downstream Gates (Evaluated Only After Precondition Met)

### Catalog readiness for visual semantics

| # | Gate | Falsifiable Check (under precondition) | Verdict (current) |
|---|---|---|---|
| 1 | Components catalog supports diagram types | `catalogs/components/component-type-catalog.yaml` carries entries usable for diagram nodes (gateway_service, data_store, model_endpoint, application_service, tool_or_api_surface, external_actor, etc.). | BLOCKED |
| 2 | Interactions catalog supports flow vocabulary | `catalogs/interactions/` carries entries usable as flow types (HTTPS, API call, model call, write, read, formatted_only handoff, etc.). | BLOCKED |
| 3 | Boundaries catalog supports trust-zone vocabulary | `catalogs/boundaries/` carries entries usable as boundary labels (Internet edge, application zone, internal data zone, external SaaS, etc.). | BLOCKED |
| 4 | Identity-access catalog supports identity-type vocabulary | `catalogs/identity-access/` carries entries usable on diagrams (`IA1` etc.). | BLOCKED |
| 5 | Data-protection catalog supports data-class annotations | `catalogs/data-protection/data-class-catalog.yaml` and `catalogs/data-protection/confidence-level-catalog.yaml` resolve. | BLOCKED |
| 6 | Security-stacks catalog supports stack annotations | `catalogs/security-stacks/proof-vs-signal-rule-catalog.yaml` is `global_rule: true`. | BLOCKED |
| 7 | Review catalog usable for diagram-side review labels | `catalogs/review/` resolves. | BLOCKED |

### Blueprint registry readiness for interaction types

| # | Gate | Falsifiable Check (under precondition) | Verdict (current) |
|---|---|---|---|
| 8 | Blueprint match states fixed at 4 | `blueprints/blueprint-registry.yaml` records `[matched, candidate, no_match, unknown]`. | BLOCKED |
| 9 | All 9 blueprints reference catalog identifiers only | No blueprint introduces a new catalog identifier. | BLOCKED |
| 10 | `BP-AI-SAAS-INTEGRATION` cloud pattern resolves | The cloud-patterns blueprint exists at `blueprints/cloud-patterns/BP-AI-SAAS-INTEGRATION.yaml`. | BLOCKED |

### Sample expected outputs define DFD output shape

| # | Gate | Falsifiable Check (under precondition) | Verdict (current) |
|---|---|---|---|
| 11 | 9 DFD baselines define output shape | `samples/sample-001-dfd-crop/expected/expected-dfd-01..09-*.md` exist and mirror `templates/output/output-dfd-01..09-*-template.md`. | BLOCKED |
| 12 | DFD output template surface frozen | `templates/output/` carries the 9 DFD output templates referenced by the BP13 diagram-shape contract. | BLOCKED |
| 13 | Sample DFD inputs (`dfd-crop.png` / `.mmd`) meet diagrammatic-quality gates | `validation/sample-input-readiness-checklist.md` reads PASS for sample-001 (or for sample-002 if the canonical sample shifts). | BLOCKED |

### Canonical diagram sink

| # | Gate | Falsifiable Check (under precondition) | Verdict (current) |
|---|---|---|---|
| 14 | `runs/RUN-001/dfd/` is the canonical sink | The folder exists and is empty save for the BP12 `.gitkeep` reservation marker. | BLOCKED |
| 15 | `diagrams/` remains README-only until BP13 | No `diagrams/*` content beyond `diagrams/README.md` exists. | BLOCKED |
| 16 | `docs/` remains README-only until BP14 | No `docs/*` content beyond `docs/README.md` exists. | BLOCKED |

## Acceptance Verdict

- **PASS** is unreachable while `BP12-SAMPLE-DFD-BLOCKER` persists.
- **BLOCKED** (current verdict) — gate 0 NOT MET; every downstream gate evaluates to BLOCKED. BP13 entry is denied.
- **FAIL** is reserved for the case where Build Package 12 itself produces a diagram, image, render, or BP13 artefact (forbidden).

## Stop Conditions

- Any diagram, image, or render is created by Build Package 12.
- The hard precondition (gate 0) is silently marked as MET without founder-approved correction.
- The `BP12-SAMPLE-DFD-BLOCKER` citation is dropped from this file.
- A BP13 artefact (diagram source file, rendered PNG/SVG, diagram template) lands under `diagrams/` before BP13 entry.

## Forbidden Outputs in Build Package 12

- `diagrams/*` content beyond the existing `diagrams/README.md` (BP01).
- Any `.png`, `.svg`, `.pdf`, `.dot`, `.mmd` (diagram), or rendered artefact.
- Any diagram-source authoring instruction inside a BP12 validation file.
- Any "rendered" or "generated" claim for a diagram in any BP12 file.

## Tool References

- `tools/Test-AisrafPackage.ps1` Check `08-folder-readme-only-rule` enforces `diagrams/` as README-only.
- This checklist is the human-review pre-render gate; no automated diagram-readiness validator is introduced by Build Package 12.

## Out-of-Scope

- Creating any diagram in Build Package 12.
- Authoring BP13 artefacts.
- Modifying the sample DFD source.
- Modifying any expected baseline.
