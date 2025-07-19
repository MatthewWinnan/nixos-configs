# DOCS -> https://github.com/OXY2DEV/markview.nvim
# Has been migrated to nixvim, using that now instead
# https://nix-community.github.io/nixvim/plugins/markview/index.html
{pkgs, ...}: {
  programs.nixvim.plugins.markview = {
    enable = false;
  };

  # Original method how I packaged it
  # programs.nixvim.extraPlugins = with pkgs.vimUtils; [
  #   (buildVimPlugin rec {
  #     pname = "markview.nvim";
  #     version = "25.2.0";
  #     src = pkgs.fetchFromGitHub {
  #       owner = "OXY2DEV";
  #       repo = "markview.nvim";
  #       rev = "refs/tags/v${version}";
  #       hash = "sha256-uOYX7W92SOgT7QdrorQC+cJ7rKWAXw/MQ7nCdAtILR0=";
  #     };
  #   })
  # ];
  #
  # programs.nixvim.extraConfigLua = ''
  #   require("markview").setup();
  # '';
}
