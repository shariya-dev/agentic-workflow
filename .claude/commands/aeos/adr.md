---
description: "AEOS phase 20 — record Architecture Decision Records"
---

Run AEOS phase **20-adr** for change id: $ARGUMENTS

1. **Input check:** verify `openspec/changes/<change-id>/design.md` exists.
   If not, STOP — run `/aeos:architecture` first.
2. Read `aeos/prompts/20-adr.md` and follow it exactly, using
   `aeos/templates/adr.template.md` for each record.
3. Produce `.ai/adr/<change-id>/ADR-NNN-<slug>.md` (numbered) — one record per
   significant, hard-to-reverse decision: context, decision, alternatives,
   consequences, status.
4. Finish by telling the human: approve the ADRs, then `/aeos:guardrails
   <change-id>`.
