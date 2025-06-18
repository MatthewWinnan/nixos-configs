# NixOptions -> https://mynixos.com/home-manager/options/programs.anyrun
{pkgs, ...}: {
  config.programs.anyrun = {
    enable = true;
  };
}
