# AISRAF Copilot Skill Wrappers

Build Package 12C projects the approved AISRAF local adapters into thin Copilot-discoverable skill wrappers.

These files are projections only. They reference canonical adapters, PRAs, prompts, skills, templates, and validators. They do not replace or duplicate the canonical contracts.

## Wrapper Index

| Wrapper | Canonical adapter | Operator card |
|---|---|---|
| `aisraf-orchestration` | `.agents/aisraf-orchestrator.agent.md` | `aisraf-orchestration.operator-card.md` |
| `aisraf-input-read` | `.agents/aisraf-input-reader.agent.md` | `aisraf-input-read.operator-card.md` |
| `aisraf-dfd-extraction` | `.agents/aisraf-dfd-extractor.agent.md` | `aisraf-dfd-extraction.operator-card.md` |
| `aisraf-review-table-build` | `.agents/aisraf-review-table-builder.agent.md` | `aisraf-review-table-build.operator-card.md` |
| `aisraf-blueprint-questioning` | `.agents/aisraf-blueprint-questioner.agent.md` | `aisraf-blueprint-questioning.operator-card.md` |
| `aisraf-finding-recommendation` | `.agents/aisraf-finding-recommender.agent.md` | `aisraf-finding-recommendation.operator-card.md` |
| `aisraf-handoff-qa-score` | `.agents/aisraf-handoff-qa-scorer.agent.md` | `aisraf-handoff-qa-score.operator-card.md` |

## Operator Use

Use a wrapper when you want an AISRAF role to explain itself, preview its output shape in chat, or write only its declared run output paths under `runs/{{run_id}}/` after the run profile and hooks permit it.

For read-only preview, say: `preview only - write nothing`.

For controlled output, confirm `runs/{{run_id}}/run-profile.yaml` is execution-ready, then use only the wrapper whose declared input dependencies are present.

## Boundaries

- No wrapper edits `prompts/`, `skills/`, `prototype-agents/`, `.agents/`, `.github/agents/`, `catalogs/`, `blueprints/`, `templates/`, `samples/`, `docs/`, `diagrams/`, or `release/`.
- No wrapper claims runtime, cloud, ADK, MCP, Jira, Confluence, Rovo, database, Terraform, external post-back, release, or diagram execution.
- Unknown values stay unknown until supported evidence resolves them.
- Accuracy scoring is owned only by `skills/rs/SK-ACCURACY-SCORE.md` and only when the scoring conditions are met.

## Validation

- Projection gates: `validation/agent-skill-projection-checklist.md`.
- Role smoke gates: `validation/role-smoke-test-checklist.md`.
- Chat preview gates: `validation/chat-preview-test-checklist.md`.
- Hook gates: `validation/hook-readiness-checklist.md`.
- Package validator: `tools/Test-AisrafPackage.ps1`.
- Readiness harness: `tools/Test-AisrafBp12AReadiness.ps1`.
