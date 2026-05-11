# catalogs/

Root Area: Root Area 09.

Owning Build Package: Build Package 07 — Catalogs.

## Purpose

Catalogs are the controlled-vocabulary and classification source for the prototype. They give prompts, skills, prototype-agent specs (PRAs), local `.agent.md` adapters, future blueprints, future templates, future samples, and validation a shared, reviewable language for talking about components, interactions, boundaries, identity/access, data protection, security-stack signals, and review outcomes.

Catalogs are not executable tools, runtime services, blueprints, prompts, skills, agent logic, or runbooks. They define what counts as a controlled value, what evidence supports it, and what claims are explicitly prohibited.

## Folder Contract

Catalogs in this folder follow these strict rules:

1. **YAML-only for vocabulary.** Every controlled-vocabulary file is a YAML file. The only Markdown allowed under `catalogs/` is the eight READMEs (the root README at [catalogs/README.md](README.md) and one per family).
2. **Closed lists.** Each catalog uses controlled values. Free text is allowed only inside `notes` and `evidence_summary` fields. Adding a new controlled value requires a future governed catalog update; reviewers must not invent values inline.
3. **`unknown` is a controlled value.** Every catalog explicitly lists `unknown` as an allowed entry or top-level `unknown_value`. Unknown stays unknown until evidence supports a different conclusion.
4. **Evidence required.** Every catalog entry declares `evidence_required` so reviewers know what supports use of that value.
5. **Anti-inference rules.** Every catalog enumerates `anti_inference_rules` that prevent reviewers from guessing cloud, security, identity, or data-protection facts from labels alone.
6. **Signal vs. proof.** Visible markers, icons, gateways, diamonds, cloud labels, and naming conventions are review *signals*, not implementation *proof*. Every catalog references the signal-vs-proof distinction recorded in [security-stacks/proof-vs-signal-rule-catalog.yaml](security-stacks/proof-vs-signal-rule-catalog.yaml).
7. **No blueprint logic.** Catalogs name vocabulary and evidence requirements. They do not define blueprint match rules, expected control patterns, conformance tests, or recommendation prose. Those concerns are owned by Build Package 08 (blueprints) and Build Package 09 (templates).
8. **No runtime claims.** No catalog claims runtime, cloud, MCP, ADK, Vertex/GCP, Jira, Confluence, Rovo, database, or Terraform execution.
9. **Read-only at runtime.** Catalogs are read by prompts, skills, PRAs, and adapters. They are not edited during a review run.

## Catalog Families

| family | folder | purpose |
|---|---|---|
| components | [components/](components/) | Component types, component review roles, and component evidence rules. |
| interactions | [interactions/](interactions/) | Interaction types, flow direction values, and flow evidence rules. |
| boundaries | [boundaries/](boundaries/) | Boundary types, boundary-crossing rules, and trust-zone vocabulary. |
| identity-access | [identity-access/](identity-access/) | Authentication marker families, authorization values, and identity evidence rules. |
| data-protection | [data-protection/](data-protection/) | Data class, transport protection, at-rest protection, and confidence-level vocabulary (cross-cutting). |
| security-stacks | [security-stacks/](security-stacks/) | Security-stack markers, control signals, and the global proof-vs-signal rule catalog (cross-cutting). |
| review | [review/](review/) | Finding categories, severity, recommendation type, AI Action Level, and review status. |

## Cross-Cutting Catalogs

Two catalogs apply across all families:

- [security-stacks/proof-vs-signal-rule-catalog.yaml](security-stacks/proof-vs-signal-rule-catalog.yaml) — `global_rule: true`. Defines the rules that turn a visible marker into a review signal rather than implementation proof. Every other catalog references it in `evidence_rules`.
- [data-protection/confidence-level-catalog.yaml](data-protection/confidence-level-catalog.yaml) — `cross_cutting_catalog: true`, `primary_family: data-protection`. Defines high/medium/low/unknown confidence values used by DFD extraction, annotation resolution, component classification, boundary classification, finding confidence, and accuracy scoring.

## Catalog Inventory

- 7 catalog families.
- 28 controlled-vocabulary YAML catalogs.
- 1 catalog registry at [catalog-registry.yaml](catalog-registry.yaml) (not counted as a controlled-vocabulary catalog).
- 8 README.md files (this root README plus one per family).
- 38 total files under `catalogs/`.

## Hard Rules

- Catalogs are read-only during review-run execution. Prompts, skills, PRAs, and adapters consume them; they do not edit them.
- Unsupported fields remain `unknown`. Never infer controls, evidence, owners, or implementation status from a catalog entry.
- Visible marker presence is not implementation proof. Stack-marker visibility is not approved-stack confirmation. Cloud service icons are not deployed-runtime proof.
- Authentication evidence does not prove authorization scope. Transport protection does not prove at-rest protection. Marker presence does not prove control effectiveness.
- Catalogs must not reference Build Package 08 blueprint identifiers (no `BP-*`). Forward consumption is recorded only in `catalog-registry.yaml#future_blueprint_consumption_notes` as `status: future_only`.
- Catalogs must not introduce non-schema variables (`{{catalog_root}}`, `{{prompt_root}}`, `{{skill_root}}`, `{{template_root}}`, `{{diagram_root}}`, `{{validation_root}}`). Repository-relative literals are used everywhere.
- Catalogs must not modify the upstream prompt, skill, prototype-agent, or adapter registries. Consumer mapping is recorded only in [catalog-registry.yaml](catalog-registry.yaml) and [validation/catalog-consumption-checklist.md](../validation/catalog-consumption-checklist.md).

## Validation

Use [validation/package-07-catalogs-checklist.md](../validation/package-07-catalogs-checklist.md), [validation/catalog-registry-checklist.md](../validation/catalog-registry-checklist.md), and [validation/catalog-consumption-checklist.md](../validation/catalog-consumption-checklist.md). Run `pwsh tools/Test-AisrafPackage.ps1` after Package 07 implementation to confirm the catalog folder layout matches the contract.
