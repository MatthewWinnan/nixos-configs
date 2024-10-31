#
# Zellij - Terminal multiplexer with batteries included
# DOCS -> https://zellij.dev
#
{config, ...}: {
  programs.zellij = {
    enable = true;
    enableFishIntegration = false;
  };

  xdg.configFile."zellij/config.kdl".source = import ./config.nix {inherit config;};
}
