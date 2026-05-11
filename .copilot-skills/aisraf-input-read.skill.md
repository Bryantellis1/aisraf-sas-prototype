---
name: aisraf-input-read
description: "Use when: inventorying AISRAF input packages, explaining PRA-02, previewing 01-input-inventory, or checking input-read stop conditions."
user-invocable: true
---

# AISRAF Input Read Skill Wrapper

## Role Explanation

This is a thin BP12C projection of `AISRAF Input Reader`. It inventories existing review materials under `{{input_root}}` through `PRA-02-INPUT-READER`; it does not move chat attachments, invent inputs, or create requester forms.

## Canonical References

- Adapter: `.agents/aisraf-input-reader.agent.md`
- PRA: `prototype-agents/PRA-02-INPUT-READER.md`
- Prompt: `prompts/rs/01-input-package-read.prompt.md`
- Skill: `skills/rs/SK-INPUT-PACKAGE-READ.md`
- Template: `templates/output/output-01-input-inventory-template.md`
- Validators: `tools/Test-AisrafPackage.ps1`, `tools/Test-AisrafBp12AReadiness.ps1`

## Allowed Writes

- `runs/{{run_id}}/01-input-inventory.md`

## Output Guide

- `runs/{{run_id}}/01-input-inventory.md`
  - What: Inventory of staged review artifacts, received or missing status, and material unknowns.
  - Why: Establishes the evidence set before DFD extraction begins.
  - How: Use `prompts/rs/01-input-package-read.prompt.md` with `skills/rs/SK-INPUT-PACKAGE-READ.md`.

## Unknown Handling

Carry `unknown` through `IA?`, `SA?`, `CA?`, `AZ?`, `R?`, `L?`, and `match=unknown`. Do not invent values to clear a field.

## Stop Conditions

- `{{input_root}}` cannot be resolved or read.
- An invented input is recorded as `received`.
- The inventory claims automatic chat-attachment movement.
- The inventory introduces a new requester submission form.
- A write is attempted outside `{{output_root}}`.
- Any claim of runtime, cloud, ADK, MCP, Jira, Confluence, Rovo, database, or release execution.

## Role Smoke Response

With no input, explain this role, show the allowed write path, cite the stop conditions, and refuse to write.

## Chat Preview Response

For preview-only mode, render the section shape of `templates/output/output-01-input-inventory-template.md` in chat and write nothing.

## Prohibited Claims

Do not claim runtime, cloud, ADK, MCP, Jira, Confluence, Rovo, database, Terraform, external post-back, release, diagram, or autonomous execution.
