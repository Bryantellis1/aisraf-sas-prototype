# Build Package 12C — Platform-Independent Agent Spec Template

| Field | Value |
|---|---|
| Document name | AISRAF Platform-Independent Agent Spec Template |
| Work package | WP-12C-I — Solution Package Architecture & Agent Specification Alignment |
| Status | DRAFT — template + one completed example. No canonical adapter or PRA is rewritten. |
| Audience | Future agent author, plugin packager, runtime adapter implementer, operator |
| Purpose | Provide one agent-spec shape that is identical across local workbench, Copilot plugin, and future Microsoft Agent Framework / Azure AI Foundry / Google ADK adapters |
| Companion | `validation/package-12c-solution-package-architecture.md`, `validation/package-12c-capability-agent-traceability-register.md`, `validation/package-12c-platform-projection-matrix.md`, `validation/package-12c-plugin-roadmap.md` |

## 1. Read Before Anything Else

- This template **does not replace** `prototype-agents/PRA-*.md` or `.agents/aisraf-*.agent.md`. Those are canonical and sealed.
- This template **describes a uniform projection shape** that any provider projection (`.github/agents/*`, `.copilot-skills/*`, future plugin manifest, future MAF/Foundry/ADK adapter) must respect.
- Authoring a brand-new agent in any future package follows this template, then is realized as a canonical PRA, a canonical adapter, and one or more provider projections.
- All template placeholders use `{{run_id}}`, `{{input_root}}`, `{{output_root}}`. Hard-coding `RUN-001` is forbidden.

## 2. Template Field Reference

| # | Field | Required | Allowed Values | Notes |
|---|---|---|---|---|
| 1 | `agent_id` | yes | kebab-case `aisraf-<name>` | Stable across all projections; matches `.agents/<id>.agent.md` filename root |
| 2 | `name` | yes | human-readable display name (e.g., `AISRAF Input Reader`) | Shown in chat agent dropdowns |
| 3 | `capability` | yes | `CAP-AISRAF-SECURITY-REVIEW-WORKBENCH` (today) | One capability per agent; multi-capability agents are not supported |
| 4 | `process_flow` | yes | `PFS-AISRAF-SAS-REVIEW-CHAIN` (today) | One PFS per agent |
| 5 | `task_flow` | yes | one or more `TFS-*` IDs | Lists every TFS this agent owns |
| 6 | `autonomy_level` | yes | `chat-preview-only` \| `controlled-write-on-approval` \| `governed-execution` | AISRAF today is `chat-preview-only` plus `controlled-write-on-approval` |
| 7 | `ai_component_mode` | yes | `assistive` \| `augmentative` \| `autonomous` | Maps to AISRAF AI Action Level catalog; `autonomous` requires WP-12C-F+ |
| 8 | `role_purpose` | yes | one paragraph (<= 120 words) | What this agent is and is not |
| 9 | `canonical_pra` | yes | one or more `prototype-agents/PRA-*.md` paths | Source of behavioral truth |
| 10 | `canonical_prompts` | yes | one or more `prompts/**/*.prompt.md` paths | Source of prompt text |
| 11 | `canonical_skills` | yes (or `none`) | one or more `skills/**/*.md` paths | Source of skill bodies |
| 12 | `canonical_templates` | yes (or `none`) | one or more `templates/**/*.md` paths | Source of output shapes |
| 13 | `provider_projections` | yes | list of provider surface paths | Each must reference, not duplicate, canonical paths |
| 14 | `allowed_inputs` | yes | list of read-only paths or path globs | Sealed surfaces are read-only here |
| 15 | `controlled_outputs` | yes | list of writeable paths under `runs/{{run_id}}/` | Must match `tools/hooks/hook-allow-list.yaml` |
| 16 | `hooks_required` | yes | list of hook IDs from `.github/hooks/aisraf-guardrails.json` and `tools/hooks/` | Today: prewrite guard, postwrite validator, stop summary, precommit validator |
| 17 | `memory_state_scope` | yes | `none-agent-side` \| `run-scoped-files` \| `session-scoped-chat` | AISRAF agents today: `run-scoped-files` (state lives in `runs/{{run_id}}/`) |
| 18 | `stop_conditions` | yes | at least 3 conditions copied verbatim from §11 of the canonical PRA | Falsifiable by byte-equality |
| 19 | `evaluation_tests` | yes | list of evaluation layers from `package-12c-solution-package-architecture.md` §13 | At minimum: discovery, role smoke, chat preview |
| 20 | `evidence_required` | yes | list of evidence paths or test card rows | What must exist before this agent's TFS is considered closed |
| 21 | `release_readiness_status` | yes | `local-workbench-only` \| `plugin-candidate` \| `runtime-candidate` | Drives plugin / runtime gating |

## 3. Template Body Form

```yaml
---
agent_id: aisraf-<name>
name: AISRAF <Display Name>
capability: CAP-AISRAF-SECURITY-REVIEW-WORKBENCH
process_flow: PFS-AISRAF-SAS-REVIEW-CHAIN
task_flow:
  - TFS-XX-<NAME>
autonomy_level: chat-preview-only
ai_component_mode: assistive
role_purpose: |
  One paragraph, <= 120 words. State what this agent is, what it is not,
  and which canonical PRA owns it. No external execution claims.
canonical_pra:
  - prototype-agents/PRA-XX-<NAME>.md
canonical_prompts:
  - prompts/<family>/<file>.prompt.md
canonical_skills:
  - skills/<family>/SK-<NAME>.md
canonical_templates:
  - templates/output/output-XX-<name>-template.md
provider_projections:
  - .agents/aisraf-<name>.agent.md
  - .github/agents/aisraf-<name>.agent.md
  - .github/skills/aisraf-<skill-id>/SKILL.md
  - .copilot-skills/aisraf-<skill-id>.skill.md
  - .copilot-skills/aisraf-<skill-id>.operator-card.md
allowed_inputs:
  - runs/{{run_id}}/run-profile.yaml
  - runs/{{run_id}}/inputs/
  - samples/sample-001-dfd-crop/inputs/
  - samples/sample-001-dfd-crop/expected/
controlled_outputs:
  - runs/{{run_id}}/<NN>-<name>.md
hooks_required:
  - aisraf-allowed-path-prewrite-guard
  - aisraf-focused-validator-postwrite
  - aisraf-session-stop-summary
  - aisraf-precommit-full-validator
memory_state_scope: run-scoped-files
stop_conditions:
  - "<verbatim from PRA §11>"
  - "<verbatim from PRA §11>"
  - "<verbatim from PRA §11>"
evaluation_tests:
  - discovery
  - role-smoke
  - chat-preview
  - sample-input-output-preview
evidence_required:
  - validation/package-12c-quick-manual-test-card.md (relevant row)
  - validation/package-12c-sample-input-output-test-card.md (relevant row)
release_readiness_status: local-workbench-only
---
```

The body that follows the YAML must reference the canonical PRA path and the canonical adapter path; it must not copy a canonical body section verbatim other than `stop_conditions`.

## 4. Mapping To Provider Projection Surfaces

The same spec drives every projection:

| Provider | Projection File | Translation Rule |
|---|---|---|
| Local canonical adapter | `.agents/<agent_id>.agent.md` | Long-form Markdown adapter; canonical |
| GitHub Copilot agent | `.github/agents/<agent_id>.agent.md` | Byte-identical projection of `.agents/<agent_id>.agent.md` |
| Provider Agent Skill package | `.github/skills/<skill-id>/SKILL.md` | YAML frontmatter `name`, `description`, `argument-hint`, `user-invocable: true`; body references canonical paths |
| Local operator skill wrapper | `.copilot-skills/<skill-id>.skill.md` | Thin wrapper; references canonical adapter and PRA |
| Operator card | `.copilot-skills/<skill-id>.operator-card.md` | Plain-language guide; references the same canonical paths |
| Future plugin manifest entry | `<plugin-root>/agents/<agent_id>.agent.md` (planned) | Bundled copy of the projection; install-time only |
| Future Microsoft Agent Framework adapter | not authored | Will translate `provider_projections`, `allowed_inputs`, `controlled_outputs`, `hooks_required` into the MAF agent shape |
| Future Azure AI Foundry deployment | not authored | Will translate the same fields into a Foundry agent + tools deployment |
| Future Google ADK adapter | not authored | Optional; same translation |

## 5. Completed Example — AISRAF Input Reader

```yaml
---
agent_id: aisraf-input-reader
name: AISRAF Input Reader
capability: CAP-AISRAF-SECURITY-REVIEW-WORKBENCH
process_flow: PFS-AISRAF-SAS-REVIEW-CHAIN
task_flow:
  - TFS-01-READ-INPUT-PACKAGE
autonomy_level: chat-preview-only
ai_component_mode: assistive
role_purpose: |
  AISRAF Input Reader inventories the existing SAS review materials staged
  under {{input_root}} for the current run. It is a specification-driven
  review agent, not a deployed runtime, and it does not claim Jira /
  Confluence / Rovo / MCP / cloud / database / Terraform / release
  post-back execution. It does not invent inputs and it does not introduce
  any new requester submission form. PRA-02-INPUT-READER owns its behavior.
canonical_pra:
  - prototype-agents/PRA-02-INPUT-READER.md
canonical_prompts:
  - prompts/rs/01-input-package-read.prompt.md
canonical_skills:
  - skills/rs/SK-INPUT-PACKAGE-READ.md
canonical_templates:
  - templates/output/output-01-input-inventory-template.md
provider_projections:
  - .agents/aisraf-input-reader.agent.md
  - .github/agents/aisraf-input-reader.agent.md
  - .github/skills/aisraf-input-read/SKILL.md
  - .copilot-skills/aisraf-input-read.skill.md
  - .copilot-skills/aisraf-input-read.operator-card.md
allowed_inputs:
  - runs/{{run_id}}/run-profile.yaml
  - runs/{{run_id}}/inputs/
  - samples/sample-001-dfd-crop/inputs/
  - samples/sample-001-dfd-crop/expected/expected-01-input-inventory.md
controlled_outputs:
  - runs/{{run_id}}/01-input-inventory.md
hooks_required:
  - aisraf-allowed-path-prewrite-guard
  - aisraf-focused-validator-postwrite
  - aisraf-session-stop-summary
  - aisraf-precommit-full-validator
memory_state_scope: run-scoped-files
stop_conditions:
  - "{{input_root}} cannot be resolved or read."
  - "An input is invented, fabricated, or claimed without a file present under {{input_root}}."
  - "The inventory claims an automatic chat-attachment movement workflow."
  - "The inventory introduces a new requester submission form."
  - "Output written outside {{output_root}}."
  - "Any forbidden runtime/cloud/ADK/MCP/Jira/Confluence claim is recorded."
evaluation_tests:
  - discovery
  - role-smoke
  - chat-preview
  - sample-input-output-preview
  - controlled-output (deferred until founder approval)
evidence_required:
  - validation/package-12c-quick-manual-test-card.md row B2
  - validation/package-12c-sample-input-output-test-card.md rows A2 + B2
  - runs/RUN-001/01-input-inventory.md (sealed BP12B post-execution evidence)
release_readiness_status: local-workbench-only
---
```

### 5.1 Why Each Field Was Filled This Way

- `autonomy_level: chat-preview-only` — Mode A in `validation/package-12c-manual-operator-test-guide.md`. Mode B (`controlled-write-on-approval`) requires explicit founder approval per the controlled-output checklist.
- `ai_component_mode: assistive` — the agent inventories what already exists; it does not classify, decide, or act on the operator's behalf.
- `canonical_skills` — exactly one skill (`SK-INPUT-PACKAGE-READ`); PRA-02 §4 names it.
- `controlled_outputs` — exactly one path; matches `tools/hooks/hook-allow-list.yaml` line 7 (`^runs/[A-Z0-9][A-Z0-9-]*/01-input-inventory\.md$`).
- `stop_conditions` — verbatim from `prototype-agents/PRA-02-INPUT-READER.md` §9.
- `release_readiness_status: local-workbench-only` — the agent is plugin-eligible only after WP-12C-K decisions; `runtime-candidate` requires WP-12C-F implementation, which has not started.

## 6. Authoring Workflow When Adding A New Agent

1. Open the canonical PRA template `prototype-agents/prototype-agent-template.md`. Author `prototype-agents/PRA-XX-<NAME>.md`.
2. Author the canonical adapter `.agents/aisraf-<id>.agent.md`. Project byte-identically into `.github/agents/aisraf-<id>.agent.md`.
3. Author the canonical prompt(s) under `prompts/<family>/`. Add to `prompt-registry.yaml`.
4. Author the canonical skill(s) under `skills/<family>/`. Add to `skill-registry.yaml`.
5. Add the agent to `prototype-agent-registry.yaml` and the `prompt-skill-agent-mapping-checklist.md`.
6. Project the agent into provider skill packages:
   - `.github/skills/aisraf-<skill-id>/SKILL.md`
   - `.copilot-skills/aisraf-<skill-id>.skill.md`
   - `.copilot-skills/aisraf-<skill-id>.operator-card.md`
7. Update `tools/hooks/hook-allow-list.yaml` if a new controlled-output path is required.
8. Update `tools/Test-AisrafPackage.ps1` allow-lists if new file names are required.
9. Add evaluation rows to `validation/package-12c-quick-manual-test-card.md` and the sample input/output test card.
10. Run all three validators with `0 FAIL` before declaring the new agent ready.

## 7. Stop Conditions For Authoring

- A new agent that has no canonical PRA is rejected.
- A new skill that is not registered in `skill-registry.yaml` is rejected.
- A new controlled-output path that is not in `tools/hooks/hook-allow-list.yaml` is rejected.
- Any provider projection that copies a canonical body instead of referencing it is rejected.
- Any agent that claims `governed-execution` autonomy without a runtime adapter is rejected.

## 8. Acceptance Verdict

`WP-12C-I_AGENT_SPEC_TEMPLATE_PASS` when:

- This template plus the completed Input Reader example are present.
- The Input Reader example field-for-field matches `prototype-agents/PRA-02-INPUT-READER.md` §§5, 6, 9 and `.agents/aisraf-input-reader.agent.md`.
- All three validators run with `0 FAIL`.
