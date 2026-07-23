#!/bin/sh
# aeos-install.sh — overlay the AEOS framework onto an EXISTING project directory,
# non-destructively and idempotently.
#
# Model:
#   SRC    = the AEOS template checkout this script lives in (auto-detected).
#   TARGET = your current working directory (your project).
#
# Usage:
#   cd /path/to/your/project
#   /path/to/aeos-template/bin/aeos-install.sh [--dry-run] [--uninstall] [--help]
#
# Policy: nothing you already have is overwritten. Files are only ADDED when
# missing; existing files are kept as-is. The single exception is CLAUDE.md,
# whose AEOS block is written between markers and is backed up (.aeos-bak)
# before any in-place change. A second run is a no-op.
#
# POSIX sh. No bashisms, no `sed -i`, no rsync dependency.

set -eu

# --- resolve SRC (template root) and TARGET (cwd) ---------------------------
script_path=$0
case "$script_path" in
  /*) : ;;                                   # already absolute
  *)  script_path="$(pwd)/$script_path" ;;   # make absolute
esac
BIN_DIR=$(CDPATH= cd -- "$(dirname -- "$script_path")" && pwd)
SRC=$(CDPATH= cd -- "$BIN_DIR/.." && pwd)
TARGET=$(pwd)

# --- flags ------------------------------------------------------------------
DRY_RUN=0
UNINSTALL=0
for arg in "$@"; do
  case "$arg" in
    --dry-run)   DRY_RUN=1 ;;
    --uninstall|--remove) UNINSTALL=1 ;;
    -h|--help)
      cat <<EOF
aeos-install.sh — overlay AEOS onto the current project (safe & idempotent)

  cd into your project first, then run this script from the template checkout.

Options:
  --dry-run           Print what would change; write nothing.
  --remove            Remove AEOS framework files and the CLAUDE.md marker block.
  --uninstall         Same as --remove. Leaves .ai/ and openspec/ untouched.
  -h, --help          Show this help.

The installer never overwrites your files. It only adds what is missing and,
for CLAUDE.md, edits between <!-- AEOS:start --> / <!-- AEOS:end --> markers,
backing the file up to CLAUDE.md.aeos-bak first.
EOF
      exit 0 ;;
    *)
      echo "aeos-install: unknown option '$arg' (try --help)" >&2
      exit 2 ;;
  esac
done

AEOS_START='<!-- AEOS:start -->'
AEOS_END='<!-- AEOS:end -->'

# --- counters ---------------------------------------------------------------
N_CREATED=0
N_KEPT=0
N_SAME=0
N_BACKED=0
N_REMOVED=0

say() { printf '%s\n' "$*"; }
act() {
  # act VERB PATH  — record a planned/performed action line
  if [ "$DRY_RUN" -eq 1 ]; then
    printf '  [dry-run] %-9s %s\n' "$1" "$2"
  else
    printf '  %-9s %s\n' "$1" "$2"
  fi
}

# Guard: refuse to install AEOS into its own template repo.
if [ "$SRC" = "$TARGET" ]; then
  echo "aeos-install: SRC and TARGET are the same directory ($TARGET)." >&2
  echo "You are inside the AEOS template itself. cd into your project first." >&2
  exit 1
fi

# ---------------------------------------------------------------------------
# copy_file SRC_FILE DST_FILE
#   missing dst      -> create   (N_CREATED)
#   identical dst    -> no-op    (N_SAME)
#   differing dst    -> keep     (N_KEPT)   [never overwrite]
# ---------------------------------------------------------------------------
copy_file() {
  _src=$1; _dst=$2
  if [ -e "$_dst" ]; then
    if cmp -s "$_src" "$_dst"; then
      N_SAME=$((N_SAME + 1))
    else
      act "keep" "$_dst"
      N_KEPT=$((N_KEPT + 1))
    fi
    return 0
  fi
  act "create" "$_dst"
  N_CREATED=$((N_CREATED + 1))
  [ "$DRY_RUN" -eq 1 ] && return 0
  mkdir -p -- "$(dirname -- "$_dst")"
  cp -- "$_src" "$_dst"
}

# ---------------------------------------------------------------------------
# merge_tree SRC_DIR DST_DIR
#   Recreates directory structure (incl. empty dirs), then copies each file
#   with copy_file. Copies CONTENTS, so an existing DST_DIR is never nested.
# ---------------------------------------------------------------------------
merge_tree() {
  _s=$1; _d=$2
  [ -d "$_s" ] || return 0
  # directories first (preserves empty ones)
  find "$_s" -type d | while IFS= read -r dir; do
    rel=${dir#"$_s"}
    rel=${rel#/}
    tdir=$_d${rel:+/$rel}
    if [ ! -d "$tdir" ] && [ "$DRY_RUN" -eq 0 ]; then
      mkdir -p -- "$tdir"
    fi
  done
  # then files, read in the parent shell (redirect, not pipe) so counters persist
  find "$_s" -type f > "$TMP/filelist"
  while IFS= read -r f; do
    [ -n "$f" ] || continue
    rel=${f#"$_s"/}
    copy_file "$f" "$_d/$rel"
  done < "$TMP/filelist"
}

# scaffold_dir DIR  — ensure DIR exists with a .gitkeep (idempotent)
scaffold_dir() {
  _d=$1
  if [ ! -e "$_d/.gitkeep" ]; then
    act "create" "$_d/.gitkeep"
    N_CREATED=$((N_CREATED + 1))
    if [ "$DRY_RUN" -eq 0 ]; then
      mkdir -p -- "$_d"
      : > "$_d/.gitkeep"
    fi
  else
    N_SAME=$((N_SAME + 1))
  fi
}

TMP=$(mktemp -d 2>/dev/null || mktemp -d -t aeos)
trap 'rm -rf "$TMP"' EXIT INT TERM

# ===========================================================================
# UNINSTALL
# ===========================================================================
if [ "$UNINSTALL" -eq 1 ]; then
  say "AEOS uninstall — target: $TARGET"
  say ""
  for p in "$TARGET/aeos" "$TARGET/.claude/commands/aeos" "$TARGET/docs/aeos"; do
    if [ -e "$p" ]; then
      act "remove" "$p"
      N_REMOVED=$((N_REMOVED + 1))
      [ "$DRY_RUN" -eq 0 ] && rm -rf -- "$p"
    fi
  done
  # strip the CLAUDE.md marker block (keep everything else)
  cm="$TARGET/CLAUDE.md"
  if [ -f "$cm" ] && grep -qF "$AEOS_START" "$cm"; then
    act "edit" "$cm (remove AEOS block)"
    if [ "$DRY_RUN" -eq 0 ]; then
      cp -- "$cm" "$cm.aeos-bak"; N_BACKED=$((N_BACKED + 1))
      awk -v s="$AEOS_START" -v e="$AEOS_END" '
        $0==s {skip=1; next}
        $0==e {skip=0; next}
        skip!=1 {print}
      ' "$cm" > "$TMP/CLAUDE.md"
      # drop a trailing blank line left where the block was, if any
      mv -- "$TMP/CLAUDE.md" "$cm"
    fi
  fi
  say ""
  say "Removed: $N_REMOVED path(s); backups: $N_BACKED."
  say "Left untouched: .ai/ workspace and openspec/ (your data)."
  [ "$DRY_RUN" -eq 1 ] && say "(dry run — nothing was written)"
  exit 0
fi

# ===========================================================================
# INSTALL
# ===========================================================================
say "AEOS installer"
say "  source: $SRC"
say "  target: $TARGET"
[ "$DRY_RUN" -eq 1 ] && say "  mode:   DRY RUN (no writes)"
say ""

# 1. Framework: aeos/
say "aeos/ (framework)"
merge_tree "$SRC/aeos" "$TARGET/aeos"

# 2. Slash commands: .claude/commands/aeos/ (other commands untouched)
say ".claude/commands/aeos/ (slash commands)"
merge_tree "$SRC/.claude/commands/aeos" "$TARGET/.claude/commands/aeos"

# 3. AEOS docs -> docs/aeos/ (top-level *.md only; user's docs/ untouched)
say "docs/aeos/ (framework docs)"
for f in "$SRC"/docs/*.md; do
  [ -f "$f" ] || continue
  copy_file "$f" "$TARGET/docs/aeos/$(basename -- "$f")"
done

# 4. Workspace scaffold: .ai/ (empty, no example content)
say ".ai/ (workspace scaffold)"
for d in foundation domain adr engineering-guide golden contracts blueprint handovers reports reviews; do
  scaffold_dir "$TARGET/.ai/$d"
done

# 5. openspec/ (conditional)
OPENSPEC_NOTE=""
say "openspec/ (spec lifecycle)"
if [ -d "$TARGET/openspec" ]; then
  say "  detected existing openspec/ — leaving it untouched."
  OPENSPEC_NOTE="openspec/ already present: run 'openspec init' to refresh CLI tool files."
else
  merge_tree "$SRC/openspec" "$TARGET/openspec"
  OPENSPEC_NOTE="openspec/ created: run 'openspec init' to generate CLI tool files."
fi

# 6. CLAUDE.md — marker block (the only in-place edit)
say "CLAUDE.md (project instructions)"
cm="$TARGET/CLAUDE.md"
block_src="$SRC/CLAUDE.md"
if [ -f "$block_src" ]; then
  # Build the desired marked block into $TMP/block
  {
    printf '%s\n' "$AEOS_START"
    cat -- "$block_src"
    printf '%s\n' "$AEOS_END"
  } > "$TMP/block"

  if [ ! -f "$cm" ]; then
    act "create" "$cm"
    N_CREATED=$((N_CREATED + 1))
    [ "$DRY_RUN" -eq 0 ] && cp -- "$TMP/block" "$cm"
  elif grep -qF "$AEOS_START" "$cm"; then
    # Extract the current block and compare to the desired one (idempotency).
    awk -v s="$AEOS_START" -v e="$AEOS_END" '
      $0==s {inb=1}
      inb {print}
      $0==e {inb=0}
    ' "$cm" > "$TMP/curblock"
    if cmp -s "$TMP/curblock" "$TMP/block"; then
      N_SAME=$((N_SAME + 1))
    else
      act "edit" "$cm (update AEOS block)"
      if [ "$DRY_RUN" -eq 0 ]; then
        cp -- "$cm" "$cm.aeos-bak"; N_BACKED=$((N_BACKED + 1))
        awk -v s="$AEOS_START" -v e="$AEOS_END" -v bf="$TMP/block" '
          $0==s {
            while ((getline line < bf) > 0) print line
            skip=1; next
          }
          $0==e {skip=0; next}
          skip!=1 {print}
        ' "$cm" > "$TMP/CLAUDE.md"
        mv -- "$TMP/CLAUDE.md" "$cm"
      fi
    fi
  else
    # Existing CLAUDE.md without AEOS markers — append the block, back up first.
    act "edit" "$cm (append AEOS block)"
    if [ "$DRY_RUN" -eq 0 ]; then
      cp -- "$cm" "$cm.aeos-bak"; N_BACKED=$((N_BACKED + 1))
      {
        cat -- "$cm"
        printf '\n'
        cat -- "$TMP/block"
      } > "$TMP/CLAUDE.md"
      mv -- "$TMP/CLAUDE.md" "$cm"
    fi
  fi
fi

# --- summary ----------------------------------------------------------------
say ""
say "Summary"
say "  created:   $N_CREATED"
say "  unchanged: $N_SAME"
say "  kept (yours, differs): $N_KEPT"
say "  backups:   $N_BACKED   (*.aeos-bak)"
say ""
[ -n "$OPENSPEC_NOTE" ] && say "Note: $OPENSPEC_NOTE"
if [ "$DRY_RUN" -eq 1 ]; then
  say "(dry run — nothing was written; re-run without --dry-run to apply)"
else
  say "Done. Open the project in Claude Code; /aeos:* commands load from .claude/commands/aeos/."
fi
