#!/usr/bin/env bash
# Build and test every (suite x preset) from tests/pipelines/**/*.json on the
# compiler this job runs. Cells run sequentially and fail fast: the first failing
# cell aborts the job. Each suite runs only on its own presets (from the JSON),
# not the cartesian product of all presets. The compiler is the only parallel
# axis -- one job per compiler, set by the workflow matrix.
set -euo pipefail

# Flatten every pipeline file into "preset<TAB>label" lines: one per (suite, its
# preset). jq -s merges all files; [.[].suites[]] gathers suites across files.
cells=$(
  find tests/pipelines -type f -name '*.json' -print0 \
    | xargs -0 cat \
    | jq -s -r '[.[].suites[]] | .[] | .label as $l | .presets[] | "\(.)\t\($l)"'
)

while IFS=$'\t' read -r preset label; do
  [ -z "$preset" ] && continue
  echo "::group::${COMPILER} / ${preset} / ${label}"
  nix develop ".#${COMPILER}" -c bash -c "
    cmake --preset ${preset} &&
    cmake --build --preset ${preset} --target ${label} &&
    ctest --preset ${preset} -L ${label} --output-on-failure"
  echo "::endgroup::"
done <<<"$cells"
