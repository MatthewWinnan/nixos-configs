# Direnv DOCS -> https://direnv.net/
# Nix-Direnv DOCS -> https://github.com/nix-community/nix-direnv

{pkgs, config, ...}: {
  # Set the log format to an empty string to avoid direnv from polluting the
  # shell output with log messages.
  home.sessionVariables = {
    DIRENV_LOG_FORMAT = "";
  };

  programs.direnv = {
    enable = true;
    # nix-direnv enables the use of use_nix and use_flake in .envrc files.
    nix-direnv.enable = true;

    # Enable zsh integration for direnv.
    enableZshIntegration = config.programs.zsh.enable;

    # Enable fish if activated, seems that home fish does this for me?
    /* enableFishIntegration = config.programs.fish.enable; */
  };
}
