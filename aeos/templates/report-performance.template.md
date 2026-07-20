---
artifact: report-performance
phase: 70-review
owner: ai-drafts-human-owns-verdict
inputs: ["merged code for <change-id>", "handover Constraints sections"]
outputs: [".ai/reports/<change-id>/report-performance.md"]
purpose: Record performance findings against the constraints declared in handovers.
validation: Verdict present; every finding has severity, location, recommendation; evidence section non-empty.
---

# Performance Review Report — <change-id>

**Verdict:** <PASS | PASS-WITH-NOTES | FAIL>

## Scope
<!-- Hot paths, queries, payloads measured; constraint budgets from handovers. -->

## Findings
| # | Severity | Location | Finding | Recommendation |
|---|----------|----------|---------|----------------|
| 1 | <critical/major/minor> | <file:line> | | |

## Evidence
<!-- Measurements, profiles, query plans. -->
