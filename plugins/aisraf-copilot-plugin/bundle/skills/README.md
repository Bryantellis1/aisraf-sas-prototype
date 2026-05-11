# skills/

Root Area: Root Area 07.

Owning Build Package: Build Package 05 — Skills and skill registry.

## Purpose

Canonical reusable skill-contract folder for AISRAF SAS Prototype v0.1.2. Skills are reusable work-unit contracts that wrap the Build Package 04 prompt cards. Each skill contract describes purpose, inputs, outputs, procedure, stop conditions, unknown handling, confidence handling, critical misses, human review gate, validation/scoring relationship, direct skill test, and out-of-scope claims. Skills are not executable runtime tools, scripts, services, runtime agents, PRAs, or `.agent.md` adapters.

## Layout

| Path | What lives here |
|---|---|
| [skill-registry.yaml](skill-registry.yaml) | Single registry that lists all 26 skill contracts (17 RS + 9 DFD) with their IDs, families, mapped Package 04 prompts, output artifacts, expected baselines (planned for Build Package 10), scoring categories, critical-miss references, and `future_pra_owner` placeholders (planned for Build Package 06). |
| [rs/](rs/) | RS family — 17 Review Sequence skill contracts covering RS-01..RS-17. See [rs/README.md](rs/README.md). |
| [dfd/](dfd/) | DFD family — 9 DFD subskill contracts covering DFD-01..DFD-09. See [dfd/README.md](dfd/README.md). |

## What Belongs Here

- `skills/skill-registry.yaml` — the single registry.
- `skills/rs/SK-*.md` — 17 RS skill contracts.
- `skills/dfd/SK-DFD-0[1-9]-*.md` — 9 DFD subskill contracts.
- This README and the two family READMEs.

## What Does Not Belong Here

- Prompt cards (owned by Build Package 04 under `prompts/`).
- PRA specifications (deferred to Build Package 06 under `prototype-agents/`).
- `.agent.md` adapters (deferred to Build Package 06 under `.agents/`).
- Catalogs (Build Package 07), blueprints (Build Package 08), templates beyond authoring-agent templates (Build Package 09), samples (Build Package 10), run outputs (Build Package 11), diagrams (Build Package 13), docs/runbooks (Build Package 14), release artifacts (Build Package 15).
- Schemas outside `config/`.
- Runtime code, cloud assets, MCP/Jira/Confluence/Rovo/ADK/Terraform proof.
- Old v0.01 skill copies, stale baselines, or scoring proof.

## Parameter Contract

Every skill contract resolves the seven required v0.1.2 run-profile variables from `runs/{{run_id}}/run-profile.yaml` through its mapped Package 04 prompt card:

- `{{run_id}}`
- `{{input_root}}`
- `{{expected_root}}`
- `{{output_root}}`
- `{{mode}}`
- `{{postback_execution_status}}`
- `{{output_destination_mode}}`

No skill contract may hardcode any of these values. Schema authority: [config/run-profile.schema.yaml](../config/run-profile.schema.yaml). Path resolution: [config/path-resolution-rules.md](../config/path-resolution-rules.md). Sensitive-data prohibitions: [config/sensitive-data-rules.md](../config/sensitive-data-rules.md).

## Required Skill Sections

Every skill contract contains all 14 sections in order:

1. Identity
2. Purpose
3. Required Inputs
4. Optional Inputs
5. Required Outputs
6. Procedure
7. Stop Conditions
8. Unknown Handling
9. Confidence Handling
10. Critical Misses
11. Human Review Gate
12. Validation / Scoring Relationship
13. Direct Skill Test
14. Not In Scope

## What Skill Contracts Do Not Claim

No skill contract claims:

- PRA execution (PRA specifications are deferred to Build Package 06);
- `.agent.md` adapter execution (adapters are deferred to Build Package 06);
- Jira post-back, Confluence publication, Rovo execution, or MCP execution;
- runtime, cloud, database, Terraform, or ADK execution;
- accuracy scoring outside [rs/SK-ACCURACY-SCORE.md](rs/SK-ACCURACY-SCORE.md) (the only skill that produces a numeric accuracy score; only when scoring is enabled and baselines exist);
- diagram generation;
- release or ZIP export;
- modification of Build Package 04 prompt cards or the prompt registry;
- modification of any baseline under `{{expected_root}}`.

## Compatibility Notes

Build Package 04 sealed the prompt registry with two placeholder `future_skill_id` values that diverge from the canonical Package 05 skill names. Build Package 05 uses the canonical names and records the drift; the prompt registry is not edited. See [skill-registry.yaml](skill-registry.yaml) `compatibility_notes` for full detail.

| Prompt registry placeholder | Canonical Package 05 skill | Prompt | Reason |
|---|---|---|---|
| `SK-DFD-LEGEND-NORMALIZE` | `SK-LEGEND-NORMALIZE` | [PR-RS-03](../prompts/rs/03-legend-normalization.prompt.md) | Drop `DFD-` prefix; the skill is RS-family, not DFD-family. |
| `SK-SECURITY-STACK-DETECT` | `SK-SECURITY-STACK-ASSESS` | [PR-RS-05](../prompts/rs/05-boundary-stack-detect.prompt.md) | The skill assesses presence/absence and gap state, not just detection. |

Some prompt registry `review_step` fields use prompt-sequence labels (e.g., `PR-RS-06 review_step: RS-06`) rather than the canonical SAS RS step (e.g., `RS-08`). Skill registry is authoritative for the canonical RS-01..RS-17 mapping.

`PR-RS-00` (full-chain wrapper) records `future_skill_id: SK-CHAIN-WRAPPER (planned)`. Build Package 05 does not author this skill. It is recorded in the registry's `planned_future_skills` block, outside the 26-skill count.

## Shared-Prompt Skill Pairs

Four Build Package 04 prompts each cover two skills. The shared prompt writes both output artifacts; each skill is the canonical contract for one artifact.

- [PR-RS-04](../prompts/rs/04-design-fact-extract.prompt.md) — `SK-COMPONENT-EXTRACT` + `SK-FLOW-EXTRACT`.
- [PR-RS-05](../prompts/rs/05-boundary-stack-detect.prompt.md) — `SK-BOUNDARY-CROSSING-DETECT` + `SK-SECURITY-STACK-ASSESS`.
- [PR-RS-07](../prompts/rs/07-missing-fact-question-generate.prompt.md) — `SK-MISSING-FACT-IDENTIFY` + `SK-TARGETED-QUESTION-GENERATE`.
- [PR-RS-10](../prompts/rs/10-finding-recommendation-write.prompt.md) — `SK-FINDING-CLASSIFY` + `SK-RECOMMENDATION-WRITE`.

This is why prompt count = 23 and skill count = 26.

## How To Test A Skill Contract Locally

1. Run [tools/New-AisrafRun.ps1](../tools/New-AisrafRun.ps1) to create a fresh `runs/<RunId>/` folder with a populated run-profile.
2. Stage required inputs under `runs/<RunId>/inputs/`.
3. Set `sensitive_data_confirmed_redacted: true` after confirming inputs are clean, then run [tools/Test-AisrafRunProfile.ps1](../tools/Test-AisrafRunProfile.ps1) with `-ExecutionReady`.
4. Open the skill's mapped Package 04 prompt card in VS Code Copilot Chat (the prompt card is the operator-facing instruction; the skill contract is the underlying reusable contract).
5. Inspect the produced artifact under `{{output_root}}` (or `{{output_root}}/dfd/` for DFD subskills).
6. Compare the artifact against the skill's Section 13 PASS criteria. Append a `00-run-log.md` entry only after a human reviewer accepts the artifact.

## How To Update A Skill

- Edit only the canonical contract under `skills/rs/` or `skills/dfd/`.
- Update [skill-registry.yaml](skill-registry.yaml) if the change affects `output_artifacts`, `input_dependencies`, `expected_baseline`, `scoring_category`, `critical_miss_refs`, `mapped_prompt_id`, `future_pra_owner`, or `notes`.
- Re-run [tools/Test-AisrafPackage.ps1](../tools/Test-AisrafPackage.ps1) and re-evaluate [validation/package-05-skills-checklist.md](../validation/package-05-skills-checklist.md) and [validation/skill-registry-checklist.md](../validation/skill-registry-checklist.md) before staging.
- Do not edit prompts/* or the prompt registry from Build Package 05.
- Do not patch a wrapper instead of the canonical contract. Do not remove the 14-section structure.

## Common Mistakes

- Treating skill contracts as runnable tools.
- Hardcoding `run_id`, sample paths, or URLs into a contract.
- Adding a Build Package 06+ artifact (PRA, adapter, catalog, blueprint, template, sample) as a hard required-input read.
- Writing outputs outside `{{output_root}}`.
- Promoting an `unknown` row to a confirmed fact to lower the unknown count.
- Claiming Jira post-back, Confluence publication, Rovo execution, MCP execution, scoring against a baseline that does not exist, diagram generation, or release export from a skill.
- Claiming runtime approval or implementation proof.

## Related Build Packages

- Build Package 02 — [config/](../config/) — run-profile variable model.
- Build Package 03 — [tools/](../tools/) — `New-AisrafRun.ps1`, `Test-AisrafRunProfile.ps1`, `Test-AisrafPackage.ps1`.
- Build Package 04 — [prompts/](../prompts/) — 23 canonical prompt cards mapped 1-to-1-or-2 with these 26 skills.
- Build Package 06 — [prototype-agents/](../prototype-agents/) — will replace each skill's `future_pra_owner` placeholder with a concrete `PRA-*` specification path.
- Build Package 07 — [catalogs/](../catalogs/) — controlled vocabulary referenced as planned placeholders only at this stage.
- Build Package 12 — [validation/](../validation/) — broader validation gates.

## Current State

Build Package 05 is active. Twenty-six canonical skill contracts (17 RS + 9 DFD) plus the registry and two family READMEs are present. PRA specifications, `.agent.md` adapters, catalogs, blueprints, templates beyond authoring-agent templates, samples, run outputs, diagrams, docs, and release artifacts are deferred to their respective owning Build Packages.
