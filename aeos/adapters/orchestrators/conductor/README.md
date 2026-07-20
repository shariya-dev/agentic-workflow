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
