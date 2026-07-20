#!/usr/bin/env node
'use strict';

/*
 * aeos — overlay the AEOS framework onto the CURRENT project directory,
 * non-destructively and idempotently. Cross-platform (Windows/macOS/Linux),
 * dependency-free. This is the Node port of bin/aeos-install.sh and preserves
 * its exact semantics:
 *
 *   - Files are only ADDED when missing; existing files are never overwritten.
 *   - The single in-place edit is CLAUDE.md, whose AEOS block lives between
 *     markers and is backed up to CLAUDE.md.aeos-bak before any change.
 *   - An existing openspec/ is left untouched; .ai/ is scaffolded empty.
 *   - A second run is a no-op.
 *
 * SRC    = this package's own directory (auto-detected).
 * TARGET = the current working directory (your project).
 */

const fs = require('fs');
const path = require('path');

const PKG_ROOT = path.resolve(__dirname, '..');
const TARGET = process.cwd();
const AEOS_START = '<!-- AEOS:start -->';
const AEOS_END = '<!-- AEOS:end -->';

// ---------------------------------------------------------------------------
// arg parsing
// ---------------------------------------------------------------------------
const argv = process.argv.slice(2);
let cmd = null;
let dryRun = false;
for (const a of argv) {
  if (a === '--dry-run') dryRun = true;
  else if (a === '-h' || a === '--help' || a === 'help') { cmd = cmd || 'help'; }
  else if (a === '-v' || a === '--version' || a === 'version') { cmd = cmd || 'version'; }
  else if (!cmd && (a === 'init' || a === 'install')) cmd = 'init';
  else if (!cmd && (a === 'uninstall' || a === 'remove')) cmd = 'uninstall';
  else {
    console.error(`aeos: unknown argument '${a}' (try 'aeos --help')`);
    process.exit(2);
  }
}
if (!cmd) cmd = 'help';

// ---------------------------------------------------------------------------
// counters + reporting
// ---------------------------------------------------------------------------
const counts = { created: 0, same: 0, kept: 0, backed: 0, removed: 0 };

function say(s) { process.stdout.write(s + '\n'); }
function act(verb, p) {
  const prefix = dryRun ? '  [dry-run] ' : '  ';
  say(prefix + verb.padEnd(9) + ' ' + p);
}

// ---------------------------------------------------------------------------
// helpers
// ---------------------------------------------------------------------------
function sameBytes(a, b) {
  try { return fs.readFileSync(a).equals(fs.readFileSync(b)); }
  catch (_e) { return false; }
}

// copy_file: missing -> create; identical -> no-op; differing -> keep (never overwrite)
function copyFile(src, dst) {
  if (fs.existsSync(dst)) {
    if (sameBytes(src, dst)) counts.same++;
    else { act('keep', dst); counts.kept++; }
    return;
  }
  act('create', dst);
  counts.created++;
  if (dryRun) return;
  fs.mkdirSync(path.dirname(dst), { recursive: true });
  fs.copyFileSync(src, dst);
}

// merge_tree: replicate structure (incl. empty dirs), then copy files.
// Copies CONTENTS of src into dst, so an existing dst is never nested.
function mergeTree(src, dst) {
  if (!fs.existsSync(src) || !fs.statSync(src).isDirectory()) return;
  const entries = fs.readdirSync(src, { withFileTypes: true });
  if (!dryRun) fs.mkdirSync(dst, { recursive: true });
  for (const e of entries) {
    const s = path.join(src, e.name);
    const d = path.join(dst, e.name);
    if (e.isDirectory()) mergeTree(s, d);
    else if (e.isFile()) copyFile(s, d);
  }
}

// scaffold_dir: ensure DIR/.gitkeep exists (idempotent)
function scaffoldDir(dir) {
  const keep = path.join(dir, '.gitkeep');
  if (fs.existsSync(keep)) { counts.same++; return; }
  act('create', keep);
  counts.created++;
  if (dryRun) return;
  fs.mkdirSync(dir, { recursive: true });
  fs.writeFileSync(keep, '');
}

function guardNotSelf() {
  if (path.resolve(PKG_ROOT) === path.resolve(TARGET)) {
    console.error(`aeos: SRC and TARGET are the same directory (${TARGET}).`);
    console.error('You are inside the AEOS package/template itself. cd into your project first.');
    process.exit(1);
  }
}

function pkgVersion() {
  try { return require(path.join(PKG_ROOT, 'package.json')).version || '0.0.0'; }
  catch (_e) { return '0.0.0'; }
}

// ---------------------------------------------------------------------------
// commands
// ---------------------------------------------------------------------------
function printHelp() {
  say(`aeos — overlay AEOS onto the current project (safe & idempotent)

Usage:
  npx @aeos/cli <command> [--dry-run]

Commands:
  init         Overlay AEOS onto the current directory (add missing files only).
  uninstall    Remove AEOS framework files and the CLAUDE.md marker block.
               Leaves your .ai/ workspace and openspec/ untouched.
  help         Show this help.
  version      Print the AEOS version.

Options:
  --dry-run    Print what would change; write nothing.

Run it from INSIDE your project directory. The installer never overwrites your
files; it only adds what is missing. For CLAUDE.md it edits between
${AEOS_START} / ${AEOS_END} markers, backing the file up to CLAUDE.md.aeos-bak first.`);
}

function claudeMd() {
  const cm = path.join(TARGET, 'CLAUDE.md');
  const blockSrcPath = path.join(PKG_ROOT, 'CLAUDE.md');
  say('CLAUDE.md (project instructions)');
  if (!fs.existsSync(blockSrcPath)) return;

  const blockSrc = fs.readFileSync(blockSrcPath, 'utf8');
  const block = AEOS_START + '\n' + blockSrc + AEOS_END + '\n';

  if (!fs.existsSync(cm)) {
    act('create', cm);
    counts.created++;
    if (!dryRun) fs.writeFileSync(cm, block);
    return;
  }

  const cur = fs.readFileSync(cm, 'utf8');
  const esc = (s) => s.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
  const re = new RegExp(esc(AEOS_START) + '[\\s\\S]*?' + esc(AEOS_END));
  const m = cur.match(re);

  if (m) {
    const curBlock = m[0] + '\n';
    if (curBlock === block) { counts.same++; return; }
    act('edit', cm + ' (update AEOS block)');
    if (!dryRun) {
      fs.copyFileSync(cm, cm + '.aeos-bak'); counts.backed++;
      const replaced = cur.replace(re, AEOS_START + '\n' + blockSrc + AEOS_END);
      fs.writeFileSync(cm, replaced);
    }
  } else {
    // existing CLAUDE.md without markers — append the block, back up first
    act('edit', cm + ' (append AEOS block)');
    if (!dryRun) {
      fs.copyFileSync(cm, cm + '.aeos-bak'); counts.backed++;
      fs.writeFileSync(cm, cur + '\n' + block);
    }
  }
}

function runInit() {
  guardNotSelf();
  say('AEOS installer');
  say('  source: ' + PKG_ROOT);
  say('  target: ' + TARGET);
  if (dryRun) say('  mode:   DRY RUN (no writes)');
  say('');

  say('aeos/ (framework)');
  mergeTree(path.join(PKG_ROOT, 'aeos'), path.join(TARGET, 'aeos'));

  say('.claude/commands/aeos/ (slash commands)');
  mergeTree(path.join(PKG_ROOT, '.claude', 'commands', 'aeos'),
            path.join(TARGET, '.claude', 'commands', 'aeos'));

  say('docs/aeos/ (framework docs)');
  const docsDir = path.join(PKG_ROOT, 'docs');
  if (fs.existsSync(docsDir)) {
    for (const name of fs.readdirSync(docsDir)) {
      const f = path.join(docsDir, name);
      if (name.endsWith('.md') && fs.statSync(f).isFile()) {
        copyFile(f, path.join(TARGET, 'docs', 'aeos', name));
      }
    }
  }

  say('.ai/ (workspace scaffold)');
  for (const d of ['blueprint', 'handovers', 'reports', 'reviews']) {
    scaffoldDir(path.join(TARGET, '.ai', d));
  }

  say('openspec/ (spec lifecycle)');
  let openspecNote;
  if (fs.existsSync(path.join(TARGET, 'openspec'))) {
    say('  detected existing openspec/ — leaving it untouched.');
    openspecNote = "openspec/ already present: run 'openspec init --tools claude --force' to refresh CLI tool files.";
  } else {
    mergeTree(path.join(PKG_ROOT, 'openspec'), path.join(TARGET, 'openspec'));
    openspecNote = "openspec/ created: run 'openspec init --tools claude --force' to generate CLI tool files.";
  }

  claudeMd();

  say('');
  say('Summary');
  say('  created:   ' + counts.created);
  say('  unchanged: ' + counts.same);
  say('  kept (yours, differs): ' + counts.kept);
  say('  backups:   ' + counts.backed + '   (*.aeos-bak)');
  say('');
  say('Note: ' + openspecNote);
  if (dryRun) {
    say('(dry run — nothing was written; re-run without --dry-run to apply)');
  } else {
    say('Done. Open the project in Claude Code; /aeos:* commands load from .claude/commands/aeos/.');
  }
}

function runUninstall() {
  say('AEOS uninstall — target: ' + TARGET);
  say('');
  for (const rel of ['aeos', path.join('.claude', 'commands', 'aeos'), path.join('docs', 'aeos')]) {
    const p = path.join(TARGET, rel);
    if (fs.existsSync(p)) {
      act('remove', p);
      counts.removed++;
      if (!dryRun) fs.rmSync(p, { recursive: true, force: true });
    }
  }
  const cm = path.join(TARGET, 'CLAUDE.md');
  if (fs.existsSync(cm)) {
    const cur = fs.readFileSync(cm, 'utf8');
    if (cur.indexOf(AEOS_START) !== -1) {
      act('edit', cm + ' (remove AEOS block)');
      if (!dryRun) {
        fs.copyFileSync(cm, cm + '.aeos-bak'); counts.backed++;
        const esc = (s) => s.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
        const re = new RegExp(esc(AEOS_START) + '[\\s\\S]*?' + esc(AEOS_END) + '\\n?');
        fs.writeFileSync(cm, cur.replace(re, ''));
      }
    }
  }
  say('');
  say('Removed: ' + counts.removed + ' path(s); backups: ' + counts.backed + '.');
  say('Left untouched: .ai/ workspace and openspec/ (your data).');
  if (dryRun) say('(dry run — nothing was written)');
}

// ---------------------------------------------------------------------------
// dispatch
// ---------------------------------------------------------------------------
switch (cmd) {
  case 'help': printHelp(); break;
  case 'version': say('aeos ' + pkgVersion()); break;
  case 'init': runInit(); break;
  case 'uninstall': runUninstall(); break;
  default: printHelp(); process.exit(2);
}
