#!/usr/bin/env bash
# Configure, build and test a single matrix cell inside the pinned compiler
# shell. Builds only the suite's target (+ its deps), then runs exactly that
# suite via the CTest label (LABEL == target name).
set -euo pipefail

nix develop ".#${COMPILER}" -c bash -c "
  cmake --preset ${PRESET} &&
  cmake --build --preset ${PRESET} --target ${LABEL} &&
  ctest --preset ${PRESET} -L ${LABEL} --output-on-failure
"
