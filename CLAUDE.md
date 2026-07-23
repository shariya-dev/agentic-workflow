# AEOS Project Instructions

This repository follows the **AEOS lifecycle**. Read this before doing anything.

## Prime Directives

1. **Never design while implementing. Never implement while designing.** The one
   exception is the Golden Module (phase 30), which is gated on both sides.
2. Every phase produces exactly one artifact, from its template in
   `aeos/templates/`, written to the location in the table below.
3. Human gates G0/G1/G2/G3 block phase transitions. A gate is passed only when a
   record exists at `.ai/reviews/<change-id>-g<n>.md` whose `Decision` is
   `APPROVED` or `APPROVED-WITH-CONDITIONS`.
4. Do not edit anything under `aeos/` during project work — it is the framework,
   synced from upstream AEOS.
5. **Not every change runs every phase.** Each change declares a `Change-Type`
   (`new-system` / `new-module` / `module-change` / `patch`) in its G0 record;
   that type selects which phases run and which project **foundation** (Golden
   Module, Engineering Guide, base architecture, base contracts, in
   `.ai/foundation/`) is reused rather than rebuilt. The Golden Module and
   Engineering Guide are built **once** per project. See
   `aeos/workflows/change-types.md`.

## Phase Write Permissions

In each phase you may write **only** to the locations listed:

| Phase | Command | May write to |
|-------|---------|--------------|
| **Stage 1 — Design** | | |
| Discovery | `/aeos:discover` | `.ai/idea.md` |
| Requirements (PRD) | `/aeos:requirements` | `openspec/changes/<id>/proposal.md` |
| Domain | `/aeos:domain` | `.ai/domain/<id>/` |
| Architecture | `/aeos:architecture` | `openspec/changes/<id>/` (design.md, spec deltas) |
| ADR | `/aeos:adr` | `.ai/adr/<id>/` |
| Guardrails | `/aeos:guardrails` | `.ai/foundation/engineering-guide.md` (+ per-change addendum) |
| **Stage 2 — Foundation** | | |
| Golden Module | `/aeos:golden` | source tree (reference module) + `.ai/foundation/golden-module.md` |
| Contracts | `/aeos:contracts` | `.ai/foundation/contracts.md` (base) or `.ai/contracts/<id>/` (delta) |
| Handover | `/aeos:handover` | `.ai/handovers/<id>/` |
| Tasks | `/aeos:tasks` | `.ai/blueprint/<id>/` + `openspec/changes/<id>/` (tasks.md, tasks/) |
| **Stage 3 — Build** | | |
| Implementation | `/aeos:implement` (orchestrator) | source tree, within one task's declared module scope |
| Testing / Review | `/aeos:report`, `/aeos:review` | `.ai/reports/<id>/` |
| Documentation | `/aeos:docs` | `.ai/reports/<id>/documentation.md` |
| Gate records | (human records) | `.ai/reviews/` |

## Gate Rules

- **G0** (after Discovery): product owner decides "worth building?" — blocks Requirements.
- **G1** (after Guardrails): architect approves the whole design — blocks the
  Golden Module. Last point before any code.
- **G2** (after Tasks): tech lead approves the golden module + contracts +
  handovers + tasks — blocks ALL parallel agent spawning.
- **G3** (after reports): release owner decides ship/no-ship — blocks docs,
  deployment, and archive.

Before starting any phase, check the preceding gate record exists. If it does
not, stop and tell the human which gate is missing.

## Where Things Live

- Phase prompts: `aeos/prompts/` · Artifact templates: `aeos/templates/`
- Phase registry: `aeos/workflows/phases.md` · Gates: `aeos/workflows/gates.md`
  · Change types & right-sizing: `aeos/workflows/change-types.md`
- Project foundation (built once, reused): `.ai/foundation/`
- Engineering guide: `aeos/guide/` (+ adapter overrides in `aeos/adapters/`)
- Current-truth specs: `openspec/specs/` · Active changes: `openspec/changes/`
- Workspace artifacts: `.ai/`
