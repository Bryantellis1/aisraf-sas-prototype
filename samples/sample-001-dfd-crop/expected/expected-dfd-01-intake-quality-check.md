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
| IQ-02 | DFD legend is present and lists every visible token used on the diagram, AND a compact legend panel is embedded inside the rendered DFD itself (`subgraph LEGEND`). | Annotation resolution can proceed without legend gaps; operator reading the rendered diagram has on-canvas vocabulary reference. | `{{input_root}}/dfd-legend-excerpt.md`; `{{input_root}}/dfd-crop.mmd` (`subgraph LEGEND`) | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Tokens: C2, C4, IA1, SA5, SA7, AZ?, AZ#, S1 (◇), T1, R1, Enc, Tok, Mask, Clr, Unknown. |
| IQ-03 | Boundary subgraphs are named with real architecture concepts (External User / Internet Zone, GCP Project, VPC, Edge / Application / Data subnets, External AI SaaS Provider Zone, Atlassian Cloud / Jira-Confluence Zone). | Extraction can proceed without `BND-*` extraction IDs as primary visual labels. | `{{input_root}}/dfd-crop.png` subgraphs | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Build Package 10A diagrammatic-quality gate satisfied. |
| IQ-04 | Components are named with real architecture concepts (Reviewer Browser, Cloud Load Balancer, Cloud Armor / WAF, Review Portal Web App, API Gateway, Review Orchestrator Service, AI Analysis Connector, External AI Model Endpoint, Review Metadata Cloud SQL, Policy Reference Store, Findings Store, Review Artifact Bucket, Audit Log Store, Jira / Confluence API). | Extraction can proceed without `CMP-*` extraction IDs as primary visual labels. | `{{input_root}}/dfd-crop.png` component nodes | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Build Package 10A diagrammatic-quality gate satisfied. |
| IQ-05 | Every flow label conforms to the 4-token grammar `<flow name> / <C#>,<T#>,<IA#|SA#|CA#>,<AZ#|AZ?>`. | Per-flow data class, transport, authentication, and authorization (or explicit unknown) are visibly recorded; flow extraction is unambiguous; a 3-token tuple is non-compliant. | `{{input_root}}/dfd-crop.png` every visible flow tuple (14 flows) | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Build Package 10A default-DFD-standard gate satisfied. |
| IQ-06 | Every Data subnet store carries a `<class> • R1 • Enc` storage tuple. | Per-store data class, replication marker, and at-rest state are visibly recorded. KMS / scope unknown is recorded downstream as MF-02. | `{{input_root}}/dfd-crop.png` Data subnet store labels | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Build Package 10A diagrammatic-quality gate satisfied. |
| IQ-07 | `S1 ◇` diamond on Cloud Armor / WAF is visible. | Recorded as a stack-marker signal at the internet edge; does not assert approved-stack. | `{{input_root}}/dfd-crop.png` Cloud Armor / WAF | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Drives MF-01. |
| IQ-08 | Every visible flow carries an explicit authorization token in the 4th position: either `AZ#` (visibly proven) or `AZ?` (explicit unknown). This sample asserts `AZ?` on all 14 flows. | Authorization is never silently dropped; authentication never implies authorization (`catalogs/identity-access/authentication-catalog.yaml#ER-AU-03`); downstream baselines record `AZ-UNKNOWN`. | `{{input_root}}/dfd-crop.png` every flow tuple's 4th position (14 flows) | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Build Package 10A default-DFD-standard gate satisfied. |
| IQ-09 | F9 / F10 carry `C4` in the visible flow tuple, but the redaction posture of the AI Analysis Connector is unknown. | Drives MF-03 — does the connector redact C4 review-IP before transmission to the External AI Model Endpoint, or transmit it verbatim? | `{{input_root}}/dfd-crop.png` F9 / F10 | `<value-from-catalogs/data-protection/confidence-level-catalog.yaml#CL-HIGH>` | Honest unknown — not a legibility problem. |

## Material Gaps

None at intake. The four open items (`S1` approved-stack scope; `Enc` KMS / scope on the five Data subnet stores; F9 / F10 redaction posture; `AZ#` scope) are recorded as material gaps at later DFD steps and at RS-07 — not as intake-level stop conditions.

## Stop Conditions Recorded

None at this step. The DFD chain may proceed to DFD-02.
