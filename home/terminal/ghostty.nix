{lib, config, ...}: let
  inherit (config.userSettings) shell;
in {
  programs.ghostty = lib.mkForce {
    enable = true;
    enableFishIntegration = shell == "fish";
    enableBashIntegration = shell == "bash";
    enableZshIntegration = shell == "zsh";

    settings = {
      # Match kitty opacity
      background-opacity = 0.8;

      # Hide window decorations (like kitty's hide_window_decorations)
      window-decoration = false;

      # Font settings (adjust to your preference)
      font-size = 12;

      # Cursor settings
      cursor-style = "block";
      cursor-style-blink = false;

      # Window padding
      window-padding-x = 4;
      window-padding-y = 4;

      # Scrollback
      scrollback-limit = 10000;

      # Mouse
      mouse-hide-while-typing = true;
    };
  };
}
