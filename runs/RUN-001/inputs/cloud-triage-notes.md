# Cloud Triage Notes — sample-001-dfd-crop

Synthetic triage narrative for the AI SaaS Security Review Portal sample. No real PII, PAN, SSN, PHI, credentials, or production endpoints are described or implied. All values are illustrative.

## 1. What The Reviewed System Is

The reviewed system is an internal **AI SaaS Security Review Portal** that helps the security team triage architecture-review requests. A reviewer signs in to the portal, submits a review request (design materials, scope summary, risk concerns), the portal stores the request metadata, calls an external AI Analysis Service for analysis assistance, retrieves policy/reference context, and lets the reviewer record findings. When the reviewer chooses, the portal renders a Jira/Confluence draft of the handoff content for the reviewer to copy. The portal does not execute Jira post-back or Confluence publication on its own.

## 2. Component Narrative

| component | classification narrative |
|---|---|
| CMP-01 Reviewer Browser | The security reviewer's standard work browser. Treated as `external_actor` in the DFD because it sits outside the application trust boundary (BND-01) until the reviewer authenticates. `IA1` indicates customer-style internal SSO authentication on F1. |
| CMP-02 Review Portal Web App | The portal's UI service. Internal application service inside BND-03. Receives the authenticated review request from F1 and forwards it to the Review API Gateway via F2. |
| CMP-03 Review API Gateway | Edge gateway in front of the portal's backend. Carries the visible `S1` security-stack diamond. The `S1` marker is a review signal, not implementation proof; the approved-stack inventory at CMP-03 is unknown until separately confirmed. |
| CMP-04 Review Metadata DB | Internal data store holding review request metadata and reviewer identity (synthetic only). Carries an `E1` at-rest marker. KMS, key rotation, and scope are unknown until separately confirmed. |
| CMP-05 AI Analysis Service | An external AI SaaS endpoint reached over the internet. Provider is the external SaaS vendor (illustrative; the sample does not name a specific commercial product). The boundary BND-02 separates the application zone from this third-party SaaS. `SA1` indicates service-to-service authentication on F4. |
| CMP-06 Policy Reference Store | Internal `C2` policy reference data. Read-only via F7. |
| CMP-07 Findings Store | Internal store for reviewer-captured findings (`C4`). Written via F6 after the reviewer composes the finding. |
| CMP-08 Jira/Confluence Draft Formatter | Local renderer that produces a Jira ticket draft and a Confluence page draft. F8 is `formatted_only`; the formatter does not execute Jira post-back or Confluence publication. |

## 3. AI Action Level Narrative

The portal assists the reviewer in drafting findings and in formatting the handoff. The reviewer (Human-In-The-Loop, HITL) approves before any external action. The Jira/Confluence handoff is `formatted_only` — local draft only — until the reviewer chooses to copy the draft to Jira/Confluence themselves. AI Action Level is therefore **AAL-L3** with **medium** confidence: HITL gates external action, AI assists drafting. The medium confidence reflects open questions about what the AI Analysis Service actually receives on F4.

## 4. Boundaries That Matter In Triage

| boundary | what crosses | open concern |
|---|---|---|
| BND-01 Internet → Review Portal | F1 (Reviewer Browser → Review Portal Web App) | Authenticated session with `IA1`; no anonymous flow visible. |
| BND-02 Application → AI Analysis Service (external SaaS) | F4 (Review API Gateway → AI Analysis Service) | Service-to-service authentication via `SA1`; authorization scope at the SaaS endpoint is unknown; data-class scope on the request body is unknown. |
| BND-03 Application zone (CMP-02, CMP-03, CMP-08) | internal traffic | Application zone trust boundary. |
| BND-04 Application → Internal data zone | F3 (write to CMP-04), F6 (write to CMP-07), F7 (read from CMP-06) | At-rest encryption proof on CMP-04 is unknown; write authorization scope on F3 is unknown. |

## 5. Triage Uncertainties

Recorded as material uncertainties to be surfaced as missing facts and targeted questions. None are invented. Each is anchored to the visible DFD, the legend, or this triage narrative.

- The approved-stack inventory at the Review API Gateway is unknown. `S1` is visible but is a signal only.
- At-rest encryption proof (KMS, key rotation, scope) on the Review Metadata DB is unknown. `E1` is visible but is a signal only.
- The data-class scope on F4 (Review API Gateway → AI Analysis Service) is unknown — does the model request body carry C4 review-IP content, or only redacted prompts?
- The authorization (AZ) policy on F4 to the external AI SaaS is unknown. `SA1` covers authentication; authorization scope is separate.

## 6. Out Of Scope For This Sample

- No PCI/PAN data, no `C5` or `C5*` tokens, no payment flows, no cardholder material.
- No real customer identifiers, no real internal employee identifiers, no real credentials, no real endpoints.
- No runtime, ADK, Vertex/GCP, MCP, Jira post-back, Confluence publication, Rovo execution, database job, or Terraform proof.
- No diagram rendering beyond the local Mermaid PNG used as the sample image.
- No release artefact production.
