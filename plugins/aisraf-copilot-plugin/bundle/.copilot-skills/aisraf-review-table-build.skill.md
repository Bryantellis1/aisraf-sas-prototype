---
name: aisraf-review-table-build
description: "Use when: building AISRAF boundary and review-table outputs, explaining PRA-05, previewing 06-08 outputs, or checking review-table stop conditions."
user-invocable: true
---

# AISRAF Review Table Build Skill Wrapper

## Role Explanation

This is a thin BP12C projection of `AISRAF Review Table Builder`. It uses `PRA-05-REVIEW-TABLE-BUILDER` to detect boundary crossings, assess visible security-stack signals, and assemble the Internal Data Flow Review Table from supported facts.

## Canonical References

- Adapter: `.agents/aisraf-review-table-builder.agent.md`
- PRA: `prototype-agents/PRA-05-REVIEW-TABLE-BUILDER.md`
- Prompts: `prompts/rs/05-boundary-stack-detect.prompt.md`, `prompts/rs/06-review-table-build.prompt.md`
- Skills: `skills/rs/SK-BOUNDARY-CROSSING-DETECT.md`, `skills/rs/SK-SECURITY-STACK-ASSESS.md`, `skills/rs/SK-DATA-FLOW-TABLE-BUILD.md`
- Handoff references: `prompts/rs/07-missing-fact-question-generate.prompt.md`, `skills/rs/SK-MISSING-FACT-IDENTIFY.md`
- Templates: `templates/output/output-06-boundaries-template.md`, `templates/output/output-07-security-stack-assessment-template.md`, `templates/output/output-08-internal-review-table-template.md`

## Allowed Writes

- `runs/{{run_id}}/06-boundaries.md`
- `runs/{{run_id}}/07-security-stack-assessment.md`
- `runs/{{run_id}}/08-internal-review-table.md`

## Output Guide

- `runs/{{run_id}}/06-boundaries.md`
  - What: Boundary-crossing evidence and limits.
  - Why: Shows where data or control crosses material review boundaries.
  - How: Use `prompts/rs/05-boundary-stack-detect.prompt.md` with `skills/rs/SK-BOUNDARY-CROSSING-DETECT.md`.
- `runs/{{run_id}}/07-security-stack-assessment.md`
  - What: Visible security-stack signal assessment.
  - Why: Separates visible signals from unsupported control claims.
  - How: Use `prompts/rs/05-boundary-stack-detect.prompt.md` with `skills/rs/SK-SECURITY-STACK-ASSESS.md`.
- `runs/{{run_id}}/08-internal-review-table.md`
  - What: Internal Data Flow Review Table.
  - Why: Provides the structured review table consumed by later AISRAF roles.
  - How: Use `prompts/rs/06-review-table-build.prompt.md` with `skills/rs/SK-DATA-FLOW-TABLE-BUILD.md`.

## Unknown Handling

Carry `unknown` through `IA?`, `SA?`, `CA?`, `AZ?`, `R?`, `L?`, and `match=unknown`. Do not invent values to clear a field.

## Stop Conditions

- An internet-facing, customer-facing, model, tool, data-store, or human-actor boundary is missed.
- Controls are claimed from a boundary label alone.
- Security-stack visibility is invented.
- A future-cloud or S# label is treated as runtime proof.
- Transit is conflated with at-rest (or vice versa).
- The review table hides a material unknown.
- The review table is converted into a requester homework form.
- A write is attempted outside `{{output_root}}`.
- Any claim of runtime, cloud, ADK, MCP, Jira, Confluence, Rovo, database, or release execution.

## Role Smoke Response

With no input, explain this role, show the allowed write paths, cite the stop conditions, and refuse to write.

## Chat Preview Response

For preview-only mode, render the section shapes of the three referenced output templates in chat and write nothing.

## Prohibited Claims

Do not claim runtime, cloud, ADK, MCP, Jira, Confluence, Rovo, database, Terraform, external post-back, release, diagram, or autonomous execution.
