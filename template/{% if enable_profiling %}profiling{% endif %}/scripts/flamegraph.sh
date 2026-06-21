#!/usr/bin/env bash

# Render a flamegraph SVG from a perf recording.
# Usage: flamegraph.sh [perf.data]   (default: profiling/results/perf.data)
# flamegraph.pl / stackcollapse-perf.pl come from the Nix dev shell.

set -euo pipefail
# shellcheck shell=bash

if [ "$(uname)" != "Linux" ]; then
  echo "error: profiling is only supported on Linux" >&2
  exit 1
fi

script_dir="$(cd "$(dirname "$0")" && pwd)"
results_dir="$script_dir/../results"
input="${1:-$results_dir/perf.data}"

if [ ! -f "$input" ]; then
  echo "error: '$input' not found -- run record.sh first" >&2
  exit 1
fi

output="$results_dir/$(basename "$input" .data).svg"

echo "--- generating flamegraph from: $input"
perf script -i "$input" | stackcollapse-perf.pl | flamegraph.pl >"$output"
echo "--- saved: $output"
