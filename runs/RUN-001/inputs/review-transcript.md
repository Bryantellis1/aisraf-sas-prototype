# Review Transcript — sample-001-dfd-crop

Synthetic review-call transcript excerpts for the AI SaaS Security Review Portal sample. All names below are role labels, not real people. No real PII, PAN, SSN, PHI, credentials, or production endpoints appear.

## 1. Context

Date: synthetic (sample fixture).
Attendees (role labels only): `[reviewer]` (security reviewer), `[design-lead]` (portal design owner), `[ai-platform-lead]` (AI platform owner).
Subject: AISRAF SAS sample review of the AI SaaS Security Review Portal pre-deployment design.

## 2. Authentication & Identity

`[reviewer]`: "On the reviewer login flow at F1, what's the authentication mechanism?"
`[design-lead]`: "Internal SSO. Marked `IA1` on the diagram. Tokens are issued by the org's identity provider; the portal validates."
`[reviewer]`: "And on F2 from the web app to the API gateway?"
`[design-lead]`: "Service-to-service auth — `SA1` on the diagram. The portal service holds a service identity that the gateway validates."
`[reviewer]`: "What about authorization scope on F2 and F4?"
`[design-lead]`: "Authentication is in place. Authorization scope on F4 to the AI Analysis Service we're still working — that's open."

## 3. Approved Security Stack At The Gateway

`[reviewer]`: "I see an `S1` diamond on the API Gateway. Is that the approved stack?"
`[design-lead]`: "S1 is the security stack marker we use on diagrams. It's a placeholder pointing at the org's security stack catalogue. We haven't yet confirmed the specific approved-stack inventory the portal will run on top of."
`[reviewer]`: "Got it. So S1 is a signal, not proof of an approved stack."
`[design-lead]`: "Correct."

## 4. AI Analysis Service Boundary

`[ai-platform-lead]`: "The AI Analysis Service is an external SaaS, not an internal endpoint. Reach is over the internet through BND-02."
`[reviewer]`: "What does the request body on F4 carry? Does it include the C4 review-IP content the reviewer pasted in?"
`[ai-platform-lead]`: "The current draft sends the request payload as-is. We've been talking about prompt redaction but it isn't implemented yet. So today, the request body data class on F4 is unknown — could be C4."
`[reviewer]`: "And the authorization at the SaaS endpoint?"
`[ai-platform-lead]`: "Service-to-service auth with the vendor token, marked `SA1`. The authorization model on the vendor side is whatever the vendor enforces. Our scope policy is open."

## 5. Review Metadata DB At-Rest

`[reviewer]`: "Review Metadata DB is `C4P` with `E1` at rest. Is that KMS-managed?"
`[design-lead]`: "`E1` is the at-rest marker we use. The KMS implementation, key rotation, and key scope are unknown to me at this stage. That's separately tracked in the validation backlog for the data team."

## 6. Findings Workflow

`[reviewer]`: "When I capture findings in the portal, where do they end up?"
`[design-lead]`: "Findings Store CMP-07 via F6. C4 internal review records."
`[reviewer]`: "Jira/Confluence handoff?"
`[design-lead]`: "F8 is `formatted_only`. The portal renders a draft for you to copy. We do not execute Jira post-back or Confluence publication automatically."

## 7. HITL Gate

`[reviewer]`: "Just to be clear — anything that goes outside the org (the AI Analysis Service call aside) requires a human approval?"
`[design-lead]`: "Yes. AI assists you in drafting findings and the handoff. You approve before any external action. AI Action Level we agreed is L3."
`[reviewer]`: "L3 medium confidence given the open questions on F4 payload class and authorization."

## 8. Open Items

The reviewer summarised the open material items at the end of the call:

- Approved-stack inventory at CMP-03 Review API Gateway (S1 confirmation).
- KMS / at-rest encryption proof on CMP-04 Review Metadata DB.
- Data-class scope on F4 to AI Analysis Service request body.
- Authorization (AZ) policy on F4 to AI Analysis Service.

Each is logged as a material missing fact for the targeted-question step. No item is forced; each remains `unknown` until evidence arrives.
