---
skill_id: SK-LEGEND-NORMALIZE
skill_name: Legend Normalize
owning_build_package: Build Package 05
skill_family: rs
status: active
mapped_prompt_id: PR-RS-03
mapped_prompt_file: prompts/rs/03-legend-normalization.prompt.md
future_pra_owner: PRA-DFD-READER (planned; defined in Build Package 06)
review_step: RS-03
---

# SK-LEGEND-NORMALIZE — Legend Normalize

## 1. Identity

- skill_id: `SK-LEGEND-NORMALIZE`
- skill_name: Legend Normalize
- owning_build_package: Build Package 05 — Skills and skill registry.
- skill_family: `rs`
- status: `active`
- mapped_prompt_id: `PR-RS-03`
- mapped_prompt_file: [prompts/rs/03-legend-normalization.prompt.md](../../prompts/rs/03-legend-normalization.prompt.md)
- future_pra_owner: `PRA-DFD-READER` (planned; defined in Build Package 06).
- review_step: `RS-03`

> Compatibility note: Package 04 prompt registry uses the placeholder name `SK-DFD-LEGEND-NORMALIZE` for this skill's `future_skill_id` field. The canonical Package 05 name is `SK-LEGEND-NORMALIZE`. The drift is recorded in [skills/skill-registry.yaml](../skill-registry.yaml) compatibility_notes; the prompt registry is not edited in Build Package 05.

## 2. Purpose

Normalize the visible DFD legend, label, and annotation tokens to a structured row per visible label so downstream skills can reason over data class, protection suffix, auth marker, transit encryption, and at-rest encryption with explicit support and confidence. The skill never invents a token meaning; unsupported tokens stay `unknown`. It does not classify components, flows, or boundaries.

## 3. Required Inputs

- `runs/{{run_id}}/run-profile.yaml`
- `{{output_root}}/01-input-inventory.md`
- `{{output_root}}/02-visible-dfd-objects.md`
- `{{input_root}}/` — DFD legend excerpt and supporting notes.
- `config/run-profile.validation-rules.md`
- `config/path-resolution-rules.md`
- `config/sensitive-data-rules.md`

## 4. Optional Inputs

- `{{output_root}}/dfd/05-annotation-resolution.md` — DFD subskill DFD-05 output, when present.
- `{{expected_root}}/expected-legend-normalization.json` — relationship reference only.

## 5. Required Outputs

- `{{output_root}}/03-legend-normalization.md` — Markdown table with the columns: `label_raw`, `data_class`, `protection_suffix`, `auth_marker`, `transit_encryption`, `at_rest_encryption`, `normalized_result`, `confidence`, `notes`.

No other write path is permitted. No write outside `{{output_root}}` is permitted.

## 6. Procedure

1. Resolve run-profile variables.
2. Read RS-01 and RS-02 outputs and the DFD legend excerpt at `{{input_root}}/`.
3. For every label associated with a visible DFD object (from RS-02), produce a normalized row.
4. Populate `data_class`, `protection_suffix`, `auth_marker`, `transit_encryption`, `at_rest_encryption` only when the legend or the visible label supports the value. Otherwise set the field to `unknown`.
5. Set `confidence` per Section 9.
6. Write `{{output_root}}/03-legend-normalization.md`.
7. Stop before writing if any Section 7 stop condition holds.

## 7. Stop Conditions

- Required RS-01 or RS-02 output missing.
- Legend excerpt missing or unreadable.
- Any required run-profile variable unresolved.
- `sensitive_data_confirmed_redacted` is `false`.
- Token meaning is invented (no legend or visible support).
- Write outside `{{output_root}}`.
- Read or write of the old reference workspace.
- Any prohibited execution claim (skill, PRA, adapter, connector, runtime, scoring, diagram, release).

## 8. Unknown Handling

- Tokens not present in the legend or supporting notes remain `unknown` for every field.
- Ambiguous tokens (multiple plausible meanings, no disambiguation) remain `unknown` with a `notes` reason.
- Material unknowns (PCI marker, Class 5 marker, identity marker, transit marker, at-rest marker) carry forward to RS-09 (`SK-MISSING-FACT-IDENTIFY`).

## 9. Confidence Handling

- `HIGH` — token meaning is fully supported by the legend excerpt, visibly drawn token, and one corroborating note.
- `MEDIUM` — token meaning is supported by the legend or a corroborating note, but not both.
- `LOW` — token is visibly drawn but legend support is partial or ambiguous.
- `UNKNOWN` — token is not in the legend and no supporting note resolves the meaning.

## 10. Critical Misses

- Reinterpreting a token's semantics (e.g., treating a tokenization marker as encryption, or `authn` as `authz`).
- Missing a visible Class 5 / PCI / authn / transit / at-rest / security-stack token.
- Defaulting unlabeled flows to a specific data class.
- Writing outside `{{output_root}}`.

## 11. Human Review Gate

The SAS reviewer must inspect:

- Every high-risk token (PCI, Class 5, identity, transit, at-rest, security stack) is present in the table or explicitly marked `unknown`.
- No token is reinterpreted away from the legend's semantics.
- Confidence levels match legend/source support.

## 12. Validation / Scoring Relationship

- Expected baseline (when present): `{{expected_root}}/expected-legend-normalization.json` (planned; defined in Build Package 10).
- Scoring category: DFD legend normalization (15 points within `SK-ACCURACY-SCORE`).
- Missed PCI/Class 5 tokens are critical misses that force a FAIL.

## 13. Direct Skill Test

```
tools/New-AisrafRun.ps1 -RunId RUN-LOCAL-SK-LEGEND-TEST -SampleId sample-001-dfd-crop -Mode folder_first_test -CopySampleInputs
tools/Test-AisrafRunProfile.ps1 -RunProfilePath runs/RUN-LOCAL-SK-LEGEND-TEST/run-profile.yaml -ExecutionReady
```

- Run RS-01 and RS-02 prompt cards first, then open [prompts/rs/03-legend-normalization.prompt.md](../../prompts/rs/03-legend-normalization.prompt.md).
- Expected local output: `runs/RUN-LOCAL-SK-LEGEND-TEST/03-legend-normalization.md`.
- PASS = output exists; every row corresponds to a label observed in RS-02; no token meaning is invented; PCI/Class 5 tokens are not silently dropped.

## 14. Not In Scope

- No component, flow, boundary, or security-stack interpretation.
- No PRA, adapter, connector, runtime, scoring, diagram, or release execution.
- Catalogs are referenced as `(planned; defined in Build Package 07)` placeholders only.
