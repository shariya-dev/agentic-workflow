# AEOS Phase Registry

Canonical definition of every lifecycle phase. Each phase produces exactly one
artifact; each artifact is the input to the next phase. Prompts live at
`aeos/prompts/<phase-id>.md`.

## Stage 1 — Engineering

| Id | Phase | Owner | Inputs | Output artifact | Validation |
|----|-------|-------|--------|-----------------|------------|
| `00-discovery` | Discovery | Human (AI-assisted) | business idea (conversation) | `.ai/idea.md` | problem, users, outcomes, constraints all present |
| `10-proposal` | Proposal | AI drafts, human approves | `.ai/idea.md`, G0 record | `openspec/changes/<id>/proposal.md` | why/what-changes/impact sections; `openspec validate <id>` passes |
| `20-design` | Design | AI drafts, human approves | proposal.md | `openspec/changes/<id>/design.md` + spec deltas | every requirement traces to the proposal; deltas validate |
| `30-blueprint` | Blueprint | AI drafts, human approves | design.md + deltas | `.ai/blueprint/<id>/blueprint.md` | every module has boundary, dependencies, wave |
| `40-handover` | Handover | AI | blueprint.md | `.ai/handovers/<id>/<module>.handover.md` (one per module) | all 11 handover sections filled per module |
| `50-tasks` | Tasks | AI | handovers | `openspec/changes/<id>/tasks.md` + `tasks/` | each task atomic, has `depends_on`, wave, verification command |

## Stage 2 — Development

| Id | Phase | Owner | Inputs | Output artifact | Validation |
|----|-------|-------|--------|-----------------|------------|
| `60-implementation` | Implementation | Orchestrator + AI agents | G1 record, tasks, handovers, guide | one reviewed branch per task | task's Definition of Done checked; verification command passes |
| `70-review` | Review | AI drafts, human owns verdicts | branches, reports so far | `.ai/reports/<id>/report-*.md` | report template verdict present with evidence |
| `80-testing` | Testing | AI | merged waves | `.ai/reports/<id>/report-test-coverage.md` | coverage evidence recorded |

Deployment follows G2; `openspec archive <id>` folds deltas into
`openspec/specs/` and closes the change.

## Artifact Dependency Graph

```
idea → proposal → design → blueprint → handovers → tasks → [G1] → code
                     ↘ spec deltas ─────────────────────────↗ (agent context)
code → review + test + integration + security reports → [G2] → deploy → archive
```
