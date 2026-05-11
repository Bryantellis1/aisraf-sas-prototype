---
name: aisraf-finding-recommendation
description: "Use when: classifying AISRAF findings, writing evidence-bound recommendations, explaining PRA-07, or previewing 13-14 outputs."
user-invocable: true
---

# AISRAF Finding Recommendation Skill Wrapper

## Role Explanation

This is a thin BP12C projection of `AISRAF Finding Recommender`. It uses `PRA-07-FINDING-RECOMMENDER` to classify findings and write evidence-bound recommendations; it does not invent owners, controls, evidence, or implementation proof.

## Canonical References

- Adapter: `.agents/aisraf-finding-recommender.agent.md`
- PRA: `prototype-agents/PRA-07-FINDING-RECOMMENDER.md`
- Prompt: `prompts/rs/10-finding-recommendation-write.prompt.md`
- Skills: `skills/rs/SK-FINDING-CLASSIFY.md`, `skills/rs/SK-RECOMMENDATION-WRITE.md`
- Templates: `templates/output/output-13-findings-template.md`, `templates/output/output-14-recommendations-template.md`
- Validators: `tools/Test-AisrafPackage.ps1`, `tools/Test-AisrafBp12AReadiness.ps1`

## Allowed Writes

- `runs/{{run_id}}/13-findings.md`
- `runs/{{run_id}}/14-recommendations.md`

## Output Guide

- `runs/{{run_id}}/13-findings.md`
  - What: Evidence-bound findings with supporting rows.
  - Why: Records review issues and strengths without unsupported facts.
  - How: Use `prompts/rs/10-finding-recommendation-write.prompt.md` with `skills/rs/SK-FINDING-CLASSIFY.md`.
- `runs/{{run_id}}/14-recommendations.md`
  - What: Recommendations tied to parent findings.
  - Why: Keeps remediation advice traceable to evidence.
  - How: Use `prompts/rs/10-finding-recommendation-write.prompt.md` with `skills/rs/SK-RECOMMENDATION-WRITE.md`.

## Unknown Handling

Carry `unknown` through `IA?`, `SA?`, `CA?`, `AZ?`, `R?`, `L?`, and `match=unknown`. Do not invent values to clear a field.

## Stop Conditions

- A finding is recorded without a supporting evidence row.
- A control, owner, or evidence reference is invented.
- A recommendation does not cite a parent finding.
- A recommendation claims implementation proof or post-back execution.
- A finding category change silently shifts the owner or route.
- A write is attempted outside `{{output_root}}`.
- Any claim of runtime, cloud, ADK, MCP, Jira, Confluence, Rovo, database, or release execution.

## Role Smoke Response

With no input, explain this role, show the allowed write paths, cite the stop conditions, and refuse to write.

## Chat Preview Response

For preview-only mode, render the section shapes of `output-13` and `output-14` templates in chat and write nothing.

## Prohibited Claims

Do not claim runtime, cloud, ADK, MCP, Jira, Confluence, Rovo, database, Terraform, external post-back, release, diagram, or autonomous execution.
