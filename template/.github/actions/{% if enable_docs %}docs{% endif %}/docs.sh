#!/usr/bin/env bash
# Generate Doxygen HTML into build/docs/html with the doxygen-awesome theme.
set -euo pipefail

THEME=$(nix eval --raw nixpkgs#doxygen-awesome-css)
VERSION=$(cat version.txt)

mkdir -p build/docs

{
  cat docs/Doxyfile
  echo "PROJECT_NUMBER = $VERSION"
  echo "HTML_EXTRA_STYLESHEET = $THEME/doxygen-awesome.css $THEME/doxygen-awesome-sidebar-only.css"
} | nix shell nixpkgs#doxygen nixpkgs#graphviz -c doxygen -
