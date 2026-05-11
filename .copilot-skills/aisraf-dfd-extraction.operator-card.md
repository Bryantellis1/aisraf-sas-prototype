# AISRAF DFD Extraction Operator Card

## Use This Role When

You need to extract visible DFD objects, normalize labels, and run the DFD subchain.

## Accepted Input

- `runs/{{run_id}}/run-profile.yaml`
- `runs/{{run_id}}/01-input-inventory.md`
- DFD source artifacts under `{{input_root}}`

## Writes

- `runs/{{run_id}}/02-visible-dfd-objects.md`
- `runs/{{run_id}}/03-legend-normalization.md`
- `runs/{{run_id}}/04-components.md`
- `runs/{{run_id}}/05-flows.md`
- `runs/{{run_id}}/dfd/01-intake-quality-check.md` through `runs/{{run_id}}/dfd/09-extraction-summary.md`

## Output To Expect

Visible DFD facts, normalized labels, component and flow facts, and ordered DFD subchain outputs.

## Local Only

This role wraps `.agents/aisraf-dfd-extractor.agent.md`, `PRA-03-DFD-EXTRACTOR`, and `PRA-04-LEGEND-NORMALIZER`.

## Not Real Integration Yet

It does not generate diagrams, compute review accuracy, or run cloud, MCP, Jira, or Confluence services.

## Stop If

- A required prior output is missing or empty.
- An object, component, flow, label, protocol, owner, control, evidence, or implementation proof is invented.
- A material model, tool/API, write-back flow, data-store, SaaS, human actor, or internet-facing flow is missed.
