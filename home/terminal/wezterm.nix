{lib, ...}: {
  programs.wezterm = lib.mkForce {
    enable = true;
    enableZshIntegration = true;
  };
}
