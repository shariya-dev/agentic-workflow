---
artifact: report-release-readiness
phase: 70-review
owner: ai-drafts-human-owns-verdict
inputs: [".ai/reports/<change-id>/report-code-review.md", "report-security.md", "report-performance.md", "report-integration.md", "report-test-coverage.md"]
outputs: [".ai/reports/<change-id>/report-release-readiness.md"]
purpose: Aggregate the five reports into a single go/no-go input for gate G2.
validation: All five source reports linked with their verdicts; overall verdict present; open risks listed.
---

# Release Readiness Report — <change-id>

**Verdict:** <PASS | PASS-WITH-NOTES | FAIL>

## Source Reports
| Report | Verdict |
|--------|---------|
| Code Review | |
| Security | |
| Performance | |
| Integration | |
| Test Coverage | |

## Open Risks
<!-- Anything shipping anyway, and why. -->

## Rollback Plan
<!-- How to undo this release if it fails. -->

## Evidence
<!-- Deployment dry-run, migration check, config diff. -->
