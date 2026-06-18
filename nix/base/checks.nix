# -- Checks -------------------------------------------------------------------
# treefmt registers its own `checks.treefmt`. Add spelling and licensing.
# perSystem module.

{ projectRoot, pkgs, ... }:
{
  checks = {
    spelling = pkgs.runCommand "typos" { } ''
      ${pkgs.typos}/bin/typos ${projectRoot}
      touch $out
    '';

    reuse = pkgs.runCommand "reuse" { } ''
      ${pkgs.reuse}/bin/reuse --root ${projectRoot} lint
      touch $out
    '';
  };
}
