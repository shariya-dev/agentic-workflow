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
