# AEOS — AI Engineering Operating System

**Version 2.0** · A reusable agentic software engineering framework.

> 🟢 **New to all this / not a developer?** Follow the
> **[Beginner's Installation Guide (INSTALL.md)](INSTALL.md)** — a no-experience-
> needed, copy-paste walkthrough for macOS and Windows.

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

Design first, prove the pattern once with a **Golden Module**, freeze the
**Contracts**, then build every module in parallel against them.

```
Stage 1 — Design (no code)
  idea → [G0] → PRD → domain → architecture → ADRs → engineering guide → [G1]

Stage 2 — Foundation (first code)
  [G1] → golden module → freeze contracts → handovers → blueprint + tasks → [G2]

Stage 3 — Parallel Build & Release
  [G2] → parallel agents in waves → testing → review → integration → security
       → performance → [G3] → docs → deployment → openspec archive
```

Gates `G0/G1/G2/G3` are human decisions recorded as files in `.ai/reviews/`.
Nothing crosses a gate without its record. Every Stage-3 agent receives only six
things: the Golden Module, Engineering Guide, Architecture, Contracts, its own
Handover, and its own Tasks.

## Install

AEOS is an **overlay**: it lays its homes (`aeos/`, `.claude/commands/aeos/`,
`docs/aeos/`, `.ai/`, and a `CLAUDE.md` block) on top of a project — new or
existing — without clobbering anything you already have.

Install it with one command, from **inside your project** (needs
[Node.js](https://nodejs.org) ≥ 16 — works on macOS, Linux, and Windows
PowerShell/CMD):

```bash
cd /path/to/your/project
npx @aeos/cli init                 # add --dry-run to preview first
```

Then finish setup:

```bash
npm install -g @fission-ai/openspec
openspec init --tools claude --force
```

The installer is **safe and idempotent**: it only adds files that are missing,
never overwrites your existing files, and a second run is a no-op. It backs up
`CLAUDE.md` (`*.aeos-bak`) before touching it, and supports `--dry-run` and
removal (`npx @aeos/cli remove`). See
[INSTALL.md](INSTALL.md) for the full guarantees and a beginner walkthrough.

> **No Node, or prefer git?** A clone-and-run installer is also available:
> `git clone https://github.com/shariya-dev/agentic-workflow.git ~/aeos-template`
> then, from your project, `~/aeos-template/bin/aeos-install.sh`. Both installers
> are equivalent. Not a developer? Follow the
> **[beginner's guide (INSTALL.md)](INSTALL.md)**.

Once installed:

1. Pick a framework adapter in `aeos/adapters/frameworks/` (Laravel is first).
2. Open the project in Claude Code and run `/aeos:discover` to capture the idea.
3. Follow the lifecycle: `/aeos:requirements → /aeos:domain → /aeos:architecture
   → /aeos:adr → /aeos:guardrails` (Stage 1), then `/aeos:golden →
   /aeos:contracts → /aeos:handover → /aeos:tasks` (Stage 2), approving each
   gate as you go.
4. After G2 approval, hand `openspec/changes/<id>/` + `.ai/handovers/<id>/` to
   the orchestrator (Conductor) for parallel development (`/aeos:implement`).
5. `/aeos:status` shows where every change sits in the lifecycle.

**New to AEOS?** Read **[getting-started.md](docs/getting-started.md)** (the
ten-minute version) then the **[User Guide](docs/user-guide.md)** — every phase
with when/what/why/how, examples, and a workflow diagram.

## Repository Map

- `docs/` — architecture, workflow, OpenSpec mapping, Conductor mapping,
  **[getting started](docs/getting-started.md)**, **[user guide](docs/user-guide.md)**
- `aeos/prompts/` — one prompt per phase (`00-discovery` … `65-documentation`)
- `aeos/templates/` — artifact contracts (PRD, domain, ADR, engineering guide,
  golden module, contracts, blueprint, handover, task, gate record, reports)
- `aeos/workflows/` — phase registry and gate definitions
- `aeos/guide/` — engineering guide skeleton (standards, DDD, SOLID, testing…)
- `aeos/adapters/` — framework + orchestrator adapters
- `openspec/` — OpenSpec CLI territory
- `.ai/` — per-project workspace (idea, domain, adr, engineering-guide, golden,
  contracts, handovers, blueprint, reviews, reports)
- `.claude/commands/aeos/` — executable phase commands
