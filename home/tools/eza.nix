# https://github.com/eza-community/eza
{
  programs.eza = {
    enable = true;
    icons = true;
    git = true;
    enableZshIntegration = false;
    extraOptions = [
      "--group-directories-first"
      "--header"
    ];
  };
}
