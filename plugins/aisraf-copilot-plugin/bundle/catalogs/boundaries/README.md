# catalogs/boundaries/

Family: boundaries.

Owning Build Package: Build Package 07 — Catalogs.

## Purpose

The boundaries family defines the controlled vocabulary used to classify boundary structures (largest to smallest), boundary crossings on flows, and trust-zone names. It enables consistent extraction of nested boundaries (external context, provider, organization/folder/account, project/subscription, region, VPC/network, subnet/zone, trust/functional zone, component group) without inferring network or cloud controls from a label.

## Catalogs

| file | purpose |
|---|---|
| [boundary-type-catalog.yaml](boundary-type-catalog.yaml) | Closed list of boundary types and the largest-to-smallest extraction order. |
| [boundary-crossing-rule-catalog.yaml](boundary-crossing-rule-catalog.yaml) | Rules that determine whether a flow crosses a boundary, and what evidence is required to claim it. |
| [trust-zone-catalog.yaml](trust-zone-catalog.yaml) | Closed list of trust/functional zones used as source/destination zone labels. |

## Boundaries

- Boundary classifications are visual structure. They do not assert network controls (firewalls, PSC, routing), tenancy, residency compliance, or cloud runtime.
- Boundary crossings are inputs into the review table; security-stack assessment of crossings is owned by [security-stacks/](../security-stacks/).
- Internet exposure is a boundary-crossing condition; the controlled value is recorded here, but the recommendations and findings live under [review/](../review/) and the future blueprint package.

## Cross-References

- Every catalog in this family references [security-stacks/proof-vs-signal-rule-catalog.yaml](../security-stacks/proof-vs-signal-rule-catalog.yaml) in `evidence_rules`.
- Confidence values come from [data-protection/confidence-level-catalog.yaml](../data-protection/confidence-level-catalog.yaml).
