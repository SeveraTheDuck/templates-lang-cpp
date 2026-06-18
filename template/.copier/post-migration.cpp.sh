#!/usr/bin/env bash

# Post-migration for the C++ layer: runs after `copier update` (never on first
# copy), from the destination project root. Named `.cpp.` so it never collides
# with the base layer's `.copier/post-migration.sh`.
#
# Context (environment, not argv): $VERSION_PEP440_FROM, $VERSION_PEP440_TO, $STAGE.

set -euo pipefail

from="${VERSION_PEP440_FROM:-0.0.0}"
to="${VERSION_PEP440_TO:-0.0.0}"

echo "post-migration (lang-cpp): ${from} -> ${to}"

# True if $1 < $2 (semver-ish via sort -V). Safe as an `if` condition under set -e.
version_lt() {
  [ "$1" != "$2" ] && [ "$(printf '%s\n%s\n' "$1" "$2" | sort -V | head -n1)" = "$1" ]
}

# -- Migrations (ascending) ---------------------------------------------------
# Template for a future migration:
#
#   if version_lt "$from" "0.2.0"; then
#     echo "  -> 0.2.0: relocate cpp fragments"
#     git mv nix/old nix/new 2>/dev/null || true
#   fi
#
# (no migrations yet)

echo "post-migration: complete"
