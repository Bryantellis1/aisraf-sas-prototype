# Security Policy

This document describes the security posture of AISRAF v0.1.2 and how to report a security issue.

## 1. Local-First Security Posture

AISRAF v0.1.2 is a local-first AL2 controlled-output workbench. It does not contact external services. It does not publish data to Jira, Confluence, Lucidchart, MCP servers, cloud runtimes, databases, Terraform pipelines, event buses, or telemetry backends. There is no post-back execution.

All inputs and outputs are local files under approved run folders. The plugin and its agents run inside your provider surface (VS Code Local plugin list, GitHub Copilot agent dropdown, or Copilot CLI) with no network egress beyond what your provider already performs for its own model calls.

Hooks enforce path guards before each write and run focused validators after each write. Canonical surfaces (`prompts/`, `skills/`, `prototype-agents/`, `catalogs/`, `blueprints/`, `templates/`, `config/`, `samples/`, `runs/RUN-001/`) and provider projections are not mutated by a review run.

## 2. Sensitive Data Rules

The full sensitive-data rules are documented in `config/sensitive-data-rules.md`. Summary:

- Do not place customer data, production secrets, production credentials, internal hostnames, or production endpoints in run profiles, sample inputs, or run inputs.
- Do not include API keys, tokens, passwords, connection strings, private certificates, or PII in any input file.
- The run-profile validator (`tools/Test-AisrafRunProfile.ps1`) screens run-profile string fields against a prohibited-substring set and refuses runs where prohibited substrings are present.
- Operators must affirm sensitive-data redaction by setting `sensitive_data_confirmed: true` in the run profile before the run is execution-ready.
- Public examples (`samples/sample-001-dfd-crop/`) are synthetic. They contain no customer PII, no real credentials, and no live endpoints.

If you discover sensitive data accidentally placed in a sample, run, or commit, treat it as a security incident: rotate any exposed credentials, remove the data from your local checkout, and avoid pushing the affected commit.

## 3. No Secrets In Run Profiles

Run profiles are version-controllable governance artifacts. They must never carry secrets:

- No API keys.
- No tokens.
- No passwords.
- No connection strings with embedded credentials.
- No private certificates or private keys.

Use environment variables, your provider's secret store, or your local OS keychain for any credential a future adapter might need. Future AL4 adapter work packages will define their own credential model; v0.1.2 does not require any credentials because it does not perform external execution.

## 4. No Live Post-Back

v0.1.2 does not post results to any external system. The handoff pack (`15-handoff-pack.md`) and any optional Jira/Confluence draft files are local Markdown drafts only. There is no automated publication path. The operator hands off the local files to their usual review channels manually.

If a future AL4 adapter is published, it will be its own work package, with its own QA and release-gate evidence, and will be opt-in per run.

## 5. No Customer PII In Public Examples

Public examples shipped under `samples/` are synthetic. They must remain free of:

- Customer names, account identifiers, or relationship identifiers.
- Real production endpoints or hostnames.
- Real credentials, tokens, or keys.
- Internal-only system names, code names, or product names that are not already public.
- Personal identifiers of any operator, contributor, or reviewer.

Contributors who add or modify samples must verify that the inputs and expected baselines are synthetic before any commit.

## 6. Reporting A Security Issue

If you find a security issue in AISRAF v0.1.2, please do not file it as a public issue. Instead:

1. Contact the maintainer privately. The maintainer contact channel is currently the project owner; until a public security contact is published, route security reports through the same channel you use for governed work-package coordination.
2. Provide a clear description of the issue, the affected files or surfaces, and the steps to reproduce.
3. Indicate the impact: data exposure, code execution, integrity violation of a canonical or projection surface, validator bypass, or other.
4. Wait for acknowledgement before public disclosure.

Until a formal CVE / advisory channel is published with the public release, treat AISRAF security communication as governed and private.

## 7. Validator-Backed Boundary

Two validator-enforced boundaries protect this security posture in v0.1.2:

- **Path guard.** `tools/hooks/aisraf-allowed-path-prewrite-guard.ps1` blocks writes outside approved scratch run folders.
- **Plugin bundle integrity.** `Test-AisrafPackage.ps1` Check 16b verifies SHA-256 source/target hash equality across every bundled file. A modified bundle file that does not match its canonical source is a closed FAIL.
