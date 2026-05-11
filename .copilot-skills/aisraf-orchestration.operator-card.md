# AISRAF Orchestration Operator Card

## Use This Role When

You need to coordinate a governed AISRAF run and record orchestration evidence.

## Accepted Input

- `runs/{{run_id}}/run-profile.yaml`
- Existing outputs written by downstream AISRAF roles.

## Writes

- `runs/{{run_id}}/00-run-log.md`

## Output To Expect

A run log shaped by `templates/output/output-00-run-log-template.md`.

## Local Only

This role is a local wrapper around `.agents/aisraf-orchestrator.agent.md` and `PRA-01-SAS-REVIEW-ORCHESTRATOR`.

## Not Real Integration Yet

It does not run cloud, ADK, MCP, Jira, Confluence, Rovo, database, Terraform, release, or diagram services.

## Stop If

- Run-profile variable cannot be resolved.
- An attempt to write outside `{{output_root}}`.
- A coordinated PRA reports a critical miss that is not resolved.
