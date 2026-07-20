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
