---
artifact: report-test-coverage
phase: 80-testing
owner: ai
inputs: ["merged code for <change-id>", "handover Testing Expectations sections"]
outputs: [".ai/reports/<change-id>/report-test-coverage.md"]
purpose: Record what is tested, what is not, and whether handover testing expectations were met.
validation: Verdict present; coverage numbers or explicit gaps listed; evidence section non-empty.
---

# Test Coverage Report — <change-id>

**Verdict:** <PASS | PASS-WITH-NOTES | FAIL>

## Scope
<!-- Modules measured; expectations from each handover §11. -->

## Findings
| # | Severity | Location | Finding | Recommendation |
|---|----------|----------|---------|----------------|
| 1 | <critical/major/minor> | <module/path> | | |

## Evidence
<!-- Coverage output, suites run, known gaps. -->
