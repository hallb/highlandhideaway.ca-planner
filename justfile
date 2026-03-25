# Highland Hideaway planner — https://github.com/casey/just
# Run `just --list` for recipes. Prefer `just bootstrap` after `./script/bootstrap` installs Just.

set shell := ["bash", "-eu", "-o", "pipefail", "-c"]

default:
    @just --list

# Install Markdown Projects CLI (Bun), then create .mdp/ if missing.
bootstrap:
    #!/usr/bin/env bash
    set -euo pipefail
    cd "{{justfile_directory()}}"
    export BUN_INSTALL="${BUN_INSTALL:-$HOME/.bun}"
    export PATH="$BUN_INSTALL/bin:$PATH"
    if ! command -v bun >/dev/null 2>&1; then
      echo "Installing Bun (https://bun.sh)..."
      curl -fsSL https://bun.sh/install | bash
    fi
    if ! command -v bun >/dev/null 2>&1; then
      echo "ERROR: bun not found. Add $BUN_INSTALL/bin to PATH or install from https://bun.sh" >&2
      exit 1
    fi
    echo "Installing Markdown Projects CLI (mdp)..."
    bun install -g github:varunpandey0502/markdown-projects
    if ! command -v mdp >/dev/null 2>&1; then
      echo "ERROR: mdp not on PATH after install. Ensure $BUN_INSTALL/bin is on PATH." >&2
      exit 1
    fi
    mdp --version
    if [ ! -d .mdp ]; then
      echo "Initializing Markdown Projects in repo root..."
      mdp project create -p . --preset generic
    else
      echo ".mdp/ already present; skipping project create."
    fi
    echo "bootstrap: done."

# Run after a fresh clone (same as bootstrap for this repo).
setup: bootstrap
    @echo "setup: done."

# Re-run bootstrap after pulling (run git pull yourself first).
update: bootstrap
    @echo "update: done."

# Sanity checks for docs layout and mdp.
test:
    #!/usr/bin/env bash
    set -euo pipefail
    cd "{{justfile_directory()}}"
    for d in docs/01-requirements docs/02-solution docs/02-solution/adr .mdp; do
      if [ ! -d "$d" ]; then
        echo "ERROR: missing $d" >&2
        exit 1
      fi
    done
    export BUN_INSTALL="${BUN_INSTALL:-$HOME/.bun}"
    export PATH="$BUN_INSTALL/bin:$PATH"
    if command -v mdp >/dev/null 2>&1; then
      mdp --version
    else
      echo "WARN: mdp not on PATH (run just bootstrap)" >&2
    fi
    echo "test: ok."

cibuild: test

server:
    @echo "No app server. Markdown Projects is file-based (https://www.markdownprojects.com/). Edit docs/ or .mdp/ and use the mdp CLI."

console:
    @echo "No project REPL. Use: mdp --help"
