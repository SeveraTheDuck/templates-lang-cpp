#!/usr/bin/env bash
# Restore release-please-managed files from main into the checked-out dev tree.
set -euo pipefail
git fetch origin main
git restore --source=origin/main -- \
  version.txt \
  CHANGELOG.md \
  .release-please-manifest.json
