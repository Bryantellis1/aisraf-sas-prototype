# Agent Instruction Triad Template

Use this template for every future package build agent. The triad is mandatory.

## A. Prompt / Mission

Agent identity: `<BUILD-AG name>`

Build Package: `<Build Package number and name>`

Mission: `<what this agent builds or validates>`

Value created: `<why this package matters to the AISRAF SAS prototype>`

Allowed touch points:

- `<files and folders this agent may create or update>`

Prohibited touch points:

- `<files, folders, claims, systems, and artifacts this agent must not create or modify>`

Stop conditions:

- `<conditions requiring the agent to stop before writing>`

## B. Specification / Build Contract

Exact files and folders:

- `<path>`: `<required purpose and format>`

Required fields or sections:

- `<field or heading>`: `<rule>`

Naming rules:

- `<naming convention>`

Dependencies:

- `<prior Build Package or source reference>`

Allowed writes:

- `<path>`

Prohibited writes:

- `<path or artifact class>`

Source references:

- `<authoritative source>`

## C. Validation / Acceptance Gate

Checklist:

- `[ ] <check>`

Critical misses:

- `<condition that fails the package>`

Evidence required:

- `<file, command output, checklist result, or human record>`

Result format:

- `PASS`
- `PARTIAL_WITH_ISSUES`
- `FAIL`

Final response format:

```text
STATUS: PASS / PARTIAL_WITH_ISSUES / FAIL
Created:
- <files>
Updated:
- <files>
Validation:
- <check>: PASS/FAIL
Remaining issues:
- <issues or none>
Next allowed Build Package:
<Build Package>
```
