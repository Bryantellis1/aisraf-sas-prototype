# Template Consumption Checklist

Authority sources:

- `prompts/prompt-registry.yaml`
- `skills/skill-registry.yaml`
- `prototype-agents/prototype-agent-registry.yaml`
- `catalogs/catalog-registry.yaml`
- `blueprints/blueprint-registry.yaml`
- `templates/template-registry.yaml`

## 1. Output Templates ↔ Prompts

For each prompt that declares an `output_artifact` under `{{output_root}}` or `{{output_root}}/dfd/` in `prompts/prompt-registry.yaml`:

- [ ] PR-RS-01 `{{output_root}}/01-input-inventory.md` ↔ TPL-OUT-01-INPUT-INVENTORY
- [ ] PR-RS-02 `{{output_root}}/02-visible-dfd-objects.md` ↔ TPL-OUT-02-VISIBLE-DFD-OBJECTS
- [ ] PR-RS-03 `{{output_root}}/03-legend-normalization.md` ↔ TPL-OUT-03-LEGEND-NORMALIZATION
- [ ] PR-RS-04 `{{output_root}}/04-components.md` ↔ TPL-OUT-04-COMPONENTS
- [ ] PR-RS-04 `{{output_root}}/05-flows.md` ↔ TPL-OUT-05-FLOWS
- [ ] PR-RS-05 `{{output_root}}/06-boundaries.md` ↔ TPL-OUT-06-BOUNDARIES
- [ ] PR-RS-05 `{{output_root}}/07-security-stack-assessment.md` ↔ TPL-OUT-07-SECURITY-STACK-ASSESSMENT
- [ ] PR-RS-06 `{{output_root}}/08-internal-review-table.md` ↔ TPL-OUT-08-INTERNAL-REVIEW-TABLE
- [ ] PR-RS-07 `{{output_root}}/09-missing-facts.md` ↔ TPL-OUT-09-MISSING-FACTS
- [ ] PR-RS-07 `{{output_root}}/12-targeted-questions.md` ↔ TPL-OUT-12-TARGETED-QUESTIONS
- [ ] PR-RS-08 `{{output_root}}/10-ai-action-level.md` ↔ TPL-OUT-10-AI-ACTION-LEVEL
- [ ] PR-RS-09 `{{output_root}}/11-blueprint-match.md` ↔ TPL-OUT-11-BLUEPRINT-MATCH
- [ ] PR-RS-10 `{{output_root}}/13-findings.md` ↔ TPL-OUT-13-FINDINGS
- [ ] PR-RS-10 `{{output_root}}/14-recommendations.md` ↔ TPL-OUT-14-RECOMMENDATIONS
- [ ] PR-RS-11 `{{output_root}}/15-handoff-pack.md` ↔ TPL-OUT-15-HANDOFF-PACK
- [ ] PR-RS-12 `{{output_root}}/16-validation-notes.md` ↔ TPL-OUT-16-VALIDATION-NOTES
- [ ] PR-RS-13 `{{output_root}}/17-accuracy-score.md` ↔ TPL-OUT-17-ACCURACY-SCORE
- [ ] PR-DFD-02 `{{output_root}}/dfd/01-intake-quality-check.md` ↔ TPL-OUT-DFD-01-INTAKE-QUALITY-CHECK
- [ ] PR-DFD-03 `{{output_root}}/dfd/02-boundary-catalog.md` ↔ TPL-OUT-DFD-02-BOUNDARY-CATALOG
- [ ] PR-DFD-04 `{{output_root}}/dfd/03-component-catalog.md` ↔ TPL-OUT-DFD-03-COMPONENT-CATALOG
- [ ] PR-DFD-05 `{{output_root}}/dfd/04-flow-inventory.md` ↔ TPL-OUT-DFD-04-FLOW-INVENTORY
- [ ] PR-DFD-06 `{{output_root}}/dfd/05-annotation-resolution.md` ↔ TPL-OUT-DFD-05-ANNOTATION-RESOLUTION
- [ ] PR-DFD-07 `{{output_root}}/dfd/06-boundary-crossings.md` ↔ TPL-OUT-DFD-06-BOUNDARY-CROSSINGS
- [ ] PR-DFD-08 `{{output_root}}/dfd/07-control-signals.md` ↔ TPL-OUT-DFD-07-CONTROL-SIGNALS
- [ ] PR-DFD-09 `{{output_root}}/dfd/08-confidence-score.md` ↔ TPL-OUT-DFD-08-CONFIDENCE-SCORE
- [ ] PR-DFD-10 `{{output_root}}/dfd/09-extraction-summary.md` ↔ TPL-OUT-DFD-09-EXTRACTION-SUMMARY

PR-RS-00 (chain wrapper) declares `output_artifact: []`; no template needed (consistent with `prompts/prompt-registry.yaml#compatibility_notes.rs_full_chain_wrapper`).

## 2. Output Templates ↔ Skills

For each skill that declares a write under `{{output_root}}` in `skills/skill-registry.yaml`:

- [ ] Every SK-* entry has a corresponding output template (per the table in `templates/output/README.md`).
- [ ] The handoff template (TPL-OUT-15-HANDOFF-PACK) maps to SK-HANDOFF-PACK-BUILD; the validation-notes template (TPL-OUT-16-VALIDATION-NOTES) maps to SK-VALIDATION-NOTE-WRITE; the accuracy-score template (TPL-OUT-17-ACCURACY-SCORE) maps to SK-ACCURACY-SCORE only (no other skill produces a numeric score).

## 3. Output Templates ↔ PRAs

For each PRA in `prototype-agents/prototype-agent-registry.yaml#pras[]`:

- [ ] PRA-01-SAS-REVIEW-ORCHESTRATOR ↔ TPL-OUT-00-RUN-LOG (file shape) + TPL-RUN-LOG-ENTRY-ROW (row pattern; coordinates appending across all PRAs).
- [ ] PRA-02-INPUT-READER ↔ TPL-OUT-01-INPUT-INVENTORY.
- [ ] PRA-03-DFD-EXTRACTOR ↔ TPL-OUT-02-VISIBLE-DFD-OBJECTS, TPL-OUT-04-COMPONENTS, TPL-OUT-05-FLOWS, all 9 TPL-OUT-DFD-* templates.
- [ ] PRA-04-LEGEND-NORMALIZER ↔ TPL-OUT-03-LEGEND-NORMALIZATION (adapter-mapped to aisraf-dfd-extractor per founder Q1 of Build Package 06).
- [ ] PRA-05-REVIEW-TABLE-BUILDER ↔ TPL-OUT-06-BOUNDARIES, TPL-OUT-07-SECURITY-STACK-ASSESSMENT, TPL-OUT-08-INTERNAL-REVIEW-TABLE.
- [ ] PRA-06-BLUEPRINT-QUESTIONER ↔ TPL-OUT-09-MISSING-FACTS, TPL-OUT-10-AI-ACTION-LEVEL, TPL-OUT-11-BLUEPRINT-MATCH, TPL-OUT-12-TARGETED-QUESTIONS.
- [ ] PRA-07-FINDING-RECOMMENDER ↔ TPL-OUT-13-FINDINGS, TPL-OUT-14-RECOMMENDATIONS.
- [ ] PRA-08-HANDOFF-QA-SCORER ↔ TPL-OUT-15-HANDOFF-PACK, TPL-OUT-16-VALIDATION-NOTES, TPL-OUT-17-ACCURACY-SCORE, TPL-JIRA-TICKET-DRAFT, TPL-CONFLUENCE-PAGE-DRAFT, TPL-RUN-POSTBACK-LOG-ENTRY-ROW.

## 4. Output Templates ↔ Adapters

- [ ] aisraf-orchestrator ↔ TPL-OUT-00-RUN-LOG, TPL-RUN-LOG-ENTRY-ROW.
- [ ] aisraf-input-reader ↔ TPL-OUT-01-INPUT-INVENTORY.
- [ ] aisraf-dfd-extractor ↔ TPL-OUT-02, TPL-OUT-03, TPL-OUT-04, TPL-OUT-05, all 9 TPL-OUT-DFD-* (joint with PRA-03 and PRA-04 per founder Q1 of Build Package 06; no `aisraf-legend-normalizer` adapter exists).
- [ ] aisraf-review-table-builder ↔ TPL-OUT-06, TPL-OUT-07, TPL-OUT-08.
- [ ] aisraf-blueprint-questioner ↔ TPL-OUT-09, TPL-OUT-10, TPL-OUT-11, TPL-OUT-12.
- [ ] aisraf-finding-recommender ↔ TPL-OUT-13, TPL-OUT-14.
- [ ] aisraf-handoff-qa-scorer ↔ TPL-OUT-15, TPL-OUT-16, TPL-OUT-17, TPL-JIRA-TICKET-DRAFT, TPL-CONFLUENCE-PAGE-DRAFT, TPL-RUN-POSTBACK-LOG-ENTRY-ROW.

## 5. Templates ↔ Catalogs

- [ ] Every catalog file path referenced in any template body resolves to an existing entry in `catalogs/catalog-registry.yaml#catalogs[]`.
- [ ] No template introduces a new catalog identifier.
- [ ] No template introduces a new controlled value (no enumeration of catalog entries inside template bodies).
- [ ] Confidence references use `<value-from-catalogs/data-protection/confidence-level-catalog.yaml>` only.
- [ ] Severity references use `<value-from-catalogs/review/severity-catalog.yaml>` only.
- [ ] Finding category references use `<value-from-catalogs/review/finding-category-catalog.yaml>` only.
- [ ] Recommendation type references use `<value-from-catalogs/review/recommendation-type-catalog.yaml>` only.
- [ ] AI Action Level references use `<value-from-catalogs/review/ai-action-level-catalog.yaml>` only.
- [ ] Review status references use `<value-from-catalogs/review/review-status-catalog.yaml>` only.

## 6. Templates ↔ Blueprints

- [ ] TPL-OUT-09-MISSING-FACTS, TPL-OUT-11-BLUEPRINT-MATCH, and TPL-OUT-12-TARGETED-QUESTIONS are the only templates that cite BP-* identifiers, and only as cross-references.
- [ ] No template introduces a new BP-* identifier.
- [ ] No template invents a new `material_missing_fact` outside `blueprints/blueprint-registry.yaml#blueprints[].material_missing_facts`.
- [ ] No template overrides any blueprint match condition or material missing fact.

## 7. Run-Log Coverage

- [ ] Every PRA writes one `templates/run/run-log-entry-row-template.md` row per executed step into `{{output_root}}/00-run-log.md`.
- [ ] Every executed prompt and skill is reachable through the run-log entry row template (consumers field lists all 23 prompts, all 26 skills, all 8 PRAs, all 7 adapters).
- [ ] `templates/run/postback-log-entry-row-template.md` is consumed only when the operator actually performs an external post-back (Jira / Confluence / both).

## 8. Output Destination Modes

For each `output_destination_mode` value in `config/run-profile.schema.yaml`:

- [ ] `local_only` — only output-family templates apply.
- [ ] `jira_draft` — `templates/jira/jira-ticket-draft-template.md` produces `{{output_root}}/jira-ticket-draft.md`; no post-back claim allowed.
- [ ] `confluence_draft` — `templates/confluence/confluence-page-draft-template.md` produces `{{output_root}}/confluence-page-draft.md`; no post-back claim allowed.
- [ ] `jira_and_confluence_draft` — both Jira and Confluence drafts produced; no post-back claim allowed.
- [ ] `external_postback_executed` — `templates/run/postback-log-entry-row-template.md` row required; `postback_execution_status: executed_by_operator` required.

## 9. Sealed Upstream Verification

- [ ] No edit to `prompts/`, `skills/`, `prototype-agents/`, `.agents/`, `catalogs/`, or `blueprints/`.
- [ ] No edit to `prompts/prompt-registry.yaml`, `skills/skill-registry.yaml`, `prototype-agents/prototype-agent-registry.yaml`, `catalogs/catalog-registry.yaml`, or `blueprints/blueprint-registry.yaml`.
