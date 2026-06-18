# -- Formatting (treefmt) -----------------------------------------------------
# perSystem module (imported via perSystem.imports in default.nix).

{ pkgs, ... }:
{
  treefmt = {
    projectRootFile = "flake.nix";
    settings.global.fail-on-change = true;

    programs = {
      taplo.enable = true;
      nixfmt.enable = true;
      yamlfmt.enable = true;
      shfmt.enable = true;
    };

    settings.formatter.shfmt = {
      options = [
        "-i"
        "2"
        "-ci"
        "-bn"
        "-w"
      ];
      includes = [
        "*.sh"
        "*.bash"
      ];
    };

    settings.formatter.jq = {
      command = "${pkgs.jq}/bin/jq";
      options = [
        "--indent"
        "2"
        "-S"
        "."
      ];
      includes = [ "*.json" ];
    };
  };
}
