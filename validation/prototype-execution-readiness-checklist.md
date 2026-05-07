# Prototype Execution Readiness Checklist

Authored by: BUILD-AG-12-VALIDATION-R1.

Scope: confirms two execution modes are ready against the BP04–BP09 chain. Mode A is direct skill test (operator invokes a single skill via its `.agent.md` adapter or directly via the prompt card). Mode B is chained run via `PRA-01-SAS-REVIEW-ORCHESTRATOR` (operator invokes the full BP04 chain end-to-end).

The checklist is read-only. Build Package 12 does not execute either mode.

`BP12-SAMPLE-DFD-BLOCKER` is cited: chain execution against `sample-001-dfd-crop` will exercise the chain but will not produce a canonical reference run.

## Identity

- Gate category: Chain gate.
- Run order position: 3 (Chain gates).
- Sealed sources: `prompts/`, `skills/`, `prototype-agents/`, `.agents/`, `catalogs/`, `blueprints/`, `templates/`, `samples/`, `runs/RUN-001/`.

## Modes

- **Mode A — Direct Skill Test.** Operator selects an `.agent.md` adapter from VS Code Copilot Chat dropdown, or runs a single prompt card directly. Used to exercise one stage of the chain in isolation.
- **Mode B — Chained Run via PRA-01.** Operator invokes `PRA-01-SAS-REVIEW-ORCHESTRATOR` (via `.agents/aisraf-orchestrator.agent.md`) to drive the full chain end-to-end. PR-RS-00 (`prompts/rs/00-run-full-chain.prompt.md`) is `status: planned` and writes no output of its own; orchestration is operator-driven and adapter-invoked.

## Inputs

- `prompts/prompt-registry.yaml`.
- `skills/skill-registry.yaml` (including `critical_miss_refs` and `stop_conditions` per skill contract).
- `prototype-agents/prototype-agent-registry.yaml` (`prompt_skill_agent_crosswalk`, `placeholder_to_pra_map`).
- `.agents/aisraf-*.agent.md` (7 adapters).
- `samples/sample-001-dfd-crop/inputs/*` (input set).
- `samples/sample-001-dfd-crop/expected/*` (26 baselines).
- `runs/RUN-001/run-profile.yaml`, `runs/RUN-001/00-run-log.md`.
- `templates/output/output-00-run-log-template.md` (run-log file shape).
- `templates/run/run-log-entry-row-template.md` and `templates/run/postback-log-entry-row-template.md` (row patterns).

## Carried-Forward Blocker

`BP12-SAMPLE-DFD-BLOCKER` — chain execution against `runs/RUN-001/` is mechanically possible. The resulting outputs are NOT a canonical reference run; the input DFD carries founder-identified defects. Operator must downgrade confidence on chain outputs.

## Gates — Mode A (Direct Skill Test)

| # | Gate | Falsifiable Check | Verdict |
|---|---|---|---|
| 1 | All 6 inputs present | The 6 sample input files exist under `samples/sample-001-dfd-crop/inputs/` (and `runs/RUN-001/inputs/`). | PASS |
| 2 | Each prompt card resolves | The 23 BP04 prompt cards exist on disk and reference the run-profile-only placeholder set. | PASS |
| 3 | Each skill contract resolves | The 26 BP05 skill contracts exist on disk and declare `mapped_prompt_id`/`mapped_prompt_file` resolving to the prompt registry. | PASS |
| 4 | Each adapter resolves | The 7 `.agent.md` adapters exist with `tools: [read, search, edit]` only and `user-invocable: true`. | PASS |
| 5 | Each baseline mirrors a template | Each of the 26 expected baselines declares `mirrors_template` resolving to a `templates/output/output-*-template.md`. | PASS |
| 6 | Stop conditions referenced exist | Every `stop_conditions` entry in a skill contract resolves to a stop condition pattern (e.g., `expected_baseline_required` violation, missing input, `unknown` overflow). | PASS |
| 7 | Run-log row template resolves | `templates/run/run-log-entry-row-template.md` exists; operator records each Mode A invocation as a row. | PASS |
| 8 | Mode A output destination | When invoked, Mode A writes only under `{{output_root}}` (= `runs/RUN-001/`). | PASS |

## Gates — Mode B (Chained Run via PRA-01)

| # | Gate | Falsifiable Check | Verdict |
|---|---|---|---|
| 9 | PRA-01 spec resolves | `prototype-agents/PRA-01-SAS-REVIEW-ORCHESTRATOR.md` exists and lists the chain order (RS chain + DFD chain). | PASS |
| 10 | Orchestrator adapter resolves | `.agents/aisraf-orchestrator.agent.md` exists and references PRA-01. | PASS |
| 11 | PR-RS-00 status | `prompts/rs/00-run-full-chain.prompt.md` is `status: planned`, claims no orchestration runtime, and writes no output of its own. | PASS |
| 12 | Crosswalk completeness | The crosswalk in `prototype-agents/prototype-agent-registry.yaml` covers all 23 prompts and 26 skills. | PASS |
| 13 | Run-log file shape | `runs/RUN-001/00-run-log.md` mirrors `templates/output/output-00-run-log-template.md`; row patterns from `templates/run/`. | PASS |
| 14 | Mode B output destination | When invoked, Mode B writes 17 RS outputs at `runs/RUN-001/` root and 9 DFD outputs under `runs/RUN-001/dfd/`; no other write paths. | PASS |
| 15 | Mode B Post-Back Evidence section | `00-run-log.md#Post-Back Evidence` is empty until `postback_execution_status: executed_by_operator` is set AND a destination URL is recorded; the row template is `templates/run/postback-log-entry-row-template.md`. | PASS |
| 16 | Mode B Stop Conditions Recorded section | `00-run-log.md#Stop Conditions Recorded` is empty until the chain raises a stop condition; entries follow the run-log row template. | PASS |

## Gates — Cross-Mode Discipline

| # | Gate | Falsifiable Check | Verdict |
|---|---|---|---|
| 17 | No `executed_by_operator` claim outside gating | No prompt, skill, PRA, adapter, template, baseline, or run artefact claims `executed_by_operator` outside the gated condition (`postback_execution_status: executed_by_operator` AND a row in `00-run-log.md#Post-Back Evidence`). | PASS |
| 18 | No diagram render claim | Mode A and Mode B do not render diagrams. Diagram generation is owned by Build Package 13. | PASS |
| 19 | No release packaging claim | Neither mode produces a release artefact. Release packaging is owned by Build Package 15. | PASS |
| 20 | Numeric scoring activation | `skills/rs/SK-ACCURACY-SCORE.md` activates only when `scoring_enabled: true` AND `expected_baseline_required: true` AND `expected_root` is non-empty / populated. | PASS |
| 21 | Adapter selection is not runtime execution | Selecting an `.agent.md` adapter from the VS Code Copilot Chat dropdown is not equivalent to runtime execution (recorded in `prototype-agents/prototype-agent-registry.yaml`). | PASS |
| 22 | Sample DFD blocker honored | When run against `sample-001-dfd-crop`, both modes propagate the input DFD defect into outputs; outputs are not canonical reference outputs while `BP12-SAMPLE-DFD-BLOCKER` persists. | PASS (acknowledged) |

## Acceptance Verdict

- **PASS** when every gate reads PASS — the chain is ready for operator invocation in either mode.
- **PARTIAL_WITH_ISSUES** when an optional `future_only` reference is missing but documented; chain execution remains possible with downgraded confidence.
- **FAIL** when a required file, contract, registry entry, or stop-condition reference is missing or unresolvable.

The blocker note in gate 22 does NOT FAIL the checklist; it acknowledges the limitation. Sealing the run as canonical requires resolving `BP12-SAMPLE-DFD-BLOCKER`.

## Stop Conditions

- A required prompt card, skill contract, PRA spec, or adapter file is missing.
- A `mapped_prompt_id` / `mapped_prompt_file` / `future_skill_id` / `future_pra_owner` placeholder fails to resolve.
- An adapter declares a tool other than `read`, `search`, `edit`.
- A run artefact body claims runtime / cloud / ADK / Vertex / GCP / MCP / Jira post-back / Confluence publication / Rovo / database / Terraform execution outside the gated condition.

## Tool References

- `tools/Test-AisrafPackage.ps1` — surface validation.
- `tools/Test-AisrafRunProfile.ps1` — run-profile schema validation.
- This checklist is the human-review chain-readiness gate; Build Package 12 does not introduce a chain-execution validator.

## Out-of-Scope

- Executing the chain.
- Producing any of the 17 RS or 9 DFD chain outputs.
- Producing a numeric accuracy score against `runs/RUN-001/`.
- Sealing the run as canonical.
