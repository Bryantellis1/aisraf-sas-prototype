# blueprints/

Root Area: Root Area 10.

Owning Build Package: Build Package 08 — Blueprints.

## Purpose

Reusable review patterns that turn Build Package 07 catalog vocabulary into governed match-and-question shapes. A blueprint helps a reviewer recognize a known design pattern (RAG retrieval, model endpoint call, write-back, HITL gate, agent-to-agent, AI workflow, AI SaaS integration, etc.), identify which catalog values support a match, and surface the material missing facts that would block matching.

## What Belongs Here

- [blueprint-registry.yaml](blueprint-registry.yaml) — registry indexing the 9 controlled blueprints, blueprint→catalog map, blueprint→skill map, blueprint→PRA map, blueprint→adapter map, blueprint→prompt map, sealed-upstream policy block, future-only ADK block.
- [blueprint-template.yaml](blueprint-template.yaml) — canonical YAML template every controlled blueprint follows.
- [platform-independent/](platform-independent/) — 8 controlled blueprints that do not depend on a specific cloud or third-party AI SaaS boundary.
- [cloud-patterns/](cloud-patterns/) — 1 controlled blueprint that materially depends on an AI SaaS or cloud third-party boundary.

Total surface: 14 files (1 root README + registry + template + 1 README per category folder + 9 BP-*.yaml + the existing folder placeholder once overwritten).

Match states are fixed at four values: `matched`, `candidate`, `no_match`, `unknown`.

## What Does Not Belong Here

- Catalog content (Build Package 07; sealed)
- Prompt cards (Build Package 04; sealed)
- Skill contracts (Build Package 05; sealed)
- PRA specs (Build Package 06; sealed)
- `.agent.md` adapters (Build Package 06; sealed)
- Templates beyond the blueprint template (Build Package 09; deferred)
- Samples and expected baselines (Build Package 10; deferred)
- Run outputs (Build Package 11; deferred)
- Diagrams (Build Package 13; deferred)
- Docs/runbooks (Build Package 14; deferred)
- Release artifacts (Build Package 15; deferred)
- Final recommendation prose, handoff prose, validation-ticket prose, owner routing, severity computation, scoring computation, AI Action Level computation, runtime/cloud/ADK/MCP/Jira/Confluence/Rovo/database/Terraform claims
- Schemas outside `config/`

## Required Blueprint Fields

Every BP-*.yaml carries the 19 required fields plus three mandatory policy blocks plus an explicit runtime-and-external-execution block:

1. `blueprint_id`
2. `blueprint_name`
3. `owning_build_package`
4. `status`
5. `purpose`
6. `applicability`
7. `catalog_dependencies`
8. `required_inputs`
9. `match_conditions`
10. `candidate_conditions`
11. `no_match_conditions`
12. `unknown_conditions`
13. `material_missing_facts`
14. `supported_finding_categories`
15. `supported_recommendation_types`
16. `human_review_gate`
17. `prohibited_claims`
18. `source_reference`
19. `version_notes`

Plus the policy blocks: `match_evidence_policy`, `catalog_value_policy`, `output_boundary`.

Plus the explicit `runtime_and_external_execution` block (six false flags).

See [blueprint-template.yaml](blueprint-template.yaml) for the canonical shape.

## Sealed Upstream Registries

Build Package 08 records its own consumer maps in [blueprint-registry.yaml](blueprint-registry.yaml). It does not modify any of the four upstream registries:

- `prompts/prompt-registry.yaml`
- `skills/skill-registry.yaml`
- `prototype-agents/prototype-agent-registry.yaml`
- `catalogs/catalog-registry.yaml`

Catalog content is sealed at 24 controlled-vocabulary YAML catalogs (33 total files under `catalogs/`). Build Package 08 must not add or modify catalogs. If a blueprint requires a controlled value that does not exist, the missing value is recorded as a `material_missing_fact` and a separate governed catalog update is required to add it.

## Match States

Founder decision Q1 fixes the four states:

| state | when |
|---|---|
| `matched` | catalog evidence is supported and `match_conditions` are satisfied |
| `candidate` | partial catalog support; `candidate_conditions` are satisfied but `match_conditions` are not |
| `no_match` | catalog evidence supports clear absence or conflict per `no_match_conditions` |
| `unknown` | required inputs are missing; targeted questions are generated to reach a decision |

`no_match` is not the same as `unknown`. A `no_match` is a supported negative finding; `unknown` is missing-fact territory.

## Human Review Gate

A blueprint match is a review hypothesis, not an approval claim. Severity, AI Action Level, finding categories, and recommendation types are selected by the relevant skills (Build Package 05) and confirmed by human review. The blueprint scopes the question; it does not decide the answer.

## When Populated

Build Package 08 (active).

## Validation

- [validation/package-08-blueprints-checklist.md](../validation/package-08-blueprints-checklist.md)
- [validation/blueprint-registry-checklist.md](../validation/blueprint-registry-checklist.md)
- [validation/blueprint-catalog-consumption-checklist.md](../validation/blueprint-catalog-consumption-checklist.md)
