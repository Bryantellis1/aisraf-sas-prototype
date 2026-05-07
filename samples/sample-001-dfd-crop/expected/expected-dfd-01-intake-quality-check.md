---
expected_baseline_id: EXP-DFD-01-INTAKE-QUALITY-CHECK
sample_id: sample-001-dfd-crop
mirrors_template: templates/output/output-dfd-01-intake-quality-check-template.md
prompt: prompts/dfd/02-dfd-intake-quality-check.prompt.md
skill: skills/dfd/SK-DFD-01-INTAKE-QUALITY-CHECK.md
owning_pra: PRA-03-DFD-EXTRACTOR
adapter: .agents/aisraf-dfd-extractor.agent.md
target_run_output: "{{output_root}}/dfd/01-intake-quality-check.md"
expected_outcome: PASS_READY_FOR_REVIEW
scoring_basis: template-aligned qualitative baseline; numeric scoring deferred to Build Package 11 run execution
package_version: v0.1.2
---

# DFD Intake Quality Check — sample-001-dfd-crop

| field | value |
|---|---|
| run_id | `{{run_id}}` |
| sample_id | sample-001-dfd-crop |
| mode | `{{mode}}` |
| input_root | `{{input_root}}` |
| output_root | `{{output_root}}` |
| dfd_step | DFD-01 |
| prompt | prompts/dfd/02-dfd-intake-quality-check.prompt.md |
| skill | skills/dfd/SK-DFD-01-INTAKE-QUALITY-CHECK.md |
| owning_pra | PRA-03-DFD-EXTRACTOR |

## Intake Quality Findings

| finding_id | observation | impact_on_extraction | source_location | confidence | notes |
|---|---|---|---|---|---|
| IQ-01 | DFD image and Mermaid source are present and legible. | Extraction can proceed against `dfd-crop.png` and `dfd-crop.mmd`. | `{{input_root}}/dfd-crop.png`; `{{input_root}}/dfd-crop.mmd` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | None. |
| IQ-02 | DFD legend is present and lists every visible token used on the diagram. | Annotation resolution can proceed without legend gaps. | `{{input_root}}/dfd-legend-excerpt.md` | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Tokens: C2, C4, C4P, IA1, SA1, S1, T1, E1, formatted_only, model call, class unknown. |
| IQ-03 | F4 / F5 payload notes carry an explicit `class unknown` token. | Data-class resolution on F4 / F5 is intentionally `DC-UNKNOWN` and routes to MF-03. | `{{input_root}}/dfd-crop.png` F4 / F5 | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Honest unknown — not a legibility problem. |
| IQ-04 | `S1` diamond on CMP-03 is visible. | Recorded as a stack-marker signal; does not assert approved-stack. | `{{input_root}}/dfd-crop.png` CMP-03 | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Drives MF-01. |

## Material Gaps

None at intake. The four `class unknown` / `S1` / `E1` items above are recorded as material gaps at later DFD steps and at RS-07 — not as intake-level stop conditions.

## Stop Conditions Recorded

None at this step. The DFD chain may proceed to DFD-02.
