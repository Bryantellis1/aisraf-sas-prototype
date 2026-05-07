# blueprints/platform-independent/

Owning Build Package: Build Package 08 — Blueprints.

## Purpose

Controlled review-pattern blueprints whose match conditions do not materially depend on a specific cloud provider, vendor SaaS, or third-party platform. Each pattern is recognizable from interaction shapes, boundary crossings, and catalog values that apply equally regardless of where the system runs.

## Inventory (8 blueprints)

| blueprint_id | blueprint_name | primary interaction shape |
|---|---|---|
| [BP-NON-AI-DATAFLOW-BASELINE](BP-NON-AI-DATAFLOW-BASELINE.yaml) | Non-AI Dataflow Baseline | data flows with no AI model invocation |
| [BP-RAG-RETRIEVAL](BP-RAG-RETRIEVAL.yaml) | RAG Retrieval | retrieval-augmented generation |
| [BP-MODEL-ENDPOINT-CALL](BP-MODEL-ENDPOINT-CALL.yaml) | Model Endpoint Call | direct model endpoint invocation |
| [BP-TOOL-USING-AGENT](BP-TOOL-USING-AGENT.yaml) | Tool-Using Agent | model-driven tool/API invocation |
| [BP-API-WRITEBACK](BP-API-WRITEBACK.yaml) | API Write-Back | model/agent output written to a system of record |
| [BP-HITL-APPROVAL](BP-HITL-APPROVAL.yaml) | HITL Approval | human approval gate before AI-driven action |
| [BP-AGENT-TO-AGENT](BP-AGENT-TO-AGENT.yaml) | Agent-to-Agent | orchestrator-to-executor or peer agent delegation |
| [BP-AI-WORKFLOW](BP-AI-WORKFLOW.yaml) | AI Workflow | multi-step composition of AI sub-patterns |

## Allowed File Types

YAML blueprint files matching `BP-*.yaml` plus this README. No Markdown blueprint files are permitted (only README is Markdown).

## What Does Not Belong Here

- Cloud-aware blueprints — see [../cloud-patterns/](../cloud-patterns/).
- Catalog content — see [../../catalogs/](../../catalogs/).
- Templates — Build Package 09 (deferred).
- Run outputs — Build Package 11 (deferred).

## Match States

Each blueprint here uses the four-state model fixed by founder decision Q1: `matched`, `candidate`, `no_match`, `unknown`.

## Cross-Pattern Composition

Several patterns compose: a design exhibiting both `BP-MODEL-ENDPOINT-CALL` and `BP-API-WRITEBACK` may match both as primary and secondary candidates, and a multi-step design typically matches `BP-AI-WORKFLOW` as the primary with sub-pattern blueprints as secondary candidates. Composition is recorded in `applicability.not_applicable_when` and `material_missing_facts` per blueprint; final selection is owned by the human review and the consuming skills.
