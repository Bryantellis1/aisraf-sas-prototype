# Docs Readiness Pre-Render Checklist

Authored by: BUILD-AG-12-VALIDATION-R1.

Scope: Build Package 14 entry gate. Confirms a runbook / practitioner-guide can be authored against frozen registries and `sample-001-dfd-crop`. This checklist is **pre-render only**: Build Package 12 forbids creating any runbook, practitioner guide, or `docs/` content beyond the BP01 README placeholder.

> **Precondition note (BP12-SAMPLE-DFD-BLOCKER).** Runbook content authored against the current sample-001 DFD will inherit `BP12-SAMPLE-DFD-BLOCKER`'s defects unless a corrective patch lands first. BP14 may proceed to author general-purpose runbook content (operator setup, run-profile editing, chain-execution mechanics) without depending on a clean canonical sample, BUT any BP14 runbook section that uses sample-001 as the canonical example will inherit the defect. Founder may either (a) defer BP14 sample-tied sections until correction lands, or (b) accept the defect propagation knowingly. Build Package 12 records the trade-off; it does not decide.

## Identity

- Gate category: Forward gate.
- Run order position: 7 (Forward gates).
- BP14 entry condition: this checklist evaluates to PASS for the registry / framework gates; BP14 sample-tied sections are gated separately by `BP12-SAMPLE-DFD-BLOCKER` resolution.

## Scope

- Frozen registries usable as runbook inputs:
  - `prompts/prompt-registry.yaml` (23 prompts).
  - `skills/skill-registry.yaml` (26 skills).
  - `prototype-agents/prototype-agent-registry.yaml` (8 PRAs + crosswalk).
  - `.agents/aisraf-*.agent.md` (7 adapters).
  - `catalogs/catalog-registry.yaml` (24 catalogs).
  - `blueprints/blueprint-registry.yaml` (9 blueprints).
  - `templates/template-registry.yaml` (31 templates).
  - `samples/sample-registry.yaml` (1 active + 7 planned/deferred).
  - `runs/RUN-001/run-profile.yaml`, `runs/RUN-001/00-run-log.md`.
  - `config/run-profile.schema.yaml`, `config/run-profile.template.yaml`, `config/run-profile.field-catalog.md`, `config/run-profile.validation-rules.md`, `config/path-resolution-rules.md`, `config/integration-fields.md`, `config/sensitive-data-rules.md`.

## Gates — General Runbook Readiness (Not Blocked)

| # | Gate | Falsifiable Check | Verdict |
|---|---|---|---|
| 1 | Operator setup inputs available | `START-HERE.md`, `README.md`, `FOLDER-CONTRACTS.md`, `BUILD-ORDER.md`, and `PROTOTYPE-CHARTER.md` are present and current. | PASS |
| 2 | Run-profile contract documented | `config/run-profile.schema.yaml`, `config/run-profile.template.yaml`, `config/run-profile.field-catalog.md`, `config/run-profile.validation-rules.md`, `config/path-resolution-rules.md`, `config/integration-fields.md`, `config/sensitive-data-rules.md` resolve and form a coherent run-profile contract. | PASS |
| 3 | Tools documented | `tools/README.md`, `tools/New-AisrafRun.ps1`, `tools/Test-AisrafRunProfile.ps1`, `tools/Test-AisrafPackage.ps1` resolve. | PASS |
| 4 | Prompt set documented | `prompts/README.md`, `prompts/rs/README.md`, `prompts/dfd/README.md`, and the 23 prompt cards resolve. | PASS |
| 5 | Skill set documented | `skills/README.md`, `skills/rs/README.md`, `skills/dfd/README.md`, and the 26 skill contracts resolve. | PASS |
| 6 | PRA set documented | `prototype-agents/README.md`, `prototype-agents/prototype-agent-template.md`, the 8 PRA specs, and the 7 adapters resolve. | PASS |
| 7 | Catalog set documented | `catalogs/README.md`, the 7 family READMEs, the 24 catalog YAMLs, and `catalogs/catalog-registry.yaml` resolve. | PASS |
| 8 | Blueprint set documented | `blueprints/README.md`, the 2 category READMEs, the 9 blueprint YAMLs, `blueprints/blueprint-template.yaml`, and `blueprints/blueprint-registry.yaml` resolve. | PASS |
| 9 | Template set documented | `templates/README.md`, the 4 family READMEs, the 31 templates, and `templates/template-registry.yaml` resolve. | PASS |
| 10 | Run fixture documented | `runs/README.md`, `runs/RUN-001/README.md`, `runs/RUN-001/run-profile.yaml`, `runs/RUN-001/00-run-log.md`, and the 4 BP11 validation checklists resolve. | PASS |

## Gates — Sample-Tied Runbook Sections (Inherited Blocker)

| # | Gate | Falsifiable Check | Verdict |
|---|---|---|---|
| 11 | Canonical sample DFD readiness | `validation/sample-input-readiness-checklist.md` reads PASS for the canonical sample. | **NOT MET — `BP12-SAMPLE-DFD-BLOCKER`** |
| 12 | Canonical sample expected baselines clean | `validation/expected-output-lint-checklist.md` reads PASS for the canonical sample. | **PARTIAL_WITH_ISSUES — `BP12-SAMPLE-DFD-BLOCKER`** |
| 13 | BP14 sample-tied content disposition | Founder explicitly decides whether BP14 sample-tied runbook sections defer until `BP12-SAMPLE-DFD-BLOCKER` resolution OR proceed with a "defect-propagated" disclosure. | **PENDING — founder decision** |

## Gates — No BP12 Authoring of Runbook Content

| # | Gate | Falsifiable Check | Verdict |
|---|---|---|---|
| 14 | `docs/` README-only | `docs/` contains only `docs/README.md` (Build Package 01 placeholder). | PASS |
| 15 | No BP14 artefact under `docs/` | No runbook, practitioner guide, mapping document, or operator-walkthrough is authored under `docs/` by Build Package 12. | PASS |
| 16 | No runbook prose inside BP12 validation files | No BP12 validation file contains operator-walkthrough prose, scripted remediation language, or "do this then do that" runbook narrative. Each BP12 validation file is a falsifiable gate, not a runbook. | PASS |

## Acceptance Verdict

- **PASS** is reachable for gates 1–10 (general runbook readiness) and gates 14–16 (no-authoring discipline). Gates 11–13 are **PENDING / PARTIAL** and require founder decision.
- **PARTIAL_WITH_ISSUES** (current verdict) — gates 1–10 PASS, gates 14–16 PASS, gates 11–12 inherit `BP12-SAMPLE-DFD-BLOCKER`, gate 13 is a founder-decision gate. BP14 may proceed with general-purpose runbook content; sample-tied sections require founder decision.
- **FAIL** when Build Package 12 itself authors any runbook, practitioner guide, or `docs/` content beyond the README placeholder.

## Stop Conditions

- Any runbook, practitioner guide, or `docs/` content is authored by Build Package 12.
- The `BP12-SAMPLE-DFD-BLOCKER` citation in gates 11–12 is dropped.
- A BP12 validation file drifts toward runbook authoring (operator-walkthrough prose, scripted remediation language).

## Forbidden Outputs in Build Package 12

- `docs/*` content beyond the existing `docs/README.md`.
- Any `runbook-*.md`, `practitioner-guide-*.md`, `mapping-*.md`, or operator-walkthrough file.
- Any "operator must do X then Y" narrative inside a BP12 validation file.

## Tool References

- `tools/Test-AisrafPackage.ps1` Check `08-folder-readme-only-rule` enforces `docs/` as README-only.
- This checklist is the human-review pre-render gate.

## Out-of-Scope

- Authoring runbooks.
- Authoring practitioner guides.
- Authoring `docs/mappings/*` (per BP06 founder decision Q3, the old v0.01 mapping documents are collapsed into `prototype-agents/prototype-agent-registry.yaml#prompt_skill_agent_crosswalk` and `validation/prompt-skill-agent-mapping-checklist.md`; no new mapping docs are introduced by BP12 or BP14).
