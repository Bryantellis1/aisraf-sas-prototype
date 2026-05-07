---
skill_id: SK-DFD-07-CONTROL-SIGNAL-DETECT
skill_name: DFD Control Signal Detect
owning_build_package: Build Package 05
skill_family: dfd
status: active
mapped_prompt_id: PR-DFD-08
mapped_prompt_file: prompts/dfd/08-control-signal-detect.prompt.md
future_pra_owner: PRA-DFD-EXTRACTOR (planned; defined in Build Package 06)
dfd_step: DFD-07
---

# SK-DFD-07-CONTROL-SIGNAL-DETECT — DFD Control Signal Detect

## 1. Identity

- skill_id: `SK-DFD-07-CONTROL-SIGNAL-DETECT`
- skill_name: DFD Control Signal Detect
- owning_build_package: Build Package 05 — Skills and skill registry.
- skill_family: `dfd`
- status: `active`
- mapped_prompt_id: `PR-DFD-08`
- mapped_prompt_file: [prompts/dfd/08-control-signal-detect.prompt.md](../../prompts/dfd/08-control-signal-detect.prompt.md)
- future_pra_owner: `PRA-DFD-EXTRACTOR` (planned; defined in Build Package 06).
- dfd_step: `DFD-07`

## 2. Purpose

Detect visible control and security-stack signals (gateway, WAF, API gateway, SIEM, DLP, IAP, CASB, identity checkpoint, policy gate, logging, encryption) without claiming hidden controls or implementation proof. Visible signals are review signals only.

## 3. Required Inputs

- `runs/{{run_id}}/run-profile.yaml`
- `{{output_root}}/dfd/03-component-catalog.md`
- `{{output_root}}/dfd/04-flow-inventory.md`
- `{{output_root}}/dfd/05-annotation-resolution.md`
- `{{output_root}}/dfd/06-boundary-crossings.md`
- `config/run-profile.validation-rules.md`
- `config/path-resolution-rules.md`
- `config/sensitive-data-rules.md`

## 4. Optional Inputs

- `{{expected_root}}/expected-security-stack-assessment.json` — relationship reference only.

## 5. Required Outputs

- `{{output_root}}/dfd/07-control-signals.md` — Markdown table with the columns: `signal_id`, `boundary_ref`, `flow_ref`, `signal_type`, `visibility`, `signal_source`, `confidence`, `notes`.

## 6. Procedure

1. Resolve run-profile variables.
2. Read DFD-03..DFD-06 outputs.
3. For each visibly drawn or annotation-supported control signal, produce one row.
4. Set `signal_type` (e.g., `waf`, `api_gateway`, `siem`, `dlp`, `iap`, `casb`, `identity_checkpoint`, `policy_gate`, `logging`, `encryption`).
5. Set `visibility` to `visible`, `partial`, `not_visible`, or `unknown`.
6. Set `confidence` per Section 9.
7. Write `{{output_root}}/dfd/07-control-signals.md`.
8. Stop before writing if any Section 7 stop condition holds.

## 7. Stop Conditions

- Required prior DFD outputs missing.
- Run-profile unresolved or sensitive-data confirmation `false`.
- The work would assert a hidden control as visible.
- Write outside `{{output_root}}` or to the old reference workspace.
- Any prohibited execution claim.

## 8. Unknown Handling

- Signal type unknown when no marker supports it.
- Visibility unknown when neither drawing nor note supports it.

## 9. Confidence Handling

- `HIGH` — signal is visibly drawn and the legend supports the marker.
- `MEDIUM` — signal partially supported by drawing or note.
- `LOW` — signal supported only by note (no visible drawing).
- `UNKNOWN` — neither drawing nor note supports the signal.

## 10. Critical Misses

- Inventing a control signal as visible.
- Treating a future cloud-service label as runtime proof.
- Treating a transit marker as at-rest, or vice versa.
- Writing outside `{{output_root}}`.

## 11. Human Review Gate

The SAS reviewer must inspect every `visibility: visible` row and every gap row.

## 12. Validation / Scoring Relationship

- Expected baseline (when present): `{{expected_root}}/expected-security-stack-assessment.json` (planned; defined in Build Package 10).
- Scoring category: feeds RS-07 security-stack assessment scoring (within `SK-ACCURACY-SCORE`).
- Invented control is a critical miss.

## 13. Direct Skill Test

```
tools/New-AisrafRun.ps1 -RunId RUN-LOCAL-SK-DFD07-TEST -SampleId sample-001-dfd-crop -Mode folder_first_test -CopySampleInputs
tools/Test-AisrafRunProfile.ps1 -RunProfilePath runs/RUN-LOCAL-SK-DFD07-TEST/run-profile.yaml -ExecutionReady
```

- Run DFD-01..DFD-06 first, then open [prompts/dfd/08-control-signal-detect.prompt.md](../../prompts/dfd/08-control-signal-detect.prompt.md).
- Expected local output: `runs/RUN-LOCAL-SK-DFD07-TEST/dfd/07-control-signals.md`.
- PASS = output exists; every row is honest about visibility; no invented controls.

## 14. Not In Scope

- No confidence scoring per row (owned by `SK-DFD-08-CONFIDENCE-SCORE`).
- No PRA, adapter, connector, runtime, scoring, diagram, or release execution.
- No claim of implementation proof from a marker.
