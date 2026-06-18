# -- Base layer: aggregator ---------------------------------------------------
# Discovered by flake.nix like any other nix/<name>/ module. Imports the upstream
# flakeModules base relies on (flake-level), and base's own perSystem fragments
# (per-system level).

{ inputs, ... }:
{
  imports = [
    inputs.treefmt-nix.flakeModule
    inputs.git-hooks.flakeModule
  ];

  perSystem.imports = [
    ./treefmt.nix
    ./hooks.nix
    ./shell.nix
    ./checks.nix
  ];
}
