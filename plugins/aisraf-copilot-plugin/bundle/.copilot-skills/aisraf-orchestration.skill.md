---
name: aisraf-orchestration
description: "Use when: coordinating an AISRAF SAS local review chain, explaining PRA-01, previewing the run-log shape, or checking orchestration stop conditions."
user-invocable: true
---

# AISRAF Orchestration Skill Wrapper

## Role Explanation

This is a thin BP12C projection of `AISRAF Orchestrator`. It coordinates the local AISRAF chain through `PRA-01-SAS-REVIEW-ORCHESTRATOR`, records orchestration evidence, and performs no extraction itself. It owns no skill.

## Canonical References

- Adapter: `.agents/aisraf-orchestrator.agent.md`
- PRA: `prototype-agents/PRA-01-SAS-REVIEW-ORCHESTRATOR.md`
- Prompt: `prompts/rs/00-run-full-chain.prompt.md`
- Skill: owns no skill
- Template: `templates/output/output-00-run-log-template.md`
- Validators: `tools/Test-AisrafPackage.ps1`, `tools/Test-AisrafBp12AReadiness.ps1`

## Allowed Writes

- `runs/{{run_id}}/00-run-log.md`

## Output Guide

- `runs/{{run_id}}/00-run-log.md`
  - What: Chronological orchestration record for the AISRAF run.
  - Why: Shows which steps ran, which outputs were accepted, and which stop conditions were recorded.
  - How: Use `prompts/rs/00-run-full-chain.prompt.md`; PRA-01 coordinates the chain and owns no skill.

## Unknown Handling

Carry `unknown` through `IA?`, `SA?`, `CA?`, `AZ?`, `R?`, `L?`, and `match=unknown`. Do not invent values to clear a field.

## Stop Conditions

- Run-profile variable cannot be resolved.
- An attempt to write outside `{{output_root}}`.
- A coordinated PRA reports a critical miss that is not resolved.
- Any claim of runtime, cloud, ADK, MCP, Jira post-back, Confluence publication, Rovo execution, database, Terraform, release packaging, or diagram generation.
- Validation-ticket evidence merged into the design-review handoff pack (or vice versa).
- A request to modify `prompts/`, `skills/`, registries, or baselines.

## Role Smoke Response

With no input, explain this role, show the allowed write path, cite the stop conditions, and refuse to write.

## Chat Preview Response

For preview-only mode, render the section shape of `templates/output/output-00-run-log-template.md` in chat and write nothing.

## Prohibited Claims

Do not claim runtime, cloud, ADK, MCP, Jira, Confluence, Rovo, database, Terraform, external post-back, release, diagram, or autonomous execution.
