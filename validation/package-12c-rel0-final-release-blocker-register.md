# WP-12C-REL0-QA — Final Release Blocker Register (Gap Detail)

| Field | Value |
|---|---|
| Work package | WP-12C-REL0-QA — Final Public Release QA |
| Companion report | `validation/package-12c-rel0-final-release-qa-report.md` |
| Agents | `AG-AISRAF-PACKAGE-QA-VALIDATOR-R1`, `AG-AISRAF-VERSION-CONTROL-HYGIENE-R1`, `AG-AISRAF-SECURITY-OVERCLAIM-GUARD-R1` |
| Mode | Audit-only. The REL0-QA agents record gaps; they do not remediate them. |
| Severity legend | `blocker` (must close before the named gate) / `warning` (must close before the named gate, but does not gate the immediately-next REL0-C step) / `info` |
| Gate column | The first gate the entry blocks. REL0-C is plan-then-execute and is not blocked by `warning`-class entries unless explicitly stated. |
| Owner column | The work package or micro-patch that owns the remediation. |

This register is the detail layer for §19 of `validation/package-12c-rel0-final-release-qa-report.md`. Severity, owner, and gate decisions in this register override any informal mention elsewhere. The five QA1 blockers (RB-001..RB-005) in `validation/package-12c-release-blocker-register.md` are independent of this register; RB-001/RB-002 are still owned by WP-12C-L3 (smoke folder hygiene) and tracked as KW-001/KW-002 in `RELEASE-MANIFEST.yaml`; RB-003/RB-004 were closed by ED1; RB-005 was closed before ED1 by QA1-PATCH-A.

---

## RB-REL0-001 — `README.md` line 15 stale; no v0.1.2 release framing or `docs/` entrypoint

| Field | Value |
|---|---|
| id | RB-REL0-001 |
| severity | `warning` |
| category | public-reader entrypoint staleness |
| path | `README.md` (line 15 and the "Current State" / "Where To Start" / "Next Build Package" / "Not Yet Created" sections) |
| evidence | Line 15: `Build Packages 01–12 are active (Build Package 12 is the most recent, pending human review before commit):`. The "Current State" enumeration stops at Build Package 12 and does not mention BP12C (`.copilot-skills/`, `.github/skills/`, `.github/hooks/`, `plugins/aisraf-copilot-plugin/`, the four `tools/hooks/` scripts, the L2B controlled-output evidence run, the public release docs). The "Where To Start" list points to `START-HERE.md`, `PROTOTYPE-CHARTER.md`, `BUILD-ORDER.md`, `FOLDER-CONTRACTS.md`, and `validation/README.md` — none of which are the v0.1.2 public reader entrypoints (`RELEASE-MANIFEST.yaml`, `CHANGELOG.md`, `docs/AISRAF-PRIMER.md`, `docs/OPERATOR-QUICKSTART.md`, `docs/SECURITY-REVIEW-WORKFLOW.md`, `docs/ARCHITECTURE-OVERVIEW.md`, `docs/ROADMAP.md`). |
| impact | Public reader who arrives at the repository sees a pre-release BP12 framing instead of the v0.1.2 public-safe release framing. The AL2 controlled-output local workbench claim, the plugin packaging trajectory, the public docs surface, and the autonomy-level table all live in `docs/`; `README.md` does not link to them. |
| proposed owner | WP-12C-REL0-C (focused doc-only micro-patch) or WP-12C-ED2 |
| gate blocked | WP-12C-REL0 closure; WP-13 unblock; public publication readiness |
| remediation | Add a v0.1.2 release header that points to `RELEASE-MANIFEST.yaml`, `CHANGELOG.md`, `docs/AISRAF-PRIMER.md`, `docs/OPERATOR-QUICKSTART.md`, `docs/SECURITY-REVIEW-WORKFLOW.md`, `docs/ARCHITECTURE-OVERVIEW.md`, and `docs/ROADMAP.md`. Update the "Current State" enumeration to record BP12C completion through REL0-B. Update the "Where To Start" list to lead with the public docs. Preserve the internal-build-document references for contributor flow under a clearly-labelled "Contributor / governance reading" subsection. |
| seeded | no |

---

## RB-REL0-002 — `START-HERE.md` line 5 stale; Operator Steps point to internal build docs only

| Field | Value |
|---|---|
| id | RB-REL0-002 |
| severity | `warning` |
| category | public-reader entrypoint staleness |
| path | `START-HERE.md` (line 5 and the entire "Operator Steps" list) |
| evidence | Line 5: `This workspace has Build Packages 01–12 active. Build Package 12 (validation framework) is the most recent.`. The "Operator Steps" list points to `README.md`, `PROTOTYPE-CHARTER.md`, `BUILD-ORDER.md`, `FOLDER-CONTRACTS.md`, the canonical surface READMEs, and `validation/README.md`. There is no mention of `docs/AISRAF-PRIMER.md`, the public release surface, the AL2 / AL3 / AL4 / AL5 posture, the plugin, or the v0.1.2 release status. The "Stop For Now" list still talks about Build Package 13 BLOCKED by `BP12-SAMPLE-DFD-BLOCKER` (consistent with `validation/README.md` and `validation/diagram-readiness-pre-render-checklist.md`, but inconsistent with the v0.1.2 release framing where WP-13 is blocked behind WP-12C-REL0 closure). |
| impact | An operator who opens `START-HERE.md` is sent on the original package-build tour and never lands on the v0.1.2 public reader docs. The contributor / governance posture is correctly described; the public-reader posture is missing. |
| proposed owner | WP-12C-REL0-C / WP-12C-ED2 |
| gate blocked | WP-12C-REL0 closure; WP-13 unblock |
| remediation | Lead with a "v0.1.2 release — read first" section that links to `RELEASE-MANIFEST.yaml`, `CHANGELOG.md`, and the five `docs/` files. Move the existing "Operator Steps" list under a "Contributor / package authoring" subsection. Update the "Stop For Now" list to record the v0.1.2 release framing for WP-13 (blocked behind WP-12C-REL0 closure) alongside the existing validation-taxonomy blocker (`BP12-SAMPLE-DFD-BLOCKER`). |
| seeded | no |

---

## RB-REL0-003 — `PACKAGE-MANIFEST.yaml` `current_build_package` and `wp12c_*_status` fields lag ED1 closure and REL0-B commit

| Field | Value |
|---|---|
| id | RB-REL0-003 |
| severity | `warning` |
| category | governance staleness |
| paths | `PACKAGE-MANIFEST.yaml` (`current_build_package`, `next_build_package`, `wp12c_current_state` block, in particular lines 16–56) |
| evidence | Lines 16–23: `current_build_package.build_package_number: "12C-ED1"`, `build_package_status: active_editor_readability_pass`; `next_build_package.build_package_number: "12C-L3"`, `build_package_status: blocked_pending_qa1_blocker_register_closure_rb_001_through_rb_005`. Line 50: `wp12c_ed1_status: ACTIVE`. `validation/package-12c-editor-readability-report.md` records `WP-12C-ED1_READABILITY_PUBLIC_SAFETY_PASS_READY_FOR_L3_PLAN` (closed). REL0-B has been committed (`794815d9…`). REL0-QA (this work package) is the active gate. The manifest still describes ED1 as active and L3 as next, which is inconsistent with the closed-ED1 and committed-REL0-B reality. |
| impact | Public readers who inspect `PACKAGE-MANIFEST.yaml` see ED1 as the current gate. This is misleading and contradicts the v0.1.2 release-framing in `RELEASE-MANIFEST.yaml` `next_gates[]` (which lists REL0-B and REL0-QA explicitly). |
| proposed owner | WP-12C-REL0-C / WP-12C-ED2 |
| gate blocked | WP-12C-REL0 closure; WP-13 unblock |
| remediation | Update `current_build_package` to `12C-REL0-QA` (or to the active REL0-C micro-patch when that opens). Set `wp12c_ed1_status: BLACK_CLOSED`, `wp12c_rel0_b_status: BLACK_CLOSED`, `wp12c_rel0_qa_status: BLACK_CLOSED_PARTIAL_WITH_GAPS` (after this report is accepted), and `wp12c_rel0_c_status: ACTIVE` (or the chosen REL0-C / ED2 designator). Update `next_build_package` accordingly. Re-run validators after the edit and confirm 0 FAIL. |
| seeded | no |

---

## RB-REL0-004 — `README.md` "Next Build Package" frames BP13 only against `BP12-SAMPLE-DFD-BLOCKER`, not against the v0.1.2 release gate

| Field | Value |
|---|---|
| id | RB-REL0-004 |
| severity | `warning` |
| category | governance staleness / public-reader clarity |
| path | `README.md` ("Build Order" and "Next Build Package" sections) |
| evidence | Last two sections of `README.md`: `The next allowed Build Package after Build Package 12 is **Build Package 13 — Diagrams**, but Build Package 13 is **BLOCKED** until \`BP12-SAMPLE-DFD-BLOCKER\` is resolved via founder-approved Package 10A / 11A correction OR sample-002 with a clean DFD is authorized.` This is internally consistent with the validation taxonomy (`validation/diagram-readiness-pre-render-checklist.md`, `validation/README.md` BLOCKERS section), but `RELEASE-MANIFEST.yaml` `next_gates[]` orders WP-13 behind `WP-12C-REL0` closure, and `docs/ROADMAP.md` §§1, 2, 6 frame WP-13 release visuals after WP-12C-REL0 closure. The two framings are valid in their own taxonomies but a public reader sees only the BP13 / sample-DFD framing in `README.md`. |
| impact | Public reader is told only one of the two preconditions for WP-13. The v0.1.2 release gate is more proximate (REL0 closure is the active gate; the BP13 sample-DFD readiness check is a separate, downstream readiness gate). |
| proposed owner | WP-12C-REL0-C / WP-12C-ED2 |
| gate blocked | WP-12C-REL0 closure; WP-13 unblock |
| remediation | Reframe the section as: "Next Build Package: WP-12C-REL0-C (focused doc-only micro-patch) → WP-12C-REL0 closure → WP-13 release visuals (still subject to `BP12-SAMPLE-DFD-BLOCKER` resolution per `validation/diagram-readiness-pre-render-checklist.md`)." Preserve the existing `BP12-SAMPLE-DFD-BLOCKER` link. |
| seeded | no |

---

## RB-REL0-005 — Validator `$validationAllowed` does not yet enumerate the two REL0-QA report filenames

| Field | Value |
|---|---|
| id | RB-REL0-005 |
| severity | `warning` |
| category | transitional validator allow-list (anticipated, not yet emitted) |
| path | `tools/Test-AisrafPackage.ps1` `$validationAllowed` appendage; current state at lines 1432–1434 enumerates only `package-12c-release-qa-report.md`, `package-12c-release-blocker-register.md`, `package-12c-editor-readability-report.md` |
| evidence | This work package writes `validation/package-12c-rel0-final-release-qa-report.md` and `validation/package-12c-rel0-final-release-blocker-register.md`. Neither filename appears in `$validationAllowed`. On the next `Test-AisrafPackage.ps1` run after these reports exist, Check `11-validation-allowed` will FAIL with two entries: *"Unexpected file in validation/ at Build Package 12: validation/package-12c-rel0-final-release-qa-report.md"* and *"Unexpected file in validation/ at Build Package 12: validation/package-12c-rel0-final-release-blocker-register.md"*. Identical pattern to QA1 RB-005. |
| impact | Next `Test-AisrafPackage.ps1` invocation will FAIL until the micro-patch lands. Validator FAIL is itself the only impact; no release-surface drift, no overclaim, no secret leak, no protected-surface drift. |
| proposed owner | WP-12C-REL0-C (or REL0-PATCH-A: minimal allow-list-only micro-patch under the BP12A `tracked-drift` governance, identical in pattern to QA1-PATCH-A) |
| gate blocked | next `Test-AisrafPackage.ps1` invocation |
| remediation | Add the two filenames to the `$validationAllowed` appendage (two-line addition). The same change must propagate to the bundle copy at `plugins/aisraf-copilot-plugin/bundle/tools/Test-AisrafPackage.ps1` and the bundle checksum manifest must be regenerated via `tools/Build-AisrafCopilotPluginBundle.ps1 -Clean` (the documented K3C pattern). After the patch, re-run all four validators and confirm 0 FAIL. |
| seeded | no |
| rel0_qa_constraint_note | REL0-QA cannot land this patch itself — the task spec forbids REL0-QA from editing validators, tools, or hooks. Documenting and routing is the QA agents' authorized action. |

---

## Carry-Forward (Not New Findings Of This Work Package)

These items predate REL0-QA and are tracked elsewhere; included here for completeness so a reader of this register sees the full release-readiness state.

| id | severity | path | owner | tracking |
|---|---|---|---|---|
| RB-001 (QA1) | `warning` | `runs/RUN-SMOKE-LOCAL-001/` | WP-12C-L3 | `validation/package-12c-release-blocker-register.md`; also `RELEASE-MANIFEST.yaml` `known_warnings[].KW-001`; folder is `.git/info/exclude`-ignored. |
| RB-002 (QA1) | `warning` | `runs/RUN-SMOKE-PLUGIN-L2B-001/` | WP-12C-L3 | `validation/package-12c-release-blocker-register.md`; also `RELEASE-MANIFEST.yaml` `known_warnings[].KW-002`; folder is `.git/info/exclude`-ignored. |
| `BP12-SAMPLE-DFD-BLOCKER` | hard, owner founder | `samples/sample-001-dfd-crop/inputs/dfd-crop.{png,mmd}` and the byte-copies under `runs/RUN-001/inputs/` | founder via Package 10A / 11A correction or sample-002 authorization | `validation/README.md` BLOCKERS section; `validation/sample-input-readiness-checklist.md`; `validation/diagram-readiness-pre-render-checklist.md`; remains the readiness precondition for BP13 / WP-13 chain execution beyond REL0 closure. |

---

## Summary

| severity | count (this register) |
|---|---|
| blocker | 0 |
| warning | 5 |
| info | 0 |

No `blocker`-severity items. No FAIL-class drift. No autonomy or AI-component-pattern overclaim. No live-integration overclaim. No secret or personal-path leak. No protected-surface drift. WP-12C-REL0-C may proceed (plan-then-execute doc-only micro-patch); WP-12C-REL0 closure follows; WP-13, WP-ORCH0, and all AL4 adapter work remain blocked / future per the release manifest and `docs/ROADMAP.md`.

This register contains no Jira, Confluence, Lucidchart, MCP, Rovo, Anthropic Claude runtime, Azure AI Foundry, Google ADK, Microsoft Agent Framework, database, Terraform, cloud-runtime, event-bus, telemetry, or external post-back execution claim. No multi-agent runtime is claimed. No production-readiness is claimed. No release is authorized. No git stage is performed. No push is performed. No diagram is created.
