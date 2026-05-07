# Prompt-Skill-PRA Parity Checklist

Authored by: BUILD-AG-12-VALIDATION-R1.

Scope: cross-registry bijection over the active BP04 prompt registry, BP05 skill registry, BP06 prototype-agent registry, and BP06 `.agent.md` adapter set. Confirms the full chain (23 prompts ↔ 26 skills ↔ 8 PRAs ↔ 7 adapters) is internally consistent and that every `mapped_prompt_id` / `mapped_prompt_file` / `future_skill_id` / `future_pra_owner` placeholder resolves via the BP06 `prompt_skill_agent_crosswalk` and the BP06 `placeholder_to_pra_map`.

This checklist does not modify any registry. It is a read-only consistency gate.

## Identity

- Gate category: Chain gate.
- Run order position: 3 (Chain gates).
- Sealed sources: `prompts/prompt-registry.yaml`, `skills/skill-registry.yaml`, `prototype-agents/prototype-agent-registry.yaml`, the 7 `.agents/aisraf-*.agent.md` adapter files.

## Counts (BP04–BP06 contracts)

- Prompts: 23 total (14 RS + 9 DFD).
- Skills: 26 total (17 RS + 9 DFD). Two BP04→BP05 name divergences (`SK-DFD-LEGEND-NORMALIZE` → `SK-LEGEND-NORMALIZE`; `SK-SECURITY-STACK-DETECT` → `SK-SECURITY-STACK-ASSESS`) are documented in `skills/skill-registry.yaml#compatibility_notes`. The full-chain wrapper placeholder `SK-CHAIN-WRAPPER` is recorded only under `planned_future_skills` and is not counted in 26.
- PRAs: 8 total (`PRA-01-SAS-REVIEW-ORCHESTRATOR` through `PRA-08-HANDOFF-QA-SCORER`).
- Adapters: 7 total (orchestrator, input-reader, dfd-extractor, review-table-builder, blueprint-questioner, finding-recommender, handoff-qa-scorer). `PRA-04-LEGEND-NORMALIZER` has no dedicated adapter; it is wrapped jointly with `PRA-03` by `.agents/aisraf-dfd-extractor.agent.md`.

## Inputs

- `prompts/prompt-registry.yaml`.
- `skills/skill-registry.yaml`.
- `prototype-agents/prototype-agent-registry.yaml` (in particular `prompt_skill_agent_crosswalk` and `placeholder_to_pra_map`).
- `.agents/*.agent.md` (7 adapter files).
- `validation/prompt-registry-checklist.md`, `validation/skill-registry-checklist.md`, `validation/agent-registry-checklist.md`, `validation/prompt-skill-agent-mapping-checklist.md` (BP04–BP06 frozen evidence; read-only).

## Gates

### Bijection on counts

| # | Gate | Falsifiable Check | Verdict |
|---|---|---|---|
| 1 | 23 active prompts | `prompts/prompt-registry.yaml` lists exactly 23 entries (14 RS + 9 DFD). | PASS |
| 2 | 26 active skills | `skills/skill-registry.yaml` lists exactly 26 entries (17 RS + 9 DFD); `SK-CHAIN-WRAPPER` is under `planned_future_skills`, not counted. | PASS |
| 3 | 8 PRAs | `prototype-agents/prototype-agent-registry.yaml` lists exactly 8 entries (`PRA-01..PRA-08`). | PASS |
| 4 | 7 adapters | Exactly 7 `aisraf-*.agent.md` files exist under `.agents/`. | PASS |

### Crosswalk completeness

| # | Gate | Falsifiable Check | Verdict |
|---|---|---|---|
| 5 | Every prompt mapped | The 23 prompts each appear once in `prototype-agents/prototype-agent-registry.yaml#prompt_skill_agent_crosswalk`. `prompts/rs/00-run-full-chain.prompt.md` (PR-RS-00) is mapped to `PRA-01` with no skill (consistent with `planned_future_skills` for `SK-CHAIN-WRAPPER`). | PASS |
| 6 | Every skill mapped | The 26 skills each appear once in the crosswalk. | PASS |
| 7 | Every PRA mapped | The 8 PRAs each carry at least one prompt+skill pair in the crosswalk; `PRA-04` is associated with the legend-normalize chain step. | PASS |
| 8 | Every adapter mapped | The 7 adapters each map to one or more PRAs; `aisraf-dfd-extractor.agent.md` jointly wraps PRA-03 and PRA-04. | PASS |

### Reference resolution

| # | Gate | Falsifiable Check | Verdict |
|---|---|---|---|
| 9 | `mapped_prompt_id` resolves | Every `mapped_prompt_id` referenced from a skill resolves to a `prompts/prompt-registry.yaml` entry. | PASS |
| 10 | `mapped_prompt_file` resolves | Every `mapped_prompt_file` referenced from a skill resolves to a file under `prompts/rs/` or `prompts/dfd/`. | PASS |
| 11 | `future_skill_id` resolves via PRA registry | Every `future_skill_id` referenced from a prompt resolves to a skill in `skills/skill-registry.yaml` (or to the documented `SK-CHAIN-WRAPPER` placeholder, which is `planned_future_skills`). | PASS |
| 12 | `future_pra_owner` resolves via crosswalk | Every `future_pra_owner` reference resolves through `prototype-agents/prototype-agent-registry.yaml#prompt_skill_agent_crosswalk`. | PASS |
| 13 | `placeholder_to_pra_map` complete | Every placeholder name used by BP04 prompt cards or BP05 skill contracts resolves through `prototype-agents/prototype-agent-registry.yaml#placeholder_to_pra_map`. | PASS |
| 14 | Two name-divergence cases documented | `SK-DFD-LEGEND-NORMALIZE` → `SK-LEGEND-NORMALIZE` and `SK-SECURITY-STACK-DETECT` → `SK-SECURITY-STACK-ASSESS` are recorded in `skills/skill-registry.yaml#compatibility_notes`; no edit to the prompt registry is permitted. | PASS |

### No orphans

| # | Gate | Falsifiable Check | Verdict |
|---|---|---|---|
| 15 | No orphan prompt | No `prompts/*.prompt.md` is missing from the prompt registry. | PASS |
| 16 | No orphan skill | No `skills/*/SK-*.md` is missing from the skill registry. | PASS |
| 17 | No orphan PRA | No `prototype-agents/PRA-*.md` is missing from the prototype-agent registry. | PASS |
| 18 | No orphan adapter | No `.agents/aisraf-*.agent.md` is missing from the adapter contract set listed in `prototype-agents/prototype-agent-registry.yaml`. | PASS |
| 19 | No phantom crosswalk row | No row in `prompt_skill_agent_crosswalk` references a non-existent prompt, skill, PRA, or adapter. | PASS |

### No new content claims

| # | Gate | Falsifiable Check | Verdict |
|---|---|---|---|
| 20 | No execution claims | The four registries do not claim runtime / cloud / ADK / Vertex / GCP / MCP / Jira post-back / Confluence publication / Rovo / database / Terraform execution. | PASS |
| 21 | No new placeholders introduced by BP12 | Build Package 12 does not introduce new `future_skill_id` or `future_pra_owner` placeholders. | PASS |
| 22 | Adapter tool list discipline | Each `.agent.md` adapter declares `tools: [read, search, edit]` only; no adapter declares another tool. | PASS |

## Acceptance Verdict

- **PASS** when every gate reads PASS.
- **PARTIAL_WITH_ISSUES** when a documented compatibility note (e.g., the two name divergences) accounts for an apparent miss; this is acceptable.
- **FAIL** when any gate other than the documented compatibility cases reads FAIL.

## Stop Conditions

- A registry edit is attempted by Build Package 12.
- A new placeholder, prompt, skill, PRA, or adapter is introduced by Build Package 12.
- The crosswalk no longer resolves for any of the 23 prompts, 26 skills, 8 PRAs, or 7 adapters.

## Tool References

- `tools/Test-AisrafPackage.ps1` — surface-level (count + filename) lint.
- This checklist is the human-review crosswalk gate; no automated crosswalk-resolver is introduced by Build Package 12.

## Out-of-Scope

- Modifying any registry.
- Adding `SK-CHAIN-WRAPPER` to the active skill set.
- Authoring an `aisraf-legend-normalizer.agent.md` adapter.
