# Package Lint Master Checklist

Authored by: BUILD-AG-12-VALIDATION-R1.

Scope: cross-package lint matrix that rolls up file-reference integrity, vocabulary discipline, run-profile placeholder discipline, no-execution claim discipline, and no-drift roll-up across Build Packages 01–12.

This checklist does not modify any sealed surface. It records read-only verdicts that the framework as a whole carries no drift across the BP01–BP11 surfaces and that the BP12 framework standup itself does not introduce drift.

## Identity

- Gate category: Cross-cutting hygiene.
- Run order position: 6 (Cross-cutting hygiene).
- Owning agent: BUILD-AG-12-VALIDATION-R1.

## Scope

- File-reference integrity: every `validation/`, `samples/`, `runs/`, `prompts/`, `skills/`, `prototype-agents/`, `.agents/`, `catalogs/`, `blueprints/`, `templates/`, and `config/` file referenced by an active BP01–BP11 contract resolves on disk.
- Vocabulary discipline: "Build Package" and "Root Area" are used consistently; lowercase folder names match `FOLDER-CONTRACTS.md`.
- Run-profile placeholder discipline: only the seven approved variables (`{{run_id}}`, `{{input_root}}`, `{{expected_root}}`, `{{output_root}}`, `{{mode}}`, `{{postback_execution_status}}`, `{{output_destination_mode}}`) appear as placeholders; non-schema placeholders (`{{catalog_root}}`, `{{prompt_root}}`, `{{skill_root}}`, `{{template_root}}`, `{{diagram_root}}`, `{{validation_root}}`) are forbidden.
- No-execution claim discipline: no prompt, skill, PRA, adapter, catalog, blueprint, template, sample, run artefact, or validation file claims runtime / cloud / ADK / Vertex / GCP / MCP / Jira post-back / Confluence publication / Rovo / database / Terraform / `executed_by_operator` execution outside the gating conditions defined in `validation/no-drift-rules.md`.
- No-drift roll-up: every BP01–BP11 no-drift rule remains satisfied by the on-disk state.

## Inputs

- The full BP01–BP11 surface (sealed): `prompts/`, `skills/`, `prototype-agents/`, `.agents/`, `catalogs/`, `blueprints/`, `templates/`, `samples/`, `runs/RUN-001/` (excluding the `dfd/.gitkeep` Build Package 12 reservation marker), `config/`, `tools/`, `authoring-agents/`, root governance files, `.github/copilot-instructions.md`.
- The BP12 surface (in scope for self-lint): the 10 new validation files, `validation/README.md`, `validation/no-drift-rules.md`, `runs/RUN-001/dfd/.gitkeep`, surgical `tools/Test-AisrafPackage.ps1` patches, surgical updates to `PACKAGE-MANIFEST.yaml`, `FOLDER-CONTRACTS.md`, `README.md`, `START-HERE.md`, `.github/copilot-instructions.md`.

## Gates

### File-reference integrity

| # | Gate | Falsifiable Check | Verdict |
|---|---|---|---|
| 1 | Validation file references resolve | Every `validation/*.md` file referenced by `validation/README.md` and `PACKAGE-MANIFEST.yaml` resolves on disk. | PASS |
| 2 | Sample file references resolve | The 6 input files and 26 expected baselines under `samples/sample-001-dfd-crop/` resolve on disk. | PASS |
| 3 | Run file references resolve | `runs/RUN-001/README.md`, `runs/RUN-001/run-profile.yaml`, `runs/RUN-001/00-run-log.md`, the 6 byte-copied inputs, and `runs/RUN-001/dfd/` resolve on disk; the 26 reserved chain outputs are absent (intentional). | PASS |
| 4 | Tool references resolve | `tools/Test-AisrafPackage.ps1`, `tools/Test-AisrafRunProfile.ps1`, `tools/New-AisrafRun.ps1`, `tools/README.md` resolve on disk. | PASS |
| 5 | Registry references resolve | `prompts/prompt-registry.yaml`, `skills/skill-registry.yaml`, `prototype-agents/prototype-agent-registry.yaml`, `catalogs/catalog-registry.yaml`, `blueprints/blueprint-registry.yaml`, `templates/template-registry.yaml`, `samples/sample-registry.yaml` resolve on disk. | PASS |

### Vocabulary discipline

| # | Gate | Falsifiable Check | Verdict |
|---|---|---|---|
| 6 | "Build Package" used for 01–16 sequence | No BP12 file uses "Phase", "Sprint", or "Iteration" in place of "Build Package" for the 01–16 sequence. | PASS |
| 7 | "Root Area" used for package-tree | No BP12 file uses "Section", "Module", or "Folder" in place of "Root Area" for the visible top-level area numbering. | PASS |
| 8 | Lowercase folder names | All folder references in BP12 files use the exact lowercase filesystem folder names listed in `FOLDER-CONTRACTS.md`. | PASS |

### Run-profile placeholder discipline

| # | Gate | Falsifiable Check | Verdict |
|---|---|---|---|
| 9 | Approved placeholders only | No BP12 file introduces `{{catalog_root}}`, `{{prompt_root}}`, `{{skill_root}}`, `{{template_root}}`, `{{diagram_root}}`, or `{{validation_root}}`. | PASS |
| 10 | Other run-profile fields descriptive only | When a BP12 file references a run-profile field outside the seven approved placeholders (e.g., `sample_id`, `source_ticket_url`), it does so descriptively as `[copy from runs/{{run_id}}/run-profile.yaml#field_name]` rather than as a `{{field_name}}` placeholder. | PASS |
| 11 | Hardcoded paths discipline | No BP12 file hardcodes a `runs/RUN-001/` path where a run-profile placeholder would be appropriate, except when the file is intentionally specific to RUN-001 (e.g., `local-run-readiness-checklist.md`, `package-12-validation-checklist.md`). | PASS |

### No-execution claim discipline

| # | Gate | Falsifiable Check | Verdict |
|---|---|---|---|
| 12 | No runtime / cloud / ADK claims | No BP12 file claims runtime, cloud, ADK, Vertex/GCP, database, or Terraform execution. | PASS |
| 13 | No MCP execution claims | No BP12 file claims MCP execution outside the gated condition `mcp_execution_status: executed_by_operator`. | PASS |
| 14 | No Jira post-back claims | No BP12 file claims Jira post-back outside the gated condition `postback_execution_status: executed_by_operator` plus a matching post-back-row in `runs/<run_id>/00-run-log.md`. | PASS |
| 15 | No Confluence publication claims | No BP12 file claims Confluence publication outside the same gated condition as Jira. | PASS |
| 16 | No Rovo execution claims | No BP12 file claims Rovo / Atlassian Rovo MCP execution outside the gated condition. | PASS |
| 17 | No diagram generation claims | No BP12 file claims to have generated, rendered, or produced a diagram (Build Package 13 owns diagram generation). | PASS |
| 18 | No release packaging claims | No BP12 file claims to have packaged a release artefact (Build Package 15 owns release packaging). | PASS |

### No-drift roll-up

| # | Gate | Falsifiable Check | Verdict |
|---|---|---|---|
| 19 | BP01–BP11 surfaces unchanged | No file under the sealed BP01–BP11 surfaces (per §`Inputs`) is modified by Build Package 12. | PASS |
| 20 | BP12 amendments present | `validation/no-drift-rules.md` carries a numbered "Build Package 12 — Validation rules" section listing the BP12 amendments. | PASS |
| 21 | Carried-forward blocker named | `BP12-SAMPLE-DFD-BLOCKER` is recorded in the seven required cross-reference points (§4 of `validation/package-12-validation-checklist.md`). | PASS |
| 22 | No other carried-forward blocker | No second hard blocker is introduced by Build Package 12 beyond `BP12-SAMPLE-DFD-BLOCKER`. | PASS |

## Acceptance Verdict

- **PASS** when every gate reads PASS.
- **PARTIAL_WITH_ISSUES** when a vocabulary or placeholder gate FAILs but the failure is bounded and named; remediation is required before BP15 release packaging.
- **FAIL** when a no-drift, no-execution-claim, or file-reference-integrity gate FAILs.

## Stop Conditions

- Any sealed BP01–BP11 file is modified by Build Package 12.
- Any BP12 file introduces a non-schema run-profile placeholder.
- Any BP12 file claims runtime, cloud, ADK, MCP, Jira post-back, Confluence publication, Rovo, database, Terraform, diagram generation, or release packaging.
- The carried-forward blocker citation chain is broken.

## Tool References

- `tools/Test-AisrafPackage.ps1` — surface-level lint (file allow-lists per package).
- `tools/Test-AisrafRunProfile.ps1` — run-profile schema lint.
- This checklist is the human-review roll-up gate; no automated lint script is introduced by Build Package 12.
