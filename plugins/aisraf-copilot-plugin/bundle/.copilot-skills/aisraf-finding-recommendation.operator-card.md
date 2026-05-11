# AISRAF Finding Recommendation Operator Card

## Use This Role When

You need to classify findings and write evidence-bound recommendations.

## Accepted Input

- `runs/{{run_id}}/06-boundaries.md`
- `runs/{{run_id}}/07-security-stack-assessment.md`
- `runs/{{run_id}}/08-internal-review-table.md`
- `runs/{{run_id}}/09-missing-facts.md`
- `runs/{{run_id}}/10-ai-action-level.md`
- `runs/{{run_id}}/11-blueprint-match.md`
- `runs/{{run_id}}/12-targeted-questions.md`

## Writes

- `runs/{{run_id}}/13-findings.md`
- `runs/{{run_id}}/14-recommendations.md`

## Output To Expect

Findings with supporting evidence rows and recommendations tied to parent findings.

## Local Only

This role is a local wrapper around `.agents/aisraf-finding-recommender.agent.md` and `PRA-07-FINDING-RECOMMENDER`.

## Not Real Integration Yet

It does not prove implementation, post back to tools, or run cloud, MCP, Jira, or Confluence services.

## Stop If

- A finding is recorded without a supporting evidence row.
- A control, owner, or evidence reference is invented.
- A recommendation does not cite a parent finding.
