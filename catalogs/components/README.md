# catalogs/components/

Family: components.

Owning Build Package: Build Package 07 — Catalogs.

## Purpose

The components family defines the controlled vocabulary used to classify visible boxes, actors, services, stores, and grouping containers in a reviewed-system DFD. The three catalogs in this family separate three different concerns: what kind of object is this (type), what does it do in the review (role), and what evidence is required to make either claim (evidence rule).

## Catalogs

| file | purpose |
|---|---|
| [component-type-catalog.yaml](component-type-catalog.yaml) | Closed list of component types (external actor, customer client, application service, gateway service, model endpoint, tool/API surface, data store, object storage, vector/retrieval store, observability store, queue/topic, identity provider, secrets/key management, grouped boundary box, unknown). |
| [component-role-catalog.yaml](component-role-catalog.yaml) | Closed list of review roles a component can play (source, destination, intermediate hop, store, actor, control plane, identity authority, observability sink, group container). |
| [component-evidence-rule-catalog.yaml](component-evidence-rule-catalog.yaml) | Evidence rules that govern when a type or role claim is supported and when it must remain unknown. |

## Boundaries

- Components are objects in a DFD. Interactions between components are owned by [interactions/](../interactions/).
- Component-level identity, secrets, key management, and security stack are signals only; controlled values for those signals live in [identity-access/](../identity-access/), [data-protection/](../data-protection/), and [security-stacks/](../security-stacks/).
- Component types and roles are classifications. They do not declare implementation, deployment, runtime status, configuration, or controls.

## Cross-References

- Every catalog in this family references [security-stacks/proof-vs-signal-rule-catalog.yaml](../security-stacks/proof-vs-signal-rule-catalog.yaml) in `evidence_rules`.
- Confidence values come from [data-protection/confidence-level-catalog.yaml](../data-protection/confidence-level-catalog.yaml).
