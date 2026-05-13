# AISRAF Branch And Release Strategy

| Field | Value |
|---|---|
| Document | docs/BRANCH-RELEASE-STRATEGY.md |
| Authority | WP-12C-REL0-PRODUCT-FLOW-ADAPTER-ROADMAP-REBASE |
| Current release | v0.1.2 (public source-available evaluation-only baseline). |
| Posture | Public source-available evaluation-only proof-of-concept. Not open source. Not production software. Not marketplace-published. |
| Out of scope | AL5 closed-loop autonomy. |

## 1. Purpose

This document defines a practical branch and tag strategy across the v0.1.x → v0.3.x release lanes, so that the rebased product flows (`docs/PRODUCT-FLOW-ROADMAP.md`) map cleanly to branches that maintainers can actually merge.

## 2. Branch Roles

- **`master` / `main`** — stable public evaluation branch. The release tag for the current public release points here. Public readers and evaluators see this branch. Only branches that have passed their gate are merged in.
- **`release/v0.1.2`** — optional release-hardening branch used only if maintainers need to harden the current release without blocking forward UX/docs work. Discardable once the release-hardening cycle closes.
- **`docs/product-flow-ux`** — UX/docs work for the operating-flow rebase (this gate and follow-up gates). No runtime, no adapter implementation.
- **`docs/plugin-install-ux`** — UX/docs work for the plugin install/load experience (Flow 6).
- **`fix/cross-shell-command-ux`** — cross-shell command alignment (PowerShell + bash + Copilot CLI). Tooling and docs only; no runtime adapter work.
- **`feature/connected-jira-intake`** — Jira intake adapter (read-only intake).
- **`feature/connected-confluence-output`** — Confluence handoff page write (operator-gated).
- **`feature/connected-lucid-source`** — Lucid/Lucidchart source ingestion.
- **`feature/connected-rovo-mcp`** — Rovo and/or MCP adapter path.
- **`feature/threat-intel-current-context`** — `SKL-THREAT-INTEL-CURRENT-CONTEXT` skill.
- **`feature/mermaid-diagram-generation`** — Flow 6 (Mermaid Diagram Generation). Generates a corrected Mermaid DFD from extracted facts as a review aid; original input diagram stays separate.
- **`feature/runtime-observability-store`** — durable observability store / runtime state backend (v0.3.0).

Each `feature/*` branch is its own work package and is gated independently. Implementation is not authorized just because a branch name exists.

## 3. Tag Names

- **`v0.1.2-eval`** — current public source-available evaluation tag for v0.1.2.
- **`v0.1.3-ux`** — UX cleanup, cross-shell commands, plugin install/load UX.
- **`v0.2.0-connected-review`** — Connected Review Flow (Jira, Confluence, Lucid, Rovo/MCP). Requires the feature/connected-* branches to be merged through their gates.
- **`v0.2.1-threat-intel`** — Threat Intelligence Enrichment. Requires the feature/threat-intel-current-context branch through its gate.
- **`v0.2.2-mermaid-generation`** (tentative) — Mermaid Diagram Generation. Requires the feature/mermaid-diagram-generation branch through its gate.
- **`v0.3.0-runtime-observability`** — runtime state store / observability backend / stronger product packaging.

The current public release tag for v0.1.2 (`v0.1.2-evaluation` / `v0.1.2-eval`) and the GitHub Release for it are governed by the WP-12C-REL0-GITHUB-PRERELEASE-UPLOAD gate and remain blocked until that gate passes.

## 4. Branch Rules

- **Small branches.** A branch covers one work package. Long-running multi-feature branches are not allowed.
- **Validator-green before merge.** No branch is merged until the validator ladder is green (`Test-AisrafPackage.ps1`, `Test-AisrafBp12AReadiness.ps1`, `Test-AisrafRunProfile.ps1`, and the AM3 runtime validators where the change touches AM3 contracts/runtime).
- **No binaries in repo.** No DOCX, PDF, PPTX, or ZIP binaries are committed in any branch. Such binaries are GitHub Release assets only, attached at release time.
- **DOCX/PDF only as GitHub Release assets.** Stakeholder docs (`AISRAF-v0.1.2-Evaluation-Guide.docx`/`.pdf` and any successors) live outside the repo and are attached to the release.
- **No connected adapter claim until tested.** A branch named `feature/connected-*` does not authorize a claim that the adapter is implemented. Public docs may say a Connected Review Flow is **planned**; they may not say it **works** until the adapter passes its own gate and an explicit release ships with it.
- **No public/open-source wording.** Branch names, commit messages, PR descriptions, and docs must keep the posture as "public source-available evaluation-only proof-of-concept" unless the license is explicitly changed by a separate governed decision.

## 5. Release Lane Summary

| Release | Branches that feed it | Tag |
|---|---|---|
| v0.1.2 (current) | `master`, optional `release/v0.1.2` | `v0.1.2-eval` |
| v0.1.3 | `docs/product-flow-ux`, `docs/plugin-install-ux`, `fix/cross-shell-command-ux` | `v0.1.3-ux` |
| v0.2.0 | `feature/connected-jira-intake`, `feature/connected-confluence-output`, `feature/connected-lucid-source`, `feature/connected-rovo-mcp` | `v0.2.0-connected-review` |
| v0.2.1 | `feature/threat-intel-current-context` | `v0.2.1-threat-intel` |
| v0.2.2 (tentative) | `feature/mermaid-diagram-generation` | `v0.2.2-mermaid-generation` |
| v0.3.0 | `feature/runtime-observability-store` plus packaging work | `v0.3.0-runtime-observability` |
| Out of scope | — | AL5 closed-loop autonomy is not a release lane. |

## 6. Out Of Scope For This Strategy

- AL5 closed-loop autonomy.
- Any branch that implements Jira, Confluence, Lucid, Rovo/MCP, online threat intelligence, cloud runtime, database runtime, Terraform, event bus, telemetry backend, or marketplace publication **inside the v0.1.2 release-hardening branch**. Those work packages must open their own feature branches under a separate gate.
- Pushes, tags, GitHub Releases, and marketplace submissions inside this gate. This document is planning; it does not authorize remote git or release actions.

## 7. References

- `docs/PRODUCT-FLOW-ROADMAP.md` — operating model and flow definitions.
- `docs/CONNECTED-REVIEW-FLOW-PLAN.md` — adapter plan for v0.2.0.
- `docs/THREAT-INTELLIGENCE-ENRICHMENT-PLAN.md` — skill plan for v0.2.1.
- `docs/PLUGIN-INSTALL-UX-PLAN.md` — install plan for v0.1.3 and later.
- `docs/ROADMAP.md` — current release roadmap and gate state.
- `validation/package-12c-rel0-product-flow-adapter-roadmap-rebase-report.md` — gate report that authorized this strategy.
