---
prompt_id: PR-RS-10
prompt_name: Finding And Recommendation Write
owning_build_package: Build Package 04
prompt_family: rs
status: active
future_skill_id: SK-FINDING-CLASSIFY and SK-RECOMMENDATION-WRITE (planned; defined in Build Package 05)
future_pra_owner: PRA-RISK-WRITER (planned; defined in Build Package 06)
review_step: RS-10
---

# RS-10 — Finding And Recommendation Write

## 1. Identity

- prompt_id: `PR-RS-10`
- prompt_name: Finding And Recommendation Write
- owning_build_package: Build Package 04 — Prompts and prompt registry.
- prompt_family: `rs`
- status: `active`
- future_skill_id: `SK-FINDING-CLASSIFY` and `SK-RECOMMENDATION-WRITE` (planned; defined in Build Package 05).
- future_pra_owner: `PRA-RISK-WRITER` (planned; defined in Build Package 06).
- review_step: `RS-10`

## 2. Purpose

Write supported findings and matching recommendations for the design under review. A finding is an observation about an actual or material risk grounded in prior-output evidence. A recommendation proposes an action that addresses one or more findings. Write `{{output_root}}/13-findings.md` and `{{output_root}}/14-recommendations.md`. This prompt does not invent findings outside the supported evidence, does not promote unknowns to assertions, and does not include recommendations unrelated to the listed findings.

## 3. Run Profile Inputs

Resolve every value from `runs/{{run_id}}/run-profile.yaml`. The seven required v0.1.2 run-profile variables are:

- `{{run_id}}`, `{{input_root}}`, `{{expected_root}}`, `{{output_root}}`, `{{mode}}`, `{{postback_execution_status}}`, `{{output_destination_mode}}`.

Do not hardcode any value. Do not invent fields outside `config/run-profile.schema.yaml`.

## 4. Required Read Paths

Required reads:

- `runs/{{run_id}}/run-profile.yaml`
- `config/run-profile.validation-rules.md`
- `config/path-resolution-rules.md`
- `config/sensitive-data-rules.md`
- `{{output_root}}/06-boundaries.md`
- `{{output_root}}/07-security-stack-assessment.md`
- `{{output_root}}/08-internal-review-table.md`
- `{{output_root}}/09-missing-facts.md`
- `{{output_root}}/10-ai-action-level.md`
- `{{output_root}}/11-blueprint-match.md`
- `{{output_root}}/12-targeted-questions.md`

Conditional read (only when `{{expected_root}}` is non-empty and populated):

- `{{expected_root}}/expected-findings.json`
- `{{expected_root}}/expected-recommendations.json`

These are relationship references only; do not edit baselines.

Future-package references (not required; do not stop on absence):

- `skills/SK-FINDING-CLASSIFY.md` and `skills/SK-RECOMMENDATION-WRITE.md` (Build Package 05).
- `prototype-agents/PRA-RISK-WRITER.md` (Build Package 06).
- `catalogs/finding-category-catalog.yaml` and `catalogs/recommendation-category-catalog.yaml` (Build Package 07).
- `templates/findings-template.md` and `templates/recommendations-template.md` (Build Package 09).

## 5. Required Output

This prompt writes exactly two artifacts:

- `{{output_root}}/13-findings.md`
- `{{output_root}}/14-recommendations.md`

No other write path is permitted. No write outside `{{output_root}}` is permitted.

## 6. Instructions

1. Resolve every variable in Section 3 from `runs/{{run_id}}/run-profile.yaml`.
2. Read the prior outputs in Section 4. Confirm all are non-empty.
3. For `13-findings.md`, list each finding with: `finding_id` (e.g., `FND-001`), `category` (one short label such as `boundary`, `authn`, `authz`, `encryption`, `logging`, `monitoring`, `ai_action_level`, `missing_evidence`, `other`, or `unknown`), `severity_qualitative` (`info`, `low`, `medium`, `high`, or `unknown`), `evidence` (prior-output IDs), `assertion` (one or two sentences citing the evidence), and `confidence`.
4. For `14-recommendations.md`, list each recommendation with: `recommendation_id` (e.g., `REC-001`), `addresses_findings` (one or more `finding_id` values), `recommended_action` (one or two sentences), `owner_role` (design owner, security owner, data owner, requester, validator, or `unknown`), `prerequisite_evidence` (the evidence that the requester or owner must provide before the recommendation can be acted on), and `confidence`.
5. Every recommendation must reference at least one finding. Every finding may have zero or more recommendations.
6. Do not generate findings beyond what prior outputs support. Where the supporting evidence is `unknown` and material, prefer to add a row to `09-missing-facts.md` (already produced) rather than asserting a finding.
7. Write both artifacts. Do not append to `{{output_root}}/00-run-log.md` until a human reviewer accepts both.

## 7. Stop Conditions

Stop before any write if any of the following holds:

- `runs/{{run_id}}/run-profile.yaml` is missing or unreadable.
- Any required run-profile variable from Section 3 is unset, empty, or unresolvable.
- `sensitive_data_confirmed_redacted` is `false`.
- Any prior output in Section 4 is missing or empty.
- A finding would require asserting runtime behavior the source does not show.
- A recommendation would require runtime cloud changes, IAM changes, network changes, or database changes that this prompt cannot support — record the recommendation but do not claim execution.
- Any proposed write resolves outside `{{output_root}}`.
- A read or write would touch the old reference workspace.
- A sensitive-data substring per `config/sensitive-data-rules.md` is detected.
- The instruction would require claiming a Package 05+ skill / PRA / adapter / connector / runtime / scoring / diagram / release execution.

## 8. Unknown Handling

- Where evidence is partial, record `severity_qualitative: unknown` and `confidence: low`; do not invent severity.
- Where the recommendation owner cannot be determined from prior outputs, record `owner_role: unknown`.
- Do not collapse two distinct findings into one to reduce row count.

## 9. Evidence / Run-Log Guidance

- After human acceptance, append one entry to `{{output_root}}/00-run-log.md` recording: `prompt_id: PR-RS-10`, `outputs: {{output_root}}/13-findings.md and {{output_root}}/14-recommendations.md`, accepted-by reviewer label, accepted-at timestamp (ISO 8601 UTC), and a one-line summary of finding count, recommendation count, and confidence breakdown.
- Do not pre-write the run-log entry before human acceptance.
- Do not claim Jira post-back, Confluence publication, Rovo execution, or MCP execution.

## 10. Direct Prompt Test

Operator test sequence:

```
# 1. Use the run that already contains 06-boundaries.md through 12-targeted-questions.md.
tools/Test-AisrafRunProfile.ps1 -RunProfilePath runs/RUN-LOCAL-RS10-TEST/run-profile.yaml -ExecutionReady
```

- Open this card in VS Code Copilot Chat. Do not edit the prompt body. Substitute or confirm only the variables in Section 3.
- Expected local artifacts: `runs/RUN-LOCAL-RS10-TEST/13-findings.md` and `runs/RUN-LOCAL-RS10-TEST/14-recommendations.md`.
- PASS = both artifacts exist; every finding cites prior-output IDs; every recommendation links to at least one finding; no invented findings; no external/runtime claim; run-log entry appended only after human acceptance.

## 11. Not In Scope

- No skill execution. Skill contracts are deferred to Build Package 05.
- No PRA execution. PRA specifications are deferred to Build Package 06.
- No `.agent.md` adapter execution. Adapters are deferred to Build Package 06.
- No Jira post-back, Confluence publication, Rovo execution, or MCP execution.
- No accuracy scoring (handled only by [13-accuracy-score.prompt.md](13-accuracy-score.prompt.md)).
- No diagram generation, runbook generation, or release/export.
- No runtime, cloud, IAM, network, database, Terraform, or ADK execution.
- No handoff packaging, validation note, or scoring (later RS cards own those).
