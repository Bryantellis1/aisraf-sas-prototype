# AISRAF Connected Review Flow Plan

| Field | Value |
|---|---|
| Document | docs/CONNECTED-REVIEW-FLOW-PLAN.md |
| Authority | WP-12C-REL0-PRODUCT-FLOW-ADAPTER-ROADMAP-REBASE |
| Target release | v0.2.0 |
| Current release status | **Not implemented in v0.1.2.** Planning only. No Jira, Confluence, Lucid, Rovo, MCP, cloud, database, Terraform, event bus, telemetry, or external post-back execution is wired up in the current release-hardening branch. |
| Posture | Public source-available evaluation-only proof-of-concept. Not open source. Not production software. Not marketplace-published. |
| Out of scope | AL5 closed-loop autonomy. |

## 1. Purpose

`Connected Review Flow` is the next planned AISRAF feature lane (v0.2.0). Its purpose is to let an application architect or security architect run an AISRAF review while:

- pulling intake context from the systems the team already uses (Jira; later Lucid/Lucidchart);
- producing handoff outputs that land in the systems the team reads from (Jira comments and attachments; Confluence pages);
- optionally using Atlassian Rovo and/or the Model Context Protocol (MCP) to coordinate tools.

Everything in this document is **planning material**. It is not implemented in v0.1.2 and is not active in the current release-hardening branch.

## 2. Three Use Cases In Plain English

### 2.1 Pre-design review / shift-left app architect flow

1. An application architect drafts a new system, draws a DFD, and writes intake notes.
2. They open AISRAF locally and start a Connected Review Flow run.
3. AISRAF reads an existing Jira design-review issue (if any) and the locally staged DFD/notes.
4. AISRAF runs the review chain locally and produces the standard outputs.
5. AISRAF drafts a Jira comment listing missing facts, targeted questions, and a confidence snapshot.
6. The operator approves; the Jira comment is posted back; the architect updates the design package before formal security review.

### 2.2 Security architect consultation flow

1. A security architect picks up a design-review request (Jira ticket, Slack message, email).
2. They open AISRAF, pull the intake context from Jira, and stage the DFD.
3. AISRAF runs the chain and produces findings, recommendations, and handoff content.
4. The architect reviews, edits where needed, and approves a Confluence draft and a Jira update.
5. AISRAF publishes the Confluence page and posts the Jira update, recording adapter response metadata in the run log.

### 2.3 Post-design review / handoff flow

1. A completed review (with findings and recommendations) is ready to hand off to the implementation team.
2. AISRAF takes the local Markdown handoff pack and produces a Confluence page draft and a Jira summary comment.
3. The operator approves both; AISRAF posts back; the run log records destination URLs and adapter response metadata.

## 3. Adapter Scope (planned)

For each adapter, the plan defines: what AISRAF reads, what AISRAF writes, what AISRAF must never write, and the human-gate boundary.

### 3.1 Jira intake (read)

- AISRAF reads a governed set of Jira issue fields (title, description, labels, components, security classification, attachments) into a governed intake template.
- No credentials are ever stored in run artifacts. Auth uses host environment configuration only.
- No Jira write occurs in the intake step.

### 3.2 Jira design-review issue creation / update (write)

AISRAF writes a Jira issue (new or existing) using a fixed field model:

- `review_id`
- `title`
- `business_context`
- `system_context`
- `app_owner`
- `security_reviewer`
- `data_classification`
- `ai_action_level_if_applicable`
- `dfd_attachments_or_links`
- `boundary_crossings`
- `authentication_authorization_notes`
- `encryption_in_transit_notes`
- `storage_at_rest_notes`
- `known_unknowns`
- `targeted_questions`
- `finding_summary`
- `recommendation_summary`
- `status`
- `evidence_links`

AISRAF must never write fields that are not in this list. AISRAF must never overwrite operator-edited free-text fields without operator approval recorded in the run log.

### 3.3 Confluence handoff page (write)

- AISRAF builds a Confluence page draft locally first, as Markdown under `runs/<run_id>/`.
- The Confluence publish step is operator-gated.
- AISRAF stores destination URL and adapter response metadata in `00-run-log.md` without secrets.

**Planned Confluence page sections.** The Confluence draft is rendered from these governed sections:

- Executive summary.
- Design context.
- Diagram / input inventory.
- Extracted architecture facts.
- DFD annotations.
- Missing facts.
- Threat intelligence summary (from Flow 5 — Threat Intelligence Enrichment; not in v0.1.2).
- Targeted questions.
- Findings.
- Recommendations.
- Handoff actions.
- Validation summary.
- Evidence / citation ledger.

### 3.4 Lucid / Lucidchart source ingestion (read)

- AISRAF reads DFD source from a Lucid document instead of (or alongside) a local file.
- AISRAF must convert the read into a governed local representation under `runs/<run_id>/inputs/` before the chain consumes it, so the chain always sees a local file.
- AISRAF must never write back into Lucid in v0.2.0.

### 3.5 Rovo / MCP adapter path

- Use Atlassian Rovo and/or MCP for tool-side integration where it simplifies auth and capability discovery.
- The Rovo/MCP path is an implementation detail; it does not introduce a new public flow.
- The Rovo/MCP path must respect the same field models, the same operator-gate rules, and the same evidence rules as the direct Jira/Confluence adapters.

### 3.6 Manual / local fallback path (always available)

- Every adapter has an authoritative local Markdown fallback.
- If Jira is unreachable, intake falls back to a local intake Markdown file.
- If Confluence is unreachable, the handoff page stays as a local Markdown draft.
- If Lucid is unreachable, the DFD source is the locally staged file.
- The local path is not a degraded path; it is the canonical path. Connected adapters are conveniences on top.

## 4. Output Model

Connected Review Flow outputs are:

- **Jira comment.** A governed Markdown→Jira-comment rendering of the targeted questions, missing facts, or findings/recommendations the operator approved for posting.
- **Jira attachment.** Run-folder evidence (selected outputs, not the whole run folder; no secrets; no internal evidence the operator did not approve).
- **Confluence page draft.** A governed page rendered from the local Markdown handoff pack.
- **Confluence page publish.** The operator-approved Confluence page, published, with destination URL recorded.
- **Local Markdown fallback.** The same outputs as local Markdown files under the run folder, available when no adapter is configured or when the operator declines to post back.
- **Run-log postback record.** A record in `00-run-log.md` for every attempted or executed post-back, including the operator approval, destination URL, adapter response metadata, and any error returned.

## 5. Postback Evidence Rule (hard rule)

AISRAF must not claim that an external post-back happened unless **all** of the following are true:

1. **Destination URL recorded.** The exact URL written by AISRAF is recorded in `00-run-log.md`.
2. **Operator approval recorded.** The operator's authorization is recorded with a timestamp.
3. **`postback_execution_status` set.** The run profile records `postback_execution_status: executed_by_operator` (or a future approved equivalent).
4. **Run-log entry written.** `00-run-log.md` records the post-back step with the timestamp, the destination, and the outcome.
5. **Adapter response metadata stored without secrets.** The adapter's response metadata (status code, returned ID, returned URL) is stored. Tokens, cookies, headers containing secrets, and any other credentials must never be stored.

Until those conditions are met, the output is a **local Markdown draft only**, and AISRAF must not say it "posted to Jira" or "published to Confluence."

## 6. Out Of Scope For This Plan

- AL5 closed-loop autonomy (no autonomous post-back without operator-in-the-loop).
- Cloud runtime, database-backed runtime, Terraform, event bus, telemetry backend in v0.2.0 (those are v0.3.0 and later).
- Marketplace publication.
- Any change to the v0.1.2 release-hardening branch behavior.

## 7. References

- `docs/PRODUCT-FLOW-ROADMAP.md` — Flow 4 summary and how it sits next to the current flows.
- `docs/THREAT-INTELLIGENCE-ENRICHMENT-PLAN.md` — separate planned feature lane (v0.2.1).
- `docs/PLUGIN-INSTALL-UX-PLAN.md` — install path for v0.1.3 and later.
- `docs/BRANCH-RELEASE-STRATEGY.md` — feature branches and tag names for v0.2.0.
- `validation/package-12c-rel0-product-flow-adapter-roadmap-rebase-report.md` — gate report that authorized this plan.
