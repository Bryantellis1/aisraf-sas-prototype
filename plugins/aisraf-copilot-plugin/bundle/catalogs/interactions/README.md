# catalogs/interactions/

Family: interactions.

Owning Build Package: Build Package 07 — Catalogs.

## Purpose

The interactions family defines the controlled vocabulary used to classify flows between components: what kind of interaction it is (data flow, model call, tool/API call, write-back, agent-to-agent, HITL approval, observability), which direction it travels, and what evidence supports a flow-level claim.

## Catalogs

| file | purpose |
|---|---|
| [interaction-type-catalog.yaml](interaction-type-catalog.yaml) | Closed list of interaction types used to classify flow rows in the review table. |
| [flow-direction-catalog.yaml](flow-direction-catalog.yaml) | Closed list of flow direction values (one_way, request_response, bidirectional, broadcast, unknown). |
| [flow-evidence-rule-catalog.yaml](flow-evidence-rule-catalog.yaml) | Evidence rules that govern when a flow-level claim is supported and when fields must remain unknown. |

## Boundaries

- Interactions describe flow types and direction. Boundary crossings on flows are owned by [boundaries/boundary-crossing-rule-catalog.yaml](../boundaries/boundary-crossing-rule-catalog.yaml).
- Identity markers attached to a flow do not prove flow-level authorization; see [identity-access/](../identity-access/).
- Annotation tokens (C5, C5P, T#, R#, SA#, etc.) are not interaction types; their semantics live in [data-protection/](../data-protection/), [identity-access/](../identity-access/), and [security-stacks/](../security-stacks/).

## Cross-References

- Every catalog in this family references [security-stacks/proof-vs-signal-rule-catalog.yaml](../security-stacks/proof-vs-signal-rule-catalog.yaml) in `evidence_rules`.
- Confidence values come from [data-protection/confidence-level-catalog.yaml](../data-protection/confidence-level-catalog.yaml).
