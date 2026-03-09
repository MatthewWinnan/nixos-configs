{lib, ...}: {
  programs.wezterm = lib.mkForce {
    enable = true;
    enableZshIntegration = true;
    extraConfig =  ''
    return {
      font = wezterm.font("JetBrains Mono"),
      hide_tab_bar_if_only_one_tab = true,
    }
    '';
  };
}
