# templates/

Root Area: Root Area 11.

Owning Build Package: Build Package 09 — Templates.

## Purpose

Reusable Markdown output-shape templates for run outputs, run-log rows, Jira-ready local drafts, and Confluence-ready local drafts. Templates define output shape only.

Templates do not execute the review, do not compute severity, score, AI Action Level, or blueprint match, do not invent findings or recommendations, do not claim Jira / Confluence / Rovo / MCP / runtime / cloud / ADK / database / Terraform execution, and do not override catalogs or blueprints.

## Layout

- `templates/README.md` — this file
- `templates/template-registry.yaml` — canonical registry of every template, its consumers, and its output boundary
- `templates/output/` — 27 file-shape templates that match canonical run-output paths under `{{output_root}}` and `{{output_root}}/dfd/`
- `templates/jira/` — 1 Jira local-draft template (formatted_only output; never claims a Jira write happened)
- `templates/confluence/` — 1 Confluence local-draft template (formatted_only output; never claims a Confluence publish happened)
- `templates/run/` — 2 run-support row templates (run-log entry row; operator post-back evidence row)

Total: 31 templates + 1 registry + 5 READMEs (root + 4 family) = 37 files under `templates/`.

## Allowed Placeholders

Templates may reference only the seven run-profile variables declared in `config/run-profile.schema.yaml` and surfaced by `prompts/prompt-registry.yaml#parameter_contract.required_run_profile_fields`:

- `{{run_id}}`
- `{{input_root}}`
- `{{expected_root}}`
- `{{output_root}}`
- `{{mode}}`
- `{{postback_execution_status}}`
- `{{output_destination_mode}}`

Other run-profile fields (`sample_id`, `source_ticket_url`, `destination_ticket_url`, `destination_confluence_url`, `jira_connector_status`, `confluence_connector_status`, `rovo_mcp_available`, `mcp_execution_status`, `operator_name`, `reviewer_name`) are referenced descriptively, e.g. `[copy from runs/{{run_id}}/run-profile.yaml#sample_id]`. Templates must not introduce `{{catalog_root}}`, `{{prompt_root}}`, `{{skill_root}}`, `{{template_root}}`, `{{diagram_root}}`, or `{{validation_root}}`.

## Controlled Vocabulary

Templates reference catalog file paths but never enumerate values inside the template body. Use placeholder-by-catalog-path style:

- `<value-from-catalogs/review/severity-catalog.yaml>`
- `<value-from-catalogs/review/finding-category-catalog.yaml>`
- `<value-from-catalogs/review/recommendation-type-catalog.yaml>`
- `<value-from-catalogs/review/ai-action-level-catalog.yaml>`
- `<value-from-catalogs/review/review-status-catalog.yaml>`
- `<value-from-catalogs/data-protection/confidence-level-catalog.yaml>`
- `<value-from-catalogs/...>` for any other Build Package 07 catalog

Templates must not duplicate catalog entries and must not introduce new controlled values.

## Output Boundary

Every output template directs writes only under the resolved `{{output_root}}` (or `{{output_root}}/dfd/` for DFD subskill outputs). No template instructs a write to `config/`, `prompts/`, `skills/`, `prototype-agents/`, `.agents/`, `catalogs/`, `blueprints/`, `templates/`, `samples/`, `diagrams/`, `docs/`, `release/`, `tools/`, `validation/`, the old reference workspace, or any path outside `{{output_root}}`.

## What Does Not Belong Here

- Sample outputs (Build Package 10 owns `samples/`)
- Live run artifacts (Build Package 11 owns `runs/`)
- Diagram source or renders (Build Package 13 owns `diagrams/`)
- Practitioner runbooks (Build Package 14 owns `docs/`)
- Release binaries (Build Package 15 owns `release/`)
- Schemas outside `config/`
- Scripts, runtime code, cloud assets, MCP/Jira/Confluence/Rovo execution proof

## Validation

- `validation/package-09-templates-checklist.md` — Build Package 09 surface acceptance
- `validation/template-registry-checklist.md` — registry shape and counts
- `validation/template-consumption-checklist.md` — template ↔ prompt/skill/PRA/adapter/blueprint/catalog mapping coverage

## Authority

- `config/run-profile.schema.yaml` — variable model
- `prompts/prompt-registry.yaml` — output paths each prompt declares
- `skills/skill-registry.yaml` — skills that wrap each prompt
- `prototype-agents/prototype-agent-registry.yaml` — PRA ownership of outputs
- `catalogs/catalog-registry.yaml` — controlled vocabulary
- `blueprints/blueprint-registry.yaml` — review-pattern source
- `validation/no-drift-rules.md` — Build Package 09 rule block
