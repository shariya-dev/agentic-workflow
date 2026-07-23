---
artifact: domain-model
phase: 10-domain
owner: ai
inputs: ["openspec/changes/<change-id>/proposal.md", "openspec/specs/"]
outputs: [".ai/domain/<change-id>/domain-model.md"]
purpose: A stable domain model — bounded contexts, structural model, and an event-storming pass — before any technology is chosen.
validation: Every bounded context has actors and rules; every aggregate has an invariant; the event-storming section lists events with their triggering commands.
---

# Domain Model: <change-id>

## Bounded Contexts
<!-- Domains / subdomains / bounded contexts and their responsibilities. -->

## Actors
<!-- Who or what interacts with the system. -->

## Business Rules
<!-- Invariants and policies that must always hold. -->

## Workflows
<!-- The key business workflows, described as steps. -->

## Entities & Aggregates
<!-- Entities, aggregate roots, and what each aggregate protects. -->

## Value Objects
<!-- Immutable value types and their validation. -->

## Relationships
<!-- How entities/aggregates relate. -->

## Data Schema (logical)
<!-- Tables/collections, key fields, keys and relationships. No engine specifics. -->

## State Transitions
<!-- For stateful entities: states and allowed transitions. -->

## Validation Rules
<!-- Field- and rule-level validation. -->

## Event Storming
<!-- Domain events, the commands that trigger them, and the actors/policies involved. -->
| Event | Triggered by (command) | Actor/Policy |
|-------|------------------------|--------------|
