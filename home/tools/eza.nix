# DOCS -> https://github.com/eza-community/eza
# NixOptions DOCS -> https://mynixos.com/home-manager/options/programs.eza

{config, ...}:
{
  programs.eza = {
    enable = true;
    icons = "auto";
    git = true;

    # We define our integrations based on the avilability of shells
    enableZshIntegration = config.programs.zsh.enable;
    enableBashIntegration = config.programs.bash.enable;
    enableNushellIntegration = config.programs.nushell.enable;
    enableFishIntegration = config.programs.fish.enable;

    extraOptions = [
      "--group-directories-first"
      "--header"
    ];
  };
}
