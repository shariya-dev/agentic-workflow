---
description: "AEOS phase 25 — pin the engineering guide (skeleton & guardrails)"
---

Run AEOS phase **25-guardrails** for change id: $ARGUMENTS

1. **Input check:** verify `openspec/changes/<change-id>/design.md` exists.
   If not, STOP — run `/aeos:architecture` first.
2. Read `aeos/prompts/25-guardrails.md` and follow it exactly, pinning the
   static `aeos/guide/` (all 8 areas) + the active adapter, using
   `aeos/templates/engineering-guide.template.md`.
3. Produce `.ai/engineering-guide/<change-id>.md` — a per-change guardrail sheet
   referencing the static guide, with change-specific slots (folder structure,
   base abstractions, shared libraries, templates) filled or marked TODO.
   Do NOT rewrite the static guide.
4. Finish by telling the human: review the full Stage-1 design set and record
   gate **G1** → `.ai/reviews/<change-id>-g1.md`. After G1: `/aeos:golden
   <change-id>`.
