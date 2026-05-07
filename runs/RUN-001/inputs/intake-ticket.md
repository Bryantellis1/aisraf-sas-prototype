# Intake Ticket — sample-001-dfd-crop

Synthetic intake ticket for the AI SaaS Security Review Portal sample. No real ticket IDs, real URLs, real PII, real PAN, real SSN, real PHI, real credentials, or real endpoints appear.

## 1. Ticket Metadata

| field | value |
|---|---|
| ticket_id | SAMPLE-INTAKE-001 (synthetic; not a real ticket) |
| title | Pre-deployment security review — AI SaaS Security Review Portal |
| review_type | design review (no implementation evidence required at this gate) |
| ai_action_level_requested | AAL-L3 (HITL approval gates external action) |
| sensitive_data_in_scope | C2 internal policy reference; C4 review-IP narratives; C4P review metadata |
| sensitive_data_explicitly_out_of_scope | C5 / C5* / PCI / PAN / SSN / PHI / customer cardholder content |
| destination_ticket_url | unknown (no Jira post-back is claimed) |
| destination_confluence_url | unknown (no Confluence publication is claimed) |
| postback_execution_status_requested | deferred |

## 2. Scope

The reviewed system is the **AI SaaS Security Review Portal** described in `cloud-triage-notes.md`. Components in scope:

- CMP-01 Reviewer Browser (external_actor)
- CMP-02 Review Portal Web App (application_service)
- CMP-03 Review API Gateway (gateway_service)
- CMP-04 Review Metadata DB (data_store)
- CMP-05 AI Analysis Service (model_endpoint, external SaaS)
- CMP-06 Policy Reference Store (data_store)
- CMP-07 Findings Store (data_store)
- CMP-08 Jira/Confluence Draft Formatter (tool_or_api_surface)

Boundaries in scope: BND-01, BND-02, BND-03, BND-04 (see `dfd-crop.png` and `cloud-triage-notes.md`).

Flows in scope: F1–F8 (see `dfd-crop.png`).

## 3. Out Of Scope

- Implementation evidence on the Review Metadata DB (deferred to a separate validation ticket; tracked in `expected/expected-16-validation-notes.md`).
- Approved-stack inventory verification at CMP-03 (deferred to a separate validation ticket).
- Production runtime, cloud account configuration, Terraform, ADK, Vertex/GCP, MCP, database jobs.
- External post-back: Jira post-back and Confluence publication remain deferred. The Jira/Confluence formatter at CMP-08 produces draft text only.
- C5 / PCI / PAN / SSN / PHI scope.

## 4. Inputs Provided To The Reviewer

| input | path |
|---|---|
| DFD image | `samples/sample-001-dfd-crop/inputs/dfd-crop.png` |
| Mermaid source for the DFD | `samples/sample-001-dfd-crop/inputs/dfd-crop.mmd` |
| DFD legend excerpt | `samples/sample-001-dfd-crop/inputs/dfd-legend-excerpt.md` |
| Cloud triage notes | `samples/sample-001-dfd-crop/inputs/cloud-triage-notes.md` |
| Review transcript | `samples/sample-001-dfd-crop/inputs/review-transcript.md` |
| Intake ticket | `samples/sample-001-dfd-crop/inputs/intake-ticket.md` (this file) |

## 5. Reviewer's Pass Criteria For This Sample

- Every finding traces to a visible fact, a transcript statement, or this ticket — no invented controls or owners.
- Material missing facts are recorded explicitly; no silent unknowns.
- The handoff pack is design-review only — no implementation-validation content mixes in.
- The Jira/Confluence drafts at F8/CMP-08 are `formatted_only`; no `executed_by_operator` claim is made.
- AI Action Level remains `AAL-L3` with `medium` confidence unless evidence resolves the F4 payload-class and AZ-scope questions.

## 6. Synthetic-Data Guarantee

All values in this ticket and its companion inputs are synthetic. Nothing in the sample is a real production endpoint, real authentication mechanism, real encryption configuration, real customer record, real reviewer identity, or real connector. The sample exists for AISRAF SAS Prototype v0.1.2 prompt/skill/PRA/blueprint/template-chain testing only.
