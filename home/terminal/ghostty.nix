{lib, ...}: {
  programs.ghostty = lib.mkForce {
    enable = true;
    enableFishIntegration = true;
    # settings = {
    #   hide_window_decorations = "yes";
    #   background_opacity = "0.80";
    #   background_blur = 10;
    #   #tab_bar_margin_width = 0;
    # };
  };
}
