---
skill_id: SK-SECURITY-STACK-ASSESS
skill_name: Security Stack Assess
owning_build_package: Build Package 05
skill_family: rs
status: active
mapped_prompt_id: PR-RS-05
mapped_prompt_file: prompts/rs/05-boundary-stack-detect.prompt.md
future_pra_owner: PRA-DESIGN-FACT-EXTRACTOR (planned; defined in Build Package 06)
review_step: RS-07
---

# SK-SECURITY-STACK-ASSESS — Security Stack Assess

## 1. Identity

- skill_id: `SK-SECURITY-STACK-ASSESS`
- skill_name: Security Stack Assess
- owning_build_package: Build Package 05 — Skills and skill registry.
- skill_family: `rs`
- status: `active`
- mapped_prompt_id: `PR-RS-05`
- mapped_prompt_file: [prompts/rs/05-boundary-stack-detect.prompt.md](../../prompts/rs/05-boundary-stack-detect.prompt.md) (shared with `SK-BOUNDARY-CROSSING-DETECT`)
- future_pra_owner: `PRA-DESIGN-FACT-EXTRACTOR` (planned; defined in Build Package 06).
- review_step: `RS-07`

> Compatibility note: Package 04 prompt registry uses the placeholder name `SK-SECURITY-STACK-DETECT` for this skill's `future_skill_id` field. The canonical Package 05 name is `SK-SECURITY-STACK-ASSESS` to reflect that the skill assesses presence/absence and gap, not just detection. The drift is recorded in [skills/skill-registry.yaml](../skill-registry.yaml) compatibility_notes.

## 2. Purpose

Assess visible security-stack markers (gateway, WAF, API gateway, SIEM, DLP, IAP, CASB, identity checkpoint, policy gate, logging, encryption) along the boundary crossings produced by `SK-BOUNDARY-CROSSING-DETECT`, and flag missing expected checkpoints per boundary type. The skill never asserts a stack component that is not visibly drawn or supported by a corroborating note. Visible signals are review signals only, not implementation proof.

## 3. Required Inputs

- `runs/{{run_id}}/run-profile.yaml`
- `{{output_root}}/03-legend-normalization.md`
- `{{output_root}}/04-components.md`
- `{{output_root}}/05-flows.md`
- `{{output_root}}/06-boundaries.md`
- `config/run-profile.validation-rules.md`
- `config/path-resolution-rules.md`
- `config/sensitive-data-rules.md`

## 4. Optional Inputs

- `{{output_root}}/dfd/07-control-signals.md` — DFD subskill DFD-07 output, when present.
- `{{input_root}}/cloud-triage-notes.md`, `{{input_root}}/review-transcript.md`
- `{{expected_root}}/expected-security-stack-assessment.json` — relationship reference only.

## 5. Required Outputs

- `{{output_root}}/07-security-stack-assessment.md` — Markdown table with the columns: `boundary_ref`, `stack_component`, `visibility`, `expected_by_boundary_type`, `gap_flag`, `confidence`, `notes`.

## 6. Procedure

1. Resolve run-profile variables.
2. Read RS-03..RS-06 outputs.
3. For each boundary crossing in RS-06, list the stack components that the boundary type would expect (per the shared prompt's narrative; do not invoke an external catalog).
4. For each expected stack component, set `visibility` to `visible`, `partial`, `not_visible`, or `unknown` based on the visible source and supporting notes.
5. Set `gap_flag: true` when an expected stack component is `not_visible` or `unknown` at a boundary type that requires it; otherwise `false`.
6. Set `confidence` per Section 9.
7. Write `{{output_root}}/07-security-stack-assessment.md`.
8. Stop before writing if any Section 7 stop condition holds.

## 7. Stop Conditions

- RS-06 output missing.
- Run-profile unresolved or sensitive-data confirmation `false`.
- The work would assert a stack component as visible that is not drawn or noted.
- Write outside `{{output_root}}` or to the old reference workspace.
- Any prohibited execution claim.

## 8. Unknown Handling

- Stack components without visible markers stay `visibility: not_visible` or `unknown` with a note.
- Encryption type, key management, log destination, and similar facts that are not visible stay `unknown` and propagate to RS-09 when material.
- Visible stack-marker tokens are treated as review signals only, not implementation proof.

## 9. Confidence Handling

- `HIGH` — stack component is visibly drawn at the boundary, the legend supports the marker, and a corroborating note confirms the role.
- `MEDIUM` — stack component is visibly drawn but the role is partially supported.
- `LOW` — only a corroborating note hints at the marker (no visible drawing).
- `UNKNOWN` — neither visible drawing nor note supports the marker.

## 10. Critical Misses

- Inventing a security-stack component as visible.
- Treating a future cloud-service label as runtime proof.
- Treating a transit marker as at-rest, or vice versa.
- Writing outside `{{output_root}}`.

## 11. Human Review Gate

The SAS reviewer must inspect:

- Approved gateway, identity checkpoint, policy checkpoint, logging, and encryption markers.
- Each `gap_flag: true` row maps to a real visibility gap, not a missing review note.

## 12. Validation / Scoring Relationship

- Expected baseline (when present): `{{expected_root}}/expected-security-stack-assessment.json` (planned; defined in Build Package 10).
- Scoring category: boundary/security-stack detection (shared 15 points with `SK-BOUNDARY-CROSSING-DETECT` within `SK-ACCURACY-SCORE`).
- Invented stack presence is a critical miss.

## 13. Direct Skill Test

```
tools/New-AisrafRun.ps1 -RunId RUN-LOCAL-SK-STACK-TEST -SampleId sample-001-dfd-crop -Mode folder_first_test -CopySampleInputs
tools/Test-AisrafRunProfile.ps1 -RunProfilePath runs/RUN-LOCAL-SK-STACK-TEST/run-profile.yaml -ExecutionReady
```

- Run RS-01..RS-06 first, then open [prompts/rs/05-boundary-stack-detect.prompt.md](../../prompts/rs/05-boundary-stack-detect.prompt.md).
- Expected local output: `runs/RUN-LOCAL-SK-STACK-TEST/07-security-stack-assessment.md`.
- PASS = output exists; visibility values are honest; `gap_flag` is set only on real gaps; no invented stack presence.

## 14. Not In Scope

- No boundary-crossing detection (owned by `SK-BOUNDARY-CROSSING-DETECT`).
- No PRA, adapter, connector, runtime, scoring, diagram, or release execution.
- No claim of implementation proof from a visible stack marker.
- Catalogs are placeholders only `(planned; defined in Build Package 07)`.
