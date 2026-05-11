# Build Package 12C Operator Card Usability Checklist

Authored by: BP12C-IMPLEMENTATION-AGENT-R1.

Status: **IMPLEMENTATION_GATE**. This checklist defines the usability gate for BP12C operator cards.

## Purpose

Confirm a new operator can choose the correct AISRAF wrapper, identify accepted inputs, predict outputs, understand local-only boundaries, and see stop conditions without opening canonical prompt, skill, PRA, or adapter files.

## Gates

| # | Gate | Falsifiable Check | Status |
|---|---|---|---|
| U1 | Seven operator cards exist | One `.operator-card.md` file exists for each `.copilot-skills/aisraf-*.skill.md` wrapper. | REQUIRED |
| U2 | Role choice visible | Each card includes `Use This Role When`. | REQUIRED |
| U3 | Accepted input visible | Each card includes `Accepted Input` with concrete run paths or run-profile variables. | REQUIRED |
| U4 | Writes visible | Each card includes `Writes` with template-style `runs/{{run_id}}/` paths. | REQUIRED |
| U5 | Expected output visible | Each card includes `Output To Expect`. | REQUIRED |
| U6 | Local-only boundary visible | Each card includes `Local Only`. | REQUIRED |
| U7 | No-real-integration boundary visible | Each card includes `Not Real Integration Yet`. | REQUIRED |
| U8 | Stop behavior visible | Each card includes at least three stop-condition bullets from its canonical adapter. | REQUIRED |
| U9 | Plain-language line length | No operator-card line exceeds 140 characters. | REQUIRED |
| U10 | No wide tables | No operator-card table exceeds five columns. | REQUIRED |
| U11 | No unsupported execution claim | `tools/Test-AisrafBp12AReadiness.ps1` returns 0 FAIL after card installation. | REQUIRED |

## Acceptance Verdict

**PASS** when U1-U11 all pass and founder manual review accepts the cards as understandable.

## Stop Conditions

- Any card omits role, input, output, local-only, no-real-integration, or stop-condition sections.
- Any card hard-codes `RUN-001` as an output path instead of `runs/{{run_id}}/`.
- Any card claims runtime, cloud, ADK, MCP, Jira, Confluence, Rovo, database, Terraform, release, diagram, or external post-back execution.
- Any validator returns FAIL.
