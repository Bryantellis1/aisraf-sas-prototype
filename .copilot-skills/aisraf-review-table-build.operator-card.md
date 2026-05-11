# AISRAF Review Table Build Operator Card

## Use This Role When

You need to detect boundaries, assess visible stack signals, and build the Internal Data Flow Review Table.

## Accepted Input

- `runs/{{run_id}}/03-legend-normalization.md`
- `runs/{{run_id}}/04-components.md`
- `runs/{{run_id}}/05-flows.md`

## Writes

- `runs/{{run_id}}/06-boundaries.md`
- `runs/{{run_id}}/07-security-stack-assessment.md`
- `runs/{{run_id}}/08-internal-review-table.md`

## Output To Expect

Boundary evidence, stack-signal assessment, and a review table shaped by the canonical output templates.

## Local Only

This role is a local wrapper around `.agents/aisraf-review-table-builder.agent.md` and `PRA-05-REVIEW-TABLE-BUILDER`.

## Not Real Integration Yet

It does not prove controls, approve runtime status, or run cloud, MCP, Jira, or Confluence services.

## Stop If

- An internet-facing, customer-facing, model, tool, data-store, or human-actor boundary is missed.
- Controls are claimed from a boundary label alone.
- Security-stack visibility is invented.
