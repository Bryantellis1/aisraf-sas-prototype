# Agent Skill Projection Checklist (BP12C)

Authored by: BP12C-OPERATOR-EXPERIENCE-PLAN-R1.

Status: **PLANNING_ONLY**. This checklist defines the gates the 7 skill wrappers must pass when BP12C-Implementation lands. It does not author the wrappers.

## Purpose

Define the falsifiable gates each Copilot-native skill package must satisfy. Provider skills live under `.github/skills/<skill-id>/SKILL.md`; retained local/operator wrappers live under `.copilot-skills/`. Both are **thin projections**: they reference canonical skills, prompts, templates, and validators. They do not duplicate canonical content and do not encode review logic.

## Wrapper Set Under Test

| # | Skill ID | Provider Package | Local Wrapper | Adapter Wrapped | Skill Required |
|---|---|---|---|---|---|
| 1 | `aisraf-orchestration` | `.github/skills/aisraf-orchestration/SKILL.md` | `.copilot-skills/aisraf-orchestration.skill.md` | `.agents/aisraf-orchestrator.agent.md` | No (orchestrator owns no skill) |
| 2 | `aisraf-input-read` | `.github/skills/aisraf-input-read/SKILL.md` | `.copilot-skills/aisraf-input-read.skill.md` | `.agents/aisraf-input-reader.agent.md` | Yes |
| 3 | `aisraf-dfd-extraction` | `.github/skills/aisraf-dfd-extraction/SKILL.md` | `.copilot-skills/aisraf-dfd-extraction.skill.md` | `.agents/aisraf-dfd-extractor.agent.md` | Yes |
| 4 | `aisraf-review-table-build` | `.github/skills/aisraf-review-table-build/SKILL.md` | `.copilot-skills/aisraf-review-table-build.skill.md` | `.agents/aisraf-review-table-builder.agent.md` | Yes |
| 5 | `aisraf-blueprint-questioning` | `.github/skills/aisraf-blueprint-questioning/SKILL.md` | `.copilot-skills/aisraf-blueprint-questioning.skill.md` | `.agents/aisraf-blueprint-questioner.agent.md` | Yes |
| 6 | `aisraf-finding-recommendation` | `.github/skills/aisraf-finding-recommendation/SKILL.md` | `.copilot-skills/aisraf-finding-recommendation.skill.md` | `.agents/aisraf-finding-recommender.agent.md` | Yes |
| 7 | `aisraf-handoff-qa-score` | `.github/skills/aisraf-handoff-qa-score/SKILL.md` | `.copilot-skills/aisraf-handoff-qa-score.skill.md` | `.agents/aisraf-handoff-qa-scorer.agent.md` | Yes |

## Gates — Discovery (D1–D7)

Each provider skill must be discoverable by the operator surface (Copilot Chat Agent Skills and Copilot CLI skill list where supported).

| # | Gate | Falsifiable Check |
|---|---|---|
| D1 | `aisraf-orchestration` discoverable | `.github/skills/aisraf-orchestration/SKILL.md` exists; frontmatter name matches parent folder; operator surface lists it. |
| D2 | `aisraf-input-read` discoverable | Same. |
| D3 | `aisraf-dfd-extraction` discoverable | Same. |
| D4 | `aisraf-review-table-build` discoverable | Same. |
| D5 | `aisraf-blueprint-questioning` discoverable | Same. |
| D6 | `aisraf-finding-recommendation` discoverable | Same. |
| D7 | `aisraf-handoff-qa-score` discoverable | Same. |

## Gates — Reference Integrity (R1–R7)

Each wrapper must reference its canonical PRA, prompt(s), and skill(s) by exact path. References are checked by grep.

| # | Gate | Falsifiable Check |
|---|---|---|
| R1 | Provider skill references the right adapter | Provider `SKILL.md` contains the literal `.agents/aisraf-<id>.agent.md` path; retained `.copilot-skills/*.skill.md` wrapper also contains the adapter path. |
| R2 | Wrapper references the right PRA(s) | Wrapper file contains the literal `prototype-agents/PRA-0[1-8]-*.md` paths from the umbrella plan §Skill Projection Set. |
| R3 | Wrapper references the right canonical skill(s) | Wrapper file contains every `skills/rs/SK-*.md` and/or `skills/dfd/SK-DFD-0[1-9]-*.md` path declared for that wrapper. |
| R4 | Wrapper references the right prompt(s) | Wrapper file contains every `prompts/rs/*.prompt.md` and/or `prompts/dfd/*.prompt.md` path declared for that wrapper. |
| R5 | Orchestrator skill exception | `aisraf-orchestration` contains the literal phrase `owns no skill` (BP06 governance), matching `.agents/aisraf-orchestrator.agent.md`. |
| R6 | DFD extractor consolidation | `aisraf-dfd-extraction` references both `prototype-agents/PRA-03-DFD-EXTRACTOR.md` and `prototype-agents/PRA-04-LEGEND-NORMALIZER.md`, matching `.agents/aisraf-dfd-extractor.agent.md`. |
| R7 | No canonical rewrite | No SK-*.md, prompt, PRA, or template body text is duplicated inline in any provider skill or retained local wrapper. |

## Gates — No-Logic Guarantee (L1–L4)

Wrappers must not encode review logic. Logic lives in canonical skills/prompts.

| # | Gate | Falsifiable Check |
|---|---|---|
| L1 | No catalog values inlined | No wrapper contains the literal value lists from `catalogs/components/`, `catalogs/interactions/`, `catalogs/boundaries/`, `catalogs/identity-access/`, `catalogs/data-protection/`, `catalogs/security-stacks/`, or `catalogs/review/`. |
| L2 | No blueprint match logic | No wrapper computes blueprint match states; only `prompts/rs/09-blueprint-match.prompt.md` + `skills/rs/SK-REVIEW-BLUEPRINT-MATCH.md` may. Falsifiable by grep: wrappers contain no `matched\|candidate\|no_match\|unknown` enumeration outside a reference path. |
| L3 | No scoring logic | No wrapper computes a numeric accuracy score; only `prompts/rs/13-accuracy-score.prompt.md` + `skills/rs/SK-ACCURACY-SCORE.md` may. |
| L4 | No AAL classification logic | No wrapper enumerates AAL bands; only `prompts/rs/08-ai-action-level-classify.prompt.md` + `skills/rs/SK-AI-ACTION-LEVEL-CLASSIFY.md` may. |

## Gates — Allowed Writes (W1–W7)

Each wrapper declares its exact allowed write set with template-style run IDs.

| # | Gate | Falsifiable Check |
|---|---|---|
| W1 | `aisraf-orchestration` writes only `runs/{{run_id}}/00-run-log.md` and chains the other wrappers. | Wrapper §Allowed Writes section enumerates exactly those paths. |
| W2 | `aisraf-input-read` writes only `runs/{{run_id}}/01-input-inventory.md`. | Same. |
| W3 | `aisraf-dfd-extraction` writes only `runs/{{run_id}}/02-visible-dfd-objects.md`, `03-legend-normalization.md`, `04-components.md`, `05-flows.md`, and `runs/{{run_id}}/dfd/01-..-09-*.md`. | Same. |
| W4 | `aisraf-review-table-build` writes only `runs/{{run_id}}/06-boundaries.md`, `07-security-stack-assessment.md`, `08-internal-review-table.md`. | Same. |
| W5 | `aisraf-blueprint-questioning` writes only `runs/{{run_id}}/09-missing-facts.md`, `10-ai-action-level.md`, `11-blueprint-match.md`, `12-targeted-questions.md`. | Same. |
| W6 | `aisraf-finding-recommendation` writes only `runs/{{run_id}}/13-findings.md`, `14-recommendations.md`. | Same. |
| W7 | `aisraf-handoff-qa-score` writes only `runs/{{run_id}}/15-handoff-pack.md`, `16-validation-notes.md`, `17-accuracy-score.md`. | Same. |

## Gates — Stop Conditions (S1–S7)

Each wrapper carries at least 3 stop conditions copied verbatim from its canonical adapter §11.

| # | Gate | Falsifiable Check |
|---|---|---|
| S1–S7 | Stop conditions verbatim from adapter §11 | For each wrapper, the §Stop Conditions section is byte-equal (line-by-line) to at least 3 of the §11 lines from its canonical adapter. |

## Gates — No-Fake-Proof (N1–N7)

Each wrapper repeats the BP06 no-fake-proof prohibition verbatim and cannot satisfy any positive execution claim regex.

| # | Gate | Falsifiable Check |
|---|---|---|
| N1–N7 | Per-wrapper `Test-PositiveExecutionClaim` returns `$null` | The 13 BP12A regexes (`runtime_deployed:\s*true`, `adk_deployed:\s*true`, `cloud_resources_created:\s*true`, `database_jobs_created:\s*true`, `mcp_execution_available:\s*true`, `jira_confluence_execution_available:\s*true`, `postback_execution_status: executed_by_operator`, `output_destination_mode: external_postback_executed`, `Jira post-back executed`, `Confluence publication executed`, `Terraform applied`, AAL-L4 autonomy patterns × 2) all fail to match any wrapper text. |

## Gates — Sealed-Surface Preservation (P1–P5)

| # | Gate | Falsifiable Check |
|---|---|---|
| P1 | `.agents/` byte-stable | `git diff .agents/` returns no changes after BP12C-Implementation. |
| P2 | `.github/agents/` byte-stable | Same. |
| P3 | `prompts/`, `skills/`, `prototype-agents/`, `catalogs/`, `blueprints/`, `templates/` byte-stable | Same. |
| P4 | `samples/` byte-stable beyond BP12B-approved baseline refresh | `git diff samples/` returns only the BP12B-approved expected-baseline paths. |
| P5 | `runs/RUN-001/` evidence byte-stable | `git diff runs/RUN-001/` returns only `00-run-log.md` (BP12B-approved post-execution gate); the 26 generated outputs unchanged. |

## Acceptance Verdict (BP12C-Implementation step)

**PASS** when: D1–D7, R1–R7, L1–L4, W1–W7, S1–S7, N1–N7, P1–P5 all green AND `Test-AisrafPackage.ps1` and `Test-AisrafBp12AReadiness.ps1` remain 0 FAIL.

## Stop Conditions

- Any wrapper duplicating canonical skill / prompt / PRA / template body text.
- Any wrapper writing outside its declared allowed-writes set.
- Any wrapper passing a positive-execution-claim regex.
- Any change to `.agents/`, `.github/agents/`, `prompts/`, `skills/`, `prototype-agents/`, `catalogs/`, `blueprints/`, `templates/` during BP12C-Implementation.
- Either core validator regressing.
