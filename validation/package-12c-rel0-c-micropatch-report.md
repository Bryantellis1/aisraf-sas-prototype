# WP-12C-REL0-C — Public Entrypoint, Manifest State, And REL0-QA Allow-List Micro-Patch Report

| Field | Value |
|---|---|
| Work package | WP-12C-REL0-C — Public Entrypoint, Manifest State, And REL0-QA Allow-List Micro-Patch |
| Mission | Close the five REL0-QA warning-class gaps (RB-REL0-001..005) using the smallest possible patch. Update only public entrypoints, manifest state, and the exact validation allow-list entries needed for REL0-QA reports. Rebuild the plugin bundle/checksum only because `tools/Test-AisrafPackage.ps1` is bundled. |
| Predecessor accepted state | `WP-12C-REL0_QA_PARTIAL_WITH_GAPS` (REL0-QA closed with five warning-class entries documented in `validation/package-12c-rel0-final-release-blocker-register.md`). |
| Agents | `AG-AISRAF-REPOSITORY-EDITOR-R1`, `AG-AISRAF-VERSION-CONTROL-HYGIENE-R1`, `AG-AISRAF-SECURITY-OVERCLAIM-GUARD-R1`, `AG-AISRAF-RELEASE-MANAGER-R1` |
| Current release truth | AISRAF v0.1.2 is an AL2 controlled-output local security architecture review workbench. AL3 orchestrated multi-agent runtime is future WP-ORCH. AL4 external adapter / post-back execution is future adapter work. AL5 closed-loop autonomy is out of scope. |

This report is the closure artifact for WP-12C-REL0-C. It records the exact micro-edits made for each of the five REL0-QA warning-class entries (RB-REL0-001..005), the bundle rebuild, the four-validator results, the git-hygiene posture, and the one new gap surfaced by the patch itself (the BP12A `tracked-drift` allow-list extension that the explicit allowed-edits list for this work package did not include).

---

## 1. RB-REL0-001 — `README.md` public-reader staleness

**Status:** closed.

**Edit:** prepended a new "v0.1.2 Release — Read First" section to `README.md` immediately after the package preamble. The new section names AISRAF v0.1.2 as an AL2 controlled-output local workbench, lists the seven public-reader entrypoints (`docs/AISRAF-PRIMER.md`, `docs/OPERATOR-QUICKSTART.md`, `docs/SECURITY-REVIEW-WORKFLOW.md`, `docs/ARCHITECTURE-OVERVIEW.md`, `docs/ROADMAP.md`, `RELEASE-MANIFEST.yaml`, `CHANGELOG.md`), enumerates the four autonomy levels (AL2 current; AL3 future WP-ORCH0; AL4 future adapters; AL5 out of scope), and frames WP-13 as blocked until WP-12C-REL0 closes plus `BP12-SAMPLE-DFD-BLOCKER` resolution. The internal-build-document narrative (Build Packages 01–12 enumeration, BP12-SAMPLE-DFD-BLOCKER detail, build-order, etc.) is preserved under a clearly-labelled "Contributor / Governance Reading" subsection. The "Current State" line "Build Packages 01–12 are active … pending human review before commit" is replaced with a statement that BP12C through WP-12C-REL0-B is committed, REL0-QA is closed with documented gaps, and REL0-C is the active gate.

**Files changed:** `README.md`.

---

## 2. RB-REL0-002 — `START-HERE.md` public-reader staleness

**Status:** closed.

**Edit:** prepended a "v0.1.2 Release — Read First" section to `START-HERE.md` immediately after the package preamble. The section names the current autonomy posture (AL2 current; AL3, AL4 future; AL5 out of scope) and routes readers by role: new evaluator → `docs/AISRAF-PRIMER.md`; operator → `docs/OPERATOR-QUICKSTART.md`; security architect → `docs/SECURITY-REVIEW-WORKFLOW.md`; maintainer → `docs/ARCHITECTURE-OVERVIEW.md` plus `RELEASE-MANIFEST.yaml`; roadmap reader → `docs/ROADMAP.md`. The previous "Operator Steps" list (which pointed only at internal package-build docs) is preserved verbatim under a relabelled "Contributor / Package Authoring — Operator Steps" subsection. The "Next Build Package" section is updated to lead with WP-12C-REL0-C → REL0 closure → WP-13 release visuals (still gated by `BP12-SAMPLE-DFD-BLOCKER`) and to record WP-ORCH0 and AL4 adapter work as future.

**Files changed:** `START-HERE.md`.

---

## 3. RB-REL0-003 — `PACKAGE-MANIFEST.yaml` governance staleness

**Status:** closed.

**Edit:** updated three blocks of `PACKAGE-MANIFEST.yaml` in place. `current_build_package` is now `12C-REL0-C` (Public Entrypoint, Manifest State, And REL0-QA Allow-List Micro-Patch; status `active_rel0_c_micropatch_for_rb_rel0_001_through_005`). `next_build_package` is now `12C-REL0-CLOSE` (Founder-Authorized Public Release Gate Closure; status `blocked_pending_rel0_c_micropatch_completion`). Inside `wp12c_current_state`: `active_work_package` is now `WP-12C-REL0-C`; `accepted_status_through` is now `WP-12C-REL0_QA_PARTIAL_WITH_GAPS`; `wp12c_ed1_status` and `wp12c_l3_status` are moved to `BLACK_CLOSED`; new keys `wp12c_rel0_b_status: BLACK_CLOSED_STAGE_COMMIT_PASS`, `wp12c_rel0_qa_status: BLACK_CLOSED_PARTIAL_WITH_GAPS`, and `wp12c_rel0_c_status: ACTIVE` are added; `wp12c_rel0_status` is updated to `BLOCKED_PENDING_REL0_C_CLOSURE`; `wp13_status` is updated to `BLOCKED_PENDING_REL0_CLOSURE_AND_BP12_SAMPLE_DFD_BLOCKER_RESOLUTION`; new keys `adapter0_status: FUTURE_NOT_IN_V0_1_2_SCOPE_AL4_NOT_CURRENT_RELEASE`, `al4_status: future_external_adapter_post_back_execution_not_current_release`, and `al5_status: out_of_scope_for_v0_1_x` are added. `current_autonomy_level` (AL2) and `future_autonomy_level` (AL3 WP-ORCH) are preserved verbatim. `current_gate` and `next_gate` are updated to reflect the REL0-C → REL0 closure → WP-13 framing. `diagrams_status` is updated to `blocked_until_rel0_closes_and_bp12_sample_dfd_blocker_resolved`.

**Files changed:** `PACKAGE-MANIFEST.yaml`.

---

## 4. RB-REL0-004 — `README.md` next-build-package framing staleness

**Status:** closed.

**Edit:** the old "Build Order" + "Next Build Package" tail of `README.md` is replaced with a "Next Build Package" section that orders the gates as WP-12C-REL0-C → WP-12C-REL0 closure → Build Package 13 release visuals (still separately gated by `BP12-SAMPLE-DFD-BLOCKER` per `validation/diagram-readiness-pre-render-checklist.md`). A separate paragraph names WP-ORCH0 (future AL3) and AL4 adapter work (Jira, Confluence, Lucidchart, Rovo, MCP, Foundry, ADK, MAF, database, Terraform, cloud, event bus, telemetry, post-back execution) as future and not current release behavior. The original `BP12-SAMPLE-DFD-BLOCKER` link is retained for contributor accuracy. The "Not Yet Created" list is updated to record: no release visuals; no multi-agent runtime; no external adapters; no chain execution against RUN-001; no numeric accuracy score; no runtime / cloud / MCP / Jira / Confluence / Lucidchart / Rovo / Foundry / ADK / MAF / database / Terraform / event-bus / telemetry proof.

**Files changed:** `README.md` (combined with RB-REL0-001 edits in the same file).

---

## 5. RB-REL0-005 — Validator `$validationAllowed` missing the REL0-QA report filenames

**Status:** closed.

**Edit:** `tools/Test-AisrafPackage.ps1` `$validationAllowed` append-list is extended with three exact filenames (no wildcards, no loosening of folder rules, no logic change): `package-12c-rel0-final-release-qa-report.md`, `package-12c-rel0-final-release-blocker-register.md`, and `package-12c-rel0-c-micropatch-report.md` (this REL0-C report itself). The plugin-bundle copy at `plugins/aisraf-copilot-plugin/bundle/tools/Test-AisrafPackage.ps1` and the bundle checksum manifest at `plugins/aisraf-copilot-plugin/bundle-checksum-manifest.yaml` are regenerated only via `tools/Build-AisrafCopilotPluginBundle.ps1 -Clean` (the documented K3C pattern). No other validator file is edited.

**Files changed:** `tools/Test-AisrafPackage.ps1`. **Files regenerated by bundle builder:** `plugins/aisraf-copilot-plugin/bundle/tools/Test-AisrafPackage.ps1`, `plugins/aisraf-copilot-plugin/bundle-checksum-manifest.yaml`.

---

## 6. New gap surfaced by REL0-C — BP12A `tracked-drift` allow-list does not enumerate `README.md` or `START-HERE.md`

**Status:** open. Documented as RB-REL0-C-006 in this report for follow-on micro-patch.

**Detail:** `tools/Test-AisrafBp12AReadiness.ps1` enforces an exact-path allow-list (`$allowedTrackedDriftExact`) for tracked drift. Every prior work package that touched root governance or surface files extended that allow-list in lock-step with its edits (`$wp12cK1bAuthorityPatchDrift`, `$wp12cApprovedPluginScaffoldDrift`, `$wp12cL1aProviderInstallSurfaceDrift`, `$wp12cK3bValidatorPatchDrift`, `$wp12cK3cExactFutureDrift`, `$wp12cL0InstallReadinessDrift`). REL0-C is authorized by the founder to edit `README.md` and `START-HERE.md`, but neither file is in the BP12A allow-list and the work-package brief did not authorize edits to `tools/Test-AisrafBp12AReadiness.ps1`. Consequently `Test-AisrafBp12AReadiness.ps1` emits one FAIL row: `01-git-workspace / tracked-drift / Unexpected tracked drift: README.md, START-HERE.md`. All other 76 BP12A checks PASS, including `02-package-surface / package-validator` (Test-AisrafPackage.ps1 returned 83 PASS, 2 WARN, 0 FAIL), `03-run-profile / execution-ready` (RUN-001 12 PASS, 0 FAIL), `04-agent-projection`, `05-prompt-registry`, `06-skill-registry`, `07-crosswalk`, `08-template-sample-mirror`, `09-sample-fixture`, `10-validation-files`, `11-tools-files`, `12-config-files`, `13-bp12c-skill-wrappers`, `13a-provider-agent-skills`, `14-bp12c-hooks`, `14a-provider-hooks`.

**Impact:** REL0-C cannot self-certify a clean BP12A. The patch itself is otherwise validator-green, git-hygiene-clean, public-safe, free of AL3 / AL4 / AL5 overclaim, and free of live-integration overclaim. The FAIL row exists only because the BP12A allow-list pattern was not extended in lock-step.

**Proposed owner / remediation:** WP-12C-REL0-C-PATCH-A (or REL0-C amendment authorized by founder). One-line allow-list addition at `tools/Test-AisrafBp12AReadiness.ps1` (after the existing `$wp12cK3cExactFutureDrift`):

```
# WP-12C-REL0-C: public entrypoint micro-patch. Exact-path only; no wildcards.
$wp12cRel0CMicropatchDrift = @(
    'README.md',
    'START-HERE.md'
)
```

…and adding `+ $wp12cRel0CMicropatchDrift` to the `$allowedTrackedDriftExact` composition. After the amendment, `tools/Build-AisrafCopilotPluginBundle.ps1 -Clean` would also need to be re-run because the BP12A validator is bundled.

This is the same governance pattern previously used by `$wp12cK1bAuthorityPatchDrift`, `$wp12cApprovedPluginScaffoldDrift`, etc. The amendment is allow-list data, not validator logic. REL0-C did not land it because the explicit allowed-edits list for this work package does not include `tools/Test-AisrafBp12AReadiness.ps1` and the brief said *do not change validator logic*; the cautious interpretation routes the change through a founder-authorized follow-on micro-patch rather than self-authorizing here.

---

## 7. Bundle rebuild

`pwsh -NoProfile -File ./tools/Build-AisrafCopilotPluginBundle.ps1 -Clean` returned:

> `Build-AisrafCopilotPluginBundle: PASS  199 files bundled, all source/target SHA-256 match.`

Only `plugins/aisraf-copilot-plugin/bundle/tools/Test-AisrafPackage.ps1` and `plugins/aisraf-copilot-plugin/bundle-checksum-manifest.yaml` changed (the bundled validator copy plus the regenerated manifest hashes).

---

## 8. Validator results

| Validator | Result |
|---|---|
| `tools/Test-AisrafPackage.ps1` | **83 PASS, 2 WARN, 0 FAIL.** Both WARNs are the known smoke-folder warnings (RB-001 `runs/RUN-SMOKE-LOCAL-001/`, RB-002 `runs/RUN-SMOKE-PLUGIN-L2B-001/`) owned by WP-12C-L3 and tracked in `RELEASE-MANIFEST.yaml` `known_warnings[]`. No FAIL. |
| `tools/Test-AisrafBp12AReadiness.ps1` | **76 PASS, 1 FAIL** (`01-git-workspace / tracked-drift`; see §6). All package-surface, run-profile, agent-projection, registry, crosswalk, template-mirror, sample-fixture, validation-files, tools-files, config-files, BP12C skill-wrapper, provider Agent Skills, hook, and provider-hook checks PASS. |
| `tools/Test-AisrafRunProfile.ps1 -RunProfilePath ./runs/RUN-SMOKE-PLUGIN-L2B-001/run-profile.yaml -ExecutionReady` | **12 PASS, 0 FAIL** (level=ExecutionReady). |
| `tools/Test-AisrafRunProfile.ps1 -RunProfilePath ./runs/RUN-001/run-profile.yaml -ExecutionReady` | **12 PASS, 0 FAIL** (level=ExecutionReady). |

---

## 9. Git hygiene

| Field | Value |
|---|---|
| Modified files | `PACKAGE-MANIFEST.yaml`, `README.md`, `START-HERE.md`, `plugins/aisraf-copilot-plugin/bundle-checksum-manifest.yaml`, `plugins/aisraf-copilot-plugin/bundle/tools/Test-AisrafPackage.ps1`, `tools/Test-AisrafPackage.ps1`. Exactly six modifications. |
| Untracked files | `validation/package-12c-rel0-final-release-blocker-register.md`, `validation/package-12c-rel0-final-release-qa-report.md` (carried in from REL0-QA), plus this report `validation/package-12c-rel0-c-micropatch-report.md` once created. All three are now allow-listed in `tools/Test-AisrafPackage.ps1` `$validationAllowed`. |
| Staged files | None. |
| `.claude/` posture | Not tracked, not staged, `.git/info/exclude`-ignored. |
| `runs/RUN-SMOKE-LOCAL-001/` | `.git/info/exclude`-ignored (local smoke evidence). |
| `runs/RUN-SMOKE-PLUGIN-L2B-001/` | `.git/info/exclude`-ignored (local smoke evidence). |
| `runs/RUN-001/` diff | Empty. RUN-001 untouched. |
| `samples/` diff | Empty. samples/ untouched. |
| Canonical surfaces diff (`prompts/`, `skills/`, `prototype-agents/`, `templates/`, `catalogs/`, `blueprints/`, `config/`) | Empty. All canonical surfaces untouched. |
| Projection surfaces diff (`.agents/`, `.github/agents/`, `.github/skills/`, `.github/hooks/`, `.copilot-skills/`) | Empty. All projection surfaces untouched. |

---

## 10. Autonomy and external-integration claim audit

- No claim that AISRAF v0.1.2 orchestrates a multi-agent runtime; AL3 is consistently labelled future / WP-ORCH0.
- No claim that AISRAF v0.1.2 executes external adapters or posts back to Jira, Confluence, Lucidchart, Rovo, MCP, Anthropic Claude runtime, Azure AI Foundry, Google ADK, Microsoft Agent Framework, databases, Terraform, cloud runtimes, event buses, or telemetry systems. AL4 is consistently labelled future adapter work.
- No claim of AL5 closed-loop autonomy; AL5 is consistently labelled out of scope for v0.1.x.
- No introduction of secrets, credentials, real PII / PAN / SSN / PHI, production endpoints, or personal absolute paths.
- No edit to `plugin.json`, `plugin.yaml`, canonical sources, projection surfaces, run fixtures, samples, or RUN-001.

---

## 11. Final status fields

```yaml
work_package_status: WP-12C-REL0_C_PARTIAL_WITH_GAPS
rb_rel0_001_status: CLOSED
rb_rel0_002_status: CLOSED
rb_rel0_003_status: CLOSED
rb_rel0_004_status: CLOSED
rb_rel0_005_status: CLOSED
files_changed:
  - README.md
  - START-HERE.md
  - PACKAGE-MANIFEST.yaml
  - tools/Test-AisrafPackage.ps1
  - plugins/aisraf-copilot-plugin/bundle/tools/Test-AisrafPackage.ps1   # via bundle builder only
  - plugins/aisraf-copilot-plugin/bundle-checksum-manifest.yaml          # via bundle builder only
files_created:
  - validation/package-12c-rel0-c-micropatch-report.md
validator_allowlist_entries_added:
  - package-12c-rel0-final-release-qa-report.md
  - package-12c-rel0-final-release-blocker-register.md
  - package-12c-rel0-c-micropatch-report.md
bundle_rebuild_status: PASS_199_FILES_BYTE_IDENTICAL_SOURCE_TARGET_SHA256_MATCH
validator_results:
  test_aisraf_package: 83_PASS_2_WARN_0_FAIL    # 2 WARN are the known smoke-folder RB-001/RB-002 (KW-001/KW-002), owned by WP-12C-L3, BLACK_CLOSED
  test_aisraf_bp12a_readiness: 76_PASS_1_FAIL    # FAIL is the new RB-REL0-C-006 tracked-drift allow-list gap; see §6
  test_aisraf_run_profile_l2b: 12_PASS_0_FAIL
  test_aisraf_run_profile_run001: 12_PASS_0_FAIL
git_hygiene_results:
  modified_count: 6
  staged_count: 0
  untracked_count: 3   # 2 REL0-QA reports + this REL0-C report
  claude_tracked_or_staged: NONE
  smoke_folders_excluded: TRUE
run001_status: UNTOUCHED_CLEAN
samples_status: UNTOUCHED_CLEAN
canonical_surface_status: UNTOUCHED_CLEAN
projection_surface_status: UNTOUCHED_CLEAN
plugin_bundle_status: REBUILT_VALIDATED_BYTE_IDENTICAL_NO_BUNDLE_FOLDER_OUTSIDE_APPROVED_PATHS
autonomy_wording_status: AL2_CURRENT_AL3_FUTURE_WP_ORCH_AL4_FUTURE_ADAPTERS_AL5_OUT_OF_SCOPE_CONSISTENT_ACROSS_README_START_HERE_AND_MANIFEST
deferred_integration_overclaim_status: NO_LIVE_JIRA_CONFLUENCE_LUCIDCHART_ROVO_MCP_FOUNDRY_ADK_MAF_DATABASE_TERRAFORM_CLOUD_EVENT_BUS_TELEMETRY_OR_POST_BACK_CLAIM
remaining_release_blockers:
  - RB-REL0-C-006 (NEW; warning-class; BP12A tracked-drift allow-list does not enumerate README.md or START-HERE.md; remediation routed to follow-on founder-authorized REL0-C-PATCH-A — see §6 of this report)
  - KW-001 / RB-001 (carry-forward; warning; runs/RUN-SMOKE-LOCAL-001/ hygiene; owned by WP-12C-L3 BLACK_CLOSED; folder .git/info/exclude-ignored)
  - KW-002 / RB-002 (carry-forward; warning; runs/RUN-SMOKE-PLUGIN-L2B-001/ hygiene; owned by WP-12C-L3 BLACK_CLOSED; folder .git/info/exclude-ignored)
  - BP12-SAMPLE-DFD-BLOCKER (carry-forward; HARD; owner founder; downstream gate for WP-13, not for REL0 closure)
may_REL0_C_STAGE_COMMIT_proceed: NO_PENDING_RB_REL0_C_006_RESOLUTION   # REL0-C cannot self-certify a clean BP12A; founder authorization needed for the one-line allow-list extension or to accept the documented FAIL row
may_REL0_CLOSE_proceed: NO_PENDING_REL0_C_STAGE_COMMIT
may_WP13_proceed: NO_BLOCKED_PENDING_REL0_CLOSURE_AND_BP12_SAMPLE_DFD_BLOCKER_RESOLUTION
may_ORCH0_proceed: NO_FUTURE_NOT_IN_V0_1_2_SCOPE
may_ADAPTER0_proceed: NO_FUTURE_AL4_NOT_CURRENT_RELEASE
may_publish_or_push: NO_NO_PUSH_NO_PUBLICATION_THIS_WORK_PACKAGE
exact_next_gate: WP-12C-REL0-C-PATCH-A (founder-authorized one-line BP12A allow-list extension for README.md and START-HERE.md, then re-run all four validators, then proceed to REL0-C-STAGE-COMMIT)
```

---

## 12. Stop notice

WP-12C-REL0-C has produced the smallest possible patch for the five REL0-QA warning-class gaps (RB-REL0-001..005, all CLOSED) and has surfaced one new warning-class gap (RB-REL0-C-006) created by the patch interaction with the BP12A `tracked-drift` allow-list. No staging has occurred. No publication has occurred. No push has occurred. No WP-13, WP-ORCH0, or AL4 adapter work has started. No diagram has been created. No new external-integration claim has been introduced. No autonomy-level overclaim has been introduced. No protected-surface drift has been introduced. No secret or personal-path leak has been introduced. RUN-001, samples, prompts, skills, prototype-agents, templates, catalogs, blueprints, config, `.agents/`, `.github/agents/`, `.github/skills/`, `.github/hooks/`, `.copilot-skills/`, `plugin.json`, and `plugin.yaml` are byte-identical to their pre-patch state.

Stopping here for founder review per the work-package brief.
