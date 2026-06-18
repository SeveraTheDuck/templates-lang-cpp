{
  description = "templates-lang-cpp: Opinionated template for production-ready C++ pet-projects";

  inputs = {
    # --- templates-base inputs ------------------------------------------------
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";

    flake-parts = {
      url = "github:hercules-ci/flake-parts";
      inputs.nixpkgs-lib.follows = "nixpkgs";
    };

    treefmt-nix = {
      url = "github:numtide/treefmt-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    git-hooks = {
      url = "github:cachix/git-hooks.nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    # --------------------------------------------------------------------------
  };

  outputs =
    inputs@{ flake-parts, ... }:
    let
      lib = inputs.nixpkgs.lib;

      # Customisation point: every nix/<name>/ with a default.nix is imported as a
      # flake-parts module. To customise, add a directory.
      moduleDirs = lib.pipe (builtins.readDir ./nix) [
        (lib.filterAttrs (
          name: type: type == "directory" && builtins.pathExists (./nix + "/${name}/default.nix")
        ))
        (lib.mapAttrsToList (name: _: ./nix + "/${name}"))
      ];
    in
    flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [
        "x86_64-linux"
        "aarch64-linux"
        "x86_64-darwin"
        "aarch64-darwin"
      ];

      imports = moduleDirs;

      perSystem._module.args.projectRoot = inputs.self.outPath;
    };
}
