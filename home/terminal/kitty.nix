{lib, ...}:{
  programs.kitty = lib.mkForce {
    enable = true;

    shellIntegration = {
     enableFishIntegration = true;
    };

    settings = {
     hide_window_decorations = "yes";
     background_opacity = "0.80";
      background_blur = 10;
      #tab_bar_margin_width = 0;
    };
  };
}
