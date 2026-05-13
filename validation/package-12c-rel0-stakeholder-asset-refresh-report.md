# WP-12C-REL0-STAKEHOLDER-ASSET-REFRESH — Gate Report

| Field | Value |
|---|---|
| Document | validation/package-12c-rel0-stakeholder-asset-refresh-report.md |
| Authority | WP-12C-REL0-STAKEHOLDER-ASSET-REFRESH |
| Release | AISRAF v0.1.2 (current public source-available evaluation-only baseline) |
| Predecessor gate | WP-12C-REL0-PLUGIN-INSTALL-UX-PACKAGING (PASS at HEAD `0b971d3`) |
| Posture | Public source-available evaluation-only proof-of-concept. Not open source. Not production software. Not marketplace-published. |
| Asset scope | One consolidated public Evaluation Guide (DOCX + PDF) plus SHA-256 checksum file, all written outside the repository |

## 1. Mission Recap

Refresh and QA the external GitHub pre-release stakeholder / public evaluation assets so they match the latest repo state after:

- The operating-flow rebase (Local Orchestrated Review, Run Observability, Release QA Flow, Connected Review Flow, Threat Intelligence Enrichment, Mermaid Diagram Generation, Plugin Install UX);
- The cross-shell command UX gate (PowerShell 7, Windows PowerShell 5.1, Git Bash invoking `powershell.exe`); and
- The plugin install UX packaging gate.

The legacy public `Mode 0 / 1 / 2 / 3 / 4` numbered list is retired from public-instruction language; `AM` / `AL` / `Mode N` remain only as **internal architecture / evidence vocabulary** inside contracts, runtime files, and validation artifacts.

DOCX / PDF / PPTX / ZIP files remain GitHub pre-release assets only — they are **not** committed into the repository.

## 2. work_package_status

`WP12C_REL0_STAKEHOLDER_ASSET_REFRESH_PASS_READY_FOR_FINAL_PUBLIC_QA`.

## 3. source_docs_read

The consolidated Evaluation Guide was authored from the following repository source documents (read-only; no repo doc edits required by this gate):

- `README.md`
- `START-HERE.md`
- `docs/COMMANDS.md`
- `docs/AISRAF-PRIMER.md`
- `docs/OPERATOR-QUICKSTART.md`
- `docs/SECURITY-REVIEW-WORKFLOW.md`
- `docs/ARCHITECTURE-OVERVIEW.md`
- `docs/ROADMAP.md`
- `docs/PLUGIN-INSTALL-UX-PLAN.md`
- `docs/PRODUCT-FLOW-ROADMAP.md`
- `docs/PROMPTS-SKILLS-AGENTS-TESTING-GUIDE.md`
- `plugins/aisraf-copilot-plugin/README.md`
- `diagrams/release-v0.1.2/png/` (15 governed PNGs)

## 4. asset_folder

`D:\E-Way 2\AISRAF-v0.1.2-github-prerelease-assets\`.

The asset folder exists, is outside the repository tree, and is not tracked by git. The folder additionally holds two pre-existing companion assets from the prior `WP-12C-REL0-GITHUB-PRERELEASE-STAKEHOLDER-ASSET-PACK` gate (`AISRAF-v0.1.2-Prompts-Skills-Agents-Test-Guide.docx/.pdf` and `AISRAF-v0.1.2-Stakeholder-Evaluation-Pack.docx/.pdf`) which were not modified by this gate.

## 5. assets_created_or_refreshed

| Asset | Path | Bytes | Status |
|---|---|---|---|
| Consolidated Evaluation Guide (DOCX) | `D:\E-Way 2\AISRAF-v0.1.2-github-prerelease-assets\AISRAF-v0.1.2-Evaluation-Guide.docx` | 24,264,659 | **Refreshed.** |
| Consolidated Evaluation Guide (PDF) | `D:\E-Way 2\AISRAF-v0.1.2-github-prerelease-assets\AISRAF-v0.1.2-Evaluation-Guide.pdf` | 4,558,122 | **Refreshed.** |
| SHA-256 checksum file | `D:\E-Way 2\AISRAF-v0.1.2-github-prerelease-assets\AISRAF-v0.1.2-Evaluation-Guide.sha256.txt` | 205 | **Created.** |
| Build script (outside repo, not committed) | `D:\E-Way 2\AISRAF-v0.1.2-github-prerelease-assets\_build-evaluation-guide.ps1` | 51,908 | **Created (build-time tooling, not a release asset).** |

The prior `_build-stakeholder-asset-pack.ps1` and the two pre-existing companion DOCX/PDF asset sets are unchanged. The two May-12 versions of the Evaluation Guide DOCX/PDF were overwritten in place by the rebuild.

## 6. asset_sha256

```
a022345ba139cd72f6ab05b9c77994a09f84e67954ebd8db7c344c0bd9055326  AISRAF-v0.1.2-Evaluation-Guide.docx
b92712d4eab8b44473737b618a9d6fce6a4504280ddfc413a17553b5dfdda9ad  AISRAF-v0.1.2-Evaluation-Guide.pdf
```

## 7. docx_status

PASS. DOCX opens through Word COM (used by the build script), is well-formed, and renders the 9-section consolidated guide plus the 4-diagram visual orientation page following the cover. Word-reported document statistics:

- Pages: 90.
- Words: 4,234.

## 8. pdf_status

PASS. PDF magic header is `%PDF-1.7`. PDF opens, is well-formed, and renders identically to the DOCX through Word's `wdFormatPDF` export path. PDF size is 4,558,122 bytes (4.6 MB) — large enough to carry the 15 embedded high-resolution diagrams and small enough for stakeholder email distribution.

## 9. pdf_page_count

90 pages (Word-reported `wdStatisticPages`; cross-checked against a raw scan of `/Type /Page` objects inside the PDF stream which also returned 90).

## 10. diagram_status

PASS. 15 governed diagrams from `diagrams/release-v0.1.2/png/` are embedded inline in both DOCX and PDF as base64 data URIs (so the DOCX is portable and does not break on another machine). Every required visual is present:

| Required visual | Embedded? |
|---|---|
| V-00 AISRAF Customer Story Flow | yes |
| V-02 AISRAF Package Map / Read Order | yes |
| V-03 Stakeholder Reading Path | yes |
| V-04 Evidence Pack vs Capability Roadmap vs Drift Baseline | yes |
| V-10 DFD Annotation Legend Card | yes |
| V-11 Annotated DFD Example | yes |
| Local Review Context (M1-CTX) | yes |
| Local Review Input-to-Output DFD (M1-DFD) | yes |
| Local Review Operator Run Sequence (M1-SEQ) | yes |
| Run Observability / Runtime Evidence Flow (M2-FLOW) | yes |
| Release QA / Commit Gate Flow (M3-FLOW) | yes |
| Future Boundary and Non-Claim (M4-BND) | yes |
| V-23 Release Package Structure | yes |
| V-24 Validation Ladder | yes |
| V-25 Publication and License Boundary | yes |

Diagrams are rendered at PNG resolution (governed source PNGs); CSS limits image width to 92% of the page so captions remain readable on PDF.

## 11. persona_coverage_status

PASS. Section 3 of the guide covers all five required stakeholder journeys in a single consolidated artifact:

- 3.1 New evaluator.
- 3.2 Application architect / solution architect (shift-left pre-review).
- 3.3 Security architect (post-design review).
- 3.4 Maintainer / release validator.
- 3.5 Plugin / package evaluator.

The consolidated guide cleanly covers all five personas; no separate persona books were created.

## 12. prompts_skills_agents_coverage_status

PASS. Section 7 of the guide covers:

- The surface map (prompts, skills, prototype agents, provider projections, plugin scaffold, catalogs, blueprints, templates).
- Agent entrypoints and roles, with `@aisraf-orchestrator` documented as the recommended first contact and the six specialist agents documented as supporting / targeted helper roles.
- The prompt → skill → agent → output traceability principle.
- Provider projections as local / package surfaces (not marketplace publication).
- What prompts, skills, and agents explicitly do **not** do (no external adapter execution, no writes outside the approved run folder, no scoring outside `SK-ACCURACY-SCORE`, no hardcoding of run-profile values).

## 13. plugin_install_ux_coverage_status

PASS. Section 5.4 documents Plugin Install UX (Flow 7) as **planned** for v0.1.3 onward, including the five governed install gates from `docs/PLUGIN-INSTALL-UX-PLAN.md` (local repo install — current; clean workspace install; packaged plugin install; marketplace / private distribution evaluation; upgrade / uninstall path). Section 3.5 routes plugin / package evaluators through `plugins/aisraf-copilot-plugin/README.md` and the package validator's bundle-checksum checks (16, 16a, 16b, 16c).

## 14. cross_shell_command_coverage_status

PASS. Section 2.2 reproduces the canonical cross-shell command table from `docs/COMMANDS.md` for the three most common commands (package validator, new personal run folder, run-profile validator) across the three supported shells: PowerShell 7 (`pwsh`), Windows PowerShell 5.1 (`powershell.exe`), and Git Bash invoking `powershell.exe`. The guide tells the evaluator that the `-ExecutionPolicy Bypass` flag applies per-command and must not be used to change the machine policy.

## 15. license_posture_status

PASS. The cover page, Section 1.1, and Section 9.1 all state the license / notice posture as **public source-available evaluation-only proof-of-concept**, **not open source**, **not production software**, and **not marketplace-published**. The guide does not assert any OSI-approved license. The guide does not grant production use, commercial use, redistribution, hosted-service offering, or marketplace publication rights.

## 16. overclaim_scan_status

PASS. Posture and overclaim scans against the rendered DOCX text returned the expected results:

- "public source-available evaluation-only" — **present** (positive claim).
- "Not open source" — **present** (negation).
- "Not production software" — **present** (negation).
- "Not marketplace-published" — **present** (negation).
- "closed-loop autonomy is out of scope" — **present** (negation).
- `@aisraf-orchestrator` documented as recommended entry point — **present**.
- `runs/<run_id>/` guidance present — **present**.
- "Do not use `runs/RUN-001/` [for personal reviews]" — **present**.
- "user runs AM3" — present only inside the negation "No public 'user runs AM3' instruction."
- "marketplace install" — present only in negations ("No marketplace install" and "There is no marketplace install").
- `AL5` — present only in negations ("AL5 closed-loop autonomy is out of scope", "(Internal vocabulary: AL5.)").
- Public `Mode 0/1/2/3/4` numbered list — **not present**.
- "live Jira" / "live Confluence" / "live Lucid" execution claims — **not present**.
- Direct PNG/PDF DFD reading claim — **not present**; explicit non-claim is present in Section 6.1.

## 17. binary_tracking_status

PASS. `git ls-files -- "*.docx" "*.pdf" "*.pptx" "*.zip"` returned **empty** before and after this gate. No DOCX / PDF / PPTX / ZIP file is committed. The refreshed Evaluation Guide DOCX, PDF, and the SHA-256 checksum file all live **outside** the repository tree, in `D:\E-Way 2\AISRAF-v0.1.2-github-prerelease-assets\`.

## 18. validator_results

| Validator | Expected | Observed | Status |
|---|---|---|---|
| `tools/Test-AisrafPackage.ps1` | 83 PASS, 3 WARN, 0 FAIL | 83 PASS, 3 WARN, 0 FAIL | PASS |
| `tools/Test-AisrafBp12AReadiness.ps1` | 77 PASS, 0 FAIL | 77 PASS, 0 FAIL | PASS |
| `tools/Test-AisrafRunProfile.ps1 -RunProfilePath ./runs/RUN-001/run-profile.yaml -ExecutionReady` | 12 PASS, 0 FAIL | 12 PASS, 0 FAIL (level=ExecutionReady) | PASS |
| `tools/Test-AisrafAm3Runtime.ps1 -ContractsOnly` | 4 PASS, 0 FAIL | 4 PASS, 0 FAIL | PASS |
| `tools/Test-AisrafAm3Runtime.ps1 -RunProfilePath ./runs/RUN-SMOKE-AM3-001/run-profile.yaml` | 23 PASS, 0 FAIL | 23 PASS, 0 FAIL | PASS |

The three WARN rows from the package validator are the three accepted local-only smoke folders (`runs/RUN-SMOKE-AM3-001/`, `runs/RUN-SMOKE-LOCAL-001/`, `runs/RUN-SMOKE-PLUGIN-L2B-001/`). They are local-only and do not block the gate.

The package validator's validation-folder allow-list (Check `11-validation-allowed`) was extended by exactly one entry — `package-12c-rel0-stakeholder-asset-refresh-report.md` — to accept this gate report. The PASS count remains 83 because the allow-list entry only changes what filenames are accepted; it does not add a new check row. The plugin bundle was rebuilt through the governed builder (`tools/Build-AisrafCopilotPluginBundle.ps1 -Clean`) so the bundle checksum manifest revalidates against the surgically-patched `tools/Test-AisrafPackage.ps1`.

## 19. run001_status

PASS. `runs/RUN-001/` is unchanged in this gate. `git diff -- runs/RUN-001/` returns empty.

## 20. samples_status

PASS. `samples/` is unchanged in this gate. `git diff -- samples/` returns empty.

## 21. canonical_surface_status

PASS. Canonical surfaces (`prompts/`, `skills/`, `prototype-agents/`, `catalogs/`, `blueprints/`, `templates/`, `config/`, `.agents/`) are unchanged in this gate.

## 22. projection_surface_status

PASS. Provider projection surfaces (`.github/agents/`, `.github/skills/`, `.github/hooks/`, `.copilot-skills/`) are unchanged. The `plugins/aisraf-copilot-plugin/bundle/` was rebuilt through the governed bundle builder only because the surgical allow-list patch landed in `tools/Test-AisrafPackage.ps1`, which is one of the files projected into the bundle.

## 23. plugin_metadata_status

PASS. `plugins/aisraf-copilot-plugin/plugin.json` and `plugin.yaml` are unchanged. The plugin bundle's `bundle-checksum-manifest.yaml` was regenerated through the governed builder so the manifest's recorded source/target SHA-256 values match the surgically-patched `tools/Test-AisrafPackage.ps1`.

## 24. remaining_blockers

None for this gate. The next gate is `WP-12C-REL0-FINAL-PUBLIC-QA`. AM4 adapter work, push, tag, GitHub Release, and marketplace publication remain blocked / future until their explicit gates pass.

## 25. may_FINAL_PUBLIC_QA_PROCEED

**Yes.** The Evaluation Guide is refreshed, posture is correct, all five validators are green at expected counts, no protected surfaces were touched outside the allowed bundle rebuild path, and no DOCX/PDF/PPTX/ZIP binary is tracked.

## 26. may_PUSH_PREP_PROCEED

**No.** Push prep is gated by `WP-12C-REL0-FINAL-PUBLIC-QA` (the next gate) and `REL0-STAGE-COMMIT`. This gate does not authorize push prep.

## 27. may_PUSH_PROCEED

**No.** Push remains blocked.

## 28. exact_next_gate

`WP-12C-REL0-FINAL-PUBLIC-QA`.

## 29. References

- `docs/PRODUCT-FLOW-ROADMAP.md` — public seven-flow operating model used as the consolidated guide's structural backbone.
- `docs/PLUGIN-INSTALL-UX-PLAN.md` — Plugin Install UX (Flow 7) gates summarised in Section 5.4 of the guide.
- `docs/CONNECTED-REVIEW-FLOW-PLAN.md` — Connected Review Flow (Flow 4) plan summarised in Section 5.1 of the guide.
- `docs/THREAT-INTELLIGENCE-ENRICHMENT-PLAN.md` — Threat Intelligence Enrichment (Flow 5) plan summarised in Section 5.2 of the guide.
- `docs/COMMANDS.md` — cross-shell command table reproduced in Section 2.2 of the guide.
- `validation/package-12c-rel0-github-prerelease-stakeholder-asset-pack-report.md` — prior accepted gate report for the companion DOCX/PDF assets (Prompts/Skills/Agents Testing Guide and Stakeholder Evaluation Pack) that remain unchanged in this gate.
- `validation/package-12c-rel0-plugin-install-ux-packaging-report.md` — accepted predecessor gate.
