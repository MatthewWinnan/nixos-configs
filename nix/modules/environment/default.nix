{config, ...}: {

environment.variables = {
    EDITOR = "nvim";
    QT_QPA_PLATFORMTHEME = "qt5ct";
    GSETTINGS_BACKEND = "keyfile";
    FLAKE = "/home/${config.userSettings.username}/NIX_REPO";
  };
}
