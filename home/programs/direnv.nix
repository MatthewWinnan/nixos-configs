# Direnv DOCS -> https://direnv.net/
# Nix-Direnv DOCS -> https://github.com/nix-community/nix-direnv
{
  pkgs,
  config,
  ...
}:
{
  programs.direnv = {
    enable = true;
    # nix-direnv enables the use of use_nix and use_flake in .envrc files.
    nix-direnv.enable = true;

    # Silence all direnv logging
    config.global.hide_env_diff = true;
    config.global.log_format = "";

    # Enable zsh integration for direnv.
    enableZshIntegration = config.programs.zsh.enable;

    # Enable fish if activated, seems that home fish does this for me?
    # enableFishIntegration = config.programs.fish.enable;
  };
}
