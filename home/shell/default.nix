{config, lib, ...}: {
  imports = [
    ./starship.nix
  ] ++ lib.optional (config.userSettings.shell == "fish") ./fish.nix
    ++ lib.optional (config.userSettings.shell == "zsh") ./zsh/default.nix
    ++ lib.optional (config.userSettings.shell == "bash") ./bash.nix
    ++ lib.optional (config.userSettings.shell == "nushell") ./nushell.nix;
}
