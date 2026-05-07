# Template: DFD Control Signals Output Shape

## 1. Template Metadata

| field | value |
|---|---|
| template_id | TPL-OUT-DFD-07-CONTROL-SIGNALS |
| template_name | DFD Control Signals Output Shape |
| owning_build_package | Build Package 09 |
| status | active |
| purpose | Define the file-level shape of `{{output_root}}/dfd/07-control-signals.md`, written by PR-DFD-08 / SK-DFD-07-CONTROL-SIGNAL-DETECT / PRA-03. |
| intended_output | `{{output_root}}/dfd/07-control-signals.md` |
| consumers | Prompts: PR-DFD-08. Skills: SK-DFD-07-CONTROL-SIGNAL-DETECT. PRAs: PRA-03-DFD-EXTRACTOR. Adapters: aisraf-dfd-extractor. Catalogs: catalogs/security-stacks/control-signal-catalog.yaml; security-stack-marker-catalog.yaml; proof-vs-signal-rule-catalog.yaml. |
| inputs_expected | `runs/{{run_id}}/run-profile.yaml`; `{{output_root}}/dfd/03-component-catalog.md`; `{{output_root}}/dfd/04-flow-inventory.md`; `{{output_root}}/dfd/05-annotation-resolution.md`; `{{output_root}}/dfd/06-boundary-crossings.md` |
| placeholders | `{{run_id}}`, `{{input_root}}`, `{{output_root}}`, `{{mode}}`, `{{postback_execution_status}}`, `{{output_destination_mode}}` |
| required_sections | Header; Control Signal Rows (proof vs signal); Unknowns; Stop Conditions Recorded |
| prohibited_content | hidden inference; controlled-value enumeration; severity / score computation; finding or recommendation prose; "approved security stack" claims from catalog match |
| output_boundary | under_resolved_output_root_dfd_subfolder_only |
| source_reference | aisraf-sas-prototype-skill-chain-pack-v0.01/templates/dfd-control-assessment-template.md (rebuilt for v0.1.2) |
| version_notes | Rebuilt for v0.1.2. |

## 2. Output Boundary

This template defines output shape only. It records visible control signals and applies the global proof-vs-signal rule. A signal match never proves the underlying control is implemented or approved.

## 3. Allowed Placeholders

Only the seven approved run-profile variables. Other run-profile fields are referenced descriptively.

## 4. File Header

```markdown
# DFD Control Signals — {{run_id}}

| field | value |
|---|---|
| run_id | {{run_id}} |
| sample_id | [copy from runs/{{run_id}}/run-profile.yaml#sample_id] |
| mode | {{mode}} |
| output_root | {{output_root}} |
| dfd_step | DFD-07 |
| prompt | prompts/dfd/08-control-signal-detect.prompt.md |
| skill | skills/dfd/SK-DFD-07-CONTROL-SIGNAL-DETECT.md |
| owning_pra | PRA-03-DFD-EXTRACTOR |
| global_rule | catalogs/security-stacks/proof-vs-signal-rule-catalog.yaml |
```

## 5. Required Sections

1. **Header**
2. **Control Signal Rows**:

   | signal_id | component_or_flow_referenced | signal_kind | signal_value | proof_or_signal | source_location | confidence | notes |
   |---|---|---|---|---|---|---|---|

   `signal_kind` uses `<value-from-catalogs/security-stacks/control-signal-catalog.yaml>` or `<value-from-catalogs/security-stacks/security-stack-marker-catalog.yaml>`. `proof_or_signal` defaults to `signal` unless `catalogs/security-stacks/proof-vs-signal-rule-catalog.yaml` raises it.

3. **Unknowns**.
4. **Stop Conditions Recorded**.

## 6. Prohibited Content

- Asserting a marker proves a control is implemented (proof-vs-signal rule applies).
- Asserting an "approved" security stack from a marker match.
- Severity, score, or AI Action Level computation.
- Finding or recommendation prose.
- Enumerated catalog values.

## 7. Source Reference

`aisraf-sas-prototype-skill-chain-pack-v0.01/templates/dfd-control-assessment-template.md` (rebuilt for v0.1.2).

## 8. Version Notes

Rebuilt for v0.1.2.
