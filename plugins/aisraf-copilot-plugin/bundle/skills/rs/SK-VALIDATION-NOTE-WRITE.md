---
skill_id: SK-VALIDATION-NOTE-WRITE
skill_name: Validation Note Write
owning_build_package: Build Package 05
skill_family: rs
status: active
mapped_prompt_id: PR-RS-12
mapped_prompt_file: prompts/rs/12-validation-note-write.prompt.md
future_pra_owner: PRA-VALIDATION-NOTE-WRITER (planned; defined in Build Package 06)
review_step: RS-16
---

# SK-VALIDATION-NOTE-WRITE — Validation Note Write

## 1. Identity

- skill_id: `SK-VALIDATION-NOTE-WRITE`
- skill_name: Validation Note Write
- owning_build_package: Build Package 05 — Skills and skill registry.
- skill_family: `rs`
- status: `active`
- mapped_prompt_id: `PR-RS-12`
- mapped_prompt_file: [prompts/rs/12-validation-note-write.prompt.md](../../prompts/rs/12-validation-note-write.prompt.md)
- future_pra_owner: `PRA-VALIDATION-NOTE-WRITER` (planned; defined in Build Package 06).
- review_step: `RS-16`

## 2. Purpose

Write separate validation-ticket notes for items that require downstream implementation evidence and cannot be confirmed during design review. The validation ticket is a separate work item from the design-review ticket. Merging the two is a critical miss.

## 3. Required Inputs

- `runs/{{run_id}}/run-profile.yaml`
- `{{output_root}}/08-internal-review-table.md`
- `{{output_root}}/09-missing-facts.md`
- `{{output_root}}/10-ai-action-level.md`
- `{{output_root}}/12-targeted-questions.md`
- `{{output_root}}/13-findings.md`
- `{{output_root}}/14-recommendations.md`
- `config/run-profile.validation-rules.md`
- `config/path-resolution-rules.md`
- `config/sensitive-data-rules.md`

## 4. Optional Inputs

- `{{output_root}}/15-handoff-pack.md` — for cross-reference; the validation ticket must remain separate.
- `{{expected_root}}/expected-validation-notes.md` — relationship reference only.

## 5. Required Outputs

- `{{output_root}}/16-validation-notes.md` — Markdown notes with the columns: `note_id`, `finding_ref`, `evidence_type_needed`, `validation_trigger`, `responsible_party`, `separation_confirmed`.

## 6. Procedure

1. Resolve run-profile variables.
2. Read RS-08, RS-09, RS-12..RS-14.
3. For each finding row in RS-13 with `validation_ticket_needed: true`, produce a validation note.
4. Set `evidence_type_needed` (e.g., implementation log, configuration export, runtime test, security-stack proof) without claiming the proof exists.
5. Set `validation_trigger` (e.g., post-deployment check, change-approval review, pre-launch test).
6. Set `separation_confirmed: true` for every row to record that the note belongs in the validation ticket and not in the design-review closeout.
7. Write `{{output_root}}/16-validation-notes.md`.
8. Stop before writing if any Section 7 stop condition holds.

## 7. Stop Conditions

- RS-13 missing.
- Run-profile unresolved or sensitive-data confirmation `false`.
- The output would merge with the design-review closeout.
- Write outside `{{output_root}}` or to the old reference workspace.
- Any prohibited execution claim.

## 8. Unknown Handling

- Responsible party unknown is allowed and recorded.
- Validation trigger unknown is allowed; do not invent a trigger.
- Evidence type unknown is allowed; do not invent the form of proof.

## 9. Confidence Handling

- `HIGH` — finding has a clear `validation_ticket_needed: true` rationale and the evidence type is canonical.
- `MEDIUM` — evidence type or trigger is partial.
- `LOW` — evidence type or trigger is speculative.
- `UNKNOWN` — drop the row; record only the finding ID with a note.

## 10. Critical Misses

- Merging the validation ticket with the design-review closeout.
- Claiming evidence exists when it does not.
- Writing outside `{{output_root}}`.

## 11. Human Review Gate

The SAS reviewer must verify the validation ticket remains separate from the design-review closeout.

## 12. Validation / Scoring Relationship

- Expected baseline (when present): `{{expected_root}}/expected-validation-notes.md` (planned; defined in Build Package 10).
- Scoring category: validation-ticket routing (10 points within `SK-ACCURACY-SCORE`).
- Merge with design-review closeout is a critical miss.

## 13. Direct Skill Test

```
tools/New-AisrafRun.ps1 -RunId RUN-LOCAL-SK-VALNOTE-TEST -SampleId sample-001-dfd-crop -Mode folder_first_test -CopySampleInputs
tools/Test-AisrafRunProfile.ps1 -RunProfilePath runs/RUN-LOCAL-SK-VALNOTE-TEST/run-profile.yaml -ExecutionReady
```

- Run RS-01..RS-14 first, then open [prompts/rs/12-validation-note-write.prompt.md](../../prompts/rs/12-validation-note-write.prompt.md).
- Expected local output: `runs/RUN-LOCAL-SK-VALNOTE-TEST/16-validation-notes.md`.
- PASS = output exists; every note has `separation_confirmed: true`; the validation notes are not mixed into the handoff pack.

## 14. Not In Scope

- No handoff pack composition (owned by `SK-HANDOFF-PACK-BUILD`).
- No PRA, adapter, connector, runtime, scoring, diagram, or release execution.
- No claim of evidence existence.
