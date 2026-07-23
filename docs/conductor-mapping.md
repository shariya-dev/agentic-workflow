# Orchestrator Contract & Conductor Mapping

Stage 3 (parallel development) is defined against an abstract **Orchestrator
Contract** so the build stage never depends on one tool. Conductor is the first
adapter (`aeos/adapters/orchestrators/conductor/`).

## Orchestrator Contract

Any orchestrator MUST satisfy:

- **Inputs:** approved G2 gate record (`.ai/reviews/<id>-g2.md`); task files
  (`openspec/changes/<id>/tasks/`); and each agent's six context-isolated
  inputs — Golden Module, Engineering Guide, Architecture, Contracts, its module
  Handover, its Task.
- **Outputs:** one reviewed branch per task, merged per wave.
- **Spawning:** one agent per task. Briefing = the six inputs above +
  `aeos/prompts/50-implementation.md`. The agent receives **nothing else**.
- **Waves:** topological sort of task `depends_on` (Golden Module is wave 0);
  wave N+1 starts only after wave N review passes.
- **Isolation:** one git worktree per agent; the task's module scope and Out of
  Scope section are hard boundaries.
- **Review flow:** every branch gets a code review report before merge.

## Where Conductor Begins

Conductor begins **only after G2 is recorded**. Nothing in Stages 1–2 involves
it.

## Conductor Mapping

See `aeos/adapters/orchestrators/conductor/README.md` for the concrete mapping
(one workspace per task, briefing convention, `conductor.json` setup scripts).

## Swapping Orchestrators

Claude Code subagents, CI-driven agents, or any future tool can replace
Conductor by adding an adapter under `aeos/adapters/orchestrators/` that
documents how it satisfies this contract. Stage 1 artifacts do not change.
