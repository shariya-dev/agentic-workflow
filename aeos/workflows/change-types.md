# AEOS Change Types & Right-Sizing

Not every change runs all 18 phases. Most phases produce **foundation** — the
Golden Module, Engineering Guide, base architecture, and base contracts — which
is built **once** and reused by every later change. A change *consumes* the
foundation; it does not regenerate it.

Every change declares a **Change-Type** in its G0 gate record. That type selects
which phases run, which foundation is reused, and which gates apply.

## The four change types

| Type | When | Phases that run | Reuses (from `.ai/foundation/`) | Gates |
|------|------|-----------------|----------------------------------|-------|
| `new-system` | Greenfield, or a major new subsystem with new patterns | **All** — the one time the Golden Module, Engineering Guide, base architecture and base contracts are created | — (creates the foundation) | G0 · G1 · G2 · G3 |
| `new-module` | Add a module to an existing system | requirements → domain *delta* → (architecture *delta* only if new patterns) → contracts *delta* (freeze new shared interfaces) → handover(new module) → tasks → implement → test → review → docs | Golden Module, Engineering Guide, base architecture, base contracts | G0 · G2 · G3 (G1 only if architecture is extended) |
| `module-change` | Modify an existing module's behavior | requirements → (ADR only if a real decision) → update handover → tasks → implement → test → review | Golden Module, Engineering Guide, architecture, contracts | G0 (lightweight) · G2 · G3 |
| `patch` | Bug fix / small tweak, one module, no shared-contract change | requirements(impact note) → implement → test → review | everything — Golden Module, guide, architecture, contracts, handover | one combined approval recorded as G3 |

## Foundation reuse rules

`.ai/foundation/` holds the project-level assets, created on the `new-system`
change and reused thereafter:

- `.ai/foundation/golden-module.md` — the reference module (+ its source).
- `.ai/foundation/engineering-guide.md` — the pinned standards.
- `.ai/foundation/architecture.md` — base architecture style + frozen tech stack.
- `.ai/foundation/contracts.md` — base shared contracts.

Foundation-producing commands follow this rule:

- **If** the change type is `new-system` **or** the foundation asset is missing →
  create it (write to `.ai/foundation/`).
- **Else** → skip the phase and reuse the foundation. Per-change *deltas* (e.g. a
  new module's contracts) are written to the per-change location
  (`.ai/contracts/<id>/`) and layered on top of the foundation.

A change that *changes the foundation itself* (new cross-cutting pattern, a
contract every module depends on) is a `new-system`-level change even if it feels
small — because it invalidates the reused assets. Treat it as such.

## Gate right-sizing

- **G2** (authorize build) applies to **every** type — it is the universal
  build-authorization gate; nothing is implemented without it.
- **G3** (ship) applies to **every** type.
- **G0** applies to every type but is lightweight for `patch`/`module-change`.
- **G1** (design freeze) applies only when the change does design work
  (`new-system`, or `new-module`/`module-change` that extends the architecture).
  Types that skip the design phases do not need G1, and no command they run
  requires it.

## How the type is set

1. `/aeos:discover` proposes a type from the scope of the idea.
2. The human confirms it in the **G0 gate record** (`Change-Type:` field) —
   authoritative.
3. Every downstream command reads that field and follows the matching row above.
   `/aeos:status` shows the type and the remaining path.
