# AISRAF Product Flow Roadmap

| Field | Value |
|---|---|
| Document | docs/PRODUCT-FLOW-ROADMAP.md |
| Authority | WP-12C-REL0-PRODUCT-FLOW-ADAPTER-ROADMAP-REBASE |
| Release | AISRAF v0.1.2 (current public source-available evaluation-only baseline) |
| Successor releases | v0.1.3 UX cleanup; v0.2.0 Connected Review Flow; v0.2.1 Threat Intelligence Enrichment; v0.3.0 runtime/observability backend |
| Posture | Public source-available evaluation-only proof-of-concept. Not open source. Not production software. Not marketplace-published. |
| Out of scope | AL5 closed-loop autonomy. Online execution of Jira, Confluence, Lucidchart, Rovo/MCP, cloud, database, Terraform, event bus, telemetry, or external post-back in v0.1.2. |

## 1. Why This Document Exists

Earlier AISRAF documentation described the product as a set of `Mode 0`, `Mode 1`, `Mode 2`, `Mode 3`, and `Mode 4` lanes. That framing collapsed several distinct ideas — preview, the user workbench, runtime evidence, maintainer QA, and future adapter execution — into one numbered list and treated them as if they were equivalent public modes of the application.

That language is being retired for public use because most of those entries are not real, user-facing application modes. They are either internal architecture/evidence vocabulary (AM3 / AL3), maintainer-only release plumbing, or future feature lanes. Naming them `Mode 1` through `Mode 4` in the same table as the everyday user flow caused readers to mistake release evidence and maintainer plumbing for switchable application states.

This roadmap defines the replacement: a small set of named product flows, each scoped to a real audience and a real action, with explicit current and future status.

## 2. The Seven Product Flows

AISRAF as a product is the sum of these seven flows:

1. **Local Orchestrated Review** — the normal AISRAF user flow.
2. **Run Observability / Runtime Evidence** — captured alongside Local Orchestrated Review.
3. **Release QA Flow** — maintainer-only.
4. **Connected Review Flow** — next planned feature lane (v0.2.0).
5. **Threat Intelligence Enrichment** — planned feature lane (v0.2.1).
6. **Mermaid Diagram Generation** — planned feature lane that produces a corrected Mermaid DFD from the extracted architecture facts as a review aid.
7. **Plugin Install UX** — dedicated packaging flow (v0.1.3 onward).

Closed-loop autonomy (autonomous decision and action without operator-in-the-loop) is **not** one of these flows. It is **out of scope** for AISRAF, including v0.1.x, v0.2.x, and v0.3.x.

The legacy `AM`, `AL`, and `Mode N` vocabulary is retained inside validation artifacts, contracts, and runtime evidence files as internal architecture/evidence vocabulary. It is no longer the public way users describe what AISRAF does for them.

## 3. Flow 1 — Local Orchestrated Review (current)

**Audience.** Application architects, solution architects, and security architects.

**What the user does (plain English).**

1. The user runs **AISRAF Local Orchestrated Review** in their local editor (currently VS Code with the local provider surface).
2. The user creates a personal run folder under `runs/<run_id>/`.
3. The user stages local input files (DFD image and/or Mermaid source, legend, design notes, intake ticket text, transcript or questionnaire) under `runs/<run_id>/inputs/`.
4. The user edits `runs/<run_id>/run-profile.yaml` and validates it.
5. The user invokes `@aisraf-orchestrator` and walks the chain (input inventory through optional accuracy score, plus the DFD subchain).
6. The user receives local Markdown outputs under the run folder.
7. AISRAF captures observability evidence (run log, event log, handoff records, human gate records, validation results) alongside those outputs.

### 3.1 Application Architect / Solution Architect Pre-Review Journey

Plain-English steps for an application architect or solution architect using AISRAF as a shift-left lint pass on their **own** design package before formal security review:

1. Create a run folder with `tools/New-AisrafRun.ps1`.
2. Add the DFD/source diagram, legend, design notes, intake notes, and transcript or questionnaire under `runs/<run_id>/inputs/`.
3. Start with `@aisraf-orchestrator`.
4. Get back: missing facts, internal review table, targeted questions, suggested controls (from blueprints and catalogs), and corrected-diagram guidance.
5. Use those outputs to improve the design package before submitting it to formal security review.

### 3.2 Security Architect Review Journey

Plain-English steps for a security architect handling a received design package:

1. Receive the staged design package (DFD, legend, design notes, intake ticket, transcript).
2. Stage it under a personal `runs/<run_id>/inputs/`.
3. Use `@aisraf-orchestrator` to run the review chain.
4. Review the extracted components, flows, trust boundaries, data classifications, authentication / authorization annotations, encryption-in-transit notes, and storage / at-rest protection.
5. Produce the local Markdown outputs: findings, recommendations, handoff pack, validation notes, and an accuracy score where eligible.
6. Keep unknowns visible. Every unanswered question must surface as `Unknown`, `Not Stated`, or `Deferred` and feed `09-missing-facts.md` and `12-targeted-questions.md`.

**What it produces.** A run folder containing:

- `00-run-log.md` and `01-input-inventory.md` through `17-accuracy-score.md`
- `dfd/01-intake-quality-check.md` through `dfd/09-extraction-summary.md`
- Run-state, event log, and handoff records as observability evidence (see Flow 2)
- Optional local Markdown drafts of Jira/Confluence handoff content (no external post-back in v0.1.2)

**Public language to use.**

- "The user runs AISRAF Local Orchestrated Review."
- "AISRAF captures observability evidence."

**Public language to avoid.**

- "The user runs AM3" / "the user runs Mode 2" — `AM3` and `AL3` are internal architecture/evidence vocabulary, not public action wording.
- "The user runs in Mode 1/2/3/4" — mode numbers are no longer the public UX model.

## 4. Flow 2 — Run Observability / Runtime Evidence (current)

**Audience.** Same user as Flow 1; plus maintainers and reviewers reading run evidence.

**What it is.** A capability that runs **alongside Local Orchestrated Review** and records the audit-quality evidence of what happened during a run. It is not a separate public mode the user opts into.

**Target observability artifact set per run.** Every orchestrated run should eventually produce, under the run folder:

- `00-run-log.md` — operator-readable run log.
- `runtime/run-state.yaml` — current step, completed steps, pending steps, gate state (or an equivalent governed run-state file).
- `runtime/events.ndjson` — append-only event log (orchestrator events, handoff request/response pairs, gate request/decision events, terminal events; or an equivalent governed event log).
- Handoff records — the internal AM3-01 through AM3-06 specialist handoff representation; this nomenclature stays **internal**.
- Human gate records — operator approvals, deferrals, rejections.
- Validation result summary — what the validator ladder returned for the run profile and (where applicable) the AM3 runtime validators.

**v0.1.2 reality.** v0.1.2 includes a **local runtime evidence harness** under `tools/Invoke-AisrafAm3LocalRun.ps1` (with `tools/Test-AisrafAm3Runtime.ps1` validating its output). The accepted smoke evidence lives under local-only `runs/RUN-SMOKE-AM3-001/runtime/` and must not be staged or published in the current gate. The target product experience is for this evidence to be produced **automatically** during the Local Orchestrated Review of a personal run folder. v0.1.2 does not yet wire that automatic emission into the orchestrator's Local Orchestrated Review path.

**Why it is not a separate user-facing mode.** The user does not pick "observability" instead of "review." Observability is the byproduct of running a review. Promoting it to a separate public mode misled readers into thinking they had to choose between a "review" path and an "evidence" path.

**Current scope.** Local-only, human-gated, validator-backed, evidence-bound. AISRAF makes no network call as part of Flow 2.

## 5. Flow 3 — Release QA Flow (current; maintainer-only)

**Audience.** AISRAF maintainers and governance reviewers. **Not** end users.

**Plain-English maintainer / release path.**

1. Run the validators (`Test-AisrafPackage.ps1`, `Test-AisrafBp12AReadiness.ps1`, `Test-AisrafRunProfile.ps1`, `Test-AisrafAm3Runtime.ps1`).
2. Check manifests (`RELEASE-MANIFEST.yaml`, `PACKAGE-MANIFEST.yaml`, plugin metadata).
3. Check the plugin bundle checksum manifest (`plugins/aisraf-copilot-plugin/bundle-checksum-manifest.yaml`).
4. Check blocker reports under `validation/` (release-blocker register, BP12C reports).
5. Confirm there are no binaries, no secrets, no overclaim in the repo.
6. Confirm the release posture (public source-available evaluation-only proof-of-concept; not open source; not production software; not marketplace-published).
7. Decide whether to push / stage / commit / tag / release.

**What it is.** The internal release-engineering flow used to prove the package itself is ready to ship. It does not generate practitioner review outputs.

**What it covers.**

- Validators (`tools/Test-AisrafPackage.ps1`, `tools/Test-AisrafBp12AReadiness.ps1`, `tools/Test-AisrafRunProfile.ps1`, `tools/Test-AisrafAm3Runtime.ps1`).
- Release manifests (`RELEASE-MANIFEST.yaml`, `PACKAGE-MANIFEST.yaml`).
- Plugin bundle checksum manifest (`plugins/aisraf-copilot-plugin/bundle-checksum-manifest.yaml`).
- Blocker registers and QA reports under `validation/`.
- Git hygiene checks (no DOCX/PDF/PPTX/ZIP binaries in repo; `runs/RUN-001/` and `samples/` untouched; canonical/provider surfaces untouched unless authorized).
- License/notice posture scans (no open-source claim, no production claim, no marketplace claim).
- Overclaim scans (no current Jira/Confluence/Lucid/Rovo/MCP execution claim; no current online threat-intelligence execution claim; no AL5 claim; no live post-back claim).
- Release readiness gates (stage/commit, push prep, push, tag, GitHub Release).

**Why it is not a public mode.** End users do not stage, commit, run the package validator, or sign a release manifest. Calling the maintainer QA path "Mode 3" in the same numbered list as the user flow blurred the line between "what you do as a user" and "what the maintainer does before shipping."

## 6. Flow 4 — Connected Review Flow (planned; v0.2.0)

**Audience.** Application architects and security architects who want to integrate AISRAF with the systems their organization actually uses (Jira, Confluence, Lucidchart, Rovo/MCP) without leaving the AISRAF review flow.

**Current status.** **Not implemented in v0.1.2.** All planned adapters listed below are deferred to the v0.2.0 feature lane and are governed by `docs/CONNECTED-REVIEW-FLOW-PLAN.md`.

**Planned adapter scope (v0.2.0).**

- **Pre-design review / shift-left app-architect flow** — application architect uses AISRAF locally over a draft DFD before formal security review, optionally pulls intake context from Jira.
- **Security architect consultation flow** — security architect receives a design package, runs AISRAF, draws findings/recommendations, and optionally posts the handoff back to Jira/Confluence.
- **Post-design review / handoff flow** — completed handoff pack is published to Confluence (operator-approved) and linked from the Jira issue.
- **Jira intake** — read Jira design-review issue fields into a governed intake template.
- **Jira design review issue creation/update** — create or update a governed Jira issue using a fixed field model (see `docs/CONNECTED-REVIEW-FLOW-PLAN.md`).
- **Confluence handoff page creation/update** — draft locally, then publish to Confluence on operator approval.
- **Lucid/Lucidchart source ingestion** — read DFD source from Lucid instead of (or in addition to) local files.
- **Rovo/MCP adapter path** — use Atlassian Rovo and/or MCP for tool-side integration.
- **Manual/local fallback path** — every connected adapter has an authoritative local Markdown fallback; nothing in Flow 4 removes the local flow.

**Hard rule for v0.1.2 and the current release-hardening branch.** No claim of external post-back unless:

- destination URL is recorded;
- operator approval is recorded;
- `postback_execution_status = executed_by_operator` (or a future approved equivalent);
- `00-run-log.md` records the action;
- adapter response metadata is stored without secrets.

Until those conditions are met, every Connected Review Flow output is a **local Markdown draft only**.

## 7. Flow 5 — Threat Intelligence Enrichment (planned; v0.2.1)

**Audience.** Security architects who want AISRAF to surface relevant current vulnerabilities and exploited-in-the-wild signals alongside the review.

**Current status.** **Not implemented in v0.1.2.** Detailed plan is governed by `docs/THREAT-INTELLIGENCE-ENRICHMENT-PLAN.md`.

**Planned scope (v0.2.1).** A new skill, `SKL-THREAT-INTEL-CURRENT-CONTEXT`, uses curated current sources (NVD CVE API, CISA KEV, vendor security advisories, official product documentation/security pages; optional later: GitHub Security Advisories / OSV) to enrich a review with:

- CVE candidates matched to component / vendor / product / library / version.
- Exploited-in-the-wild check (CISA KEV).
- Vendor advisory notes.
- Architecture/security concern notes for the named component or pattern.
- Targeted security questions for the design under review.
- An evidence/citation ledger so every external fact carries source, retrieval date, and confidence.

**Hard rule.** No internet result becomes a finding automatically. Human approval is required before any threat-intel item becomes a finding or recommendation in the review.

## 8. Flow 6 — Mermaid Diagram Generation (planned)

**Audience.** Application architects, solution architects, and security architects who want AISRAF to produce a corrected Mermaid DFD from the extracted architecture facts as a review aid.

**Current status.** **Not implemented in v0.1.2.** Planning only. v0.1.2 reads a Mermaid DFD from `runs/<run_id>/inputs/` when one is staged; it does not generate one.

**Planned scope.**

- Generate corrected Mermaid examples from the extracted components (`04-components.md`), flows (`05-flows.md`), trust boundaries (`06-boundaries.md`), data classifications, authentication / authorization annotations, encryption-in-transit notes, and at-rest storage protection notes.
- Output the generated diagram as a local `.mmd` file under the run folder (and, later, an optional rendered PNG/SVG where tooling exists).
- **Never** claim the generated diagram is ground truth. It is a review aid. The original input diagram and any generated diagram are kept as separate files; the generated diagram is labelled as such.
- Run a Mermaid-syntax validator and the DFD-annotation-rules validator (`tools/Test-AisrafPackage.ps1` Check `08j-sample-dfd-grammar` already encodes those rules for `samples/`; a future check covers run-folder generation).
- Human approval is required before the generated diagram is treated as part of the review record.

**Hard rule.** No automated overwrite of the operator's source diagram. The generated diagram lands at a separate path (for example `runs/<run_id>/dfd/generated/<dfd_id>.mmd`); the original input stays at `runs/<run_id>/inputs/`.

## 9. Flow 7 — Plugin Install UX (planned; v0.1.3 onward)

**Audience.** First-time users installing AISRAF, returning users upgrading AISRAF, and maintainers proving install/load works.

**Current v0.1.2 truth.**

- AISRAF is delivered as a **repo-local evaluation package**.
- It is **not** marketplace-published.
- It is **not** a one-click install.
- Provider surfaces (`.agents/`, `.github/agents/`, `.github/skills/`, `.github/hooks/`, `.copilot-skills/`, `plugins/aisraf-copilot-plugin/`) are included in the repo.
- The current install experience is: clone or download the public GitHub proof-of-concept repository, open the folder in VS Code, and use the local provider surface to invoke `@aisraf-orchestrator`.

**Target install experience (v0.1.3 onward).** See `docs/PLUGIN-INSTALL-UX-PLAN.md` for the full plan and install gates.

## 10. Closed-Loop Autonomy — Out Of Scope

Closed-loop autonomy (autonomous decision and action without operator-in-the-loop) is **not** an AISRAF flow. There is no `Mode 5`, no `AL5` work package, no closed-loop roadmap row, and no marketplace, cloud, or runtime path on the AISRAF roadmap that removes the human gate.

## 11. How The Old Mode Vocabulary Maps To The New Flows

This mapping is provided so contributors reading older artifacts can translate without ambiguity.

| Old vocabulary | New flow | Public language |
|---|---|---|
| Mode 0 — preview/read-only, no writes | Optional "preview" sub-step of Local Orchestrated Review | "Preview the role and outputs before authorizing writes." |
| Mode 1 / AL2 — controlled-output local workbench | Local Orchestrated Review | "Run AISRAF Local Orchestrated Review." |
| Mode 2 / AM3 / AL3 — local orchestrated runtime evidence | Run Observability / Runtime Evidence (alongside Flow 1) | "AISRAF captures observability evidence." (AM3 / AL3 stays internal.) |
| Mode 3 — maintainer validation and release QA | Release QA Flow (maintainer-only) | "Maintainer release QA path." |
| Mode 4 / AM4 — future external adapter / post-back | Connected Review Flow (planned; v0.2.0) | "Planned Connected Review Flow." |
| AL5 — closed-loop autonomy | Out of scope | "Out of scope." |

## 12. Release Lane Summary

| Release | Flow scope |
|---|---|
| v0.1.2 (current) | Flow 1 (Local Orchestrated Review) + Flow 2 (Run Observability — emitted today through a local runtime evidence harness; not yet auto-emitted by the orchestrator) + Flow 3 (Release QA Flow). Public source-available evaluation-only. |
| v0.1.3 | UX cleanup (terminology rebase landed here), cross-shell commands, and Plugin Install / Load UX (Flow 7 progress). |
| v0.2.0 | Connected Review Flow (Flow 4): Jira, Confluence, Lucid, Rovo/MCP. Manual/local fallback retained. |
| v0.2.1 | Threat Intelligence Enrichment (Flow 5): `SKL-THREAT-INTEL-CURRENT-CONTEXT`. |
| v0.2.2 (tentative) | Mermaid Diagram Generation (Flow 6) once Connected Review Flow and Threat Intelligence Enrichment land and the corrected-DFD review-aid pattern can be governed alongside them. |
| v0.3.0 | Runtime state store / observability backend / stronger product packaging (auto-emit of run-state.yaml / events.ndjson into Flow 1). |
| Out of scope | AL5 / closed-loop autonomy. |

## 13. References

- `docs/CONNECTED-REVIEW-FLOW-PLAN.md` — full plan for Flow 4.
- `docs/THREAT-INTELLIGENCE-ENRICHMENT-PLAN.md` — full plan for Flow 5.
- `docs/PLUGIN-INSTALL-UX-PLAN.md` — full plan for Flow 6.
- `docs/BRANCH-RELEASE-STRATEGY.md` — branch and tag strategy across v0.1.x → v0.3.x.
- `docs/ROADMAP.md` — current release roadmap and gate state.
- `docs/OPERATOR-QUICKSTART.md` — operator quickstart for Flow 1.
- `docs/SECURITY-REVIEW-WORKFLOW.md` — security architect workflow for Flow 1.
- `docs/ARCHITECTURE-OVERVIEW.md` — architecture overview.
- `validation/package-12c-rel0-product-flow-adapter-roadmap-rebase-report.md` — gate report that authorized this rebase.
