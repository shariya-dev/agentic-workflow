# AEOS — AI Engineering Operating System: v1.0 Framework Design

**Date:** 2026-07-20
**Status:** Approved
**Scope:** The engineering framework only. No application code, no business logic, no Laravel modules.

## 1. What AEOS Is

AEOS is a reusable agentic software engineering framework, distributed as a **template repository**. Cloning it into a new project gives that project a standardized idea → production lifecycle in which AI generates engineering artifacts *before* implementation begins, with mandatory human approval gates between major phases.

It integrates:

- **OpenSpec CLI** (real compatibility) — specification lifecycle: propose → design → tasks → apply → archive.
- **Claude Code** — executable phase commands (`/aeos:*`) + a root `CLAUDE.md` that teaches every session the lifecycle.
- **Conductor** (conductor.build) — Stage 2 parallel multi-agent development, behind an abstract Orchestrator contract so the tool is swappable.
- **Human review gates** — approvals are version-controlled artifacts, not verbal events.

### Prime directives

1. AI must not design while implementing; AI must not implement while designing.
2. Every phase produces exactly one engineering artifact; every artifact is the input to the next phase.
3. Every phase has one owner; every gate has one human decision-maker.
4. Every engineering decision is version-controlled.
5. The lifecycle is framework-agnostic; stack specifics live only in adapters. Laravel is the first adapter.

## 2. Architecture: Three Lifecycles, Three Homes

The repo separates concerns by *rate and direction of change*:

| Home | Role | Mutability |
|------|------|-----------|
| `aeos/` | **The System** — prompts, templates, workflows, guide, adapters. Synced from upstream AEOS. | Immutable per-project (upgrade = sync from upstream) |
| `openspec/` | **The Spec Lifecycle** — owned by the real OpenSpec CLI. `specs/` = current truth; `changes/<id>/` = proposal.md, design.md, tasks.md, spec deltas. | Managed by `openspec` tooling |
| `.ai/` | **The Workspace** — per-project artifacts OpenSpec has no concept of: idea, blueprint, handovers, reviews, reports. | Mutable, born per-project |

AEOS never duplicates what OpenSpec owns; it wraps it with gates and richer artifacts, cross-linked by a shared `<change-id>`.

### Repository tree

```
aeos-template/
├─ README.md                       # what AEOS is, quickstart, lifecycle at a glance
├─ CLAUDE.md                       # teaches sessions: lifecycle, gate rules, write-permissions per phase
├─ docs/
│  ├─ architecture.md              # three lifecycles, artifact dependency graph
│  ├─ workflow.md                  # Stage 1 + Stage 2 walkthrough, gate rules
│  ├─ openspec-mapping.md          # phase ⇄ propose/design/tasks/apply + proposed extensions
│  └─ conductor-mapping.md         # Orchestrator contract + Conductor adapter mapping
├─ aeos/
│  ├─ prompts/                     # 00-discovery.md, 10-proposal.md, 20-design.md,
│  │                               # 30-blueprint.md, 40-handover.md, 50-tasks.md,
│  │                               # 60-implementation.md, 70-review.md, 80-testing.md
│  ├─ templates/
│  │  ├─ handover.template.md
│  │  ├─ task.template.md
│  │  ├─ gate-record.template.md
│  │  ├─ report-code-review.template.md
│  │  ├─ report-security.template.md
│  │  ├─ report-performance.template.md
│  │  ├─ report-integration.template.md
│  │  ├─ report-test-coverage.template.md
│  │  └─ report-release-readiness.template.md
│  ├─ workflows/
│  │  ├─ phases.md                 # phase registry: owner/inputs/outputs/validation per phase
│  │  └─ gates.md                  # G0/G1/G2 definitions
│  ├─ guide/                       # engineering guide skeleton (structure only, v1)
│  │  ├─ coding-standards.md
│  │  ├─ folder-conventions.md
│  │  ├─ naming.md
│  │  ├─ architecture-constraints.md
│  │  ├─ ddd-rules.md
│  │  ├─ solid.md
│  │  ├─ testing-rules.md
│  │  └─ review-rules.md
│  └─ adapters/
│     ├─ _contract.md              # what any adapter must provide
│     ├─ frameworks/laravel/       # first framework adapter (placeholder impl of contract)
│     └─ orchestrators/conductor/  # conductor.json convention, worktree/setup notes
├─ openspec/
│  ├─ specs/                       # current truth (empty in template; .gitkeep)
│  └─ changes/                     # active changes (empty in template; .gitkeep)
├─ .ai/
│  ├─ idea.md                      # template-stage placeholder
│  ├─ blueprint/                   # .ai/blueprint/<change-id>/blueprint.md
│  ├─ handovers/                   # .ai/handovers/<change-id>/<module>.handover.md
│  ├─ reviews/                     # gate records: <change-id>-g1.md …
│  └─ reports/                     # .ai/reports/<change-id>/report-*.md
├─ .claude/
│  └─ commands/aeos/               # discover, propose, design, blueprint, handover,
│                                  # tasks, review, report, status
└─ conductor.json                  # Conductor workspace setup (per orchestrator adapter)
```

Numbered prompt prefixes encode phase order in the filesystem, with gaps for future phases.

## 3. Lifecycle

### Stage 1 — Engineering (artifact per phase)

| # | Phase | Artifact | Location | Owner |
|---|-------|----------|----------|-------|
| 0 | Discovery | `idea.md` | `.ai/` | Human (AI-assisted) |
| — | **GATE G0** | gate record | `.ai/reviews/` | Human: "worth speccing?" |
| 1 | Proposal | `proposal.md` | `openspec/changes/<id>/` | AI drafts, human approves |
| 2 | Design | `design.md` + spec deltas | `openspec/changes/<id>/` | AI drafts, human approves |
| 3 | Blueprint | `blueprint.md` — module map, boundaries, waves | `.ai/blueprint/<id>/` | AI drafts, human approves |
| 4 | Handover | one `<module>.handover.md` per module | `.ai/handovers/<id>/` | AI |
| 5 | Tasks | `tasks.md` + per-task files | `openspec/changes/<id>/` | AI |
| — | **GATE G1** | gate record | `.ai/reviews/` | Human: scope + architecture. **No agent spawns without it.** |

### Stage 2 — Development

Orchestrator (Conductor) → parallel agents in waves → per-wave review → testing → integration → security → **GATE G2** (release readiness, human) → deployment → `openspec archive` (deltas fold into `openspec/specs/`).

Each agent receives exactly: one task file, its module's handover, the engineering guide (+ adapter overrides). Agents never write outside their module scope.

### Artifact dependency graph

```
idea → proposal → design → blueprint → handovers → tasks → [G1] → code
                     ↘ spec deltas ─────────────────────────↗ (agent context)
code → review + test + integration + security reports → [G2] → deploy → archive
```

Every artifact template carries a frontmatter contract: `owner, phase, inputs, outputs, purpose, validation`.

## 4. OpenSpec Mapping

| AEOS phase | OpenSpec concept |
|------------|------------------|
| Discovery | upstream of `propose` (no OpenSpec equivalent) |
| Proposal | `openspec/changes/<id>/proposal.md` (`propose`) |
| Design | `design.md` + spec deltas |
| Tasks | `tasks.md` |
| Stage 2 | `apply` |
| Deployment end | `archive` — deltas merge into `specs/` |

**Gaps → extensions, not workarounds.** OpenSpec has no blueprint, handover, gate-record, or report concepts. These are AEOS extension artifacts living in `.ai/`, cross-linked by the shared change-id. `docs/openspec-mapping.md` documents a proposed upstream extension (an `openspec/changes/<id>/aeos/` sub-folder convention) should OpenSpec later permit custom artifacts.

## 5. Orchestrator Contract & Conductor Mapping

**Abstract contract** (any orchestrator must satisfy it):

- **Inputs:** approved G1 gate record; task files; handovers; engineering guide + adapter.
- **Outputs:** one reviewed branch per task, merged per wave.
- **Spawning:** one agent per task; task brief = task file + handover path + guide path.
- **Waves:** topological sort of the task `depends_on` graph; wave N+1 starts only after wave N review passes.
- **Isolation:** one git worktree per agent; module scope enforced by task's declared file boundaries.
- **Review flow:** every branch gets a code-review report before merge.

**Conductor adapter** (`aeos/adapters/orchestrators/conductor/`): `conductor.json` setup/run scripts, one Conductor workspace per task, briefing convention for pasting the task brief. The engineering stage never references Conductor by name — swapping to Claude Code subagents or CI agents changes only the adapter.

## 6. Human Approval Gates

| Gate | Reviews | Decision owner | Blocks |
|------|---------|----------------|--------|
| G0 | idea.md — is this worth speccing? | Product owner | Proposal work |
| G1 | proposal + design + blueprint + handovers + tasks — scope & architecture | Tech lead / architect | All Stage 2 agent spawning |
| G2 | all six reports — release readiness | Release owner | Deployment |

Every gate decision is written to `.ai/reviews/<change-id>-g<n>.md` using `gate-record.template.md` (what was reviewed, decision, conditions, approver, date). `/aeos:*` commands refuse to run a phase whose preceding gate record is missing — enforcement at the tool layer, not just discipline.

## 7. Templates (v1 contracts)

- **`handover.template.md`** — Module Purpose, Scope (in/out), Requirements, Business Rules, Dependencies, APIs, Events, Database, Constraints, Acceptance Criteria, Testing Expectations.
- **`task.template.md`** — frontmatter: `id, change_id, module, handover, depends_on[], wave, estimated_scope`; body: Objective, Context Files, Definition of Done (checkboxes), Verification Command, Out of Scope. Atomic, measurable, independently executable — `depends_on` drives wave topo-sort.
- **Reports (×6)** — code review, security, performance, integration, test coverage, release readiness. Shared shape: Verdict (`PASS / PASS-WITH-NOTES / FAIL`), Findings table (severity / location / recommendation), Evidence. Release-readiness aggregates the other five.
- **`gate-record.template.md`** — reviewed artifacts, decision, conditions, approver, date.

## 8. Prompts (v1 placeholders)

Nine thin phase prompts in `aeos/prompts/`, each: Role · Inputs to load · Rules (incl. the two prime directives) · Output artifact + template · Handoff. Deliberately shallow in v1 — the frame is the deliverable; depth comes later.

## 9. Claude Code Integration

- `.claude/commands/aeos/` — thin wrappers: each `/aeos:<phase>` loads its phase prompt + templates + current artifacts and checks the preceding gate record. `/aeos:status` reports lifecycle position of each change.
- Root `CLAUDE.md` — lifecycle summary, three-lifecycles rule, per-phase write permissions ("in Design you may write only to `openspec/changes/<id>/`").

## 10. Engineering Guide (structure only, v1)

Eight skeleton files under `aeos/guide/` (coding standards, folder conventions, naming, architecture constraints, DDD rules, SOLID, testing rules, review rules), each a headed outline with `<!-- adapter override: ... -->` markers where framework adapters inject stack specifics.

## 11. Adapters & Extensibility

`aeos/adapters/_contract.md` defines what any adapter supplies: guide overrides, stack conventions, verification commands, scaffold conventions. Two adapter families:

- **frameworks/** — `laravel/` first (placeholder implementing the contract layout); `.NET`, NestJS, Spring Boot, Django, FastAPI drop in beside it later with zero workflow change.
- **orchestrators/** — `conductor/` first; others later.

The lifecycle never names a framework outside `adapters/`.

## 12. v1 Deliverable & Non-Goals

**Deliverable:** ~45 placeholder-depth files — folder structure, artifact contracts, templates, prompts, commands, docs, README. Structure, contracts, and ownership are the product.

**Non-goals for v1:** application code, Laravel module code, detailed prompt engineering, filled-in engineering guide content, CI pipelines, automated gate tooling beyond the command-level checks.

**Success criteria:** a new project can be started by cloning the template, and every artifact of the lifecycle has an obvious home, an owner, a template, and a validation contract before any code exists.
