# prompts/

Root Area: Root Area 06.

Owning Build Package: Build Package 04 — Prompts and prompt registry.

## Purpose

Canonical prompt-card folder for AISRAF SAS Prototype v0.1.2. Prompt cards are reusable, parameterized Markdown instructions that an operator opens in VS Code Copilot Chat. Each card reads from a resolved run profile, writes only under `{{output_root}}`, marks unsupported facts as `unknown`, and stops cleanly when prerequisites are missing. The card is documentation, not a runtime tool.

## Layout

| Path | What lives here |
|---|---|
| [prompt-registry.yaml](prompt-registry.yaml) | Single registry that lists all 23 prompt cards with their IDs, families, run-profile variables, output paths, future skill IDs (planned for Build Package 05), and future PRA owners (planned for Build Package 06). |
| [rs/](rs/) | RS family — 14 Review Sequence prompt cards, including the planned full-chain wrapper. See [rs/README.md](rs/README.md). |
| [dfd/](dfd/) | DFD family — 9 DFD subskill prompt cards numbered 02 through 10. See [dfd/README.md](dfd/README.md). |

## What Belongs Here

- `prompts/prompt-registry.yaml` — the single registry.
- `prompts/rs/*.prompt.md` — 14 RS family prompt cards.
- `prompts/dfd/*.prompt.md` — 9 DFD family prompt cards.
- This README and the two family READMEs.

## What Does Not Belong Here

- Skill contracts (deferred to Build Package 05).
- PRA specifications (deferred to Build Package 06).
- `.agent.md` adapters (deferred to Build Package 06).
- Catalogs, blueprints, templates, samples, run outputs, diagrams, docs/runbooks, release artifacts.
- `.github/prompts/*.prompt.md` wrappers (founder-gated; not in Package 04).
- Old v0.01 prompt copies, stale baselines, or scoring proof.
- Generated outputs (those land under `runs/<run_id>/` only when Build Package 11 authorizes them).
- Schemas outside `config/`, runtime code, cloud assets, or external-connector proof.

## Parameter Contract

Every prompt card resolves the seven required v0.1.2 run-profile variables from `runs/{{run_id}}/run-profile.yaml`:

- `{{run_id}}`
- `{{input_root}}`
- `{{expected_root}}`
- `{{output_root}}`
- `{{mode}}`
- `{{postback_execution_status}}`
- `{{output_destination_mode}}`

No prompt may hardcode any value. The schema authority is [config/run-profile.schema.yaml](../config/run-profile.schema.yaml). Path resolution rules are in [config/path-resolution-rules.md](../config/path-resolution-rules.md). Sensitive-data prohibitions are in [config/sensitive-data-rules.md](../config/sensitive-data-rules.md).

## Required Prompt Sections

Every prompt card contains all 11 sections in order:

1. Identity
2. Purpose
3. Run Profile Inputs
4. Required Read Paths
5. Required Output
6. Instructions
7. Stop Conditions
8. Unknown Handling
9. Evidence / Run-Log Guidance
10. Direct Prompt Test
11. Not In Scope

## What Prompt Cards Do Not Claim

No prompt card claims:

- skill execution (skill contracts are deferred to Build Package 05);
- PRA execution (PRA specifications are deferred to Build Package 06);
- `.agent.md` adapter execution (adapters are deferred to Build Package 06);
- Jira post-back, Confluence publication, Rovo execution, or MCP execution;
- runtime, cloud, database, Terraform, or ADK execution;
- accuracy scoring (the only conditional scoring is performed by [rs/13-accuracy-score.prompt.md](rs/13-accuracy-score.prompt.md), and only when `scoring_enabled: true`, `expected_baseline_required: true`, and `{{expected_root}}` is non-empty and populated);
- diagram generation;
- release or ZIP export.

## RS Output 12 (`12-targeted-questions.md`)

[rs/07-missing-fact-question-generate.prompt.md](rs/07-missing-fact-question-generate.prompt.md) writes both `{{output_root}}/09-missing-facts.md` and `{{output_root}}/12-targeted-questions.md`. The two outputs cross-link by `missing_id` / `question_id`. There is no separate targeted-question prompt card; total prompt count remains 23.

## How To Run One Prompt Manually

1. Run [tools/New-AisrafRun.ps1](../tools/New-AisrafRun.ps1) to create a fresh `runs/<RunId>/` folder with a populated `run-profile.yaml`.
2. Stage required inputs under `runs/<RunId>/inputs/` (use `-CopySampleInputs` once Build Package 10 provides samples).
3. Set `sensitive_data_confirmed_redacted: true` in the run profile after confirming inputs are clean, then run [tools/Test-AisrafRunProfile.ps1](../tools/Test-AisrafRunProfile.ps1) with `-ExecutionReady`.
4. Open the chosen prompt card in VS Code Copilot Chat. Do not edit the card body.
5. Inspect the produced artifact under `{{output_root}}` (or `{{output_root}}/dfd/` for DFD prompts).
6. Append a `00-run-log.md` entry only after a human reviewer accepts the artifact.

## How To Update A Prompt

- Edit only the canonical card under `prompts/rs/` or `prompts/dfd/`.
- Update [prompt-registry.yaml](prompt-registry.yaml) if the change affects `output_artifact`, `input_dependencies`, `uses_run_profile_fields`, `future_skill_id`, `future_pra_owner`, or `notes`.
- Re-run [tools/Test-AisrafPackage.ps1](../tools/Test-AisrafPackage.ps1) and re-evaluate [validation/package-04-prompts-checklist.md](../validation/package-04-prompts-checklist.md) and [validation/prompt-registry-checklist.md](../validation/prompt-registry-checklist.md) before staging.
- Do not patch a wrapper instead of the canonical card. Do not remove the 11-section structure.

## Common Mistakes

- Treating prompt cards as autonomous automation.
- Hardcoding `run_id`, sample paths, or URLs into a card.
- Adding a Build Package 05+ artifact (skill, PRA, adapter, catalog, blueprint, template, sample) as a Required Read.
- Writing outputs outside `{{output_root}}`.
- Promoting an `unknown` row to a confirmed fact to lower the unknown count.
- Claiming Jira post-back, Confluence publication, Rovo execution, MCP execution, scoring against a baseline that doesn't exist, diagram generation, or release export from a prompt.

## Related Build Packages

- Build Package 02 — [config/](../config/) — run-profile variable model.
- Build Package 03 — [tools/](../tools/) — `New-AisrafRun.ps1`, `Test-AisrafRunProfile.ps1`, `Test-AisrafPackage.ps1`.
- Build Package 05 — [skills/](../skills/) — will replace each prompt's `future_skill_id` with a concrete `SK-*` contract path.
- Build Package 06 — [prototype-agents/](../prototype-agents/) — will replace each prompt's `future_pra_owner` with a concrete `PRA-*` specification path.
- Build Package 12 — [validation/](../validation/) — broader validation gates.

## Current State

Build Package 04 is active. Twenty-three canonical prompt cards plus the registry and two family READMEs are present. Skill contracts, PRA specifications, `.agent.md` adapters, catalogs, blueprints, templates, samples, run outputs, diagrams, docs, and release artifacts are deferred to their respective owning Build Packages.
