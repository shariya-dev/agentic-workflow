# AEOS Workflow

Three stages, four gates. Each phase produces exactly one artifact; each artifact
is the next phase's input. Commands enforce gate/input checks. The shape: design
first, prove the pattern once with a Golden Module, freeze contracts, then build
every module in parallel against them.

## Stage 1 — Design (documents only, no code)

| # | Phase | Command | Artifact | Owner |
|---|-------|---------|----------|-------|
| 00 | Discovery | `/aeos:discover` | `.ai/idea.md` | Human (AI-assisted) |
| — | **GATE G0** | (human records) | `.ai/reviews/<id>-g0.md` | Product owner |
| 05 | Requirements (PRD) | `/aeos:requirements` | `openspec/changes/<id>/proposal.md` | AI drafts, human approves |
| 10 | Domain | `/aeos:domain` | `.ai/domain/<id>/domain-model.md` | AI drafts, human approves |
| 15 | Architecture | `/aeos:architecture` | `design.md` + spec deltas + stack freeze | AI drafts, human approves |
| 20 | ADR | `/aeos:adr` | `.ai/adr/<id>/ADR-NNN-*.md` | AI drafts, human approves |
| 25 | Guardrails | `/aeos:guardrails` | `.ai/engineering-guide/<id>.md` | AI drafts, human approves |
| — | **GATE G1** | (human records) | `.ai/reviews/<id>-g1.md` | Architect — **last point before any code** |

## Stage 2 — Foundation (first code + frozen contracts + handover package)

| # | Phase | Command | Artifact | Owner |
|---|-------|---------|----------|-------|
| 30 | Golden Module | `/aeos:golden` | reference module (code) + `.ai/golden/<id>/golden-module.md` | AI, human approves |
| 35 | Contracts | `/aeos:contracts` | `.ai/contracts/<id>/contracts.md` (FROZEN) | AI drafts, human approves |
| 40 | Handover | `/aeos:handover` | `.ai/handovers/<id>/<module>.handover.md` | AI |
| 45 | Blueprint + Tasks | `/aeos:tasks` | `.ai/blueprint/<id>/blueprint.md` + `tasks/` | AI |
| — | **GATE G2** | (human records) | `.ai/reviews/<id>-g2.md` | Tech lead — **blocks all parallel spawning** |

## Stage 3 — Parallel Build & Release

1. Orchestrator spawns one agent per task (`/aeos:implement`). Each agent gets
   **only** the six context-isolated inputs: Golden Module, Engineering Guide,
   Architecture, Contracts, its own Handover, its own Tasks.
2. Agents run in dependency waves; wave N+1 starts only after wave N passes
   review and merges.
3. Testing produces the coverage report (`/aeos:report`).
4. Reviews run per branch and on merged waves (`/aeos:review code-review /
   integration / security / performance`).
5. Release readiness aggregates the reports (`/aeos:review release-readiness`).
6. **GATE G3** — release owner decides; record in `.ai/reviews/<id>-g3.md`.
7. Documentation & handover (`/aeos:docs`), deploy, then
   `openspec archive <id>` — spec deltas fold into `openspec/specs/`.

## Continuous Evolution

A change request re-enters at `/aeos:requirements` with an impact-analysis note
and follows the same pipeline. No direct coding — only controlled evolution.

## Gate Rules

Gates are files, not conversations: `aeos/templates/gate-record.template.md` →
`.ai/reviews/`. A missing record means the phase does not run — commands check
and refuse. Definitions: `aeos/workflows/gates.md`.
