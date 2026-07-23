# Getting Started with AEOS

New here? This is the shortest path from "I have an idea" to "it's shipped."
Read it once, top to bottom. It walks through one complete example so you can see
the whole shape before you try it yourself.

---

## What AEOS is, in one breath

AEOS is a way of building software with AI where you **design first, prove the
pattern once, freeze the shared rules, then let many AI agents build in
parallel** — with a human saying "yes, go" at four key moments.

You work through a fixed set of phases. Each phase produces **one document** (or,
once, one reference module). Each feeds the next. You run each phase with a short
command in Claude Code.

Three stages:
- **Stage 1 — Design.** Turn an idea into an approved, technology-frozen plan.
- **Stage 2 — Foundation.** Build one perfect *Golden Module*, freeze the shared
  *Contracts*, and write each module's *Handover*.
- **Stage 3 — Build.** Many agents build the rest in parallel, then it's tested,
  reviewed, hardened, and shipped.

Four approval **gates** (G0–G3) sit between the risky transitions. A gate is a
committed file that says "approved."

---

## The whole flow at a glance

```
STAGE 1 — DESIGN (no code)
  Discover → [G0] → Requirements → Domain → Architecture → ADRs → Guardrails → [G1]
STAGE 2 — FOUNDATION (first code)
  Golden Module → Freeze Contracts → Handovers → Blueprint+Tasks → [G2]
STAGE 3 — BUILD & RELEASE
  Parallel Dev → Testing → Review/Security/Perf → [G3] → Docs → Deploy → Archive
```

---

## What you need

1. **Git** — your project must be a git repo (every decision is a tracked file).
2. **Claude Code** — where you type the commands.

Useful soon after: **OpenSpec** (keeps specs tidy) and **Conductor** (runs the
parallel agents in Stage 3).

> First time with a terminal? Read **[INSTALL.md](../INSTALL.md)** first.

---

## Install AEOS into your project

From inside your project folder:
```bash
npx @aeos/cli init --dry-run   # preview — writes nothing
npx @aeos/cli init             # install
```
Open the project in Claude Code; the `/aeos:*` commands are ready.

---

## The two rules to remember

1. **Never design and build at the same time.** The only exception is the Golden
   Module — and it's gated on both sides.
2. **Stage 3 agents are blindfolded on purpose.** Each parallel agent gets *only*
   the Golden Module, Engineering Guide, Architecture, Contracts, its own
   Handover, and its own Tasks. That's what stops them inventing conflicting
   patterns.

---

## A complete example, start to finish

Let's add a **password reset** feature. Its change id — shared by every
document — is `password-reset`. After each command, review the output before
moving on.

### Stage 1 — Design

**1. Describe the idea**
```
/aeos:discover let users reset their password by email
```
→ writes `.ai/idea.md` (the problem, not the solution).

**2. Gate G0 — worth building?** Copy `aeos/templates/gate-record.template.md`
to `.ai/reviews/password-reset-g0.md`, set `Decision: APPROVED`, commit.

**3. Requirements (PRD)**
```
/aeos:requirements password-reset
```
→ `openspec/changes/password-reset/proposal.md` (requirements, user stories,
acceptance criteria).

**4. Domain model**
```
/aeos:domain password-reset
```
→ `.ai/domain/password-reset/domain-model.md` (entities like ResetToken, the
rules, the events).

**5. Architecture (+ freeze the stack)**
```
/aeos:architecture password-reset
```
→ `design.md` + spec deltas.

**6. ADRs**
```
/aeos:adr password-reset
```
→ `.ai/adr/password-reset/ADR-001-*.md` (e.g. "why signed tokens, not DB
lookups").

**7. Engineering Guide**
```
/aeos:guardrails password-reset
```
→ `.ai/engineering-guide/password-reset.md` (pins the standards every module
follows).

**8. Gate G1 — design frozen.** Record `.ai/reviews/password-reset-g1.md` →
`APPROVED`. **No code exists yet — this is the last cheap moment to change
direction.**

### Stage 2 — Foundation

**9. Golden Module**
```
/aeos:golden password-reset
```
→ one complete, tested reference module + `.ai/golden/password-reset/golden-module.md`.
This is the standard everything else copies.

**10. Freeze Contracts**
```
/aeos:contracts password-reset
```
→ `.ai/contracts/password-reset/contracts.md` (the shared APIs/events/DTOs,
marked FROZEN).

**11. Handovers**
```
/aeos:handover password-reset
```
→ one `.ai/handovers/password-reset/<module>.handover.md` per module.

**12. Blueprint + Tasks**
```
/aeos:tasks password-reset
```
→ `.ai/blueprint/password-reset/blueprint.md` (waves) + task files.

**13. Gate G2 — authorize parallel fan-out.** Record
`.ai/reviews/password-reset-g2.md` → `APPROVED`. **The big one — nothing parallel
runs without it.**

### Stage 3 — Build & Release

**14. Parallel development.** Hand tasks to Conductor (one workspace per task,
wave 1 first), or in a single session:
```
/aeos:implement password-reset T-001
```
Each agent imitates the Golden Module and builds against the frozen contracts.

**15. Test, review, harden.**
```
/aeos:report password-reset                    # test coverage
/aeos:review password-reset code-review         # per branch — merge only on PASS
/aeos:review password-reset integration
/aeos:review password-reset security
/aeos:review password-reset performance
/aeos:review password-reset release-readiness
```

**16. Gate G3 — ship?** Record `.ai/reviews/password-reset-g3.md` → `APPROVED`.

**17. Document, deploy, archive.**
```
/aeos:docs password-reset
# deploy however you deploy, then:
openspec archive password-reset
```
The new spec folds into your project's "current truth." Done.

---

## Lost? One command tells you where you are

```
/aeos:status
```
It prints every change, how far it's got, the last gate passed, and the exact
next command.

---

## Where to go next

- **[user-guide.md](user-guide.md)** — every phase in depth: when/what/why/how,
  examples, and a full workflow diagram.
- **[workflow.md](workflow.md)** — the compact reference table.
- **[INSTALL.md](../INSTALL.md)** — detailed, beginner-friendly installation.

You now know the whole loop. The rest is just doing it.
