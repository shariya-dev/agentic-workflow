---
artifact: report-code-review
phase: 70-review
owner: ai-drafts-human-owns-verdict
inputs: ["reviewed branches / merged waves for <change-id>"]
outputs: [".ai/reports/<change-id>/report-code-review.md"]
purpose: Record code quality findings and a merge verdict for the change.
validation: Verdict present; every finding has severity, location, recommendation; evidence section non-empty.
---

# Code Review Report — <change-id>

**Verdict:** <PASS | PASS-WITH-NOTES | FAIL>

## Scope
<!-- Branches / waves / modules reviewed. Standards applied: aeos/guide/review-rules.md + adapter overrides. -->

## Findings
| # | Severity | Location | Finding | Recommendation |
|---|----------|----------|---------|----------------|
| 1 | <critical/major/minor> | <file:line> | | |

## Evidence
<!-- Commands run, diffs inspected, checklists applied. -->
