---
skill_id: SK-BOUNDARY-CROSSING-DETECT
skill_name: Boundary Crossing Detect
owning_build_package: Build Package 05
skill_family: rs
status: active
mapped_prompt_id: PR-RS-05
mapped_prompt_file: prompts/rs/05-boundary-stack-detect.prompt.md
future_pra_owner: PRA-DESIGN-FACT-EXTRACTOR (planned; defined in Build Package 06)
review_step: RS-06
---

# SK-BOUNDARY-CROSSING-DETECT — Boundary Crossing Detect

## 1. Identity

- skill_id: `SK-BOUNDARY-CROSSING-DETECT`
- skill_name: Boundary Crossing Detect
- owning_build_package: Build Package 05 — Skills and skill registry.
- skill_family: `rs`
- status: `active`
- mapped_prompt_id: `PR-RS-05`
- mapped_prompt_file: [prompts/rs/05-boundary-stack-detect.prompt.md](../../prompts/rs/05-boundary-stack-detect.prompt.md) (shared with `SK-SECURITY-STACK-ASSESS`)
- future_pra_owner: `PRA-DESIGN-FACT-EXTRACTOR` (planned; defined in Build Package 06).
- review_step: `RS-06`

## 2. Purpose

Detect every visible or supported boundary crossing where a flow moves between zones, trust levels, externally exposed entry points, third-party services, customer environments, internal services, data stores, model endpoints, or tool/API surfaces. The skill records the boundary crossing as a row with explicit auth and encryption visibility. Missed internet-facing boundaries are critical misses.

## 3. Required Inputs

- `runs/{{run_id}}/run-profile.yaml`
- `{{output_root}}/03-legend-normalization.md`
- `{{output_root}}/04-components.md`
- `{{output_root}}/05-flows.md`
- `config/run-profile.validation-rules.md`
- `config/path-resolution-rules.md`
- `config/sensitive-data-rules.md`

## 4. Optional Inputs

- `{{output_root}}/dfd/06-boundary-crossings.md` — DFD subskill DFD-06 output, when present.
- `{{input_root}}/cloud-triage-notes.md`, `{{input_root}}/review-transcript.md`
- `{{expected_root}}/expected-boundaries.json` — relationship reference only.

## 5. Required Outputs

- `{{output_root}}/06-boundaries.md` — Markdown table with the columns: `crossing_id`, `flow_ref`, `source_zone`, `destination_zone`, `internet_facing`, `data_class`, `auth_visible`, `encryption_visible`, `confidence`, `notes`.

The shared prompt also writes `{{output_root}}/07-security-stack-assessment.md` (owned by `SK-SECURITY-STACK-ASSESS`).

## 6. Procedure

1. Resolve run-profile variables.
2. Read RS-03, RS-04, RS-05 outputs.
3. For every flow, determine whether the source and destination components live in different zones.
4. For each crossing flow, produce a boundary-crossing row.
5. Set `internet_facing: true` only when at least one endpoint is in the public internet zone or an externally exposed entry point.
6. Populate `data_class`, `auth_visible`, `encryption_visible` from the RS-03 normalized legend rows; otherwise `unknown`.
7. Set `confidence` per Section 9.
8. Write `{{output_root}}/06-boundaries.md`.
9. Stop before writing if any Section 7 stop condition holds.

## 7. Stop Conditions

- Required prior outputs missing.
- Run-profile unresolved or sensitive-data confirmation `false`.
- The work would invent a boundary or trust level not supported by RS-04 zone assignments.
- Write outside `{{output_root}}` or to the old reference workspace.
- Any prohibited execution claim.

## 8. Unknown Handling

- Boundary fields without legend or note support remain `unknown`.
- Trust level, owner, exposure, and policy facts that are not visible remain `unknown`.
- Material unknowns (auth at internet boundary, encryption at internet/PCI boundary) carry forward to RS-09.

## 9. Confidence Handling

- `HIGH` — both zones are clearly assigned in RS-04, the flow is unambiguous, and auth/encryption are legend-supported.
- `MEDIUM` — zones clear but one of `auth_visible` / `encryption_visible` is `unknown`.
- `LOW` — at least one zone is ambiguous or the flow's endpoint is `unknown` in RS-04.
- `UNKNOWN` — flow exists but neither zone can be reliably assigned.

## 10. Critical Misses

- Missing an internet/customer-facing boundary.
- Missing a model/tool/data-store/human boundary that is visibly drawn.
- Claiming auth or encryption controls from a boundary label alone.
- Writing outside `{{output_root}}`.

## 11. Human Review Gate

The SAS reviewer must inspect every internet-facing, third-party, model endpoint, data-store, tool/API, and customer-environment crossing for accuracy and unknowns.

## 12. Validation / Scoring Relationship

- Expected baseline (when present): `{{expected_root}}/expected-boundaries.json` (planned; defined in Build Package 10).
- Scoring category: boundary/security-stack detection (shared 15 points with `SK-SECURITY-STACK-ASSESS` within `SK-ACCURACY-SCORE`).
- Missed internet-facing boundary forces a FAIL.

## 13. Direct Skill Test

```
tools/New-AisrafRun.ps1 -RunId RUN-LOCAL-SK-BOUNDARY-TEST -SampleId sample-001-dfd-crop -Mode folder_first_test -CopySampleInputs
tools/Test-AisrafRunProfile.ps1 -RunProfilePath runs/RUN-LOCAL-SK-BOUNDARY-TEST/run-profile.yaml -ExecutionReady
```

- Run RS-01..RS-04 first, then open [prompts/rs/05-boundary-stack-detect.prompt.md](../../prompts/rs/05-boundary-stack-detect.prompt.md).
- Expected local output: `runs/RUN-LOCAL-SK-BOUNDARY-TEST/06-boundaries.md`.
- PASS = output exists; internet-facing crossings are present where supported; unknowns are explicit; no critical miss.

## 14. Not In Scope

- No security stack assessment (owned by `SK-SECURITY-STACK-ASSESS`).
- No PRA, adapter, connector, runtime, scoring, diagram, or release execution.
- Catalogs are placeholders only `(planned; defined in Build Package 07)`.
