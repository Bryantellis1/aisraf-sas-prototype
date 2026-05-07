# Path Resolution Rules

Package: AISRAF SAS Prototype v0.1.2
Owning Build Package: Build Package 02.
Schema authority: [config/run-profile.schema.yaml](run-profile.schema.yaml)

This document defines how relative paths declared in `runs/<run_id>/run-profile.yaml` resolve from the active workspace root, and how later Build Packages must avoid hardcoded paths.

## 1. Workspace root

`workspace_root` is `.` and resolves to the active workspace root:

```
D:\E-Way 2\AISRAF- SAS Prototype v0.1.2
```

Every relative path in the run profile resolves from this root. Tools and validators must compute the absolute path by joining `workspace_root` with the relative path field. Operators must not hardcode the absolute path in any later artifact.

The old reference workspace at `D:/E-Way 2/aisraf-sas-prototype-skill-chain-pack-v0.01` is named in `old_reference_workspace` for traceability only. Tools, prompts, skills, PRAs, samples, runs, validators, diagrams, docs, and release artifacts must not write to that workspace.

## 2. Path fields

| field | resolves to | example |
|---|---|---|
| `workspace_root` | active workspace root | `.` → `D:\E-Way 2\AISRAF- SAS Prototype v0.1.2` |
| `input_root` | `<workspace_root>/<input_root>` | `runs/RUN-001/inputs` → `D:\E-Way 2\AISRAF- SAS Prototype v0.1.2\runs\RUN-001\inputs` |
| `expected_root` | `<workspace_root>/<expected_root>` | `samples/sample-001-dfd-crop/expected` → `D:\E-Way 2\AISRAF- SAS Prototype v0.1.2\samples\sample-001-dfd-crop\expected` |
| `output_root` | `<workspace_root>/<output_root>` | `runs/RUN-001` → `D:\E-Way 2\AISRAF- SAS Prototype v0.1.2\runs\RUN-001` |
| `old_reference_workspace` | absolute path constant | `D:/E-Way 2/aisraf-sas-prototype-skill-chain-pack-v0.01` |

## 3. Allowed and disallowed forms

Allowed in `input_root`, `expected_root`, `output_root`:

- Forward-slash relative path segments (`runs/RUN-001/inputs`).
- Lowercase folder names matching the canonical workspace layout.
- Empty string for `expected_root` only when `expected_baseline_required: false`.

Disallowed:

- Parent traversal segments (`..`, `../foo`, `runs/../etc`).
- Drive letters (`C:`, `D:`, `D:/E-Way 2/...`).
- Leading `/` (POSIX absolute path).
- Backslash separators in YAML values; the schema regex uses forward slashes. Tools normalise Windows paths to forward slashes when writing the run profile.
- Symlink targets that resolve outside the workspace.

The schema enforces these via its `pattern` rules. See [config/run-profile.schema.yaml](run-profile.schema.yaml) and [config/run-profile.validation-rules.md](run-profile.validation-rules.md) Check 4.

## 4. Output write-boundary

All run output writes must land under the resolved `output_root` (`runs/<run_id>/`). Concretely:

- Prompt cards (Build Package 04) write step outputs to `<output_root>/01-input-inventory.md`, `<output_root>/02-...`, etc.
- Skill contracts (Build Package 05) declare their outputs as `{{output_root}}/...`.
- Run logs (Build Package 11) write to `<output_root>/00-run-log.md`.
- Scoring artifacts (Build Package 12) write to `<output_root>/17-accuracy-score.md`.
- Diagrams generated for a specific run land under `<output_root>/diagrams/`, never under the package-source `diagrams/` folder (Build Package 13).

A write outside `<output_root>` is a critical miss enforced by Build Package 11.

## 5. Read-boundary for inputs and expected baselines

- Prompts and skills read inputs from `<input_root>` only. Prompts must not read directly from Jira, Confluence, MCP, or any external source at run time. External material is staged into `<input_root>` before any prompt card or skill executes.
- Prompts and skills read expected baselines from `<expected_root>` only when scoring is active. Expected baselines must not be edited during a run.

## 6. Windows path examples

The active workspace path on the founder's machine is `D:\E-Way 2\AISRAF- SAS Prototype v0.1.2`. PowerShell-friendly resolution examples:

| field | YAML value | resolved Windows path |
|---|---|---|
| `input_root` | `runs/RUN-001/inputs` | `D:\E-Way 2\AISRAF- SAS Prototype v0.1.2\runs\RUN-001\inputs` |
| `expected_root` | `samples/sample-001-dfd-crop/expected` | `D:\E-Way 2\AISRAF- SAS Prototype v0.1.2\samples\sample-001-dfd-crop\expected` |
| `output_root` | `runs/RUN-001` | `D:\E-Way 2\AISRAF- SAS Prototype v0.1.2\runs\RUN-001` |
| `old_reference_workspace` | `D:/E-Way 2/aisraf-sas-prototype-skill-chain-pack-v0.01` | `D:\E-Way 2\aisraf-sas-prototype-skill-chain-pack-v0.01` (read-only) |

When Build Package 03 tools join workspace_root with a run-profile relative path, they normalise the result to the host OS separator. YAML values stay forward-slash so the schema regex applies cleanly.

## 7. No hardcoded paths in later Build Packages

Later Build Packages must consume run-profile fields by name, not by hardcoded literal:

- Prompt cards reference `{{input_root}}`, `{{expected_root}}`, `{{output_root}}`, `{{run_id}}`, `{{sample_id}}` — never a literal `runs/RUN-001/...`.
- Skill contracts reference the same `{{...}}` set.
- PRA specs and `.agent.md` adapters inherit from prompts and skills; they do not invent their own path literals.
- Templates declare reusable shapes that include `{{output_root}}/`-prefixed paths only.
- Sample inputs live under `samples/<sample_id>/inputs/`. Tools copy them into `runs/<run_id>/inputs/` before execution.
- Run outputs live only under `runs/<run_id>/` per the resolved `output_root`.

A literal `runs/RUN-001/` written into any Build Package 04–16 artifact is a path-drift defect and must be replaced with the resolved variable reference.
