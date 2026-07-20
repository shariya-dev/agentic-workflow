---
artifact: report-security
phase: 70-review
owner: ai-drafts-human-owns-verdict
inputs: ["merged code for <change-id>", "handover Constraints sections"]
outputs: [".ai/reports/<change-id>/report-security.md"]
purpose: Record security findings and a ship-safety verdict for the change.
validation: Verdict present; every finding has severity, location, recommendation; evidence section non-empty.
---

# Security Review Report — <change-id>

**Verdict:** <PASS | PASS-WITH-NOTES | FAIL>

## Scope
<!-- Attack surfaces reviewed: authn/z, input handling, secrets, dependencies, data exposure. -->

## Findings
| # | Severity | Location | Finding | Recommendation |
|---|----------|----------|---------|----------------|
| 1 | <critical/major/minor> | <file:line> | | |

## Evidence
<!-- Scans run, configs inspected, threat cases exercised. -->
