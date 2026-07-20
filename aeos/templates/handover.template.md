---
artifact: handover
phase: 40-handover
owner: ai
inputs: [".ai/blueprint/<change-id>/blueprint.md"]
outputs: [".ai/handovers/<change-id>/<module>.handover.md"]
purpose: Give one implementation agent everything it needs to build one module without re-deriving design decisions.
validation: All 11 sections non-empty; every dependency names another module or external system; every acceptance criterion is testable.
---

# Module Handover: <module-name>

> Change: `<change-id>` · Blueprint: `.ai/blueprint/<change-id>/blueprint.md`

## 1. Module Purpose
<!-- One paragraph: why this module exists. -->

## 2. Scope
**In scope:**
**Out of scope:**

## 3. Requirements
<!-- Numbered functional requirements, traceable to design.md. -->

## 4. Business Rules
<!-- Invariants that must always hold. -->

## 5. Dependencies
<!-- Other modules / external systems this module consumes, and what it provides to others. -->

## 6. APIs
<!-- Endpoints / interfaces this module exposes: route, verb, request, response. -->

## 7. Events
<!-- Events published and consumed: name, payload, trigger. -->

## 8. Database
<!-- Tables/collections owned by this module. Schema sketch. No other module writes here. -->

## 9. Constraints
<!-- Performance, security, compliance, technology constraints. -->

## 10. Acceptance Criteria
<!-- Checkbox list; each criterion independently verifiable. -->

## 11. Testing Expectations
<!-- Required test types and critical paths that must be covered. -->
