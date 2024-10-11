# NixOptions https://mynixos.com/home-manager/options/programs.bat
# https://github.com/sharkdp/bat
{
  pkgs,
  config,
  lib,
  ...
}: {
  programs.bat = {
    enable = true;
    # With batgrep, bat can be used as the printer for ripgrep search results.
    # batgrep needle src/
    extraPackages = with pkgs.bat-extras; [batgrep batman];

    # For some reason this causes custom.tmTheme to point to an empty file, bat can not load any custom themes
    # thus stylix default theme fails, check why???
    # themes = {
    #   custom = {
    #     src = import ./theme.nix {inherit config;};
    #     file = "custom.tmTheme";
    #   };
    # };

    config = {
      pager = "less -FR"; # frfr
    };
  };
}
