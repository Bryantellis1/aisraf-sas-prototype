# PRA-02-INPUT-READER

## 1. Identity

- pra_id: `PRA-02-INPUT-READER`
- pra_name: Input Reader
- status: active
- type: prototype review-agent specification
- package_scope: `aisraf-sas-prototype-v0.1.2`
- owning_build_package: `06`
- mapped_adapter: `.agents/aisraf-input-reader.agent.md`

## 2. Purpose

Inventory the existing SAS review materials staged under `{{input_root}}` for the current run, without inventing inputs and without claiming an automatic chat-attachment movement workflow. PRA-02 is the first hands-on PRA in the chain after PRA-01 confirms the run profile. It is a specification, not a deployed runtime agent.

## 3. Owned Prompts

- `prompts/rs/01-input-package-read.prompt.md` (RS-01).

## 4. Owned Skills

- `skills/rs/SK-INPUT-PACKAGE-READ.md`.

## 5. Inputs

Required run-profile variables: `{{run_id}}`, `{{input_root}}`, `{{output_root}}`, `{{mode}}`, `{{postback_execution_status}}`, `{{output_destination_mode}}`.

Required reads:

- `runs/{{run_id}}/run-profile.yaml`.
- All review materials staged under `{{input_root}}/` for this run (DFD crop, legend excerpt, cloud triage notes, review transcript, intake ticket, supporting documents).

Optional reads:

- `{{expected_root}}/expected-input-inventory.json`, only when `mode = scored` and `expected_baseline_required = true`. Build Package 10 will provide this file; until then it is treated as unknown and not required.

## 6. Outputs

- `{{output_root}}/01-input-inventory.md`.

## 7. Procedure

1. Confirm `{{input_root}}` resolves and is readable.
2. Open `prompts/rs/01-input-package-read.prompt.md`.
3. Apply `skills/rs/SK-INPUT-PACKAGE-READ.md` to inventory each material under `{{input_root}}` as `received`, `missing`, or `empty`. Do not invent material that is not present.
4. Write `{{output_root}}/01-input-inventory.md` describing the inventory.
5. After SAS acceptance, hand off to PRA-03 (DFD extraction) via the AISRAF DFD Extractor adapter, and request that PRA-01 append the RS-01 entry to `{{output_root}}/00-run-log.md`.

## 8. Human Gates

- SAS confirms the inventory uses only existing review materials and introduces no new requester submission form or process.
- SAS accepts the inventory before PRA-03 begins.

## 9. Stop Conditions

- `{{input_root}}` cannot be resolved or read.
- An input is invented, fabricated, or claimed without a file present under `{{input_root}}`.
- The inventory claims an automatic chat-attachment movement workflow.
- The inventory introduces a new requester submission form.
- Output written outside `{{output_root}}`.
- Any forbidden runtime/cloud/ADK/MCP/Jira/Confluence claim is recorded.

## 10. Unknown Handling

- Treat absent inputs as `missing` with a short note. Do not promote them to `received` to satisfy the inventory.
- Treat unknown formats or unreadable files as `empty` with the unreadable reason recorded.
- Treat baselines under `{{expected_root}}` as unknown until Build Package 10 provides them.

## 11. Evidence and Run-Log Guidance

- After SAS acceptance, PRA-01 appends an RS-01 entry to `{{output_root}}/00-run-log.md` referencing this PRA, `prompts/rs/01-input-package-read.prompt.md`, `skills/rs/SK-INPUT-PACKAGE-READ.md`, `{{output_root}}/01-input-inventory.md`, and the SAS reviewer decision.
- No evidence is written outside `{{output_root}}`.

## 12. Direct Adapter Test

Operator opens `.agents/aisraf-input-reader.agent.md` from the local Copilot Chat agent dropdown and asks: "Inventory the materials staged under `{{input_root}}` for `{{run_id}} = RUN-EXAMPLE`. Use `prompts/rs/01-input-package-read.prompt.md` and `skills/rs/SK-INPUT-PACKAGE-READ.md`. Write `{{output_root}}/01-input-inventory.md` only. Do not invent inputs; do not claim chat-attachment movement; do not write outside `{{output_root}}`." A PASS test produces the inventory file with `received`, `missing`, and `empty` rows correctly distinguished.

## 13. Not in Scope

- Not a deployed runtime agent.
- Not a Google ADK agent.
- Not a Vertex, GCP, or external cloud agent.
- Not an MCP execution surface.
- Not a Jira post-back, Confluence publication, or Rovo execution surface.
- Not a requester submission system.
- Not allowed to write outside `{{output_root}}`.
- Not allowed to modify `prompts/`, `skills/`, `config/`, `tools/`, `validation/`, `prototype-agents/`, `.agents/`, or any file under `{{expected_root}}`.
- Not allowed to claim accuracy scoring outside `skills/rs/SK-ACCURACY-SCORE.md`.
- Not allowed to claim release packaging or diagram generation.
