{config, ...}: {
  environment.variables = {
    EDITOR = "nvim";
    BROWSER = "qutebrowser";
    TERMINAL = "kitty";
    QT_QPA_PLATFORMTHEME = "qt5ct";
    GSETTINGS_BACKEND = "keyfile";
  };
}
