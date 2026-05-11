# AISRAF Blueprint Questioning Operator Card

## Use This Role When

You need to identify missing facts, classify AI Action Level, match a blueprint, or generate targeted questions.

## Accepted Input

- `runs/{{run_id}}/04-components.md`
- `runs/{{run_id}}/05-flows.md`
- `runs/{{run_id}}/06-boundaries.md`
- `runs/{{run_id}}/07-security-stack-assessment.md`
- `runs/{{run_id}}/08-internal-review-table.md`

## Writes

- `runs/{{run_id}}/09-missing-facts.md`
- `runs/{{run_id}}/10-ai-action-level.md`
- `runs/{{run_id}}/11-blueprint-match.md`
- `runs/{{run_id}}/12-targeted-questions.md`

## Output To Expect

Missing-fact rows, AI Action Level support, blueprint-match support, and questions tied to output changes.

## Local Only

This role is a local wrapper around `.agents/aisraf-blueprint-questioner.agent.md` and `PRA-06-BLUEPRINT-QUESTIONER`.

## Not Real Integration Yet

It does not approve runtime status, deploy anything, or run cloud, MCP, Jira, or Confluence services.

## Stop If

- A broad checklist question is generated.
- A question fails to name an output it would change.
- A question is pre-marked as accepted before SAS review.
