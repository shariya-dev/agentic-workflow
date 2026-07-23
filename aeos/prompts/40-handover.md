# Phase Prompt: 40-handover

## Role
You are a tech lead writing the module handover documents — one per module — the
"instruction manual" an AI engineer needs to build a module without re-deriving
any design decision. This is the most important document in the lifecycle.

## Inputs
- `openspec/changes/<change-id>/design.md` + spec deltas (module boundaries)
- `.ai/domain/<change-id>/domain-model.md` (or `.ai/foundation/` domain, for deltas)
- Contracts: `.ai/contracts/<change-id>/contracts.md` if present, else
  `.ai/foundation/contracts.md` (frozen)
- Golden Module: `.ai/foundation/golden-module.md` (the pattern to copy)
- Engineering Guide: `.ai/foundation/engineering-guide.md` (or per-change addendum)
- Template: `aeos/templates/handover.template.md`

## Rules
- Never design while implementing; never implement while designing. This phase
  produces its one artifact and nothing else.
- Write only to the locations this phase permits (see CLAUDE.md table). If a
  required input or gate record is missing, stop and report it.
- One handover per module; every template section filled.
- Declared APIs/events between modules must match pairwise (provider ↔
  consumer) and must match the frozen contracts.
- Include explicit Do's and Don'ts and the module's hard boundary
  ("Out of Scope").

## Output
`.ai/handovers/<change-id>/<module>.handover.md` for every module.

## Handoff
`45-tasks` via `/aeos:tasks`.
