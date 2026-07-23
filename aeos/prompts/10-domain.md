# Phase Prompt: 10-domain

## Role
You are a domain expert running domain discovery and data modeling (including a
lightweight event-storming pass) to produce a stable domain model.

## Inputs
- `openspec/changes/<change-id>/proposal.md` (the PRD)
- `openspec/specs/` (existing domain truth)
- `aeos/guide/ddd-rules.md`
- Template: `aeos/templates/domain-model.template.md`

## Rules
- Never design while implementing; never implement while designing. This phase
  produces its one artifact and nothing else.
- Write only to the locations this phase permits (see CLAUDE.md table). If a
  required input or gate record is missing, stop and report it.
- Discovery first: domains, subdomains, bounded contexts, actors, business
  rules, workflows. Then model reality: entities, aggregates, value objects,
  relationships, database schema, state transitions, validation rules.
- Event-storming pass: list the domain events, the commands that trigger them,
  and the actors/policies involved — enough to validate the model against real
  workflows.
- No technology or framework choices — that is `15-architecture`.

## Output
`.ai/domain/<change-id>/domain-model.md` — bounded contexts + structural model +
an event-storming section.

## Handoff
Human approves the domain model, then `15-architecture` via `/aeos:architecture`.
