# PRA-03-DFD-EXTRACTOR

## 1. Identity

- pra_id: `PRA-03-DFD-EXTRACTOR`
- pra_name: DFD Extractor
- status: active
- type: prototype review-agent specification
- package_scope: `aisraf-sas-prototype-v0.1.2`
- owning_build_package: `06`
- mapped_adapter: `.agents/aisraf-dfd-extractor.agent.md`
- adapter_consolidation_note: This adapter jointly wraps PRA-03 and PRA-04. PRA-04 (Legend Normalizer) has no dedicated adapter (founder decision Q1).

## 2. Purpose

Extract visible Data Flow Diagram (DFD) objects, components, and flows from the staged inputs, and run the 9-step DFD subskill chain when the operator stages DFD inputs. PRA-03 is the largest PRA by prompt and skill count. It is a specification, not a deployed runtime agent. PRA-04-LEGEND-NORMALIZER (`prompts/rs/03-legend-normalization.prompt.md`, `skills/rs/SK-LEGEND-NORMALIZE.md`) is exercised within the same adapter session but remains a distinct PRA spec.

## 3. Owned Prompts

RS family (2):

- `prompts/rs/02-dfd-visual-read.prompt.md` (RS-02).
- `prompts/rs/04-design-fact-extract.prompt.md` (RS-04 components and RS-05 flows; shared with PRA-03 only).

DFD family (9):

- `prompts/dfd/02-dfd-intake-quality-check.prompt.md` (DFD-01).
- `prompts/dfd/03-boundary-extract.prompt.md` (DFD-02).
- `prompts/dfd/04-component-extract.prompt.md` (DFD-03).
- `prompts/dfd/05-flow-extract.prompt.md` (DFD-04).
- `prompts/dfd/06-annotation-resolve.prompt.md` (DFD-05).
- `prompts/dfd/07-boundary-crossing-detect.prompt.md` (DFD-06).
- `prompts/dfd/08-control-signal-detect.prompt.md` (DFD-07).
- `prompts/dfd/09-confidence-score.prompt.md` (DFD-08).
- `prompts/dfd/10-dfd-extraction-summarize.prompt.md` (DFD-09).

Total prompts owned: 11.

## 4. Owned Skills

RS family (3):

- `skills/rs/SK-DFD-VISUAL-READ.md` (RS-02).
- `skills/rs/SK-COMPONENT-EXTRACT.md` (RS-04, owns `04-components.md`).
- `skills/rs/SK-FLOW-EXTRACT.md` (RS-05, owns `05-flows.md`).

DFD family (9):

- `skills/dfd/SK-DFD-01-INTAKE-QUALITY-CHECK.md`.
- `skills/dfd/SK-DFD-02-BOUNDARY-EXTRACT.md`.
- `skills/dfd/SK-DFD-03-COMPONENT-EXTRACT.md`.
- `skills/dfd/SK-DFD-04-FLOW-EXTRACT.md`.
- `skills/dfd/SK-DFD-05-ANNOTATION-RESOLVE.md`.
- `skills/dfd/SK-DFD-06-BOUNDARY-CROSSING-DETECT.md`.
- `skills/dfd/SK-DFD-07-CONTROL-SIGNAL-DETECT.md`.
- `skills/dfd/SK-DFD-08-CONFIDENCE-SCORE.md`.
- `skills/dfd/SK-DFD-09-EXTRACTION-SUMMARIZE.md`.

Total skills owned: 12.

## 5. Inputs

Required run-profile variables: `{{run_id}}`, `{{input_root}}`, `{{output_root}}`, `{{mode}}`, `{{postback_execution_status}}`, `{{output_destination_mode}}`.

Required reads:

- `runs/{{run_id}}/run-profile.yaml`.
- `{{output_root}}/01-input-inventory.md` (from PRA-02).
- `{{output_root}}/03-legend-normalization.md` (from PRA-04, before component/flow extraction).
- `{{input_root}}/` (DFD crop, supporting notes).
- For DFD subskill chain: `{{output_root}}/dfd/01-intake-quality-check.md` through `{{output_root}}/dfd/08-confidence-score.md`, as each DFD step completes.

Optional reads (test mode only):

- `{{expected_root}}/expected-visible-dfd-objects.json`, `expected-components.json`, `expected-flows.json`, `expected-boundaries.json`, when Build Package 10 provides them.

## 6. Outputs

RS family (3):

- `{{output_root}}/02-visible-dfd-objects.md`.
- `{{output_root}}/04-components.md`.
- `{{output_root}}/05-flows.md`.

DFD family (9):

- `{{output_root}}/dfd/01-intake-quality-check.md`.
- `{{output_root}}/dfd/02-boundary-catalog.md`.
- `{{output_root}}/dfd/03-component-catalog.md`.
- `{{output_root}}/dfd/04-flow-inventory.md`.
- `{{output_root}}/dfd/05-annotation-resolution.md`.
- `{{output_root}}/dfd/06-boundary-crossings.md`.
- `{{output_root}}/dfd/07-control-signals.md`.
- `{{output_root}}/dfd/08-confidence-score.md`.
- `{{output_root}}/dfd/09-extraction-summary.md`.

## 7. Procedure

1. Read `{{output_root}}/01-input-inventory.md` to confirm DFD inputs are present.
2. Run `prompts/rs/02-dfd-visual-read.prompt.md` with `skills/rs/SK-DFD-VISUAL-READ.md` to write `{{output_root}}/02-visible-dfd-objects.md`.
3. Hand off to PRA-04 (Legend Normalizer) for `prompts/rs/03-legend-normalization.prompt.md` → `{{output_root}}/03-legend-normalization.md`. Do not extract components or flows before legend normalization is accepted.
4. Run `prompts/rs/04-design-fact-extract.prompt.md` with `skills/rs/SK-COMPONENT-EXTRACT.md` and `skills/rs/SK-FLOW-EXTRACT.md` to write `{{output_root}}/04-components.md` and `{{output_root}}/05-flows.md`.
5. If the operator stages DFD inputs that warrant the DFD subskill chain, sequence DFD-01 through DFD-09 in order:
   - `prompts/dfd/02-dfd-intake-quality-check.prompt.md` → `{{output_root}}/dfd/01-intake-quality-check.md` (gate; if `proceed = false`, stop).
   - `prompts/dfd/03-boundary-extract.prompt.md` → `{{output_root}}/dfd/02-boundary-catalog.md`.
   - `prompts/dfd/04-component-extract.prompt.md` → `{{output_root}}/dfd/03-component-catalog.md`.
   - `prompts/dfd/05-flow-extract.prompt.md` → `{{output_root}}/dfd/04-flow-inventory.md`.
   - `prompts/dfd/06-annotation-resolve.prompt.md` → `{{output_root}}/dfd/05-annotation-resolution.md`.
   - `prompts/dfd/07-boundary-crossing-detect.prompt.md` → `{{output_root}}/dfd/06-boundary-crossings.md`.
   - `prompts/dfd/08-control-signal-detect.prompt.md` → `{{output_root}}/dfd/07-control-signals.md`.
   - `prompts/dfd/09-confidence-score.prompt.md` → `{{output_root}}/dfd/08-confidence-score.md` (per-row extraction confidence; not an accuracy score).
   - `prompts/dfd/10-dfd-extraction-summarize.prompt.md` → `{{output_root}}/dfd/09-extraction-summary.md` (records `accuracy_score_claim: not_applicable`).
6. After SAS acceptance of each output, request the corresponding run-log entry from PRA-01.
7. Hand off to PRA-05 (Review Table Builder) for boundary-crossing detection, security-stack assessment, and review-table build.

## 8. Human Gates

- SAS spot-checks `{{output_root}}/02-visible-dfd-objects.md` for invented or unsupported objects.
- SAS reviews uncertain components and material flows before PRA-05 begins.
- SAS confirms `{{output_root}}/dfd/01-intake-quality-check.md` allows progression before any DFD-02..DFD-09 step is attempted.
- SAS confirms `{{output_root}}/dfd/09-extraction-summary.md` records `accuracy_score_claim: not_applicable` (DFD summary never claims accuracy).

## 9. Stop Conditions

- Required prior output is missing or empty.
- An object, component, flow, protocol, owner, control, evidence, or implementation proof is invented.
- A material model, tool/API, write-back flow, data-store, SaaS, human actor, or internet-facing flow is missed.
- Unsupported precision is claimed from low-quality DFD input.
- A DFD subskill claims accuracy scoring (only `skills/rs/SK-ACCURACY-SCORE.md` may produce an accuracy score).
- Output written outside `{{output_root}}` (or `{{output_root}}/dfd/`).
- Any forbidden runtime/cloud/ADK/MCP/Jira/Confluence claim is recorded.

## 10. Unknown Handling

- Treat unknown labels, unknown protocols, unknown owners as `unknown`. Do not invent values.
- Treat absent annotations as `unknown` and route the gap to PRA-06 for missing-fact handling.
- Treat unknown DFD intake (`proceed = false`) as a stop, not a soft warning.
- Treat the absence of expected baselines as `not_applicable` for scoring purposes (PRA-08 owns the scoring decision).

## 11. Evidence and Run-Log Guidance

- Each owned RS-step (RS-02, RS-04, RS-05) and each DFD step (DFD-01..DFD-09) appends one run-log entry to `{{output_root}}/00-run-log.md` referencing prompt, skill, output file, and SAS reviewer decision.
- DFD subskill outputs live under `{{output_root}}/dfd/` and never elsewhere.

## 12. Direct Adapter Test

Operator opens `.agents/aisraf-dfd-extractor.agent.md` from the local Copilot Chat agent dropdown and asks: "Read `{{output_root}}/01-input-inventory.md`. Run `prompts/rs/02-dfd-visual-read.prompt.md` with `skills/rs/SK-DFD-VISUAL-READ.md` to write `{{output_root}}/02-visible-dfd-objects.md`. Then hand off to legend normalization (PRA-04) for `prompts/rs/03-legend-normalization.prompt.md` and resume with `prompts/rs/04-design-fact-extract.prompt.md`. Do not write outside `{{output_root}}`; do not invent objects, components, or flows; do not claim accuracy." A PASS test produces the visible-objects file, returns control for legend normalization, and does not invent or write elsewhere.

## 13. Not in Scope

- Not a deployed runtime agent.
- Not a Google ADK agent.
- Not a Vertex, GCP, or external cloud agent.
- Not an MCP execution surface.
- Not a Jira post-back, Confluence publication, or Rovo execution surface.
- Not allowed to perform legend normalization itself (PRA-04 owns it).
- Not allowed to perform boundary-crossing detection or stack assessment (PRA-05 owns those).
- Not allowed to write outside `{{output_root}}` or `{{output_root}}/dfd/`.
- Not allowed to modify `prompts/`, `skills/`, `config/`, `tools/`, `validation/`, `prototype-agents/`, `.agents/`, or any file under `{{expected_root}}`.
- Not allowed to claim accuracy scoring outside `skills/rs/SK-ACCURACY-SCORE.md`.
- Not allowed to claim release packaging or diagram generation.
