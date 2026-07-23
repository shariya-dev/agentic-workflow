# AEOS v2 — 18-Phase Production Lifecycle (Design Spec)

Date: 2026-07-23
Status: Approved (conversation), implementing.

## Goal

Rewire the AEOS framework to faithfully implement the production agentic
workflow in `each-module.md` (18 phases), while preserving AEOS's differentiators:
human approval gates, the OpenSpec spec-lifecycle backbone, one-artifact-per-phase,
and strict Stage-2 context isolation.

## Decisions (locked)

- **OpenSpec stays the backbone.** New artifacts (PRD, domain model, ADRs,
  contracts) layer on top. The PRD *is* the upgraded proposal (still emits an
  OpenSpec-valid `proposal.md`). `openspec archive` still closes a change.
- **Golden Module is real, built code** — the reference every module imitates.
  It is the first code written, on the design/build boundary, and is gated on
  both sides.
- **Modules boundaries live in Architecture; a lightweight Implementation
  Blueprint (wave plan) is kept** so the orchestrator knows what runs in
  parallel. This is the one addition beyond the literal 18.
- **Engineering Guide phase pins the existing static `aeos/guide/`** (which
  already ships all 8 guardrail areas) + adapter, with placeholders for
  change-specific rules. It does not regenerate the guide.
- **4 gates (G0–G3).** The Golden Module being real code earns a gate on each
  side.

## Three stages, 14 commands, 4 gates

### Stage 1 — Design (documents only, no code)
| id | command | each-module.md | artifact |
|----|---------|----------------|----------|
| 00 | `/aeos:discover` | 1 Business Idea | `.ai/idea.md` |
| 05 | `/aeos:requirements` | 2 Requirement Analysis | `openspec/changes/<id>/proposal.md` (PRD depth) |
| — | **G0 — worth building?** (product owner) | — | `.ai/reviews/<id>-g0.md` |
| 10 | `/aeos:domain` | 3+4 Domain Discovery & Modeling | `.ai/domain/<id>/domain-model.md` |
| 15 | `/aeos:architecture` | 5+6 Architecture + Tech Decisions | `design.md` + spec deltas + stack freeze |
| 20 | `/aeos:adr` | (5/6 rationale) | `.ai/adr/<id>/ADR-NNN-*.md` |
| 25 | `/aeos:guardrails` | 7 Skeleton & Guardrails | `.ai/engineering-guide/<id>.md` |
| — | **G1 — design frozen, authorize foundation build** (architect) | — | `.ai/reviews/<id>-g1.md` |

### Stage 2 — Foundation (first code + frozen contracts + handover package)
| id | command | each-module.md | artifact |
|----|---------|----------------|----------|
| 30 | `/aeos:golden` | 8 Golden Module | reference module (code) + `.ai/golden/<id>/golden-module.md` |
| 35 | `/aeos:contracts` | 9 Freeze Contracts | `.ai/contracts/<id>/contracts.md` (frozen) |
| 40 | `/aeos:handover` | 10 Module Handovers | `.ai/handovers/<id>/<module>.handover.md` |
| 45 | `/aeos:tasks` | *(addition)* wave plan + task slices | `.ai/blueprint/<id>/blueprint.md` + `openspec/changes/<id>/tasks/` |
| — | **G2 — standard set + contracts frozen → authorize parallel fan-out** (tech lead) | — | `.ai/reviews/<id>-g2.md` |

### Stage 3 — Parallel Build & Release
| id | command | each-module.md | artifact |
|----|---------|----------------|----------|
| 50 | `/aeos:implement` | 11 Parallel AI Development | reviewed branch per task (context-isolated brief) |
| 55 | `/aeos:report` | 12 Automated Testing | `report-test-coverage.md` |
| 60 | `/aeos:review code-review` | 13 Code Review | `report-code-review.md` |
| 60 | `/aeos:review integration` | 14 Integration & Validation | `report-integration.md` |
| 60 | `/aeos:review security` / `performance` | 15 Security & Perf | `report-security.md`, `report-performance.md` |
| 60 | `/aeos:review release-readiness` | (aggregate) | `report-release-readiness.md` |
| — | **G3 — ship?** (release owner) | — | `.ai/reviews/<id>-g3.md` |
| 65 | `/aeos:docs` | 17 Documentation & Handover | `.ai/reports/<id>/documentation.md` |
| — | Deploy → `openspec archive <id>` | 16 CI/CD | specs fold into current truth |

Continuous evolution (18): a change request re-enters at `/aeos:requirements`
with an impact-analysis note; same pipeline.

## Context-isolation contract (Stage 3)

Every parallel-dev agent receives **only**: Golden Module · Engineering Guide ·
Architecture · Contracts · its own Handover · its own Tasks. Nothing else. This
is a hard rule in `50-implementation.md` and the `/aeos:implement` brief.

## File plan

- Prompts (`aeos/prompts/`): 00-discovery, 05-requirements, 10-domain,
  15-architecture, 20-adr, 25-guardrails, 30-golden-module, 35-contracts,
  40-handover, 45-tasks, 50-implementation, 55-testing, 60-review,
  65-documentation.
- Commands (`.claude/commands/aeos/`): discover, requirements, domain,
  architecture, adr, guardrails, golden, contracts, handover, tasks, implement,
  report, review, docs, status.
- Templates (`aeos/templates/`): add prd, domain-model, adr, engineering-guide,
  golden-module, contracts, blueprint; rework handover, task; keep gate-record
  and report-* templates.
- Registry/rules: rewrite `aeos/workflows/phases.md`, `aeos/workflows/gates.md`;
  update `CLAUDE.md`.
- Docs: rewrite `docs/workflow.md`, `docs/user-guide.md`, `docs/getting-started.md`;
  touch `docs/architecture.md`.
- Remove: old `10-proposal`, `20-design`, `30-blueprint`, `50-tasks`,
  `60-implementation`, `70-review`, `80-testing` prompts; old `propose`,
  `design`, `blueprint` commands.

## Lite path

Small changes may collapse Domain Discovery + Modeling into one short pass and
skip formal event storming; gates still apply but records can be brief. This is
documented in the user guide, not enforced by tooling.
