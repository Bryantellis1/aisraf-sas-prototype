# blueprints/cloud-patterns/

Owning Build Package: Build Package 08 — Blueprints.

## Purpose

Controlled review-pattern blueprints whose match conditions materially depend on a cloud or third-party SaaS boundary crossing. The boundary itself (an internal trust zone crossing to an external AI SaaS provider, a managed cloud model surface, or an internet-crossing tool/agent surface) is part of the recognized shape.

## Inventory (1 blueprint)

| blueprint_id | blueprint_name | primary boundary shape |
|---|---|---|
| [BP-AI-SAAS-INTEGRATION](BP-AI-SAAS-INTEGRATION.yaml) | AI SaaS Integration | application crosses internet boundary to an external AI SaaS provider (e.g., OpenAI, Gemini, Anthropic, Azure OpenAI) |

The single-blueprint count for this folder is intentional. Founder decision Q2 locks the Build Package 08 inventory at 9 blueprints (8 platform-independent + 1 cloud-pattern). The folder split (founder decision Q3) preserves forward-compatibility for additional cloud-pattern blueprints to be added through future governed expansion (e.g., per-CSP variants, model-marketplace patterns, vector-cloud retrieval). No additional cloud-pattern blueprint is authorized in Build Package 08.

## Allowed File Types

YAML blueprint files matching `BP-*.yaml` plus this README. No Markdown blueprint files are permitted (only README is Markdown).

## What Does Not Belong Here

- Platform-independent blueprints — see [../platform-independent/](../platform-independent/).
- Catalog content — see [../../catalogs/](../../catalogs/).
- Templates — Build Package 09 (deferred).
- Cloud runtime, ADK, Vertex, GCP, MCP, or Jira/Confluence proof — never permitted in any Package.

## Match States

The blueprint here uses the four-state model fixed by founder decision Q1: `matched`, `candidate`, `no_match`, `unknown`.

## Boundary Awareness, Not Implementation

A cloud-pattern blueprint records what the reviewer should recognize and what catalog values support a match. It does not declare or claim cloud deployment, configuration, runtime state, ADK/Vertex/GCP integration, MCP execution, database state, or Terraform state. Implementation evidence belongs to a separate validation ticket; the blueprint itself only scopes the question.
