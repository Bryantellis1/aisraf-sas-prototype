# PRA-04-LEGEND-NORMALIZER

## 1. Identity

- pra_id: `PRA-04-LEGEND-NORMALIZER`
- pra_name: Legend Normalizer
- status: active
- type: prototype review-agent specification
- package_scope: `aisraf-sas-prototype-v0.1.2`
- owning_build_package: `06`
- mapped_adapter: `.agents/aisraf-dfd-extractor.agent.md` (no dedicated adapter; founder decision Q1)

## 2. Purpose

Normalise the visible labels and annotations on a DFD into a consistent vocabulary that the downstream PRAs can rely on, while preserving the corrected semantics of the visible legend. PRA-04 sits between PRA-03's visible-objects pass and PRA-03's component/flow extraction pass. It is a specification, not a deployed runtime agent. It has no dedicated `.agent.md` adapter; the AISRAF DFD Extractor adapter jointly wraps PRA-03 and PRA-04 in a single local Copilot session.

## 3. Owned Prompts

- `prompts/rs/03-legend-normalization.prompt.md` (RS-03).

## 4. Owned Skills

- `skills/rs/SK-LEGEND-NORMALIZE.md`.

## 5. Inputs

Required run-profile variables: `{{run_id}}`, `{{input_root}}`, `{{output_root}}`, `{{mode}}`, `{{postback_execution_status}}`, `{{output_destination_mode}}`.

Required reads:

- `runs/{{run_id}}/run-profile.yaml`.
- `{{output_root}}/01-input-inventory.md` (from PRA-02).
- `{{output_root}}/02-visible-dfd-objects.md` (from PRA-03).
- `{{input_root}}/` for the DFD legend excerpt and any supplementary annotation notes.

Optional reads (test mode only):

- `{{expected_root}}/expected-legend-normalization.json`, when Build Package 10 provides it.

## 6. Outputs

- `{{output_root}}/03-legend-normalization.md`.

## 7. Procedure

1. Read `{{output_root}}/02-visible-dfd-objects.md` and the DFD legend excerpt staged under `{{input_root}}/`.
2. Open `prompts/rs/03-legend-normalization.prompt.md`.
3. Apply `skills/rs/SK-LEGEND-NORMALIZE.md` to each visible label, preserving the documented annotation semantics (Class 5, PCI/PAN, S#, T#, R#, SA#, CA#, IA#, etc.). Treat S# as a review signal, never as proof of an approved security stack.
4. Write `{{output_root}}/03-legend-normalization.md`. Record every label as `normalized`, `unknown`, or `note-supported` with the source visible label retained.
5. Hand control back to PRA-03 (resume `prompts/rs/04-design-fact-extract.prompt.md`).

## 8. Human Gates

- SAS reviews high-risk labels (Class 5, PCI/PAN, transit, at-rest, identity tokens) before component/flow extraction proceeds.
- SAS confirms no S# label has been reinterpreted as a security-stack approval claim.
- SAS accepts `{{output_root}}/03-legend-normalization.md` before PRA-03 resumes.

## 9. Stop Conditions

- A token semantic is reinterpreted (for example, S# treated as approved security stack rather than as a review signal).
- A label is invented to satisfy a normalization slot.
- An unlabeled flow data class is silently defaulted instead of recorded as `unknown`.
- A PCI/PAN, Class 5, or security-token label is missed or quietly dropped.
- Output written outside `{{output_root}}`.
- Any forbidden runtime/cloud/ADK/MCP/Jira/Confluence claim is recorded.

## 10. Unknown Handling

- Treat unrecognised labels as `unknown` with the visible token preserved verbatim.
- Treat ambiguous annotations as `note-supported` with a short reason. Do not promote to `normalized` without supporting evidence.
- Treat absent legend excerpts as a stop condition; do not normalise from inferred meaning.

## 11. Evidence and Run-Log Guidance

- After SAS acceptance, PRA-01 appends an RS-03 entry to `{{output_root}}/00-run-log.md` referencing this PRA, `prompts/rs/03-legend-normalization.prompt.md`, `skills/rs/SK-LEGEND-NORMALIZE.md`, `{{output_root}}/03-legend-normalization.md`, and the SAS reviewer decision.
- No evidence is written outside `{{output_root}}`.

## 12. Direct Adapter Test

PRA-04 has no dedicated adapter. Operators test legend normalization through `.agents/aisraf-dfd-extractor.agent.md`. Sample test prompt: "Open `{{output_root}}/02-visible-dfd-objects.md`. Run `prompts/rs/03-legend-normalization.prompt.md` with `skills/rs/SK-LEGEND-NORMALIZE.md` to write `{{output_root}}/03-legend-normalization.md`. Preserve every visible label; mark unknowns as `unknown`; do not treat S# as an approved security stack; do not write outside `{{output_root}}`." A PASS test produces the legend-normalization file with corrected semantics intact and no invented labels.

## 13. Not in Scope

- Not a deployed runtime agent.
- Not a Google ADK agent.
- Not a Vertex, GCP, or external cloud agent.
- Not an MCP execution surface.
- Not a Jira post-back, Confluence publication, or Rovo execution surface.
- Not allowed to extract components, flows, boundaries, or stack signals (PRA-03 and PRA-05 own those).
- Not allowed to write outside `{{output_root}}`.
- Not allowed to modify `prompts/`, `skills/`, `config/`, `tools/`, `validation/`, `prototype-agents/`, `.agents/`, or any file under `{{expected_root}}`.
- Not allowed to claim accuracy scoring outside `skills/rs/SK-ACCURACY-SCORE.md`.
- Not allowed to claim release packaging or diagram generation.
- Not allowed to introduce a separate `.agents/aisraf-legend-normalizer.agent.md` (founder decision Q1; legend normalization is wrapped by the AISRAF DFD Extractor adapter).
