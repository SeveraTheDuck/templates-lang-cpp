# -- Git hooks (pre-commit) ---------------------------------------------------
# Hooks run at commit time. The flakeModule's own flake check is disabled in
# favour of the granular checks in checks.nix.
# perSystem module.

{ pkgs, ... }:
{
  pre-commit = {
    check.enable = false;

    settings.hooks = {
      treefmt.enable = true;
      typos.enable = true;

      reuse = {
        enable = true;
        name = "reuse";
        entry = "${pkgs.reuse}/bin/reuse lint";
        pass_filenames = false;
      };

      commitlint = {
        enable = true;
        name = "commitlint";
        entry = "${pkgs.commitlint-rs}/bin/commitlint --edit";
        stages = [ "commit-msg" ];
      };
    };
  };
}
