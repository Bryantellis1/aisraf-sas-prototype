# DFD Legend Excerpt — sample-001-dfd-crop

This is a synthetic legend excerpt for AISRAF SAS Prototype v0.1.2 (Build Package 10A corrective patch — GCP-style architecture review DFD). No real PII, PAN, SSN, PHI, secrets, credentials, or production endpoints are described or implied.

> **Build Package 10A note.** This sample DFD adopts the **default flow-tuple standard** for AISRAF cloud-architecture review samples:
>
> - **Flow-label grammar** (4 tokens, comma-separated): `<flow name> / <C#>,<T#>,<IA#|SA#|CA#>,<AZ#|AZ?>`
> - **Data-store grammar** (3 tokens, separated by `•`): `<store name> / <C#> • <R#> • <Enc|Tok|Mask|Clr|Unknown>`
> - **Authorization is explicit on every material flow.** Where authorization is not visibly proven, the visible token is `AZ?` (resolves to `<value-from-catalogs/identity-access/authorization-catalog.yaml#AZ-UNKNOWN>`). Authentication never implies authorization.
> - **A compact legend panel is embedded inside the rendered DFD** (`subgraph LEGEND`). This document is the supporting reference for that embedded legend.
> - Extraction IDs (`CMP-NN`, `BND-NN`, `F#`, `BC-NN`) live only in expected baselines and analyst-extraction tables.

## 1. Visible Tokens On The Sample DFD

| token | where_visible | normalize_via |
|---|---|---|
| `IA1` | F1 (Reviewer Browser → Cloud Load Balancer); F2 (Cloud LB → Cloud Armor / WAF); F3 (Cloud Armor / WAF → Review Portal Web App) | `catalogs/identity-access/authentication-catalog.yaml#AU-INTERNAL-AUTHENTICATION` |
| `SA5` | F4 / F5 / F6 / F7 / F8 / F11 / F12 / F13 / F14 (every internal service-to-service hop) | `catalogs/identity-access/authentication-catalog.yaml#AU-SERVICE-AUTHENTICATION` (raw_pattern `^SA[0-9]+[OS]?$`; sample-specific service-auth subtype) |
| `SA7` | F9 / F10 (cross-internet to External AI Model Endpoint) | `catalogs/identity-access/authentication-catalog.yaml#AU-SERVICE-AUTHENTICATION` (raw_pattern `^SA[0-9]+[OS]?$`; sample-specific external-SaaS service-auth subtype) |
| `AZ?` | every visible flow tuple's 4th position (all 14 flows) | `catalogs/identity-access/authorization-catalog.yaml#AZ-UNKNOWN` (explicit unknown sentinel; required by 4-token flow grammar when authorization is not visibly proven) |
| `AZ#` | not visible in this sample | reserved for the `AZ-PRESENT` (`catalogs/identity-access/authorization-catalog.yaml#AZ-PRESENT`) and adjacent entries when explicit authorization is visibly proven on a flow |
| `S1` (◇ diamond) | Cloud Armor / WAF visible diamond marker at the internet edge | `catalogs/security-stacks/security-stack-marker-catalog.yaml#SSM-STACK-DIAMOND` |
| `T1` | every visible flow tuple's 2nd position (all 14 flows) | `catalogs/data-protection/transport-protection-catalog.yaml#TP-T-MARKER` |
| `R1` | every Data subnet store visible label `<class> • R1 • Enc` | sample-specific raw token; resolves via this legend §3 with `CL-MEDIUM` confidence |
| `Enc` | every Data subnet store visible label `<class> • R1 • Enc` | `catalogs/data-protection/at-rest-protection-catalog.yaml#AR-ENC-WORD` |
| `Tok` / `Mask` / `Clr` / `Unknown` | not visible in this sample (alternative storage-state markers documented in the embedded legend for future stores) | reserved at-rest state vocabulary; sample-001 only exercises `Enc` |
| `C2` | F7 (Policy Lookup); Policy Reference Store store label | `catalogs/data-protection/data-class-catalog.yaml#DC-C2` |
| `C4` | every other flow tuple's 1st position; Review Metadata Cloud SQL, Findings Store, Review Artifact Bucket, Audit Log Store labels | `catalogs/data-protection/data-class-catalog.yaml#DC-C4` |
| `formatted_only` (implicit) | Jira / Confluence API component label; F14 draft-handoff destination | `templates/jira/jira-ticket-draft-template.md`; `templates/confluence/confluence-page-draft-template.md` |

## 2. Tokens Intentionally Absent

The sample does not include `C5`, `C5P`, `C5E1P`, `C5T1P`, `C5U1P`, `C5H1P`, `T2+`, `E2+`, `IA2+`, `CA#`, `GSA#`, `Tok`, `Mask`, `Clr`, mutual-TLS labels, or `AZ#` (authorization-present numbered subtype). This sample exercises C2/C4-band review-IP handling, transit/at-rest signal-vs-proof, AI-SaaS boundary crossing, HITL gating, the founder-specified 4-token flow-label grammar, and the explicit-authorization-or-AZ? rule — not C5 PCI/PAN scope.

**Authorization is recorded on every visible flow as `AZ?`.** Per the founder-specified rule that authentication never implies authorization (`catalogs/identity-access/authentication-catalog.yaml#ER-AU-03`; `catalogs/identity-access/authorization-catalog.yaml#ER-AZ-03`), this sample's DFD does not visibly assert authorization on any flow; the explicit `AZ?` token resolves downstream to `AZ-UNKNOWN`. No `AZ#` token is invented. When a future sample DFD models visibly-proven authorization on a flow, the 4th-position token would be `AZ#` (numbered subtype optional) resolving to `AZ-PRESENT`.

## 3. Reading Rules That Apply To This Sample

- **Visible label is a review signal, not implementation proof.** `S1` does not prove an approved security stack at the Cloud Armor / WAF (`catalogs/security-stacks/proof-vs-signal-rule-catalog.yaml#SR-DIAMOND-NOT-APPROVED-STACK`; `#SR-MARKER-NOT-PROOF`). The embedded legend panel inside the DFD restates this rule explicitly.
- **Per-flow data class.** Each flow carries its own data class as the 1st token of the 4-token tuple; data class is never inherited from the diagram, the boundary, or an upstream flow (`catalogs/data-protection/data-class-catalog.yaml#ER-DC-02`).
- **Per-flow transport protection.** Each flow carries its own transport marker as the 2nd token. Cross-internet flows (F9 / F10) carry `T1` as a transit signal; KMS / TLS configuration / cipher suite / mTLS posture remain unknown until separately confirmed.
- **Per-flow authentication.** Each flow carries its own authentication marker as the 3rd token (`IA1` / `SA5` / `SA7`).
- **Per-flow authorization (or explicit unknown).** Each flow carries `AZ#` (visibly proven) or `AZ?` (visibly unknown) as the 4th token. This sample asserts `AZ?` on all 14 flows — authorization is not visibly proven. **The 4th token is mandatory under the 4-token grammar; a 3-token flow tuple is non-compliant.**
- **Component-level markers (e.g., `S1` at Cloud Armor / WAF) do not propagate to every connected flow** (`catalogs/components/component-evidence-rule-catalog.yaml#CER-COMPONENT-MARKER-IS-COMPONENT-SCOPE`).
- **Storage-state vocabulary.** The visible tuple `<class> • R# • <state>` on every Data subnet store records data class + replication-region marker + at-rest state. The state vocabulary is `Enc` (encrypted at rest), `Tok` (tokenized), `Mask` (masked), `Clr` (cleartext), or `Unknown`. This sample exercises only `Enc`. `R#` is sample-specific (single-region/regional managed resource); the catalog primarily documents at-rest encryption (`AR-ENC-WORD`) and at-rest unknown (`AR-UNKNOWN`), so `R1` is recorded with `CL-MEDIUM` confidence as a sample-specific replication marker. `Enc` resolves to `AR-ENC-WORD`. KMS, key rotation, and key scope remain unknown until separately confirmed (drives MF-02).
- **Cloud Armor / WAF placement.** The `S1 ◇` diamond at the internet edge is a security-stack signal (WAF / DDoS edge inspection visible); it does not prove approved-stack inventory, rule efficacy, blocking enforcement, or runtime configuration (`catalogs/security-stacks/proof-vs-signal-rule-catalog.yaml#SR-DIAMOND-NOT-APPROVED-STACK`; `#SR-GATEWAY-NOT-ENFORCEMENT`). Internal network policy / firewall, egress control / proxy / CASB, and VPC Service Controls are intentionally not modeled in this sample (they would be added as separate visible components when modeled).
- **`formatted_only` semantics on the Jira / Confluence API destination.** F14 is a local draft handoff, not external post-back. Post-back requires `runs/{{run_id}}/run-profile.yaml#postback_execution_status: executed_by_operator` AND `output_destination_mode: external_postback_executed` AND a matching row appended to `{{output_root}}/00-run-log.md` per `templates/run/postback-log-entry-row-template.md`.
- **GCP topology cues are visible context, not runtime proof.** `GCP Project: aisraf-review-dev`, `VPC: review-platform-vpc`, and the Edge / Application / Data subnets are review-time architecture context. They do not prove deployed runtime, deployed service accounts, configured firewall rules, encryption configuration, or IAM enforcement (`catalogs/security-stacks/proof-vs-signal-rule-catalog.yaml#SR-CLOUD-LABEL-NOT-RUNTIME`).

## 4. Embedded Legend Panel (inside the DFD)

The rendered DFD image (`dfd-crop.png`) contains a `subgraph LEGEND` panel listing the same vocabulary above. The embedded panel is the operator-facing legend; this Markdown excerpt is the supporting documentation for validation extraction. Both must agree.

## 5. Source Reference

Built for AISRAF SAS Prototype v0.1.2 sample-001-dfd-crop (Build Package 10A corrective patch — default GCP-style architecture review DFD standard with 4-token flow grammar and embedded legend). Conceptually informed by the v0.01 sample-001 legend pattern; not bit-copied. The legend semantics are anchored to v0.1.2 catalog paths only. Resolves `BP12-SAMPLE-DFD-BLOCKER` on the sample side; the byte-copy under `runs/RUN-001/inputs/dfd-legend-excerpt.md` is refreshed by Build Package 11A.
