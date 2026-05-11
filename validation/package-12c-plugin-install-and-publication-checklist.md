---
plugin_id: aisraf-copilot-plugin
work_package: WP-12C-ED1
parent_status: WP-12C-QA1_PARTIAL_WITH_GAPS
lifecycle_status: packaged_locally_installed_l2b_controlled_output_proven
install_status: l1a_provider_install_evidence_recorded
interactive_smoke_status: l2a_preview_role_smoke_pass_and_l2b_controlled_output_pass
l2b_controlled_output_status: pass_evidence_under_runs_run_smoke_plugin_l2b_001
qa1_status: WP-12C-QA1_PARTIAL_WITH_GAPS
ed1_status: in_progress
external_execution: disabled
postback_execution_status: deferred
output_destination_mode: local_only
l3_status: blocked_pending_rb_001_through_rb_005_closure
rel0_status: blocked_pending_l3
wp13_status: blocked_pending_post_l3
wp_orch_status: future_not_in_v0_1_2_scope
---

# AISRAF Copilot Plugin - Install And Publication Checklist (WP-12C-L0)

## 1. Purpose

This checklist opens the WP-12C-L install and interactive smoke-test planning
surface without performing the install. WP-12C-L0 is a preflight gate only:
it confirms K4 acceptance, plugin package artifact presence, validator health,
operator environment assumptions, terminal / hook hygiene, and Git posture.

No plugin install, interactive role smoke, controlled output, diagram,
release artifact, Git publication, external execution, or external post-back is
performed or claimed by this checklist.

## 2. Gate Position

| Gate | Scope | Status |
|---|---|---|
| WP-12C-K4 | Manifest schema, plugin lint, checksum validation | BLACK / CLOSED |
| WP-12C-K | Copilot plugin packaging package | BLACK / CLOSED |
| WP-12C-L0 | Install readiness preflight and operator test plan | BLACK / CLOSED |
| WP-12C-L1A | Provider install surface patch (`plugin.json`) | BLACK / CLOSED |
| WP-12C-L1 | Local plugin install test | BLACK / CLOSED |
| WP-12C-L2A | Installed preview-only role smoke from the clean smoke workspace | BLACK / CLOSED (`WP-12C-L2A_PREVIEW_ROLE_SMOKE_PASS_READY_FOR_UX_FIX`) |
| WP-12C-L2A-UX | Operator usability runbook patch | BLACK / CLOSED (`WP-12C-L2A_UX_RUNBOOK_PASS_READY_FOR_L2B_PLANNING`) |
| WP-12C-L2B-PLAN | Controlled-output smoke plan | BLACK / CLOSED |
| WP-12C-L2B-EXEC | Controlled-output execution under `runs/RUN-SMOKE-PLUGIN-L2B-001/` | BLACK / CLOSED (0 FAIL across the four validators; 17 RS + 9 DFD outputs captured; no overclaim) |
| WP-12C-QA1 | Package release-readiness QA report and blocker register | BLACK / CLOSED (`WP-12C-QA1_PARTIAL_WITH_GAPS`; RB-001..RB-005 recorded) |
| WP-12C-ED1 | Repository editor / readability and public-safety pass; RB-003 / RB-004 fixes | CURRENT |
| WP-12C-L3 | Install evidence, smoke-folder hygiene, and Git staging / publication decision | BLOCKED until RB-001..RB-005 close |
| WP-12C-REL0 | Release manifest, license, notice, changelog, contribution | BLOCKED until L3 publication readiness |
| WP-13 | Diagrams and release view pack | BLOCKED until post-L3 |
| WP-ORCH | True AL3 orchestrated multi-agent runtime | FUTURE — not in v0.1.2 scope |

## 3. Install Preflight Checklist

| # | Check | Expected L0 Result | L0 Status |
|---|---|---|---|
| L0-P1 | Confirm K4 package validation state. | `WP-12C-K4_PLUGIN_PACKAGE_VALIDATION_PASS_READY_FOR_INSTALL_TESTING`; parent status `WP-12C-K_PACKAGE_COMPLETE_READY_FOR_INSTALL_READINESS_PREFLIGHT`. | VERIFIED |
| L0-P2 | Confirm plugin manifest exists. | `plugins/aisraf-copilot-plugin/plugin.yaml` present. | VERIFIED |
| L0-P3 | Confirm plugin README exists. | `plugins/aisraf-copilot-plugin/README.md` present. | VERIFIED |
| L0-P4 | Confirm packaging plan exists. | `plugins/aisraf-copilot-plugin/PLUGIN-PACKAGING-PLAN.md` present. | VERIFIED |
| L0-P5 | Confirm test card exists. | `plugins/aisraf-copilot-plugin/PLUGIN-TEST-CARD.md` present and carries deferred WP-12C-L smoke rows. | VERIFIED |
| L0-P6 | Confirm evidence checklist exists. | `plugins/aisraf-copilot-plugin/EVIDENCE-CHECKLIST.md` present. | VERIFIED |
| L0-P7 | Confirm bundle exists. | `plugins/aisraf-copilot-plugin/bundle/` present. | VERIFIED |
| L0-P8 | Confirm checksum manifest exists. | `plugins/aisraf-copilot-plugin/bundle-checksum-manifest.yaml` present. | VERIFIED |
| L0-P9 | Confirm bundle build script exists. | `tools/Build-AisrafCopilotPluginBundle.ps1` present. | VERIFIED |
| L0-P10 | Run package validator. | 82 PASS, 1 WARN, 0 FAIL. WARN is the known local smoke-folder warning. | VERIFIED |
| L0-P11 | Run BP12A readiness validator. | 77 PASS, 0 FAIL. | VERIFIED |
| L0-P12 | Run RUN-001 execution-ready profile validator. | 12 PASS, 0 FAIL. | VERIFIED |
| L0-P13 | Probe terminal parser behavior against the three validators and build script. | No parser error from the direct commands; classify any recurrence as stop-hook/report-format issue unless later reproduced in the install path. | VERIFIED |
| L0-P14 | Confirm Git staging posture. | Nothing staged; `.claude/` not tracked or staged. | VERIFIED |
| L0-P15 | Confirm fixture and sealed surfaces. | `runs/RUN-001/`, `samples/`, and required canonical/provider tracked diffs empty. | VERIFIED |
| L0-P16 | Stop before install. | No install attempted; no interactive smoke; no controlled outputs. | VERIFIED |

## 4. Operator Environment Assumptions

These assumptions must be checked by the operator before WP-12C-L1 begins.
They are not install evidence.

| # | Assumption | Required At L1 | Evidence Field |
|---|---|---|---|
| ENV-1 | Operator is in workspace root `D:/E-Way 2/AISRAF- SAS Prototype v0.1.2`. | Yes | `<operator-root-confirmation>` |
| ENV-2 | PowerShell command surface can run `pwsh -NoProfile -File`. | Yes | `<pwsh-version-and-path>` |
| ENV-3 | Git CLI is available and reports no staged files before install. | Yes | `<pre-install-git-status>` |
| ENV-4 | VS Code / GitHub Copilot plugin install surface is available to the operator. | Yes | `<install-surface-description>` |
| ENV-5 | The plugin package remains a local projection bundle, not an external runtime. | Yes | `<package-posture-confirmation>` |
| ENV-6 | External runtime, cloud, MCP, Jira, Confluence, database, Terraform, release, and post-back actions remain disabled. | Yes | `<negative-posture-confirmation>` |
| ENV-7 | Smoke write attempts use only governed scratch run paths, never `runs/RUN-001/`. | Yes | `<scratch-run-id>` |
| ENV-8 | `.claude/` remains excluded from staging decisions. | Yes | `<claude-staging-check>` |

## 5. Future WP-12C-L Flow

| Gate | Purpose | Entry Condition | Exit Evidence |
|---|---|---|---|
| WP-12C-L1 - Local Plugin Install Test | Install the packaged plugin in the operator environment. | L0 accepted. | Install command, transcript, installed package identity, uninstall/rollback notes if needed. |
| WP-12C-L2 - Installed Plugin Interactive Smoke Test | Run discovery, role preview, chat preview, hook smoke, controlled-output validator, and negative posture rows. | L1 passed. | Chat transcripts, hook transcripts, validator transcripts, Git hygiene after each risky row. |
| WP-12C-L3 - Install Evidence + Git Staging Decision | Decide whether install evidence is publishable and whether any files should be staged. | L2 passed. | Evidence completeness verdict, staging decision, publication decision, remaining blockers. |

L1, L2, and L3 remain blocked until their predecessor gate is accepted.

## 6. Install Evidence Fields

Do not fill these fields in L0. They are reserved for WP-12C-L1.

| Field | Required Value At L1 | Captured Value |
|---|---|---|
| Install command used | Exact operator command or UI action. | `<not-captured-in-L0>` |
| Install start timestamp | UTC timestamp. | `<not-captured-in-L0>` |
| Install end timestamp | UTC timestamp. | `<not-captured-in-L0>` |
| Installer version / provider surface | VS Code / GitHub Copilot install surface details. | `<not-captured-in-L0>` |
| Installed package identity | Plugin id, version, package path. | `<not-captured-in-L0>` |
| Install result | PASS / PARTIAL / FAIL. | `<not-captured-in-L0>` |
| Install transcript location | Path or pasted transcript reference. | `<not-captured-in-L0>` |
| Rollback / uninstall command | Exact command or UI action, if used or prepared. | `<not-captured-in-L0>` |

## 7. Post-Install Discovery Evidence Fields

Do not fill these fields in L0. They are reserved for WP-12C-L2.

| Row | Prompt / Action | Expected Behavior | Evidence Field |
|---|---|---|---|
| S1 | Show AISRAF agents exposed by the plugin. | 7 AISRAF agents listed from provider projection. | `<not-captured-in-L0>` |
| S2 | Show AISRAF skills exposed by the plugin. | 7 AISRAF Agent Skills listed from provider projection. | `<not-captured-in-L0>` |

## 8. Role Smoke Evidence Fields

Do not fill these fields in L0. Role smoke prompts are preview-only unless a
later controlled-output row explicitly authorizes a scratch write.

| Row | Role | Prompt Intent | Expected Behavior | Evidence Field |
|---|---|---|---|---|
| S3 | AISRAF Orchestrator | Preview role and run-log shape. | Explains role, paths, stop conditions, and run-log shape; no file write. | `<not-captured-in-L0>` |
| S4 | AISRAF Input Reader | Preview role. | Explains input inventory role and canonical paths; no file write. | `<not-captured-in-L0>` |
| S5 | AISRAF DFD Extractor | Preview role. | Explains visible DFD extraction, legend normalization, components, flows, and DFD subchain; no file write. | `<not-captured-in-L0>` |
| S6 | AISRAF Review Table Builder | Preview role. | Explains boundary, security-stack, and internal review table outputs; no file write. | `<not-captured-in-L0>` |
| S7 | AISRAF Blueprint Questioner | Preview role. | Explains missing facts, AI Action Level, blueprint match, and targeted questions; no file write. | `<not-captured-in-L0>` |
| S8 | AISRAF Finding Recommender | Preview role. | Explains findings and recommendation outputs; no file write. | `<not-captured-in-L0>` |
| S9 | AISRAF Handoff QA Scorer | Preview role. | Explains handoff pack, validation notes, and accuracy-score authority; no file write. | `<not-captured-in-L0>` |

## 9. Chat Preview Evidence Fields

Do not fill these fields in L0.

| Row | Skill Preview | Expected Behavior | Evidence Field |
|---|---|---|---|
| S10 | AISRAF orchestration preview. | Shows run-log output shape by path and heading hints only. | `<not-captured-in-L0>` |
| S11 | AISRAF input-read sample input/output preview. | References sample input and expected-baseline paths without duplicating canonical bodies. | `<not-captured-in-L0>` |
| S12 | AISRAF DFD extraction skill wiring preview. | Names canonical PRA, adapter, prompt, skill, and template layers. | `<not-captured-in-L0>` |

## 10. Hook Smoke Evidence Fields

Do not fill these fields in L0. Hook smoke is deferred until the plugin is
installed and the operator explicitly runs L2.

| Row | Hook Smoke | Expected Behavior | Evidence Field |
|---|---|---|---|
| S13 | Negative path: attempt a write under `runs/RUN-001/`. | Pre-write guard blocks; `runs/RUN-001/` diff remains empty. | `<not-captured-in-L0>` |
| S14 | Allowed scratch path: attempt a write under `runs/RUN-SMOKE-LOCAL-XXX/`. | Guard allows scratch path; focused validator route runs after write. | `<not-captured-in-L0>` |
| S15 | Stop-hook session summary. | Summary reports wrapper id, inputs read, outputs written, and validators invoked. | `<not-captured-in-L0>` |

## 11. Controlled-Output Evidence Fields

Do not fill these fields in L0. Controlled output, if authorized in L2, must
use a governed scratch run only and must never modify `runs/RUN-001/`.

| Row | Controlled Output Check | Expected Behavior | Evidence Field |
|---|---|---|---|
| S16 | Run scratch run-profile validator. | 12 PASS, 0 FAIL for the scratch run profile. | `<not-captured-in-L0>` |
| S17 | Run BP12A readiness validator after scratch write. | 0 FAIL; tracked drift limited to allowed scratch paths. | `<not-captured-in-L0>` |
| S18 | Negative external execution request. | Agent refuses and cites disabled posture. | `<not-captured-in-L0>` |
| S19 | Negative sealed-surface edit request. | Edit is blocked or declined; sealed surface diff remains empty. | `<not-captured-in-L0>` |
| S20 | Negative external post-back request. | Agent refuses and keeps output destination local-only. | `<not-captured-in-L0>` |

## 12. Validator Transcript Fields

| Validator / Probe | Expected Result | L0 Result | Future Evidence Field |
|---|---|---|---|
| `pwsh -NoProfile -File ./tools/Test-AisrafPackage.ps1` | 82 PASS, 1 WARN, 0 FAIL. | VERIFIED at L0. | `<L1-or-L2-transcript-path>` |
| `pwsh -NoProfile -File ./tools/Test-AisrafBp12AReadiness.ps1` | 77 PASS, 0 FAIL. | VERIFIED at L0. | `<L1-or-L2-transcript-path>` |
| `pwsh -NoProfile -File ./tools/Test-AisrafRunProfile.ps1 -RunProfilePath ./runs/RUN-001/run-profile.yaml -ExecutionReady` | 12 PASS, 0 FAIL. | VERIFIED at L0. | `<L1-or-L2-transcript-path>` |
| `pwsh -NoProfile -File ./tools/Build-AisrafCopilotPluginBundle.ps1 -Clean` | PASS, 199 files bundled, all hashes match. | VERIFIED at L0; no parser error. | `<as-needed-rebuild-transcript-path>` |

## 13. Git Staging And Publication Decision Fields

Do not stage `.claude/`. Do not run `git add .`. Do not publish to Git in L0.

| Field | Required Decision At L3 | Captured Value |
|---|---|---|
| Pre-install `git status --short` | Snapshot reviewed. | `<not-captured-in-L0-for-L3>` |
| Post-install `git status --short` | Snapshot reviewed. | `<not-captured-in-L0>` |
| `.claude/` tracked check | Empty. | `<not-captured-in-L0-for-L3>` |
| `.claude/` staged check | Empty. | `<not-captured-in-L0-for-L3>` |
| RUN-001 diff | Empty. | `<not-captured-in-L0-for-L3>` |
| Samples diff | Empty. | `<not-captured-in-L0-for-L3>` |
| Canonical/provider tracked diffs | Empty unless explicitly authorized by accepted package scope. | `<not-captured-in-L0-for-L3>` |
| Files proposed for staging | Explicit path list only. | `<not-captured-in-L0>` |
| Publication decision | BLOCKED / APPROVED BY FOUNDER. | `<not-captured-in-L0>` |

## 14. Terminal And Hook Hygiene Finding

The recurring PowerShell parser error was not reproduced by the direct L0
commands listed in Section 12. For L0, classify any continued recurrence as a
stop-hook/report-format issue unless it is later reproduced by a direct
validator, build-script, install, or smoke command.

This issue does not block WP-12C-L1 install testing at L0 because the direct
validator and build-script probes returned 0 FAIL / PASS. Do not patch hooks
inside L0 unless the issue becomes reproducible in the install path.

## 15. Stop Conditions

Stop and escalate before continuing if any condition below occurs.

| # | Stop Condition |
|---|---|
| STOP-1 | Any required artifact from Section 3 is missing. |
| STOP-2 | Any governed validator reports a non-zero FAIL count. |
| STOP-3 | The known smoke-folder WARN becomes a FAIL or expands beyond accepted local smoke posture. |
| STOP-4 | `.claude/` becomes tracked or staged. |
| STOP-5 | Anything is staged before an explicit L3 staging decision. |
| STOP-6 | `runs/RUN-001/` changes during install or smoke. |
| STOP-7 | `samples/` changes during install or smoke. |
| STOP-8 | A sealed canonical or provider projection surface is edited outside an approved package scope. |
| STOP-9 | Plugin install is attempted before L0 acceptance. |
| STOP-10 | Interactive smoke is attempted before L1 passes. |
| STOP-11 | Controlled output is attempted outside a governed scratch run. |
| STOP-12 | Any external runtime, cloud, MCP, Jira, Confluence, database, Terraform, release, diagram, Git publication, or external post-back action is attempted. |
| STOP-13 | The parser error is reproduced by a direct install, validator, build-script, or smoke command and blocks evidence capture. |

## 16. Verdict Definitions

| Verdict | Definition |
|---|---|
| PASS | K4 state confirmed; all required artifacts exist; validators return 0 FAIL; Git hygiene confirms nothing staged, `.claude/` unstaged, RUN-001 unchanged, samples unchanged, and sealed/canonical tracked diffs empty; parser issue is reproduced, dismissed, or classified; install plan exists; no install or smoke was performed. |
| PARTIAL | One or more non-blocking evidence gaps remain, but no validator FAIL, unauthorized write, install attempt, smoke attempt, staging action, or external action occurred. L1 remains blocked until gaps close. |
| FAIL | A required artifact is missing, a validator FAILs, a stop condition fires, a prohibited action occurs, or Git / fixture hygiene cannot be confirmed. L1 remains blocked. |

## 17. L0 Close Criteria

L0 may close only when:

- K4 package state is confirmed.
- Required plugin package artifacts are present.
- The three governed validators return 0 FAIL.
- Git hygiene confirms nothing staged and `.claude/` not staged.
- `runs/RUN-001/`, `samples/`, and sealed/canonical tracked diffs remain empty.
- Terminal/parser behavior is classified.
- This checklist exists.
- L1 remains blocked until founder acceptance.
- WP-13 and Git publication remain blocked.

Candidate L0 final status after successful preflight:

`WP-12C-L0_INSTALL_READINESS_PREFLIGHT_PASS_READY_FOR_LOCAL_INSTALL_TEST`

## 18. L1A Provider Install Surface Patch

L1A created provider-required `plugin.json`.
`plugin.json` points to bundled agents, bundled skills, and bundled hook config.
No MCP/external execution/post-back runtime was enabled.
True L1 install remains blocked until L1A is accepted.

L2 remains blocked until true L1 install closes. WP-13 remains blocked.

## 19. WP-12C-L2A Closeout (Installed Preview-Only Role Smoke)

L2A ran from the isolated smoke workspace
`D:/E-Way 2/AISRAF-PLUGIN-SMOKE-WORKSPACE`. The governed repo workspace
`D:/E-Way 2/AISRAF- SAS Prototype v0.1.2` was deliberately not used as the
smoke surface so local projection folders could not contaminate provider
discovery.

All seven AISRAF role previews responded preview-only:

- `@aisraf-orchestrator`
- `@aisraf-input-reader`
- `@aisraf-dfd-extractor`
- `@aisraf-review-table-builder`
- `@aisraf-blueprint-questioner`
- `@aisraf-finding-recommender`
- `@aisraf-handoff-qa-scorer`

Each role identified its responsibility and referenced the expected governed
output shape. No role wrote files. No controlled outputs executed. No
external execution claim appeared for Jira, Confluence, Lucidchart, MCP,
cloud, database, Terraform, Claude, Foundry, ADK, MAF, or external
post-back execution.

Finding Recommender is accepted with a UX caveat because output was
interleaved, not functionally wrong. The fix is captured under L2A-UX
(Section 20) and is documentation-only; no canonical / projection / fixture
content changes.

Validator results recorded at L2A close:

- `Test-AisrafPackage.ps1`: 83 PASS, 1 known smoke-folder WARN, 0 FAIL.
- `Test-AisrafBp12AReadiness.ps1`: 77 PASS, 0 FAIL.
- `Test-AisrafRunProfile.ps1 -ExecutionReady`: 12 PASS, 0 FAIL.

Known warnings carried into L2A-UX:

- `runs/RUN-SMOKE-LOCAL-001/` exists from prior local smoke and must be
  removed or excluded before any human Git staging decision at L3.
- Smoke folders must never be staged.

Final L2A status:
`WP-12C-L2A_PREVIEW_ROLE_SMOKE_PASS_READY_FOR_UX_FIX`.

## 20. WP-12C-L2A-UX Operator Usability Patch

L2A-UX is documentation-only. It patches operator guidance so a real
operator can install, discover, preview-test, and later run controlled
output without confusion. It does not run controlled-output smoke,
execute writes, modify `RUN-001`, modify samples, or modify any canonical
prompt, skill, PRA, template, catalog, blueprint, config, provider
projection, plugin bundle file, or installed plugin cache. L2A-UX does
not use VS Code "Create Plugin", does not generate diagrams, does not
publish to Git, does not stage `.claude/`, and does not run `git add .`.

### 20.1 Workspace Guidance (Where To Run What)

| Workspace | Purpose | Allowed Activity | Forbidden Activity |
|---|---|---|---|
| `D:/E-Way 2/AISRAF-PLUGIN-SMOKE-WORKSPACE` | Installed-plugin operator testing (L1, L2A, L2B). | Provider discovery, role preview prompts, controlled-output smoke after L2B authorization, Git hygiene checks scoped to that workspace. | Editing canonical sources, sealed surfaces, or validators. |
| `D:/E-Way 2/AISRAF- SAS Prototype v0.1.2` | Validation authoring and package development (the governed repo). | Editing validation docs, plugin scaffold, validators, hook scripts; running validators; capturing package evidence. | Running installed-plugin smoke from this workspace, because local `.agents/`, `.copilot-skills/`, `.github/agents/`, `.github/skills/`, `.github/hooks/` projections can contaminate provider discovery. |

Falsifier: any L2 evidence row sourced from the governed repo workspace
fails L2A-UX. Re-run from the smoke workspace and recapture the row.

### 20.2 UI / Provider Explanation

Operators must read the provider behaviour notes below before treating
any UI count as failure evidence.

| Surface | Expected Behaviour | Why It Is Not A Failure |
|---|---|---|
| Copilot CLI plugin install report | May report success even when VS Code Local → Plugins shows no plugin. | Copilot CLI and VS Code Local read different provider registries; the Copilot CLI report is authoritative for L1A install evidence. |
| VS Code Agent Customizations panel | May show different agent / skill / hook counts vs. Copilot CLI. | Local and Copilot CLI providers discover different surfaces (`.agents/`, `.github/agents/`, `.github/skills/`, `.github/hooks/`, `.copilot-skills/`). Different counts are expected and are not drift unless a canonical surface is missing. |
| VS Code "Create Plugin" command | Must not be used for this governed package. | The plugin is a projection bundle authored by `tools/Build-AisrafCopilotPluginBundle.ps1`; "Create Plugin" would author plugin content outside the governed package. Use only the K3C build script. |

Falsifier: any L2 evidence row that treats a provider count divergence as
a defect without checking the canonical / provider projection diffs first
fails L2A-UX. Compare the registry counts to the canonical sources before
filing a defect.

### 20.3 Terminal And Evidence Capture Guidance

| # | Requirement | Why |
|---|---|---|
| TERM-1 | Use a large terminal pane or the editor-area terminal. | Role preview output is multi-section; small panes interleave headings. |
| TERM-2 | Increase terminal scrollback before starting a smoke. | Role preview output exceeds default scrollback for some shells. |
| TERM-3 | Capture screenshots or copy / paste output after each role preview. | Evidence must be reviewable after the session ends. |
| TERM-4 | Run one role prompt at a time. | Concurrent prompts interleave provider output and break per-role attribution. |
| TERM-5 | Stop if output is interleaved beyond reviewability. | Continuing produces evidence that cannot be attributed to a specific role and fails L2 review. |
| TERM-6 | Record the workspace path in the evidence row. | The same role prompt is invalid evidence if captured from the governed repo workspace. |

Falsifier: any L2 evidence row missing terminal posture (workspace path,
capture method, single-role attribution) fails L2A-UX.

### 20.4 L2A Role-Smoke Runbook (Seven Preview-Only Prompts)

Run each role from the Copilot Chat agent dropdown inside the smoke
workspace. Use the role smoke prompt body documented in
`validation/role-smoke-test-checklist.md` Section "L2A Role-Smoke Runbook".
Each prompt is preview-only and must satisfy the six expected-evidence
items below. Mark a row PASS only when every item is satisfied.

| Role Selection | Expected Evidence (per row) |
|---|---|
| `@aisraf-orchestrator` | Role responds; identifies orchestration responsibility; references theoretical `runs/{{run_id}}/00-run-log.md`; stays preview-only; no files written; no external execution claim. |
| `@aisraf-input-reader` | Role responds; identifies input-inventory responsibility; references theoretical `runs/{{run_id}}/01-input-inventory.md`; stays preview-only; no files written; no external execution claim. |
| `@aisraf-dfd-extractor` | Role responds; identifies DFD extraction + legend normalization; references theoretical `02-..-05-*.md` and `dfd/01-..-09-*.md` paths; stays preview-only; no files written; no external execution claim. |
| `@aisraf-review-table-builder` | Role responds; identifies boundary / security-stack / review-table responsibility; references theoretical `06`, `07`, `08` paths; stays preview-only; no files written; no external execution claim. |
| `@aisraf-blueprint-questioner` | Role responds; identifies missing-fact / AAL / blueprint match / targeted-question responsibility; references theoretical `09`, `10`, `11`, `12` paths; stays preview-only; no files written; no external execution claim. |
| `@aisraf-finding-recommender` | Role responds; identifies finding + recommendation responsibility; references theoretical `13`, `14` paths; stays preview-only; no files written; no external execution claim. UX caveat: output may interleave; record the screenshot and continue if the role identity and output shape are still attributable. |
| `@aisraf-handoff-qa-scorer` | Role responds; identifies handoff-pack / validation-note / accuracy-score responsibility; references theoretical `15`, `16`, `17` paths; stays preview-only; no files written; no external execution claim. |

Six expected-evidence items per row:

1. Role responds.
2. Role identifies its responsibility.
3. Role references the expected governed output shape.
4. Role stays preview-only.
5. No files written.
6. No external execution claim.

### 20.5 L2B Controlled-Output Readiness (Blockers)

L2B remains BLOCKED until every item below is satisfied.

| # | Required For L2B Open | Status At L2A-UX |
|---|---|---|
| L2B-R1 | L2A-UX accepted (`WP-12C-L2A_UX_RUNBOOK_PASS_READY_FOR_L2B_PLANNING`). | Pending acceptance. |
| L2B-R2 | Controlled-output run path chosen and recorded. | Not chosen. |
| L2B-R3 | Exact scratch output folder approved (must match `runs/RUN-[A-Z0-9][A-Z0-9-]*/...`, must not be `runs/RUN-001/`, must not be `samples/`). | Not approved. |
| L2B-R4 | Prewrite guard command(s) specified for the chosen scratch path. | Not specified. |
| L2B-R5 | Focused validator command(s) specified for the chosen scratch outputs. | Not specified. |
| L2B-R6 | Founder explicit approval on L2B brief. | Not requested. |

L2B-forbidden writes (do not relax):

- No write under `runs/RUN-001/`.
- No write under `samples/`.
- No write under canonical surfaces (`prompts/`, `skills/`, `prototype-agents/`, `templates/`, `catalogs/`, `blueprints/`, `config/`, `.agents/`).
- No write under provider projections (`.github/agents/`, `.github/skills/`, `.github/hooks/`, `.copilot-skills/`).
- No write under plugin bundle (`plugins/aisraf-copilot-plugin/bundle/`).
- No external post-back execution.

### 20.6 Future Integration Boundary (Stay Future)

The integrations below are governed adapter paths planned for future work
packages. They are not active in L2A and are not active in L2B.

| Integration | Future Work Package | L2A Posture | L2B Posture |
|---|---|---|---|
| Jira | post-WP-15 governed adapter | Not active. | Not active. |
| Confluence | post-WP-15 governed adapter | Not active. | Not active. |
| Lucidchart | post-WP-13 documentation adapter | Not active. | Not active. |
| MCP | WP-15 strategy first | Not active. | Not active. |
| Anthropic Claude (runtime / Code / SDK) | WP-15 strategy first | Not active. | Not active. |
| Azure AI Foundry | WP-15 strategy first | Not active. | Not active. |
| Google ADK | WP-15 strategy first | Not active. | Not active. |
| Microsoft Agent Framework (MAF) | WP-15 strategy first | Not active. | Not active. |
| Database | post-WP-15 governed adapter | Not active. | Not active. |
| Terraform | post-WP-15 governed adapter | Not active. | Not active. |
| External post-back execution | post-WP-15 governed adapter | Not active. | Not active. |

Falsifier: any L2A or L2B evidence row that claims one of the rows above
is "implemented", "ready", "deployed", "configured for live use",
"executed", or "post-backed" fails L2A-UX. Mark such rows as future
governed adapter paths only and recapture.

### 20.7 Git / Version-Control Hygiene (Always)

| # | Rule | Why |
|---|---|---|
| GIT-1 | Do not run `git add .`. | Stages unintended files (notably `.claude/`, smoke folders). |
| GIT-2 | Do not stage `.claude/`. | Local-only by `.gitignore`; staging it pollutes the repo. |
| GIT-3 | Do not stage smoke folders. | `runs/RUN-SMOKE-LOCAL-*` is local smoke evidence, not solution-package evidence. |
| GIT-4 | Resolve `runs/RUN-SMOKE-LOCAL-001/` warning before L3. | The known package validator WARN must be cleared (remove the folder or extend the validator's smoke-folder ignore list, both gated on L3 approval). |
| GIT-5 | L3 is the first gate that may decide staging or publication. | L0–L2 are read / preview / smoke only; L3 is the publication-decision gate. |

L3 staging decision is bound by the `validation/package-12c-plugin-install-and-publication-checklist.md` §13 fields and must record the resolution of the smoke-folder warning before any `git add` is run.

## 21. WP-12C-L2A-UX Closeout

L2A-UX may close only when:

- Sections 20.1 through 20.7 are present and consistent with this checklist, the manual operator test guide, the quick manual test card, the operator experience plan, and the role smoke checklist.
- All three governed validators return 0 FAIL after L2A-UX edits.
- Git hygiene confirms nothing staged, `.claude/` untracked and unstaged, `RUN-001` unchanged, samples unchanged, sealed canonical / provider projection diffs empty, and only validation / plugin doc patches are in the working set.
- L2B remains BLOCKED until §20.5 items clear.
- WP-13 remains BLOCKED.

Candidate L2A-UX final status:

`WP-12C-L2A_UX_RUNBOOK_PASS_READY_FOR_L2B_PLANNING`

## 22. WP-12C-L2B-UXA Security Architect Operator Journey + Consumer Workspace Addendum

L2B-UXA is documentation-only. It explains how a security architect uses
AISRAF as a local review assistant before controlled scratch-output execution
is approved. L2B execution remains blocked until the founder explicitly
approves the controlled-output run.

### 22.1 What AISRAF Is

AISRAF is a local security architecture and design-review assistant. It helps
a security architect review DFD and design-review packages, identify missing
facts, prepare targeted questions, build a data-flow review table, draft
findings and recommendations, and assemble local handoff evidence.

Current capability is local-only:

- Local preview through the installed AISRAF plugin.
- Local controlled-output generation only after explicit L2B approval.
- Local validation and Git hygiene checks.

AISRAF does not currently execute Jira, Confluence, Lucidchart, MCP, cloud
runtime, database, Terraform, release, or external post-back actions. Claude
runtime adapters, Azure AI Foundry, Google ADK, and Microsoft Agent Framework
are future strategy surfaces only.

### 22.2 First-Run User Experience

For product proof, open the isolated smoke workspace:

```text
D:/E-Way 2/AISRAF-PLUGIN-SMOKE-WORKSPACE
```

The smoke workspace may be empty. Empty is expected and useful: it proves the
installed plugin is loading from the plugin source or provider cache, not from
workspace-local customization folders. Do not copy `.agents/`,
`.github/agents/`, `.github/skills/`, `.github/hooks/`, or `.copilot-skills/`
into the smoke workspace for product proof.

Use VS Code Local as the primary proof surface. Copilot CLI remains a separate
secondary provider path because it can retain installed-plugin state and
user/global customizations.

### 22.3 Plugin vs User vs Workspace Agents

| Source | Meaning | Counts As Product Proof? |
|---|---|---|
| Plugin agents | Agents shipped by `aisraf-copilot-plugin`. Use these for AISRAF product proof. | Yes |
| User agents | Personal or global user customizations. | No |
| Workspace agents | Repo or project customizations under a workspace. | No |
| Built-in agents | Default Copilot / VS Code agents. | Expected background surface |
| eWay agents | Personal main-profile agents. | No; not an AISRAF plugin failure |

Duplicate-looking AISRAF agents are acceptable only when their source is
separated and the plugin-provided AISRAF agents are visible. eWay agents should
not appear in the clean Local provider proof surface; if they appear from User
or global scope, document them as user-profile noise rather than a plugin
failure.

### 22.4 Security Architect Workflow

Current local-only workflow:

1. Receive a design-review or Jira request.
2. Gather the DFD, design notes, ticket text, triage notes, and transcript
  locally.
3. Place or stage the input package under the approved local input root.
4. Run preview-only role smoke from the isolated smoke workspace.
5. Generate pre-design-review questions.
6. Generate the review table.
7. Generate findings and recommendations.
8. Generate the handoff pack and validation notes.
9. Keep outputs local under the approved run folder.

Future adapter workflow, not active in L2B:

1. Jira ticket or design request.
2. Attached DFD, Lucidchart export, design docs, and transcript.
3. AISRAF input package.
4. Targeted pre-review questions.
5. Design-review support.
6. Updated DFD or transcript intake.
7. Final findings and recommendations.
8. Confluence or Jira post-back performed only by a future governed adapter or
  human operator with recorded evidence.

Future-only surfaces: Jira attachment read, Confluence page write, Lucidchart
direct read, MCP execution, cloud runtime, database, Terraform, Azure AI
Foundry, Google ADK, Microsoft Agent Framework, Claude runtime adapter, and
external post-back.

### 22.5 Input Package Model

Current local inputs include:

- DFD image or source.
- DFD legend.
- Intake ticket text.
- Cloud triage notes.
- Review transcript.
- Supporting notes.

Current sample source:

```text
./samples/sample-001-dfd-crop/inputs/
```

Future L2B scratch input staging:

```text
./runs/RUN-SMOKE-PLUGIN-L2B-001/inputs/
```

### 22.6 Output and Logging Model

L2B execution, when explicitly approved, writes only under:

```text
./runs/RUN-SMOKE-PLUGIN-L2B-001/
```

Expected local outputs:

```text
00-run-log.md
01-input-inventory.md
02-visible-dfd-objects.md
03-legend-normalization.md
04-components.md
05-flows.md
06-boundaries.md
07-security-stack-assessment.md
08-internal-review-table.md
09-missing-facts.md
10-ai-action-level.md
11-blueprint-match.md
12-targeted-questions.md
13-findings.md
14-recommendations.md
15-handoff-pack.md
16-validation-notes.md
17-accuracy-score.md
dfd/01-intake-quality-check.md
dfd/02-boundary-catalog.md
dfd/03-component-catalog.md
dfd/04-flow-inventory.md
dfd/05-annotation-resolution.md
dfd/06-boundary-crossings.md
dfd/07-control-signals.md
dfd/08-confidence-score.md
dfd/09-extraction-summary.md
```

`00-run-log.md` must record: `run_id`, `mode`, `input_root`, `output_root`,
roles invoked, files read, files written, guard results, focused validator
results, stop conditions, external execution status, and final PASS / PARTIAL /
FAIL summary.

### 22.7 Type Checking and Validation

Required checks:

- Plugin manifest and schema validation.
- `plugin.json` root detection and field validation.
- Skill folder and `SKILL.md` validation.
- Agent file and frontmatter validation.
- Run-profile schema validation.
- Output-template name validation.
- Hook allow-list validation.
- Positive external-execution claim lint.
- Protected surface diff check.

Required validators for L2B execution evidence:

```powershell
pwsh -NoProfile -File ./tools/Test-AisrafPackage.ps1
pwsh -NoProfile -File ./tools/Test-AisrafBp12AReadiness.ps1
pwsh -NoProfile -File ./tools/Test-AisrafRunProfile.ps1 -RunProfilePath ./runs/RUN-SMOKE-PLUGIN-L2B-001/run-profile.yaml -ExecutionReady
```

Required Git hygiene:

```powershell
git status --short
git diff --name-only
git diff --staged --name-only
git ls-files -- .claude
git diff --cached --name-only -- .claude
git diff -- runs/RUN-001/
git diff -- samples/
git diff -- prompts/ skills/ prototype-agents/ templates/ catalogs/ blueprints/ config/ .agents/ .github/agents/ .github/skills/ .github/hooks/ .copilot-skills/
```

### 22.8 Evidence Capture

Acceptable evidence:

- Copied terminal output.
- Screenshots.
- Saved transcript text.
- Validator transcript.
- Git hygiene transcript.

Recommended terminal setting:

```json
"terminal.integrated.scrollback": 50000
```

Use the terminal in the editor area, run one role at a time, do not run
parallel role prompts, and stop if output becomes unattributable.

### 22.9 L2B Execution Readiness

L2B execution may proceed only after:

- UXA patch accepted.
- L2B plan accepted.
- Exact scratch folder approved.
- Exact output list approved.
- Prewrite guard sequence approved.
- Focused validator sequence approved.
- Final validator ladder approved.
- Explicit founder approval granted.

Known non-blocking warning: `runs/RUN-SMOKE-LOCAL-001/` exists beside
`RUN-001`. Do not remove it in UXA. Keep it as an L3 cleanup / staging hygiene
item. Do not stage smoke folders.

### 22.10 Role Guide For Security Architects

| Role | Business Value | When To Use | Reads | May Write During L2B | Must Not Claim | Evidence To Capture |
|---|---|---|---|---|---|---|
| `@aisraf-orchestrator` | Coordinates local review chain and run log. | Start or close a run. | Run profile and prior run evidence. | `00-run-log.md` | Runtime, cloud, Jira, Confluence, MCP, release, or post-back execution. | Role response, run-log guard and validator results. |
| `@aisraf-input-reader` | Builds the input inventory. | After inputs are staged. | Input package and run profile. | `01-input-inventory.md` | Moving chat attachments or inventing requester forms. | Inventory output and validator result. |
| `@aisraf-dfd-extractor` | Extracts visible DFD facts and preserves unknowns. | When DFD inputs are available. | DFD image/source, legend, notes, transcript. | `02` through `05`, plus `dfd/01` through `dfd/09`. | Diagram generation, hidden inference, or runtime proof. | DFD outputs, unknown handling, guard and validator results. |
| `@aisraf-review-table-builder` | Builds boundary, security-stack, and review-table evidence. | After DFD facts exist. | Components, flows, boundaries, control signals. | `06-boundaries.md`, `07-security-stack-assessment.md`, `08-internal-review-table.md` | Approved-control claims without evidence. | Review table, security-stack rows, validator result. |
| `@aisraf-blueprint-questioner` | Identifies missing facts, AI Action Level posture, blueprint match, and targeted questions. | Before or during design review. | Prior RS outputs and blueprints/catalog references. | `09` through `12`. | AAL or blueprint decisions without evidence. | Missing facts, questions, match evidence, validator result. |
| `@aisraf-finding-recommender` | Drafts findings and recommendations tied to evidence. | After review table and questions are available. | Boundary, stack, review table, missing facts, blueprint outputs. | `13-findings.md`, `14-recommendations.md` | Owner, implementation proof, or evidence invention. | Finding IDs, parent recommendation links, validator result. |
| `@aisraf-handoff-qa-scorer` | Builds handoff pack, validation notes, and governed accuracy score. | At closeout, after prior outputs exist. | Outputs `08` through `16` and expected baselines when scoring is enabled. | `15-handoff-pack.md`, `16-validation-notes.md`, `17-accuracy-score.md` | Numeric score without scoring gates or baseline edits. | Handoff pack, validation notes, scoring eligibility, validator result. |

### 22.11 DFD Review Annotation Requirements

Data-flow outputs should preserve: data classification, source, destination,
trust or boundary crossing, authentication signal, authorization signal,
encryption in transit, encryption at rest for stores, logging / monitoring /
control evidence, and unknown values carried forward rather than invented.

## 23. WP-12C-L2B-UXA Close Criteria

L2B-UXA may close only when this addendum is present, validators return 0 FAIL,
Git hygiene confirms protected surfaces remain unchanged, L2B execution remains
blocked pending founder approval, L3 remains blocked, and WP-13 remains
blocked.

Candidate L2B-UXA final status:

`WP-12C-L2B_UXA_OPERATOR_JOURNEY_PASS_READY_FOR_L2B_EXECUTION_APPROVAL`