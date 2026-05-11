# AISRAF Input Read Operator Card

## Use This Role When

You need to inventory the existing files staged for an AISRAF review.

## Accepted Input

- `runs/{{run_id}}/run-profile.yaml`
- Files under `{{input_root}}`

## Writes

- `runs/{{run_id}}/01-input-inventory.md`

## Output To Expect

A received, missing, or empty inventory shaped by `templates/output/output-01-input-inventory-template.md`.

## Local Only

This role is a local wrapper around `.agents/aisraf-input-reader.agent.md` and `PRA-02-INPUT-READER`.

## Not Real Integration Yet

It does not move chat attachments, create requester forms, or run cloud, MCP, Jira, or Confluence services.

## Stop If

- `{{input_root}}` cannot be resolved or read.
- An invented input is recorded as `received`.
- The inventory claims automatic chat-attachment movement.
