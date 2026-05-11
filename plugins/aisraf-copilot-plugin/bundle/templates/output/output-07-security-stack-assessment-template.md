# Template: Security Stack Assessment Output Shape

## 1. Template Metadata

| field | value |
|---|---|
| template_id | TPL-OUT-07-SECURITY-STACK-ASSESSMENT |
| template_name | Security Stack Assessment Output Shape |
| owning_build_package | Build Package 09 |
| status | active |
| purpose | Define the file-level shape of `{{output_root}}/07-security-stack-assessment.md`, written by PR-RS-05 / SK-SECURITY-STACK-ASSESS / PRA-05. |
| intended_output | `{{output_root}}/07-security-stack-assessment.md` |
| consumers | Prompts: PR-RS-05. Skills: SK-SECURITY-STACK-ASSESS. PRAs: PRA-05-REVIEW-TABLE-BUILDER. Adapters: aisraf-review-table-builder. Catalogs: catalogs/security-stacks/security-stack-marker-catalog.yaml; control-signal-catalog.yaml; proof-vs-signal-rule-catalog.yaml; catalogs/identity-access/authentication-catalog.yaml; authorization-catalog.yaml; identity-evidence-rule-catalog.yaml; catalogs/data-protection/transport-protection-catalog.yaml; at-rest-protection-catalog.yaml. |
| inputs_expected | `runs/{{run_id}}/run-profile.yaml`; `{{output_root}}/03-legend-normalization.md`; `{{output_root}}/04-components.md`; `{{output_root}}/05-flows.md` |
| placeholders | `{{run_id}}`, `{{input_root}}`, `{{output_root}}`, `{{mode}}`, `{{postback_execution_status}}`, `{{output_destination_mode}}` |
| required_sections | Header; Security Stack Marker Table (proof vs signal); Identity Markers; Data Protection Markers; Unknowns; Stop Conditions Recorded |
| prohibited_content | hidden inference; controlled-value enumeration; severity / score computation; finding or recommendation prose; "approved security stack" claims from catalog match |
| output_boundary | under_resolved_output_root_only |
| source_reference | aisraf-sas-prototype-skill-chain-pack-v0.01/templates/security-stack-assessment-template.md (rebuilt; v0.01 was a stub) |
| version_notes | Rebuilt for v0.1.2. |

## 2. Output Boundary

This template defines output shape only. It records visible markers and applies the global proof-vs-signal rule. A marker match is a signal; it never proves a control is implemented or approved.

## 3. Allowed Placeholders

Only the seven approved run-profile variables. Other run-profile fields are referenced descriptively.

## 4. File Header

```markdown
# Security Stack Assessment — {{run_id}}

| field | value |
|---|---|
| run_id | {{run_id}} |
| sample_id | [copy from runs/{{run_id}}/run-profile.yaml#sample_id] |
| mode | {{mode}} |
| output_root | {{output_root}} |
| step | RS-05 |
| prompt | prompts/rs/05-boundary-stack-detect.prompt.md |
| skill | skills/rs/SK-SECURITY-STACK-ASSESS.md |
| owning_pra | PRA-05-REVIEW-TABLE-BUILDER |
| global_rule | catalogs/security-stacks/proof-vs-signal-rule-catalog.yaml |
```

## 5. Required Sections

1. **Header**
2. **Security Stack Marker Table** — one row per visible marker:

   | marker_id | component_or_flow_referenced | marker_kind | marker_value | proof_or_signal | source_location | confidence | notes |
   |---|---|---|---|---|---|---|---|

   - `marker_kind` uses `<value-from-catalogs/security-stacks/security-stack-marker-catalog.yaml>` or `<value-from-catalogs/security-stacks/control-signal-catalog.yaml>`.
   - `proof_or_signal` is determined by `catalogs/security-stacks/proof-vs-signal-rule-catalog.yaml`. Default `signal` unless evidence meets the proof threshold described there.

3. **Identity Markers** — one row per identity-related marker:

   | marker_id | component_referenced | authentication_marker | authorization_marker | identity_evidence_rule_applied | proof_or_signal | confidence | notes |
   |---|---|---|---|---|---|---|---|

   - `authentication_marker` uses `<value-from-catalogs/identity-access/authentication-catalog.yaml>`.
   - `authorization_marker` uses `<value-from-catalogs/identity-access/authorization-catalog.yaml>`.
   - `identity_evidence_rule_applied` references `catalogs/identity-access/identity-evidence-rule-catalog.yaml`.

4. **Data Protection Markers** — one row per transport/at-rest marker:

   | marker_id | flow_or_store_referenced | transport_protection | at_rest_protection | proof_or_signal | confidence | notes |
   |---|---|---|---|---|---|---|

   - `transport_protection` uses `<value-from-catalogs/data-protection/transport-protection-catalog.yaml>`.
   - `at_rest_protection` uses `<value-from-catalogs/data-protection/at-rest-protection-catalog.yaml>`.

5. **Unknowns** — markers expected but not present, or labels not resolvable.
6. **Stop Conditions Recorded**.

## 6. Prohibited Content

- Asserting that a marker proves the control is implemented (the global proof-vs-signal rule applies).
- Asserting an "approved" security stack from a marker match.
- Severity, score, AI Action Level, or blueprint-match computation.
- Finding or recommendation prose.
- Enumerating catalog entries.

## 7. Source Reference

`aisraf-sas-prototype-skill-chain-pack-v0.01/templates/security-stack-assessment-template.md` (rebuilt; v0.01 was a stub).

## 8. Version Notes

Rebuilt for v0.1.2; explicit proof-vs-signal column added per Build Package 07 global rule.
