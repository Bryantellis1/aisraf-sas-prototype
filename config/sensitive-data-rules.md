# Sensitive Data Rules

Package: AISRAF SAS Prototype v0.1.2
Owning Build Package: Build Package 02.
Schema authority: [config/run-profile.schema.yaml](run-profile.schema.yaml)

This document defines what cannot be stored in any run-profile field, run log, sample input, expected baseline, prompt card, skill contract, PRA spec, adapter wrapper, catalog entry, blueprint, template, diagram source, doc, or release artifact created within this package.

The prohibition is absolute. There is no "low-risk" exception. The rules apply to operator-edited fields, tool-derived fields, free-text notes, URL fields, and any future field added to the schema.

## 1. Categorically prohibited

The following must never appear in any package artifact:

### 1.1 Credentials and secrets

- API keys (Jira, Confluence, Atlassian, Rovo, GitHub, Azure DevOps, Azure, GCP, AWS, OpenAI, Anthropic, third-party).
- Personal access tokens (PAT) of any kind.
- OAuth client secrets, refresh tokens, ID tokens, JWTs.
- Session cookies, CSRF tokens, signed URLs that include credentials.
- Passwords and passphrases.
- SSH private keys (`BEGIN RSA PRIVATE KEY`, `BEGIN OPENSSH PRIVATE KEY`, `BEGIN EC PRIVATE KEY`).
- TLS private keys.
- Cryptographic key material of any kind.
- Database connection strings carrying credentials.
- Service account JSON files.

### 1.2 Real PII

- Real customer names tied to a real account.
- Real customer email addresses, phone numbers, postal addresses.
- Government identifiers (SSN, SIN, national ID, passport number, driver's license).
- Real birth dates of real customers.
- Real geo-coordinates of customer locations.

### 1.3 Real payment-card and financial data

- Primary Account Number (PAN) — any 13-to-19-digit card number.
- CVV, CVC, CV2.
- Track 1 / Track 2 magnetic stripe data.
- Real bank account numbers and routing numbers.

### 1.4 Customer secrets

- Internal customer account IDs from production systems.
- Internal vendor account IDs.
- Customer-specific configuration that is not synthetic.
- Customer-specific design documents that are not redacted to synthetic form.

### 1.5 Production endpoints

- Hostnames of production systems unless explicitly approved.
- Internal load balancer URLs.
- Internal admin consoles.
- Internal monitoring dashboards.

There is no production-endpoint allow-list at present. Adding one requires a founder gate.

### 1.6 Unredacted Class 5 payloads

- Real Class 5 data of any kind, per the AISRAF data-class model. Sample inputs may carry Class 5 markers (`C5`, `C5P`, `C5E1P`, etc.) as labels, but no real Class 5 payload may be stored anywhere in the package.

## 2. URL hygiene

URLs in `source_ticket_url`, `destination_ticket_url`, `destination_confluence_url`, and any future URL field:

- Use `https://` scheme.
- Carry no query string parameters that include credentials.
- Carry no fragments that include credentials.
- Use canonical hostnames; no `localhost`, no private IPs, no `.onion`.
- Match the schema regex `^(|https://[^?#\s]+)$`.

## 3. Prohibited substrings (lint targets)

A Build Package 12 lint scans every string field for these substrings and patterns. A match stops the run:

- `Bearer ` (case-insensitive).
- `Authorization:`.
- `x-api-key:`, `X-Api-Key:`, `apikey:`.
- `?token=`, `&token=`.
- `?api_key=`, `&api_key=`.
- `?password=`, `&password=`.
- `?secret=`, `&secret=`.
- `?key=`, `&key=` (when the value looks like a token).
- `BEGIN RSA PRIVATE KEY`, `BEGIN OPENSSH PRIVATE KEY`, `BEGIN EC PRIVATE KEY`, `BEGIN PRIVATE KEY`.
- `AWS_SECRET`, `AWS_ACCESS_KEY_ID`, `AWS_SESSION_TOKEN`.
- `GOOGLE_APPLICATION_CREDENTIALS` value embedded inline.
- Anthropic, OpenAI key prefixes (`sk-`, `xoxb-`, `xoxp-`, etc.) when followed by a long random suffix.

## 4. Prohibited patterns (regex targets)

- 13-to-19 contiguous digits (PAN-shaped) anywhere in any field.
- `\d{3}-\d{2}-\d{4}` (US SSN-shaped).
- 32-or-more contiguous hex characters preceded by an `=` (likely token).
- 40-or-more contiguous base64 characters preceded by an `=` (likely token).

## 5. Identity field rules

`operator_name` and `reviewer_name` carry role labels or short display names. They must NOT carry:

- Full legal names tied to real customer accounts.
- Customer email addresses.
- Customer phone numbers.
- Internal employee email addresses that are sensitive.

Preferred values: `SAS reviewer`, `Local operator`, `AppSec reviewer`, `GRC partner`, `Security Architect`, founder role labels.

## 6. Notes field rule

`notes` is free text but the prohibition above applies. Notes are scanned by the same lint. If an operator needs to record a sensitive discovery, the right place is an out-of-band note in a controlled location, not the run profile.

## 7. Sample-input rule

Synthetic samples (`samples/<sample_id>/inputs/`) must satisfy the same prohibition. Build Package 10 (Samples and expected baselines) enforces this for all input files. The `prototype_data_safety_rule` declared in the v0.01 reference workspace is the inspiration; the v0.1.2 rule is restated here so it survives the rebuild.

## 8. Sensitive-data confirmation

The operator confirms compliance by setting `sensitive_data_confirmed_redacted: true` in the run profile before any run begins. The schema requires this constant to be `true` (the template ships `false` so the operator is forced to make the confirmation explicit).

A run that begins without the confirmation is a critical miss enforced by Build Packages 03 and 12.

## 9. What to do when a violation is detected

1. Stop the run immediately.
2. Remove the offending value from every artifact in the package and any cached run output.
3. Record the incident in a separate out-of-band note (not in the package).
4. Rotate any leaked credential outside this package.
5. Re-run the sensitive-data lint to confirm the violation is gone.
6. Resume only after the lint is clean and `sensitive_data_confirmed_redacted: true` is honest.

Bypassing any of these steps is forbidden by [validation/no-drift-rules.md](../validation/no-drift-rules.md).
