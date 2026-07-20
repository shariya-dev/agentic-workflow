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

## Install

AEOS is an **overlay**: it lays its homes (`aeos/`, `.claude/commands/aeos/`,
`docs/aeos/`, `.ai/`, and a `CLAUDE.md` block) on top of a project — new or
existing — without clobbering anything you already have.

```bash
# 1. Clone the template anywhere (this is the AEOS source, not your project).
git clone git@github.com:shariya-dev/agentic-workflow.git ~/aeos-template

# 2. From INSIDE your project, run the installer.
cd /path/to/your/project
~/aeos-template/bin/aeos-install.sh            # add --dry-run to preview first
```

The installer is **safe and idempotent**: it only adds files that are missing,
never overwrites your existing files, and a second run is a no-op. See
[Installing into an existing project](docs/user-manual.md#1-install) for the
non-destructive guarantees, backups (`*.aeos-bak`), `--dry-run`, and
`--uninstall`.

Then finish setup:

1. Install the OpenSpec CLI and run `openspec init` (the installer tells you
   whether it created `openspec/` or left your existing one in place).
2. Pick a framework adapter in `aeos/adapters/frameworks/` (Laravel is first).
3. Open the project in Claude Code and run `/aeos:discover` to capture the idea.
4. Follow the lifecycle: `/aeos:propose → /aeos:design → /aeos:blueprint →
   /aeos:handover → /aeos:tasks`, approving each gate as you go.
5. After G1 approval, hand `openspec/changes/<id>/` + `.ai/handovers/<id>/` to
   the orchestrator (Conductor) for parallel development.
6. `/aeos:status` shows where every change sits in the lifecycle.

**New to AEOS? Read the [User Manual](docs/user-manual.md)** — a step-by-step
walkthrough of the full lifecycle with a worked example.

## Repository Map

- `docs/` — architecture, workflow, OpenSpec mapping, Conductor mapping,
  **[user manual](docs/user-manual.md)**
- `aeos/prompts/` — one prompt per phase (`00-discovery` … `80-testing`)
- `aeos/templates/` — artifact contracts (handover, task, gate record, reports)
- `aeos/workflows/` — phase registry and gate definitions
- `aeos/guide/` — engineering guide skeleton (standards, DDD, SOLID, testing…)
- `aeos/adapters/` — framework + orchestrator adapters
- `openspec/` — OpenSpec CLI territory
- `.ai/` — per-project workspace
- `.claude/commands/aeos/` — executable phase commands
