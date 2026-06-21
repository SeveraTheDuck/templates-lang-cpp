#!/usr/bin/env bash

# Record a perf profile for <binary>, saving perf.data to profiling/results/.
# Usage: record.sh <binary> [args...]

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

script_dir="$(cd "$(dirname "$0")" && pwd)"
results_dir="$script_dir/../results"
mkdir -p "$results_dir"
output="$results_dir/perf.data"

echo "--- recording: $binary $*"
perf record -F 997 --call-graph "${PERF_CALL_GRAPH:-dwarf}" -o "$output" -- "$binary" "$@"
echo "--- saved: $output (analyze with flamegraph.sh / report.sh)"
