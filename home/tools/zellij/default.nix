#
# Zellij - Terminal multiplexer with batteries included
#
{config, ...}: {
  programs.zellij = {
    enable = true;
    enableFishIntegration = false;
  };

  xdg.configFile."zellij/config.kdl".source = import ./config.nix {inherit config;};
}
