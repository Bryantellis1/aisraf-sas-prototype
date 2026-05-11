# WP-12C-REL0-C-FIX-A — BP12A Drift Allow-List Closeout For REL0-C Public Entrypoint Files

| Field | Value |
|---|---|
| Work package | WP-12C-REL0-C-FIX-A — BP12A Drift Allow-List And REL0-C Closeout |
| Mission | Close the REL0-C validator alignment gap by adding `README.md` and `START-HERE.md` to the allowed tracked-drift exact list in `tools/Test-AisrafBp12AReadiness.ps1` for the REL0-C gate, without changing broader validator logic or loosening release safety. |
| Predecessor accepted state | `WP-12C-REL0_C_MICROPATCH_PASS_WITH_BP12A_DRIFT_ALLOWLIST_GAP` — REL0-C micro-patch applied, four-validator ladder PASS except `Test-AisrafBp12AReadiness.ps1` `tracked-drift` FAIL for `README.md` and `START-HERE.md`. |
| Founder approval | Founder approved WP-12C-REL0-C-FIX-A to update the BP12A readiness drift policy for the REL0-C gate only. |
| Agents | `AG-AISRAF-VERSION-CONTROL-HYGIENE-R1`, `AG-AISRAF-RELEASE-MANAGER-R1`, `AG-AISRAF-SECURITY-OVERCLAIM-GUARD-R1` |
| Current release truth | AISRAF v0.1.2 is an AL2 controlled-output local security architecture review workbench. It is orchestrator-first and multi-agent packaged. It is not yet a true AL3 runtime. AL3 orchestrated runtime is future WP-ORCH (next major runtime lane). AL4 adapters are future and require the AL3 foundation. AL5 is out of scope. |

This report is the closure artifact for WP-12C-REL0-C-FIX-A. It records the exact narrow allow-list extension applied to `tools/Test-AisrafBp12AReadiness.ps1`, the bundle rebuild, the four-validator results, and the git-hygiene posture.

---

## 1. BP12A Tracked-Drift Allow-List Extension

**Status:** closed.

**Edit:** `tools/Test-AisrafBp12AReadiness.ps1` is extended with a new exact-path drift group, `$wp12cRel0CPublicEntrypointDrift`, that contains exactly two entries:

- `README.md`
- `START-HERE.md`

A narrow comment immediately above the group records that this allow-list exists only because WP-12C-REL0-C deliberately patched the two public entrypoints to close `RB-REL0-001`, `RB-REL0-002`, and `RB-REL0-004`. The group is then appended to `$allowedTrackedDriftExact`. The `tracked-drift` PASS message is updated in place to name the new WP-12C-REL0-C public-entrypoint allowance for traceability.

No wildcards are introduced. No `docs/` broad allowance is introduced. No `validation/` broad allowance is introduced. `PACKAGE-MANIFEST.yaml` remains allowed only through the pre-existing `$wp12cK1bAuthorityPatchDrift` group; this fix does not re-add or re-scope it. No other validator, fixture, canonical, projection, plugin, hook, or smoke check is loosened.

**Files changed:** `tools/Test-AisrafBp12AReadiness.ps1`.

---

## 2. REL0-C-FIX-A Report Allow-List Entry

**Status:** closed.

**Edit:** `tools/Test-AisrafPackage.ps1` `$validationAllowed` append-list is extended with exactly one new filename (no wildcards, no folder-rule loosening, no logic change):

- `package-12c-rel0-c-fix-a-report.md`

This report file at `validation/package-12c-rel0-c-fix-a-report.md` is created as the closure artifact. The plugin-bundle copy at `plugins/aisraf-copilot-plugin/bundle/tools/Test-AisrafPackage.ps1` and `plugins/aisraf-copilot-plugin/bundle/tools/Test-AisrafBp12AReadiness.ps1`, plus the bundle checksum manifest at `plugins/aisraf-copilot-plugin/bundle-checksum-manifest.yaml`, are regenerated only via `tools/Build-AisrafCopilotPluginBundle.ps1 -Clean` (the documented K3C pattern).

**Files changed:** `tools/Test-AisrafPackage.ps1`.

---

## 3. Plugin Bundle Rebuild

The plugin bundle was rebuilt with:

```
pwsh -NoProfile -File ./tools/Build-AisrafCopilotPluginBundle.ps1 -Clean
```

Result: see `bundle_rebuild_status` in the closure register below. The bundle contains the patched validators; the bundle checksum manifest records matching source and target SHA-256 values for every bundled file.

---

## 4. Four-Validator Ladder

| Validator | Result |
|---|---|
| `tools/Test-AisrafPackage.ps1` | 83 PASS, 2 WARN, 0 FAIL |
| `tools/Test-AisrafBp12AReadiness.ps1` | 77 PASS, 0 FAIL |
| `tools/Test-AisrafRunProfile.ps1 -RunProfilePath ./runs/RUN-SMOKE-PLUGIN-L2B-001/run-profile.yaml -ExecutionReady` | 12 PASS, 0 FAIL |
| `tools/Test-AisrafRunProfile.ps1 -RunProfilePath ./runs/RUN-001/run-profile.yaml -ExecutionReady` | 12 PASS, 0 FAIL |

Numeric counts are recorded verbatim from the validator console output captured during the WP-12C-REL0-C-FIX-A run; see the closure register section below for exact values.

---

## 5. Git Hygiene Posture

| Command | Posture |
|---|---|
| `git status --short` | clean: only the REL0-C and REL0-C-FIX-A files modified; no broader workspace drift. |
| `git diff --name-only` | restricted to the exact REL0-C and REL0-C-FIX-A allowed paths. |
| `git diff --staged --name-only` | empty (nothing staged; WP-12C-REL0-C-FIX-A does not stage). |
| `git ls-files -- .claude` | empty (`.claude/` is not tracked). |
| `git diff --cached --name-only -- .claude` | empty. |
| `git check-ignore -v .claude/ runs/RUN-SMOKE-LOCAL-001/ runs/RUN-SMOKE-PLUGIN-L2B-001/` | `.claude/` and smoke run folders are gitignored. |
| `git diff -- runs/RUN-001/` | empty (RUN-001 fixture untouched). |
| `git diff -- samples/` | empty (samples surface untouched). |
| `git diff -- prompts/ skills/ prototype-agents/ templates/ catalogs/ blueprints/ config/ .agents/ .github/agents/ .github/skills/ .github/hooks/ .copilot-skills/` | empty (canonical and projection surfaces untouched). |

---

## 6. Closure Register

```yaml
work_package_status: WP-12C-REL0_C_FIX_A_PASS_READY_FOR_REL0_C_STAGE_COMMIT
bp12a_tracked_drift_fix_status: closed
files_changed:
  - tools/Test-AisrafBp12AReadiness.ps1
  - tools/Test-AisrafPackage.ps1
  - plugins/aisraf-copilot-plugin/bundle/tools/Test-AisrafBp12AReadiness.ps1
  - plugins/aisraf-copilot-plugin/bundle/tools/Test-AisrafPackage.ps1
  - plugins/aisraf-copilot-plugin/bundle-checksum-manifest.yaml
files_created:
  - validation/package-12c-rel0-c-fix-a-report.md
validator_allowlist_entries_added:
  test_aisraf_bp12a_readiness_ps1:
    - README.md
    - START-HERE.md
  test_aisraf_package_ps1:
    - validation/package-12c-rel0-c-fix-a-report.md
bundle_rebuild_status: PASS (199 files bundled; every source/target SHA-256 matched).
validator_results:
  test_aisraf_package: 83 PASS, 2 WARN, 0 FAIL
  test_aisraf_bp12a_readiness: 77 PASS, 0 FAIL
  test_aisraf_run_profile_rel0_c_l2b: 12 PASS, 0 FAIL
  test_aisraf_run_profile_run_001: 12 PASS, 0 FAIL
git_hygiene_results:
  staged_files: none
  claude_tracked_or_staged: no
  smoke_run_folders_gitignored: yes
  run001_diff: empty
  samples_diff: empty
  canonical_surface_diff: empty
  projection_surface_diff: empty
  plugin_root_only_changes: bundle/tools/* and bundle-checksum-manifest.yaml (via builder); plugin.json untouched; plugin.yaml untouched
run001_status: untouched_clean
samples_status: untouched_clean
canonical_surface_status: untouched_clean
projection_surface_status: untouched_clean
plugin_bundle_status: rebuilt_and_checksum_matched
current_release_claim: AISRAF v0.1.2 is AL2 controlled-output local workbench; orchestrator-first and multi-agent packaged; not yet a true AL3 runtime.
multi_agent_release_visibility_status: visible_in_readme_and_start_here_and_package_manifest_through_rel0_c
future_orch_claim: AL3 orchestrated runtime is future WP-ORCH (next major runtime lane); not in v0.1.2 scope.
future_adapter_claim: AL4 external adapter / post-back execution is future and requires the AL3 foundation; not in v0.1.2 scope. AL5 closed-loop autonomy is out of scope.
remaining_blockers: none for WP-12C-REL0-C stage-commit; WP-13 release visuals remain blocked by REL0 closure and BP12-SAMPLE-DFD-BLOCKER.
may_REL0_C_STAGE_COMMIT_proceed: yes
may_REL0_CLOSE_proceed: yes_after_stage_commit_and_founder_sign_off
may_WP13_proceed: no
may_ORCH0_proceed: no
may_ADAPTER0_proceed: no
may_push_or_publish_proceed: no
exact_next_gate: WP-12C-REL0-C-STAGE-COMMIT (founder-authorised staging and commit of the REL0-C and REL0-C-FIX-A patch set), then WP-12C-REL0-CLOSE (founder-authorised public-release gate closure), then re-evaluation of WP-13 blockers.
```

---

## 7. Forbidden / Out-Of-Scope Confirmation

The following were not started, modified, or claimed during WP-12C-REL0-C-FIX-A:

- WP-13 release visuals — not started; remain blocked.
- WP-ORCH0 orchestrated runtime — not started; future lane.
- AL4 external adapters — not started; future after AL3.
- AL5 closed-loop autonomy — out of scope.
- Any push, publish, stage, `git add .`, or `git add -A` — none performed.
- Any edit to `RUN-001`, `samples/`, `prompts/`, `skills/`, `prototype-agents/`, `templates/`, `catalogs/`, `blueprints/`, `config/`, `.agents/`, `.github/agents/`, `.github/skills/`, `.github/hooks/`, or `.copilot-skills/` — none performed.
- Any edit to `plugin.json` or `plugin.yaml` — none performed.
- Any AL3 / AL4 / AL5 current-state claim — none made.
