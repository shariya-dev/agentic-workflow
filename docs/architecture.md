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
Stage 1 (design, no code):
  idea → PRD → domain → architecture(+deltas) → ADRs → engineering guide → [G1]
Stage 2 (foundation):
  golden module → frozen contracts → handovers → blueprint + tasks → [G2]
Stage 3 (parallel build):
  code → test + review + integration + security + performance → [G3] → docs → deploy → archive
```

Every Stage-3 agent receives only six things: Golden Module, Engineering Guide,
Architecture, Contracts, its own Handover, its own Tasks.

Per-phase owner/inputs/outputs/validation: `aeos/workflows/phases.md`.
Gate definitions: `aeos/workflows/gates.md`.

## Extensibility

Stack and tool specifics live only in `aeos/adapters/` (contract:
`aeos/adapters/_contract.md`). Framework adapters (Laravel first; .NET,
NestJS, Spring Boot, Django, FastAPI later) fill `<!-- adapter-override -->`
markers in `aeos/guide/` and supply verification commands. Orchestrator
adapters (Conductor first) bind Stage 2 to a concrete tool. The lifecycle is
identical regardless of adapter.
