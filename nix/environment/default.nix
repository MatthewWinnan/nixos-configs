{config, ...}: {
  environment.variables = {
    EDITOR = "nvim";
    BROWSER = "qutebrowser";
    TERMINAL = "kitty";
    QT_QPA_PLATFORMTHEME = "qt5ct";
    GSETTINGS_BACKEND = "keyfile";
    NH_FLAKE = "/home/${config.userSettings.username}/NIX_REPO";
  };
}
