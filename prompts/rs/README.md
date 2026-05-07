# prompts/rs/

Root Area: Root Area 06 — `prompts/`.

Owning Build Package: Build Package 04 — Prompts and prompt registry.

Prompt family: `rs` — Review Sequence.

## Purpose

Reusable, parameterized prompt cards that guide a local Copilot operator through the AISRAF SAS review sequence (RS). Every card reads from a resolved run profile, writes only under `{{output_root}}`, marks unsupported facts as `unknown`, and stops cleanly when prerequisites are missing.

## Scope

The RS family covers fourteen prompt cards:

| File | Prompt ID | Status | Output(s) |
|---|---|---|---|
| [00-run-full-chain.prompt.md](00-run-full-chain.prompt.md) | PR-RS-00 | planned | none — wrapper card |
| [01-input-package-read.prompt.md](01-input-package-read.prompt.md) | PR-RS-01 | active | `{{output_root}}/01-input-inventory.md` |
| [02-dfd-visual-read.prompt.md](02-dfd-visual-read.prompt.md) | PR-RS-02 | active | `{{output_root}}/02-visible-dfd-objects.md` |
| [03-legend-normalization.prompt.md](03-legend-normalization.prompt.md) | PR-RS-03 | active | `{{output_root}}/03-legend-normalization.md` |
| [04-design-fact-extract.prompt.md](04-design-fact-extract.prompt.md) | PR-RS-04 | active | `{{output_root}}/04-components.md`, `{{output_root}}/05-flows.md` |
| [05-boundary-stack-detect.prompt.md](05-boundary-stack-detect.prompt.md) | PR-RS-05 | active | `{{output_root}}/06-boundaries.md`, `{{output_root}}/07-security-stack-assessment.md` |
| [06-review-table-build.prompt.md](06-review-table-build.prompt.md) | PR-RS-06 | active | `{{output_root}}/08-internal-review-table.md` |
| [07-missing-fact-question-generate.prompt.md](07-missing-fact-question-generate.prompt.md) | PR-RS-07 | active | `{{output_root}}/09-missing-facts.md`, `{{output_root}}/12-targeted-questions.md` |
| [08-ai-action-level-classify.prompt.md](08-ai-action-level-classify.prompt.md) | PR-RS-08 | active | `{{output_root}}/10-ai-action-level.md` |
| [09-blueprint-match.prompt.md](09-blueprint-match.prompt.md) | PR-RS-09 | active | `{{output_root}}/11-blueprint-match.md` |
| [10-finding-recommendation-write.prompt.md](10-finding-recommendation-write.prompt.md) | PR-RS-10 | active | `{{output_root}}/13-findings.md`, `{{output_root}}/14-recommendations.md` |
| [11-handoff-pack-build.prompt.md](11-handoff-pack-build.prompt.md) | PR-RS-11 | active | `{{output_root}}/15-handoff-pack.md` |
| [12-validation-note-write.prompt.md](12-validation-note-write.prompt.md) | PR-RS-12 | active | `{{output_root}}/16-validation-notes.md` |
| [13-accuracy-score.prompt.md](13-accuracy-score.prompt.md) | PR-RS-13 | active (conditional) | `{{output_root}}/17-accuracy-score.md` |

## Prompt Count vs. RS Output Count

The RS family has fourteen prompt cards but seventeen RS outputs (`01-input-inventory.md` through `17-accuracy-score.md`). The mismatch is intentional: a single prompt may produce multiple RS outputs.

| RS output | Producing prompt |
|---|---|
| `01-input-inventory.md` | PR-RS-01 |
| `02-visible-dfd-objects.md` | PR-RS-02 |
| `03-legend-normalization.md` | PR-RS-03 |
| `04-components.md` | PR-RS-04 |
| `05-flows.md` | PR-RS-04 |
| `06-boundaries.md` | PR-RS-05 |
| `07-security-stack-assessment.md` | PR-RS-05 |
| `08-internal-review-table.md` | PR-RS-06 |
| `09-missing-facts.md` | PR-RS-07 |
| `10-ai-action-level.md` | PR-RS-08 |
| `11-blueprint-match.md` | PR-RS-09 |
| `12-targeted-questions.md` | PR-RS-07 |
| `13-findings.md` | PR-RS-10 |
| `14-recommendations.md` | PR-RS-10 |
| `15-handoff-pack.md` | PR-RS-11 |
| `16-validation-notes.md` | PR-RS-12 |
| `17-accuracy-score.md` | PR-RS-13 |

## What Belongs Here

- Markdown prompt cards `*.prompt.md` matching the two-digit RS naming pattern.
- This README.

## What Does Not Belong Here

- Skill contracts (deferred to Build Package 05).
- PRA specifications (deferred to Build Package 06).
- `.agent.md` adapters (deferred to Build Package 06).
- Catalogs, blueprints, templates, samples, run outputs, diagrams, docs, release artifacts.
- Generated outputs (those land under `runs/<run_id>/` only when Build Package 11 authorizes them).
- Wrappers under `.github/prompts/` (founder-gated; not in Package 04).
- Old v0.01 prompt copies, stale baselines, or scoring proof.

## How To Run One Prompt Manually

1. Run [tools/New-AisrafRun.ps1](../../tools/New-AisrafRun.ps1) to create a new `runs/<RunId>/` folder with a fresh `run-profile.yaml`.
2. Stage the required inputs under `runs/<RunId>/inputs/` (or copy the sample inputs via `-CopySampleInputs`).
3. Confirm `sensitive_data_confirmed_redacted: true` in the run profile, then run [tools/Test-AisrafRunProfile.ps1](../../tools/Test-AisrafRunProfile.ps1) with `-ExecutionReady`.
4. Open the chosen prompt card in VS Code Copilot Chat.
5. Do not edit the prompt body. Substitute or confirm only the run-profile variables Copilot resolves from `runs/<RunId>/run-profile.yaml`.
6. Inspect the produced artifact under `{{output_root}}`. Append a `00-run-log.md` entry only after a human reviewer accepts it.

## What This Family Does Not Claim

No prompt card claims skill execution, PRA execution, `.agent.md` adapter execution, Jira post-back, Confluence publication, Rovo execution, MCP execution, runtime/cloud/database execution, diagram generation, release export, or accuracy scoring (the only conditional scoring is performed by [13-accuracy-score.prompt.md](13-accuracy-score.prompt.md), and only when `scoring_enabled: true`, `expected_baseline_required: true`, and `{{expected_root}}` is non-empty and populated).
