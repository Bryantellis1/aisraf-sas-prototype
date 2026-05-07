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
- Build Package 03 tools must resolve every run-profile field through `config/run-profile.template.yaml` and `config/run-profile.schema.yaml`. A tool may not invent, rename, or silently default any field outside that schema; adding a field requires a Build Package 02 schema change in the same change set.
- Build Package 03 tools must not write outside `runs/<run_id>/`. They must not modify `config/`, `prompts/`, `skills/`, `prototype-agents/`, `.agents/`, `catalogs/`, `blueprints/`, `templates/`, `samples/`, `diagrams/`, `docs/`, `release/`, the old reference workspace, or any path with a drive letter, leading `/`, or `..` segment.
- Build Package 03 tools must not claim execution of prompts, skills, PRAs, `.agent.md` adapters, Jira, Confluence, Rovo, MCP, scoring, diagram generation, runbook generation, or release export. Console output and run-log entries must describe only what the tool did.
- Build Package 03 must not introduce `tools/Export-AisrafRelease.ps1` or any other release-export tool. Release packaging is owned by Build Package 15 and gated by founder approval.
- Smoke-run folders created by Build Package 03 tooling must be removed before human git stage. No `runs/<run_id>/` folder may be committed before Build Package 11.
