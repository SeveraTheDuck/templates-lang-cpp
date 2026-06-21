# -- C++ git hooks (clang-tidy) ------------------------------------------------
# Adds a clang-tidy hook to base's pre-commit set (merges by name). The wrapper
# script lives in nix/cpp/clang-tidy.sh; the clang-tidy binary is passed as its
# first argument (absolute store path, so the hook does not depend on PATH).
# perSystem module.

{ pkgs, ... }:
{
  pre-commit.settings.hooks.clang-tidy = {
    enable = true;
    name = "clang-tidy";
    entry = "${pkgs.bash}/bin/bash nix/cpp/clang-tidy.sh ${pkgs.clang-tools}/bin/clang-tidy";
    files = "\\.(c|cc|cpp|h|hh|hpp)$";
    pass_filenames = true;
  };
}
