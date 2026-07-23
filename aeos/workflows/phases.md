# AEOS Phase Registry

Canonical definition of every lifecycle phase. Each phase produces exactly one
artifact; each artifact is the input to the next phase. Prompts live at
`aeos/prompts/<phase-id>.md`. This implements the production agentic workflow:
design first, prove the pattern once with a Golden Module, freeze contracts, then
build every module in parallel against them.

## Stage 1 — Design (documents only, no code)

| Id | Phase | Owner | Inputs | Output artifact | Validation |
|----|-------|-------|--------|-----------------|------------|
| `00-discovery` | Discovery | Human (AI-assisted) | idea / PRD / SRS / BRD / ToR | `.ai/idea.md` | problem, users, outcomes, constraints all present |
| `05-requirements` | Requirement Analysis (PRD) | AI drafts, human approves | `.ai/idea.md`, G0 record | `openspec/changes/<id>/proposal.md` | functional/non-functional split; user stories + acceptance criteria; `openspec validate` passes |
| `10-domain` | Domain Discovery & Modeling | AI drafts, human approves | proposal.md | `.ai/domain/<id>/domain-model.md` | bounded contexts + structural model + event-storming section |
| `15-architecture` | Architecture + Tech Freeze | AI drafts, human approves | proposal.md, domain-model.md | `design.md` + spec deltas | arch style + module boundaries + frozen stack; deltas validate |
| `20-adr` | Architecture Decision Records | AI drafts, human approves | design.md | `.ai/adr/<id>/ADR-NNN-*.md` | one ADR per significant decision, with alternatives |
| `25-guardrails` | Engineering Guide (pinned) | AI drafts, human approves | design.md, `aeos/guide/`, adapter | `.ai/engineering-guide/<id>.md` | all 8 guide areas referenced; adapter named |

## Stage 2 — Foundation (first code + frozen contracts + handover package)

| Id | Phase | Owner | Inputs | Output artifact | Validation |
|----|-------|-------|--------|-----------------|------------|
| `30-golden-module` | Golden Module | AI, human approves | G1 record, design, guide, domain | reference module (code) + `.ai/golden/<id>/golden-module.md` | module built; tests pass; layers documented |
| `35-contracts` | Freeze Contracts | AI drafts, human approves | golden-module.md, design, domain | `.ai/contracts/<id>/contracts.md` | all shared interfaces listed; marked FROZEN |
| `40-handover` | Module Handovers | AI | design, domain, contracts, golden, guide | `.ai/handovers/<id>/<module>.handover.md` | all sections filled; APIs/events match contracts |
| `45-tasks` | Impl Blueprint + Tasks | AI | handovers, design, contracts | `.ai/blueprint/<id>/blueprint.md` + `openspec/changes/<id>/tasks/` | waves acyclic; each task atomic with verification command |

## Stage 3 — Parallel Build & Release

| Id | Phase | Owner | Inputs | Output artifact | Validation |
|----|-------|-------|--------|-----------------|------------|
| `50-implementation` | Parallel AI Development | Orchestrator + AI agents | G2 record, tasks, + the 6 context-isolated inputs | one reviewed branch per task | Definition of Done checked; verification command passes |
| `55-testing` | Automated Testing | AI | merged waves, handover testing expectations | `.ai/reports/<id>/report-test-coverage.md` | coverage evidence recorded |
| `60-review` | Review & Hardening | AI drafts, human owns verdicts | branches, merged waves, contracts | `.ai/reports/<id>/report-*.md` | verdict present with evidence |
| `65-documentation` | Documentation & Handover | AI | G3 record, design, ADRs, contracts, reports | `.ai/reports/<id>/documentation.md` | API/arch/ADR/runbook/dev-guide index present |

Deployment follows G3; `openspec archive <id>` folds deltas into
`openspec/specs/` and closes the change.

## Context-Isolation Contract (Stage 3)

Every parallel-dev agent (`50-implementation`) receives **only**: Golden Module ·
Engineering Guide · Architecture · Contracts · its own Handover · its own Tasks.
Nothing else.

## Artifact Dependency Graph

```
Stage 1 (design, no code):
  idea → PRD → domain model → architecture(+deltas) → ADRs → engineering guide
                                              ↘ spec deltas ↘
                                            [G1]
Stage 2 (foundation):
  golden module → frozen contracts → handovers → blueprint + tasks
                                            [G2]
Stage 3 (parallel build):
  code → test + review + integration + security + performance reports
                                            [G3] → docs → deploy → archive
```

Gate definitions: `aeos/workflows/gates.md`.
