# WP-12C-AM3 — Risk Register

| Field | Value |
|---|---|
| Work package family | WP-12C-AM3 (PLAN → CONTRACTS → RUNTIME → EVIDENCE) |
| This document | Risk register for the full AM3 lane. |
| Severity scale | LOW / MEDIUM / HIGH / CRITICAL |
| Likelihood scale | LOW / MEDIUM / HIGH |
| Posture | Each risk has an owning agent, a mitigation, a detection signal, and the validator or evidence row that catches it. |

This register identifies the failure modes that would invalidate the AM3 lane. It is consulted at every AM3 gate. New risks discovered in CONTRACTS, RUNTIME, or EVIDENCE are appended in their own WP and re-confirmed against this register.

---

## 1. R-AM3-01 — AM3 Becomes AM4 By Accident

**Description.** A specialist handoff, an event field, the runner code, or a contract field allows an external destination URL, a Jira/Confluence/Lucidchart/MCP/cloud/database reference, or any network call. AM3 silently crosses into AM4 territory.

| Property | Value |
|---|---|
| Severity | CRITICAL |
| Likelihood | MEDIUM (developer ergonomics tempt the inclusion of an "optional" destination URL field) |
| Owning agent | AG-AISRAF-SECURITY-OVERCLAIM-GUARD-R1 |
| Mitigation | Handoff schema `additionalProperties: false`; closed event-type enumeration; closed connector-status enumeration in the run profile schema; explicit forbidden-pattern scan in `Test-AisrafAm3Runtime.ps1` (AM3-T5). Static scan of the runner for `Invoke-WebRequest` / `Invoke-RestMethod` / `curl` / `wget`. |
| Detection | AM3-T5 (no-external-execution proof) and AM3-T1 (scaffold validation) both FAIL. |
| Trigger to revert / halt | Any AM3-T5 FAIL halts the AM3 lane until the offending field is removed and the schema is tightened. |

## 2. R-AM3-02 — AM3 Claimed Before AM3-EVIDENCE Closes

**Description.** A document, manifest field, or roadmap entry asserts AISRAF v0.1.2 has AL3 / AM3 before the WP-12C-AM3-EVIDENCE smoke run has been executed and accepted.

| Property | Value |
|---|---|
| Severity | HIGH |
| Likelihood | MEDIUM (early enthusiasm to update positioning) |
| Owning agent | AG-AISRAF-RELEASE-MANAGER-R1, AG-AISRAF-SECURITY-OVERCLAIM-GUARD-R1 |
| Mitigation | DoD §1 forbids raising `current_autonomy_level` above AL2 until AM3-EVIDENCE closes. `Test-AisrafPackage.ps1` overclaim guard scans for "AL3 implemented" / "AM3 implemented" claims in any AM3 lane file before EVIDENCE closes. |
| Detection | AM3-T6 (no-overclaim proof) FAILs. |
| Trigger to revert / halt | Any AM3-T6 FAIL halts the gate; the offending claim is removed before the gate may reopen. |

## 3. R-AM3-03 — AM4 Adapter Work Starts Inside AM3

**Description.** Under time pressure or scope creep, AM4 adapter scaffolding (Jira intake, Confluence post-back, Lucidchart adapter, MCP adapter, cloud runtime, database, Terraform, event bus, telemetry) is begun inside the AM3 lane.

| Property | Value |
|---|---|
| Severity | HIGH |
| Likelihood | LOW (founder direction explicitly defers AM4) |
| Owning agent | AG-AISRAF-RELEASE-MANAGER-R1 |
| Mitigation | The AM3 PLAN §10 file list is exhaustive; no file outside that list is authorized in WP-12C-AM3-PLAN. Each later gate (CONTRACTS, RUNTIME, EVIDENCE) updates its own authorized file list and the BP12A drift allow-list policy with the same exact-path discipline. No `adapters/` or `connectors/` directory is created. |
| Detection | `Test-AisrafBp12AReadiness.ps1` tracked-drift FAIL on any unexpected path; package surface validator FAIL on unrecognized top-level folder. |
| Trigger to revert / halt | Any unauthorized AM4 path halts the gate; the path is removed before the gate may reopen. |

## 4. R-AM3-04 — Canonical Or Projection Surface Drift Under AM3 Work

**Description.** AM3 implementation accidentally edits `prompts/`, `skills/`, `prototype-agents/`, `templates/`, `catalogs/`, `blueprints/`, `config/` (beyond the four new AM3 schemas), `samples/`, `runs/RUN-001/`, or any provider projection surface.

| Property | Value |
|---|---|
| Severity | HIGH |
| Likelihood | MEDIUM (refactors during runtime authoring can drift) |
| Owning agent | AG-AISRAF-VERSION-CONTROL-HYGIENE-R1, AG-AISRAF-ARCHITECTURE-TRACEABILITY-R1 |
| Mitigation | DoD §1.11 requires canonical / projection / RUN-001 / samples byte-unchanged check at every AM3 gate. `git diff` checks are recorded in each gate's closeout report. |
| Detection | BP12A tracked-drift FAIL on any unauthorized path; canonical surface diff non-empty. |
| Trigger to revert / halt | Halt the gate; restore the drifted file; re-run validators before the gate may reopen. |

## 5. R-AM3-05 — Sensitive Data Leakage Into Runtime Artifacts

**Description.** A specialist response, event log entry, run-state field, or handoff file embeds a credential, an email address, a customer-identifying string, an internal hostname, or a destination URL.

| Property | Value |
|---|---|
| Severity | CRITICAL |
| Likelihood | MEDIUM (rich runtime artifacts are tempting places to dump context) |
| Owning agent | AG-AISRAF-SECURITY-OVERCLAIM-GUARD-R1 |
| Mitigation | The handoff response schema requires a sensitive-data screen result (PASS only) per step. The AM3 validator route scans all runtime artifacts for forbidden patterns. The run profile must affirm `sensitive_data_confirmed_redacted: true`. `config/sensitive-data-rules.md` applies. |
| Detection | AM3-T5 FAIL or AM3-T3 FAIL on the sensitive-data screen field. |
| Trigger to revert / halt | Halt the run; scrub the artifact; the run is not eligible for evidence acceptance. |

## 6. R-AM3-06 — Human Gate Bypassed By The Runtime

**Description.** The local AM3 runner advances past a PRA-01 §8 human gate or past the final decision gate without recording paired `gate_request` / `gate_decision` events.

| Property | Value |
|---|---|
| Severity | HIGH |
| Likelihood | LOW (default runtime design is explicit pause; bug-shaped risk) |
| Owning agent | AG-AISRAF-ARCHITECTURE-TRACEABILITY-R1 |
| Mitigation | The orchestrator contract names the five required gates. The AM3 validator (AM3-T2) requires paired `gate_request` / `gate_decision` events at each named gate before `current_step` may advance. |
| Detection | AM3-T2 FAIL on missing gate_request / gate_decision pair. |
| Trigger to revert / halt | Halt the run; flag the bypass; the runner is patched before re-execution. |

## 7. R-AM3-07 — State / Event Log Divergence

**Description.** The run-state file's `current_step`, `last_completed_step`, or `last_checkpoint_id` falls out of sync with the events.ndjson tail.

| Property | Value |
|---|---|
| Severity | MEDIUM |
| Likelihood | MEDIUM (concurrent writes; partial writes during interrupt) |
| Owning agent | AG-AISRAF-ARCHITECTURE-TRACEABILITY-R1 |
| Mitigation | Run-state writes follow event log writes (event-first ordering). Validator AM3-T2 cross-checks `run-state.last_checkpoint_id` against the final event id and `run-state.current_step` against the last orchestrator_decision. |
| Detection | AM3-T2 FAIL on state / event divergence. |
| Trigger to revert / halt | Halt the run; reconstruct state from events; replay only after divergence root cause is found. |

## 8. R-AM3-08 — Smoke Run Folder Leaks Into Release Staging

**Description.** `runs/RUN-SMOKE-AM3-001/` is accidentally staged or committed, causing release surface drift.

| Property | Value |
|---|---|
| Severity | MEDIUM |
| Likelihood | LOW (gitignore posture for `runs/RUN-SMOKE-*/` already in place per L2B pattern) |
| Owning agent | AG-AISRAF-VERSION-CONTROL-HYGIENE-R1 |
| Mitigation | The AM3 smoke run folder follows the existing `runs/RUN-SMOKE-*/` exclusion pattern. `git check-ignore` is recorded at each gate close. |
| Detection | BP12A tracked-drift FAIL on the smoke run path. |
| Trigger to revert / halt | Unstage; restore gitignore; the gate may not close until clean. |

## 9. R-AM3-09 — Plugin Bundle Drift From AM3 Validator Additions

**Description.** The AM3 validator (`Test-AisrafAm3Runtime.ps1`) and AM3 runner (`Invoke-AisrafAm3LocalRun.ps1`) are added to `tools/` but the plugin bundle copy and bundle checksum manifest are not regenerated.

| Property | Value |
|---|---|
| Severity | MEDIUM |
| Likelihood | MEDIUM (easy to forget the bundle rebuild step) |
| Owning agent | AG-AISRAF-VERSION-CONTROL-HYGIENE-R1, AG-AISRAF-RELEASE-MANAGER-R1 |
| Mitigation | Every AM3 gate that adds or modifies a file under `tools/` regenerates the bundle via `tools/Build-AisrafCopilotPluginBundle.ps1 -Clean` and confirms the bundle checksum manifest matches source SHA-256. |
| Detection | `Test-AisrafPackage.ps1` Check 16-related plugin-bundle checks FAIL on mismatched SHA-256. |
| Trigger to revert / halt | Re-run the bundle builder; re-confirm the manifest; gate stays open until checksums match. |

## 10. R-AM3-10 — Closed-Loop Autonomy Claimed By Implication

**Description.** AM3 evidence or AM3 plan language implies the orchestrator may proceed without a human gate ("automatically advances", "auto-resumes", "headless mode"), implying AL5 closed-loop autonomy.

| Property | Value |
|---|---|
| Severity | HIGH |
| Likelihood | LOW (founder direction is explicit) |
| Owning agent | AG-AISRAF-SECURITY-OVERCLAIM-GUARD-R1 |
| Mitigation | AM3 plan documents and DoD explicitly forbid headless / unattended advancement. The orchestrator contract requires gate_request / gate_decision pairs. AM3-T6 scans for autonomy-implying phrases. |
| Detection | AM3-T6 FAIL on autonomy-implying phrase or absent gate pair. |
| Trigger to revert / halt | Halt the gate; rewrite the phrase; remove the autonomy implication. |

## 11. R-AM3-11 — Schema Versioning Drift From Run Profile Schema

**Description.** AM3 schemas use a version pin (`v0_1_2`) that does not match the existing `run-profile.v0_1_2` package_version pin, causing version inconsistency across `config/`.

| Property | Value |
|---|---|
| Severity | LOW |
| Likelihood | LOW |
| Owning agent | AG-AISRAF-ARCHITECTURE-TRACEABILITY-R1 |
| Mitigation | All four AM3 schemas pin `schema_version: <name>.v0_1_2` and `package_version: v0.1.2`, identical to the run-profile schema convention. The package validator confirms consistent version pinning across `config/`. |
| Detection | Package surface validator FAIL on version mismatch. |
| Trigger to revert / halt | Re-pin schema versions; re-run validator. |

## 12. R-AM3-12 — Roadmap / Manifest / Plan Documents Drift Out Of Sync

**Description.** `docs/ROADMAP.md`, `PACKAGE-MANIFEST.yaml`, and the four AM3 plan documents tell three different stories about whether AM3 is current, in-lane, or future.

| Property | Value |
|---|---|
| Severity | MEDIUM |
| Likelihood | MEDIUM (multiple files updated in different WPs) |
| Owning agent | AG-AISRAF-RELEASE-MANAGER-R1 |
| Mitigation | At each AM3 gate close, the closure register cross-references the canonical positioning across roadmap, manifest, and plan documents. `current_autonomy_level`, `target_autonomy_level_for_v0_1_2`, and the roadmap section headings must agree. |
| Detection | Manual cross-read during gate close; AM3-T6 scans for inconsistent claims. |
| Trigger to revert / halt | Reconcile the documents before the gate may close. |

## 13. Cross-Cutting Posture

- All risks above are detectable by the five-validator ladder plus the AM3 validator route (AM3-T1 through AM3-T6), and by `git diff` checks at each gate.
- No risk on this register is mitigated by adding an AM4 capability "just in case." AM4 is deferred.
- No risk on this register is mitigated by adding closed-loop autonomy. AL5 is out of scope.
- New risks discovered during CONTRACTS / RUNTIME / EVIDENCE are appended here in their own WP. This register is the single AM3 risk source.

## 14. Risk Acceptance Posture For This WP

WP-12C-AM3-PLAN accepts the residual risk that:

- The four plan documents may need minor wording updates when CONTRACTS authors the YAML schemas. Such updates are explicit, gated, and tracked.
- The risk register itself may need a new entry when the runner is implemented. The CONTRACTS or RUNTIME WP appends it; the register is not re-authored from scratch.

No CRITICAL or HIGH risk is accepted as "live" by WP-12C-AM3-PLAN. All CRITICAL / HIGH risks above have a named mitigation, a named detection, and a named halt trigger.
