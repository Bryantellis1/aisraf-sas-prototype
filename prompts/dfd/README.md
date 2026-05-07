# prompts/dfd/

Root Area: Root Area 06 — `prompts/`.

Owning Build Package: Build Package 04 — Prompts and prompt registry.

Prompt family: `dfd` — Data Flow Diagram extraction subskills.

## Purpose

Reusable, parameterized prompt cards that guide a local Copilot operator through the DFD extraction sequence one step at a time. Each card reads from a resolved run profile, writes exactly one DFD artifact under `{{output_root}}/dfd/`, marks unsupported facts as `unknown`, and stops cleanly when prerequisites are missing.

## Scope

The DFD family covers nine prompt cards numbered 02 through 10. The numbering preserves the v0.01 sequence; there is intentionally no DFD-01 prompt (the first DFD step is `02-dfd-intake-quality-check`).

| File | Prompt ID | DFD step | Status | Output |
|---|---|---|---|---|
| [02-dfd-intake-quality-check.prompt.md](02-dfd-intake-quality-check.prompt.md) | PR-DFD-02 | DFD-01 | active | `{{output_root}}/dfd/01-intake-quality-check.md` |
| [03-boundary-extract.prompt.md](03-boundary-extract.prompt.md) | PR-DFD-03 | DFD-02 | active | `{{output_root}}/dfd/02-boundary-catalog.md` |
| [04-component-extract.prompt.md](04-component-extract.prompt.md) | PR-DFD-04 | DFD-03 | active | `{{output_root}}/dfd/03-component-catalog.md` |
| [05-flow-extract.prompt.md](05-flow-extract.prompt.md) | PR-DFD-05 | DFD-04 | active | `{{output_root}}/dfd/04-flow-inventory.md` |
| [06-annotation-resolve.prompt.md](06-annotation-resolve.prompt.md) | PR-DFD-06 | DFD-05 | active | `{{output_root}}/dfd/05-annotation-resolution.md` |
| [07-boundary-crossing-detect.prompt.md](07-boundary-crossing-detect.prompt.md) | PR-DFD-07 | DFD-06 | active | `{{output_root}}/dfd/06-boundary-crossings.md` |
| [08-control-signal-detect.prompt.md](08-control-signal-detect.prompt.md) | PR-DFD-08 | DFD-07 | active | `{{output_root}}/dfd/07-control-signals.md` |
| [09-confidence-score.prompt.md](09-confidence-score.prompt.md) | PR-DFD-09 | DFD-08 | active | `{{output_root}}/dfd/08-confidence-score.md` |
| [10-dfd-extraction-summarize.prompt.md](10-dfd-extraction-summarize.prompt.md) | PR-DFD-10 | DFD-09 | active | `{{output_root}}/dfd/09-extraction-summary.md` |

## What Belongs Here

- Markdown prompt cards `*.prompt.md` matching the two-digit DFD naming pattern.
- This README.

## What Does Not Belong Here

- Skill contracts (deferred to Build Package 05).
- PRA specifications (deferred to Build Package 06).
- `.agent.md` adapters (deferred to Build Package 06).
- DFD catalogs (deferred to Build Package 07).
- DFD templates (deferred to Build Package 09).
- Sample inputs or expected baselines (deferred to Build Package 10).
- Run outputs (deferred to Build Package 11).
- Diagrams, docs/runbooks, release artifacts, runtime code, cloud assets.
- Old v0.01 prompt copies, stale catalogs, or scoring proof.

## Confidence Score vs. Accuracy Score

[09-confidence-score.prompt.md](09-confidence-score.prompt.md) records a per-row extraction confidence based on the operator's ability to read the visible source. It is **not** an accuracy score against a baseline. Accuracy scoring against expected baselines is owned by [prompts/rs/13-accuracy-score.prompt.md](../rs/13-accuracy-score.prompt.md) and runs only when `scoring_enabled: true`, `expected_baseline_required: true`, and `{{expected_root}}` is non-empty and populated.

## How To Run One DFD Prompt Manually

1. Run [tools/New-AisrafRun.ps1](../../tools/New-AisrafRun.ps1) to create a fresh `runs/<RunId>/` with `dfd/` already created (empty).
2. Stage DFD inputs under `runs/<RunId>/inputs/` (or copy from samples once Build Package 10 provides them).
3. Confirm `sensitive_data_confirmed_redacted: true` and run [tools/Test-AisrafRunProfile.ps1](../../tools/Test-AisrafRunProfile.ps1) with `-ExecutionReady`.
4. Open the chosen DFD prompt card in VS Code Copilot Chat in dependency order: 02 → 03 → 04 → 05 → 06 → 07 → 08 → 09 → 10.
5. Do not edit the prompt body. Substitute or confirm only the run-profile variables Copilot resolves from `runs/<RunId>/run-profile.yaml`.
6. Inspect the produced artifact under `{{output_root}}/dfd/`. Append a `00-run-log.md` entry only after a human reviewer accepts it.

## What This Family Does Not Claim

No prompt card claims skill execution, PRA execution, `.agent.md` adapter execution, Jira post-back, Confluence publication, Rovo execution, MCP execution, runtime/cloud/database execution, diagram generation, release export, or accuracy scoring against a baseline.
