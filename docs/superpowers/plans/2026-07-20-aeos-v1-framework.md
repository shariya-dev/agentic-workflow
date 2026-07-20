# AEOS v1.0 Framework Repository Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Build the AEOS v1.0 template repository — folder structure, artifact templates, phase prompts, workflow docs, engineering guide skeleton, adapters, and Claude Code commands — per the approved spec at `docs/superpowers/specs/2026-07-20-aeos-framework-design.md`.

**Architecture:** Three lifecycles, three homes: `aeos/` (the immutable framework), `openspec/` (real OpenSpec CLI territory), `.ai/` (per-project mutable workspace). Claude Code commands in `.claude/commands/aeos/` are thin wrappers that load prompts + templates and enforce gate records. Everything is markdown + one JSON file; no application code.

**Tech Stack:** Markdown, git, OpenSpec CLI directory conventions, Claude Code slash commands, Conductor (`conductor.json`).

## Global Constraints

- **No application code, no business logic, no Laravel modules** — markdown/JSON only (spec §12).
- All files are **placeholder-depth by design**: real structure, real contracts, skeleton content (spec §12).
- Every artifact template opens with the frontmatter contract: `artifact, phase, owner, inputs, outputs, purpose, validation` (spec §3).
- Phases and artifacts are cross-linked by a shared `<change-id>` used in both `openspec/changes/<id>/` and `.ai/*/<id>/` (spec §2).
- Prompt files use numbered prefixes with gaps: `00-, 10-, 20-, 30-, 40-, 50-, 60-, 70-, 80-` (spec §2).
- Framework names (Laravel, .NET, …) may appear **only** under `aeos/adapters/` (spec §11). "Conductor" may appear only in `aeos/adapters/orchestrators/conductor/`, `docs/conductor-mapping.md`, and root `conductor.json`.
- Gate records live at `.ai/reviews/<change-id>-g<n>.md`; commands must refuse to run a phase whose preceding gate record is missing (spec §6).
- Working directory: `/Applications/MAMP/htdocs/aeos`. Git repo already initialized on `main` with the spec committed.
- Commit after every task with a `feat:`/`docs:` conventional message ending in the Claude co-author trailer.

**Verification convention used by every task:** `ls` the created paths and `grep -c` required headings; expected counts are given per step. A task is done only when its verification commands produce the expected output.

---

### Task 1: Root files — README.md, CLAUDE.md, .gitignore

**Files:**
- Create: `README.md`
- Create: `CLAUDE.md`
- Create: `.gitignore`

**Interfaces:**
- Produces: the lifecycle vocabulary every other file reuses — Stage 1 phases `Discovery → Proposal → Design → Blueprint → Handover → Tasks`, gates `G0/G1/G2`, the three homes `aeos/`, `openspec/`, `.ai/`, and command names `/aeos:discover|propose|design|blueprint|handover|tasks|review|report|status`. Later tasks must use these exact names.

- [ ] **Step 1: Write `README.md`**

````markdown
# AEOS — AI Engineering Operating System

**Version 1.0** · A reusable agentic software engineering framework.

AEOS is not an application. It is a template repository that standardizes how
software is engineered from **idea → production** using AI agents, with human
approval gates between major phases. AI generates engineering artifacts
*before* implementation begins. Clone this template to start any new project
(Laravel, .NET, NestJS, Spring Boot, Django, FastAPI, …) — the lifecycle is
identical regardless of stack; stack specifics live only in adapters.

## Prime Directives

1. AI must not design while implementing. AI must not implement while designing.
2. Every phase produces exactly one engineering artifact; every artifact is the
   input to the next phase.
3. Every phase has one owner; every gate has one human decision-maker.
4. Every engineering decision is version-controlled.
5. The lifecycle is framework-agnostic. Stack specifics live only in
   `aeos/adapters/`.

## Three Lifecycles, Three Homes

| Home | Role | Mutability |
|------|------|-----------|
| `aeos/` | **The System** — prompts, templates, workflows, guide, adapters | Immutable per-project; upgrade = sync from upstream AEOS |
| `openspec/` | **The Spec Lifecycle** — owned by the OpenSpec CLI (`specs/` = current truth, `changes/<id>/` = active change) | Managed by `openspec` tooling |
| `.ai/` | **The Workspace** — idea, blueprint, handovers, reviews, reports | Mutable, born per-project |

## Lifecycle at a Glance

```
Stage 1 — Engineering
  idea → [G0] → proposal → design → blueprint → handovers → tasks → [G1]

Stage 2 — Development
  [G1] → orchestrator spawns parallel agents in waves → review → testing
       → integration → security → [G2] → deployment → openspec archive
```

Gates `G0/G1/G2` are human decisions recorded as files in `.ai/reviews/`.
Nothing crosses a gate without its record.

## Quickstart

1. Clone this template into a new project repository.
2. Install the OpenSpec CLI and run `openspec init` (refreshes tool files;
   AEOS directories are already in place).
3. Pick a framework adapter in `aeos/adapters/frameworks/` (Laravel is first).
4. Open the project in Claude Code and run `/aeos:discover` to capture the idea.
5. Follow the lifecycle: `/aeos:propose → /aeos:design → /aeos:blueprint →
   /aeos:handover → /aeos:tasks`, approving each gate as you go.
6. After G1 approval, hand `openspec/changes/<id>/` + `.ai/handovers/<id>/` to
   the orchestrator (Conductor) for parallel development.
7. `/aeos:status` shows where every change sits in the lifecycle.

## Repository Map

- `docs/` — architecture, workflow, OpenSpec mapping, Conductor mapping
- `aeos/prompts/` — one prompt per phase (`00-discovery` … `80-testing`)
- `aeos/templates/` — artifact contracts (handover, task, gate record, reports)
- `aeos/workflows/` — phase registry and gate definitions
- `aeos/guide/` — engineering guide skeleton (standards, DDD, SOLID, testing…)
- `aeos/adapters/` — framework + orchestrator adapters
- `openspec/` — OpenSpec CLI territory
- `.ai/` — per-project workspace
- `.claude/commands/aeos/` — executable phase commands
````

- [ ] **Step 2: Write `CLAUDE.md`**

````markdown
# AEOS Project Instructions

This repository follows the **AEOS lifecycle**. Read this before doing anything.

## Prime Directives

1. **Never design while implementing. Never implement while designing.**
2. Every phase produces exactly one artifact, from its template in
   `aeos/templates/`, written to the location in the table below.
3. Human gates G0/G1/G2 block phase transitions. A gate is passed only when a
   record exists at `.ai/reviews/<change-id>-g<n>.md` with `Decision: APPROVED`.
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
| Gate records | `/aeos:review` | `.ai/reviews/` |

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
````

- [ ] **Step 3: Write `.gitignore`**

```gitignore
.DS_Store
*.log
node_modules/
vendor/
```

- [ ] **Step 4: Verify**

Run: `ls README.md CLAUDE.md .gitignore && grep -c "Prime Directives" README.md CLAUDE.md`
Expected: three filenames listed; `README.md:1` and `CLAUDE.md:1`.

- [ ] **Step 5: Commit**

```bash
git add README.md CLAUDE.md .gitignore
git commit -m "feat: AEOS root — README, CLAUDE.md lifecycle rules, gitignore

Co-Authored-By: Claude Fable 5 <noreply@anthropic.com>"
```

---

### Task 2: Workflow definitions — `aeos/workflows/phases.md` and `gates.md`

**Files:**
- Create: `aeos/workflows/phases.md`
- Create: `aeos/workflows/gates.md`

**Interfaces:**
- Consumes: phase/gate names from Task 1.
- Produces: the canonical phase registry (id, owner, inputs, outputs, validation) that prompts (Task 4), templates (Task 3), and commands (Task 8) reference by phase id (`00-discovery` … `80-testing`).

- [ ] **Step 1: Write `aeos/workflows/phases.md`**

````markdown
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
````

- [ ] **Step 2: Write `aeos/workflows/gates.md`**

````markdown
# AEOS Human Approval Gates

A gate is passed only when a record exists at `.ai/reviews/<change-id>-g<n>.md`
(from `aeos/templates/gate-record.template.md`) with `Decision: APPROVED`.
Approval is a version-controlled artifact, not a verbal event.

## G0 — Idea Gate

- **Reviews:** `.ai/idea.md` — is this worth speccing?
- **Decision owner:** Product owner
- **Blocks:** Proposal phase (`/aeos:propose` refuses without it)

## G1 — Engineering Gate

- **Reviews:** proposal + design + blueprint + handovers + tasks — scope and
  architecture as a whole
- **Decision owner:** Tech lead / architect
- **Blocks:** ALL Stage 2 agent spawning. No orchestrator run without it.

## G2 — Release Gate

- **Reviews:** all six reports in `.ai/reports/<id>/` (code review, security,
  performance, integration, test coverage, release readiness)
- **Decision owner:** Release owner
- **Blocks:** Deployment and `openspec archive`

## Conditional Approval

A gate record may carry `Decision: APPROVED-WITH-CONDITIONS` plus a Conditions
list. Conditions become tasks in the change and must close before the next gate.
````

- [ ] **Step 3: Verify**

Run: `grep -c '^| `' aeos/workflows/phases.md && grep -c '^## G' aeos/workflows/gates.md`
Expected: `9` (phase rows) and `3` (gates).

- [ ] **Step 4: Commit**

```bash
git add aeos/workflows/
git commit -m "feat: phase registry and gate definitions

Co-Authored-By: Claude Fable 5 <noreply@anthropic.com>"
```

---

### Task 3: Artifact templates — `aeos/templates/` (9 files)

**Files:**
- Create: `aeos/templates/handover.template.md`
- Create: `aeos/templates/task.template.md`
- Create: `aeos/templates/gate-record.template.md`
- Create: `aeos/templates/report-code-review.template.md`
- Create: `aeos/templates/report-security.template.md`
- Create: `aeos/templates/report-performance.template.md`
- Create: `aeos/templates/report-integration.template.md`
- Create: `aeos/templates/report-test-coverage.template.md`
- Create: `aeos/templates/report-release-readiness.template.md`

**Interfaces:**
- Consumes: phase ids from Task 2.
- Produces: template filenames + frontmatter contract (`artifact, phase, owner, inputs, outputs, purpose, validation`) that prompts (Task 4) and commands (Task 8) reference verbatim. Report verdict vocabulary: `PASS / PASS-WITH-NOTES / FAIL`. Gate decision vocabulary: `APPROVED / APPROVED-WITH-CONDITIONS / REJECTED`.

- [ ] **Step 1: Write `aeos/templates/handover.template.md`**

````markdown
---
artifact: handover
phase: 40-handover
owner: ai
inputs: [".ai/blueprint/<change-id>/blueprint.md"]
outputs: [".ai/handovers/<change-id>/<module>.handover.md"]
purpose: Give one implementation agent everything it needs to build one module without re-deriving design decisions.
validation: All 11 sections non-empty; every dependency names another module or external system; every acceptance criterion is testable.
---

# Module Handover: <module-name>

> Change: `<change-id>` · Blueprint: `.ai/blueprint/<change-id>/blueprint.md`

## 1. Module Purpose
<!-- One paragraph: why this module exists. -->

## 2. Scope
**In scope:**
**Out of scope:**

## 3. Requirements
<!-- Numbered functional requirements, traceable to design.md. -->

## 4. Business Rules
<!-- Invariants that must always hold. -->

## 5. Dependencies
<!-- Other modules / external systems this module consumes, and what it provides to others. -->

## 6. APIs
<!-- Endpoints / interfaces this module exposes: route, verb, request, response. -->

## 7. Events
<!-- Events published and consumed: name, payload, trigger. -->

## 8. Database
<!-- Tables/collections owned by this module. Schema sketch. No other module writes here. -->

## 9. Constraints
<!-- Performance, security, compliance, technology constraints. -->

## 10. Acceptance Criteria
<!-- Checkbox list; each criterion independently verifiable. -->

## 11. Testing Expectations
<!-- Required test types and critical paths that must be covered. -->
````

- [ ] **Step 2: Write `aeos/templates/task.template.md`**

````markdown
---
artifact: task
phase: 50-tasks
owner: ai
inputs: [".ai/handovers/<change-id>/<module>.handover.md"]
outputs: ["openspec/changes/<change-id>/tasks/<task-id>.md"]
purpose: One atomic, measurable, independently executable unit of work for one AI agent.
validation: Has objective, definition of done, verification command; touches only files inside its declared module scope; depends_on lists task ids only.
---

# Task: <task-id> — <short title>

```yaml
id: <task-id>            # e.g. T-003
change_id: <change-id>
module: <module-name>
handover: .ai/handovers/<change-id>/<module>.handover.md
depends_on: []           # task ids that must merge first
wave: 1                  # topological wave number
estimated_scope: S       # S / M / L
```

## Objective
<!-- One sentence. What exists when this task is done that didn't before. -->

## Context Files
<!-- Exact paths the agent should read before starting. -->

## Definition of Done
- [ ] <!-- observable, checkable outcomes only -->

## Verification Command
```bash
# exact command an agent runs to prove the task is done; from the adapter's verification conventions
```

## Out of Scope
<!-- What this task must NOT touch, to protect module isolation. -->
````

- [ ] **Step 3: Write `aeos/templates/gate-record.template.md`**

````markdown
---
artifact: gate-record
phase: gate
owner: human
inputs: ["artifacts under review (see gate definition in aeos/workflows/gates.md)"]
outputs: [".ai/reviews/<change-id>-g<n>.md"]
purpose: Version-control a human gate decision so downstream phases can verify it.
validation: Decision is one of APPROVED / APPROVED-WITH-CONDITIONS / REJECTED; approver and date present.
---

# Gate Record: <change-id> — G<n>

- **Gate:** G<n> (<idea | engineering | release>)
- **Change:** `<change-id>`
- **Approver:** <name / role>
- **Date:** <YYYY-MM-DD>

## Artifacts Reviewed
<!-- Exact paths reviewed at this gate. -->

## Decision
Decision: <APPROVED | APPROVED-WITH-CONDITIONS | REJECTED>

## Conditions
<!-- Required if APPROVED-WITH-CONDITIONS; each becomes a task before the next gate. -->

## Notes
<!-- Rationale, risks accepted, follow-ups. -->
````

- [ ] **Step 4: Write the six report templates**

All six share one shape; only `artifact`, title, and the Scope hints differ.
Write each file exactly as below.

`aeos/templates/report-code-review.template.md`:

````markdown
---
artifact: report-code-review
phase: 70-review
owner: ai-drafts-human-owns-verdict
inputs: ["reviewed branches / merged waves for <change-id>"]
outputs: [".ai/reports/<change-id>/report-code-review.md"]
purpose: Record code quality findings and a merge verdict for the change.
validation: Verdict present; every finding has severity, location, recommendation; evidence section non-empty.
---

# Code Review Report — <change-id>

**Verdict:** <PASS | PASS-WITH-NOTES | FAIL>

## Scope
<!-- Branches / waves / modules reviewed. Standards applied: aeos/guide/review-rules.md + adapter overrides. -->

## Findings
| # | Severity | Location | Finding | Recommendation |
|---|----------|----------|---------|----------------|
| 1 | <critical/major/minor> | <file:line> | | |

## Evidence
<!-- Commands run, diffs inspected, checklists applied. -->
````

`aeos/templates/report-security.template.md`:

````markdown
---
artifact: report-security
phase: 70-review
owner: ai-drafts-human-owns-verdict
inputs: ["merged code for <change-id>", "handover Constraints sections"]
outputs: [".ai/reports/<change-id>/report-security.md"]
purpose: Record security findings and a ship-safety verdict for the change.
validation: Verdict present; every finding has severity, location, recommendation; evidence section non-empty.
---

# Security Review Report — <change-id>

**Verdict:** <PASS | PASS-WITH-NOTES | FAIL>

## Scope
<!-- Attack surfaces reviewed: authn/z, input handling, secrets, dependencies, data exposure. -->

## Findings
| # | Severity | Location | Finding | Recommendation |
|---|----------|----------|---------|----------------|
| 1 | <critical/major/minor> | <file:line> | | |

## Evidence
<!-- Scans run, configs inspected, threat cases exercised. -->
````

`aeos/templates/report-performance.template.md`:

````markdown
---
artifact: report-performance
phase: 70-review
owner: ai-drafts-human-owns-verdict
inputs: ["merged code for <change-id>", "handover Constraints sections"]
outputs: [".ai/reports/<change-id>/report-performance.md"]
purpose: Record performance findings against the constraints declared in handovers.
validation: Verdict present; every finding has severity, location, recommendation; evidence section non-empty.
---

# Performance Review Report — <change-id>

**Verdict:** <PASS | PASS-WITH-NOTES | FAIL>

## Scope
<!-- Hot paths, queries, payloads measured; constraint budgets from handovers. -->

## Findings
| # | Severity | Location | Finding | Recommendation |
|---|----------|----------|---------|----------------|
| 1 | <critical/major/minor> | <file:line> | | |

## Evidence
<!-- Measurements, profiles, query plans. -->
````

`aeos/templates/report-integration.template.md`:

````markdown
---
artifact: report-integration
phase: 70-review
owner: ai-drafts-human-owns-verdict
inputs: ["merged waves for <change-id>", "handover Dependencies/APIs/Events sections"]
outputs: [".ai/reports/<change-id>/report-integration.md"]
purpose: Verify modules compose — every declared dependency, API, and event actually connects.
validation: Verdict present; every finding has severity, location, recommendation; evidence section non-empty.
---

# Integration Review Report — <change-id>

**Verdict:** <PASS | PASS-WITH-NOTES | FAIL>

## Scope
<!-- Module boundaries exercised; contract pairs (provider ↔ consumer) checked. -->

## Findings
| # | Severity | Location | Finding | Recommendation |
|---|----------|----------|---------|----------------|
| 1 | <critical/major/minor> | <file:line> | | |

## Evidence
<!-- Integration runs, contract checks, event traces. -->
````

`aeos/templates/report-test-coverage.template.md`:

````markdown
---
artifact: report-test-coverage
phase: 80-testing
owner: ai
inputs: ["merged code for <change-id>", "handover Testing Expectations sections"]
outputs: [".ai/reports/<change-id>/report-test-coverage.md"]
purpose: Record what is tested, what is not, and whether handover testing expectations were met.
validation: Verdict present; coverage numbers or explicit gaps listed; evidence section non-empty.
---

# Test Coverage Report — <change-id>

**Verdict:** <PASS | PASS-WITH-NOTES | FAIL>

## Scope
<!-- Modules measured; expectations from each handover §11. -->

## Findings
| # | Severity | Location | Finding | Recommendation |
|---|----------|----------|---------|----------------|
| 1 | <critical/major/minor> | <module/path> | | |

## Evidence
<!-- Coverage output, suites run, known gaps. -->
````

`aeos/templates/report-release-readiness.template.md`:

````markdown
---
artifact: report-release-readiness
phase: 70-review
owner: ai-drafts-human-owns-verdict
inputs: [".ai/reports/<change-id>/report-code-review.md", "report-security.md", "report-performance.md", "report-integration.md", "report-test-coverage.md"]
outputs: [".ai/reports/<change-id>/report-release-readiness.md"]
purpose: Aggregate the five reports into a single go/no-go input for gate G2.
validation: All five source reports linked with their verdicts; overall verdict present; open risks listed.
---

# Release Readiness Report — <change-id>

**Verdict:** <PASS | PASS-WITH-NOTES | FAIL>

## Source Reports
| Report | Verdict |
|--------|---------|
| Code Review | |
| Security | |
| Performance | |
| Integration | |
| Test Coverage | |

## Open Risks
<!-- Anything shipping anyway, and why. -->

## Rollback Plan
<!-- How to undo this release if it fails. -->

## Evidence
<!-- Deployment dry-run, migration check, config diff. -->
````

- [ ] **Step 5: Verify**

Run: `ls aeos/templates/ | wc -l && grep -l '^artifact:' aeos/templates/*.md | wc -l && grep -c 'PASS | PASS-WITH-NOTES | FAIL' aeos/templates/report-*.md | grep -c ':1$'`
Expected: `9`, `9`, `6`.

- [ ] **Step 6: Commit**

```bash
git add aeos/templates/
git commit -m "feat: artifact templates — handover, task, gate record, six reports

Co-Authored-By: Claude Fable 5 <noreply@anthropic.com>"
```

---

### Task 4: Phase prompts — `aeos/prompts/` (9 files)

**Files:**
- Create: `aeos/prompts/00-discovery.md`
- Create: `aeos/prompts/10-proposal.md`
- Create: `aeos/prompts/20-design.md`
- Create: `aeos/prompts/30-blueprint.md`
- Create: `aeos/prompts/40-handover.md`
- Create: `aeos/prompts/50-tasks.md`
- Create: `aeos/prompts/60-implementation.md`
- Create: `aeos/prompts/70-review.md`
- Create: `aeos/prompts/80-testing.md`

**Interfaces:**
- Consumes: phase registry (Task 2), template paths and vocab (Task 3).
- Produces: prompt files loaded verbatim by the commands in Task 8. Every prompt has exactly the five sections: `## Role`, `## Inputs`, `## Rules`, `## Output`, `## Handoff`.

- [ ] **Step 1: Write all nine prompts**

Each prompt is deliberately thin (v1 establishes the frame). Shared rules
block — include it verbatim as the first two Rules bullets of every prompt:

```markdown
- Never design while implementing; never implement while designing. This phase
  produces its one artifact and nothing else.
- Write only to the locations this phase permits (see CLAUDE.md table). If a
  required input or gate record is missing, stop and report it.
```

`aeos/prompts/00-discovery.md`:

````markdown
# Phase Prompt: 00-discovery

## Role
You are a product discovery partner helping a human turn a raw business idea
into a structured idea document. You ask; the human decides.

## Inputs
- Conversation with the human (the idea source)
- `.ai/idea.md` if it already exists (refine, don't overwrite silently)

## Rules
- Never design while implementing; never implement while designing. This phase
  produces its one artifact and nothing else.
- Write only to the locations this phase permits (see CLAUDE.md table). If a
  required input or gate record is missing, stop and report it.
- No solutions, no architecture, no technology choices — problem space only.
- Capture: problem, target users, desired outcomes, constraints, success
  metrics, open questions.

## Output
`.ai/idea.md` — free-form but must answer: problem, users, outcomes,
constraints, success metrics.

## Handoff
Human reviews idea.md at gate **G0**. On approval (record in `.ai/reviews/`),
next phase is `10-proposal` via `/aeos:propose`.
````

`aeos/prompts/10-proposal.md`:

````markdown
# Phase Prompt: 10-proposal

## Role
You are a staff engineer writing an OpenSpec change proposal from an approved
idea.

## Inputs
- `.ai/idea.md`
- Gate record `.ai/reviews/<change-id>-g0.md` (Decision: APPROVED) — required
- `openspec/specs/` (current truth, for impact analysis)

## Rules
- Never design while implementing; never implement while designing. This phase
  produces its one artifact and nothing else.
- Write only to the locations this phase permits (see CLAUDE.md table). If a
  required input or gate record is missing, stop and report it.
- Propose the *what* and *why*; defer the *how* to `20-design`.
- Follow OpenSpec proposal conventions (why / what changes / impact).

## Output
`openspec/changes/<change-id>/proposal.md` — validate with
`openspec validate <change-id>`.

## Handoff
Human approves the proposal, then `20-design` via `/aeos:design`.
````

`aeos/prompts/20-design.md`:

````markdown
# Phase Prompt: 20-design

## Role
You are a software architect turning an approved proposal into a technical
design and spec deltas.

## Inputs
- `openspec/changes/<change-id>/proposal.md`
- `openspec/specs/` (current truth)
- `aeos/guide/architecture-constraints.md` + active adapter overrides

## Rules
- Never design while implementing; never implement while designing. This phase
  produces its one artifact and nothing else.
- Write only to the locations this phase permits (see CLAUDE.md table). If a
  required input or gate record is missing, stop and report it.
- Every design decision traces to a proposal requirement.
- Record alternatives considered and why they lost.
- No module decomposition yet — that is `30-blueprint`.

## Output
`openspec/changes/<change-id>/design.md` + spec deltas under
`openspec/changes/<change-id>/specs/`.

## Handoff
Human approves the design, then `30-blueprint` via `/aeos:blueprint`.
````

`aeos/prompts/30-blueprint.md`:

````markdown
# Phase Prompt: 30-blueprint

## Role
You are a principal engineer decomposing an approved design into independent
modules and implementation waves.

## Inputs
- `openspec/changes/<change-id>/design.md` + spec deltas
- `aeos/guide/ddd-rules.md`, `aeos/guide/architecture-constraints.md`

## Rules
- Never design while implementing; never implement while designing. This phase
  produces its one artifact and nothing else.
- Write only to the locations this phase permits (see CLAUDE.md table). If a
  required input or gate record is missing, stop and report it.
- Every module gets: name, purpose, boundary (owned paths/data), dependencies,
  wave number. Modules in the same wave must be independently buildable.
- Minimize cross-module dependencies; a dependency cycle is a blueprint bug.

## Output
`.ai/blueprint/<change-id>/blueprint.md` — module map + wave plan.

## Handoff
Human approves the blueprint, then `40-handover` via `/aeos:handover`.
````

`aeos/prompts/40-handover.md`:

````markdown
# Phase Prompt: 40-handover

## Role
You are a tech lead writing module handover documents — one per blueprint
module — so an implementation agent can build each module without re-deriving
design decisions.

## Inputs
- `.ai/blueprint/<change-id>/blueprint.md`
- `openspec/changes/<change-id>/design.md` + spec deltas
- Template: `aeos/templates/handover.template.md`

## Rules
- Never design while implementing; never implement while designing. This phase
  produces its one artifact and nothing else.
- Write only to the locations this phase permits (see CLAUDE.md table). If a
  required input or gate record is missing, stop and report it.
- One handover per module; all 11 template sections filled.
- Declared APIs/Events between modules must match pairwise (provider ↔
  consumer).

## Output
`.ai/handovers/<change-id>/<module>.handover.md` for every blueprint module.

## Handoff
`50-tasks` via `/aeos:tasks`.
````

`aeos/prompts/50-tasks.md`:

````markdown
# Phase Prompt: 50-tasks

## Role
You are an engineering manager slicing handovers into atomic tasks executable
by parallel AI agents.

## Inputs
- `.ai/handovers/<change-id>/*.handover.md`
- `.ai/blueprint/<change-id>/blueprint.md` (waves)
- Template: `aeos/templates/task.template.md`

## Rules
- Never design while implementing; never implement while designing. This phase
  produces its one artifact and nothing else.
- Write only to the locations this phase permits (see CLAUDE.md table). If a
  required input or gate record is missing, stop and report it.
- Each task: atomic, measurable, independently executable, one module only.
- `depends_on` may reference task ids only; the dependency graph must be
  acyclic and consistent with blueprint waves.
- Every task carries a runnable verification command (from the adapter).

## Output
`openspec/changes/<change-id>/tasks.md` (index) + one file per task under
`openspec/changes/<change-id>/tasks/`.

## Handoff
Human reviews the full Stage-1 artifact set at gate **G1**. On approval,
Stage 2 begins: the orchestrator consumes tasks + handovers.
````

`aeos/prompts/60-implementation.md`:

````markdown
# Phase Prompt: 60-implementation

## Role
You are one implementation agent building exactly one task inside one module
boundary. (This prompt is the per-agent briefing used by the orchestrator.)

## Inputs
- Your task file: `openspec/changes/<change-id>/tasks/<task-id>.md`
- Your module handover: path named in the task frontmatter
- `aeos/guide/` + active adapter overrides
- Gate record `.ai/reviews/<change-id>-g1.md` (Decision: APPROVED) — required

## Rules
- Never design while implementing; never implement while designing. This phase
  produces its one artifact and nothing else.
- Write only to the locations this phase permits (see CLAUDE.md table). If a
  required input or gate record is missing, stop and report it.
- Touch only files inside your task's module scope; "Out of Scope" is a hard
  boundary.
- A design gap found mid-task is reported back, never improvised around.
- Done means: Definition of Done checked AND the verification command passes.

## Output
One branch implementing the task, ready for review.

## Handoff
Branch enters review (`70-review`); merge only after a passing code review.
````

`aeos/prompts/70-review.md`:

````markdown
# Phase Prompt: 70-review

## Role
You are a reviewer producing report artifacts (code review, security,
performance, integration, release readiness) for a change.

## Inputs
- Branches / merged waves for `<change-id>`
- Handovers (constraints, APIs, events) and `aeos/guide/review-rules.md`
- Templates: `aeos/templates/report-*.template.md`

## Rules
- Never design while implementing; never implement while designing. This phase
  produces its one artifact and nothing else.
- Write only to the locations this phase permits (see CLAUDE.md table). If a
  required input or gate record is missing, stop and report it.
- Verdicts are evidence-backed; a finding without location + recommendation
  doesn't count.
- Release readiness aggregates the other five reports and feeds gate **G2**.

## Output
`.ai/reports/<change-id>/report-<type>.md` per review performed.

## Handoff
All six reports → human decides at gate **G2** → deployment →
`openspec archive <change-id>`.
````

`aeos/prompts/80-testing.md`:

````markdown
# Phase Prompt: 80-testing

## Role
You are a test engineer measuring the change against every handover's Testing
Expectations.

## Inputs
- Merged waves for `<change-id>`
- Handover §11 (Testing Expectations) per module
- Template: `aeos/templates/report-test-coverage.template.md`
- Adapter verification conventions (test runner commands)

## Rules
- Never design while implementing; never implement while designing. This phase
  produces its one artifact and nothing else.
- Write only to the locations this phase permits (see CLAUDE.md table). If a
  required input or gate record is missing, stop and report it.
- Report reality: gaps are listed, never papered over.

## Output
`.ai/reports/<change-id>/report-test-coverage.md`.

## Handoff
Feeds the release-readiness report and gate **G2**.
````

- [ ] **Step 2: Verify**

Run: `ls aeos/prompts/ | wc -l && grep -l '^## Role' aeos/prompts/*.md | wc -l && grep -l 'Never design while implementing' aeos/prompts/*.md | wc -l`
Expected: `9`, `9`, `9`.

- [ ] **Step 3: Commit**

```bash
git add aeos/prompts/
git commit -m "feat: nine phase prompts (00-discovery … 80-testing)

Co-Authored-By: Claude Fable 5 <noreply@anthropic.com>"
```

---

### Task 5: Engineering guide skeleton — `aeos/guide/` (8 files)

**Files:**
- Create: `aeos/guide/coding-standards.md`
- Create: `aeos/guide/folder-conventions.md`
- Create: `aeos/guide/naming.md`
- Create: `aeos/guide/architecture-constraints.md`
- Create: `aeos/guide/ddd-rules.md`
- Create: `aeos/guide/solid.md`
- Create: `aeos/guide/testing-rules.md`
- Create: `aeos/guide/review-rules.md`

**Interfaces:**
- Consumes: nothing.
- Produces: guide file paths referenced by prompts (Task 4) and the adapter contract (Task 6). Every file contains at least one `<!-- adapter-override: ... -->` marker — the hook adapters fill.

- [ ] **Step 1: Write all eight guide files**

Structure only (spec §10): headed outlines, no content. Each file follows the
same pattern — write each exactly as below.

`aeos/guide/coding-standards.md`:

````markdown
# Coding Standards

> v1 skeleton — headings define what this guide will cover. Framework adapters
> inject stack specifics at the override markers.

## Language & Formatting
<!-- adapter-override: formatter, linter, language version -->

## Error Handling

## Comments & Documentation

## Dependency Policy
<!-- adapter-override: package manager, allowed dependency sources -->

## Code Smells to Reject
````

`aeos/guide/folder-conventions.md`:

````markdown
# Folder Conventions

> v1 skeleton.

## Project Layout
<!-- adapter-override: canonical source tree for the stack -->

## Module Boundaries on Disk

## Where Tests Live
<!-- adapter-override: test directory conventions -->

## Generated & Vendor Code
````

`aeos/guide/naming.md`:

````markdown
# Naming Conventions

> v1 skeleton.

## Files & Directories
<!-- adapter-override: stack file naming (case, suffixes) -->

## Types, Functions, Variables

## Database Objects
<!-- adapter-override: table/column conventions -->

## Events & Messages

## Branches, Commits, Change Ids
````

`aeos/guide/architecture-constraints.md`:

````markdown
# Architecture Constraints

> v1 skeleton. Hard rules the design and blueprint phases must respect.

## Layering Rules
<!-- adapter-override: framework layer mapping -->

## Module Isolation
<!-- Modules own their data; no cross-module table writes. -->

## Communication Between Modules
<!-- APIs and events only; no reaching into internals. -->

## Technology Boundaries
<!-- adapter-override: approved stack components -->

## Forbidden Patterns
````

`aeos/guide/ddd-rules.md`:

````markdown
# DDD Rules

> v1 skeleton.

## Bounded Contexts
<!-- Blueprint modules map to bounded contexts. -->

## Ubiquitous Language

## Aggregates & Invariants

## Domain Events

## Anti-Corruption Layers
<!-- adapter-override: integration seam conventions -->
````

`aeos/guide/solid.md`:

````markdown
# SOLID Expectations

> v1 skeleton.

## Single Responsibility

## Open/Closed

## Liskov Substitution

## Interface Segregation

## Dependency Inversion
<!-- adapter-override: DI container conventions -->
````

`aeos/guide/testing-rules.md`:

````markdown
# Testing Rules

> v1 skeleton.

## Test Pyramid Expectations
<!-- adapter-override: unit/integration/e2e tooling -->

## What Must Always Be Tested

## Test Data & Fixtures

## Coverage Expectations

## Flaky Test Policy
````

`aeos/guide/review-rules.md`:

````markdown
# Review Rules

> v1 skeleton.

## What Reviewers Check
<!-- Correctness vs handover, boundaries respected, standards applied. -->

## Severity Definitions
<!-- critical / major / minor — used by all report templates. -->

## Merge Criteria
<!-- adapter-override: CI checks required before merge -->

## Review Etiquette for AI Agents
````

- [ ] **Step 2: Verify**

Run: `ls aeos/guide/ | wc -l && grep -l 'adapter-override' aeos/guide/*.md | wc -l`
Expected: `8`, `8`.

- [ ] **Step 3: Commit**

```bash
git add aeos/guide/
git commit -m "feat: engineering guide skeleton (8 files, adapter-override markers)

Co-Authored-By: Claude Fable 5 <noreply@anthropic.com>"
```

---

### Task 6: Adapters — contract, Laravel placeholder, Conductor orchestrator + root `conductor.json`

**Files:**
- Create: `aeos/adapters/_contract.md`
- Create: `aeos/adapters/frameworks/laravel/README.md`
- Create: `aeos/adapters/frameworks/laravel/guide-overrides.md`
- Create: `aeos/adapters/frameworks/laravel/verification.md`
- Create: `aeos/adapters/orchestrators/conductor/README.md`
- Create: `conductor.json`

**Interfaces:**
- Consumes: guide files + override markers (Task 5), task/handover vocab (Task 3), orchestrator contract from spec §5.
- Produces: the adapter contract every future adapter (frameworks or orchestrators) implements; `conductor.json` consumed by the Conductor app.

- [ ] **Step 1: Write `aeos/adapters/_contract.md`**

````markdown
# Adapter Contract

An adapter binds the framework-agnostic AEOS lifecycle to a concrete tool or
stack. The lifecycle never names a stack outside `aeos/adapters/`. Two families:

## Framework Adapters (`frameworks/<name>/`)

Every framework adapter MUST provide:

| File | Purpose |
|------|---------|
| `README.md` | What the adapter covers, stack versions, how to activate it |
| `guide-overrides.md` | Content for every `<!-- adapter-override: ... -->` marker in `aeos/guide/` |
| `verification.md` | Exact commands tasks use in their Verification Command section (test, lint, static analysis) |

An adapter MAY add scaffold conventions (generators, starter layouts). It must
not alter phase order, artifacts, or gates.

## Orchestrator Adapters (`orchestrators/<name>/`)

Every orchestrator adapter MUST document how the tool satisfies the
Orchestrator Contract (`docs/conductor-mapping.md`):

- how agents are spawned (one per task) and briefed (task file + handover +
  guide)
- how waves are executed in dependency order
- how module isolation is enforced (e.g. one git worktree per agent)
- how review flows before merge

## Activation

A project activates one framework adapter and one orchestrator adapter and
records the choice in its README. Multiple framework adapters may coexist in
`aeos/adapters/` — only the activated one applies.
````

- [ ] **Step 2: Write the Laravel adapter placeholder (3 files)**

`aeos/adapters/frameworks/laravel/README.md`:

````markdown
# Laravel Adapter

> v1 placeholder — first framework adapter, structure per `../../_contract.md`.

- **Stack:** Laravel (version TBD per project), PHP, Composer
- **Status:** skeleton — files exist, content to be filled when first used
- **Activate:** note in project README; tasks then use `verification.md`
  commands and guides resolve overrides from `guide-overrides.md`.
````

`aeos/adapters/frameworks/laravel/guide-overrides.md`:

````markdown
# Laravel Guide Overrides

> v1 placeholder. One section per `<!-- adapter-override: ... -->` marker in
> `aeos/guide/`. Fill when the adapter is first activated.

## coding-standards: formatter, linter, language version
## coding-standards: package manager, allowed dependency sources
## folder-conventions: canonical source tree for the stack
## folder-conventions: test directory conventions
## naming: stack file naming (case, suffixes)
## naming: table/column conventions
## architecture-constraints: framework layer mapping
## architecture-constraints: approved stack components
## ddd-rules: integration seam conventions
## solid: DI container conventions
## testing-rules: unit/integration/e2e tooling
## review-rules: CI checks required before merge
````

`aeos/adapters/frameworks/laravel/verification.md`:

````markdown
# Laravel Verification Commands

> v1 placeholder. Exact commands for task Verification Command sections.

## Test
<!-- e.g. vendor/bin/phpunit or php artisan test — fixed per project -->

## Lint / Format Check

## Static Analysis
````

- [ ] **Step 3: Write the Conductor orchestrator adapter**

`aeos/adapters/orchestrators/conductor/README.md`:

````markdown
# Conductor Orchestrator Adapter

Binds Stage 2 to [Conductor](https://conductor.build) — parallel Claude Code
agents in git worktrees. Satisfies the Orchestrator Contract in
`docs/conductor-mapping.md`.

## Mapping

| Contract requirement | Conductor mechanism |
|----------------------|---------------------|
| One agent per task | One Conductor workspace per task |
| Agent briefing | Paste the task brief: task file path + handover path + `aeos/prompts/60-implementation.md` |
| Wave ordering | Start wave N+1 workspaces only after wave N branches pass review |
| Module isolation | Conductor's per-workspace git worktree; task Out of Scope is the boundary |
| Review before merge | Each workspace branch gets `/aeos:review` (code review report) before merge |

## Workspace Setup

Root `conductor.json` defines setup/run scripts executed in every new
workspace. Keep setup idempotent — every worktree runs it fresh.

## Briefing Convention

For task `<task-id>` of change `<change-id>`, the briefing message is:

```
Implement task openspec/changes/<change-id>/tasks/<task-id>.md.
Read your handover and follow aeos/prompts/60-implementation.md.
Do not touch files outside your module scope.
```
````

- [ ] **Step 4: Write root `conductor.json`**

```json
{
  "scripts": {
    "setup": "echo 'AEOS: adapter setup placeholder — install deps for the active framework adapter here'",
    "run": "echo 'AEOS: run placeholder — start the app or test watcher here'"
  }
}
```

- [ ] **Step 5: Verify**

Run: `ls aeos/adapters/_contract.md aeos/adapters/frameworks/laravel/ aeos/adapters/orchestrators/conductor/ conductor.json && grep -c '## ' aeos/adapters/frameworks/laravel/guide-overrides.md`
Expected: all paths listed (laravel shows 3 files); override sections count `12`.

- [ ] **Step 6: Commit**

```bash
git add aeos/adapters/ conductor.json
git commit -m "feat: adapter contract, Laravel placeholder, Conductor orchestrator adapter

Co-Authored-By: Claude Fable 5 <noreply@anthropic.com>"
```

---

### Task 7: Workspace + OpenSpec skeleton — `.ai/` and `openspec/`

**Files:**
- Create: `.ai/idea.md`
- Create: `.ai/blueprint/.gitkeep`
- Create: `.ai/handovers/.gitkeep`
- Create: `.ai/reviews/.gitkeep`
- Create: `.ai/reports/.gitkeep`
- Create: `openspec/project.md`
- Create: `openspec/specs/.gitkeep`
- Create: `openspec/changes/.gitkeep`

**Interfaces:**
- Consumes: workspace layout from Task 1 (CLAUDE.md table).
- Produces: the empty per-project workspace the commands (Task 8) write into.

- [ ] **Step 1: Write `.ai/idea.md`**

````markdown
# Idea

> Template-stage placeholder. Run `/aeos:discover` to replace this with your
> project's idea. Gate G0 reviews this file.

## Problem

## Target Users

## Desired Outcomes

## Constraints

## Success Metrics

## Open Questions
````

- [ ] **Step 2: Write `openspec/project.md`**

````markdown
# Project Context

> Placeholder — `openspec init` and the project team fill this in. The OpenSpec
> CLI reads this for project-wide context. AEOS conventions: change ids used in
> `openspec/changes/<id>/` are reused for `.ai/blueprint/<id>/`,
> `.ai/handovers/<id>/`, `.ai/reports/<id>/`, and `.ai/reviews/<id>-g<n>.md`.

## Purpose

## Tech Stack
<!-- Comes from the activated framework adapter. -->

## Conventions
<!-- See aeos/guide/ and the activated adapter. -->
````

- [ ] **Step 3: Create the four `.gitkeep` files**

```bash
touch .ai/blueprint/.gitkeep .ai/handovers/.gitkeep .ai/reviews/.gitkeep .ai/reports/.gitkeep openspec/specs/.gitkeep openspec/changes/.gitkeep
```

(Create parent directories first if `touch` complains: `mkdir -p .ai/blueprint .ai/handovers .ai/reviews .ai/reports openspec/specs openspec/changes`.)

- [ ] **Step 4: Verify**

Run: `find .ai openspec -type f | sort`
Expected exactly:

```
.ai/blueprint/.gitkeep
.ai/handovers/.gitkeep
.ai/idea.md
.ai/reports/.gitkeep
.ai/reviews/.gitkeep
openspec/changes/.gitkeep
openspec/project.md
openspec/specs/.gitkeep
```

- [ ] **Step 5: Commit**

```bash
git add .ai/ openspec/
git commit -m "feat: per-project workspace (.ai/) and OpenSpec skeleton

Co-Authored-By: Claude Fable 5 <noreply@anthropic.com>"
```

---

### Task 8: Claude Code commands — `.claude/commands/aeos/` (9 files)

**Files:**
- Create: `.claude/commands/aeos/discover.md`
- Create: `.claude/commands/aeos/propose.md`
- Create: `.claude/commands/aeos/design.md`
- Create: `.claude/commands/aeos/blueprint.md`
- Create: `.claude/commands/aeos/handover.md`
- Create: `.claude/commands/aeos/tasks.md`
- Create: `.claude/commands/aeos/review.md`
- Create: `.claude/commands/aeos/report.md`
- Create: `.claude/commands/aeos/status.md`

**Interfaces:**
- Consumes: prompt paths (Task 4), template paths (Task 3), gate rules (Task 2), workspace layout (Task 7).
- Produces: `/aeos:*` slash commands. Shared shape: frontmatter `description`, then numbered instructions: (1) gate/input check, (2) load prompt + template, (3) produce artifact, (4) name the next step.

- [ ] **Step 1: Write the nine command files**

`.claude/commands/aeos/discover.md`:

````markdown
---
description: "AEOS phase 00 — capture the business idea into .ai/idea.md"
---

Run AEOS phase **00-discovery** for: $ARGUMENTS

1. Read `aeos/prompts/00-discovery.md` and follow it exactly.
2. No gate precedes this phase. If `.ai/idea.md` already has content, refine it
   with the human rather than overwriting.
3. Produce `.ai/idea.md` covering: problem, users, outcomes, constraints,
   success metrics, open questions.
4. Finish by telling the human: review `.ai/idea.md` and record gate **G0**
   using `aeos/templates/gate-record.template.md` →
   `.ai/reviews/<change-id>-g0.md`. Next: `/aeos:propose <change-id>`.
````

`.claude/commands/aeos/propose.md`:

````markdown
---
description: "AEOS phase 10 — write the OpenSpec proposal for a change"
---

Run AEOS phase **10-proposal** for change id: $ARGUMENTS

1. **Gate check:** verify `.ai/reviews/<change-id>-g0.md` exists and contains
   `Decision: APPROVED`. If not, STOP and tell the human gate G0 is missing.
2. Read `aeos/prompts/10-proposal.md` and follow it exactly, with `.ai/idea.md`
   and `openspec/specs/` as inputs.
3. Produce `openspec/changes/<change-id>/proposal.md`; run
   `openspec validate <change-id>` if the CLI is installed.
4. Finish by telling the human: approve the proposal, then `/aeos:design
   <change-id>`.
````

`.claude/commands/aeos/design.md`:

````markdown
---
description: "AEOS phase 20 — write design.md and spec deltas for a change"
---

Run AEOS phase **20-design** for change id: $ARGUMENTS

1. **Input check:** verify `openspec/changes/<change-id>/proposal.md` exists.
   If not, STOP — run `/aeos:propose` first.
2. Read `aeos/prompts/20-design.md` and follow it exactly, with the proposal,
   `openspec/specs/`, and `aeos/guide/architecture-constraints.md` (+ active
   adapter overrides) as inputs.
3. Produce `openspec/changes/<change-id>/design.md` and spec deltas under
   `openspec/changes/<change-id>/specs/`.
4. Finish by telling the human: approve the design, then `/aeos:blueprint
   <change-id>`.
````

`.claude/commands/aeos/blueprint.md`:

````markdown
---
description: "AEOS phase 30 — decompose the design into modules and waves"
---

Run AEOS phase **30-blueprint** for change id: $ARGUMENTS

1. **Input check:** verify `openspec/changes/<change-id>/design.md` exists.
   If not, STOP — run `/aeos:design` first.
2. Read `aeos/prompts/30-blueprint.md` and follow it exactly.
3. Produce `.ai/blueprint/<change-id>/blueprint.md`: every module with name,
   purpose, boundary, dependencies, wave; dependency graph acyclic.
4. Finish by telling the human: approve the blueprint, then `/aeos:handover
   <change-id>`.
````

`.claude/commands/aeos/handover.md`:

````markdown
---
description: "AEOS phase 40 — write one handover document per blueprint module"
---

Run AEOS phase **40-handover** for change id: $ARGUMENTS

1. **Input check:** verify `.ai/blueprint/<change-id>/blueprint.md` exists.
   If not, STOP — run `/aeos:blueprint` first.
2. Read `aeos/prompts/40-handover.md` and follow it exactly, using
   `aeos/templates/handover.template.md` for every module.
3. Produce `.ai/handovers/<change-id>/<module>.handover.md` for each blueprint
   module — all 11 sections filled; provider/consumer APIs and events must
   match pairwise.
4. Finish by telling the human: next is `/aeos:tasks <change-id>`.
````

`.claude/commands/aeos/tasks.md`:

````markdown
---
description: "AEOS phase 50 — slice handovers into atomic tasks for parallel agents"
---

Run AEOS phase **50-tasks** for change id: $ARGUMENTS

1. **Input check:** verify `.ai/handovers/<change-id>/` contains at least one
   `*.handover.md`. If not, STOP — run `/aeos:handover` first.
2. Read `aeos/prompts/50-tasks.md` and follow it exactly, using
   `aeos/templates/task.template.md` per task. Verification commands come from
   the active framework adapter's `verification.md`.
3. Produce `openspec/changes/<change-id>/tasks.md` (index) plus one file per
   task under `openspec/changes/<change-id>/tasks/`; `depends_on` acyclic,
   waves consistent with the blueprint.
4. Finish by telling the human: review the full Stage-1 set and record gate
   **G1** → `.ai/reviews/<change-id>-g1.md`. After G1, hand off to the
   orchestrator (see `docs/conductor-mapping.md`).
````

`.claude/commands/aeos/review.md`:

````markdown
---
description: "AEOS phase 70 — produce review report artifacts and gate records"
---

Run AEOS phase **70-review** for change id: $ARGUMENTS

1. **Gate check:** verify `.ai/reviews/<change-id>-g1.md` exists with
   `Decision: APPROVED` (Stage 2 must have been authorized). If not, STOP.
2. Read `aeos/prompts/70-review.md`. Ask the human which review to run (code
   review / security / performance / integration / release readiness) if not
   given in the arguments.
3. Produce `.ai/reports/<change-id>/report-<type>.md` from the matching
   template in `aeos/templates/`. Verdicts need evidence.
4. When all six reports exist (including `/aeos:report` outputs), tell the
   human: decide gate **G2** → `.ai/reviews/<change-id>-g2.md`. After G2:
   deploy, then `openspec archive <change-id>`.
````

`.claude/commands/aeos/report.md`:

````markdown
---
description: "AEOS phase 80 — produce the test coverage report"
---

Run AEOS phase **80-testing** for change id: $ARGUMENTS

1. **Gate check:** verify `.ai/reviews/<change-id>-g1.md` exists with
   `Decision: APPROVED`. If not, STOP.
2. Read `aeos/prompts/80-testing.md` and follow it exactly; measure against
   every handover's §11 Testing Expectations, using the adapter's test
   commands.
3. Produce `.ai/reports/<change-id>/report-test-coverage.md` — real numbers or
   explicit gaps.
4. Finish by telling the human: this feeds the release-readiness report
   (`/aeos:review <change-id> release-readiness`) and gate **G2**.
````

`.claude/commands/aeos/status.md`:

````markdown
---
description: "Show where every AEOS change sits in the lifecycle"
---

Report AEOS lifecycle status. For each change id found in `openspec/changes/`
(and any `.ai/` artifacts without a change folder yet):

1. Check which artifacts exist: idea (`.ai/idea.md`), proposal, design,
   blueprint (`.ai/blueprint/<id>/`), handovers (`.ai/handovers/<id>/`), tasks,
   reports (`.ai/reports/<id>/`).
2. Check which gate records exist in `.ai/reviews/` and their Decision lines.
3. Print a table: change id · furthest completed phase · last passed gate ·
   next action (the exact `/aeos:*` command or gate to record).
4. Flag inconsistencies: artifacts present without their preceding gate record,
   or gate records referencing missing artifacts.
````

- [ ] **Step 2: Verify**

Run: `ls .claude/commands/aeos/ | wc -l && grep -l '^description:' .claude/commands/aeos/*.md | wc -l && grep -l 'STOP' .claude/commands/aeos/*.md | wc -l`
Expected: `9`, `9`, `7` (all except `discover.md` and `status.md` contain a STOP check).

- [ ] **Step 3: Commit**

```bash
git add .claude/
git commit -m "feat: /aeos slash commands with gate enforcement

Co-Authored-By: Claude Fable 5 <noreply@anthropic.com>"
```

---

### Task 9: Documentation — `docs/` (4 files)

**Files:**
- Create: `docs/architecture.md`
- Create: `docs/workflow.md`
- Create: `docs/openspec-mapping.md`
- Create: `docs/conductor-mapping.md`

**Interfaces:**
- Consumes: everything — this task documents the finished system, so exact paths/names from Tasks 1–8 must be used.
- Produces: the reference docs linked from README.

- [ ] **Step 1: Write `docs/architecture.md`**

````markdown
# AEOS Architecture

AEOS separates three lifecycles by *rate and direction of change*:

| Home | Role | Mutability |
|------|------|-----------|
| `aeos/` | **The System** — prompts, templates, workflows, guide, adapters | Immutable per-project; upgrade = sync from upstream AEOS |
| `openspec/` | **The Spec Lifecycle** — OpenSpec CLI territory (`specs/` = current truth, `changes/<id>/` = active change) | Managed by `openspec` tooling |
| `.ai/` | **The Workspace** — idea, blueprint, handovers, reviews, reports | Mutable, born per-project |

AEOS never duplicates what OpenSpec owns; it wraps the spec lifecycle with
human gates and richer artifacts, cross-linked by a shared `<change-id>`.

## Artifact Contract

Every artifact template (`aeos/templates/`) opens with machine-readable
frontmatter: `artifact, phase, owner, inputs, outputs, purpose, validation`.
An artifact is valid only when its validation criteria hold.

## Artifact Dependency Graph

```
idea → proposal → design → blueprint → handovers → tasks → [G1] → code
                     ↘ spec deltas ─────────────────────────↗ (agent context)
code → review + test + integration + security reports → [G2] → deploy → archive
```

Per-phase owner/inputs/outputs/validation: `aeos/workflows/phases.md`.
Gate definitions: `aeos/workflows/gates.md`.

## Extensibility

Stack and tool specifics live only in `aeos/adapters/` (contract:
`aeos/adapters/_contract.md`). Framework adapters (Laravel first; .NET,
NestJS, Spring Boot, Django, FastAPI later) fill `<!-- adapter-override -->`
markers in `aeos/guide/` and supply verification commands. Orchestrator
adapters (Conductor first) bind Stage 2 to a concrete tool. The lifecycle is
identical regardless of adapter.
````

- [ ] **Step 2: Write `docs/workflow.md`**

````markdown
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
````

- [ ] **Step 3: Write `docs/openspec-mapping.md`**

````markdown
# AEOS ⇄ OpenSpec Mapping

AEOS uses the real OpenSpec CLI conventions — `openspec/specs/` (current
truth) and `openspec/changes/<id>/` (proposal.md, design.md, tasks.md, spec
deltas) — so `openspec validate`, `list`, and `archive` work natively.

## Phase Mapping

| AEOS phase | OpenSpec concept |
|------------|------------------|
| 00-discovery | upstream of `propose` — no OpenSpec equivalent |
| 10-proposal | `openspec/changes/<id>/proposal.md` (`propose`) |
| 20-design | `design.md` + spec deltas under `changes/<id>/specs/` |
| 50-tasks | `tasks.md` (+ AEOS adds per-task files in `tasks/`) |
| Stage 2 | `apply` — implementing the change |
| post-deployment | `archive` — deltas merge into `specs/`, change closes |

## Gaps → Extensions, Not Workarounds

OpenSpec has no concept of blueprint, handover, gate record, or report.
These are **AEOS extension artifacts** in `.ai/`, cross-linked by the shared
change id:

| AEOS extension | Location | Fills the gap |
|----------------|----------|---------------|
| Blueprint | `.ai/blueprint/<id>/` | module decomposition between design and tasks |
| Handovers | `.ai/handovers/<id>/` | per-module implementation contracts |
| Gate records | `.ai/reviews/<id>-g<n>.md` | versioned human approvals |
| Reports | `.ai/reports/<id>/` | Stage 2 quality evidence |

## Proposed Upstream Extension

If OpenSpec later supports custom artifacts inside a change, AEOS would move
its extensions to `openspec/changes/<id>/aeos/` (blueprint/, handovers/,
reviews/, reports/) so a change folder is fully self-contained. Until then,
`.ai/` keeps OpenSpec tooling unbroken — no workarounds inside `openspec/`.
````

- [ ] **Step 4: Write `docs/conductor-mapping.md`**

````markdown
# Orchestrator Contract & Conductor Mapping

Stage 2 is defined against an abstract **Orchestrator Contract** so the
engineering stage never depends on one tool. Conductor is the first adapter
(`aeos/adapters/orchestrators/conductor/`).

## Orchestrator Contract

Any orchestrator MUST satisfy:

- **Inputs:** approved G1 gate record (`.ai/reviews/<id>-g1.md`); task files
  (`openspec/changes/<id>/tasks/`); handovers (`.ai/handovers/<id>/`);
  engineering guide + active framework adapter.
- **Outputs:** one reviewed branch per task, merged per wave.
- **Spawning:** one agent per task. Briefing = task file + its handover +
  `aeos/prompts/60-implementation.md`.
- **Waves:** topological sort of task `depends_on`; wave N+1 starts only after
  wave N review passes.
- **Isolation:** one git worktree per agent; the task's module scope and Out of
  Scope section are hard boundaries.
- **Review flow:** every branch gets a code review report before merge.

## Where Conductor Begins

Conductor begins **only after G1 is recorded**. Nothing in Stage 1 involves it.

## Conductor Mapping

See `aeos/adapters/orchestrators/conductor/README.md` for the concrete mapping
(one workspace per task, briefing convention, `conductor.json` setup scripts).

## Swapping Orchestrators

Claude Code subagents, CI-driven agents, or any future tool can replace
Conductor by adding an adapter under `aeos/adapters/orchestrators/` that
documents how it satisfies this contract. Stage 1 artifacts do not change.
````

- [ ] **Step 5: Verify**

Run: `ls docs/*.md | wc -l && grep -c 'Orchestrator Contract' docs/conductor-mapping.md && grep -c 'aeos/' docs/architecture.md`
Expected: `4`; `>=2`; `>=4`.

- [ ] **Step 6: Commit**

```bash
git add docs/architecture.md docs/workflow.md docs/openspec-mapping.md docs/conductor-mapping.md
git commit -m "docs: architecture, workflow, OpenSpec mapping, orchestrator contract

Co-Authored-By: Claude Fable 5 <noreply@anthropic.com>"
```

---

### Task 10: Final structural verification

**Files:**
- None created; verification only.

**Interfaces:**
- Consumes: the whole repository.

- [ ] **Step 1: Verify the full tree matches the spec**

Run: `find . -type f -not -path './.git/*' -not -path './docs/superpowers/*' | sort`

Expected exactly (58 files):

```
./.ai/blueprint/.gitkeep
./.ai/handovers/.gitkeep
./.ai/idea.md
./.ai/reports/.gitkeep
./.ai/reviews/.gitkeep
./.claude/commands/aeos/blueprint.md
./.claude/commands/aeos/design.md
./.claude/commands/aeos/discover.md
./.claude/commands/aeos/handover.md
./.claude/commands/aeos/propose.md
./.claude/commands/aeos/report.md
./.claude/commands/aeos/review.md
./.claude/commands/aeos/status.md
./.claude/commands/aeos/tasks.md
./.gitignore
./CLAUDE.md
./README.md
./aeos/adapters/_contract.md
./aeos/adapters/frameworks/laravel/README.md
./aeos/adapters/frameworks/laravel/guide-overrides.md
./aeos/adapters/frameworks/laravel/verification.md
./aeos/adapters/orchestrators/conductor/README.md
./aeos/guide/architecture-constraints.md
./aeos/guide/coding-standards.md
./aeos/guide/ddd-rules.md
./aeos/guide/folder-conventions.md
./aeos/guide/naming.md
./aeos/guide/review-rules.md
./aeos/guide/solid.md
./aeos/guide/testing-rules.md
./aeos/prompts/00-discovery.md
./aeos/prompts/10-proposal.md
./aeos/prompts/20-design.md
./aeos/prompts/30-blueprint.md
./aeos/prompts/40-handover.md
./aeos/prompts/50-tasks.md
./aeos/prompts/60-implementation.md
./aeos/prompts/70-review.md
./aeos/prompts/80-testing.md
./aeos/templates/gate-record.template.md
./aeos/templates/handover.template.md
./aeos/templates/report-code-review.template.md
./aeos/templates/report-integration.template.md
./aeos/templates/report-performance.template.md
./aeos/templates/report-release-readiness.template.md
./aeos/templates/report-security.template.md
./aeos/templates/report-test-coverage.template.md
./aeos/templates/task.template.md
./aeos/workflows/gates.md
./aeos/workflows/phases.md
./conductor.json
./docs/architecture.md
./docs/conductor-mapping.md
./docs/openspec-mapping.md
./docs/workflow.md
./openspec/changes/.gitkeep
./openspec/project.md
./openspec/specs/.gitkeep
```

- [ ] **Step 2: Cross-reference check — no dangling paths**

Run: `grep -rho 'aeos/[a-z/-]*\.md' README.md CLAUDE.md docs/ .claude/ aeos/prompts/ | sort -u | while read f; do [ -f "$f" ] || echo "MISSING: $f"; done`
Expected: no output (every referenced framework file exists).

- [ ] **Step 3: Constraint check — framework names only in adapters**

Run: `grep -ril 'laravel' --exclude-dir=.git --exclude-dir=superpowers . | grep -v 'aeos/adapters/' | grep -v 'README.md' | grep -v 'docs/architecture.md'`
Expected: no output. (README and docs/architecture.md name Laravel only as the first-adapter example, which the spec itself does; all other mentions must be inside `aeos/adapters/`.)

- [ ] **Step 4: Verify clean git state and history**

Run: `git status --porcelain && git log --oneline`
Expected: empty status; ~10 commits (spec, plan, then one per task 1–9).

- [ ] **Step 5: Commit any stragglers (only if Step 4 showed dirt)**

```bash
git add -A && git commit -m "chore: final structural fixes from verification

Co-Authored-By: Claude Fable 5 <noreply@anthropic.com>"
```
