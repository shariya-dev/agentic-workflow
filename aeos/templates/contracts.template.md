---
artifact: contracts
phase: 35-contracts
owner: ai
inputs: [".ai/foundation/golden-module.md", "openspec/changes/<change-id>/design.md", ".ai/domain/<change-id>/domain-model.md"]
outputs: [".ai/foundation/contracts.md (base) or .ai/contracts/<change-id>/contracts.md (delta)"]
purpose: The frozen set of interfaces modules share, so parallel agents build against stable contracts.
validation: Every shared API/DTO/event/interface/DB-contract/message listed; marked FROZEN with version+date; consistent with spec deltas.
---

# Contracts (FROZEN): <change-id>

- **Status:** FROZEN
- **Version:** v1
- **Date:** <YYYY-MM-DD>

> Once frozen, no agent changes a contract independently. A change goes through a
> controlled contract-change request: re-enter at `/aeos:requirements` with an
> impact-analysis note.

## APIs
<!-- Shared routes: method, path, request shape, response shape, status codes. -->

## DTOs
<!-- Shared data-transfer objects: fields and types. -->

## Domain Events
<!-- name, payload schema, publisher, subscribers. -->

## Interfaces
<!-- Shared interfaces/ports and their method signatures. -->

## Database Contracts
<!-- Shared tables/columns/keys other modules read (but do not own). -->

## Message Formats
<!-- Queue/message payloads and their schemas. -->
