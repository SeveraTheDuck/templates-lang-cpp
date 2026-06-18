# -- C++ formatting (treefmt) --------------------------------------------------
# clang-format and cmake-format are native treefmt-nix programs; they merge with
# base's formatters by name. clang-tidy is NOT here -- it is static analysis,
# not formatting (see hooks.nix and the CMake CXX_CLANG_TIDY wiring).
# perSystem module.

{ ... }:
{
  treefmt.programs = {
    clang-format.enable = true;
    cmake-format.enable = true;
  };
}
