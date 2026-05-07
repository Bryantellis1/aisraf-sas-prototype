# DFD Legend Excerpt — sample-001-dfd-crop

This is a synthetic legend excerpt for AISRAF SAS Prototype v0.1.2 Build Package 10. No real PII, PAN, SSN, PHI, secrets, credentials, or production endpoints are described or implied.

## 1. Visible Tokens On The Sample DFD

| token | where_visible | normalize_via |
|---|---|---|
| `IA1` | CMP-01 Reviewer Browser; F1 (Reviewer Browser → Review Portal Web App) | `catalogs/identity-access/authentication-catalog.yaml` |
| `SA1` | F2 (Review Portal Web App → Review API Gateway); F4 (Review API Gateway → AI Analysis Service); CMP-05 AI Analysis Service | `catalogs/identity-access/authentication-catalog.yaml` |
| `S1` | CMP-03 Review API Gateway (security-stack diamond marker `◇`) | `catalogs/security-stacks/security-stack-marker-catalog.yaml` |
| `T1` | F1 (HTTPS · IA1 · T1) | `catalogs/data-protection/transport-protection-catalog.yaml` |
| `E1` | CMP-04 Review Metadata DB (E1 marker on the at-rest store); F3 destination side | `catalogs/data-protection/at-rest-protection-catalog.yaml` |
| `C2` | F7 (Review API Gateway → Policy Reference Store); CMP-06 Policy Reference Store | `catalogs/data-protection/data-class-catalog.yaml` |
| `C4` | F1 review request payload; F6 finding record write; CMP-07 Findings Store | `catalogs/data-protection/data-class-catalog.yaml` |
| `C4P` | F3 (Review API Gateway → Review Metadata DB); CMP-04 Review Metadata DB | `catalogs/data-protection/data-class-catalog.yaml` |
| `formatted_only` | F8 (Review API Gateway → Jira/Confluence Draft Formatter); CMP-08 | `templates/jira/jira-ticket-draft-template.md`; `templates/confluence/confluence-page-draft-template.md` |
| `model call` | F4 verb token | `catalogs/interactions/interaction-type-catalog.yaml#IT-MODEL-CALL` |
| `class unknown` | F4 request payload note; F5 response payload note | `catalogs/data-protection/data-class-catalog.yaml#DC-UNKNOWN` |

## 2. Tokens Intentionally Absent

The sample does not include `C5`, `C5P`, `C5E1P`, `C5T1P`, `C5U1P`, `C5H1P`, `T2+`, `E2+`, mutual-TLS labels, `IA2+`, `SA2+`, or `CA#`. This sample exercises C4-band review-IP handling, transit/at-rest signal-vs-proof, AI-SaaS boundary crossing, and HITL gating — not C5 PCI/PAN scope.

## 3. Reading Rules That Apply To This Sample

- A marker is a review signal, not implementation proof. `S1` does not prove an approved security stack at CMP-03; the global rule lives in `catalogs/security-stacks/proof-vs-signal-rule-catalog.yaml#SR-DIAMOND-NOT-APPROVED-STACK` and `#SR-MARKER-NOT-PROOF`.
- One material flow gets exactly one data class. Conflicting indicators must be resolved or marked `unknown` (see `catalogs/data-protection/data-class-catalog.yaml#ER-DC-02`).
- Component-level markers (`E1` at CMP-04, `S1` at CMP-03) do not propagate to every connected flow (`catalogs/components/component-evidence-rule-catalog.yaml#CER-COMPONENT-MARKER-IS-COMPONENT-SCOPE`).
- Artifact-level class headers do not classify any flow (`catalogs/interactions/flow-evidence-rule-catalog.yaml#FER-ARTIFACT-CLASS-DOES-NOT-PROPAGATE`).
- An external AI SaaS endpoint does not prove deployed runtime, IAM, or encryption behaviour (`catalogs/security-stacks/proof-vs-signal-rule-catalog.yaml#SR-CLOUD-LABEL-NOT-RUNTIME`).
- `formatted_only` on F8 is not external post-back. Post-back requires `runs/{{run_id}}/run-profile.yaml#postback_execution_status: executed_by_operator` and a matching row appended to `{{output_root}}/00-run-log.md`.

## 4. Source Reference

Built for AISRAF SAS Prototype v0.1.2 sample-001-dfd-crop (Build Package 10 — AI SaaS Security Review Portal scenario). Conceptually informed by the v0.01 sample-001 legend pattern; not bit-copied. The legend semantics are anchored to v0.1.2 catalog paths only.
