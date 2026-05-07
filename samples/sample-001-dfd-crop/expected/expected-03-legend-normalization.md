---
expected_baseline_id: EXP-RS-03-LEGEND-NORMALIZATION
sample_id: sample-001-dfd-crop
mirrors_template: templates/output/output-03-legend-normalization-template.md
prompt: prompts/rs/03-legend-normalization.prompt.md
skill: skills/rs/SK-LEGEND-NORMALIZE.md
owning_pra: PRA-04-LEGEND-NORMALIZER
adapter: .agents/aisraf-dfd-extractor.agent.md
target_run_output: "{{output_root}}/03-legend-normalization.md"
expected_outcome: PASS_READY_FOR_REVIEW
scoring_basis: template-aligned qualitative baseline; numeric scoring deferred to Build Package 11 run execution
package_version: v0.1.2
---

# Legend Normalization — sample-001-dfd-crop

| field | value |
|---|---|
| run_id | `{{run_id}}` |
| sample_id | sample-001-dfd-crop |
| mode | `{{mode}}` |
| output_root | `{{output_root}}` |
| step | RS-03 |
| prompt | prompts/rs/03-legend-normalization.prompt.md |
| skill | skills/rs/SK-LEGEND-NORMALIZE.md |
| owning_pra | PRA-04-LEGEND-NORMALIZER |

## Normalization Table

| raw_label | source_location | normalized_term | normalization_basis | confidence | notes |
|---|---|---|---|---|---|
| `IA1` | `dfd-crop.png` CMP-01; F1 label; `dfd-legend-excerpt.md` § 1 | `<value-from-catalogs/identity-access/authentication-catalog.yaml#AU-INTERNAL-AUTHENTICATION>` | `catalogs/identity-access/authentication-catalog.yaml#AU-INTERNAL-AUTHENTICATION` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Internal SSO per `review-transcript.md` § 2. |
| `SA1` | `dfd-crop.png` F2; F4; CMP-05; `dfd-legend-excerpt.md` § 1 | `<value-from-catalogs/identity-access/authentication-catalog.yaml#AU-SERVICE-AUTHENTICATION>` | `catalogs/identity-access/authentication-catalog.yaml#AU-SERVICE-AUTHENTICATION` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Service-to-service authentication; authorization scope is recorded separately. |
| `S1` | `dfd-crop.png` CMP-03 diamond; `dfd-legend-excerpt.md` § 1 | `<value-from-catalogs/security-stacks/security-stack-marker-catalog.yaml#SSM-STACK-DIAMOND>` | `catalogs/security-stacks/security-stack-marker-catalog.yaml#SSM-STACK-DIAMOND` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Marker only. Proof-vs-signal rule `SR-DIAMOND-NOT-APPROVED-STACK` applies. |
| `T1` | `dfd-crop.png` F1 label; `dfd-legend-excerpt.md` § 1 | `<value-from-catalogs/data-protection/transport-protection-catalog.yaml#TP-T-MARKER>` | `catalogs/data-protection/transport-protection-catalog.yaml#TP-T-MARKER` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Standalone T# is a transit-encryption marker (data-class-catalog ER-DC-06). |
| `E1` | `dfd-crop.png` CMP-04; F3 destination; `dfd-legend-excerpt.md` § 1 | `<value-from-catalogs/data-protection/at-rest-protection-catalog.yaml#AR-ENC-WORD>` | `catalogs/data-protection/at-rest-protection-catalog.yaml#AR-ENC-WORD` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | At-rest encryption marker; KMS / scope unknown. |
| `C2` | `dfd-crop.png` F7; CMP-06; `dfd-legend-excerpt.md` § 1 | `<value-from-catalogs/data-protection/data-class-catalog.yaml#DC-C2>` | `catalogs/data-protection/data-class-catalog.yaml#DC-C2` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Internal policy reference. |
| `C4` | `dfd-crop.png` F1 payload note; F6 payload note; CMP-07 | `<value-from-catalogs/data-protection/data-class-catalog.yaml#DC-C4>` | `catalogs/data-protection/data-class-catalog.yaml#DC-C4` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Restricted design / IP / review record class. |
| `C4P` | `dfd-crop.png` F3 payload; CMP-04 | `<value-from-catalogs/data-protection/data-class-catalog.yaml#DC-C5P>` (raw_pattern `^C[1-5]P$`) | `catalogs/data-protection/data-class-catalog.yaml#DC-C5P` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-MEDIUM>` | Token follows the C#P PCI/PAN suffix pattern; sample uses C4P to denote restricted personal-identity scope on reviewer metadata. Confidence reduced to medium because the catalog primarily documents C5P; sample-specific C4P is recorded with this note. |
| `formatted_only` | `dfd-crop.png` F8; CMP-08 | descriptive (no controlled vocabulary needed) | `templates/jira/jira-ticket-draft-template.md`; `templates/confluence/confluence-page-draft-template.md` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Not external post-back. |
| `model call` | `dfd-crop.png` F4 verb | `<value-from-catalogs/interactions/interaction-type-catalog.yaml#IT-MODEL-CALL>` | `catalogs/interactions/interaction-type-catalog.yaml#IT-MODEL-CALL` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | F4 verb token. |
| `class unknown` | `dfd-crop.png` F4 / F5 payload notes | `<value-from-catalogs/data-protection/data-class-catalog.yaml#DC-UNKNOWN>` | `catalogs/data-protection/data-class-catalog.yaml#DC-UNKNOWN` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Honest unknown — drives MF-03. |

## Unknowns

| unknown_id | label_observed | catalog_reference_checked | gap |
|---|---|---|---|
| UNK-03 | None at this step. | n/a | Material gaps belong to step RS-07. The C4P note above is recorded in the table itself. |

## Stop Conditions Recorded

None at this step. Every visible token resolves to a v0.1.2 catalog path with at most a medium-confidence annotation on `C4P`.
