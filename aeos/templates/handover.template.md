---
artifact: handover
phase: 40-handover
owner: ai
inputs: ["openspec/changes/<change-id>/design.md", ".ai/domain/<change-id>/domain-model.md", ".ai/contracts/<change-id>/contracts.md", ".ai/golden/<change-id>/golden-module.md", ".ai/engineering-guide/<change-id>.md"]
outputs: [".ai/handovers/<change-id>/<module>.handover.md"]
purpose: The instruction manual one AI engineer needs to build one module without re-deriving any design decision.
validation: Every section non-empty; APIs/events match the frozen contracts; Do's/Don'ts and Out-of-Scope present; every acceptance criterion is testable.
---

# Module Handover: <module-name>

> Change: `<change-id>` · Contracts: `.ai/contracts/<change-id>/contracts.md` ·
> Golden Module: `.ai/golden/<change-id>/golden-module.md`

## 1. Business Goal
<!-- One paragraph: why this module exists and the value it delivers. -->

## 2. Requirements
<!-- Numbered functional requirements for this module, traceable to the PRD/design. -->

## 3. Use Cases
<!-- The user/system interactions this module supports. -->

## 4. Acceptance Criteria
<!-- Checkbox list; each criterion independently verifiable. -->

## 5. Database Design
<!-- Tables/collections OWNED by this module. Schema. No other module writes here. -->

## 6. APIs
<!-- Endpoints this module exposes: route, verb, request, response. Must match contracts. -->

## 7. Events
<!-- Events published and consumed: name, payload, trigger. Must match contracts. -->

## 8. Dependencies
<!-- Other modules / external systems this consumes, and what it provides. -->

## 9. Constraints
<!-- Performance, security, compliance, technology constraints. -->

## 10. Coding Rules
<!-- Module-specific rules on top of the engineering guide. Reference the Golden Module. -->

## 11. Testing Requirements
<!-- Required test types and critical paths that must be covered. -->

## 12. Do's and Don'ts
**Do:**
**Don't:**

## 13. Out of Scope
<!-- The hard boundary. Files/areas this module must NOT touch. -->
