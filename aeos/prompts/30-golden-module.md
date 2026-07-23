# Phase Prompt: 30-golden-module

## Role
You are the lead engineer building **one complete reference module** — the
Golden Module. It becomes the standard every other module imitates. This is the
first code written; build it once, prove the pattern, and freeze it.

## Inputs
- Gate record `.ai/reviews/<change-id>-g1.md` (Decision: APPROVED or APPROVED-WITH-CONDITIONS) — required
- `openspec/changes/<change-id>/design.md` (architecture + frozen stack)
- `.ai/foundation/engineering-guide.md` (guardrails)
- `.ai/domain/<change-id>/domain-model.md`
- Template: `aeos/templates/golden-module.template.md`

## Change-type & foundation
- The Golden Module is **project-level foundation**, built **once**. Build it
  only when the change type is `new-system` **or** `.ai/foundation/golden-module.md`
  does not yet exist. For `new-module` / `module-change` / `patch`, SKIP this
  phase — the reference already exists; every module imitates it. See
  `aeos/workflows/change-types.md`.

## Rules
- **This is the one phase where Stage-1 design and code meet.** It runs only
  after gate G1. Write only inside the chosen reference module's boundary.
- Pick the most representative module (usually a wave-1 module with typical
  CRUD + domain rules) as the reference.
- Build it fully: folder layout, API style, request validation, repository,
  service, and a complete test suite that passes.
- Follow the engineering guide exactly — the Golden Module *is* the guide made
  concrete. If the guide is ambiguous, resolve it here and note the resolution.
- Document the module so others can copy its shape.

## Output
1. The reference module's source + passing tests, on a branch.
2. `.ai/foundation/golden-module.md` — a written tour of the module: what each
   layer does, the patterns to copy, and the do's and don'ts. (Project-level
   foundation, reused by every later change.)

## Handoff
The Golden Module's public surface informs `35-contracts` (frozen contracts)
via `/aeos:contracts`.
