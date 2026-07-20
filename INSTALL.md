# Installing AEOS — A Complete Beginner's Guide

**No technical background needed.** This guide assumes you have *never* opened a
terminal before. Follow the parts in order, top to bottom. Every command sits in
its own grey box — copy **one box at a time**, paste it, press **Enter**, and
wait for it to finish before moving to the next.

Take your time. Nothing here can break your computer.

---

## Part 0 — What AEOS is, and the safety promise

**AEOS is a set of ready-made instructions and commands that helps an AI build
software for you in careful, reviewable steps.** You "install" it by laying it on
top of a project folder on your computer.

**The safety promise (this is important):** the installer **never overwrites
files you already have.** It only *adds* files that are missing. The one file it
may change is a file called `CLAUDE.md`, and before it changes that one, it first
saves a copy called `CLAUDE.md.aeos-bak` so your original is never lost.

Two safety tools you'll use in this guide:

- **`--dry-run`** — a "preview" mode. It shows you exactly what *would* happen
  and **writes nothing at all.** Always safe to run.
- **`uninstall`** — a command that cleanly removes AEOS again if you change your
  mind. It leaves your own work untouched.

You will preview first (Part 3), then install for real (Part 4). If anything ever
looks wrong, the **Appendix** at the end shows how to undo everything.

---

## Part 1 — Open a terminal and install the prerequisites

A "terminal" is just a window where you type commands instead of clicking
buttons. AEOS needs three free tools:

- **Node.js** — provides the `npx` command that installs AEOS in one line.
- **Git** — on Windows it also gives you the terminal we'll use; on Mac it's used
  for the optional snapshot in Part 6.
- **OpenSpec** — a small helper AEOS works alongside.

We'll open the terminal, then check for and install each one.

### 1a. Open your terminal

**On a Mac:**

1. Press **Command (⌘) + Spacebar** together. A search box appears.
2. Type the word **Terminal**.
3. Press **Enter**. A window with a blinking cursor opens. That's your terminal.

**On Windows:**

For this guide, Windows users should use a terminal called **Git Bash** — **not**
the built-in "Command Prompt" or "PowerShell." Git Bash makes every command in
this guide behave exactly like it does on a Mac. Git Bash is installed together
with Git (next step), so:

1. First do step **1b** below to install **Git for Windows** — this gives you
   both Git *and* Git Bash.
2. Then click the **Start** menu, type **Git Bash**, and press **Enter**. A
   window with a blinking cursor opens. That's your terminal.

> Throughout this guide, "your terminal" means the **Terminal** app on Mac or
> **Git Bash** on Windows.

### 1b. Install Git

First, check whether you already have it. Copy this box, paste it into your
terminal, and press Enter:

```
git --version
```

- If you see something like `git version 2.39.0`, Git is installed. Skip to 1c.
- If you see **`command not found`** (or on Windows, nothing that looks like a
  version), install it:
  - **Mac:** copy and run the box below. A pop-up may appear asking to install
    "command line developer tools" — click **Install** and wait, then run
    `git --version` again to confirm.

    ```
    xcode-select --install
    ```

  - **Windows:** open your web browser, go to **https://git-scm.com/download/win**,
    download the installer, and run it. Click **Next** through every screen
    (the default choices are fine). This installs both **Git** and **Git Bash**.
    When it finishes, open **Git Bash** (see 1a) and run `git --version` again.

### 1c. Install Node.js (this also installs npm and npx)

Check first:

```
node --version
```

Then check npm (it comes bundled with Node):

```
npm --version
```

- If both print a version number (for example `v20.11.0` and `10.2.4`), you're
  set — skip to 1d.
- If either says **`command not found`**, install Node.js:
  1. Open your web browser and go to **https://nodejs.org**.
  2. Click the big button labelled **LTS** (it stands for "Long-Term Support" —
     the stable version). This downloads an installer.
  3. Open the downloaded file and click **Next / Continue / Agree** through
     every screen — the defaults are correct.
  4. **Important:** close your terminal window completely and open a fresh one
     (this lets it notice the new tool). Then run `node --version` and
     `npm --version` again to confirm.

> Installing Node.js also gives you a command called **`npx`** — that's what
> installs AEOS in Part 4. You don't need to install `npx` separately.

### 1d. Install the OpenSpec command

Now install OpenSpec using npm. Copy and run:

```
npm install -g @fission-ai/openspec
```

The `-g` means "install it for the whole computer so I can use it anywhere."

**If you see a permission error** (words like `EACCES`, `permission denied`, or
`try running with sudo`) — this only happens on Mac/Linux — run this instead. It
will ask for your computer login password; as you type, **nothing appears on
screen** (that's normal for passwords), just type it and press Enter:

```
sudo npm install -g @fission-ai/openspec
```

> On Windows, you generally do **not** need `sudo`. If you hit a permission
> problem there, close Git Bash, right-click its icon, choose **Run as
> administrator**, and run the `npm install -g @fission-ai/openspec` command
> again.

Confirm it worked:

```
openspec --version
```

If a version number prints, all three prerequisites are ready.

---

## Part 2 — Find your project folder and go into it

AEOS installs *into a project folder* — the folder that holds the app you're
working on. Now you'll point the terminal at that folder.

### 2a. Get the folder's location ("path")

**On a Mac:**

1. Open **Finder** and find your project folder (don't open it — just see it).
2. In your terminal, type `cd` followed by **one space** (do not press Enter
   yet):

   ```
   cd 
   ```

3. Now **drag the project folder from Finder directly into the terminal
   window** and let go. The folder's full path appears automatically after
   `cd `. Now press **Enter**.

**On Windows (Git Bash):**

The easiest way — no typing of paths at all:

1. Open **File Explorer** and find your project folder.
2. **Right-click the folder** and choose **Git Bash Here** (Git for Windows adds
   this option to the right-click menu). A Git Bash window opens *already inside*
   that folder. If you use this method, you can **skip to Part 2b.**

If "Git Bash Here" isn't there, use the copy-path method instead:

1. In File Explorer, hold **Shift**, then **right-click** your project folder,
   and choose **Copy as path**. This copies the location (with quote marks).
2. In Git Bash, type `cd` and a space, then paste (right-click → **Paste**, or
   **Shift + Insert**):

   ```
   cd "C:\Users\YourName\your-project"
   ```

3. Git Bash prefers forward slashes. If pressing Enter gives an error, retype it
   changing the back-slashes `\` to forward-slashes `/`, keeping the quotes:

   ```
   cd "C:/Users/YourName/your-project"
   ```

### 2b. Confirm you're in the right place

Run this — it **p**rints your **w**orking **d**irectory (where you currently
are):

```
pwd
```

The path it prints should end with your project folder's name. If it does,
you're in the right spot. If not, repeat Part 2a.

> **Brand-new project with no folder yet?** Make one and enter it with these two
> commands (run them one at a time), then continue:
>
> ```
> mkdir ~/my-first-project
> ```
>
> ```
> cd ~/my-first-project
> ```

---

## Part 3 — Preview the installation (writes nothing)

**Always preview first.** This shows what the installer *would* do without
changing a single file. Make sure your terminal is still inside your project
folder (run `pwd` again if unsure), then run:

```
npx @aeos/cli init --dry-run
```

The first time you use `npx`, it may say *"Need to install the following
packages… Ok to proceed?"* — type **y** and press Enter. It downloads AEOS
temporarily and runs it. (Nothing is installed permanently, and because of
`--dry-run`, nothing in your project changes.)

### How to read the preview

At the bottom you'll see a **Summary** like this:

```
Summary
  created:   51
  unchanged: 0
  kept (yours, differs): 0
  backups:   0   (*.aeos-bak)
```

Here's what each line means:

| Line | Plain-English meaning |
|------|-----------------------|
| **created** | New files AEOS will add (because you don't have them). This is normal and expected. |
| **unchanged** | Files that already exist and are already identical — left alone. |
| **kept (yours, differs)** | You already have a file with this name and *different* contents — AEOS will **keep yours** and not touch it. Your work is safe. |
| **backups** | How many files will be safety-copied to a `.aeos-bak` file before any change. In practice only `CLAUDE.md` is ever edited, so this is 0 or 1. |

Above the summary, lines beginning with `[dry-run] create` list each file it
would add. Because this was a preview, the last line reminds you: *"dry run —
nothing was written."* Nothing on your computer changed.

If the numbers look reasonable (lots of "created", and your own files under
"kept" or "unchanged"), continue to Part 4.

---

## Part 4 — Install for real, then set up OpenSpec

### 4a. Run the installer

Same command as the preview, but **without** `--dry-run`:

```
npx @aeos/cli init
```

It prints the files it creates and finishes with a **Summary** and a line
starting with `Note:` telling you whether it created a fresh `openspec/` folder
or found one you already had. If you see any `backups: 1`, that means your
existing `CLAUDE.md` was safely copied to `CLAUDE.md.aeos-bak` before AEOS was
added to it — your original text is preserved inside the new file (and fully in
the backup).

### 4b. Initialize OpenSpec

This sets OpenSpec up for use with Claude. Run:

```
openspec init --tools claude --force
```

- `--tools claude` tells OpenSpec you're using Claude.
- `--force` lets it tidy up any older setup files without stopping to ask.

---

## Part 5 — (Optional) Choose your framework

If your project uses a specific framework (like Laravel, .NET, Django, and so
on), you can record that. This step is optional — you can skip it and come back
later.

Open the project settings file in a simple text editor. On Mac:

```
open -e openspec/project.md
```

On Windows (Git Bash), open it with Notepad:

```
notepad openspec/project.md
```

Fill in your project's purpose, technology, and conventions where the file asks,
then save and close it. (You can also just edit it later inside Claude Code.)

---

## Part 6 — (Recommended) Save a snapshot with Git

A "snapshot" (called a *commit*) lets you undo everything back to this exact
moment if you ever want to. Run these **one at a time**:

```
git init
```

```
git add -A
```

```
git commit -m "Add AEOS"
```

**If the last command complains** that it doesn't know who you are (a message
about `user.name` and `user.email`), tell Git your name and email once with the
two commands below (use your real name and email, keep the quotes), then run the
`git commit` command again:

```
git config --global user.name "Your Name"
```

```
git config --global user.email "you@example.com"
```

---

## Part 7 — Verify everything installed

Run this single command. It lists the AEOS commands and folders that should now
exist in your project:

```
ls .claude/commands/aeos/ aeos/ docs/aeos/
```

You should see command files like `discover.md`, `propose.md`, `design.md`,
`blueprint.md`, `handover.md`, `tasks.md`, `review.md`, `report.md`, and
`status.md`, plus AEOS folders such as `prompts`, `templates`, `workflows`, and
`guide`. If you see those, **AEOS is installed correctly.** 🎉

---

## Part 8 — What's next: every command, in order, with examples

First, open your project folder in **Claude Code**.

> **Where do these go?** The `/aeos:*` commands below are typed **inside Claude
> Code** (not in your Terminal / Git Bash). The **gate** steps between them are
> *your* decisions — you (or a teammate) record them as a small file; they are
> not commands.

Throughout, we follow one running example: adding invoicing to an app. The short
name for this piece of work is its **change id**: `add-invoicing`. You pass that
same id to every command so they all work on the same thing.

Do these **in order** — each command needs the previous one's result to exist.

---

### 8.1 · `/aeos:discover` — capture the idea

**Use it when:** you're starting something new and only have an idea in your
head, not a plan. It interviews you and writes down the *problem* (not the
solution). No gate comes before this one.

**Example — type into Claude Code** (put your own idea after `discover`):

```
/aeos:discover invoicing for B2B customers
```

**You get:** a file `.ai/idea.md` describing the problem, users, desired
outcomes, constraints, and success measures.

#### What can you give it? (three common situations)

Discovery is a **conversation**, so it accepts as little or as much as you have.

**A) You only have an idea in your head.** Just type it — even a few words is
enough. AEOS will then *interview you* to fill in the rest.

```
/aeos:discover task management
```

That absolutely works. AEOS will ask follow-up questions (who is it for? what
problem does it solve? how will you know it succeeded?) and write your answers
into `.ai/idea.md`. You don't need anything prepared.

**B) You have a sentence or two of context.** Put it all on the line — more
context means fewer questions back:

```
/aeos:discover a task manager for small design agencies to track client work and deadlines
```

**C) You already have a document** — an SRS (Software Requirements
Specification), a tender/RFP document, a brief, a spec, etc. You **cannot** just
type its name after the command and expect it to be read — a file name typed
after a `/` command is treated as plain text, not opened. Instead, do this:

1. **Put the document inside your project folder** so Claude Code can open it —
   for example in a new folder `.ai/inputs/`. In your Terminal / Git Bash, from
   inside your project:

   ```
   mkdir -p .ai/inputs
   ```

   Then move your file into that `.ai/inputs` folder using Finder (Mac) or File
   Explorer (Windows). Plain-text (`.txt`), Markdown (`.md`), and **PDF** files
   can be read directly. For a Word file (`.docx`), open it and **Save As →
   PDF** first (or copy-paste its text).

2. **Start discovery and point Claude at the file.** Run the command with a
   short label, then in your *next* message tell Claude to read the document:

   ```
   /aeos:discover task management (requirements attached)
   ```

   Then, as a normal follow-up message in Claude Code:

   ```
   Please read .ai/inputs/tender.pdf and use it as the basis for the idea.
   ```

   Claude opens the file, pulls out the problem, users, outcomes, constraints,
   and success measures, and asks you about anything the document leaves unclear.

> **Good to know:** discovery deliberately stays in the "problem" space. Even if
> your SRS or tender already describes *solutions* or *technology*, discovery
> ignores those on purpose — they belong to the later `/aeos:propose` and
> `/aeos:design` phases, so nothing is lost.

---

### 8.2 · Gate **G0** — "Is this worth specifying?" *(your decision, not a command)*

**Use it when:** `.ai/idea.md` is written and someone (the product owner) has
read it and wants to go ahead. You record a tiny approval file. This is also the
moment the idea gets its change id (`add-invoicing`).

**How:** copy `aeos/templates/gate-record.template.md` to
`.ai/reviews/add-invoicing-g0.md`, and inside it write the decision line:

```
Decision: APPROVED
```

Nothing past this point runs until that file exists and says `APPROVED` (or
`APPROVED-WITH-CONDITIONS`).

---

### 8.3 · `/aeos:propose` — write the proposal (the *what* and *why*)

**Use it when:** G0 is approved and you want the formal proposal. It reads your
idea and turns it into a proper change proposal. (It will **stop** if the G0 file
is missing — that's the safety net working.)

**Example:**

```
/aeos:propose add-invoicing
```

**You get:** `openspec/changes/add-invoicing/proposal.md`. Read and approve it in
the conversation before moving on.

---

### 8.4 · `/aeos:design` — decide *how* it will be built

**Use it when:** the proposal is approved and you want the technical design and
the specification changes.

**Example:**

```
/aeos:design add-invoicing
```

**You get:** `design.md` plus "spec deltas" (the exact changes to the spec) under
`openspec/changes/add-invoicing/specs/`. Approve the design, then continue.

---

### 8.5 · `/aeos:blueprint` — split the work into modules and "waves"

**Use it when:** the design is approved and you want it broken into buildable
pieces (modules) grouped into waves (what can be built first, second, …).

**Example:**

```
/aeos:blueprint add-invoicing
```

**You get:** `.ai/blueprint/add-invoicing/blueprint.md` — each module with a
name, purpose, boundary, dependencies, and wave number. Approve it, then
continue.

---

### 8.6 · `/aeos:handover` — write a full build-brief per module

**Use it when:** the blueprint is approved. This writes one detailed "handover"
document per module — everything a builder needs so they never have to guess.

**Example:**

```
/aeos:handover add-invoicing
```

**You get:** one `.ai/handovers/add-invoicing/<module>.handover.md` per module,
each with all 11 sections filled in.

---

### 8.7 · `/aeos:tasks` — slice handovers into small, assignable tasks

**Use it when:** the handovers exist and you want the actual to-do list — small
tasks that can be built one at a time (or in parallel).

**Example:**

```
/aeos:tasks add-invoicing
```

**You get:** `openspec/changes/add-invoicing/tasks.md` (an index) plus one file
per task under `tasks/`, each with a verification command.

---

### 8.8 · Gate **G1** — "Build it?" *(your decision, not a command)*

**Use it when:** the whole Stage-1 set (proposal + design + blueprint + handovers
+ tasks) is ready and a tech lead has reviewed it. This is the **most important**
gate — the last cheap moment to change scope.

**How:** record the decision in `.ai/reviews/add-invoicing-g1.md`:

```
Decision: APPROVED
```

**Nothing in Stage 2 (the actual building) runs without this file.**

---

### 8.9 · Building the tasks *(handled by the orchestrator, after G1)*

**Use it when:** G1 is approved. The tasks are handed to the orchestrator
(Conductor), which has AI agents build them wave by wave. See
[docs/user-manual.md](docs/user-manual.md) §3 for this hand-off. When branches
come back, you review them:

---

### 8.10 · `/aeos:review` — check the finished work

**Use it when:** code has been built and you need it checked. There are five
review types — run the one you need: `code-review`, `security`, `performance`,
`integration`, `release-readiness`. (Requires G1 to be approved; it will stop
otherwise.)

**Examples — run whichever applies** (one at a time):

```
/aeos:review add-invoicing code-review
```

```
/aeos:review add-invoicing security
```

```
/aeos:review add-invoicing integration
```

```
/aeos:review add-invoicing performance
```

```
/aeos:review add-invoicing release-readiness
```

**You get:** a report file per review under `.ai/reports/add-invoicing/`. Every
verdict must cite evidence.

---

### 8.11 · `/aeos:report` — measure test coverage

**Use it when:** the work is built and you want the test-coverage report (this
feeds the `release-readiness` review above).

**Example:**

```
/aeos:report add-invoicing
```

**You get:** `.ai/reports/add-invoicing/report-test-coverage.md` — real numbers,
or explicitly named gaps.

---

### 8.12 · Gate **G2** — "Ship it?" *(your decision, not a command)*

**Use it when:** all six reports exist and the release owner has reviewed them.
Record the decision in `.ai/reviews/add-invoicing-g2.md`:

```
Decision: APPROVED
```

Then deploy however your project deploys, and finally close the loop in your
**Terminal / Git Bash**:

```
openspec archive add-invoicing
```

---

### 8.13 · `/aeos:status` — see where you are (use anytime)

**Use it when:** at *any* point you want a map of every change, the furthest
phase it reached, the last gate it passed, and the exact next command to run.
It's the safest thing to run if you're ever unsure what comes next.

**Example:**

```
/aeos:status
```

---

### The whole command order at a glance

```
/aeos:discover  →  [Gate G0]  →  /aeos:propose  →  /aeos:design
   →  /aeos:blueprint  →  /aeos:handover  →  /aeos:tasks  →  [Gate G1]
   →  (orchestrator builds)  →  /aeos:review …  +  /aeos:report
   →  [Gate G2]  →  deploy  →  openspec archive
```

`/aeos:status` can be run at any time. For the full walkthrough with more detail,
see [docs/user-manual.md](docs/user-manual.md).

---

## Appendix

### A. Troubleshooting

| What you see | What it means | What to do |
|--------------|---------------|------------|
| `command not found: node` (or npm/npx/git/openspec) | That tool isn't installed yet, or the terminal hasn't noticed it | Go back to **Part 1** and install it; then **close and reopen** your terminal |
| `npx: Need to install the following packages… Ok to proceed?` | `npx` is about to fetch AEOS temporarily — this is normal | Type **y** and press Enter |
| `npm error 404 … '@aeos/cli' is not in this registry` | The AEOS package name isn't reachable (offline, or not published yet) | Check your internet, or use the git fallback in section **D** below |
| `permission denied` / `EACCES` during `npm install` | Your account needs elevated rights to install globally | Mac/Linux: add `sudo ` in front and enter your password. Windows: run Git Bash **as administrator** |
| On Windows, commands behave oddly | You're in Command Prompt or PowerShell, not Git Bash | Close it and open **Git Bash** instead (Part 1a) |
| `cd` fails after "Copy as path" on Windows | The path uses back-slashes `\` | Retype it with forward-slashes `/`, keeping the quotes (Part 2a) |
| `SRC and TARGET are the same directory` | You ran the installer *inside* the AEOS package/template folder by mistake | Use `cd` to go into **your own** project folder first (Part 2), then run it |
| The installer changed my `CLAUDE.md` | This is expected and safe | Your original is saved as `CLAUDE.md.aeos-bak`; your text is also kept inside the new file |

### B. Re-running, previewing, and uninstalling

All of these are safe to run from inside your project folder:

- **Preview again (no changes):**

  ```
  npx @aeos/cli init --dry-run
  ```

- **Run / re-run the install** (running it twice does nothing the second time —
  it only ever *adds* what's missing):

  ```
  npx @aeos/cli init
  ```

- **Preview an uninstall (no changes):**

  ```
  npx @aeos/cli uninstall --dry-run
  ```

- **Uninstall for real** (removes the AEOS files and the AEOS section of
  `CLAUDE.md`; **leaves your own work — the `.ai/` and `openspec/` folders —
  untouched**):

  ```
  npx @aeos/cli uninstall
  ```

- **See all options:**

  ```
  npx @aeos/cli help
  ```

### C. The whole thing in short (cheat-sheet)

Once your prerequisites (Part 1) are installed, the entire install is just:

```
cd /path/to/your/project
```

```
npx @aeos/cli init --dry-run
```

```
npx @aeos/cli init
```

```
openspec init --tools claude --force
```

Then open the project in Claude Code and run `/aeos:discover ...`. Done.

### D. Fallback — install without Node (git clone method)

If you can't use `npx` (no Node.js, or you're offline from npm), you can install
the exact same AEOS with Git instead. Download AEOS once:

```
git clone https://github.com/shariya-dev/agentic-workflow.git ~/aeos-template
```

Then, from **inside your project folder** (Part 2), run the shell installer
(needs Git Bash on Windows):

```
~/aeos-template/bin/aeos-install.sh --dry-run
```

```
~/aeos-template/bin/aeos-install.sh
```

It behaves identically to `npx @aeos/cli init`. For uninstall, use
`~/aeos-template/bin/aeos-install.sh --uninstall`.
