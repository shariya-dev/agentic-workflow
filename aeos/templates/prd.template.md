---
artifact: prd
phase: 05-requirements
owner: ai
inputs: [".ai/idea.md", "openspec/specs/"]
outputs: ["openspec/changes/<change-id>/proposal.md"]
purpose: A complete, unambiguous product requirements document that is also an OpenSpec-valid change proposal.
validation: Functional and non-functional requirements separated; every user story has testable acceptance criteria; why/what-changes/impact present; openspec validate passes.
---

# PRD / Proposal: <change-id>

## Why
<!-- The problem and the business reason to build it. Traceable to .ai/idea.md. -->

## What Changes
<!-- The capabilities being added or changed, at requirement level (not design). -->

## Functional Requirements
<!-- Numbered, each independently verifiable. FR-1, FR-2, … -->

## Non-Functional Requirements
<!-- Performance, security, availability, compliance budgets. NFR-1, NFR-2, … -->

## User Stories
<!-- As a <role>, I want <goal>, so that <benefit>. One per capability. -->

## Acceptance Criteria
<!-- Per story: Given/When/Then, testable. -->

## Assumptions
<!-- Stated assumptions that, if wrong, change the requirements. -->

## Edge Cases
<!-- Boundary and error conditions to handle. -->

## Out of Scope
<!-- Explicitly not in this change. -->

## Impact
<!-- Which existing specs/capabilities this touches (for openspec). -->
