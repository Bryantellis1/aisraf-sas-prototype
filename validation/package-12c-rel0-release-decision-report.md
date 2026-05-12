# WP-12C REL0 Release Decision Report

work_package_status: WP-12C-REL0_RELEASE_DECISION_BLOCKED_WITH_REASON
head_commit: abcad6feb16a94ed71c81f6620032584f22e5a68
founder_release_decision: BLOCKED - do not push, publish, tag, start WP-13 execution, or start AM4
release_claim_status: PASS_NO_AFFIRMATIVE_OVERCLAIM_FOUND_WITH_METADATA_AND_JOURNEY_GAPS
plain_language_autonomy_terms_status: FAIL - public-facing docs use AL/AM before the required plain-language definitions are established
mode_0_to_4_status: PARTIAL - modes 0 through 4 are documented, but the AL/AM terms need a short definition before first use for public readers
al2_user_journey_status: PARTIAL - the everyday local controlled-output workbench path is described, but the AL2 label is not defined plainly enough before use
am3_runtime_evidence_journey_status: PARTIAL - AM3 / AL3 evidence path is validator-green and described, but AM must be defined as the evidence lane before public readers meet AM3
am4_boundary_status: PASS - AM4 is consistently future-only external adapter / post-back execution
al5_boundary_status: PASS - AL5 is consistently out of scope
plugin_user_experience_status: BLOCKED_WITH_REASON - operator quickstart explains expected plugin discovery, but plugins/aisraf-copilot-plugin/README.md still presents the package as a K2 scaffold-only, not-installable future plugin surface
input_output_journey_status: PASS - public docs explain runs/<run_id>/inputs/, run-profile.yaml control, local Markdown outputs, 00-run-log.md, 01-input-inventory.md through 17-accuracy-score.md, and dfd/01 through dfd/09 outputs
validator_results: PASS_PRE_REPORT - Test-AisrafPackage 83 PASS, 3 WARN, 0 FAIL; Test-AisrafBp12AReadiness 77 PASS, 0 FAIL; RUN-SMOKE-AM3-001 run profile 12 PASS, 0 FAIL; RUN-SMOKE-PLUGIN-L2B-001 run profile 12 PASS, 0 FAIL; RUN-001 run profile 12 PASS, 0 FAIL; AM3 ContractsOnly 4 PASS, 0 FAIL; AM3 runtime 23 PASS, 0 FAIL
git_hygiene_results: PASS_PRE_REPORT - HEAD abcad6f chore: close AISRAF v0.1.2 REL0 remediation QA; no unstaged diff; no staged diff; .claude not tracked or staged; smoke folders ignored by .git/info/exclude
run001_status: PASS_UNCHANGED - git diff -- runs/RUN-001/ returned no rows before this report
samples_status: PASS_UNCHANGED - git diff -- samples/ returned no rows before this report
canonical_surface_status: PASS_CLEAN - prompts/, skills/, prototype-agents/, templates/, catalogs/, blueprints/, config/, and .agents/ had no diff before this report
projection_surface_status: PASS_CLEAN - .github/agents/, .github/skills/, .github/hooks/, and .copilot-skills/ had no diff before this report
local_only_status: PASS - .claude/, runs/RUN-SMOKE-LOCAL-001/, runs/RUN-SMOKE-PLUGIN-L2B-001/, and runs/RUN-SMOKE-AM3-001/ are ignored, untracked, unstaged, and local-only
license_notice_status: PARTIAL_PUBLIC_SAFE_PLACEHOLDER - LICENSE and NOTICE.md are evaluation-only, all-rights-reserved placeholders pending founder / legal confirmation; they do not grant open-source or marketplace publication rights
security_overclaim_status: PASS - release-facing scan found no affirmative current claim of production readiness, marketplace publication, Jira execution, Confluence post-back, Lucidchart execution, MCP/Rovo execution, cloud runtime, database runtime, Terraform execution, event bus integration, telemetry backend integration, external post-back execution, AM4 current, AL5 current, closed-loop autonomy, or no-human-approval-required operation
remaining_blockers: |
  1. validation/package-12c-rel0-release-decision-report.md is not allow-listed in tools/Test-AisrafPackage.ps1 Check 11 or the bundled validator copy. Per founder instruction, no validator patch was made automatically. This exact allow-list patch requires explicit founder authorization before the report can coexist with a green package validator.
  2. Public metadata is stale after commit abcad6f: README.md, START-HERE.md, PACKAGE-MANIFEST.yaml, RELEASE-MANIFEST.yaml, and docs/ROADMAP.md still describe the current gate as WP-12C-REL0-FINAL-QA-REMEDIATION / final QA rerun instead of the release decision baseline.
  3. RELEASE-MANIFEST.yaml and PACKAGE-MANIFEST.yaml still point release metadata at the AM3 stage commit 34c1d55ce79e6bb0f9f274bef335af42600ef3f7 rather than the accepted REL0 remediation commit abcad6feb16a94ed71c81f6620032584f22e5a68.
  4. Public docs do not consistently define AL as Autonomy Level and AM as Autonomy Mode / release evidence lane before using AL2, AM3, AM4, and AL5.
  5. plugins/aisraf-copilot-plugin/README.md is stale and conflicts with the current plugin/package state by describing the surface as scaffold-only, five files only, no subfolders, not installable, K2/K3 blocked, and WP-12C-L blocked.
  6. License and notice remain public-safe placeholders pending founder / legal confirmation, so push/publication remains blocked until that posture is explicitly accepted for the release lane.
may_WP13_PREP_proceed: false
may_WP13_proceed: false
may_REL0_PUSH_PREP_proceed: false
may_REL0_PUSH_proceed: false
may_AM4_ADAPTERS_proceed: false
exact_next_gate: WP-12C-REL0-RELEASE-DECISION-REMEDIATION

## Scope Performed

- Performed the founder release decision gate against the accepted prior state and HEAD commit abcad6feb16a94ed71c81f6620032584f22e5a68.
- Did not push, publish, tag, create diagrams, start WP-13 execution, or start AM4.
- Wrote only this allowed report file.

## Read-Only Checks

- git status --short: clean before this report.
- git log -1 --oneline: abcad6f chore: close AISRAF v0.1.2 REL0 remediation QA.
- git diff --name-only: no rows before this report.
- git diff --staged --name-only: no rows before this report.
- git ls-files -- .claude: no rows.
- git diff --cached --name-only -- .claude: no rows.
- git check-ignore -v confirmed .claude/ and the three smoke folders are ignored by .git/info/exclude.
- git diff -- runs/RUN-001/: no rows.
- git diff -- samples/: no rows.
- git diff -- protected canonical/provider surfaces: no rows.

## Validator Ladder

All requested validators passed before this report was written:

| Validator | Result |
|---|---|
| pwsh -NoProfile -File ./tools/Test-AisrafPackage.ps1 | 83 PASS, 3 WARN, 0 FAIL |
| pwsh -NoProfile -File ./tools/Test-AisrafBp12AReadiness.ps1 | 77 PASS, 0 FAIL |
| pwsh -NoProfile -File ./tools/Test-AisrafRunProfile.ps1 -RunProfilePath ./runs/RUN-SMOKE-AM3-001/run-profile.yaml -ExecutionReady | 12 PASS, 0 FAIL |
| pwsh -NoProfile -File ./tools/Test-AisrafRunProfile.ps1 -RunProfilePath ./runs/RUN-SMOKE-PLUGIN-L2B-001/run-profile.yaml -ExecutionReady | 12 PASS, 0 FAIL |
| pwsh -NoProfile -File ./tools/Test-AisrafRunProfile.ps1 -RunProfilePath ./runs/RUN-001/run-profile.yaml -ExecutionReady | 12 PASS, 0 FAIL |
| pwsh -NoProfile -File ./tools/Test-AisrafAm3Runtime.ps1 -ContractsOnly | 4 PASS, 0 FAIL |
| pwsh -NoProfile -File ./tools/Test-AisrafAm3Runtime.ps1 -RunProfilePath ./runs/RUN-SMOKE-AM3-001/run-profile.yaml | 23 PASS, 0 FAIL |

The 3 package WARN rows are the expected local-only smoke folder warnings.

## User Journey Clarity Findings

| Check | Result | Evidence |
|---|---|---|
| New user understands what appears after loading the plugin | PARTIAL | docs/OPERATOR-QUICKSTART.md lists the 7 agents, 7 provider skill packages, and hook config; plugin README is stale and still describes a scaffold-only future plugin. |
| New user knows to start with @aisraf-orchestrator | PASS | docs/OPERATOR-QUICKSTART.md and docs/SECURITY-REVIEW-WORKFLOW.md direct the user to start with the orchestrator. |
| New user knows where to place inputs | PASS | docs/OPERATOR-QUICKSTART.md and docs/SECURITY-REVIEW-WORKFLOW.md name runs/<run_id>/inputs/. |
| New user knows run-profile.yaml controls the run | PASS | docs/OPERATOR-QUICKSTART.md explains run-profile.yaml and key fields. |
| New user knows outputs are local Markdown files | PASS | docs/OPERATOR-QUICKSTART.md and docs/SECURITY-REVIEW-WORKFLOW.md list 00-run-log.md, 01-17 root outputs, and dfd/01-09 outputs. |
| New user understands AL2 as the everyday journey | PARTIAL | AL2 controlled-output workbench is named repeatedly, but AL is not defined up front as Autonomy Level. |
| New user understands AM3 / AL3 as local runtime evidence journey | PARTIAL | AM3 / AL3 is accurately bounded and validator-backed, but AM is not defined up front as Autonomy Mode / release evidence lane. |
| New user understands AM4 is future external integration | PASS | AM4 future boundary is consistent across README, docs, CHANGELOG, NOTICE, and RELEASE-MANIFEST. |
| New user understands AL5 is not included | PASS | AL5 out-of-scope boundary is consistent across public docs. |
| No doc requires prior AL/AM knowledge | FAIL | Public docs use AL/AM labels before the required plain-language definitions are established. |

## Release Claim Scan

Release-facing files scanned: README.md, START-HERE.md, PACKAGE-MANIFEST.yaml, RELEASE-MANIFEST.yaml, CHANGELOG.md, SECURITY.md, CONTRIBUTING.md, LICENSE, NOTICE.md, docs/AISRAF-PRIMER.md, docs/OPERATOR-QUICKSTART.md, docs/SECURITY-REVIEW-WORKFLOW.md, docs/ARCHITECTURE-OVERVIEW.md, docs/ROADMAP.md, plugins/aisraf-copilot-plugin/plugin.json, and plugins/aisraf-copilot-plugin/plugin.yaml.

The scan found only negated, deferred, future-only, or boundary statements for the forbidden claim set. No affirmative current external execution, production, publication, AM4, AL5, closed-loop, or no-human-approval operation claim was accepted.

## Release Decision

The technical release candidate is validator-green before this report. However, the founder release decision is blocked because public release metadata and plugin-facing user journey text are not yet clear and current enough for a public user, and because this decision report filename is not yet admitted by the package validator allow-list.

Do not proceed to WP-13 prep, WP-13 execution, REL0 push prep, REL0 push, or AM4 adapter work from this state.