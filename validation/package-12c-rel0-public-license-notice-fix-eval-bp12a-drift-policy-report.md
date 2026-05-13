# WP-12C-REL0-PUBLIC-LICENSE-NOTICE-FIX-EVAL-BP12A-DRIFT-POLICY — Validator-Policy Patch Report

Work package: WP-12C-REL0-PUBLIC-LICENSE-NOTICE-FIX-EVAL-BP12A-DRIFT-POLICY
Parent gate:  WP-12C-REL0-PUBLIC-LICENSE-NOTICE-FIX-EVAL (closed PARTIAL_WITH_GAPS)
Release lane: AISRAF SAS Prototype v0.1.2 — public source-available evaluation-only proof-of-concept
Scope:        validator-policy patch only (BP12A tracked-drift allow-list)
Status field: see `Status` section below

---

## 1. Why this micro-gate exists

The parent gate WP-12C-REL0-PUBLIC-LICENSE-NOTICE-FIX-EVAL rewrote the public
license/notice surface to drop any open-source claim and to assert the
evaluation-only public source-available proof-of-concept posture. That gate
closed `PARTIAL_WITH_GAPS` for one and only one reason:

`tools/Test-AisrafBp12AReadiness.ps1` Check `01-git-workspace / tracked-drift`
reported `LICENSE` as unexpected tracked drift, because `LICENSE` was not in
any exact-path allow-list. Every other tracked-diff path was already in a
named exact-path allow-list:

| Tracked path                                                     | Existing exact-path group                                              |
| ---------------------------------------------------------------- | ----------------------------------------------------------------------- |
| CHANGELOG.md                                                     | `$wp12cRel0FinalQaRemediationDrift`                                     |
| NOTICE.md                                                        | `$wp12cRel0FinalQaRemediationDrift`                                     |
| PACKAGE-MANIFEST.yaml                                            | `$wp12cK1bAuthorityPatchDrift`                                          |
| README.md                                                        | `$wp12cRel0CPublicEntrypointDrift`                                      |
| RELEASE-MANIFEST.yaml                                            | `$wp12cAm3ReleaseClaimAlignmentDrift`                                   |
| START-HERE.md                                                    | `$wp12cRel0CPublicEntrypointDrift`                                      |
| docs/AISRAF-PRIMER.md                                            | `$wp12cAm3ReleaseClaimAlignmentDrift`                                   |
| docs/ARCHITECTURE-OVERVIEW.md                                    | `$wp12cAm3ReleaseClaimAlignmentDrift`                                   |
| docs/OPERATOR-QUICKSTART.md                                      | `$wp12cAm3ReleaseClaimAlignmentDrift`                                   |
| docs/ROADMAP.md                                                  | `$wp12cAm3PlanRoadmapDrift`                                             |
| plugins/aisraf-copilot-plugin/README.md                          | `$wp12cApprovedPluginScaffoldDrift`                                     |
| plugins/aisraf-copilot-plugin/bundle-checksum-manifest.yaml      | `$wp12cK3cExactFutureDrift`                                             |
| plugins/aisraf-copilot-plugin/bundle/tools/Test-AisrafBp12A...  | `$wp12cK3cExactFutureDriftPrefixes` (`plugins/aisraf-copilot-plugin/bundle/`) |
| plugins/aisraf-copilot-plugin/bundle/tools/Test-AisrafPackage... | `$wp12cK3cExactFutureDriftPrefixes` (`plugins/aisraf-copilot-plugin/bundle/`) |
| tools/Test-AisrafBp12AReadiness.ps1                              | `$wp12cK3bValidatorPatchDrift`                                          |
| tools/Test-AisrafPackage.ps1                                     | `$wp12cK3bValidatorPatchDrift`                                          |
| LICENSE                                                          | (none — blocker)                                                        |

This micro-gate closes that single named gap.

## 2. Why a *validator-policy* patch and not a LICENSE wording change

The LICENSE wording was already approved by the parent
WP-12C-REL0-PUBLIC-LICENSE-NOTICE-FIX-EVAL gate. The remaining problem was
purely a policy gap inside the BP12A no-drift validator: it had no exact-path
group authorizing `LICENSE`. The correct fix is to patch the validator's
allow-list, not to re-edit the LICENSE file. Editing LICENSE would re-open
the license-posture decision that the parent gate just closed.

This is the same pattern used by WP-12C-REL0-RELEASE-DECISION-STAGE-COMMIT-FIX-A
(validator-policy patch only).

## 3. Boundaries that must NOT shift

This micro-gate is constrained to a single exact-path allow-list entry. It
must not:

- broaden the BP12A allow-list with any wildcard (`docs/**`, `validation/**`,
  `*.md`, `*.txt`, `LICENSE*`, `release/**`, `diagrams/**`, `publications/**`);
- weaken the `.claude` exclusion, the no-staged-files rule, the smoke-folder
  exclusion, RUN-001 fixture protection, samples protection, canonical-surface
  protection, provider-projection protection, AM4 boundary, or WP-13 boundary;
- change the LICENSE file content;
- change the evaluation-only license posture;
- introduce any open-source, marketplace-published, or production-software
  claim anywhere in the release surface;
- start WP-13 visual pack or AM4 work;
- stage, commit, push, tag, or publish anything;
- edit prompts, skills, prototype-agents, templates, catalogs, blueprints,
  config, RUN-001, samples, smoke evidence, plugin.json, plugin.yaml, or
  provider projections;
- touch diagrams or publications.

## 4. Exact change set

### 4.1 `tools/Test-AisrafBp12AReadiness.ps1`

Added one new named exact-path allow-list group immediately after
`$wp12cRel0ReleaseDecisionFounderApprovalDrift`:

```powershell
# WP-12C-REL0-PUBLIC-LICENSE-NOTICE-FIX-EVAL-BP12A-DRIFT-POLICY: exact
# license-file allowance for the evaluation-only public source-available
# proof-of-concept license/notice gate. The repository LICENSE was rewritten
# to drop the open-source claim and assert evaluation-only posture; BP12A
# previously flagged the resulting tracked diff because LICENSE was not in
# any exact-path allow-list. Exact-path only; LICENSE only; no wildcards;
# no broadening of docs/, validation/, release/, diagrams/, publications/,
# *.md, *.txt, or LICENSE* surfaces.
$wp12cRel0PublicLicenseNoticeFixEvalDrift = @(
    'LICENSE'
)
```

Appended that group to `$allowedTrackedDriftExact` (exact-path concatenation,
no `*` operator, no wildcard).

Extended the Check `01-git-workspace / tracked-drift` PASS detail string to
name the new allow-list group explicitly, and to repeat that there is still
no broad `LICENSE*` / `release/` / `diagrams/` / `publications/` allowance.

### 4.2 `tools/Test-AisrafPackage.ps1`

Added one exact filename to the `validation/` allow-list inside Check
`11-validation-allowed` (immediately after the parent gate's existing
`package-12c-rel0-public-license-notice-fix-eval-report.md` entry):

```
'package-12c-rel0-public-license-notice-fix-eval-bp12a-drift-policy-report.md',
```

Exact-path only. No wildcard. No relaxation of the `validation/` file allow-list
shape (still file-by-file). No relaxation of the surrounding folder-shape
guards in Check `12-tools-allowed`, Check `16-plugin-content-limits`, or
anywhere else.

### 4.3 `validation/package-12c-rel0-public-license-notice-fix-eval-bp12a-drift-policy-report.md`

This file. The single deliverable.

### 4.4 Governed bundle

After the two `tools/` script edits, the governed bundle rebuilder
`tools/Build-AisrafCopilotPluginBundle.ps1 -Clean` was run so that
`plugins/aisraf-copilot-plugin/bundle/tools/Test-AisrafBp12AReadiness.ps1`,
`plugins/aisraf-copilot-plugin/bundle/tools/Test-AisrafPackage.ps1`, and
`plugins/aisraf-copilot-plugin/bundle-checksum-manifest.yaml` are re-projected
through the governed builder rather than edited by hand.

## 5. What this micro-gate does NOT touch

- `LICENSE` content (unchanged — parent gate already approved the wording)
- `NOTICE.md`, `README.md`, `START-HERE.md`, `CHANGELOG.md`,
  `CONTRIBUTING.md`, `SECURITY.md`, `PACKAGE-MANIFEST.yaml`,
  `RELEASE-MANIFEST.yaml`, `PROTOTYPE-CHARTER.md`, `FOLDER-CONTRACTS.md`,
  `BUILD-ORDER.md`
- `docs/**` (no edits)
- `runs/RUN-001/**` (fixture protected)
- `samples/**` (sealed)
- `prompts/`, `skills/`, `prototype-agents/`, `templates/`, `catalogs/`,
  `blueprints/`, `config/`, `authoring-agents/` (canonical surface sealed)
- `plugin.json`, `plugin.yaml` (provider projection sealed)
- `diagrams/**` (no visual-pack work yet)
- `publications/**` (does not exist yet — WP-13 not started)
- `runs/RUN-SMOKE-*` smoke evidence

## 6. Mode and boundary statements that remain unchanged

- Mode 0 / AL0 – authoring with templates only. Unchanged.
- Mode 1 / AL2 – everyday controlled-output local workbench. Unchanged.
- Mode 2 / AM3 / AL3 – current local orchestrated runtime evidence path.
  Unchanged.
- Mode 3 – reserved. Unchanged.
- Mode 4 / AM4 – external adapter mode. Still future-only. Unchanged.
- AL4 autonomous execution and AL5 fully autonomous — out of scope. Unchanged.
- AM4 external adapter mode — out of scope. Unchanged.
- Public posture — evaluation-only public source-available proof-of-concept.
  NOT open source. NOT production software. NOT marketplace-published.
  Unchanged.

## 7. Validator-ladder expected pass state

| Validator                                                                         | Expected                  |
| --------------------------------------------------------------------------------- | -------------------------- |
| `pwsh -NoProfile -File ./tools/Test-AisrafPackage.ps1`                            | 0 FAIL                     |
| `pwsh -NoProfile -File ./tools/Test-AisrafBp12AReadiness.ps1`                     | 77 PASS, 0 FAIL            |
| `Test-AisrafRunProfile.ps1 -RunProfilePath ./runs/RUN-001/run-profile.yaml -ExecutionReady` | 12 PASS, 0 FAIL    |
| `Test-AisrafAm3Runtime.ps1 -ContractsOnly`                                        | 4 PASS, 0 FAIL             |
| `Test-AisrafAm3Runtime.ps1 -RunProfilePath ./runs/RUN-SMOKE-AM3-001/run-profile.yaml` | 23 PASS, 0 FAIL        |
| `git diff --check`                                                                | clean                      |
| `git diff --staged --name-only`                                                   | empty (no staged files)    |
| `git ls-files -- .claude`                                                         | empty                      |

The actual ladder run output is summarized in the `Status` section.

## 8. Status

| Field                                       | Value                                                                              |
| ------------------------------------------- | ---------------------------------------------------------------------------------- |
| work_package_status                         | see final-report block below                                                       |
| bp12a_license_drift_policy_status           | LICENSE allowed by exact-path group `$wp12cRel0PublicLicenseNoticeFixEvalDrift` only |
| exact_paths_added                           | `LICENSE` (BP12A) + `package-12c-rel0-public-license-notice-fix-eval-bp12a-drift-policy-report.md` (BP12C package validator) |
| wildcard_status                             | none — no new wildcard introduced                                                  |
| license_notice_status                       | unchanged (evaluation-only public source-available proof-of-concept)               |
| open_source_claim_status                    | NONE                                                                               |
| marketplace_claim_status                    | NONE                                                                               |
| production_claim_status                     | NONE                                                                               |
| mode_0_to_4_status                          | unchanged                                                                          |
| am3_claim_status                            | unchanged (bounded local runtime evidence only)                                    |
| am4_boundary_status                         | held (future-only)                                                                 |
| al5_boundary_status                         | held (out-of-scope)                                                                |

## 9. Next gate (only after this returns PASS_READY)

`WP-13-FIRST-PUBLIC-VISUAL-PACK-AND-PUBLICATION-EXPORT`

WP-13 may then:

- copy approved visuals into `diagrams/release-v0.1.2/`
- create `diagram-registry.yaml`
- link the right diagrams into README/docs
- create aligned Markdown / Word / PDF publication exports under
  `publications/release-v0.1.2/`

WP-13 must start only after this micro-gate returns PASS_READY.

After WP-13 the public-release sequence is:

1. WP-12C-REL0-PUBLIC-LICENSE-NOTICE-FIX-EVAL-BP12A-DRIFT-POLICY (this gate)
2. WP-13-FIRST-PUBLIC-VISUAL-PACK-AND-PUBLICATION-EXPORT
3. FINAL-PUBLIC-QA
4. STAGE-COMMIT
5. POST-COMMIT-QA
6. PUSH-PREP
7. PUSH
8. OPTIONAL TAG / GITHUB RELEASE
