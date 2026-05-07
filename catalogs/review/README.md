# catalogs/review/

Family: review.

Owning Build Package: Build Package 07 — Catalogs.

## Purpose

The review family defines the controlled vocabulary used to classify review outcomes: finding category, severity, recommendation type, AI Action Level, and review status. These catalogs make review outputs comparable across runs and reviewers and prevent ad-hoc severity or category labels.

## Catalogs

| file | purpose |
|---|---|
| [finding-category-catalog.yaml](finding-category-catalog.yaml) | Closed list of finding categories (Gap, Deficiency, Evidence Gap, Observation, Requirement, Risk, Out of Scope, Unknown). |
| [severity-catalog.yaml](severity-catalog.yaml) | Closed list of severity values used in findings and accuracy scoring (Critical, High, Medium, Low, Informational, Unknown). |
| [recommendation-type-catalog.yaml](recommendation-type-catalog.yaml) | Closed list of recommendation types (categories only — no recommendation prose, no template language). |
| [ai-action-level-catalog.yaml](ai-action-level-catalog.yaml) | Closed list of AI Action Levels (L0–L4) and Unknown — definitions only; selection and computation are owned by prompts, skills, and human review. |
| [review-status-catalog.yaml](review-status-catalog.yaml) | Closed list of review status values (in_progress, awaiting_inputs, awaiting_human_review, complete, blocked, withdrawn, unknown). |

## Boundaries

- Catalogs in this family define categories, levels, statuses, and types. They do not produce prose, recommendation language, finding sentences, validation-note text, scoring formulas, or remediation scripts.
- AI Action Level values are controlled definitions. The AI Action Level for a given review is computed by [skills/rs/SK-AI-ACTION-LEVEL-CLASSIFY.md](../../skills/rs/SK-AI-ACTION-LEVEL-CLASSIFY.md) under [prompts/rs/08-ai-action-level-classify.prompt.md](../../prompts/rs/08-ai-action-level-classify.prompt.md) and [PRA-06-BLUEPRINT-QUESTIONER](../../prototype-agents/PRA-06-BLUEPRINT-QUESTIONER.md), not by a catalog.
- Severity is a controlled value. Translating a finding into a numeric accuracy score is owned by [skills/rs/SK-ACCURACY-SCORE.md](../../skills/rs/SK-ACCURACY-SCORE.md) and [PRA-08-HANDOFF-QA-SCORER](../../prototype-agents/PRA-08-HANDOFF-QA-SCORER.md), not by a catalog.
- Recommendation prose, handoff language, validation-note prose, and runbook language are owned by Build Package 09 templates and Build Package 14 documentation. The recommendation-type catalog only names categories.

## Cross-References

- Every catalog in this family references [security-stacks/proof-vs-signal-rule-catalog.yaml](../security-stacks/proof-vs-signal-rule-catalog.yaml) in `evidence_rules`.
- Confidence values come from [data-protection/confidence-level-catalog.yaml](../data-protection/confidence-level-catalog.yaml).
