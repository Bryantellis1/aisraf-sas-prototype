---
skill_id: SK-HANDOFF-PACK-BUILD
skill_name: Handoff Pack Build
owning_build_package: Build Package 05
skill_family: rs
status: active
mapped_prompt_id: PR-RS-11
mapped_prompt_file: prompts/rs/11-handoff-pack-build.prompt.md
future_pra_owner: PRA-HANDOFF-BUILDER (planned; defined in Build Package 06)
review_step: RS-15
---

# SK-HANDOFF-PACK-BUILD — Handoff Pack Build

## 1. Identity

- skill_id: `SK-HANDOFF-PACK-BUILD`
- skill_name: Handoff Pack Build
- owning_build_package: Build Package 05 — Skills and skill registry.
- skill_family: `rs`
- status: `active`
- mapped_prompt_id: `PR-RS-11`
- mapped_prompt_file: [prompts/rs/11-handoff-pack-build.prompt.md](../../prompts/rs/11-handoff-pack-build.prompt.md)
- future_pra_owner: `PRA-HANDOFF-BUILDER` (planned; defined in Build Package 06).
- review_step: `RS-15`

## 2. Purpose

Build the Design Review Handoff Pack for design-review ticket closeout, summarizing reviewed inputs, supported facts, open targeted questions, findings, recommendations, visible evidence, missing evidence, route, and owners. The pack is design-review material only and must not contain implementation validation proof; that material lives in `SK-VALIDATION-NOTE-WRITE`.

## 3. Required Inputs

- `runs/{{run_id}}/run-profile.yaml`
- `{{output_root}}/01-input-inventory.md`
- `{{output_root}}/04-components.md`
- `{{output_root}}/05-flows.md`
- `{{output_root}}/06-boundaries.md`
- `{{output_root}}/07-security-stack-assessment.md`
- `{{output_root}}/08-internal-review-table.md`
- `{{output_root}}/09-missing-facts.md`
- `{{output_root}}/10-ai-action-level.md`
- `{{output_root}}/11-blueprint-match.md`
- `{{output_root}}/12-targeted-questions.md`
- `{{output_root}}/13-findings.md`
- `{{output_root}}/14-recommendations.md`
- `config/run-profile.validation-rules.md`
- `config/path-resolution-rules.md`
- `config/sensitive-data-rules.md`

## 4. Optional Inputs

- `templates/handoff-pack-template.md` (planned; defined in Build Package 09).
- `{{expected_root}}/expected-handoff-pack.md` — relationship reference only.

## 5. Required Outputs

- `{{output_root}}/15-handoff-pack.md` — Markdown pack with the sections: `reviewed_inputs`, `supported_facts_summary`, `open_targeted_questions`, `findings_table`, `recommendations_table`, `visible_evidence_summary`, `missing_evidence_items`, `route`, `owners`, `design_review_scope_declaration`.

## 6. Procedure

1. Resolve run-profile variables.
2. Read all required prior outputs (RS-01 + RS-04..RS-14).
3. Compose each section of the pack from supported rows; do not add facts that are not present in the prior outputs.
4. Include `design_review_scope_declaration: "design review only; implementation validation routed to validation ticket"` at the top of the pack.
5. Write `{{output_root}}/15-handoff-pack.md`.
6. Stop before writing if any Section 7 stop condition holds.

## 7. Stop Conditions

- Any required prior output missing.
- Run-profile unresolved or sensitive-data confirmation `false`.
- The pack would mix implementation validation proof into the design-review closeout.
- Write outside `{{output_root}}` or to the old reference workspace.
- Any prohibited execution claim.

## 8. Unknown Handling

- Open targeted questions remain `status: open` in the pack.
- `missing_evidence_items` lists material unknowns from RS-09 and `gap_flag: true` rows from RS-07.
- Owner unknown is preserved as `unknown` in the pack.

## 9. Confidence Handling

- The pack inherits confidence from each source row. The skill itself does not raise confidence.

## 10. Critical Misses

- Mixing implementation validation proof into the closeout.
- Re-routing the ticket without supported facts.
- Writing outside `{{output_root}}`.

## 11. Human Review Gate

The SAS reviewer must confirm the pack is design-review material only and does not include implementation validation proof.

## 12. Validation / Scoring Relationship

- Expected baseline (when present): `{{expected_root}}/expected-handoff-pack.md` (planned; defined in Build Package 10).
- Scoring category: handoff pack completeness (10 points within `SK-ACCURACY-SCORE`).
- Mixing validation proof into closeout is a critical miss.

## 13. Direct Skill Test

```
tools/New-AisrafRun.ps1 -RunId RUN-LOCAL-SK-HANDOFF-TEST -SampleId sample-001-dfd-crop -Mode folder_first_test -CopySampleInputs
tools/Test-AisrafRunProfile.ps1 -RunProfilePath runs/RUN-LOCAL-SK-HANDOFF-TEST/run-profile.yaml -ExecutionReady
```

- Run RS-01..RS-14 first, then open [prompts/rs/11-handoff-pack-build.prompt.md](../../prompts/rs/11-handoff-pack-build.prompt.md).
- Expected local output: `runs/RUN-LOCAL-SK-HANDOFF-TEST/15-handoff-pack.md`.
- PASS = output exists; every section is populated from prior outputs only; design-review scope declaration is present; no validation proof in closeout.

## 14. Not In Scope

- No validation note writing (owned by `SK-VALIDATION-NOTE-WRITE`).
- No PRA, adapter, connector, runtime, scoring, diagram, or release execution.
- No release packaging or ZIP export.
