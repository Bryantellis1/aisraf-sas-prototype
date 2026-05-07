---
expected_baseline_id: EXP-DFD-05-ANNOTATION-RESOLUTION
sample_id: sample-001-dfd-crop
mirrors_template: templates/output/output-dfd-05-annotation-resolution-template.md
prompt: prompts/dfd/06-annotation-resolve.prompt.md
skill: skills/dfd/SK-DFD-05-ANNOTATION-RESOLVE.md
owning_pra: PRA-03-DFD-EXTRACTOR
adapter: .agents/aisraf-dfd-extractor.agent.md
target_run_output: "{{output_root}}/dfd/05-annotation-resolution.md"
expected_outcome: PASS_READY_FOR_REVIEW
scoring_basis: template-aligned qualitative baseline; numeric scoring deferred to Build Package 11 run execution
package_version: v0.1.2
---

# DFD Annotation Resolution — sample-001-dfd-crop

| field | value |
|---|---|
| run_id | `{{run_id}}` |
| sample_id | sample-001-dfd-crop |
| mode | `{{mode}}` |
| output_root | `{{output_root}}` |
| dfd_step | DFD-05 |
| prompt | prompts/dfd/06-annotation-resolve.prompt.md |
| skill | skills/dfd/SK-DFD-05-ANNOTATION-RESOLVE.md |
| owning_pra | PRA-03-DFD-EXTRACTOR |

## Resolved Annotations

| annotation_id | annotation_visible | resolved_to_catalog_value | resolution_basis | source_location | confidence | notes |
|---|---|---|---|---|---|---|
| AN-01 | `IA1` | `<value-from-catalogs/identity-access/authentication-catalog.yaml#AU-INTERNAL-AUTHENTICATION>` | `catalogs/identity-access/authentication-catalog.yaml#AU-INTERNAL-AUTHENTICATION` | `dfd-crop.png` CMP-01; F1 | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Internal SSO per `review-transcript.md` § 2. |
| AN-02 | `SA1` | `<value-from-catalogs/identity-access/authentication-catalog.yaml#AU-SERVICE-AUTHENTICATION>` | `catalogs/identity-access/authentication-catalog.yaml#AU-SERVICE-AUTHENTICATION` | `dfd-crop.png` F2; F4 | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Service-to-service AuthN. |
| AN-03 | `S1` | `<value-from-catalogs/security-stacks/security-stack-marker-catalog.yaml#SSM-STACK-DIAMOND>` | `catalogs/security-stacks/security-stack-marker-catalog.yaml#SSM-STACK-DIAMOND` | `dfd-crop.png` CMP-03 diamond | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Marker only; proof-vs-signal rule applies. |
| AN-04 | `T1` | `<value-from-catalogs/data-protection/transport-protection-catalog.yaml#TP-T-MARKER>` | `catalogs/data-protection/transport-protection-catalog.yaml#TP-T-MARKER` | `dfd-crop.png` F1 | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Standalone T# is transit-encryption marker. |
| AN-05 | `E1` | `<value-from-catalogs/data-protection/at-rest-protection-catalog.yaml#AR-ENC-WORD>` | `catalogs/data-protection/at-rest-protection-catalog.yaml#AR-ENC-WORD` | `dfd-crop.png` CMP-04 | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Component-scope at-rest marker. |
| AN-06 | `C2` | `<value-from-catalogs/data-protection/data-class-catalog.yaml#DC-C2>` | `catalogs/data-protection/data-class-catalog.yaml#DC-C2` | `dfd-crop.png` F7; CMP-06 | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Internal policy data. |
| AN-07 | `C4` | `<value-from-catalogs/data-protection/data-class-catalog.yaml#DC-C4>` | `catalogs/data-protection/data-class-catalog.yaml#DC-C4` | `dfd-crop.png` F1; F6; CMP-07 | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Restricted review records. |
| AN-08 | `C4P` | `<value-from-catalogs/data-protection/data-class-catalog.yaml#DC-C5P>` (raw_pattern `^C[1-5]P$`) | `catalogs/data-protection/data-class-catalog.yaml#DC-C5P` | `dfd-crop.png` F3; CMP-04 | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-MEDIUM>` | Catalog covers the C#P pattern under DC-C5P; sample-specific C4P recorded with this note. |
| AN-09 | F4 / F5 `class unknown` | `<value-from-catalogs/data-protection/data-class-catalog.yaml#DC-UNKNOWN>` | `catalogs/data-protection/data-class-catalog.yaml#DC-UNKNOWN` | `dfd-crop.png` F4; F5 | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Honest unknown — drives MF-03. |
| AN-10 | F8 `formatted_only` | descriptive only (no controlled vocabulary required) | `templates/jira/jira-ticket-draft-template.md`; `templates/confluence/confluence-page-draft-template.md` | `dfd-crop.png` F8; CMP-08 | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Local draft only. |

## Unresolved Annotations

None at this step. The two `class unknown` annotations on F4 / F5 resolve cleanly to `DC-UNKNOWN`; that is a resolved annotation, not an unresolved one.

## Stop Conditions Recorded

None at this step.
