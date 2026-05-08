#!/usr/bin/env bash
# Install repository-managed git hooks by pointing core.hooksPath at .githooks.
# Run this once per clone:
#   bash scripts/install-hooks.sh

set -euo pipefail

ROOT_DIR="$(cd "$(dirname "$0")/.." && pwd)"
cd "$ROOT_DIR"

if [ ! -d .githooks ]; then
  echo "install-hooks: .githooks directory not found at $ROOT_DIR" >&2
  exit 1
fi

chmod +x .githooks/* 2>/dev/null || true

git config core.hooksPath .githooks

current="$(git config --get core.hooksPath || true)"
echo "core.hooksPath: ${current}"
echo "Hooks installed:"
ls -la .githooks/ | tail -n +2 | awk '{print "  " $0}'
echo ""
echo "Verify by running e.g. 'git commit --dry-run' or staging a guarded change."
