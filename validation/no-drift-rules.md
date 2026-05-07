# No-Drift Rules

These rules apply to AISRAF SAS Prototype v0.1.2 unless a later Build Package contract explicitly authorizes a narrower change.

- No unlisted files or folders.
- No release artifacts before Build Package 15.
- No diagrams before Build Package 13.
- No run outputs before Build Package 11.
- No prompt content before Build Package 04 except `prompts/README.md`.
- No skill content before Build Package 05 except `skills/README.md`.
- No PRA or `.agent.md` adapter content before Build Package 06.
- No catalogs before Build Package 07 except `catalogs/README.md`.
- No blueprints before Build Package 08 except `blueprints/README.md`.
- No templates before Build Package 09 except Build Package 01 authoring-agent templates.
- No samples or expected baselines before Build Package 10.
- No test claims without evidence.
- No Jira, Confluence, or MCP claims without execution evidence.
- No cloud, GCP, ADK, database, Terraform, runtime, or deployed-agent claims.
- No modification to the old reference workspace.
- No copying old stale release artifacts, failed diagrams, run proof, temporary reports, or generated outputs into this clean rebuild.
- No Build Package may invent a run-profile field outside `config/run-profile.schema.yaml`. Adding, removing, or renaming a field requires a Build Package 02 schema change in the same change set, with matching updates to `config/run-profile.template.yaml`, the samples, `config/run-profile.field-catalog.md`, and `config/run-profile.validation-rules.md`.
- No artifact, prompt, skill, PRA, runbook, scoring report, manifest entry, evidence record, diagram, or message may claim Jira post-back, Confluence publication, MCP execution, or connector use unless `postback_execution_status: executed_by_operator` (or the equivalent connector or MCP `executed_by_operator` value) is set AND `output_root/00-run-log.md` records timestamp, destination URL, and operator role for that action.
