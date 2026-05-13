# AISRAF Threat Intelligence Enrichment Plan

| Field | Value |
|---|---|
| Document | docs/THREAT-INTELLIGENCE-ENRICHMENT-PLAN.md |
| Authority | WP-12C-REL0-PRODUCT-FLOW-ADAPTER-ROADMAP-REBASE |
| Target release | v0.2.1 |
| Current release status | **Not implemented in v0.1.2.** Planning only. No online threat-intelligence execution is wired up in the current release-hardening branch. |
| Posture | Public source-available evaluation-only proof-of-concept. Not open source. Not production software. Not marketplace-published. |
| Out of scope | AL5 closed-loop autonomy. Any threat-intel item becoming a finding without human approval. |

## 1. Purpose

Threat Intelligence Enrichment is a planned AISRAF feature lane (v0.2.1). Its purpose is to enrich a security architecture review with **current** context from curated external sources, so that the review can call out:

- relevant Common Vulnerabilities and Exposures (CVEs) for the components and libraries in scope;
- exploited-in-the-wild signals for those components and libraries;
- vendor security advisories;
- architecture and security concerns for the named component/pattern;
- library and component threat context for the named version (where known).

Everything in this document is **planning material**. It is not implemented in v0.1.2 and is not active in the current release-hardening branch.

## 2. New Skill

The plan introduces a new skill:

- **Skill ID.** `SKL-THREAT-INTEL-CURRENT-CONTEXT`
- **Family.** RS (review skill family).
- **Status.** Planned; not authored in v0.1.2. Authoring is gated by a future governed skill update.
- **Consumers (planned).** The findings, recommendations, targeted questions, and handoff steps in the review chain may optionally consume threat-intel outputs once the skill is approved.

## 3. Purpose Statement (skill scope)

The skill uses curated current sources to enrich security architecture reviews with relevant vulnerabilities, exploited-in-the-wild signals, vendor advisories, and architecture/security concerns. It does not replace the review chain. It produces candidate evidence the human reviewer chooses to keep, reframe, or discard.

## 4. Allowed Sources

The skill is allowed to consult only these curated sources at v0.2.1:

- **NVD CVE API.** Authoritative CVE feed for matching component/version to CVE records.
- **CISA KEV (Known Exploited Vulnerabilities).** Authoritative exploited-in-the-wild signal.
- **Vendor security advisories.** Official advisories for the named vendor/product.
- **Official product documentation and security pages.** First-party documentation for the named product.

Optional later sources (require a separate governed approval before they are added):

- **GitHub Security Advisories.**
- **OSV (Open Source Vulnerabilities database).**

Forbidden sources at v0.2.1:

- Forums, mailing-list archives, social media, blog aggregators, and any source that is not first-party or curated.
- Any source that would require posting private ticket data or credentials to an external search.

## 5. Inputs

The skill consumes a structured input drawn from the current review:

- `component_name`
- `vendor`
- `product`
- `library_or_package`
- `version_if_known`
- `protocol` (e.g., HTTPS, gRPC, MQTT)
- `deployment_context` (e.g., on-prem, SaaS, hybrid)
- `data_classification`
- `exposure_or_boundary_crossing`
- `cloud_or_provider_context`
- `confidence_level`

Inputs are read from the run-profile, the review-table output, the security-stack assessment, and the missing-facts output. The skill must never ask the operator for credentials.

## 6. Outputs

The skill writes these governed Markdown outputs under `runs/<run_id>/threat-intel/` (path planned; final path is set by the v0.2.1 work package):

- `threat-intel-summary.md` — short narrative summary of what was retrieved and what is relevant.
- `cve-candidate-table.md` — CVE candidates matched to component/version/context.
- `exploited-vuln-check.md` — CISA KEV check result per component.
- `vendor-advisory-notes.md` — relevant vendor advisories, with publication date and applicability.
- `architecture-concern-notes.md` — architecture/security concerns surfaced for the named component or pattern (not CVEs).
- `targeted-security-questions.md` — questions for the design under review that follow from the retrieved evidence.
- `evidence/citation-ledger.md` — per-item source URL, retrieval date, retrieved hash (where applicable), and confidence.

## 7. Rules (hard rules)

1. **No automatic findings.** No internet result becomes a finding automatically. Findings remain in `13-findings.md` and require human approval before any threat-intel item enters that file.
2. **Version-aware CVE matching.** A CVE must match product, version, and context before it is treated as relevant. Generic product hits without a version match are tagged as candidates, not relevance claims.
3. **Unknown version handling.** If the version is unknown, the output is `candidate risk / needs version confirmation` and a targeted question is added.
4. **Source, date, confidence on every fact.** Every external fact carries source URL, retrieval date, and a confidence value. Facts without all three are dropped before they reach the operator.
5. **No private data sent externally.** No credentials, no private ticket data, no run-folder evidence beyond the structured input from section 5 is sent to any external search.
6. **Cache or ledger every lookup.** Lookup results are cached or recorded in a ledger for reproducibility. A re-run with the same inputs reuses the cache where the cache window allows.
7. **Human approval before promotion.** No threat-intel item becomes a finding, recommendation, or handoff content without the operator's explicit approval, recorded in `00-run-log.md`.
8. **No vendor name speculation.** If the vendor or product is ambiguous, the skill records `Unknown` rather than guessing.
9. **No exploit detail.** The skill must not author exploit code, weaponization steps, or payloads. It captures advisory references and recommended mitigations only.

## 8. Out Of Scope For This Plan

- AL5 closed-loop autonomy (no autonomous promotion of threat-intel items into findings).
- Any change to the v0.1.2 release-hardening branch behavior.
- Posting threat-intel findings to Jira/Confluence (those go through the Connected Review Flow gates in `docs/CONNECTED-REVIEW-FLOW-PLAN.md`).
- Marketplace publication.

## 9. References

- `docs/PRODUCT-FLOW-ROADMAP.md` — Flow 5 summary and how it sits next to the current flows.
- `docs/CONNECTED-REVIEW-FLOW-PLAN.md` — Connected Review Flow plan; relevant if threat-intel findings are eventually posted back.
- `docs/BRANCH-RELEASE-STRATEGY.md` — feature branch and tag names for v0.2.1.
- `validation/package-12c-rel0-product-flow-adapter-roadmap-rebase-report.md` — gate report that authorized this plan.
