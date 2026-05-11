# AISRAF Handoff QA Score Operator Card

## Use This Role When

You need to build the handoff pack, write validation notes, or run governed scoring conditions.

## Accepted Input

- `runs/{{run_id}}/01-input-inventory.md` through `runs/{{run_id}}/14-recommendations.md`
- `{{expected_root}}` when scoring is enabled and required

## Writes

- `runs/{{run_id}}/15-handoff-pack.md`
- `runs/{{run_id}}/16-validation-notes.md`
- `runs/{{run_id}}/17-accuracy-score.md`

## Output To Expect

A design-review handoff pack, validation-ticket notes, and scoring output or a not-applicable scoring record.

## Local Only

This role is a local wrapper around `.agents/aisraf-handoff-qa-scorer.agent.md` and `PRA-08-HANDOFF-QA-SCORER`.

## Not Real Integration Yet

It does not edit baselines, publish externally, package a release, or run cloud, MCP, Jira, or Confluence services.

## Stop If

- Validation-ticket evidence is found inside the handoff pack (or vice versa).
- An accuracy claim is made when `mode != scored`, `expected_baseline_required = false`, or `{{expected_root}}` is empty.
- A score is inflated by hiding unknowns or by ignoring a critical miss.
