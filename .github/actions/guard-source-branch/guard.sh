#!/usr/bin/env bash
set -euo pipefail
if [ "$HEAD_REF" != "dev" ] && [[ $HEAD_REF != release-please--* ]]; then
  echo "::error::PRs into main must come from dev (or release-please), got '$HEAD_REF'."
  exit 1
fi
