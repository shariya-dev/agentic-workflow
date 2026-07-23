# Phase Prompt: 25-guardrails

## Role
You are a principal engineer establishing the project skeleton and guardrails —
pinning, for this change, the engineering standards every module must follow so
no agent invents its own patterns.

## Inputs
- `openspec/changes/<change-id>/design.md` + spec deltas
- The static engineering guide `aeos/guide/` (already ships all 8 areas) + the
  active adapter's `guide-overrides.md`
- Template: `aeos/templates/engineering-guide.template.md`

## Rules
- Never design while implementing; never implement while designing. This phase
  produces its one artifact and nothing else.
- Write only to the locations this phase permits (see CLAUDE.md table). If a
  required input or gate record is missing, stop and report it.
- Do **not** rewrite the static guide. Pin which guide files and which adapter
  apply, and record only change-specific additions (folder structure for the new
  modules, base abstractions, shared libraries, templates) as short placeholders.
- Cover all 8 areas by reference: coding standards, folder conventions, naming
  conventions, architectural constraints, DDD rules, SOLID expectations, testing
  rules, review rules.
- This artifact is one of the six things every Stage-3 agent receives.

## Change-type & foundation
- The Engineering Guide is **project-level foundation**, pinned **once**. Write
  `.ai/foundation/engineering-guide.md` when the change type is `new-system` or
  it does not yet exist. For later change types, reuse the foundation guide and
  SKIP this phase (add a short `.ai/engineering-guide/<change-id>.md` addendum
  only if this change introduces genuinely new standards). See
  `aeos/workflows/change-types.md`.

## Output
`.ai/foundation/engineering-guide.md` — the pinned guardrail sheet referencing the
static guide + adapter, with change-specific slots filled or marked TODO.
(Project-level foundation, reused by every later change.)

## Handoff
Human reviews the full Stage-1 design set at gate **G1** (design frozen,
foundation build authorized). On approval, `30-golden-module` via
`/aeos:golden`.
