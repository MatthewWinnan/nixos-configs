{ config, ... }: {
  programs.fish = {
    enable = true;
    shellInit = "clear;sleep 0.1;fastfetch";
  };
}
