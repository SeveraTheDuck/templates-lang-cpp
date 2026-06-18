#!/usr/bin/env bash

# Quick perf counters (cycles, instructions, cache + branch misses) for a binary.
# Usage: stat.sh <binary> [args...]

set -euo pipefail
# shellcheck shell=bash

if [ "$(uname)" != "Linux" ]; then
  echo "error: profiling is only supported on Linux" >&2
  exit 1
fi

if [ "$#" -lt 1 ]; then
  echo "usage: $0 <binary> [args...]" >&2
  exit 1
fi

binary="$1"
shift

if [ ! -x "$binary" ]; then
  echo "error: '$binary' is not executable" >&2
  exit 1
fi
perf stat -d -- "$binary" "$@"
