# catalogs/identity-access/

Family: identity-access.

Owning Build Package: Build Package 07 — Catalogs.

## Purpose

The identity-access family defines the controlled vocabulary used to classify authentication markers, authorization values, and identity evidence requirements. It draws a hard line between authentication (who is calling) and authorization (what they are allowed to do), and prevents reviewers from claiming authorization scope from an authentication marker alone.

## Catalogs

| file | purpose |
|---|---|
| [authentication-catalog.yaml](authentication-catalog.yaml) | Closed list of authentication marker families: service authentication (SA#), customer authentication (CA#), internal/workforce authentication (IA#), managed service account or workload identity (GSA#), and unknown. |
| [authorization-catalog.yaml](authorization-catalog.yaml) | Closed list of authorization values: present, partial, planned, unknown — with strict allowed/not-allowed conditions. |
| [identity-evidence-rule-catalog.yaml](identity-evidence-rule-catalog.yaml) | Evidence rules covering token validation, least privilege, role scope, approval authority, and implementation proof. |

## Boundaries

- Authentication markers are review signals only. They do not prove authorization, MFA, SSO enforcement, token validation, least privilege, role scope, approval authority, approved security architecture, or implementation evidence.
- A managed service account or workload identity marker (GSA#) records that the design names such an identity. It does not prove current cloud runtime, deployed service account, credential safety, or keyless status.
- Approval authority and HITL gating semantics live under [review/](../review/) and [security-stacks/](../security-stacks/); identity-access only records what authentication-and-authorization values are visible.

## Cross-References

- Every catalog in this family references [security-stacks/proof-vs-signal-rule-catalog.yaml](../security-stacks/proof-vs-signal-rule-catalog.yaml) in `evidence_rules`.
- Confidence values come from [data-protection/confidence-level-catalog.yaml](../data-protection/confidence-level-catalog.yaml).
