#!/usr/bin/env bash

# Open the interactive perf report for a recording.
# Usage: report.sh [perf.data]   (default: profiling/results/perf.data)

set -euo pipefail
# shellcheck shell=bash

if [ "$(uname)" != "Linux" ]; then
  echo "error: profiling is only supported on Linux" >&2
  exit 1
fi

script_dir="$(cd "$(dirname "$0")" && pwd)"
input="${1:-$script_dir/../results/perf.data}"

if [ ! -f "$input" ]; then
  echo "error: '$input' not found -- run record.sh first" >&2
  exit 1
fi

perf report -i "$input"
