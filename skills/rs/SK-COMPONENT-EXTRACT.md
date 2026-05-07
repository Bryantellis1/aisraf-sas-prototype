---
skill_id: SK-COMPONENT-EXTRACT
skill_name: Component Extract
owning_build_package: Build Package 05
skill_family: rs
status: active
mapped_prompt_id: PR-RS-04
mapped_prompt_file: prompts/rs/04-design-fact-extract.prompt.md
future_pra_owner: PRA-DESIGN-FACT-EXTRACTOR (planned; defined in Build Package 06)
review_step: RS-04
---

# SK-COMPONENT-EXTRACT — Component Extract

## 1. Identity

- skill_id: `SK-COMPONENT-EXTRACT`
- skill_name: Component Extract
- owning_build_package: Build Package 05 — Skills and skill registry.
- skill_family: `rs`
- status: `active`
- mapped_prompt_id: `PR-RS-04`
- mapped_prompt_file: [prompts/rs/04-design-fact-extract.prompt.md](../../prompts/rs/04-design-fact-extract.prompt.md) (shared with `SK-FLOW-EXTRACT`)
- future_pra_owner: `PRA-DESIGN-FACT-EXTRACTOR` (planned; defined in Build Package 06).
- review_step: `RS-04`

## 2. Purpose

Extract every supported component (services, models, stores, tools, agents, human actors, observability surfaces) from the visible DFD objects and review notes. The skill never invents a component, never classifies a component beyond what RS-02 and RS-03 support, and never assigns runtime properties from a label alone. It produces one of two artifacts written by the shared design-fact prompt.

## 3. Required Inputs

- `runs/{{run_id}}/run-profile.yaml`
- `{{output_root}}/02-visible-dfd-objects.md`
- `{{output_root}}/03-legend-normalization.md`
- `config/run-profile.validation-rules.md`
- `config/path-resolution-rules.md`
- `config/sensitive-data-rules.md`

## 4. Optional Inputs

- `{{input_root}}/cloud-triage-notes.md`, `{{input_root}}/review-transcript.md`, `{{input_root}}/intake-ticket.md` — supporting notes when present.
- `{{output_root}}/dfd/03-component-catalog.md` — DFD subskill DFD-03 output, when present.
- `{{expected_root}}/expected-components.json` — relationship reference only.

## 5. Required Outputs

- `{{output_root}}/04-components.md` — Markdown table with the columns: `component_id`, `component_name`, `component_type`, `zone`, `visibility_source`, `confidence`, `notes`.

The shared prompt also writes `{{output_root}}/05-flows.md` (owned by `SK-FLOW-EXTRACT`). This skill is responsible only for the component artifact.

## 6. Procedure

1. Resolve run-profile variables.
2. Read RS-02 and RS-03 outputs.
3. For each visible node not already reduced to noise (legend swatches, title text, decorations), produce a component row.
4. Populate `component_type` only when supported by the visible label, the normalized legend row, or a corroborating note. Otherwise set `unknown`.
5. Populate `zone` (e.g., internet, customer environment, internal trust, external SaaS, model endpoint, data store) only when the source supports it. Otherwise `unknown`.
6. Set `confidence` per Section 9.
7. Write `{{output_root}}/04-components.md`.
8. Stop before writing if any Section 7 stop condition holds.

## 7. Stop Conditions

- Required prior RS outputs missing.
- Run-profile variable unresolved or `sensitive_data_confirmed_redacted: false`.
- The work would invent a component that is not visible in RS-02.
- Write outside `{{output_root}}` or to the old reference workspace.
- Any prohibited execution claim.

## 8. Unknown Handling

- Components without supported type stay `component_type: unknown`.
- Components without supported zone stay `zone: unknown`.
- Material unknowns (component owner, runtime, identity binding, classification) carry forward to RS-09 only when they affect a finding, recommendation, owner, route, or score.

## 9. Confidence Handling

- `HIGH` — visibly drawn, fully labeled, with a corroborating note for type and zone.
- `MEDIUM` — visibly drawn with one supported attribute; the other is `unknown`.
- `LOW` — visibly drawn but type and zone are both ambiguous.
- `UNKNOWN` — node is visible but neither type nor zone can be supported.

## 10. Critical Misses

- Inventing a component that is not visible in the source.
- Missing an external actor, model, tool, store, observability surface, or human actor.
- Asserting runtime or approved-stack properties from a component label alone.
- Writing outside `{{output_root}}`.

## 11. Human Review Gate

The SAS reviewer must inspect:

- Every component row corresponds to a visible node in RS-02.
- Component type and zone match the legend and notes; ambiguity is `unknown`.
- No invented component appears in the output.

## 12. Validation / Scoring Relationship

- Expected baseline (when present): `{{expected_root}}/expected-components.json` (planned; defined in Build Package 10).
- Scoring category: component extraction (15 points within `SK-ACCURACY-SCORE`).
- Invented components are critical misses.

## 13. Direct Skill Test

```
tools/New-AisrafRun.ps1 -RunId RUN-LOCAL-SK-COMPONENT-TEST -SampleId sample-001-dfd-crop -Mode folder_first_test -CopySampleInputs
tools/Test-AisrafRunProfile.ps1 -RunProfilePath runs/RUN-LOCAL-SK-COMPONENT-TEST/run-profile.yaml -ExecutionReady
```

- Run RS-01, RS-02, RS-03 first, then open [prompts/rs/04-design-fact-extract.prompt.md](../../prompts/rs/04-design-fact-extract.prompt.md).
- Expected local output: `runs/RUN-LOCAL-SK-COMPONENT-TEST/04-components.md` (alongside `05-flows.md`).
- PASS = output exists; every row corresponds to a visible node; no invented components.

## 14. Not In Scope

- No flow extraction (owned by `SK-FLOW-EXTRACT`).
- No boundary derivation, security stack assertion, or scoring.
- No PRA, adapter, connector, runtime, scoring, diagram, or release execution.
- Catalogs and templates are placeholders only `(planned; defined in Build Package 07/09)`.
