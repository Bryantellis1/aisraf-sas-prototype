# WP-12C-QA1 — Release Blocker Register (Gap Detail)

| Field | Value |
|---|---|
| Work package | WP-12C-QA1 — Release QA And Blocker Report |
| Companion report | `validation/package-12c-release-qa-report.md` |
| Agent | AG-AISRAF-PACKAGE-QA-VALIDATOR-R1 |
| Mode | Audit-only. The QA agent records gaps; it does not remediate them. |
| Severity legend | `blocker` (must close before the named gate) / `warning` (must close before the named gate, but does not gate the immediately-next ED1 step) / `info` |
| Gate column | The first gate the entry blocks. ED1 is plan-only and is not blocked by `warning`-class entries unless explicitly stated. |
| Owner column | The work package or micro-patch that owns the remediation. |

This register is the detail layer for §13 of `validation/package-12c-release-qa-report.md`. Severity, owner, and gate decisions in this register override any informal mention elsewhere.

---

## RB-001 — Smoke folder `runs/RUN-SMOKE-LOCAL-001/` present

| Field | Value |
|---|---|
| id | RB-001 |
| severity | `warning` |
| category | `git-hygiene` |
| path | `runs/RUN-SMOKE-LOCAL-001/` |
| evidence | `Test-AisrafPackage.ps1` Check `14-runs-readme-only` WARN: *"runs/RUN-SMOKE-LOCAL-001/ exists alongside the governed RUN-001 fixture. Build Package 03 must remove smoke run folders before human git stage."* |
| proposed_owner_wp | WP-12C-L3 |
| gate_blocked | L3 staging |
| remediation | Delete the smoke folder during L3 staging preparation, or relocate per a future founder-approved smoke-evidence policy. QA agent must not delete the folder itself (QA spec §5 item 12). |
| seeded | yes (QA spec §17 RB-001 known-warning seed) |

## RB-002 — Smoke folder `runs/RUN-SMOKE-PLUGIN-L2B-001/` present

| Field | Value |
|---|---|
| id | RB-002 |
| severity | `warning` |
| category | `git-hygiene` |
| path | `runs/RUN-SMOKE-PLUGIN-L2B-001/` |
| evidence | `Test-AisrafPackage.ps1` Check `14-runs-readme-only` WARN: *"runs/RUN-SMOKE-PLUGIN-L2B-001/ exists alongside the governed RUN-001 fixture. Build Package 03 must remove smoke run folders before human git stage."* |
| proposed_owner_wp | WP-12C-L3 |
| gate_blocked | L3 staging |
| remediation | L2B controlled-output evidence is captured. Before L3 staging, either remove the smoke folder or apply a founder-approved smoke-evidence retention policy (e.g., move evidence out of `runs/` into a long-term evidence area). Until L3, the folder remains as the L2B closeout artifact. |
| seeded | no (new at QA1; companion to RB-001) |

## RB-003 — Manifest / Charter / Build-Order language lags BP12C-MP1 trajectory

| Field | Value |
|---|---|
| id | RB-003 |
| severity | `warning` |
| category | `manifest`, `solution-alignment` |
| paths | `PACKAGE-MANIFEST.yaml` (`current_build_package`, `next_build_package`, `wp12c_current_state` block), `BUILD-ORDER.md` (WP-12C K/L gate overlay table), `PROTOTYPE-CHARTER.md` (Plugin Gate Principle paragraph) |
| evidence | `PACKAGE-MANIFEST.yaml` lines 16–42 declare `current_build_package: 12C-K1B-A`, `next_build_package: 12C-K1B-B`, `wp12c_k2_status: BLOCKED`, `wp12c_l_status: BLOCKED`. `BUILD-ORDER.md` lines 21–31 mark K1B-A..K4 as BLACK / CLOSED but still list `WP-12C-L0 \| NEXT` and `WP-12C-L1/L2/L3 \| BLOCKED` — L2B has executed and QA1 has opened. `PROTOTYPE-CHARTER.md` lines 52–55 still read *"`plugins/` must not be created until the validator allow-list patch passes in WP-12C-K1B-B / K2 scope"* even though `plugins/aisraf-copilot-plugin/` exists and is validator-gated (Check 16/16a/16b/16c PASS). |
| proposed_owner_wp | WP-12C-ED1 |
| gate_blocked | L3 staging |
| remediation | ED1 updates the three documents to record the BP12C-MP1 trajectory (K2/K3/K3C complete; L2B-PLAN and L2B-EXEC complete; QA1 opened) and reframes the `plugins/` language as "governed and validator-gated" rather than "must not be created." QA agent does not edit these documents (QA spec §8). |
| seeded | no |

## RB-004 — `package-12c-plugin-install-and-publication-checklist.md` frontmatter is stale

| Field | Value |
|---|---|
| id | RB-004 |
| severity | `warning` |
| category | `logging-evidence`, `documentation` |
| path | `validation/package-12c-plugin-install-and-publication-checklist.md` (YAML frontmatter and §2 gate table) |
| evidence | Frontmatter: `work_package: WP-12C-L0`, `parent_status: WP-12C-K_PACKAGE_COMPLETE_READY_FOR_INSTALL_READINESS_PREFLIGHT`, `lifecycle_status: packaged_not_installed`, `install_status: not_started`, `interactive_smoke_status: not_started`. L2B-EXEC-RETRY has been performed under `runs/RUN-SMOKE-PLUGIN-L2B-001/` and the closeout report records local-installed/discoverable posture. The §2 gate table reflects the same pre-L2B state. |
| proposed_owner_wp | WP-12C-ED1 |
| gate_blocked | L3 staging |
| remediation | ED1 refreshes the frontmatter and §2 table to record the current L2B-EXEC-RETRY completion and QA1 entry posture. Do not delete the checklist; align it. |
| seeded | no |

## RB-005 — Validator allow-list does not yet name the QA1 report files

| Field | Value |
|---|---|
| id | RB-005 |
| severity | `warning` |
| category | `validator-failure` (anticipated, not yet emitted) |
| path | `tools/Test-AisrafPackage.ps1` `$validationAllowed` appendage around lines 1402–1411 |
| evidence | The QA1 work package writes `validation/package-12c-release-qa-report.md` and `validation/package-12c-release-blocker-register.md`. Neither filename appears in the `$validationAllowed` array nor in the BP12C appendage (which currently ends at line 1410 with `'package-12c-l2b-closeout-plugin-discovery-report.md'`). On the next run of `Test-AisrafPackage.ps1` after these two reports exist, Check `11-validation-allowed` will FAIL with two entries: *"Unexpected file in validation/ at Build Package 12: validation/package-12c-release-qa-report.md"* and *"Unexpected file in validation/ at Build Package 12: validation/package-12c-release-blocker-register.md"*. |
| proposed_owner_wp | QA1-PATCH-A (a minimal allow-list-only micro-patch under the BP12A `tracked-drift` governance, identical in pattern to the L2B closeout's surgical addition at line 1410) or the first ED1 step. |
| gate_blocked | next `Test-AisrafPackage.ps1` invocation; ED1 should run the validators first thing and will trip this check until the micro-patch lands. |
| remediation | Add the two filenames to the `$validationAllowed` appendage (two-line addition). The same change must propagate to the bundle copy at `plugins/aisraf-copilot-plugin/bundle/tools/Test-AisrafPackage.ps1` and the bundle checksum manifest must be regenerated via `tools/Build-AisrafCopilotPluginBundle.ps1 -Clean` (the documented K3C pattern). |
| seeded | no |
| qa1_constraint_note | QA1 cannot land this patch itself — the task spec forbids QA1 from editing tools or hooks. Documenting and routing is the QA agent's authorized action. |

---

## Summary

| severity | count |
|---|---|
| blocker | 0 |
| warning | 5 |
| info | 0 |

No `blocker`-severity items. No FAIL-class drift. ED1 may proceed (plan-only authoring). L3, REL0, and WP-13 remain blocked until the register closes.

This register contains no Jira, Confluence, Lucidchart, MCP, Foundry, ADK, MAF, database, Terraform, cloud-runtime, event-bus, telemetry, or external post-back execution claim. No multi-agent runtime is claimed. No release is authorized. No git staging is performed.
