#!/usr/bin/env bash

# Lint each commit in FROM..TO individually.

set -euo pipefail

status=0
while IFS= read -r sha; do
  if ! git show -s --format=%B "$sha" | nix shell nixpkgs#commitlint-rs --command commitlint; then
    echo "::error::commit $sha failed: $(git show -s --format=%s "$sha")"
    status=1
  fi
done < <(git rev-list --reverse --no-merges "${FROM}..${TO}")

exit "$status"
