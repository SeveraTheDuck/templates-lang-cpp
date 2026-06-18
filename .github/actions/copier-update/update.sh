#!/usr/bin/env bash

# Run copier update per layer in the order declared in .copier/update-order.
# Blank and comment lines are ignored.
# --trust is required: base declares _migrations

set -euo pipefail

order_file=".copier/update-order"

if [ ! -f "$order_file" ]; then
  echo "::error::$order_file not found"
  exit 1
fi

while IFS= read -r line; do
  case "$line" in
    '' | '#'*) continue ;;
  esac
  echo "::group::copier update $line"
  nix run nixpkgs#copier -- update --trust --skip-answered --defaults -a "$line"
  echo "::endgroup::"
done <"$order_file"
