#
# gh - GitHub CLI
# Got this from https://github.com/sukhmancs/nixos-configs/blob/94b744f0f81d4a610fccdab94e5b25a2138d4c92/homes/shared/programs/git/gh.nix
#
{pkgs, ...}: {
  programs.gh = {
    enable = true;
    gitCredentialHelper.enable = false;
    extensions = with pkgs; [
      gh-poi
      gh-cal
      gh-eco
      gh-dash
    ];
    settings = {
      git_protocol = "ssh";
      prompt = "enabled";
      editor = "nvim";
      pager = "delta -s";
      aliases = {
        co = "pr checkout";
        al = "alias list";
        il = "issue list";
        iv = "issue view --comments";
        rl = "repo list";
        rv = "repo view";
        gv = "gist view";
        st = "status";
      };
      browser = "$BROWSER";
    };
  };
}
