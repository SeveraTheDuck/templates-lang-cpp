# -- mkCppShell ----------------------------------------------------------------
# Builds a per-compiler dev shell: reuses the merged devShellPackages, the
# treefmt wrapper and the pre-commit install hook, with Nix hardening disabled
# so sanitizers work. Imported by shells.nix (a helper, not a flake module).

{ pkgs, config }:
{
  stdenv,
  cc,
  cxx,
}:
(pkgs.mkShell.override { inherit stdenv; }) {
  packages = config.devShellPackages ++ [ config.treefmt.build.wrapper ];
  hardeningDisable = [ "all" ];
  CC = cc;
  CXX = cxx;
  shellHook = config.pre-commit.installationScript;
}
