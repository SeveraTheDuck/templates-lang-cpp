#!/usr/bin/env bash

# Record a profile and render a flamegraph in one step.
# Usage: run.sh <binary> [args...]

set -euo pipefail
# shellcheck shell=bash

script_dir="$(cd "$(dirname "$0")" && pwd)"
"$script_dir/record.sh" "$@"
"$script_dir/flamegraph.sh"
