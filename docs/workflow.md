# AEOS Workflow

## Stage 1 — Engineering

Each phase produces exactly one artifact; each artifact is the next phase's
input. Commands enforce gate/input checks.

| # | Phase | Command | Artifact | Owner |
|---|-------|---------|----------|-------|
| 0 | Discovery | `/aeos:discover` | `.ai/idea.md` | Human (AI-assisted) |
| — | **GATE G0** | (human records) | `.ai/reviews/<id>-g0.md` | Product owner |
| 1 | Proposal | `/aeos:propose` | `openspec/changes/<id>/proposal.md` | AI drafts, human approves |
| 2 | Design | `/aeos:design` | `design.md` + spec deltas | AI drafts, human approves |
| 3 | Blueprint | `/aeos:blueprint` | `.ai/blueprint/<id>/blueprint.md` | AI drafts, human approves |
| 4 | Handover | `/aeos:handover` | `.ai/handovers/<id>/<module>.handover.md` | AI |
| 5 | Tasks | `/aeos:tasks` | `tasks.md` + `tasks/` | AI |
| — | **GATE G1** | (human records) | `.ai/reviews/<id>-g1.md` | Tech lead — **blocks all agent spawning** |

## Stage 2 — Development

1. Orchestrator consumes: G1 record, task files, handovers, guide + adapter.
2. Agents spawn one-per-task in dependency waves (topological sort of
   `depends_on`); wave N+1 starts only after wave N passes review.
3. Every branch gets a code review report before merge (`/aeos:review`).
4. Testing produces the coverage report (`/aeos:report`).
5. Integration + security reviews run on merged waves.
6. Release readiness aggregates all five reports.
7. **GATE G2** — release owner decides; record in `.ai/reviews/<id>-g2.md`.
8. Deploy, then `openspec archive <id>` — spec deltas fold into
   `openspec/specs/` and the change closes.

## Gate Rules

Gates are files, not conversations: `aeos/templates/gate-record.template.md` →
`.ai/reviews/`. A missing record means the phase does not run — commands check
and refuse. Definitions: `aeos/workflows/gates.md`.
