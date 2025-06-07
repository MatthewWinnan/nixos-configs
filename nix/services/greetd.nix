{
  pkgs,
  config,
  ...
}: let
  isHeadless = config.deviceSettings.headless;
in {
  services.greetd = {
    enable = true;
    settings.default_session.command =
      if isHeadless
      then ''
        ${pkgs.greetd.tuigreet}/bin/tuigreet \
          --time \
          --asterisks \
          --user-menu \
          --cmd ${pkgs.fish}/bin/fish
      ''
      else ''
        ${pkgs.greetd.tuigreet}/bin/tuigreet \
          --time \
          --asterisks \
          --user-menu \
          --cmd hyprland
      '';
  };

  environment.etc =
    if isHeadless
    then {}
    else {
      "greetd/environments".text = ''
        hyprland
      '';
    };
}
