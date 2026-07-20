# AEOS Project Instructions

This repository follows the **AEOS lifecycle**. Read this before doing anything.

## Prime Directives

1. **Never design while implementing. Never implement while designing.**
2. Every phase produces exactly one artifact, from its template in
   `aeos/templates/`, written to the location in the table below.
3. Human gates G0/G1/G2 block phase transitions. A gate is passed only when a
   record exists at `.ai/reviews/<change-id>-g<n>.md` whose `Decision` is
   `APPROVED` or `APPROVED-WITH-CONDITIONS`.
4. Do not edit anything under `aeos/` during project work — it is the framework,
   synced from upstream AEOS.

## Phase Write Permissions

In each phase you may write **only** to the locations listed:

| Phase | Command | May write to |
|-------|---------|--------------|
| Discovery | `/aeos:discover` | `.ai/idea.md` |
| Proposal | `/aeos:propose` | `openspec/changes/<id>/proposal.md` |
| Design | `/aeos:design` | `openspec/changes/<id>/` (design.md, spec deltas) |
| Blueprint | `/aeos:blueprint` | `.ai/blueprint/<id>/` |
| Handover | `/aeos:handover` | `.ai/handovers/<id>/` |
| Tasks | `/aeos:tasks` | `openspec/changes/<id>/` (tasks.md, tasks/) |
| Implementation | (orchestrator) | source tree, within one task's declared module scope |
| Review / Reports | `/aeos:review`, `/aeos:report` | `.ai/reports/<id>/` |
| Gate records | (human records) | `.ai/reviews/` |

## Gate Rules

- **G0** (after Discovery): product owner decides "worth speccing?" — blocks Proposal.
- **G1** (after Tasks): tech lead approves scope + architecture — blocks ALL
  Stage 2 agent spawning.
- **G2** (after reports): release owner decides ship/no-ship — blocks deployment.

Before starting any phase, check the preceding gate record exists. If it does
not, stop and tell the human which gate is missing.

## Where Things Live

- Phase prompts: `aeos/prompts/` · Artifact templates: `aeos/templates/`
- Phase registry: `aeos/workflows/phases.md` · Gates: `aeos/workflows/gates.md`
- Engineering guide: `aeos/guide/` (+ adapter overrides in `aeos/adapters/`)
- Current-truth specs: `openspec/specs/` · Active changes: `openspec/changes/`
- Workspace artifacts: `.ai/`
