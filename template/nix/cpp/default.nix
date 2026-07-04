# -- C++ layer: aggregator -----------------------------------------------------
# Discovered by flake.nix like any nix/<name>/ module. Reuses base's treefmt /
# git-hooks flakeModules (no flake-level imports of its own)

{ ... }:
{
  perSystem.imports = [
    ./toolchain.nix
    ./shells.nix
    ./treefmt.nix
    ./package.nix
  ];
}
