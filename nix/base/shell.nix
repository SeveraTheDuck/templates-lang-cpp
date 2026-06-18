# -- Dev shell ----------------------------------------------------------------
# Owns the append-only `devShellPackages` option (the extensible surface, since
# devShells.default is a package and cannot be merged) and builds the shell.
# perSystem module: options/config declared directly in the per-system scope.

{
  config,
  pkgs,
  lib,
  ...
}:
{
  options.devShellPackages = lib.mkOption {
    type = lib.types.listOf lib.types.package;
    default = [ ];
    description = "Packages added to the development shell (append-only).";
  };

  config.devShellPackages = with pkgs; [
    just
    typos
    reuse
    commitlint-rs
    jq
  ];

  config.devShells.default = pkgs.mkShell {
    packages = config.devShellPackages ++ [ config.treefmt.build.wrapper ];
    shellHook = ''
      ${config.pre-commit.installationScript}
      echo "dev shell ready — run 'just' to see available recipes"
    '';
  };
}
