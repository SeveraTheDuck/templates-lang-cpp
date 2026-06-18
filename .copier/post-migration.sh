#!/usr/bin/env bash

# Post-migration: runs after `copier update` (never on first copy), from the
# destination project root. Handles file moves / removals / renames across
# template versions that Copier's 3-way merge cannot perform on its own.
#
# Context from Copier (environment, not argv):
#   $VERSION_PEP440_FROM  — version being updated FROM (valid PEP440, no `v`)
#   $VERSION_PEP440_TO    — version being updated TO
#   $STAGE                — "before" | "after" (this script runs at "after")
#
# Adding a migration:
#   1. Add a version-gated block below, in ascending version order.
#   2. Gate on "$from" with version_lt (see template).
#   3. Prefer `git mv` / `rm -f`; make operations idempotent.

set -euo pipefail

from="${VERSION_PEP440_FROM:-0.0.0}"
to="${VERSION_PEP440_TO:-0.0.0}"

echo "post-migration: ${from} -> ${to}"

# True if $1 < $2 (semver-ish ordering via sort -V). Safe under `set -e` when
# used as an `if` condition.
version_lt() {
  [ "$1" != "$2" ] && [ "$(printf '%s\n%s\n' "$1" "$2" | sort -V | head -n1)" = "$1" ]
}

# -- Migrations (ascending) ---------------------------------------------------
#
# Template for a future migration:
#
#   if version_lt "$from" "1.2.0"; then
#     echo "  -> 1.2.0: relocate nix fragments"
#     git mv nix/old nix/new 2>/dev/null || true
#   fi
#
# (no migrations yet)

echo "post-migration: complete"
