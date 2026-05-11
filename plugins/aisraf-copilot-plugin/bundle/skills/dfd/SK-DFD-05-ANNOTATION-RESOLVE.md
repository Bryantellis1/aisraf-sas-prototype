---
skill_id: SK-DFD-05-ANNOTATION-RESOLVE
skill_name: DFD Annotation Resolve
owning_build_package: Build Package 05
skill_family: dfd
status: active
mapped_prompt_id: PR-DFD-06
mapped_prompt_file: prompts/dfd/06-annotation-resolve.prompt.md
future_pra_owner: PRA-DFD-EXTRACTOR (planned; defined in Build Package 06)
dfd_step: DFD-05
---

# SK-DFD-05-ANNOTATION-RESOLVE — DFD Annotation Resolve

## 1. Identity

- skill_id: `SK-DFD-05-ANNOTATION-RESOLVE`
- skill_name: DFD Annotation Resolve
- owning_build_package: Build Package 05 — Skills and skill registry.
- skill_family: `dfd`
- status: `active`
- mapped_prompt_id: `PR-DFD-06`
- mapped_prompt_file: [prompts/dfd/06-annotation-resolve.prompt.md](../../prompts/dfd/06-annotation-resolve.prompt.md)
- future_pra_owner: `PRA-DFD-EXTRACTOR` (planned; defined in Build Package 06).
- dfd_step: `DFD-05`

## 2. Purpose

Resolve visible legend tokens, data-class markers, auth markers, transit markers, at-rest markers, and security-stack markers from the DFD source against the legend excerpt. The skill produces a normalized annotation row per DFD object and per flow. Token meaning is never invented.

## 3. Required Inputs

- `runs/{{run_id}}/run-profile.yaml`
- `{{output_root}}/dfd/02-boundary-catalog.md`
- `{{output_root}}/dfd/03-component-catalog.md`
- `{{output_root}}/dfd/04-flow-inventory.md`
- `{{input_root}}/` — DFD source and legend excerpt.
- `config/run-profile.validation-rules.md`
- `config/path-resolution-rules.md`
- `config/sensitive-data-rules.md`

## 4. Optional Inputs

- `{{expected_root}}/expected-legend-normalization.json` — relationship reference only.

## 5. Required Outputs

- `{{output_root}}/dfd/05-annotation-resolution.md` — Markdown table with the columns: `target_id` (component or flow), `target_kind` (component | flow), `label_raw`, `data_class`, `auth_marker`, `transit_marker`, `at_rest_marker`, `security_stack_marker`, `confidence`, `notes`.

## 6. Procedure

1. Resolve run-profile variables.
2. Read DFD-02..DFD-04 outputs and the legend excerpt.
3. For each visible token associated with a component or flow, populate the annotation columns from the legend excerpt; otherwise `unknown`.
4. Set `confidence` per Section 9.
5. Write `{{output_root}}/dfd/05-annotation-resolution.md`.
6. Stop before writing if any Section 7 stop condition holds.

## 7. Stop Conditions

- Required prior DFD outputs missing.
- Legend excerpt missing or unreadable.
- Run-profile unresolved or sensitive-data confirmation `false`.
- The work would invent a token meaning.
- Write outside `{{output_root}}` or to the old reference workspace.
- Any prohibited execution claim.

## 8. Unknown Handling

- Tokens not in the legend stay `unknown` for every field.
- Ambiguous tokens stay `unknown` with a note.
- Material unknowns (PCI marker, Class 5 marker, identity marker, transit marker, at-rest marker) propagate to DFD-08 and to RS-09.

## 9. Confidence Handling

- `HIGH` — token is in the legend excerpt and visibly drawn next to the target.
- `MEDIUM` — token is in the legend or the target's note; not both.
- `LOW` — token is visibly drawn but legend support is partial.
- `UNKNOWN` — token is not in the legend and no supporting note resolves the meaning.

## 10. Critical Misses

- Reinterpreting token semantics (`T#` as tokenization vs. transit, `authn` as `authz`).
- Treating a stack marker as approved stack.
- Missing a Class 5 / PCI / authn / transit / at-rest token visibly drawn.
- Defaulting unlabeled flows to a specific data class.
- Writing outside `{{output_root}}`.

## 11. Human Review Gate

The SAS reviewer must inspect rows with high-risk tokens (PCI, Class 5, identity, transit, at-rest, security stack).

## 12. Validation / Scoring Relationship

- Expected baseline (when present): `{{expected_root}}/expected-legend-normalization.json` (planned; defined in Build Package 10).
- Scoring category: feeds RS-03 legend normalization scoring (within `SK-ACCURACY-SCORE`).
- Missed PCI/Class 5 token is a critical miss.

## 13. Direct Skill Test

```
tools/New-AisrafRun.ps1 -RunId RUN-LOCAL-SK-DFD05-TEST -SampleId sample-001-dfd-crop -Mode folder_first_test -CopySampleInputs
tools/Test-AisrafRunProfile.ps1 -RunProfilePath runs/RUN-LOCAL-SK-DFD05-TEST/run-profile.yaml -ExecutionReady
```

- Run DFD-01..DFD-04 first, then open [prompts/dfd/06-annotation-resolve.prompt.md](../../prompts/dfd/06-annotation-resolve.prompt.md).
- Expected local output: `runs/RUN-LOCAL-SK-DFD05-TEST/dfd/05-annotation-resolution.md`.
- PASS = output exists; every annotation row is supported by the legend; no token meaning is invented.

## 14. Not In Scope

- No boundary crossing detection (owned by `SK-DFD-06-BOUNDARY-CROSSING-DETECT`).
- No control-signal detection (owned by `SK-DFD-07-CONTROL-SIGNAL-DETECT`).
- No PRA, adapter, connector, runtime, scoring, diagram, or release execution.
