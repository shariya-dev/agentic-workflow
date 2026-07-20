---
artifact: report-integration
phase: 70-review
owner: ai-drafts-human-owns-verdict
inputs: ["merged waves for <change-id>", "handover Dependencies/APIs/Events sections"]
outputs: [".ai/reports/<change-id>/report-integration.md"]
purpose: Verify modules compose — every declared dependency, API, and event actually connects.
validation: Verdict present; every finding has severity, location, recommendation; evidence section non-empty.
---

# Integration Review Report — <change-id>

**Verdict:** <PASS | PASS-WITH-NOTES | FAIL>

## Scope
<!-- Module boundaries exercised; contract pairs (provider ↔ consumer) checked. -->

## Findings
| # | Severity | Location | Finding | Recommendation |
|---|----------|----------|---------|----------------|
| 1 | <critical/major/minor> | <file:line> | | |

## Evidence
<!-- Integration runs, contract checks, event traces. -->
