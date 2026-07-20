# AEOS User Manual

Step-by-step guide to using AEOS in any project — from cloning the template to
shipping your first change. Framework theory lives in
[architecture.md](architecture.md) and [workflow.md](workflow.md); this manual
is the *how-to*.

Throughout, we use a running example: a change called **`add-invoicing`** in a
Laravel project.

---

## 0. What You Need

| Tool | Required | Purpose |
|------|----------|---------|
| Git | Yes | Every artifact and gate decision is version-controlled |
| [Claude Code](https://claude.com/claude-code) | Yes | Runs the `/aeos:*` phase commands |
| [OpenSpec CLI](https://github.com/Fission-AI/OpenSpec) | Recommended | `openspec validate / list / archive` on the spec lifecycle |
| [Conductor](https://conductor.build) | Stage 2 only | Parallel AI agents in git worktrees (swappable — see [conductor-mapping.md](conductor-mapping.md)) |

---

## 1. Start a New Project

1. **Clone the template** into your new project repo:

   ```bash
   git clone git@github.com:shariya-dev/agentic-workflow.git my-project
   cd my-project
   rm -rf .git && git init -b main
   git add -A && git commit -m "chore: bootstrap from AEOS template"
   ```

2. **Initialize OpenSpec** (refreshes CLI tool files; AEOS directories already exist):

   ```bash
   openspec init
   ```

3. **Activate a framework adapter.** Pick one from `aeos/adapters/frameworks/`
   (Laravel is first) and record the choice in your project README. Fill in the
   adapter's three files when you first need them:
   - `README.md` — stack versions
   - `guide-overrides.md` — content for the 12 override markers in `aeos/guide/`
   - `verification.md` — the exact test/lint/analysis commands tasks will use

4. **Fill in `openspec/project.md`** — purpose, tech stack, conventions.

5. **Open the project in Claude Code.** The root `CLAUDE.md` teaches every
   session the lifecycle automatically; the `/aeos:*` commands are picked up
   from `.claude/commands/aeos/`.

Your project is now AEOS-operated. Everything below is per change.

---

## 2. Stage 1 — Engineering (idea → approved tasks)

**The golden rule:** each phase produces exactly one artifact, and no phase
starts until its input (or gate) exists. Commands enforce this — if a command
STOPs, it will tell you which artifact or gate record is missing.

### Phase 0 — Discovery

```
/aeos:discover invoicing for B2B customers
```

The AI interviews you and writes **`.ai/idea.md`**: problem, target users,
desired outcomes, constraints, success metrics, open questions. No solutions,
no architecture — problem space only. `idea.md` is a working scratchpad; it is
promoted into a change id at gate G0.

### Gate G0 — "Worth speccing?" (Product owner)

Copy `aeos/templates/gate-record.template.md` to
**`.ai/reviews/add-invoicing-g0.md`**, review `idea.md`, and record your
decision:

```markdown
## Decision
Decision: APPROVED
```

Commit it. (A gate is passed when its record's Decision is `APPROVED` or
`APPROVED-WITH-CONDITIONS`; `REJECTED` blocks the lifecycle.)

### Phase 1 — Proposal

```
/aeos:propose add-invoicing
```

Produces **`openspec/changes/add-invoicing/proposal.md`** — the *what* and
*why* (never the *how*). Validate with `openspec validate add-invoicing`.
Review and approve it in conversation, then:

### Phase 2 — Design

```
/aeos:design add-invoicing
```

Produces **`design.md`** plus spec deltas under
`openspec/changes/add-invoicing/specs/`. Every decision traces to a proposal
requirement; alternatives considered are recorded. Approve, then:

### Phase 3 — Blueprint

```
/aeos:blueprint add-invoicing
```

Produces **`.ai/blueprint/add-invoicing/blueprint.md`** — the module map:
every module gets a name, purpose, boundary, dependencies, and wave number.
E.g. `invoice-core` (wave 1), `invoice-pdf` (wave 2), `invoice-notifications`
(wave 2). Approve, then:

### Phase 4 — Handovers

```
/aeos:handover add-invoicing
```

Produces one **`.ai/handovers/add-invoicing/<module>.handover.md`** per
blueprint module — all 11 sections (purpose, scope, requirements, business
rules, dependencies, APIs, events, database, constraints, acceptance criteria,
testing expectations). This is everything an implementation agent needs to
build the module without re-deriving design decisions.

### Phase 5 — Tasks

```
/aeos:tasks add-invoicing
```

Produces **`openspec/changes/add-invoicing/tasks.md`** (index) plus one file
per task under `tasks/` — each atomic, single-module, with `depends_on`, a
wave number, and a runnable verification command from your adapter's
`verification.md`.

### Gate G1 — "Build it?" (Tech lead / architect)

Review the full Stage-1 set (proposal + design + blueprint + handovers +
tasks) as a whole. Record the decision in
**`.ai/reviews/add-invoicing-g1.md`** and commit.

> **Nothing in Stage 2 runs without this record.** This is the framework's
> most important gate: it is the last moment scope and architecture are cheap
> to change.

At any point, `/aeos:status` shows where every change sits and what the next
action is.

---

## 3. Stage 2 — Development (tasks → production)

### Hand off to the orchestrator

With Conductor (see `aeos/adapters/orchestrators/conductor/README.md`):

1. Open the repo in Conductor. Root `conductor.json` runs your adapter's setup
   in every new workspace.
2. **One workspace per task**, starting with wave 1 tasks only.
3. Brief each agent with the convention:

   ```
   Implement task openspec/changes/add-invoicing/tasks/T-001.md.
   Read your handover and follow aeos/prompts/60-implementation.md.
   Do not touch files outside your module scope.
   ```

4. The agent builds on its own branch; done = Definition of Done checked AND
   the task's verification command passes.

### Review every branch, merge per wave

For each finished branch:

```
/aeos:review add-invoicing code-review
```

writes `.ai/reports/add-invoicing/report-code-review.md`. Merge only on
`PASS` (or `PASS-WITH-NOTES` you accept). **Wave 2 workspaces start only after
wave 1 branches pass review and merge.**

### Test, integrate, secure

Once waves are merged:

```
/aeos:report add-invoicing                      # test coverage report
/aeos:review add-invoicing integration          # modules actually compose?
/aeos:review add-invoicing security             # ship-safe?
/aeos:review add-invoicing performance          # constraint budgets met?
/aeos:review add-invoicing release-readiness    # aggregates the other five
```

All reports land in `.ai/reports/add-invoicing/`. Verdicts need evidence — a
finding without location + recommendation doesn't count.

### Gate G2 — "Ship it?" (Release owner)

Review all six reports, record the decision in
**`.ai/reviews/add-invoicing-g2.md`**, commit. (In v1, G2 is enforced by
process, not by a command.)

### Deploy and archive

Deploy however your project deploys. Then close the loop:

```bash
openspec archive add-invoicing
```

The spec deltas fold into `openspec/specs/` — current truth now includes
invoicing — and the change folder archives. The next change starts from an
accurate spec of the system.

---

## 4. Rules That Keep You Safe

1. **Never design while implementing; never implement while designing.** If an
   agent hits a design gap mid-task, it reports back — it never improvises.
2. **Each phase writes only to its permitted locations** — the table in
   `CLAUDE.md` is authoritative.
3. **Don't edit `aeos/` during project work.** It's the framework; change
   requests go upstream (see §5).
4. **Gates are files.** If it isn't in `.ai/reviews/`, it didn't happen.
5. **Module boundaries are hard.** A task's "Out of Scope" section is a wall,
   not a suggestion.

---

## 5. Maintaining AEOS Itself

- **Upgrading a project's framework:** copy the newer `aeos/` directory (and
  `.claude/commands/aeos/`) from the template repo over your project's copy.
  They are safe to replace wholesale because project work never lives there.
- **Adding a framework adapter** (.NET, NestJS, Spring Boot, Django, FastAPI):
  create `aeos/adapters/frameworks/<name>/` implementing
  `aeos/adapters/_contract.md` — README, guide-overrides (one section per
  override marker), verification commands. The lifecycle itself never changes.
- **Swapping the orchestrator:** add `aeos/adapters/orchestrators/<name>/`
  documenting how the tool satisfies the Orchestrator Contract in
  [conductor-mapping.md](conductor-mapping.md).

---

## 6. Troubleshooting

| Symptom | Cause | Fix |
|---------|-------|-----|
| A command STOPs immediately | Preceding gate record or artifact missing | Run `/aeos:status` — it names the exact missing piece and next action |
| `openspec validate` fails | Proposal/deltas don't follow OpenSpec conventions | Fix the flagged file; AEOS artifacts in `.ai/` are not validated by the CLI |
| Agent wants to change another module | Task boundaries drawn wrong | Stop the agent; fix the blueprint/tasks (Stage 1), re-approve G1 deltas — don't patch around it in Stage 2 |
| Two modules disagree about an API | Handover contract mismatch | Handovers must match pairwise (provider ↔ consumer); fix at `/aeos:handover`, not in code |
| Where do I see lifecycle state? | — | `/aeos:status` any time |
