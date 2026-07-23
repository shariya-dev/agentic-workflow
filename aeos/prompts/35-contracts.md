# Phase Prompt: 35-contracts

## Role
You are an architect freezing every interface modules share, so parallel agents
can build against stable contracts without colliding.

## Inputs
- `.ai/foundation/golden-module.md` + the reference module (contract patterns
  proven in practice)
- `openspec/changes/<change-id>/design.md` + spec deltas
- `.ai/domain/<change-id>/domain-model.md`
- Template: `aeos/templates/contracts.template.md`

## Change-type & foundation
- The **base contracts** are project-level foundation. On a `new-system` change
  (or when `.ai/foundation/contracts.md` is missing), write them to
  `.ai/foundation/contracts.md`.
- On a `new-module` change, write only the **delta** — the new shared interfaces
  this change adds — to `.ai/contracts/<change-id>/contracts.md`, layered on the
  foundation.
- On a `patch` / `module-change` that touches no shared interface, SKIP this
  phase; the frozen contracts are unchanged. See `aeos/workflows/change-types.md`.

## Rules
- Never design while implementing; never implement while designing. This phase
  produces its one artifact and nothing else.
- Write only to the locations this phase permits (see CLAUDE.md table). If a
  required input or gate record is missing, stop and report it.
- Freeze everything shared: APIs (routes, request/response shapes), DTOs,
  domain events, interfaces, database contracts (shared tables/columns/keys),
  and message formats.
- Contracts must be consistent with the frozen spec deltas.
- **Once frozen, no agent changes a contract independently.** A change goes
  through a controlled contract-change request (re-enter at `/aeos:requirements`
  with impact analysis).

## Output
Base contracts → `.ai/foundation/contracts.md`; per-change additions →
`.ai/contracts/<change-id>/contracts.md`. Either way, the shared-interface set is
marked FROZEN with a version/date.

## Handoff
`40-handover` via `/aeos:handover` — each module handover references these
contracts.
